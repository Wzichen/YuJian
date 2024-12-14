extends StateNode

var _player: Player


func _register() -> void:
	if owner is Player:
		_player = owner
	else:
		queue_free()
	pass


func _update(delta: float) -> void:
	pass


func _physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("jump")
	
	var motion := _player.move_motion * _player.speed
	_player.move_to(motion)
	pass
