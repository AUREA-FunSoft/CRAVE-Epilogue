
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
	pass

func skip():
	print("skip")
	get_node("/root/scene_switcher").goto_scene("res://scenes/main_menu.scn")
	
