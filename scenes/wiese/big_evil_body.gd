extends CharacterBody2D

func _ready() -> void:
	get_tree().create_timer(0.1).timeout.connect(queue_free)
