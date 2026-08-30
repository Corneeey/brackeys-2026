extends CharacterBody2D

func _ready() -> void:
	get_tree().create_timer(0.25).timeout.connect(queue_free)
