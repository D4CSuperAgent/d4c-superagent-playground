# tide / shore.gd  UI 段（第 690-775 行）
# 岸上场景全部界面：顶栏 + 状态行/提示行/交互提示 + 对话面板
# 注意：全部代码创建，无 Theme 资源
func _setup_ui() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)

	var bar := Panel.new()
	bar.position = Vector2(20.0, 20.0)
	bar.size = Vector2(600.0, 38.0)
	var bar_box := StyleBoxFlat.new()
	bar_box.bg_color = Color(0.065, 0.080, 0.095, 0.82)
	bar_box.border_color = Color(0.910, 0.690, 0.294, 0.42)
	bar_box.border_width_left = 2
	bar_box.border_width_top = 1
	bar_box.border_width_right = 1
	bar_box.border_width_bottom = 1
	bar_box.corner_radius_top_left = 3
	bar_box.corner_radius_top_right = 3
	bar_box.corner_radius_bottom_left = 3
	bar_box.corner_radius_bottom_right = 3
	bar.add_theme_stylebox_override("panel", bar_box)
	layer.add_child(bar)

	hud = Label.new()
	hud.text = "W A S D 走　F 送鱼　E 卖鱼/上船　R 买饵"
	hud.position = Vector2(32.0, 28.0)
	hud.add_theme_font_size_override("font_size", 19)
	hud.add_theme_color_override("font_color", Color(0.94, 0.95, 0.94))
	layer.add_child(hud)

	stat = Label.new()
	stat.position = Vector2(30.0, 64.0)
	stat.add_theme_font_size_override("font_size", 22)
	stat.add_theme_color_override("font_color", Color(1.0, 0.94, 0.82))
	stat.add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.55))
	stat.add_theme_constant_override("shadow_offset_x", 1)
	stat.add_theme_constant_override("shadow_offset_y", 1)
	layer.add_child(stat)

	msg = Label.new()
	msg.position = Vector2(30.0, 104.0)
	msg.add_theme_font_size_override("font_size", 24)
	msg.add_theme_color_override("font_color", Color(1.0, 0.98, 0.92))
	layer.add_child(msg)

	# 对话面板：谁说话、说了什么，留在画面下方几秒
	dlg = Panel.new()
	dlg.position = Vector2(30.0, 452.0)
	dlg.size = Vector2(600.0, 96.0)
	var dlg_box := StyleBoxFlat.new()
	dlg_box.bg_color = Color(0.075, 0.090, 0.105, 0.90)
	dlg_box.border_color = Color(0.910, 0.690, 0.294, 0.55)
	dlg_box.border_width_left = 2
	dlg_box.border_width_top = 1
	dlg_box.border_width_right = 1
	dlg_box.border_width_bottom = 1
	dlg_box.corner_radius_top_left = 3
	dlg_box.corner_radius_top_right = 3
	dlg_box.corner_radius_bottom_left = 3
	dlg_box.corner_radius_bottom_right = 3
	dlg.add_theme_stylebox_override("panel", dlg_box)
	dlg.visible = false
	layer.add_child(dlg)

	dlg_name = Label.new()
	dlg_name.position = Vector2(18.0, 10.0)
	dlg_name.size = Vector2(200.0, 24.0)
	dlg_name.add_theme_font_size_override("font_size", 19)
	dlg_name.add_theme_color_override("font_color", Color(0.910, 0.690, 0.294))
	dlg.add_child(dlg_name)

	dlg_line = Label.new()
	dlg_line.position = Vector2(18.0, 38.0)
	dlg_line.size = Vector2(564.0, 48.0)
	dlg_line.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	dlg_line.add_theme_font_size_override("font_size", 21)
	dlg_line.add_theme_color_override("font_color", Color(1.0, 0.97, 0.90))
	dlg.add_child(dlg_line)

	prompt = Label.new()
	prompt.position = Vector2(30.0, 150.0)
	prompt.add_theme_font_size_override("font_size", 20)
	prompt.add_theme_color_override("font_color", Color(0.86, 0.94, 1.0))
	prompt.add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.55))
	prompt.add_theme_constant_override("shadow_offset_x", 1)
	prompt.add_theme_constant_override("shadow_offset_y", 1)
	layer.add_child(prompt)

