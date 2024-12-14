extends StateNode

var _player: Player


func _register() -> void:
	if owner is Player:
		_player = owner
	else:
		queue_free()
	pass


func _enter() -> void:
	_player.jump()
	pass


func _physics_update(delta: float) -> void:
	if _player.velocity.y >= 0:
		state_machine.change_state("fall")
	
	var speed := _player.move_motion.x * _player.speed
	_player.move_horizontal(speed)
	_player.fall()
	pass
