extends RigidBody2D

var damage_taken_m:= 0
var damage_dealt_m:= 10
var health:= 100

@onready var character = get_node("../player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("run")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
