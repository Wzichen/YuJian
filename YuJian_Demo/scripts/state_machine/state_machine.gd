## 状态机节点，管理角色状态的执行与切换。
class_name StateMachine extends Node

## 当前运行状态即将发生改变时发出
signal state_changing(new_state: StringName)

## 当前运行状态发生改变后发出
signal state_changed(new_state: StringName)

## 当前生效的状态的名称
var current_state_name: StringName:
	get:
		return _current_state.state_name

## 当前状态机下的所有状态节点
var _states: Array[StateNode] = []
var _current_state: StateNode


func _ready() -> void:
	# 获取到所有可用的状态节点
	for state in get_children():
		if state is StateNode:
			state.state_machine = self
			state._register()
			_states.append(state)
	
	if _states.size() > 0:
		# 默认将第一个获取到的状态作为初始状态
		_current_state = _states[0]
		_current_state._enter()
	else:
		push_warning("状态机未获取到任何状态节点！")
	pass


func _process(delta: float) -> void:
	if _current_state != null:
		_current_state._update(delta)
	pass



func _physics_process(delta: float) -> void:
	if _current_state != null:
		_current_state._physics_update(delta)
	pass


## 改变当前活动状态
func change_state(new_state: StringName) -> void:
	if new_state == current_state_name:
		return
	
	state_changing.emit(new_state)
	
	# 退出旧状态，进入新状态
	for state in _states:
		if state.state_name == new_state:
			_current_state._exit()
			_current_state = state
			_current_state._enter()
			
			state_changed.emit(new_state)
			return
	
	# 运行到此处说明状态机中不存在传入的状态名称，什么都不会发生
	printerr("状态机中不存在状态: " + new_state)
	pass
