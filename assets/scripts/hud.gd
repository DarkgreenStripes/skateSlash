extends CanvasLayer
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_message("SKATE SLASH")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$Message.text = text
	$Message.show()

func game_over_message():
	$Message.text = "BOOYAAAAA"
	$Message.show()

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$Message.hide()
	
	start_game.emit()
