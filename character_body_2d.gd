extends CharacterBody2D

@export var speed := 300.0
const ROCK_SCENE = preload("res://rock.tscn")
@export var freeze_time := 1.5

@onready var anim = $AnimatedSprite2D
@onready var shoot_point = $ShootPoint

const JUMP_VELOCITY = -400.0

var facing_direction := 1.0
var frozen := false

var is_dead := false


func _physics_process(delta: float) -> void:

	if frozen:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement
	var direction := Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * speed

		anim.play("walk")
		anim.flip_h = direction < 0

		facing_direction = direction

	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		anim.play("idle")

	# Shoot
	if Input.is_action_just_pressed("shoot"):
		shoot()

	move_and_slide()


func shoot():
	var rock = ROCK_SCENE.instantiate()

	rock.global_position = shoot_point.global_position
	rock.direction = facing_direction

	get_tree().current_scene.add_child(rock)


func die():
	if is_dead:
		return

	is_dead = true
	call_deferred("restart_game")


func restart_game():
	get_tree().reload_current_scene()
