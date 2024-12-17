class_name DialogManager extends CanvasLayer

## 当对话开始时发出
signal dialog_started

## 当对话结束时发出
signal dialog_ended

@onready var portrait_rect: TextureRect = %PortraitRect
@onready var name_label: Label = %NameLabel
@onready var content_label: Label = %ContentLabel

var _dialogs: Array[DialogUnit]
var _index: int = 0
var _is_talking: bool = false


func _ready() -> void:
	hide()
	pass


func _input(event: InputEvent) -> void:
	if _dialogs.size() == 0:
		return
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_display_next_dialog()
		
	elif event is InputEventKey and event.keycode == KEY_ENTER:
		_display_next_dialog()
	pass


## 开启对话
func start_dialog(dialog: Dialog) -> void:
	show()
	_dialogs = dialog.dialog_list
	_index = 0
	dialog_started.emit()
	_display_next_dialog()
	pass


## 结束对话
func end_dialog() -> void:
	hide()
	_dialogs = []
	dialog_ended.emit()
	pass


func _display_next_dialog() -> void:
	if _dialogs == null or _is_talking:
		return
	
	if _index >= _dialogs.size():
		end_dialog()
		return
	
	_is_talking = true
	
	name_label.text = _dialogs[_index].role_name
	portrait_rect.texture = _dialogs[_index].portrait

	var content := _dialogs[_index].content
	var current_content := ""
	for character in content:
		current_content += character
		content_label.text = current_content
		await get_tree().create_timer(0.1).timeout
	
	_index += 1
	_is_talking = false
	pass
