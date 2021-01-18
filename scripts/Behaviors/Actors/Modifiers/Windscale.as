namespace Modifiers
{
	class Windscale : Modifier
	{
		float m_scale;

		Windscale(UnitPtr unit, SValue& params)
		{
			m_scale = GetParamFloat(unit, params, "wind-scale", false, 1.0f);
		}

		ModDyn DynWindScale() override { return ModDyn::Static; }
		float WindScale(PlayerBase@ player) override { return m_scale; }
	}
}
