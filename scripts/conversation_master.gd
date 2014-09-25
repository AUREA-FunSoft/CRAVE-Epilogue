
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
export var code = "default"

var conversation_file
var name_text
var name_bg
var dialog_text
var dialog_bg
var lets_next
var screen_size 

#typewriter
var char_count
var writing
var chars
var elapsed
var timeout

func _ready():
	screen_size = OS.get_video_mode_size()
	conversation_file = File.new()
	conversation_file.open("res://assets/texts/"+code+".dialog", File.READ)
	name_bg = get_node("NameBG")
	name_text = get_node("NameText")
	dialog_bg = get_node("DialogBG")
	dialog_text = get_node("DialogText")
	lets_next = false
	writing = false
	elapsed = 0
	timeout = 0.1
	reScaleNodes()
	setDialog()
	

func _process(delta):
	elapsed = elapsed + delta
	if elapsed > timeout:
		dialog_text.set_visible_characters(chars)
		elapsed = 0
		chars = chars + 1
		if chars == char_count+1:
			set_process(false)
			writing = false

func reScaleNodes():
	var BGsize = dialog_bg.get_texture().get_size()
	var dialogResizedSize = Vector2(screen_size.width - 20, screen_size.height / 5)
	var dialogScale = dialogResizedSize/BGsize
	dialog_bg.set_scale(dialogScale)
	dialog_bg.set_pos(Vector2(10, (4 * dialogResizedSize.height) - 10))
	dialog_text.set_size(dialogResizedSize - Vector2(20,20))
	dialog_text.set_pos(dialog_bg.get_pos() + Vector2(10,10))
	var nameResizedSize = Vector2(screen_size.width / 5, screen_size.height / 20)
	var nameScale = nameResizedSize/BGsize
	name_bg.set_scale(nameScale)
	name_bg.set_pos(Vector2(10, dialog_bg.get_pos().y - nameResizedSize.y))
	name_text.set_size(nameResizedSize - Vector2(20,0))
	name_text.set_pos(name_bg.get_pos() + Vector2(10,10))
	

func setDialog():
	var text
	while text != ">":
		text = conversation_file.get_line()
		if conversation_file.eof_reached():
			lets_next = true
		else:
			var textStrings = text.split(":")
			if textStrings.size() > 1:
				if textStrings[0] == "b":
					#set background
					pass
				elif textStrings[0] == "c":
					name_text.set_text(textStrings[1])
				elif textStrings[0] == "p":
					setPosition(textStrings[1])
				elif textStrings[0] == "d":
					dialog_text.set_visible_characters(0)
					dialog_text.set_text(textStrings[1])
					char_count = dialog_text.get_total_character_count()
					chars = 0
					writing = true
					set_process(true)
	

func _on_Next_pressed():
	if writing:
		set_process(false)
		dialog_text.set_visible_characters(char_count)
		writing = false
	else:
		if !lets_next:
			setDialog()
		else:
			print("Next!!")

func setPosition(var pos):
	var nameBGPos = name_bg.get_pos()
	var nameTextPos = name_text.get_pos()
	if pos == "left":
		name_bg.set_pos(Vector2(10,nameBGPos.y))
		name_text.set_pos(Vector2(20,nameTextPos.y))
		name_text.set_align(Label.ALIGN_LEFT)
	elif pos == "right":
		name_bg.set_pos(Vector2((4*screen_size.width/5)-10,nameBGPos.y))
		name_text.set_pos(Vector2((4*screen_size.width/5),nameTextPos.y))
		name_text.set_align(Label.ALIGN_RIGHT)
	
	