extends CharacterBody2D
signal hit
signal game_over

@export var health_p:= 100
@export var damage_dealt_p:= 10
var SPEED = 250.0
var JUMP_VELOCITY = -250.0
var spawn_point:= Vector2(0.0, -1.0) 

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
	on_death()

func _on_area_2d_body_entered(body: Node2D) -> void:
	health_p -= damage_taken_p
	if health_p <= 0:
		health_p = 0
	print(health_p)
	hit.emit()
	# disables collision
	$Area2D/hitbox.set_deferred("disabled", true)
	await get_tree().create_timer(1).timeout
	$Area2D/hitbox.set_deferred("disabled", false)
	
func on_death ():
	if health_p <= 0 or position.y >= 1000.0:
		game_over.emit()
		
	
	
