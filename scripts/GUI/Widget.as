enum WidgetFlow
{
	None,
	Vbox,
	VboxWrapped,
	Hbox,
	HboxWrapped
}

enum WidgetDirection
{
	Up,
	Down,
	Left,
	Right
}

enum BorderType
{
	Inner,
	Middle,
	Outer
}

enum WidgetHint
{
	None,

	NumberLow,
	NumberMid,
	NumberHigh,
	Name,
	Resource,
	Color
}

bool g_debugWidgets;
bool g_inspectWidget;

class WidgetSubText
{
	string m_text;
	Sprite@ m_sprite;
}

class Widget
{
	Widget@ m_parent;
	IWidgetHoster@ m_host;

	bool m_priorityFocus;
	bool m_pixelPerfect;

	int m_doubleClickTime;
	vec2 m_doubleClickPos;
	bool m_canDoubleClick;

	vec2 m_anchor;
	vec2 m_offset;
	vec2 m_padding;

	string m_id;
	uint m_idHash;

	string m_filter;

	protected int _m_width;
	protected int _m_height;

	int m_width
	{
		get { return _m_width; }
		set {
			if (value != _m_width)
				Invalidate();
			_m_width = value;
		}
	}
	int m_height
	{
		get { return _m_height; }
		set {
			if (value != _m_height)
				Invalidate();
			_m_height = value;
		}
	}

	float m_widthScalar = -1;
	float m_heightScalar = -1;

	WidgetFlow m_flow;
	bool m_flowAffected;
	int m_spacing;
	int m_spacingLine;
	bool m_flowFlip;
	bool m_flowFlipOrder;

	bool m_mouseWasDown;
	bool m_hovering;
	bool m_defaultFocus;

	private bool _m_canFocus;
	bool m_canFocus
	{
		get {return _m_canFocus && (m_enabled || m_tooltipText != "");}
		set {
			_m_canFocus = value;
		}
	}
	bool m_canFocusInput;
	string m_focusUp;
	string m_focusDown;
	string m_focusLeft;
	string m_focusRight;
	string m_focusEffect;

	vec2 m_origin;

	vec2 m_originOriginal;

	array<Widget@>@ m_children;

	array<WidgetAnimation@> m_animations;

	vec2 m_lastMousePos;

	vec2 m_childOffset;

	bool m_tooltipEnabled;
	string m_tooltipTitle;
	array<WidgetSubText@> m_tooltipSubtexts;
	string m_tooltipText;
	int m_tooltipAlign;

	bool m_invalidable;
	bool m_invalidated = true;
	private bool _m_visible;
	bool m_visible
	{
		get { return _m_visible; }
		set {
			if (value != _m_visible)
				Invalidate();
			_m_visible = value;
		}
	}

	bool m_enabled;

	Platform::CursorInfo@ m_cursor;

	WidgetHint m_hint;
	string m_hintResource;

%if TARGET_XB1
	vec2 overscanMove = vec2();
	vec2 overscanMoveForced = vec2();
%endif
	Widget()
	{
		@m_children = array<Widget@>();
	}

	int opCmp(const Widget@ w)
	{
		return 0;
	}

	void Invalidate()
	{
		if (!m_invalidable)
			return;

		if (m_host !is null)
		{
			if (m_host.m_invalidationDebug && !m_host.m_invalidated)
				DumpStack();
			m_host.m_invalidated = true;
			m_invalidated = true;
		}
	}

	void SetID(string id)
	{
		m_id = id;
		m_idHash = HashString(id);
	}

	Widget@ Clone()
	{
		Widget@ w = Widget();
		CloneInto(w);
		return w;
	}

	void CloneInto(Widget@ w)
	{
		w = this;
		@w.m_parent = null;
		@w.m_host = null;
		@w.m_children = array<Widget@>();
		for (uint i = 0; i < m_children.length(); i++)
			w.AddChild(m_children[i].Clone());
	}

	void Load()
	{
		m_id = "";
		m_idHash = 0;
		m_anchor = vec2();
		m_offset = vec2();
		m_visible = true;
	}

	void LoadWidthHeight(WidgetLoadingContext &ctx, bool required = true)
	{
		string w = ctx.GetString("width", required, "");
		if (w != "")
		{
			if (w.substr(w.length() - 1, 1) == "%")
				m_widthScalar = int(parseInt(w.substr(0, w.length() - 1))) / 100.0;
			else
				m_width = parseInt(w);
		}
		string h = ctx.GetString("height", required, "");
		if (h != "")
		{
			if (h.substr(h.length() - 1, 1) == "%")
				m_heightScalar = int(parseInt(h.substr(0, h.length() - 1))) / 100.0;
			else
				m_height = parseInt(h);
		}
	}

	void Load(WidgetLoadingContext &ctx)
	{
		GUIDef@ def = ctx.GetGUIDef();;

		@m_host = cast<IWidgetHoster>(ctx.GetWidgetHost());

		SetID(ctx.GetString("id", false));

		m_priorityFocus = ctx.GetBoolean("priorityfocus", false, false);

		m_canDoubleClick = ctx.GetBoolean("candoubleclick", false, false);

		m_filter = ctx.GetString("filter", false).toLower();

		m_anchor = ctx.GetVector2("anchor", false);
		m_offset = ctx.GetVector2("offset", false, m_offset);
		m_padding = ctx.GetVector2("padding", false);
		m_visible = ctx.GetBoolean("visible", false, true);
		m_enabled = ctx.GetBoolean("enabled", false, true);

		m_focusEffect = ctx.GetString("focuseffect", false, "highlight");
		m_canFocus = ctx.GetBoolean("canfocus", false, false);
		m_focusUp = ctx.GetString("focusup", false);
		m_focusDown = ctx.GetString("focusdown", false);
		m_focusLeft = ctx.GetString("focusleft", false);
		m_focusRight = ctx.GetString("focusright", false);

		m_pixelPerfect = ctx.GetBoolean("pixel-perfect", false, true);

		string flow = ctx.GetString("flow", false, "none");
		     if (flow == "vbox") m_flow = WidgetFlow::Vbox;
		else if (flow == "vboxwrapped") m_flow = WidgetFlow::VboxWrapped;
		else if (flow == "hbox") m_flow = WidgetFlow::Hbox;
		else if (flow == "hboxwrapped") m_flow = WidgetFlow::HboxWrapped;
		m_spacing = ctx.GetInteger("spacing", false, 0);
		m_spacingLine = ctx.GetInteger("spacing-line", false, m_spacing);

		m_flowFlip = ctx.GetBoolean("flow-flip", false);
		m_flowFlipOrder = ctx.GetBoolean("flow-flip-order", false);
		m_flowAffected = ctx.GetBoolean("flow-affected", false, true);

		m_tooltipEnabled = ctx.GetBoolean("tooltip-enabled", false, true);
		m_tooltipTitle = Resources::GetString(ctx.GetString("tooltip-title", false));

		string subText = Resources::GetString(ctx.GetString("tooltip-sub", false));
		auto subSprite = def.GetSprite(ctx.GetString("tooltip-sub-sprite", false));
		if (subText != "")
		{
			auto newSubText = WidgetSubText();
			newSubText.m_text = subText;
			@newSubText.m_sprite = subSprite;
			m_tooltipSubtexts.insertLast(newSubText);
		}

		m_tooltipText = Resources::GetString(ctx.GetString("tooltip", false));
		m_defaultFocus = ctx.GetBoolean("defaultfocus", false);
		m_invalidable = ctx.GetBoolean("invalidable", false, true);

		string strHint = ctx.GetString("hint", false);
		if (strHint != "")
		{
			     if (strHint == "number-low") m_hint = WidgetHint::NumberLow;
			else if (strHint == "number-mid") m_hint = WidgetHint::NumberMid;
			else if (strHint == "number-high") m_hint = WidgetHint::NumberHigh;
			else if (strHint == "name") m_hint = WidgetHint::Name;
			else if (strHint == "resource")
			{
				m_hint = WidgetHint::Resource;
				m_hintResource = ctx.GetString("hint-resource");
			}
			else if (strHint == "color") m_hint = WidgetHint::Color;
		}
	}

	void ClearTooltipSubs()
	{
		m_tooltipSubtexts.removeRange(0, m_tooltipSubtexts.length());
	}

