
extends TextureButton

export(int, "Start", "Exit") var menu

func _ready():
	# Initalization here
	pass

func _on_menu_button_pressed():
	print(menu)
