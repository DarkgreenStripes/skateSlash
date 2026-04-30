extends CharacterBody2D
signal hit


@export var health_p:= 100
@export var damage_dealt_p:= 50
var SPEED = 250.0
var JUMP_VELOCITY = -200.0

@onready var mob = get_node("../mob")
@onready var damage_taken_p = mob.damage_dealt_m

var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	velocity.x = SPEED

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	health_p -= damage_taken_p
	print(health_p)
	hit.emit()
	# disables collision
	$Area2D/body.set_deferred("disabled", true)