	void AddTooltipSub(Sprite@ sprite, string text)
	{
		auto newSubText = WidgetSubText();
		newSubText.m_text = text;
		@newSubText.m_sprite = sprite;
		m_tooltipSubtexts.insertLast(newSubText);
	}

	void Update(int dt)
	{
		for (uint i = 0; i < m_children.length(); i++)
			m_children[i].Update(dt);

		for (uint i = 0; i < m_animations.length(); i++)
			m_animations[i].Update(dt);

		if (m_doubleClickTime > 0)
			m_doubleClickTime -= dt;
	}

	vec2 GetAbsolutePosition()
	{
		vec2 ret = m_offset;
		Widget@ parent = m_parent;
		while (parent !is null)
		{
			ret += parent.m_offset;
			@parent = parent.m_parent;
		}
		return ret;
	}

	vec2 GetRelativeOffset()
	{
		if (m_parent is null)
			return m_origin;
		else
			return m_origin - m_parent.m_origin;
	}

	void CalculateOrigin(vec2 origin, vec2 parentSz)
	{
		origin.x += (m_anchor.x * (parentSz.x - m_width)) + m_offset.x;
		origin.y += (m_anchor.y * (parentSz.y - m_height)) + m_offset.y;

		if (m_pixelPerfect)
		{
			origin.x = int(origin.x);
			origin.y = int(origin.y);
		}

		m_origin = origin;
	}

	void DoLayout(vec2 origin, vec2 parentSz)
	{
		if (!m_visible)
			return;

		if (m_widthScalar >= 0)
			m_width = int(m_widthScalar * parentSz.x);
		if (m_heightScalar >= 0)
			m_height = int(m_heightScalar * parentSz.y);

		CalculateOrigin(origin, parentSz);
		origin = m_origin;

		vec2 childOffset = m_padding + m_childOffset;

		float ox = origin.x;
		float oy = origin.y;

		Widget@ lastWidget = null;

		int numChildren = m_children.length();

		int forStart = 0;
		int forDir = 1;
		if (m_flow != WidgetFlow::None && (m_flowFlip && !m_flowFlipOrder))
		{
			forStart = numChildren - 1;
			forDir = -1;
		}

		for (int i = forStart; i >= 0 && i < numChildren; i += forDir)
		{
			auto child = m_children[i];

			vec2 newOrigin = childOffset + origin;

			if (lastWidget !is null && m_flow != WidgetFlow::None && child.m_flowAffected)
			{
				switch (m_flow)
				{
					case WidgetFlow::Vbox:
						if (m_flowFlip)
							newOrigin.y = lastWidget.m_origin.y - child.m_height - m_spacing;
						else
							newOrigin.y = lastWidget.m_origin.y + lastWidget.m_height + m_spacing;
						break;

					case WidgetFlow::VboxWrapped:
						if (m_flowFlip)
							newOrigin.y = lastWidget.m_origin.y - child.m_width - m_spacing;
						else
							newOrigin.y = lastWidget.m_origin.y + lastWidget.m_height + m_spacing;
						newOrigin.x = lastWidget.m_origin.x;
						if (newOrigin.y < 0 || newOrigin.y - origin.y + child.m_height > m_height - m_padding.y)
						{
							newOrigin.y = childOffset.y + origin.y;
							if (m_flowFlip)
								newOrigin.y += m_height - child.m_height - m_padding.y;
							newOrigin.x += lastWidget.m_width + m_spacingLine;
						}
						break;

					case WidgetFlow::Hbox:
						if (m_flowFlip)
							newOrigin.x = lastWidget.m_origin.x - child.m_width - m_spacing;
						else
							newOrigin.x = lastWidget.m_origin.x + lastWidget.m_width + m_spacing;
						break;

					case WidgetFlow::HboxWrapped:
						if (m_flowFlip)
							newOrigin.x = lastWidget.m_origin.x - child.m_width - m_spacing;
						else
							newOrigin.x = lastWidget.m_origin.x + lastWidget.m_width + m_spacing;
						newOrigin.y = lastWidget.m_origin.y;
						if (newOrigin.x < 0 || newOrigin.x - origin.x + child.m_width > m_width - m_padding.x)
						{
							newOrigin.x = childOffset.x + origin.x;
							if (m_flowFlip)
								newOrigin.x += m_width - child.m_width - m_padding.x;
							newOrigin.y += lastWidget.m_height + m_spacingLine;
						}
						break;
				}
			}
			else if (m_flowFlip)
			{
				switch (m_flow)
				{
					case WidgetFlow::Vbox:
					case WidgetFlow::VboxWrapped:
						newOrigin.y += m_height - child.m_height;
						break;

					case WidgetFlow::Hbox:
					case WidgetFlow::HboxWrapped:
						newOrigin.x += m_width - child.m_width;
						break;
				}
			}

			vec2 mySz = vec2(m_width, m_height);
			child.m_originOriginal = newOrigin - childOffset;
			//child.CalculateOrigin(newOrigin, mySz);

			if (child.m_visible)
				child.DoLayout(newOrigin, mySz);

			if (child.m_visible && (child.m_flowAffected || m_flow == WidgetFlow::None))
				@lastWidget = child;
		}

		m_invalidated = false;
	}

	void DrawBorder(SpriteBatch& sb, vec2 pos, vec2 size, int borderWidth = 1, vec4 borderColor = vec4(1, 1, 1, 1), BorderType borderType = BorderType::Inner)
	{
		if (borderWidth == 0 || borderColor.w <= 0)
			return;

		vec4 rect;
		if (borderType == BorderType::Inner)
		{
			rect = vec4(pos.x, pos.y, size.x, borderWidth); sb.DrawSprite(null, rect, rect, borderColor);
			rect = vec4(pos.x, pos.y + borderWidth, borderWidth, size.y - borderWidth * 2); sb.DrawSprite(null, rect, rect, borderColor);
			rect = vec4(pos.x, pos.y + size.y - borderWidth, size.x, borderWidth); sb.DrawSprite(null, rect, rect, borderColor);
			rect = vec4(pos.x + size.x - borderWidth, pos.y + borderWidth, borderWidth, size.y - borderWidth * 2); sb.DrawSprite(null, rect, rect, borderColor);
		}
		else if (borderType == BorderType::Outer)
		{
			rect = vec4(pos.x - borderWidth, pos.y - borderWidth, size.x + borderWidth * 2, borderWidth); sb.DrawSprite(null, rect, rect, borderColor);
			rect = vec4(pos.x - borderWidth, pos.y, borderWidth, size.y); sb.DrawSprite(null, rect, rect, borderColor);
			rect = vec4(pos.x - borderWidth, pos.y + size.y, size.x + borderWidth * 2, borderWidth); sb.DrawSprite(null, rect, rect, borderColor);
			rect = vec4(pos.x + size.x, pos.y, borderWidth, size.y); sb.DrawSprite(null, rect, rect, borderColor);
		}
		else if (borderType == BorderType::Middle)
		{
			rect = vec4(pos.x - borderWidth / 2, pos.y - borderWidth / 2, size.x + borderWidth, borderWidth); sb.DrawSprite(null, rect, rect, borderColor);
			rect = vec4(pos.x - borderWidth / 2, pos.y + borderWidth / 2, borderWidth, size.y - borderWidth); sb.DrawSprite(null, rect, rect, borderColor);
			rect = vec4(pos.x - borderWidth / 2, pos.y + size.y - borderWidth / 2, size.x + borderWidth, borderWidth); sb.DrawSprite(null, rect, rect, borderColor);
			rect = vec4(pos.x + size.x - borderWidth / 2, pos.y + borderWidth / 2, borderWidth, size.y - borderWidth); sb.DrawSprite(null, rect, rect, borderColor);
		}
	}

	bool ShouldDrawChild(Widget@ child)
	{
		return true;
	}

