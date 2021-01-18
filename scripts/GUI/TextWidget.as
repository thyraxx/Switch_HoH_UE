class TextWidget : Widget
{
	BitmapFont@ m_font;
	string m_fontName;
	bool m_direct;

	BitmapString@ m_text;
	Widget@ m_highlightParent = null;

	string m_str = "";
	bool m_upper = false;
	int m_textWidth = -1;
	TextAlignment m_alignment = TextAlignment::Left;
	vec4 m_color = vec4(1, 1, 1, 1);
	vec4 m_colorOriginal;
	vec4 m_colorHoverText;
	

	/* SCROLL*/
	bool m_canScroll = false;
	int m_scrollWidthDiff = 0;
	float m_scrollOffset = 0;
	int m_previousTime = 0;
	int m_scrollVelocity = 10;

	int m_waitStart = 0;
	int m_waitTime = 2000;
	int m_vertTextSpacing = 2;

	///////////

	TextWidget()
	{
		super();
		
		m_width = 0;
		m_height = 0;
	}

	Widget@ Clone() override
	{
		TextWidget@ w = TextWidget();
		CloneInto(w);
		return w;
	}
	
	void Load(WidgetLoadingContext &ctx) override
	{
		TextAlignment align = TextAlignment::Left;
		string alignStr = ctx.GetString("align", false);
		if (alignStr == "right")
			align = TextAlignment::Right;
		else if (alignStr == "center")
			align = TextAlignment::Center;

		m_width = ctx.GetInteger("width", false, 0);

		m_upper = ctx.GetBoolean("upper", false, false);

		m_direct = ctx.GetBoolean("direct", false, false);

		if (m_font is null)
		{
			m_fontName = ctx.GetString("font", false);
			@m_font = Resources::GetBitmapFont(m_fontName);
			if (m_font is null)
				PrintError("Couldn't load font: '" + m_fontName + "'");
		}
		
		m_colorOriginal = ctx.GetColorRGBA("color", false, m_color);
		
		string text = Resources::GetString(ctx.GetString("text", false));
		LoadWidthHeight(ctx, false);
		SetText(text, m_width, align, m_colorOriginal);

		m_colorHoverText = Tweak::ScaleButtonTextHoverColor;

		Widget::Load(ctx);

		m_focusEffect = "";
		CheckParent();
		/*SCROLL*/
		m_canScroll = ctx.GetBoolean("canscroll", false, false);
		m_scrollWidthDiff = ctx.GetInteger("scrollWLim", false, 0);
		//////////
	}

	void CheckParent()
	{
		Widget@ w = m_parent;
		while(w !is null){
			if(w.m_canFocus)
			{
				if(w.m_focusEffect == "text-highlight") @m_highlightParent = w;
				break;
			}
			@w = m_parent;
		}
	}

	void SetFont(string fnm)
	{
		@m_font = Resources::GetBitmapFont(fnm);
		if (m_font is null)
		{
			PrintError("Font not found: \"" + fnm + "\"");
			@m_text = null;
		}
		else
			SetText(m_str, m_textWidth, m_alignment, m_color, true);
	}

	void MeasureSize()
	{
		if (m_direct)
		{
			auto size = m_font.MeasureText(m_str, m_textWidth);
			if (m_textWidth > 0)
				m_width = min(int(size.x), m_textWidth);
			else
				m_width = int(size.x);
			m_height = int(size.y);
		}
		else if (m_text !is null)
		{
			if (m_textWidth > 0)
				m_width = min(m_text.GetWidth(), m_textWidth);
			else
				m_width = m_text.GetWidth();
			m_height = m_text.GetHeight();
		}
	}

	void SetText(string str, int width, TextAlignment align = TextAlignment::Left, vec4 color = vec4(1, 1, 1, 1), bool force = false)
	{
		if (!force && m_str == str && m_textWidth == width && m_alignment == align)// && m_color == color)
			return;

		if (m_upper)
			str = utf8string(str).toUpper().plain();

		m_str = str;
		m_textWidth = width;
		m_alignment = align;
		m_color = color;
		m_filter = str.toLower();

		if (!m_direct)
		{
			@m_text = m_font.BuildText(str, width, align);
			m_text.SetColor(color);
		}

		MeasureSize();
	}

	void SetText(string str, bool setColor = true, bool force = false)
	{
		if (!force && m_str == str)
			return;

		if (m_upper)
			str = utf8string(str).toUpper().plain();

		m_str = str;
		m_filter = str.toLower();

		if (m_widthScalar >= 0 && m_parent !is null)
			m_textWidth = int(m_widthScalar * m_parent.m_width);

		@m_text = m_font.BuildText(str, m_textWidth, m_alignment);
		if (setColor)
			m_text.SetColor(m_color);

		MeasureSize();
	}

	void SetColor(vec4 color)
	{
		m_color = color;

		if (!m_direct)
			m_text.SetColor(color);
	}
	
	vec4 GetTextColor()
	{
		if (m_hovering || (m_highlightParent !is null && m_highlightParent.m_hovering))
			return m_colorHoverText;
		return m_color;
	}

	void DoDraw(SpriteBatch& sb, vec2 pos) override
	{
		pos.x = int(pos.x);
		pos.y = int(pos.y);
		
		if (m_direct)
		{
			sb.DrawString(pos, m_font, m_str, m_color, m_alignment);
		}
		else if (m_text !is null)
		{
			m_text.SetColor(GetTextColor());
			/*            SCROLL          */
			auto alignmentOffset = 0;
			auto anchorOffset = 0;
			auto spacingOffset = 0;
			if(m_parent!is null and m_canScroll)
			{
				int widthLimit = m_parent.m_width - m_scrollWidthDiff;

				if(m_text.GetWidth() > widthLimit)
				{
					alignmentOffset = (m_alignment == TextAlignment::Right)?(widthLimit - m_text.GetWidth()):((m_alignment == TextAlignment::Center)?((m_parent.m_width - m_text.GetWidth())/2):0);
					anchorOffset = m_anchor.x * (m_text.GetWidth() - widthLimit);
					spacingOffset = m_vertTextSpacing*2;
					pos += vec2(alignmentOffset + anchorOffset + spacingOffset, 0);
					Scroll(pos);
				}
			}
			////////////////////////////////
			sb.DrawString(pos + vec2(-m_scrollOffset, 0), m_text);
		}
	}

	void ClearChildren() override
	{
		@m_text = null;
		Widget::ClearChildren();
	}

	void Scroll(vec2 textPos)
	{
		auto limit = textPos.x + m_text.GetWidth() - (m_parent.m_origin.x + m_parent.m_width - m_scrollWidthDiff) + m_vertTextSpacing;
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

	void AnimateSet(string key, vec4 v) override
	{
		if (key == "color")
			SetColor(v);
		Widget::AnimateSet(key, v);
	}
}

ref@ LoadTextWidget(WidgetLoadingContext &ctx)
{
	TextWidget@ w = TextWidget();
	w.Load(ctx);
	return w;
}

ref@ LoadSysTextWidget(WidgetLoadingContext &ctx)
{
	TextWidget@ w = TextWidget();
	@w.m_font = Resources::GetBitmapFont("system/system_small.fnt");
	w.Load(ctx);
	return w;
}

void ModTextWidget(Widget@ w, string text)
{
	auto tw = cast<TextWidget>(w);
	if (tw !is null)
		tw.SetText(text);
}
