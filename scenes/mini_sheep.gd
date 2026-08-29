extends CharacterBody2D

@export var speed = 100

@export var max_y = 600
@export var max_x = 600

var target
var rng = RandomNumberGenerator.new()
var is_hovered = false

func _ready() -> void:
	target = get_random_location()
	
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("drag") && is_hovered):
		print("open sheep")

func _physics_process(_delta):
	self.velocity = global_position.direction_to(target) * speed
	if global_position.distance_to(target) > 10:
		move_and_slide()
	else:
		target = get_random_location()

func get_random_location():
	return Vector2(rng.randf_range(0, max_x),rng.randf_range(0, max_y))


func _on_area_2d_mouse_entered() -> void:
	is_hovered = true


func _on_area_2d_mouse_exited() -> void:
	is_hovered = false
