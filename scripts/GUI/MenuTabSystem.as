class MenuTabSystem
{
	IWidgetHoster@ m_host;

	array<MenuTab@> m_tabs;
	MenuTab@ m_currentTab;

	CheckBoxGroupWidget@ m_wTabsContainer;
	ClipWidget@ m_wTabsClip;
	int m_lastTabRight;
	float m_clipX;
	float m_clipXPrev;

	MenuTabSystem(IWidgetHoster@ host)
	{
		@m_host = host;

		@m_wTabsContainer = cast<CheckBoxGroupWidget>(host.m_widget.GetWidgetById("tabs-container"));
		@m_wTabsClip = cast<ClipWidget>(host.m_widget.GetWidgetById("tabs-clip"));

		for(uint i = 0; i < m_wTabsClip.m_children.length(); i++)
		{
			m_wTabsClip.m_children[i].m_canFocus = false;
		}
	}

	void UpdateVisibility()
	{
		for (uint i = 0; i < m_wTabsClip.m_children.length(); i++)
		{
			auto wButton = cast<ScalableSpriteButtonWidget>(m_wTabsClip.m_children[i]);
			if (wButton is null)
				continue;

			auto tab = GetTab(wButton.m_value);
			if (tab is null)
				continue;

			wButton.m_visible = tab.ShouldShowButton();
		}
	}

	ScalableSpriteButtonWidget@ GetTabButton(const string &in id)
	{
		for (uint i = 0; i < m_wTabsClip.m_children.length(); i++)
		{
			auto wButton = cast<ScalableSpriteButtonWidget>(m_wTabsClip.m_children[i]);
			if (wButton !is null && wButton.m_value == id)
				return wButton;
		}
		return null;
	}

	Widget@ GetTabWidget(const string &in id)
	{
		auto wTab = m_host.m_widget.GetWidgetById("tab-" + id);
		if (wTab is null)
		{
			PrintError("Tab widget not found: \"tab-" + id + "\"");
			return null;
		}
		return wTab;
	}

	void AddTab(MenuTab@ tab, GUIBuilder@ b = null)
	{
		if (b is null)
			@b = g_gameMode.m_guiBuilder;

		auto wTab = GetTabWidget(tab.m_id);
		if (wTab !is null)
		{
			@tab.m_def = wTab.AddResource(b, tab.GetGuiFilename());
			@tab.m_widget = wTab;
			wTab.m_visible = false;
			m_tabs.insertLast(tab);
			tab.OnCreated();
		}

		auto wTabButton = GetTabButton(tab.m_id);
		if (wTabButton !is null)
			wTabButton.m_visible = tab.ShouldShowButton();
	}

	MenuTab@ GetTab(const string &in id)
	{
		for (uint i = 0; i < m_tabs.length(); i++)
		{
			auto tab = m_tabs[i];
			if (tab.m_id == id)
				return tab;
		}
		return null;
	}

	void SetTab(const string &in id)
	{
		for (uint i = 0; i < m_tabs.length(); i++)
		{
			auto tab = m_tabs[i];
			bool isTab = (tab.m_id == id);

			if (tab.IsVisible() != isTab)
				tab.SetVisible(isTab);

			if (isTab)
				@m_currentTab = tab;
		}

		m_wTabsContainer.SetChecked(id);

		m_host.Invalidate();
		m_host.DoLayout();
	}

	void Close()
	{
		SetTab("");
		for(uint i = 0; i <m_wTabsClip.m_children.length();i++ )
							m_wTabsClip.m_children[i].SetHovering(false, m_wTabsClip.m_children[i].m_origin);
	}

	void Update(int dt)
	{
		if (m_currentTab !is null)
			m_currentTab.Update(dt);

		if (m_wTabsClip !is null)
		{

			auto gi = GetInput();

			if(gi.Attack3.Pressed)
			{
				ScalableSpriteButtonWidget@ wfa = null;
				int index = -1;
				for(uint i = 0; i < m_wTabsClip.m_children.length(); i++)
				{
					@wfa = cast<ScalableSpriteButtonWidget>(m_wTabsClip.m_children[i]);
					if(wfa !is null)
					{
						auto parse = wfa.m_func.split(" ");
						if(m_currentTab.m_id == (parse[1]))
						{
							index = i;
							break;
						}
					}

				}
				if(index != -1 && index < m_wTabsClip.m_children.length() - 1)
				{
					
					for(uint j = (index + 1); j < m_wTabsClip.m_children.length(); j++)
					{
						auto wf = cast<ScalableSpriteButtonWidget>(m_wTabsClip.m_children[j]);
						
						if(wf !is null && wf.m_visible)
						{
							//for(uint i = 0; i <m_wTabsClip.m_children.length();i++ )
							//	m_wTabsClip.m_children[i].SetHovering(false, m_wTabsClip.m_children[i].m_origin);
							//wf.SetHovering(true, wf.m_origin);
							auto parse = wf.m_func.split(" ");
							if(g_gameMode.m_widgetUnderCursor !is null)
							{
								g_gameMode.m_widgetUnderCursor.SetHovering(false, g_gameMode.m_widgetUnderCursor.m_origin);
								@g_gameMode.m_widgetUnderCursor = null;
							}
							SetTab(parse[1]);
							break;
						}
					}
				}
			}
			if(gi.Attack4.Pressed)
			{
				int index = -1;
				ScalableSpriteButtonWidget@ wfa = null;
				for(uint i = 0; i < m_wTabsClip.m_children.length(); i++)
				{
					@wfa = cast<ScalableSpriteButtonWidget>(m_wTabsClip.m_children[i]);
					if(wfa !is null)
					{
						auto parse = wfa.m_func.split(" ");
						if(m_currentTab.m_id == (parse[1]))
						{
							index = i;
							break;
						}
					}
				}
				if(index > 0)
				{
					for(uint j = index - 1; j >= 0; j--)
					{
						auto wf = cast<ScalableSpriteButtonWidget>(m_wTabsClip.m_children[j]);
						if(wf !is null && wf.m_visible)
						{
							//for(uint i = 0; i <m_wTabsClip.m_children.length();i++ )
							//	m_wTabsClip.m_children[i].SetHovering(false, m_wTabsClip.m_children[i].m_origin);
							//wf.SetHovering(true, wf.m_origin);
							auto parse = wf.m_func.split(" ");
							if(g_gameMode.m_widgetUnderCursor !is null)
							{
								g_gameMode.m_widgetUnderCursor.SetHovering(false, g_gameMode.m_widgetUnderCursor.m_origin);
								@g_gameMode.m_widgetUnderCursor = null;
							}
							SetTab(parse[1]);
							break;
						}
					}
				}
			}

			if (m_lastTabRight == 0)
			{
				for (uint i = 0; i < m_wTabsClip.m_children.length(); i++)
				{
					auto child = m_wTabsClip.m_children[i];
					if (child.m_visible)
						m_lastTabRight += child.m_width;
				}
			}
			float factor = 0;
			int extraRight = m_lastTabRight - m_wTabsClip.m_width;

			//Agregado 14/01/2019 ///////////////////////////////////////////////////////////////////////////////////////
			for (uint i = 0; i < m_wTabsClip.m_children.length(); i++)
			{
				if( m_wTabsClip.m_children[i] is cast<Widget>(m_wTabsContainer.GetChecked()) && m_wTabsClip.m_children.length() > 1)
				{
				factor = float(i) / float(m_wTabsClip.m_children.length() - 1);
				break;
				}
			}
			///////////////////////////////////////////////////////////////////////////////////////////////////////////
			if (extraRight > 0)
			{
				m_clipXPrev = m_clipX;
				m_clipX = lerp(0.0f, float(-extraRight), factor);
			}
		}
	}

	void AfterUpdate()
	{
		if (m_currentTab !is null)
			m_currentTab.AfterUpdate();
	}

	void DoLayout()
	{
		for (uint i = 0; i < m_wTabsClip.m_children.length(); i++)
		{
			auto child = m_wTabsClip.m_children[i];
			child.m_origin.x = child.m_originOriginal.x + m_clipX;
		}
	}

	void Draw(SpriteBatch& sb, int idt)
	{
		for (uint i = 0; i < m_wTabsClip.m_children.length(); i++)
		{
			auto child = m_wTabsClip.m_children[i];
			child.m_origin.x = child.m_originOriginal.x + lerp(m_clipXPrev, m_clipX, idt / 33.0f);
		}

		if (m_currentTab !is null)
			m_currentTab.Draw(sb, idt);
	}

	bool OnFunc(Widget@ sender, string name)
	{
		if (m_currentTab !is null && m_currentTab.OnFunc(sender, name))
			return true;

		auto parse = name.split(" ");

		if (parse[0] == "set-tab")
		{
			SetTab(parse[1]);
			return true;
		}

		return false;
	}
}
