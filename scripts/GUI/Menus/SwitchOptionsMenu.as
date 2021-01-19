namespace Menu
{
	class SwitchOptionsMenu : SubOptionsMenu
	{
		SwitchOptionsMenu(MenuProvider@ provider)
		{
			super(provider);

			m_isPopup = true;
		}

		void Update(int dt) override
		{
			SubOptionsMenu::Update(dt);

			auto gi = GetInput();

			if(gi.MapOverlay.Pressed)
				OnFunc(null, "defaults");
		}

		void SwitchSave()
		{
			Config::SaveVar("rg_brightness");
			Config::SaveVar("rg_gamma");
			Config::SaveVar("rg_contrast");
			Config::SaveVar("rg_crt_curve");

			Config::SaveVar("ui_txt_enemy_hurt_husk");
			Config::SaveVar("ui_txt_enemy_hurt_local");
			Config::SaveVar("ui_txt");
			Config::SaveVar("ui_minimap_size");
			
			Config::SaveVar("ui_key_count");
			Config::SaveVar("r_floating_texts");
			Config::SaveVar("g_screenshake");
%if TARGET_XB1
			Config::SaveVar("ui_overscan");
%endif
%if TARGET_NX
			Config::SaveVar("blit_zoom");
			Config::SaveVar("r_zoom_blur");
%endif
			Config::SaveVar("g_laser_sight");
			Config::SaveVar("snd_volume_music");
			Config::SaveVar("snd_volume_etc");

			Blit::SaveConfig();
		}

		void OnFunc(Widget@ sender, string name) override
		{	
			//print(GetVarBool("rg_crt_mode"));
%if TARGET_NX
			if(name=="zoom_change")
			{
				bool blurring = GetVarBool("r_zoom_blur");
				float zoom_lvl = GetVarFloat("blit_zoom");
				//print("zoom_change. r_zoom_blur: " + blurring + "  " + GetVarFloat("blit_zoom"));
				if(zoom_lvl < 0.01f && blurring)
				{
					SetVar("r_zoom_blur", false);
					zoom_lvl = 0.0f;
				}
				else if(zoom_lvl > 0.0f && !blurring)
					SetVar("r_zoom_blur", true);
			}
%endif
			if(name=="back") 
				SwitchSave();
			//print(">>>>>>>>>>> name: " + name);
			SubOptionsMenu::OnFunc(sender, name);
			//print(GetVarBool("rg_crt_mode"));
			// if(GetVarBool("rg_crt_mode"))
			// {
				// SetVar("rg_brightness", -0.0745f);
				// SetVar("rg_gamma", 3.4f);
				// SetVar("rg_contrast",1.15f);
				// SetVar("rg_crt_curve",0.075f);
				// //SetVar("r_draw_phosphor", true);
				// //SetVar("r_draw_blur", true);
				// //SetVar("r_draw_bloom", true);
			// }
			// else
			// {
				// SetVar("rg_brightness", GetVarFloatDefault("rg_brightness"));
				// SetVar("rg_gamma", GetVarFloatDefault("rg_gamma"));
				// SetVar("rg_contrast", GetVarFloatDefault("rg_contrast"));
				// SetVar("rg_crt_curve",GetVarFloatDefault("rg_crt_curve"));
				// //SetVar("r_draw_phosphor", false);
				// //SetVar("r_draw_blur", false);
				// //SetVar("r_draw_bloom", false);
			// }
			// //print(GetVarInt("r_info"));
			// switch(GetVarInt("r_info"))
			// {
				// case 0:
				// {
					// SetVar("ui_txt_enemy_hurt_husk", "");
					// SetVar("ui_txt_enemy_hurt_local","");
					// SetVar("ui_txt", false);
					// SetVar("ui_minimap_size", -1);
					// break;
				// }
				// case 1:
				// {
					// SetVar("ui_txt_enemy_hurt_husk", "");
					// SetVar("ui_txt_enemy_hurt_local","ffd800");
					// SetVar("ui_txt", true);
					// SetVar("ui_minimap_size", 70);
					// break;
				// }
				// case 2:
				// {
					// SetVar("ui_txt_enemy_hurt_husk","aa9000");
					// SetVar("ui_txt_enemy_hurt_local","ffd800");
					// SetVar("ui_txt", true);
					// SetVar("ui_minimap_size", 100);
					// break;
				// }
				// default:
			// }
			
			if(GetVarInt("r_floating_texts") == 1)
			{
				SetVar("ui_txt_enemy_hurt_husk","aa9000");
				SetVar("ui_txt_enemy_hurt_local","ffd800");
				SetVar("ui_txt", true);
			}
			else
			{
				SetVar("ui_txt_enemy_hurt_husk", "");
				SetVar("ui_txt_enemy_hurt_local","");
				SetVar("ui_txt", false);
			}
			
		}
	}
}
