class_name Sword extends Area2D

## 剑的跟随模式
enum FollowingMode {
	## 不跟随任何角色，原地静止
	UNFOLLOW,
	
	## 跟随角色，且位置始终在角色脚下
	UNDER_FEET,
	
	## 跟随角色，位置在角色身后
	BEHIND
}

## 剑的当前跟随模式
var following_mode: FollowingMode = FollowingMode.UNFOLLOW

## 当前的剑所跟随的角色
var master: Player


func _process(_delta: float) -> void:
	match following_mode:
		FollowingMode.UNDER_FEET:
			global_position = master.global_position
	pass


## 开始跟随角色
func start_follow(player: Player) -> void:
	master = player
	following_mode = FollowingMode.UNDER_FEET
	pass


## 结束跟随角色
func end_follow() -> void:
	following_mode = FollowingMode.UNFOLLOW
