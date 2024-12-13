class_name Sword extends CharacterBody2D

## 使用该剑的玩家
var player: Player


func _physics_process(delta: float) -> void:
	move_and_slide()
	pass


func following_player() -> void:
	velocity = player.velocity
	pass


func move_to(motion: Vector2, speed: float) -> void:
	velocity = motion * speed
	pass
