extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _gui_input(event):
   if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
	   get_tree().change_scene("res://game.tscn")
