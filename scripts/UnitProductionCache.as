namespace UnitProductionCache
{

	class IBase
	{
		UnitProducer@ __prod;
	}

	array<IBase@> g_unitProdCache;

	bool GetCached(UnitPtr unit, IBase@ cached)
	{
		auto prod = unit.GetUnitProducer();
		uint num = g_unitProdCache.length();
		for (uint i = 0; i < num; i++)
		{
			if (g_unitProdCache[i].__prod is prod)
			{
				@cached = g_unitProdCache[i];
				return true;
			}
		}

		return false;
	}

	IBase@ GetCached(UnitPtr unit)
	{
//%PROFILE_START GetCached
		auto prod = unit.GetUnitProducer();
		uint num = g_unitProdCache.length();
		for (uint i = 0; i < num; i++)
		{
			if (g_unitProdCache[i].__prod is prod)
			{
//				%PROFILE_STOP
				return g_unitProdCache[i];
			}
		}

//		%PROFILE_STOP
		return null;
	}
	
	IBase@ AddCached(UnitPtr unit, IBase@ cached)
	{
		@cached.__prod = unit.GetUnitProducer();
		g_unitProdCache.insertLast(cached);
		return cached;
	}
/*
	class IBase
	{
	}
	
	dictionary g_unitProdCache;

	bool GetCached(UnitPtr unit, IBase@ cached)
	{
		if (g_unitProdCache.get("" + unit.GetUnitProducer().GetResourceHash(), @cached))
			return true;
		
		return false;
	}

	IBase@ GetCached(UnitPtr unit)
	{
		IBase@ cached = null;
		
%PROFILE_START GetCached
		if (g_unitProdCache.get("" + unit.GetUnitProducer().GetResourceHash(), @cached))
		{
			%PROFILE_STOP
			return cached;
		}

		%PROFILE_STOP
		return null;
	}
	
	IBase@ AddCached(UnitPtr unit, IBase@ cached)
	{
		g_unitProdCache.set("" + unit.GetUnitProducer().GetResourceHash(), @cached);
		return cached;
	}
*/
}