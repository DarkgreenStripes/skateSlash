extends Label

var score_points: int = 0

func _ready() -> void:
	text = "Score: "+str(score_points)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		score_points += 1
	text = "Score: "+str(score_points)
 
