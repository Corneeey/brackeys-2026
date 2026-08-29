class_name DialogueAudio extends AudioStreamPlayer

@export var sound_bites: Array[AudioStream]
@export_range(0.0, 1.0, 0.01) var talking_speed: float = 0.2

var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = talking_speed
	timer.one_shot = true
	add_child(timer)
	timer.start()

func play_audio() -> void:
	if (timer.time_left == 0):
		stream = _get_random_sound_bite()
		timer.start()
		play()

func _get_random_sound_bite() -> AudioStream:
	return sound_bites.pick_random()
