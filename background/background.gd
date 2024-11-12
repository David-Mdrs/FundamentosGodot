extends ParallaxBackground

class_name Background

@onready var _clouds: Array = [
$CloudT1, $CloudT2, $CloudT3, $CloudT4,
$CloudT5, $CloudT6, $CloudT7, $CloudT8,
$CloudT9
]

func _physics_process(_delta: float) -> void:
	var _i: int = 0
	for cloud in _clouds:
		cloud.motion_offset.x -= 10 * _delta
		_i += 1
	pass
