extends StateNode

@onready var sword_snap_area: Area2D = %SwordSnapArea

var _player: Player


func _register() -> void:
	if owner is Player:
		_player = owner
	else:
		queue_free()
	pass


func _enter() -> void:
	sword_snap_area.area_entered.connect(_on_sword_snap_area_entered)
	pass


func _physics_update(_delta: float) -> void:
	if _player.is_on_sword():
		state_machine.change_state("riding_sword")
	
	var speed := _player.move_motion.x * _player.speed
	_player.move_horizontal(speed)
	_player.fall()
	pass


func _exit() -> void:
	sword_snap_area.area_entered.disconnect(_on_sword_snap_area_entered)
	pass


func _on_sword_snap_area_entered(area: Area2D) -> void:
	if area is Sword:
		_player.equip_sword(area)
	pass
