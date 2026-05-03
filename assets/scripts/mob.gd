extends RigidBody2D
signal hit

@export var health_m:= 100
@export var damage_dealt_m:= 50

@onready var player = get_node("../player")
@onready var damage_taken_m = player.damage_dealt_p

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("run")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	on_death_mob()
	


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

func on_death_mob():
	if health_m <= 0:
		queue_free()
