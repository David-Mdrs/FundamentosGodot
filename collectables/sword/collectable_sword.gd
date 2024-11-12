extends ColletableComponent
class_name ColletableSword

func _consume(_body: BaseCharacter) -> void:
	_body.update_sword_state(true)
