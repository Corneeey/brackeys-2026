extends CharacterBody2D

signal open_sheep

const CLEAN_TEXTURE = preload("uid://b40ol8r770x4i")

@export var speed = 100

var roaming_area: Rect2

var target
var rng = RandomNumberGenerator.new()
var is_hovered = false
var already_cared_for = false

@onready var sprite = $Area2D/CollisionShape2D/Sprite2D

func _ready() -> void:
	global_position = get_random_location()
	target = get_random_location()
	
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("drag") 
			&& is_hovered 
			&& !already_cared_for):
				_open_sheep()

func _open_sheep() -> void:
	if(!SheepManager.is_sheep_minigame_open):
		open_sheep.emit()
		clean_sheep()


func clean_sheep() -> void:
		already_cared_for = true
		sprite.texture = CLEAN_TEXTURE

func _physics_process(_delta):	
	self.velocity = global_position.direction_to(target) * speed
	
	if global_position.distance_to(target) > 10:
		var vel: Vector2 = velocity
		rotation = vel.angle() + PI
		
		move_and_slide()
	else:
		target = get_random_location()

func get_random_location():
	return Vector2(
		rng.randf_range(roaming_area.position.x, roaming_area.end.x),
		rng.randf_range(roaming_area.position.y, roaming_area.end.y)
		)

func _on_area_2d_mouse_entered() -> void:
	is_hovered = true

func _on_area_2d_mouse_exited() -> void:
	is_hovered = false
