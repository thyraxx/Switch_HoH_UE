class DialogXBOWindow : IWidgetHoster
{
	bool m_visible;

	DialogXBOWindow(GUIBuilder@ b)
	{
		LoadWidget(b, "gui/dialogwindowXBO.gui");

		m_visible = false;
	}

	bool BlocksLower() override
	{
		return true;
	}

	void SetQuestion(string question)
	{
		auto wQuestion = cast<TextWidget>(m_widget.GetWidgetById("question"));
		if (wQuestion !is null)
		{
			wQuestion.m_anchor.y = 0.5;
			wQuestion.SetText("\\cF8941D" + question, false);
		}

		Invalidate();
	}

	void Draw(SpriteBatch& sb, int idt) override
	{
		if (m_visible)
			IWidgetHoster::Draw(sb, idt);
	}

	void Close()
	{
		m_visible = false;
	}

	void OnFunc(Widget@ sender, string name) override
	{
		IWidgetHoster::OnFunc(sender, name);
	}
}
