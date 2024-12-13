class_name Player extends CharacterBody2D

## 角色所受到的重力
@export_group("基础属性")
@export var speed: float = 400

@export var gravity: float = 1000

## 角色的最大下落速度
@export var max_falling_speed: float = 1000

## 角色的跳跃力度
@export var jump_force: float = 500

## 角色的横向移动方向
var move_motion: Vector2 = Vector2.ZERO

## 角色当前是否站在剑上
var is_on_sword: bool = false

## 角色当前使用的剑
var equipping_sword: Sword


func _process(_delta: float) -> void:
	move_motion = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_motion.y *= 0.7
	pass


func _physics_process(delta: float) -> void:
	if not is_on_sword and not is_on_floor() :
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_falling_speed)
		velocity.x = move_motion.x * speed
	elif is_on_sword:
		equipping_sword.move_to(move_motion, speed)
		velocity.y = equipping_sword.velocity.y
		global_position.x = equipping_sword.global_position.x
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	
	move_and_slide()
	pass


## 使角色跳跃
func jump() -> void:
	is_on_sword = false
	velocity.y = -jump_force
	pass


func _on_sword_snap_area_entered(area: Area2D) -> void:
	var sword := area.owner
	if sword is Sword:
		equipping_sword = sword
		is_on_sword = true
		
		sword.player = self
		global_position = sword.global_position
	pass


func _on_sword_snap_area_exited(area: Area2D) -> void:
	if area.owner is Sword:
		equipping_sword.velocity = Vector2.ZERO
		equipping_sword = null
		is_on_sword = false
	pass
