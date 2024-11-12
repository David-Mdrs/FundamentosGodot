extends AnimatedSprite2D
class_name CharacterTexture

var _suffix: String = ""
var _is_on_action: bool = false

func _verify_direction(_direction: float) -> void:
	if _direction > 0:
		flip_h = false
	if _direction < 0:
		flip_h = true

@export_category("Objetcs")
@export var _character: BaseCharacter

func animate(_velocity: Vector2) -> void:
	_verify_direction(_velocity.x)
	
	if _is_on_action:
		return
	
	if not _velocity:
		play("idle" +_suffix)
		return
		
	if _velocity.y:
		if _velocity.y > 0:
			play("fall" +_suffix)
		if _velocity.y < 0:
			play("jump" +_suffix)
		return
		
	if _velocity.x:
		play("run" +_suffix)
		return

# priority animations
func action_animation(_action_name: String) -> void:
	_is_on_action = true
	play(_action_name +_suffix)

func update_suffix(_state: bool) -> void:
	if _state:
		_suffix = "_with_sword"
		return
	_suffix = ""
		
func _on_animation_finished() -> void:
	_is_on_action = false
	_character.set_physics_process(true)