	void Draw(SpriteBatch& sb, bool debugDraw = false)
	{
		bool visible = m_visible;

		for (uint i = 0; i < m_animations.length(); i++)
		{
			auto anim = m_animations[i];
			anim.PreRender(m_host.m_idt);
			if (anim.IsDone())
				m_animations.removeAt(i--);
		}

		if (!visible)
			return;
		vec2 drawPos = m_origin;
%if TARGET_XB1
		float overscan = GetVarFloat("ui_overscan");
		if(overscanMoveForced.x != 0 || overscanMoveForced.y != 0)
		{
			overscanMove = overscanMoveForced;
		}
		else if(m_parent !is null && (m_parent.overscanMove.x != 0 || m_parent.overscanMove.y != 0))
		{
			overscanMove = m_parent.overscanMove;
		}
		else
		{
			vec2 screenCenter = vec2(g_gameMode.m_wndWidth/2, g_gameMode.m_wndHeight/2);
			overscanMove = (screenCenter - GetCenter());
			overscanMove += vec2(m_width*sign(overscanMove.x)/2, m_height*sign(overscanMove.y)/2);

			if(abs(overscanMove.x) > screenCenter.x*(1 - overscan))
			{
				overscanMove.x *= overscan;
			}
			else
			{
				overscanMove.x = 0;
			}

			if(abs(overscanMove.y) > screenCenter.y*(1 - overscan))
			{
				overscanMove.y *= overscan;
			}
			else
			{
				overscanMove.y = 0;
			}
		}
		drawPos += overscanMove;
%endif

		DoDraw(sb, drawPos);

		if (g_debugWidgets)
			debugDraw = true;

		DrawChildren(sb, debugDraw);

		if (g_gameMode.m_widgetUnderCursor is this && m_focusEffect == "highlight")
		{
			//print(w.m_focusEffect);
			float sintime = ((sin(g_gameMode.acc)+1)/2);
			float anvalue = sintime*0.5 + 0.5;
			vec4 color = vec4(anvalue, anvalue, 0, anvalue);
			Rect@ rect = GetRectangle();
%if TARGET_XB1
			sb.DrawLine(vec2(rect.left, rect.top + 0.5) + overscanMove, vec2(rect.right, rect.top + 0.5) + overscanMove, 1, color);
			sb.DrawLine(vec2(rect.left + 0.5, rect.top + 1) + overscanMove, vec2(rect.left + 0.5, rect.bottom - 1) + overscanMove, 1, color);
			sb.DrawLine(vec2(rect.right - 0.5, rect.top + 1) + overscanMove, vec2(rect.right - 0.5, rect.bottom - 1) + overscanMove, 1, color);
			sb.DrawLine(vec2(rect.left, rect.bottom - 0.5) + overscanMove, vec2(rect.right, rect.bottom - 0.5) + overscanMove, 1, color);	
%else
			sb.DrawLine(vec2(rect.left, rect.top + 0.5), vec2(rect.right, rect.top + 0.5), 1, color);
			sb.DrawLine(vec2(rect.left + 0.5, rect.top + 1), vec2(rect.left + 0.5, rect.bottom - 1), 1, color);
			sb.DrawLine(vec2(rect.right - 0.5, rect.top + 1), vec2(rect.right - 0.5, rect.bottom - 1), 1, color);
			sb.DrawLine(vec2(rect.left, rect.bottom - 0.5), vec2(rect.right, rect.bottom - 0.5), 1, color);	
%endif
			//sb.DrawLine(vec2(0,0), vec2((rect.left + rect.right)/2, (rect.bottom + rect.top)/2), 1, color);
			//sb.DrawCircle(vec2((rect.left + rect.right)/2, (rect.bottom + rect.top)/2), 10, vec4(1, 1, 0, 1), 25);
		}

		if (debugDraw)
			DebugDraw(sb);
	}

	void DrawChildren(SpriteBatch& sb, bool debugDraw = false)
	{
		uint numChildren = m_children.length();

		int forStart = 0;
		int forDir = 1;
		if (m_flow != WidgetFlow::None && m_flowFlip)
		{
			forStart = numChildren - 1;
			forDir = -1;
		}

		Widget@ w = null;

		float sintime = ((sin(g_gameMode.acc)+1)/2);

		for (int i = forStart; i >= 0 && i < int(numChildren); i += forDir)
		{
			auto child = m_children[i];

			vec2 mySz = vec2(m_width, m_height);

			if (ShouldDrawChild(child) && (child.m_focusEffect != "blink" || !(g_gameMode.m_widgetUnderCursor is child) || !(sintime > 0.5) ) )
				child.Draw(sb, debugDraw);

			if(g_gameMode.m_widgetUnderCursor is child)
			{
				@w = child;
			}

		}
/*
		if (w !is null && w.m_focusEffect == "highlight")
		{
			//print(w.m_focusEffect);
			float anvalue = sintime*0.5 + 0.5;
			vec4 color = vec4(anvalue, anvalue, 0, anvalue);
			Rect@ rect = w.GetRectangle();
			sb.DrawLine(vec2(rect.left, rect.top + 0.5), vec2(rect.right, rect.top + 0.5), 1, color);
			sb.DrawLine(vec2(rect.left + 0.5, rect.top + 1), vec2(rect.left + 0.5, rect.bottom - 1), 1, color);
			sb.DrawLine(vec2(rect.right - 0.5, rect.top + 1), vec2(rect.right - 0.5, rect.bottom - 1), 1, color);
			sb.DrawLine(vec2(rect.left, rect.bottom - 0.5), vec2(rect.right, rect.bottom - 0.5), 1, color);	
			//sb.DrawLine(vec2(0,0), vec2((rect.left + rect.right)/2, (rect.bottom + rect.top)/2), 1, color);
			//sb.DrawCircle(vec2((rect.left + rect.right)/2, (rect.bottom + rect.top)/2), 10, vec4(1, 1, 0, 1), 25);
		}
//*/
	}

	void DebugDraw(SpriteBatch& sb)
	{
		vec4 color = vec4(0, 0, 0, 0.5);
		if (g_gameMode.m_widgetUnderCursor is this)
		{
			color.r = 1;
			color.a = 1;
		}
		if (g_gameMode.m_widgetInputFocus is this)
		{
			color.g = 1;
			color.a = 1;
		}
		if (m_hovering)
		{
			color.b = 1;
			color.a = 1;
		}

		sb.PauseClipping();

		Rect@ rect = GetRectangle();
		sb.DrawLine(vec2(rect.left, rect.top), vec2(rect.right, rect.top), 1, color);
		sb.DrawLine(vec2(rect.left, rect.top), vec2(rect.left, rect.bottom), 1, color);
		sb.DrawLine(vec2(rect.right, rect.top), vec2(rect.right, rect.bottom), 1, color);
		sb.DrawLine(vec2(rect.left, rect.bottom), vec2(rect.right, rect.bottom), 1, color);

		for (uint i = 0; i < m_children.length(); i++)
		{
			auto c = m_children[i];
			vec4 col = color;
			col.w = 0.25;
			sb.DrawLine(m_origin, m_origin + (c.m_anchor * (vec2(m_width, m_height) - vec2(c.m_width, c.m_height)) + c.m_offset), 1, col);
		}

		sb.ResumeClipping();
	}

	bool ContainsFocusable()
	{
		if (m_canFocus)
			return true;
		for (uint i = 0; i < m_children.length(); i++)
		{
			if (m_children[i].ContainsFocusable())
				return true;
		}
		return false;
	}

	void ScrollTo(Widget@ w = null)
	{
		if (m_parent is null)
			return;

		if(w is null)@w = this;

		ScrollableWidget@ wScrollable = cast<ScrollableWidget>(m_parent);
		if (wScrollable is null || !wScrollable.m_autoScroll)
		{
			if (m_parent.m_parent !is null)
			{
					m_parent.ScrollTo(w);
			}
			return;
		}

		if(wScrollable.m_height > m_height)
		{
			@w = this;
		}

		// might already fit inside, no need to scroll then
		if (w.m_origin.y >= wScrollable.m_origin.y && w.m_origin.y + w.m_height <= wScrollable.m_origin.y + wScrollable.m_height)
			return;

		vec2 o = w.m_origin;
		int h = w.m_height;

		int topDist = wScrollable.m_origin.y - o.y;
		int bottomDist = (o.y + h) - (wScrollable.m_origin.y + wScrollable.m_height);

		if(h <= wScrollable.m_height)
		{
			wScrollable.m_autoScrollValue -= abs(topDist) > abs(bottomDist)? -abs(bottomDist) : abs(topDist);
		}
		else
		{
			if(o.y > wScrollable.m_origin.y + wScrollable.m_height/2 || o.y + h < wScrollable.m_origin.y + wScrollable.m_height/2)
			wScrollable.m_autoScrollValue += abs(topDist) > abs(bottomDist)? -abs(bottomDist) : abs(topDist);
		}
		wScrollable.TestAutoscrollLimit();
	}

