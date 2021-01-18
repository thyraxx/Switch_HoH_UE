namespace WorldScript
{
	class DelayedSurvivalSpawn : QueuedTasks::QueuedTask
	{
		SurvivalEnemySpawn@ m_spawn;
		SurvivalEnemySpawnPoint@ m_spawnPoint;
		bool m_ignoreIntro;

		DelayedSurvivalSpawn(SurvivalEnemySpawn@ spawn, SurvivalEnemySpawnPoint@ point, bool ignoreIntro)
		{
			@m_spawn = spawn;
			@m_spawnPoint = point;
			m_ignoreIntro = ignoreIntro;
		}

		void Execute() override
		{
			if (m_spawnPoint.IntroEffect !is null && !m_ignoreIntro)
			{
				auto spawnPointScript = WorldScript::GetWorldScript(g_scene, m_spawnPoint);
				(Network::Message("PlaySurvivalIntroEffect") << spawnPointScript.GetUnit()).SendToAll();

				auto fxUnit = PlayEffect(m_spawnPoint.IntroEffect, xy(m_spawnPoint.Position));
				auto b = cast<EffectBehavior>(fxUnit.GetScriptBehavior());
				QueuedTasks::Queue(b.m_ttl, DelayedSurvivalSpawn(m_spawn, m_spawnPoint, true));
				return;
			}

			DoExec();
		}

		void DoExec()
		{
			auto enemyCfg = SpawnUnitBaseHandler::PackEnemyCfg(m_spawnPoint.AggroEnemy, m_spawnPoint.NoLootEnemy, m_spawnPoint.NoExperienceEnemy);
			UnitPtr u = m_spawn.ProduceUnit(m_spawnPoint.Position, 0);

			auto enemy = cast<CompositeActorBehavior>(u.GetScriptBehavior());
			if (enemy !is null)
				SpawnUnitBaseHandler::ConfigureEnemy(enemy, enemyCfg);

			m_spawnPoint.SpawnEffects();

			if (!u.IsValid())
				return;

			m_spawn.AllSpawned.Add(u);

			if (m_spawn.m_needNetSync)
			{
				auto spawnScript = WorldScript::GetWorldScript(g_scene, m_spawn);
				auto spawnPointScript = WorldScript::GetWorldScript(g_scene, m_spawnPoint);

				(Network::Message("SurvivalEnemySpawn") << u.GetId() << spawnScript.GetUnit() << spawnPointScript.GetUnit() << enemyCfg);
			}
		}
	}

	[WorldScript color="0 196 150" icon="system/icons.png;256;0;32;32"]
	class SurvivalEnemySpawn
	{
		[Editable]
		UnitProducer@ UnitType;

		[Editable default=1]
		uint NumberToSpawnMin;

		[Editable default=1]
		uint NumberToSpawnMax;

		[Editable default=0]
		uint NumberPerPlayer;

		[Editable default=0]
		uint NumberPerPlayerMax;

		[Editable default=100000]
		uint MaxToSpawn;

		[Editable]
		string SpawnPointFilter;

		UnitSource AllSpawned;

		bool m_needNetSync;


		void Initialize()
		{
			m_needNetSync = UnitType !is null && !IsNetsyncedExistance(UnitType.GetNetSyncMode());
		}

		UnitPtr ProduceUnit(vec3 pos, int id)
		{
			auto prod = UnitMap::Replace(UnitType);

			if (prod is null)
			{
				auto script = WorldScript::GetWorldScript(g_scene, this);
				PrintError("Undefined producer in unit ID " + script.GetUnit().GetId());
				return UnitPtr();
			}

			pos.x += randf() / 100.0;
			pos.y += randf() / 100.0;

			UnitPtr ret = prod.Produce(g_scene, pos, id);

			auto actor = cast<CompositeActorBehavior>(ret.GetScriptBehavior());
			if (actor !is null)
				actor.Configure(true, false, false);

			return ret;
		}

		SValue@ ServerExecute()
		{
			auto survivalMode = cast<Survival>(g_gameMode);
			if (survivalMode is null)
				return null;

			SValueBuilder sval;
			if (m_needNetSync)
				sval.PushArray();

			uint num = NumberToSpawnMin + randi(NumberToSpawnMax - NumberToSpawnMin + 1);
			for (uint i = 0; i < g_players.length(); i++)
			{
				if (g_players[i].peer == 255)
					continue;

				int perPlayer = NumberPerPlayer;
				if (NumberPerPlayerMax > NumberPerPlayer)
					perPlayer += randi(NumberPerPlayerMax - NumberPerPlayer + 1);

				num += perPlayer;
			}

			num = min(num, MaxToSpawn);

			array<WorldScript::SurvivalEnemySpawnPoint@> spawns;
			for (uint i = 0; i < survivalMode.m_enemySpawns.length(); i++)
			{
				auto spawn = survivalMode.m_enemySpawns[i];
				if (spawn.Filter == SpawnPointFilter && spawn.Enabled)
					spawns.insertLast(spawn);
			}

			for (uint i = 0; i < num; i++)
			{
				auto spawn = spawns[randi(spawns.length())];

				int delay = randi(spawn.Delay);
				if (delay > 0 || spawn.IntroEffect !is null)
				{
					QueuedTasks::Queue(delay, DelayedSurvivalSpawn(this, spawn, false));
					continue;
				}

				auto spawnScript = WorldScript::GetWorldScript(g_scene, spawn);
				vec3 pos = spawn.Position;

				auto enemyCfg = SpawnUnitBaseHandler::PackEnemyCfg(spawn.AggroEnemy, spawn.NoLootEnemy, spawn.NoExperienceEnemy);

				UnitPtr u = ProduceUnit(pos, 0);

				auto enemy = cast<CompositeActorBehavior>(u.GetScriptBehavior());
				if (enemy !is null)
					SpawnUnitBaseHandler::ConfigureEnemy(enemy, enemyCfg);

				spawn.SpawnEffects();

				if (!u.IsValid())
					continue;

				AllSpawned.Add(u);
				if (m_needNetSync)
				{
					sval.PushInteger(u.GetId());
					sval.PushInteger(spawnScript.GetUnit().GetId());
					sval.PushInteger(enemyCfg);
				}
			}

			if (m_needNetSync)
				return sval.Build();

			return null;
		}

		void ClientExecute(SValue@ val)
		{
			if (val is null)
				return;

			array<SValue@>@ arr = val.GetArray();
			for (uint i = 0; i < arr.length(); i += 3)
			{
				int id = arr[i].GetInteger();
				auto spawn = cast<SurvivalEnemySpawnPoint>(g_scene.GetUnit(arr[i + 1].GetInteger()).GetScriptBehavior());
				int enemyCfg = arr[i + 2].GetInteger();

				UnitPtr u = ProduceUnit(spawn.Position, id);

				auto enemy = cast<CompositeActorBehavior>(u.GetScriptBehavior());
				if (enemy !is null)
					SpawnUnitBaseHandler::ConfigureEnemy(enemy, enemyCfg);

				spawn.SpawnEffects();
			}
		}
	}
}
