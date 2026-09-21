extends Area2D

@export var speed := 500.0

var direction := 1.0


func _ready():
	body_entered.connect(_on_body_entered)

	await get_tree().create_timer(4.0).timeout

	if is_instance_valid(self):
		queue_free()


func _physics_process(delta):
	position.x += speed * direction * delta


func _on_body_entered(body):
	if body.has_method("hit_by_rock"):
		body.hit_by_rock()
		queue_free()
