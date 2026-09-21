extends CharacterBody2D

@export var speed := 120.0

var player


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player:
		var direction = sign(player.global_position.x - global_position.x)
		velocity.x = direction * speed

	move_and_slide()

	# Freeze player when touching them
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body.has_method("die"):
			body.die()


func hit_by_rock():
	var main = get_tree().current_scene

	if main.has_method("add_score"):
		main.add_score(1)

	queue_free()
