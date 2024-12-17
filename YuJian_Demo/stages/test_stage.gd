extends Node

@export var background_rolling_speed: float = 100

@onready var background: ParallaxBackground = %Background
@onready var dialog_manager: DialogManager = %DialogManager
@onready var player: Player = %Player

var _dialog: Dialog = preload("res://resources/dialog/dialog_01.tres")


func _ready() -> void:
	dialog_manager.start_dialog(_dialog)
	pass


func _process(delta: float) -> void:
	background.scroll_offset.x -= background_rolling_speed * delta
	pass


func _on_dialog_manager_dialog_started() -> void:
	player.can_move = false
	pass


func _on_dialog_manager_dialog_ended() -> void:
	player.can_move = true
	pass
