app.Env("CYGWIN") = "nontsec";

Config.tty.execute_command = "/bin/bash --login -i";
Config.tty.title = "ck";
Config.tty.savelines = 1000;
Config.tty.input_encoding = Encoding.UTF8;
Config.tty.display_encoding = Encoding.UTF8 | Encoding.SJIS | Encoding.EUCJP ;
Config.tty.scroll_key = 1;
Config.tty.scroll_output = 0;
Config.tty.bs_as_del = 1;
Config.tty.use_bell = 0;
Config.tty.cjk_width = 1;

Config.accelkey.new_shell    = Keys.ShiftL | Keys.CtrlL | Keys.N;
Config.accelkey.new_window   = Keys.ShiftL | Keys.CtrlL | Keys.M;
Config.accelkey.open_window  = Keys.ShiftL | Keys.CtrlL | Keys.O;
Config.accelkey.close_window = Keys.ShiftL | Keys.CtrlL | Keys.W;
Config.accelkey.next_shell   = Keys.CtrlL | Keys.Tab;
Config.accelkey.prev_shell   = Keys.ShiftL | Keys.CtrlL | Keys.Tab;
Config.accelkey.paste        = Keys.ShiftL | Keys.Insert;
Config.accelkey.popup_menu   = Keys.ShiftL | Keys.F10;
Config.accelkey.popup_sys_menu = Keys.AltR | Keys.Space;
Config.accelkey.scroll_page_up   = Keys.ShiftL | Keys.PageUp;
Config.accelkey.scroll_page_down = Keys.ShiftL | Keys.PageDown;
Config.accelkey.scroll_line_up   = Keys.None;
Config.accelkey.scroll_line_down = Keys.None;
Config.accelkey.scroll_top    = Keys.ShiftL | Keys.Home;
Config.accelkey.scroll_bottom = Keys.ShiftL | Keys.End;

Config.window.position_x = null;
Config.window.position_y = null;
Config.window.cols = 120;
Config.window.rows = 40;
Config.window.scrollbar_show = 1;
Config.window.scrollbar_right = 1;
Config.window.blink_cursor = 1;
Config.window.transparent = WinTransp.GrassNoEdge;
Config.window.zorder = WinZOrder.Normal;
Config.window.linespace = 0;
Config.window.border_left   = 1;
Config.window.border_top    = 1;
Config.window.border_right  = 1;
Config.window.border_bottom = 1;
Config.window.mouse_left   = MouseCmd.Select;
Config.window.mouse_middle = MouseCmd.Paste;
Config.window.mouse_right  = MouseCmd.Paste;
//Config.window.font_name = "MS Gothic";
Config.window.font_size = 12;
Config.window.background_file = "";
Config.window.background_repeat_x = Place.Repeat;
Config.window.background_repeat_y = Place.Repeat;
Config.window.background_align_x = Align.Near;
Config.window.background_align_y = Align.Near;
Config.window.alpha_text_border = 0x44;
Config.window.alpha_back_colorN = 0xaa;
Config.window.color_selection  = 0x660000ff;
Config.window.color_cursor     = 0x00aa00;
Config.window.color_imecursor  = 0xaa0000;

// Hybrid
/*
Config.window.color_foreground = 0xC5C8C6;
Config.window.color_background = 0x1D1F21;
Config.window.color_color0 = 0x282A2E;
Config.window.color_color0 = 0x000000;
Config.window.color_color8 = 0x373B41;
Config.window.color_color1 = 0xA54242;
Config.window.color_color9 = 0xCC6666;
Config.window.color_color2 = 0x8C9440;
Config.window.color_color10 = 0xB5BD68;
Config.window.color_color3 = 0xDE935F;
Config.window.color_color11 = 0xF0C674;
Config.window.color_color4 = 0x5F819D;
Config.window.color_color12 = 0x81A2BE;
Config.window.color_color5 = 0x85678F;
Config.window.color_color13 = 0xB294BB;
Config.window.color_color6 = 0x5E8D87;
Config.window.color_color14 = 0x8ABEB7;
Config.window.color_color7 = 0x707880;
Config.window.color_color15 = 0xC5C8C6;
*/

// Monokai
Config.window.color_foreground = 0xFFFFFFFF;
Config.window.color_background = 0xff333333;
Config.window.color_color0 = 0x1B1D1E;
Config.window.color_color1 = 0xF92672;
Config.window.color_color2 = 0x82B414;
Config.window.color_color3 = 0xFD971F;
Config.window.color_color4 = 0x56C2D6;
Config.window.color_color5 = 0x8C54FE;
Config.window.color_color6 = 0x465457;
Config.window.color_color7 = 0xCCCCC6;
Config.window.color_color8 = 0x505354;
Config.window.color_color9 = 0xFF5995;
Config.window.color_color10 = 0xB6E354;
Config.window.color_color11 = 0xFEED6C;
Config.window.color_color12 = 0x8CEDFF;
Config.window.color_color13 = 0x9E6FFE;
Config.window.color_color14 = 0x899CA1;
Config.window.color_color15 = 0xF8F8F2;

/*
Config.window.color_foreground = 0xFFFFFFFF;
Config.window.color_background = 0xff333333;
Config.window.color_color0 = 0x000000;
Config.window.color_color1 = 0xcd0000;
Config.window.color_color2 = 0x00cd00;
Config.window.color_color3 = 0xcdcd00;
Config.window.color_color4 = 0x0000cd;
Config.window.color_color5 = 0xcd00cd;
Config.window.color_color6 = 0x00cdcd;
Config.window.color_color7 = 0xe5e5e5;
Config.window.color_color8 = 0x4d4d4d;
Config.window.color_color9 = 0xff0000;
Config.window.color_color10 = 0x00ff00;
Config.window.color_color11 = 0xffff00;
Config.window.color_color12 = 0x0000ff;
Config.window.color_color13 = 0xff00ff;
Config.window.color_color14 = 0x00ffff;
Config.window.color_color15 = 0xffffff;
*/

