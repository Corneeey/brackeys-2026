extends CharacterBody2D

signal open_sheep

const CLEAN_TEXTURE = preload("uid://b40ol8r770x4i")

@export var speed = 100

var roaming_area: Rect2

var target : Vector2 = Vector2(0,0)
var rng = RandomNumberGenerator.new()
var is_hovered = false
var already_cared_for = false
var is_ready = false
var is_evil = true

var last_location
var start_location

@onready var sprite = $Area2D/CollisionShape2D/Sprite2D

func _ready() -> void:
	start_location = position
	last_location = position
	target = get_random_location()
	print("Sheep ready at: ", position, " Target: ", target)
	
	is_ready = true
	
func _process(delta: float) -> void:
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
	if !is_ready:
		return
	
	is_evil = position.y < 0
	
	if(is_evil):
		print("Position is evil ", position)
		position = start_location
		print("Set position to start ", position)
		if(target == Vector2(0,0)):
			target = get_random_location()
			print("sent sheep to", target)
		return
	
	self.velocity = position.direction_to(target).normalized() * speed
	if position.distance_to(target) > 10:
		var vel: Vector2 = velocity
		rotation = vel.angle() + PI
		
		move_and_slide()
		if get_slide_collision_count() > 0:
			#print("collision: change target ", self.name)
			target = get_random_location()
	else:
		#print("reached target: change target", self.name)
		target = get_random_location()
		last_location = position
		
func get_random_location():
	return Vector2(
		rng.randf_range(max(0, roaming_area.position.x), max(0, roaming_area.end.x)),
		rng.randf_range(max(0, roaming_area.position.y), max(0, roaming_area.end.y)))

func _on_area_2d_mouse_entered() -> void:
	is_hovered = true

func _on_area_2d_mouse_exited() -> void:
	is_hovered = false
