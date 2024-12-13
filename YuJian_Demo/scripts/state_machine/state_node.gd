## 单个状态的基本运行单位，继承此类来实现状态的逻辑
## 注意：只有将状态节点作为状态机的字节点才会生效！
class_name StateNode extends Node

## 当前状态的名称
@export var state_name: StringName = &"default"

## 当前状态节点所属的状态机
var state_machine: StateMachine


## 状态节点第一次注册进状态机时调用
func _register() -> void:
	pass


## 状态节点开始生效时调用
func _enter() -> void:
	pass


## 状态节点生效后每个逻辑帧调用
@warning_ignore("unused_parameter")
func _update(delta: float) -> void:
	pass


## 状态节点生效后每个物理帧调用
@warning_ignore("unused_parameter")
func _physics_update(delta: float) -> void:
	pass


## 状态节点切换到其它状态后，当前状态准备失效时调用
func _exit() -> void:
	pass
