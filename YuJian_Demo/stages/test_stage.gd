extends Node

@export var background_rolling_speed: float = 100

@onready var background: ParallaxBackground = %Background


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	background.scroll_offset.x -= background_rolling_speed * delta
	pass