	void SetHovering(bool hovering, vec2 mousePos, bool force = false)
	{
		if (m_hovering != hovering || force)
		{
			m_hovering = hovering;
			if (hovering)
			{
				if (m_canFocus)
				{
					if(g_gameMode.m_widgetUnderCursor !is null) 
					{
						g_gameMode.m_widgetUnderCursor.m_hovering = false;
						g_gameMode.m_widgetUnderCursor.OnMouseLeave(mousePos);
					}
					@g_gameMode.m_widgetUnderCursor = this;
					ScrollTo();

					BaseGameMode@ gm = cast<BaseGameMode>(g_gameMode);
					if(m_host.m_tooltipWidget != null)
					{
						m_host.m_tooltipWidget.Hide();
					}
					else if (gm !is null)
						gm.m_tooltip.Hide();

					OnMouseEnter(mousePos, force);
				}
				/*
				if (force)
					ScrollTo();
				*/
				
				//m_host.m_queueMouseEnter.insertLast(WidgetMouseEvt(this, mousePos, force));
			}
			/*
			else
				m_host.m_queueMouseLeave.insertLast(WidgetMouseEvt(this, mousePos));
			*/
		}
	}

	// Method that gets called only if the widget has input focus (return true if other input should be ignored)
	bool UpdateInput(GameInput& input, MenuInput& menuInput)
	{
		return false;
	}

	bool UpdateInput(vec2 origin, vec2 parentSz, vec3 mousePos)
	{
		return false;
		vec2 d = m_origin - origin;
		origin += d;
		mousePos.x -= d.x;
		mousePos.y -= d.y;

		m_lastMousePos = xy(mousePos);

		if (!m_visible)
		{
			SetHovering(false, xy(mousePos));
			return false;
		}

		if (m_host.m_mouseUsed)
		{
			bool mouseHoverSelf = mousePos.x >= 0 && mousePos.y >= 0 && mousePos.x < m_width && mousePos.y < m_height;

			if (m_parent !is null)// && m_parent.m_overflow == WidgetOverflow::Clip)
				SetHovering(mouseHoverSelf && m_parent.m_hovering, xy(mousePos), m_host.m_forcingFocus);
			else
				SetHovering(mouseHoverSelf, xy(mousePos), m_host.m_forcingFocus);
		}
		else
		{
			SetHovering(g_gameMode.m_widgetUnderCursor is this, xy(mousePos), m_host.m_forcingFocus);
		}

		bool hoveringChildren = false;
		for (uint i = 0; i < m_children.length(); i++)
		{
			if(m_children[i].UpdateInput(origin, vec2(m_width, m_height), mousePos))
				hoveringChildren = true;
		}

		return m_hovering;
	}

	Rect@ GetRectangle(int inset = 0)
	{
		return Rect(
			m_origin.x + inset, m_origin.y + inset,
			m_origin.x + m_width - inset, m_origin.y + m_height - inset
		);
	}

	vec2 GetCenter()
	{
		return vec2(m_origin.x + m_width / 2, m_origin.y + m_height / 2);
	}

array<Widget@> intersectArray;
	
	void IntersectWidgets(Rect& rect, array<Widget@>@ retArray, bool onlyCanFocus = false, Widget@ ignore = null, bool onlyInsideParent = false, Widget@ fromWidget = null)
	{
		Rect@ rectUs = GetRectangle();
		//Agregado 17/01/2019//////////////////////////////////////////////////////////////////////////////
		if(m_invalidated) return;
		///////////////////////////////////////////////////////////////////////////////////////////////////
		ScrollableWidget@ wScrollable = cast<ScrollableWidget>(this);
		bool scrollable = wScrollable !is null;

		Widget@ fromScrollableParent = null;
		if(fromWidget !is null)
		{
			@fromScrollableParent = fromWidget;
			while(fromScrollableParent !is null)
			{
				if(cast<ScrollableWidget>(fromScrollableParent) !is null)
				{
					break;
				}
				@fromScrollableParent = fromScrollableParent.m_parent;
			} 
		}

		for (uint i = 0; i < m_children.length(); i++)
		{
			Widget@ w = m_children[i];

			if (!w.m_visible)
				continue;

			w.IntersectWidgets(rect, retArray, onlyCanFocus, w, onlyInsideParent, fromWidget);

			if (onlyCanFocus && !w.m_canFocus)
				continue;

			if (ignore is w)
				continue;

			Rect@ wr = w.GetRectangle(1);

			Widget@ wScrollableParent = w;
			while(wScrollableParent !is null)
			{
				if(cast<ScrollableWidget>(wScrollableParent) !is null)
				{
					break;
				}
				@wScrollableParent = wScrollableParent.m_parent;
			}

			bool SharedScrollableParent = wScrollableParent is fromScrollableParent and fromScrollableParent !is null;
			/*
			bool SharedScrollableParent = false;
			if(cast<ScrollableWidget>(w.m_parent) !is null && fromWidget !is null)
			{
				Widget@ wref_parent = fromWidget;
				while(wref_parent.m_parent !is null)
				{
					@wref_parent = wref_parent.m_parent;
					if(w.m_parent is wref_parent)
					{
						SharedScrollableParent = true;
						break;
					} 
				}
			}
			*/
			if(!rectUs.Contains(wr) && cast<ScrollableWidget>(w.m_parent) !is null && !SharedScrollableParent && !w.m_parent.GetRectangle(1).Contains(wr))
				continue;

			if (  ((wr.IntersectsWith(rect)) and (!onlyInsideParent or rectUs.Contains(wr))) 
			//*
				 	or (!SharedScrollableParent and wScrollableParent !is null and cast<ScrollableWidget>(wScrollableParent) !is null and wScrollableParent.GetRectangle(1).IntersectsWith(rect))
			//	*/
			)
				retArray.insertLast(w);
		}
	}

	void IntersectWidgets(Widget@ wRef, array<Widget@>@ retArray, WidgetDirection dir, bool onlyCanFocus = false, Widget@ ignore = null, bool onlyInsideParent = false)
	{
		Rect@ rectUs = GetRectangle();
		//Agregado 17/01/2019//////////////////////////////////////////////////////////////////////////////
		if(m_invalidated) return;
		///////////////////////////////////////////////////////////////////////////////////////////////////
		ScrollableWidget@ wScrollable = cast<ScrollableWidget>(this);
		bool scrollable = wScrollable !is null;

		Widget@ fromScrollableParent = null;

		@fromScrollableParent = wRef;
		while(fromScrollableParent !is null)
		{
			if(cast<ScrollableWidget>(fromScrollableParent) !is null)
			{
				break;
			}
			@fromScrollableParent = fromScrollableParent.m_parent;
		} 

		for (uint i = 0; i < m_children.length(); i++)
		{
			Widget@ w = m_children[i];

			w.IntersectWidgets(wRef, retArray, dir, onlyCanFocus, w, onlyInsideParent);

			if (onlyCanFocus && !w.m_canFocus)
				continue;

			if (!w.m_visible)
				continue;

			if (ignore is w || wRef is w)
				continue;

			Rect@ wr = w.GetRectangle(1);
			
			Widget@ wScrollableParent = w;
			while(wScrollableParent !is null)
			{
				if(cast<ScrollableWidget>(wScrollableParent) !is null)
				{
					break;
				}
				@wScrollableParent = wScrollableParent.m_parent;
			}

			bool SharedScrollableParent = wScrollableParent is fromScrollableParent and fromScrollableParent !is null;
			/*
			bool SharedScrollableParent = false;
			if(cast<ScrollableWidget>(w.m_parent) !is null)
			{
				Widget@ wref_parent = wRef;
				while(wref_parent.m_parent !is null)
				{
					@wref_parent = wref_parent.m_parent;
					if(w.m_parent is wref_parent)
					{
						SharedScrollableParent = true;
						break;
					} 
				}
			}
			*/
			if(!rectUs.Contains(wr) && !SharedScrollableParent && !w.m_parent.GetRectangle(1).Contains(wr))
				continue;

			if ((InRange(dir, wRef, w, m_host.skewAngle) and (!onlyInsideParent or rectUs.Contains(wr)))
				//*
				 or (!SharedScrollableParent and wScrollableParent !is null and cast<ScrollableWidget>(wScrollableParent) !is null and InRange(dir, wRef, wScrollableParent, 0))
				 //*/
				  )
				retArray.insertLast(w);
		}
	}

