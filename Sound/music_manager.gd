extends Node

@onready var normal_music: AudioStreamPlayer = $NormalMusic
@onready var chase_music: AudioStreamPlayer = $ChaseMusic

func play_normal():
	chase_music.stop()
	normal_music.play()
	
func play_chase():
	normal_music.stop()
	chase_music.play()
