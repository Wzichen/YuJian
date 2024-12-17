class_name Player extends CharacterBody2D

@export_group("基础属性")
## 角色的移动速度
@export var speed: float = 400

## 角色的移动平滑度
@export var moving_smooth: float = 100

## 角色所受到的重力
@export var gravity: float = 1200

## 角色的最大下落速度
@export var max_falling_speed: float = 1000

## 角色的跳跃力度
@export var jump_force: float = 800

## 角色的移动方向
var move_motion: Vector2 = Vector2.ZERO

## 角色当前是否可移动
var can_move: bool = true

## 角色当前装备的剑
var equipping_sword: Sword

var _process_delta: float
var _physics_delta: float


func _process(delta: float) -> void:
	_process_delta = delta
	
	if can_move:
		move_motion = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		move_motion.y *= 0.7
	else:
		move_motion = Vector2.ZERO
	pass


func _physics_process(delta: float) -> void:
	_physics_delta = delta
	# 角色节点本身只需要确保移动动作能顺利执行就好，具体执行移动的动作交由状态机来做
	move_and_slide()
	pass


## 操控角色沿着指定方向移动（角色在剑上时使用）
func move_to(motion: Vector2) -> void:
	var target_velocity = velocity.lerp(motion, exp(-moving_smooth * _physics_delta))
	if not target_velocity.is_equal_approx(velocity):
		velocity = target_velocity
	pass


## 操控角色水平移动（角色会受到重力影响时使用）
func move_horizontal(horizon_speed: float) -> void:
	var target_speed = lerpf(velocity.x, horizon_speed, exp(-moving_smooth * _physics_delta))
	if not is_equal_approx(velocity.x, target_speed):
		velocity.x = target_speed
	pass


## 操控角色跳跃（只有当角色站在地面或剑上时才会生效）
func jump() -> void:
	if can_move and (is_on_floor() or is_on_sword()):
		unequip_sword()
		velocity.y = -jump_force
	pass


## 操控角色下落
func fall() -> void:
	if not is_on_floor() and not is_on_sword():
		velocity.y += gravity * _physics_delta
		velocity.y = min(velocity.y, max_falling_speed)
	pass


## 装备给定的剑
func equip_sword(sword: Sword) -> void:
	if equipping_sword != sword:
		equipping_sword = sword
		global_position = equipping_sword.global_position
		equipping_sword.start_follow(self)
	pass


## 卸下已有的剑
func unequip_sword() -> void:
	if equipping_sword != null:
		equipping_sword.end_follow()
		equipping_sword = null
	pass

## 当前角色是否站在剑上
func is_on_sword() -> bool:
	return equipping_sword != null