	bool InRange(WidgetDirection dir, Widget@ wRef, Widget@ w, float skewAngle)
	{
		switch(dir)
		{
			case WidgetDirection::Up:
			{
				auto upperLeftRefToRightW = (w.m_origin + vec2(w.m_width, 0)) - wRef.m_origin;
				auto upperRightRefToLeftW = w.m_origin - (wRef.m_origin + vec2(wRef.m_width, 0));
				if(
					(upperLeftRefToRightW.y * skewAngle < upperLeftRefToRightW.x) 
					&& (upperRightRefToLeftW.y * skewAngle < -upperRightRefToLeftW.x)
					&& (wRef.m_origin.y >= w.m_origin.y + w.m_height)
					)	
				{
					return true;
				}
				break;
			}
			case WidgetDirection::Down:
			{
				auto bottomLeftRefToRightW = (w.m_origin + vec2(w.m_width, w.m_height)) - (wRef.m_origin + vec2(0, wRef.m_height));
				auto bottomRightRefToLeftW = (w.m_origin + vec2(0, w.m_height)) - (wRef.m_origin + vec2(wRef.m_width, wRef.m_height));
				if(
					(bottomLeftRefToRightW.y * skewAngle > -bottomLeftRefToRightW.x)
					&& (bottomRightRefToLeftW.y * skewAngle > bottomRightRefToLeftW.x)
					&& (wRef.m_origin.y + wRef.m_height <= w.m_origin.y)
					)
				{
					return true;
				}
				break;
			}
			case WidgetDirection::Left:
			{
				auto leftUpperRefToBottomW = (w.m_origin + vec2(0, w.m_height)) - wRef.m_origin;
				auto leftBottomRefToUpperW = w.m_origin - (wRef.m_origin + vec2(0, wRef.m_height));
				if(
					(leftUpperRefToBottomW.y > leftUpperRefToBottomW.x * skewAngle)
					&& (leftBottomRefToUpperW.y < -leftBottomRefToUpperW.x * skewAngle)
					&& (wRef.m_origin.x >= w.m_origin.x + w.m_width) 
					)
				{
					return true;
				}
				break;
			}
			case WidgetDirection::Right:
			{
				auto rightUpperRefToBottomW = (w.m_origin + vec2(w.m_width, w.m_height)) - (wRef.m_origin + vec2(wRef.m_width, 0));
				auto rightBottomRefToUpperW = (w.m_origin + vec2(w.m_width, 0)) - (wRef.m_origin + vec2(wRef.m_width, wRef.m_height));
				if(
					(rightUpperRefToBottomW.y > -rightUpperRefToBottomW.x * skewAngle)
					&& (rightBottomRefToUpperW.y < rightBottomRefToUpperW.x * skewAngle)
					&& (wRef.m_origin.x + wRef.m_width <= w.m_origin.x)
					)
				{
					return true;
				}
				break;
			}
		}
		return false;
	}

	Widget@ ClosestInArray(array<Widget@>@ arr, WidgetDirection dir, Widget@ originWidget = null)
	{
		Widget@ candidate = null;
		for (uint i = 0; i < arr.length(); i++)
		{
			auto w = arr[i];
			bool closer = false;
			if(originWidget !is null)
			{
				//vec2 ocoord = originWidget.GetCenter();
				//vec2 wcoord = w.GetCenter();
				//vec2 ccoord = candidate.GetCenter();
				//closer = true;
				vec2 d2 = w.GetCenter() - originWidget.GetCenter();

				/*
				print("d2-> x: " + parseFloat(d2.x) + ", y: " + parseFloat(d2.y));
				switch (dir)
				{
					case WidgetDirection::Up: 
					{
						print("Up");
						closer = (d2.y*originWidget.m_width) < -abs(d2.x*originWidget.m_height);
						break;
					}
					case WidgetDirection::Down: 
					{
						print("Down");
						closer = (d2.y*originWidget.m_width) > abs(d2.x*originWidget.m_height); 
						break;
					}
					case WidgetDirection::Left: 
					{
						print("Left");
						closer = (d2.x*originWidget.m_height) < -abs(d2.y*originWidget.m_width); 
						break;
					}
					case WidgetDirection::Right: 
					{
						 print("Right");
						 closer = (d2.x*originWidget.m_height) > abs(d2.y*originWidget.m_width); 
						 break;
					}
				}
				//*/
			
				if (candidate !is null)
				{
					vec2 d1 = candidate.GetCenter() - originWidget.GetCenter();
					//closer = (d1.x*d1.x + d1.y*d1.y) > (d2.x*d2.x + d2.y*d2.y);
					switch (dir)
					{
						case WidgetDirection::Up:
						case WidgetDirection::Down: 
						{
							float candVerticalDistance = abs(d1.y);
							float newVerticalDistance = abs(d2.y);
							if(
								(newVerticalDistance - w.m_height/2) < (candVerticalDistance - candidate.m_height/2)
								||(
								(newVerticalDistance - w.m_height/2) < (candVerticalDistance + candidate.m_height/2) 
//								newVerticalDistance < (candVerticalDistance - candidate.m_height/2) 
//								|| ( ( (candVerticalDistance - candidate.m_height/2) < newVerticalDistance &&  newVerticalDistance < (candVerticalDistance + candidate.m_height/2) ) 
									&& abs(d2.x) <= abs(d1.x)
//									) 
								)
							  )
							{
								closer = true;
							}
							break;
						}
						/*
						case WidgetDirection::Down: 
						{
							if(abs(d2.y) < abs(d1.y) || (d2.y == d1.y && abs(d2.x) < abs(d1.x)) )
							{
								closer = true;
							}
							break;
						}
						*/
						case WidgetDirection::Left:
						case WidgetDirection::Right:
						{
							float candHorizontalDistance = abs(d1.x);
							float newHorizontalDistance = abs(d2.x);
							if((newHorizontalDistance - w.m_width/2) < (candHorizontalDistance - candidate.m_width/2)
								||(
								(newHorizontalDistance - w.m_width/2) < (candHorizontalDistance + candidate.m_width/2)
//								newHorizontalDistance < (candHorizontalDistance - candidate.m_width/2) 
//								|| ( (  (candHorizontalDistance - candidate.m_width/2) < newHorizontalDistance && newHorizontalDistance < (candHorizontalDistance + candidate.m_width/2) ) 
									&& abs(d2.y) <= abs(d1.y) 
//									)
								)
							   )  
							{
								closer = true;
							}
							break;
						}
						/*
						case WidgetDirection::Right: 
						{
							if(abs(d2.x) < abs(d1.x) || ( d2.x == d1.x && abs(d2.y) < abs(d1.y) ))
							{
								closer = true;
							}
							break;
						}
						*/
					}

				}
				else
				{
					closer = true;
				}

				
				/*
				switch (dir)
				{
					case WidgetDirection::Up: 
					{
						closer = ;
						break;
					}
					case WidgetDirection::Down: 
					{
						closer = ; 
						break;
					}
					case WidgetDirection::Left: 
					{
						closer = ; 
						break;
					}
					case WidgetDirection::Right: 
					{
						closer = ;
						 break;
					}
				}
				*/

			} 
			else if (candidate is null)
			{
				closer = true;
			}
			else
			{
				
				switch (dir)
				{
					case WidgetDirection::Up: 
					{
						closer = w.m_origin.y + w.m_height > candidate.m_origin.y + candidate.m_height;
						break;
					}
					case WidgetDirection::Down: 
					{
						closer = w.m_origin.y < candidate.m_origin.y; 
						break;
					}
					case WidgetDirection::Left: 
					{
						closer = w.m_origin.x + w.m_width > candidate.m_origin.x + candidate.m_width; 
						break;
					}
					case WidgetDirection::Right: 
					{
						closer = w.m_origin.x < candidate.m_origin.x;
						 break;
					}
				}
			}
			if (closer)
			{
				@candidate = w;
			}
		}
		return candidate;
	}

