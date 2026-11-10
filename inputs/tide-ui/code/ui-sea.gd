# tide / main.gd  UI 段（第 1060-1110 行 + 1495-1580 行）
# 海上场景：顶部操作条 + 居中状态大字 + 信纸面板


func _setup_ui() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)

	var panel := Panel.new()
	panel.position = Vector2(16, 14)
	panel.size = Vector2(330, 40)
	var box := StyleBoxFlat.new()
	box.bg_color = Color(0.065, 0.080, 0.095, 0.82)
	box.border_color = Color(0.910, 0.690, 0.294, 0.42)
	box.border_width_left = 2
	box.border_width_top = 1
	box.border_width_right = 1
	box.border_width_bottom = 1
	box.corner_radius_top_left = 3
	box.corner_radius_top_right = 3
	box.corner_radius_bottom_left = 3
	box.corner_radius_bottom_right = 3
	panel.add_theme_stylebox_override("panel", box)
	layer.add_child(panel)

	hud = Label.new()
	hud.text = "W 前进　S 后退　A/D 转向　ESC 退出"
	hud.add_theme_color_override("font_color", Color(0.93, 0.95, 0.90, 1.0))
	hud.position = Vector2(28, 24)
	hud.add_theme_font_size_override("font_size", 18)
	layer.add_child(hud)

	stat = Label.new()
	stat.text = "钱 0　饵 6　鱼篓 0"
	stat.position = Vector2(28, 116)
	stat.add_theme_font_size_override("font_size", 20)
	stat.add_theme_color_override("font_color", Color(0.90, 0.93, 0.90))
	stat.add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.55))
	stat.add_theme_constant_override("shadow_offset_x", 2)
	stat.add_theme_constant_override("shadow_offset_y", 2)
	layer.add_child(stat)


func _setup_npcs() -> void:
	var spec := [
		{"name": "阿鲛", "c": Color(0.52, 0.38, 0.26), "dx": -1.15, "dz": 1.5,
		 "line": "他把鱼翻过来看了看，只说：这条肥。"},
		{"name": "灯婆", "c": Color(0.66, 0.62, 0.54), "dx": 0.35, "dz": 1.9,
		 "line": "她没抬头，把鱼放进脚边的篮子。"},
		{"name": "小满", "c": Color(0.60, 0.47, 0.38), "dx": 1.65, "dz": 1.1,
		 "line": "“给我的？”他抱着跑了两步，又停下来回头看你。"},
	]
	for sv in spec:

# ---- 信纸面板 ----



func _setup_letters() -> void:
	var ps := StyleBoxFlat.new()
	ps.bg_color = Color(0.957, 0.929, 0.878, 0.96)
	ps.border_color = Color(0.85, 0.79, 0.68, 1.0)
	ps.set_border_width_all(2)
	ps.set_corner_radius_all(3)
	ps.shadow_color = Color(0.0, 0.0, 0.0, 0.30)
	ps.shadow_size = 12

	letter_panel = Panel.new()
	letter_panel.add_theme_stylebox_override("panel", ps)
	letter_panel.position = Vector2(236.0, 232.0)
	letter_panel.size = Vector2(560.0, 268.0)
	letter_panel.visible = false
	hud.get_parent().add_child(letter_panel)

	letter_text = Label.new()
	letter_text.position = Vector2(34.0, 30.0)
	letter_text.size = Vector2(492.0, 190.0)
	letter_text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	letter_text.add_theme_font_size_override("font_size", 19)
	letter_text.add_theme_color_override("font_color", Color(0.106, 0.165, 0.227))
	letter_panel.add_child(letter_text)

	# 铜色细线：信纸的抬头分界
	var rule := ColorRect.new()
	rule.color = Color(0.910, 0.690, 0.294, 0.55)
	rule.position = Vector2(34.0, 18.0)
	rule.size = Vector2(492.0, 1.0)
	letter_panel.add_child(rule)

	letter_head = Label.new()
	letter_head.position = Vector2(34.0, 2.0)
	letter_head.size = Vector2(300.0, 16.0)
	letter_head.add_theme_font_size_override("font_size", 13)
	letter_head.add_theme_color_override("font_color", Color(0.560, 0.430, 0.230))
	letter_panel.add_child(letter_head)

	letter_hint = Label.new()
	letter_hint.position = Vector2(34.0, 226.0)
	letter_hint.add_theme_font_size_override("font_size", 15)
	letter_hint.add_theme_color_override("font_color", Color(0.36, 0.34, 0.30))
	letter_panel.add_child(letter_hint)


func _toggle_letter() -> void:
	if not letter_open:
		if letter_idx >= LETTERS.size():
			return
		letter_open = true
		letter_page = 0
		letter_panel.visible = true
		_refresh_letter()
	else:
		letter_page += 1
		if letter_page >= LETTERS[letter_idx].size():
			letter_open = false
			letter_panel.visible = false
			letter_idx += 1
			Game.letter_idx = letter_idx
		else:
			_refresh_letter()


func _refresh_letter() -> void:
	letter_text.text = LETTERS[letter_idx][letter_page]
	letter_hint.text = "（T 翻页　%d/%d）" % [letter_page + 1, LETTERS[letter_idx].size()]
	if letter_head != null:
		letter_head.text = "第 %d 封　·　第 %d 页" % [letter_idx + 1, letter_page + 1]


func _close_letter() -> void:
	if letter_open:
		letter_open = false
		letter_panel.visible = false


func _update_fishing(delta: float) -> void:
	var space := Input.is_physical_key_pressed(KEY_SPACE)
	var pressed := space and not space_prev
	space_prev = space

	var t_key := Input.is_physical_key_pressed(KEY_T)
