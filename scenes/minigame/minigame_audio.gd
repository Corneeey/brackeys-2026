class_name MinigameAudio extends AudioStreamPlayer

enum AudioEvent {
	BRUSHED,
	CARROT_FED,
	PETTED
	}

@export var audio_bundles: Dictionary[AudioEvent, AudioBundle] = {}

func play_audio(audio_event: AudioEvent) -> void:
	if playing:
		return
	
	stream = _get_sound_bite(audio_event)
	play()

func _get_sound_bite(audio_event: AudioEvent) -> AudioStream:
	return audio_bundles[audio_event].sound_bites.pick_random()