	// Returns whether focus was changed. If this returns true, the previous widget will be unfocused.
	bool FocusTowards(WidgetDirection dir, Widget@ originWidget = null)
	{
		// maybe we have hard-defined the focus widgets so check that first before anything
		string hardFocus = "";
		switch (dir)
		{
			case WidgetDirection::Up: hardFocus = m_focusUp; break;
			case WidgetDirection::Down: hardFocus = m_focusDown; break;
			case WidgetDirection::Left: hardFocus = m_focusLeft; break;
			case WidgetDirection::Right: hardFocus = m_focusRight; break;
		}
		if (hardFocus != "")
		{
			Widget@ hardFocusWidget = m_host.m_widget.GetWidgetById(hardFocus);
			if (hardFocusWidget !is null && !hardFocusWidget.m_invalidated && g_gameMode.m_widgetUnderCursor !is hardFocusWidget) // condicion agregada////////////////////////
			{
				hardFocusWidget.SetHovering(true, hardFocusWidget.GetCenter(), true);
				return true;
			}
		}

		// if there's no parent we can't figure out what's around us
		if (m_parent is null)
			return false;

		ScrollableWidget@ wScrollableParent = cast<ScrollableWidget>(m_parent);
		if (wScrollableParent !is null && (dir == WidgetDirection::Up || dir == WidgetDirection::Down) && wScrollableParent.m_flow == WidgetFlow::Vbox && wScrollableParent.m_autoScroll)
		{
			int index = wScrollableParent.m_children.findByRef(this);
			if (index == -1 
				|| (dir == WidgetDirection::Up && (index == 0 || wScrollableParent.m_scrollUpThroughWidget)) 
				|| (dir == WidgetDirection::Down && ((index == int(wScrollableParent.m_children.length()) - 1) || wScrollableParent.m_scrollDownThroughWidget)) )
				return wScrollableParent.FocusTowards(dir);
			Widget@ w = null;
			Widget@ auxw = null;
			int add = (dir == WidgetDirection::Up ? -1 : 1);
			BaseGameMode@ gm = cast<BaseGameMode>(g_gameMode);
			for (uint i = index + add; i >= 0 && i < wScrollableParent.m_children.length(); i += add)
			{
				@w = wScrollableParent.m_children[i];
				if (w.m_canFocus)
				{
					if(auxw !is null)
					{
						@w = auxw;
					}
					break;
				}

				if(gm !is null && auxw is null)
				{
					intersectArray.removeRange(0, intersectArray.length());
					wScrollableParent.m_children[i].IntersectWidgets(wScrollableParent.m_children[i].GetRectangle(), intersectArray, true, this);
					//auto widgets = wScrollableParent.m_children[i].IntersectWidgets(this, dir, true, this);
					if(originWidget is null)
						@auxw = ClosestInArray(intersectArray, dir, this);
					else
						@auxw = ClosestInArray(intersectArray, dir, originWidget);
				}

				@w = null;
			}

			if (w !is null && !w.m_invalidated && g_gameMode.m_widgetUnderCursor !is w) //condicion agregada///////////////////////////////////////////////////////
			{
				w.SetHovering(true, w.GetCenter(), true);
				return true;
			}
		}
		// get the parent rectangle
		Rect@ parentRect = m_host.m_widget.GetRectangle();

		// get the rectangle that we want to test first
		Rect rect;

		Widget@ wItChild = this; 
		while(wItChild.m_parent !is null)
		{
			@wScrollableParent = cast<ScrollableWidget>(wItChild.m_parent);
			if(wScrollableParent !is null) break;
			@wItChild = wItChild.m_parent;
		}

        /////////// Search in scrollable space /////////////
    
        if(wScrollableParent !is null)
        {
	        switch (dir)
			{
				case WidgetDirection::Up:
				case WidgetDirection::Down:
					rect.left = wScrollableParent.GetRectangle().left;
					rect.right = wScrollableParent.GetRectangle().right;
					break;

				case WidgetDirection::Left:
				case WidgetDirection::Right:
					rect.top = wScrollableParent.GetRectangle().top;
					rect.bottom = wScrollableParent.GetRectangle().bottom;
					break;
			}
			intersectArray.removeRange(0, intersectArray.length());
			wScrollableParent.IntersectWidgets(this, intersectArray, dir, true, this);
			//auto widgets = m_host.m_widget.IntersectWidgets(this, dir, true, this);

			Widget@ closest;
			if(originWidget is null)
				@closest = ClosestInArray(intersectArray, dir, this);
			else
				@closest = ClosestInArray(intersectArray, dir, originWidget);	
			if (closest !is null && !closest.m_invalidated && g_gameMode.m_widgetUnderCursor !is closest) //condicion agregada///////////////////////////////////////////
			{
				closest.SetHovering(true, closest.GetCenter(), true);
				return true;
			}
        }
		
        //Search in extended scrollable space
		 if(wScrollableParent !is null)
        {
	        switch (dir)
			{
				case WidgetDirection::Up:
					rect.bottom = m_origin.y;
					rect.top = parentRect.top;
					rect.left = wScrollableParent.GetRectangle().left;
					rect.right = wScrollableParent.GetRectangle().right;
					if (wScrollableParent !is null && wScrollableParent.m_autoScroll && (wScrollableParent.GetRectangle().top - wScrollableParent.m_autoScrollValue < rect.top ))
					{
						rect.top = wScrollableParent.GetRectangle().top - wScrollableParent.m_autoScrollValue;
					}
					break;
				case WidgetDirection::Down:
					rect.bottom = parentRect.bottom;
					rect.top = m_origin.y + m_height;
					rect.left = wScrollableParent.GetRectangle().left;
					rect.right = wScrollableParent.GetRectangle().right;
					if (wScrollableParent !is null && wScrollableParent.m_autoScroll && (wScrollableParent.GetRectangle().top + wScrollableParent.m_autoScrollHeight > rect.bottom))
					{
						rect.bottom = wScrollableParent.GetRectangle().top + wScrollableParent.m_autoScrollHeight;
					}
					break;

				case WidgetDirection::Left:
					rect.left = parentRect.left;
					rect.right = m_origin.x;
					rect.top = wScrollableParent.GetRectangle().top;
					rect.bottom = wScrollableParent.GetRectangle().bottom;
					break;
				case WidgetDirection::Right:
					rect.left = m_origin.x + m_width;
					rect.right = parentRect.right;
					rect.top = wScrollableParent.GetRectangle().top;
					rect.bottom = wScrollableParent.GetRectangle().bottom;
					break;
			}
			intersectArray.removeRange(0, intersectArray.length());
			//m_host.m_widget.IntersectWidgets(this, intersectArray, dir, true, this);
			//auto widgets = m_host.m_widget.IntersectWidgets(this, dir, true, this);
			wScrollableParent.IntersectWidgets(rect, intersectArray, true, this, false, this);

			switch (dir)
			{
				case WidgetDirection::Up:
				{
					for(int i = intersectArray.length()-1; i>=0; i--)
					{
						if(intersectArray[i].m_origin.y + intersectArray[i].m_height > m_origin.y) intersectArray.removeAt(i);
					}
					break;
				}
				case WidgetDirection::Down:
				{
					for(int i = intersectArray.length()-1; i>=0; i--)
					{
						if(intersectArray[i].m_origin.y  < m_origin.y + m_height) intersectArray.removeAt(i);
					}
					break;
				}
				case WidgetDirection::Left:
				{
					for(int i = intersectArray.length()-1; i>=0; i--)
					{
						if(intersectArray[i].m_origin.x + intersectArray[i].m_width < m_origin.x) intersectArray.removeAt(i);
					}
					break;
				}
				case WidgetDirection::Right:
				{
					for(int i = intersectArray.length()-1; i>=0; i--)
					{
						if(intersectArray[i].m_origin.x < m_origin.x + m_width) intersectArray.removeAt(i);
					}
					break;
				}
			}

			Widget@ closest;
			if(originWidget is null)
				@closest = ClosestInArray(intersectArray, dir, this);
			else
				@closest = ClosestInArray(intersectArray, dir, originWidget);	
			if (closest !is null && !closest.m_invalidated && g_gameMode.m_widgetUnderCursor !is closest) //condicion agregada///////////////////////////////////////////
			{
				closest.SetHovering(true, closest.GetCenter(), true);
				return true;
			}
        }

		switch (dir)
		{
			case WidgetDirection::Up:
				rect.left = m_origin.x;
				rect.right = m_origin.x + m_width;
				rect.top = parentRect.top;
				rect.bottom = m_origin.y;
				if (wScrollableParent !is null && wScrollableParent.m_autoScroll && (wScrollableParent.GetRectangle().top - wScrollableParent.m_autoScrollValue < rect.top ))
				{
					rect.top = wScrollableParent.GetRectangle().top - wScrollableParent.m_autoScrollValue;
				}
				break;

			case WidgetDirection::Down:
				rect.left = m_origin.x;
				rect.right = m_origin.x + m_width;
				rect.top = m_origin.y + m_height;
				rect.bottom = parentRect.bottom;
				if (wScrollableParent !is null && wScrollableParent.m_autoScroll && (wScrollableParent.GetRectangle().top + wScrollableParent.m_autoScrollHeight > rect.bottom))
				{
					rect.bottom = wScrollableParent.GetRectangle().top + wScrollableParent.m_autoScrollHeight;
				}
				break;

			case WidgetDirection::Left:
				rect.left = parentRect.left;
				rect.right = m_origin.x;
				rect.top = m_origin.y;
				rect.bottom = m_origin.y + m_height;
				break;

			case WidgetDirection::Right:
				rect.left = m_origin.x + m_width;
				rect.right = parentRect.right;
				rect.top = m_origin.y;
				rect.bottom = m_origin.y + m_height;
				break;
		}

			{ // test if we have any widgets in the immediate area
			intersectArray.removeRange(0, intersectArray.length());
			m_host.m_widget.IntersectWidgets(rect, intersectArray, true, this, false, this);
			//auto widgets = m_host.m_widget.IntersectWidgets(this, dir, true, this);

			Widget@ closest;
			if(originWidget is null)
				@closest = ClosestInArray(intersectArray, dir, this);
			else
				@closest = ClosestInArray(intersectArray, dir, originWidget);	
			if (closest !is null && !closest.m_invalidated && g_gameMode.m_widgetUnderCursor !is closest) //condicion agregada///////////////////////////////////////////
			{
				closest.SetHovering(true, closest.GetCenter(), true);
				return true;
			}
		}

		 if(wScrollableParent !is null)
		 {
			switch (dir)
			{
				case WidgetDirection::Up:
				case WidgetDirection::Down:
					rect.left = wScrollableParent.GetRectangle().left;
					rect.right = wScrollableParent.GetRectangle().right;
					//dirSwap = WidgetDirection::Right;
					break;

				case WidgetDirection::Left:
				case WidgetDirection::Right:
					rect.top = wScrollableParent.GetRectangle().top;
					rect.bottom = wScrollableParent.GetRectangle().bottom;
					//dirSwap = WidgetDirection::Down;
					break;
			}

			{ // test if we have any widgets in the immediate area
				intersectArray.removeRange(0, intersectArray.length());
				m_host.m_widget.IntersectWidgets(rect, intersectArray, true, this, false, this);
				//auto widgets = m_host.m_widget.IntersectWidgets(this, dir, true, this);
				Widget@ closest;
				if(originWidget is null)
					@closest = ClosestInArray(intersectArray, dir, this);
				else
					@closest = ClosestInArray(intersectArray, dir, originWidget);	
				if (closest !is null && !closest.m_invalidated && g_gameMode.m_widgetUnderCursor !is closest) //condicion agregada///////////////////////////////////////////
				{
					closest.SetHovering(true, closest.GetCenter(), true);
					return true;
				}
			}
		}
		//*
		// if we get here, the first test did not give any results, so we expand the search area
		WidgetDirection dirSwap = dir;
		switch (dir)
		{
			case WidgetDirection::Up:
			case WidgetDirection::Down:
				rect.left = parentRect.left;
				rect.right = parentRect.right;
				//dirSwap = WidgetDirection::Right;
				break;

			case WidgetDirection::Left:
			case WidgetDirection::Right:
				rect.top = parentRect.top;
				rect.bottom = parentRect.bottom;
				//dirSwap = WidgetDirection::Down;
				break;
		}



		{ // test if we have any widgets in the expanded area
			intersectArray.removeRange(0, intersectArray.length());
			//auto widgets = m_host.m_widget.IntersectWidgets(rect, true, this);
			m_host.m_widget.IntersectWidgets(this, intersectArray, dir, true, this);
			
			Widget@ closest;
			if(originWidget is null)
				@closest = ClosestInArray(intersectArray, dir, this);
			else
				@closest = ClosestInArray(intersectArray, dir, originWidget);
			if (closest !is null && !closest.m_invalidated && g_gameMode.m_widgetUnderCursor !is closest) //condicion agregada///////////////////////////////////////////
			{
				closest.SetHovering(true, closest.GetCenter(), true);
				return true;
			}
		}
		/*/
		Widget@ wItChild = m_parent; 
		while(wItChild.m_parent !is null)
		{
			@wScrollableParent = cast<ScrollableWidget>(wItChild.m_parent);
			if (wScrollableParent !is null && (dir == WidgetDirection::Up || dir == WidgetDirection::Down) && wScrollableParent.m_flow == WidgetFlow::Vbox && wScrollableParent.m_autoScroll)
			{
				int index = wScrollableParent.m_children.findByRef(wItChild);
				if (index == -1 
					|| (dir == WidgetDirection::Up && (index == 0 || wScrollableParent.m_scrollUpThroughWidget)) 
					|| (dir == WidgetDirection::Down && ((index == int(wScrollableParent.m_children.length()) - 1) || wScrollableParent.m_scrollDownThroughWidget)) )
					return wScrollableParent.FocusTowards(dir);
				Widget@ w = null;
				Widget@ auxw = null;
				int add = (dir == WidgetDirection::Up ? -1 : 1);
				BaseGameMode@ gm = cast<BaseGameMode>(g_gameMode);
				for (uint i = index + add; i >= 0 && i < wScrollableParent.m_children.length(); i += add)
				{
					@w = wScrollableParent.m_children[i];
					if (w.m_canFocus)
					{
						if(auxw !is null)
						{
							@w = auxw;
						}
						break;
					}

					if(gm !is null && auxw is null)
					{
						intersectArray.removeRange(0, intersectArray.length());
						wScrollableParent.m_children[i].IntersectWidgets(wScrollableParent.m_children[i].GetRectangle(), intersectArray, true, wItChild);
						//auto widgets = wScrollableParent.m_children[i].IntersectWidgets(this, dir, true, wItChild);
						if(originWidget is null)
							@auxw = ClosestInArray(intersectArray, dir, wItChild);
						else
							@auxw = ClosestInArray(intersectArray, dir, originWidget);
					}

					@w = null;
				}

				if (w !is null && !w.m_invalidated && g_gameMode.m_widgetUnderCursor !is w) //condicion agregada///////////////////////////////////////////////////////
				{
					w.SetHovering(true, w.GetCenter(), true);
					return true;
				}
			}

			if(wScrollableParent !is null)
			{
				switch (dir)
				{
					case WidgetDirection::Up:
					case WidgetDirection::Down:
						rect.left = wScrollableParent.GetRectangle().left;
						rect.right = wScrollableParent.GetRectangle().right;
						//dirSwap = WidgetDirection::Right;
						break;

					case WidgetDirection::Left:
					case WidgetDirection::Right:
						rect.top = wScrollableParent.GetRectangle().top;
						rect.bottom = wScrollableParent.GetRectangle().bottom;
						//dirSwap = WidgetDirection::Down;
						break;
				}

				{ // test if we have any widgets in the immediate area
					intersectArray.removeRange(0, intersectArray.length());
					m_host.m_widget.IntersectWidgets(rect, intersectArray, true, this);
					//auto widgets = m_host.m_widget.IntersectWidgets(this, dir, true, this);
					Widget@ closest;
					if(originWidget is null)
						@closest = ClosestInArray(intersectArray, dir, this);
					else
						@closest = ClosestInArray(intersectArray, dir, originWidget);	
					if (closest !is null && !closest.m_invalidated && g_gameMode.m_widgetUnderCursor !is closest) //condicion agregada///////////////////////////////////////////
					{
						closest.SetHovering(true, closest.GetCenter(), true);
						return true;
					}
				}
			}
			@wItChild = wItChild.m_parent;
		}
		//*/



		// pass 2 didn't find anything either, so try from the parent instead
		//if(originWidget == null)
			//return m_parent.FocusTowards(dir, this);

		//return m_parent.FocusTowards(dir, originWidget);
		return false;
	}

