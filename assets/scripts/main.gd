extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_game_over() -> void:
	$HUD.game_over_message()
	$player.set_physics_process(false)
	$player.damage_dealt_p = 0
	get_tree().call_group("mobs", "set_physics_process", false)
	get_tree().set_group("mobs", "damage_taken_m", 0)
	
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()

func _on_end_point_end() -> void:
	$HUD.show_message("YAYY YOU ARRIVED")
	$player.set_physics_process(false)
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

func _on_hud_start_game() -> void:
	get_tree().paused = false
