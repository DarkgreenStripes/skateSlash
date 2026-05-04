extends CharacterBody2D
signal hit
signal detect

@export var health_m:= 100
@export var damage_dealt_m:= 50
@export var patrol_distance := 100
@export var speed:=25
@export var chase_speed := 150.0  # Faster when chasing!

var initial_pos:Vector2
var direction := -1 # -1 is left, 1 is right
var is_chasing := false

@onready var player = get_node("../player")
@onready var damage_taken_m = player.damage_dealt_p

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play("run")
	initial_pos = global_position # Grabs where the mob is placed in the level
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	on_death_mob()
	if is_chasing and player:
		if player.global_position.x > global_position.x:
			velocity.x = chase_speed
		else:
			velocity.x = -chase_speed
		
		$AnimatedSprite2D.flip_h = (velocity.x < 0)

	else:
		# Patrol logic only when NOT chasing
		if abs(position.x - initial_pos.x) > patrol_distance:
			direction = -direction 
			$AnimatedSprite2D.flip_h = (direction < 0)
		
		velocity.x = direction * speed
	move_and_slide()

func on_death_mob():
	if health_m <= 0:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	health_m -= damage_taken_m
	if health_m <= 0:
		health_m = 0
	print("Mob health ", health_m)
	hit.emit()
	# disables collision
	$Area2D/hitbox.set_deferred("disabled", true)
	await get_tree().create_timer(0.5).timeout
	$Area2D/hitbox.set_deferred("disabled", false)

func _on_detected(body: Node2D) -> void:
	if body.name == "player":
		detect.emit()
		is_chasing = true
func _no_detection(body: Node2D) -> void:
	if body.name == "player":
		is_chasing = false
