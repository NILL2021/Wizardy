extends Control

func _gui_input(event):
   if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
	   get_tree().quit()
