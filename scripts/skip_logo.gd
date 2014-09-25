
extends TextureButton

# member variables here, example:
# var a=2
# var b="textvar"
var screen_size
var skip

func _ready():
	skip = 0
	screen_size = OS.get_video_mode_size()
	set_size(screen_size)
	
func _on_TextureButton_pressed():
	print("skip")
	get_node("/root/scene_switcher").goto_scene("res://scenes/main_menu.scn")
	
