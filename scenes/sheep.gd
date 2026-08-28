extends Sprite2D

var is_in_hover = false 
var time_cared_for_sheep = 0.0
var sheep_care = 0.0

@onready var dirt = $Dirt

func _on_dirt_mouse_entered() -> void:
	sheep_care += 10
	dirt.visible = false

func _on_sheep_body_mouse_entered() -> void:
	is_in_hover = true


func _on_sheep_body_mouse_exited() -> void:
	is_in_hover = false

func _process(delta: float) -> void:
	if(is_in_hover):
		time_cared_for_sheep += delta
		print(time_cared_for_sheep)
