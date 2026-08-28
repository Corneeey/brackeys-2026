extends Area2D

var is_getting_cleaned = false
var dirt_alpha = 1

func _mouse_enter() -> void:
	is_getting_cleaned = true
	
func _mouse_exit() -> void:
	is_getting_cleaned = false

func _process(_delta: float) -> void:
	if(is_getting_cleaned):
		print("dirt is getting cleaned")
		self.modulate = Color(self.modulate, dirt_alpha)
		dirt_alpha -= 0.008
	
	if(dirt_alpha < 0.1):
		self.visible = false