	GUIDef@ AddResource(GUIBuilder@ b, string filename)
	{
		GUIDef@ def = Resources::GetGUIDef(filename);
		if (def is null)
		{
			PrintError("GUI Definition is null for: '" + filename + "'");
			return null;
		}
		Widget@ w = cast<Widget>(b.BuildGUI(def, m_host));
		if (w is null)
		{
			PrintError("GUI resource build failed for: '" + filename + "'");
			return null;
		}
		else
			AddChild(w);
		Hooks::Call("WidgetHosterResourceAdded", @this, @w, @b, @def);
		return def;
	}

	void AddChild(ref widget, int insertAt = -1)
	{
		Widget@ w = cast<Widget>(widget);
		if (insertAt == -1 || insertAt > int(m_children.length()))
			m_children.insertLast(w);
		else
			m_children.insertAt(insertAt, w);
		@w.m_parent = this;
		if (w.m_host is null)
			SetHost(m_host);

		w.AddedToParent();
		Invalidate();
	}

	void AddedToParent()
	{
	}

	void RemoveFromParent()
	{
		if (m_parent is null)
			return;
		int index = m_parent.m_children.findByRef(this);
		if (index == -1)
			return;
		Unfocus();
		m_parent.m_children.removeAt(index);
		m_parent.Invalidate();
		@m_parent = null;
	}

