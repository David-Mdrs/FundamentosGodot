extends CharacterBody2D
class_name BaseCharacter

var _has_sword: bool = false
var _on_floor: bool = true
var _jump_count: int = 0

@export_category("Variables")
@export var _speed: float = 150.0
@export var _jump_speed: float = -300.0

@export_category("Objects")
@export var _character_texture: CharacterTexture

func _physics_process(_delta: float) -> void:
	_vertical_movement(_delta)
	_horizontal_movement()

	move_and_slide()
	_character_texture.animate(velocity)

func _vertical_movement(_delta: float) -> void:
	
		if is_on_floor():
			if _on_floor == false:
				_character_texture.action_animation("land")
				set_physics_process(false)
				_on_floor = true
			_jump_count = 0
			
		if not is_on_floor():
			_on_floor = false
			velocity += get_gravity() * _delta

		if Input.is_action_just_pressed("move_jump") and _jump_count < 2:
			_jump_count += 1
			velocity.y = _jump_speed

func _horizontal_movement() -> void:
	var _direction := Input.get_axis("move_left", "move_right")
	if _direction:
		velocity.x = _direction * _speed
		return
	velocity.x = move_toward(velocity.x, 0, _speed)

func update_sword_state(_state: bool) -> void:
	_has_sword = _state
	_character_texture.update_suffix(_has_sword)
