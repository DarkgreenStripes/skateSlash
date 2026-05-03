extends TextureProgressBar

@onready var player:= get_parent().get_parent()

func _ready() -> void:
	value = 100

func _process(delta: float) -> void:
	value = player.health_p