	void SetOriginFromParent(vec2 origin)
	{
		if (m_parent is null)
			m_offset = origin;
		else
			m_offset = origin - m_parent.m_origin;
	}

	void MoveToParentInPlace(Widget@ newParent, int insertAt = -1)
	{
		RemoveFromParent();
		newParent.AddChild(this, insertAt);
		SetOriginFromParent(m_origin);
	}

	bool Unfocus()
	{
		if (g_gameMode.m_widgetUnderCursor is this)
		{
			@g_gameMode.m_widgetUnderCursor = null;
			OnMouseLeave(vec2());
			return true;
		}
		for (uint i = 0; i < m_children.length(); i++)
		{
			if (m_children[i].Unfocus())
				return true;
		}
		return false;
	}

	void SetHost(IWidgetHoster@ host)
	{
		@m_host = host;
		for (uint i = 0; i < m_children.length(); i++)
			m_children[i].SetHost(host);

		Invalidate();
	}

	void ClearChildren()
	{
		for (uint i = 0; i < m_children.length(); i++)
		{
			m_children[i].ClearChildren();
			m_children[i].Unfocus();
			@m_children[i].m_parent = null;
		}
		m_children.removeRange(0, m_children.length());

		Invalidate();
	}

	void Remove()
	{
		if (m_parent is null)
			return;
		m_parent.m_children.removeAt(m_parent.m_children.findByRef(this));
		@m_parent = null;
	}

	void DoDraw(SpriteBatch& sb, vec2 pos) {}

	void Animate(WidgetAnimation@ anim)
	{
		@anim.m_widget = this;
		m_animations.insertLast(anim);
	}

	void FinishAnimations()
	{
		for (uint i = 0; i < m_animations.length(); i++)
			m_animations[i].Finish();
		CancelAnimations();
	}

	void CancelAnimations()
	{
		m_animations.removeRange(0, m_animations.length());
	}

	void AnimateSet(string key, vec4 v) { }

	void AnimateSet(string key, vec2 v)
	{
		if (key == "offset")
			m_offset = v;
		else if (key == "anchor")
			m_anchor = v;

		m_host.Invalidate();
	}

	void AnimateSet(string key, float f)
	{
		if (key == "width")
			m_width = int(f);
		else if (key == "height")
			m_height = int(f);

		m_host.Invalidate();
	}

	void AnimateSet(string key, bool b)
	{
		if (key == "visible")
			m_visible = b;
	}

	void AnimateSet(string key, Sprite@ s)
	{
	}

	void AnimateSet(string key, string str)
	{
		if (key == "func")
			m_host.OnFunc(this, str);
	}

	Widget@ GetWidgetById(const string &in id)
	{
		if (m_id == id)
			return this;

		return GetWidgetByIdImpl(HashString(id));
	}

	Widget@ GetWidgetByIdImpl(uint idHash)
	{
		for (uint i = 0; i < m_children.length(); i++)
		{
			if (m_children[i].m_idHash == idHash)
				return m_children[i];

			Widget@ w = m_children[i].GetWidgetByIdImpl(idHash);
			if (w !is null)
				return w;
		}

		return null;
	}
	
	int GetChildrenPosition(Widget@ w)
	{
		for(uint i = 0; i < m_children.length(); i++)
		{
			if(w is m_children[i])return i;
		}
		return -1;
	}

	array<Widget@> GetWidgetsById(const string &in id)
	{
		array<Widget@> ret;

		if (m_id == id)
			ret.insertLast(this);

		for (uint i = 0; i < m_children.length(); i++)
		{
			array<Widget@> ws = m_children[i].GetWidgetsById(id);
			for (uint j = 0; j < ws.length(); j++)
				ret.insertLast(ws[j]);
		}

		return ret;
	}

	bool PassesFilter(const string &in str)
	{
		if (m_filter == "")
			return true;
		return (m_filter.findFirst(str) != -1);
	}

	void ShowTooltip()
	{
		BaseGameMode@ gm = cast<BaseGameMode>(g_gameMode);
		if(m_host.m_tooltipWidget != null)
		{
			//print("WORKS");
			m_host.m_tooltipWidget.Reset();
			m_host.m_tooltipWidget.SetTitle(m_tooltipTitle);

			for (uint i = 0; i < m_tooltipSubtexts.length(); i++)
			{
				auto subText = m_tooltipSubtexts[i];
				m_host.m_tooltipWidget.AddSub(subText.m_sprite, subText.m_text);
			}

			if (m_tooltipAlign > -1)
				m_host.m_tooltipWidget.SetText(m_tooltipText, TextAlignment(m_tooltipAlign));
			else
				m_host.m_tooltipWidget.SetText(m_tooltipText);

			m_host.m_tooltipWidget.SetEnabled(m_tooltipEnabled);
		}
		else if (gm !is null)
		{
			gm.m_tooltip.Reset();
			gm.m_tooltip.SetTitle(m_tooltipTitle);

			for (uint i = 0; i < m_tooltipSubtexts.length(); i++)
			{
				auto subText = m_tooltipSubtexts[i];
				gm.m_tooltip.AddSub(subText.m_sprite, subText.m_text);
			}

			if (m_tooltipAlign > -1)
				gm.m_tooltip.SetText(m_tooltipText, TextAlignment(m_tooltipAlign));
			else
				gm.m_tooltip.SetText(m_tooltipText);

			gm.m_tooltip.SetEnabled(m_tooltipEnabled);
		}
	}

	// These return whether it was handled (true = don't propogate to its parent)
	bool OnMouseDown(vec2 mousePos) { return false; }
	bool OnMouseUp(vec2 mousePos) { return false; }
	bool OnClick(vec2 mousePos) { return false; }
	bool OnDoubleClick(vec2 mousePos) { return false; }

	void OnMouseEnter(vec2 mousePos, bool forced)
	{
		if (m_tooltipText != "" || m_tooltipTitle != "")
			ShowTooltip();
	}

	void OnMouseLeave(vec2 mousePos)
	{
		m_mouseWasDown = false;

		if (m_tooltipText != "" || m_tooltipTitle != "")
		{
			BaseGameMode@ gm = cast<BaseGameMode>(g_gameMode);
			if(m_host.m_tooltipWidget != null)
			{
				m_host.m_tooltipWidget.Hide();
			}
			else if (gm !is null)
				gm.m_tooltip.Hide();
		}
	}
}
