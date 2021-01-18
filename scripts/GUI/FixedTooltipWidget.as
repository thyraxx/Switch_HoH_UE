class FixedTooltipWidget : Widget
{
	ScriptSprite@ m_spriteTopLeft;
	ScriptSprite@ m_spriteTop;
	ScriptSprite@ m_spriteTopRight;

	ScriptSprite@ m_spriteLeft;
	ScriptSprite@ m_spriteMiddle;
	ScriptSprite@ m_spriteRight;

	ScriptSprite@ m_spriteBottomLeft;
	ScriptSprite@ m_spriteBottom;
	ScriptSprite@ m_spriteBottomRight;

	BitmapFont@ m_fontTitle;
	BitmapString@ m_textTitle;
	int m_titleSpacing;

	BitmapFont@ m_fontSub;
	vec2 m_subSpacing;

	array<TooltipSubText@> m_subTexts;

	BitmapFont@ m_font;
	BitmapString@ m_text;

	//bool m_enabled;
	//int m_maxWidth;
	vec2 m_textOffset;
	vec2 m_sizeOffset;

	TextAlignment m_textAlignment = TextAlignment::Left;
	int m_textWidth;

	float m_scrollOffset = 0;
	int m_previousTime;
	int m_scrollVelocity;

	int m_waitStart ;
	int m_waitTime = 2000;
	int m_vertTextSpacing = 4;
	/*
	vec4 m_color;

	vec4 m_borderColor;
	int m_borderWidth;
	BorderType m_borderType;

	vec4 m_shadowColor;
	int m_shadowSize;

	SpriteRect@ m_spriteRect;
	*/
	FixedTooltipWidget()
	{
		super();
		
		SValue@ params = Resources::GetSValue("gui/tooltip.sval");

		@m_spriteTopLeft = ScriptSprite(GetParamArray(UnitPtr(), params, "top-left"));
		@m_spriteTop = ScriptSprite(GetParamArray(UnitPtr(), params, "top"));
		@m_spriteTopRight = ScriptSprite(GetParamArray(UnitPtr(), params, "top-right"));

		@m_spriteLeft = ScriptSprite(GetParamArray(UnitPtr(), params, "left"));
		@m_spriteMiddle = ScriptSprite(GetParamArray(UnitPtr(), params, "middle"));
		@m_spriteRight = ScriptSprite(GetParamArray(UnitPtr(), params, "right"));

		@m_spriteBottomLeft = ScriptSprite(GetParamArray(UnitPtr(), params, "bottom-left"));
		@m_spriteBottom = ScriptSprite(GetParamArray(UnitPtr(), params, "bottom"));
		@m_spriteBottomRight = ScriptSprite(GetParamArray(UnitPtr(), params, "bottom-right"));

		@m_fontTitle = Resources::GetBitmapFont(GetParamString(UnitPtr(), params, "font-title", false, "gui/fonts/arial11_bold.fnt"));
		@m_fontSub = Resources::GetBitmapFont(GetParamString(UnitPtr(), params, "font-sub", false, "gui/fonts/arial11.fnt"));
		@m_font = Resources::GetBitmapFont(GetParamString(UnitPtr(), params, "font", false, "gui/fonts/arial11.fnt"));

		m_titleSpacing = GetParamInt(UnitPtr(), params, "title-spacing", false, -2);
		m_subSpacing = GetParamVec2(UnitPtr(), params, "sub-spacing", false, vec2(6, 0));

		//m_maxWidth = GetParamInt(UnitPtr(), params, "max-width", false, 100);
		m_textOffset = GetParamVec2(UnitPtr(), params, "text-offset", false, vec2(5, 4));
		m_sizeOffset = GetParamVec2(UnitPtr(), params, "size-offset", false, vec2(9, 8));

		string align = GetParamString(UnitPtr(), params, "alignment", false);
		if (align == "right")
			m_textAlignment = TextAlignment::Right;
		else if (align == "center")
			m_textAlignment = TextAlignment::Center;

		m_scrollVelocity = 20;

	}

	Widget@ Clone() override
	{
		FixedTooltipWidget@ w = FixedTooltipWidget();
		CloneInto(w);
		return w;
	}

	void SetTitle(string title)
	{
		if (m_fontTitle is null)
			return;
			//print("SETTING TITLE: " + title);
		if (title == "")
			@m_textTitle = null;
		else
			@m_textTitle = m_fontTitle.BuildText(title, m_textWidth, m_textAlignment);
	}

	void AddSub(Sprite@ sprite, string sub)
	{
		if (m_fontSub is null)
			return;

		auto subText = TooltipSubText();
		@subText.m_sprite = sprite;
		@subText.m_text = m_fontSub.BuildText(sub, m_textWidth, m_textAlignment);
		AddSub(subText);
	}

	void AddSub(TooltipSubText@ subText)
	{
		m_subTexts.insertLast(subText);
	}

	void SetText(string text)
	{
		@m_text = m_font.BuildText(text, m_textWidth, m_textAlignment);
		m_previousTime = m_waitStart = g_menuTime;
		m_scrollOffset = 0;
	}

	void SetText(string text, TextAlignment align)
	{
		@m_text = m_font.BuildText(text, m_textWidth, align);
		m_previousTime = m_waitStart = g_menuTime;
		m_scrollOffset = 0;
	}

	void Hide()
	{
		@m_text = null;
	}

	void Reset()
	{
		//print("RESET");
		@m_textTitle = null;
		m_subTexts.removeRange(0, m_subTexts.length());
		@m_text = null;

		m_enabled = true;
	}

	void SetEnabled(bool enabled)
	{
		m_enabled = enabled;
	}

	void Load(WidgetLoadingContext &ctx) override
	{
		LoadWidthHeight(ctx);
		Widget::Load(ctx);

		m_textWidth = m_width - m_sizeOffset.x;
	}

	void DoDraw(SpriteBatch& sb, vec2 pos) override
	{
		Widget::DoDraw(sb, pos);

		auto tm = g_menuTime;

		vec2 size = vec2(m_width, m_height);

		//if (!m_enabled)
		//	sb.EnableColorize(vec4(0, 0, 0, 1), vec4(0.125, 0.125, 0.125, 1), vec4(0.25, 0.25, 0.25, 1));

		if (GetVarBool("ui_tooltip_pretty"))
		{
			m_spriteTopLeft.Draw(sb, pos, tm);
			m_spriteTop.Draw(sb, vec4(
				pos.x + m_spriteTopLeft.GetWidth(),
				pos.y,
				size.x - m_spriteTopLeft.GetWidth() - m_spriteTopRight.GetWidth(),
				m_spriteTop.GetHeight()
			), tm);
			m_spriteTopRight.Draw(sb, pos + vec2(size.x - m_spriteTopRight.GetWidth(), 0), tm);

			m_spriteLeft.Draw(sb, vec4(
				pos.x,
				pos.y + m_spriteTopLeft.GetHeight(),
				m_spriteLeft.GetWidth(),
				size.y - m_spriteTopLeft.GetHeight() - m_spriteBottomLeft.GetHeight()
			), tm);
			m_spriteMiddle.Draw(sb, vec4(
				pos.x + m_spriteTopLeft.GetWidth(),
				pos.y + m_spriteTopLeft.GetHeight(),
				size.x - m_spriteTopLeft.GetWidth() - m_spriteTopRight.GetWidth(),
				size.y - m_spriteTopLeft.GetHeight() - m_spriteBottomLeft.GetHeight()
			), tm);
			m_spriteRight.Draw(sb, vec4(
				pos.x + size.x - m_spriteRight.GetWidth(),
				pos.y + m_spriteTopRight.GetHeight(),
				m_spriteRight.GetWidth(),
				size.y - m_spriteTopRight.GetHeight() - m_spriteBottomRight.GetHeight()
			), tm);

			m_spriteBottomLeft.Draw(sb, pos + vec2(0, size.y - m_spriteBottomLeft.GetHeight()), tm);
			m_spriteBottom.Draw(sb, vec4(
				pos.x + m_spriteBottomLeft.GetWidth(),
				pos.y + size.y - m_spriteBottom.GetHeight(),
				size.x - m_spriteBottomLeft.GetWidth() - m_spriteBottomRight.GetWidth(),
				m_spriteBottom.GetHeight()
			), tm);
			m_spriteBottomRight.Draw(sb, pos + vec2(size.x - m_spriteBottomRight.GetWidth(), size.y - m_spriteBottomRight.GetHeight()), tm);
		}
		else
			sb.FillRectangle(vec4(pos.x + 2, pos.y + 2, size.x, size.y), vec4(0, 0, 0, 0.8));

		////////////// DRAW STRINGS ///////////////

		if (m_text is null)
			return;

		vec2 textPos = pos + m_textOffset;

		float anchorX = 0;
		switch (m_textAlignment)
		{
			case TextAlignment::Center: anchorX = 0.5; break;
			case TextAlignment::Right: anchorX = 1; break;
		}

		float contentWidth = size.x - m_textOffset.x * 2;

		if (m_textTitle !is null)
		{
			//print("ANCHOR: " + parseFloat(anchorX));
			sb.DrawString(textPos + vec2(anchorX * (contentWidth - m_textTitle.GetWidth()), 0), m_textTitle);
			textPos += vec2(0, m_textTitle.GetHeight() + m_titleSpacing);
		}
		
		//int totalSubWidth = GetSubtextWidth();
		//int subX = int((anchorX * contentWidth) - (anchorX * totalSubWidth));
		
		int subLine = 0;
		int currentWidth = 0;
		int currentLine = 0;
		
		for (uint i = 0; i < m_subTexts.length(); i++)
		{	
			vec2 subTextPos = textPos;
			auto subText = m_subTexts[i];
			//print("SUBTEXT: " + parseInt(i));
			if(currentWidth + subText.GetWidth() > m_textWidth)
			{
				currentWidth -= m_subSpacing.x;
				//print("Excess Width m_textWidth: " + parseInt(currentWidth + subText.GetWidth()));
				int subX = int((anchorX * contentWidth) - (anchorX * (currentWidth) ) );
				for(uint j = subLine; j < i; j++)
				{
					vec2 subTextPos = textPos + vec2(subX, m_subTexts[subLine].m_text.GetHeight() * currentLine);
					//print("Drawing text: " + parseInt(j));
					subX += int(m_subTexts[j].GetWidth() + m_subSpacing.x);

					vec2 subTextOffset;
					if (m_subTexts[j].m_sprite !is null)
						subTextOffset.x = m_subTexts[j].m_sprite.GetWidth() + 4;

					sb.DrawString(subTextPos + subTextOffset, m_subTexts[j].m_text);

					if (m_subTexts[j].m_sprite !is null)
						sb.DrawSprite(subTextPos + vec2(0, m_subTexts[j].m_text.GetHeight() / 2 - m_subTexts[j].m_sprite.GetHeight() / 2 + 1), m_subTexts[j].m_sprite, g_menuTime);
				}

				//print("Reset width");
				subLine = i;
				currentWidth = m_subTexts[i].GetWidth();
				currentLine++;
			}
			else
			{

				currentWidth += subText.GetWidth() + m_subSpacing.x;
				//print("Add width: " + parseInt(currentWidth));
			}
		}

		if(m_subTexts.length() > subLine)
		{
			currentWidth -= m_subSpacing.x;
			int subX = int((anchorX * contentWidth) - (anchorX * (currentWidth) ) );
			for(uint j = subLine; j < m_subTexts.length(); j++)
			{
				vec2 subTextPos = textPos + vec2(subX, m_subTexts[subLine].m_text.GetHeight() * currentLine);
				//print("Drawing text: " + parseInt(j));
				subX += int(m_subTexts[j].GetWidth() + m_subSpacing.x);
				
				vec2 subTextOffset;
				if (m_subTexts[j].m_sprite !is null)
					subTextOffset.x = m_subTexts[j].m_sprite.GetWidth() + 4;

				sb.DrawString(subTextPos + subTextOffset, m_subTexts[j].m_text);

				if (m_subTexts[j].m_sprite !is null)
					sb.DrawSprite(subTextPos + vec2(0, m_subTexts[j].m_text.GetHeight() / 2 - m_subTexts[j].m_sprite.GetHeight() / 2 + 1), m_subTexts[j].m_sprite, g_menuTime);
			}
			currentLine++;
		}
			/*

			vec2 subTextPos = textPos + vec2(subX, 0);
			subX += int(subText.GetWidth() + m_subSpacing.x);

			vec2 subTextOffset;
			if (subText.m_sprite !is null)
				subTextOffset.x = subText.m_sprite.GetWidth() + 4;

			sb.DrawString(subTextPos + subTextOffset, subText.m_text);

			if (subText.m_sprite !is null)
				sb.DrawSprite(subTextPos + vec2(0, subText.m_text.GetHeight() / 2 - subText.m_sprite.GetHeight() / 2 + 1), subText.m_sprite, g_menuTime);
			*/



		if (m_subTexts.length() > 0)
			textPos += vec2(0, m_subTexts[0].m_text.GetHeight() * (currentLine) + m_subSpacing.y);
		
		// SCROLL TEXT
		//*
		bool clipped = false;

		if(textPos.y + m_text.GetHeight() > pos.y + m_height)
		{
			textPos.y += m_vertTextSpacing;
			//*
			sb.PushClipping(vec4(
				m_origin.x ,
				textPos.y,
				m_width,
				(m_origin.y + m_height - (textPos.y)) - m_vertTextSpacing
			));
			//*/
			Scroll(textPos);

			textPos.y -= m_scrollOffset;

			clipped = true;
		}
	//*/
		if(m_text != null)
			sb.DrawString(textPos + vec2(anchorX * (contentWidth - m_text.GetWidth()), 0), m_text);
//*
		if(clipped)
		{
			sb.PopClipping();
		}
//*/
		//if (!m_enabled)
		//	sb.DisableColorize();
	}

	void Scroll(vec2 textPos)
	{
		auto limit = textPos.y + m_text.GetHeight() - (m_origin.y + m_height) + m_vertTextSpacing;
		if(m_waitStart + m_waitTime < g_menuTime)
		{

			m_scrollOffset += float(m_scrollVelocity) * float(g_menuTime - m_previousTime)/1000;

			if(m_scrollOffset > limit)
			{
				//print("Change upwards");
				m_scrollOffset = limit;
				m_waitStart = g_menuTime;
				m_scrollVelocity = abs(m_scrollVelocity) * -1;
			}
			else if(m_scrollOffset < 0)
			{
				//print("Change downwards");
				m_scrollOffset = 0;
				m_waitStart = g_menuTime;
				m_scrollVelocity = abs(m_scrollVelocity); 
			}

		}

		m_previousTime = g_menuTime;
	}

	int GetSubtextWidth()
	{
		int ret = 0;
		for (uint i = 0; i < m_subTexts.length(); i++)
		{
			ret += m_subTexts[i].GetWidth();
			if (i < m_subTexts.length() - 1)
				ret += int(m_subSpacing.x);
		}
		return ret;
	}
}

ref@ LoadFixedTooltipWidget(WidgetLoadingContext &ctx)
{
	FixedTooltipWidget@ w = FixedTooltipWidget();
	w.Load(ctx);
	return w;
}