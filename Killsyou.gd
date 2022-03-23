extends StaticBody





func _on_Area_area_entered(area):
	if area.get_parent().is_in_group("player"):
		get_tree().change_scene("res://main.tscn")
	else:
		pass
