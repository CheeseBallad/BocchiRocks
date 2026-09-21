extends Node2D

const GUITAR_SCENE = preload("res://guitar.tscn")

@onready var left_spawn = $LeftSpawn
@onready var right_spawn = $RightSpawn
@onready var timer = $Timer


func _ready():
	timer.timeout.connect(_spawn_guitar)

	timer.wait_time = 3.0
	timer.start()

	# Spawn one immediately for testing
	_spawn_guitar()


func _spawn_guitar():
	var guitar = GUITAR_SCENE.instantiate()

	if randi() % 2 == 0:
		guitar.global_position = left_spawn.global_position
	else:
		guitar.global_position = right_spawn.global_position

	get_tree().current_scene.add_child(guitar)

	print("Guitar spawned at: ", guitar.global_position)
