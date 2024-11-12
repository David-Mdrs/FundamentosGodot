extends Area2D
class_name ColletableComponent

func _on_body_entered(_body: Node2D) -> void:
	if _body is BaseCharacter:
		_consume(_body)
		queue_free()

func _consume(_body: BaseCharacter) -> void:
	pass
