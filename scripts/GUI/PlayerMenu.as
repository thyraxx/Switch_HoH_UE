class PlayerMenu : UserWindow
{
	MenuTabSystem@ m_tabSystem;

	PlayerMenuMapTab@ m_tabMap;

	Menu::Backdrop@ m_backdrop;

	bool m_pause = false;

	PlayerMenu(GUIBuilder@ b)
	{
		super(b, "gui/playermenu.gui");

		@m_tabSystem = MenuTabSystem(this);

		m_tabSystem.AddTab(@m_tabMap = PlayerMenuMapTab(), b);
		m_tabSystem.AddTab(PlayerMenuCharacterTab(), b);
		m_tabSystem.AddTab(PlayerMenuEffectsTab(), b);
		m_tabSystem.AddTab(PlayerMenuStatsTab(), b);

		@m_backdrop = Menu::Backdrop(b, "gui/playermenu/backdrop.gui");
	}

	bool BlocksLower() override
	{
		return true;
	}

	void SetTab(string id)
	{
		GlobalCache::Set("playermenu-tab", id);

		m_tabSystem.SetTab(id);
	}

	void Show() override
	{
		if (m_visible)
			return;

		UserWindow::Show();

		PauseGame(true, true);

		string startTab = GlobalCache::Get("playermenu-tab");
		if (startTab == "")
			startTab = "character";

		SetTab(startTab);
	}

	void Close() override
	{
		if (!m_visible)
			return;

		m_tabSystem.Close();

		UserWindow::Close();

		PauseGame(false, true);
		if(m_pause)
		{
			m_pause = false;
			Blit::TogglePlayerMenu(true);
		}
	}

	void DoLayout() override
	{
		bool invalidated = m_invalidated;

		UserWindow::DoLayout();

		if (invalidated)
			m_tabSystem.DoLayout();
	}

	void Update(int dt) override
	{
		if (m_backdrop !is null)
			m_backdrop.Update(dt);

		if (m_visible)
			m_tabSystem.Update(dt);

		UserWindow::Update(dt);
	}

	void AfterUpdate()
	{
		if (m_visible)
			m_tabSystem.AfterUpdate();
	}

	void Draw(SpriteBatch& sb, int idt) override
	{
		if (!m_visible)
			return;

		if (m_backdrop !is null)
			m_backdrop.Draw(sb, idt);

		UserWindow::Draw(sb, idt);

		m_tabSystem.Draw(sb, idt);
	}

	void OnFunc(Widget@ sender, string name) override
	{
		auto parse = name.split(" ");
		if (parse[0] == "close")
			Close();
		else if (parse[0] == "set-tab")
			SetTab(parse[1]);
		else
			m_tabSystem.OnFunc(sender, name);
	}
}
