extends AnimatedSprite2D

@onready var score = get_node("../score")
@onready var character = get_parent().get_parent()

var flow_points := 0
var last_checked:= -1
var is_flowing:= false

func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	
	if flow_points >= 5 and Input.is_action_just_pressed("Activate_flow"):
		is_flowing = true
	
		flow_points = 0
		frame = flow_points
		
		character.SPEED = 500
		await get_tree().create_timer(1.5).timeout
		character.SPEED = 250
		is_flowing = false

	elif !is_flowing and score.score_points != 0 and score.score_points != last_checked:
		
		print(score.score_points)
		flow_points += 1
		frame = flow_points
			
		last_checked = score.score_points
		
