extends CharacterBody2D
class_name BaseCharacter

var _has_sword: bool = false
var _on_floor: bool = true
var _jump_count: int = 0
var _attack_index: int = 1

@export_category("Variables")
@export var _speed: float = 150.0
@export var _jump_speed: float = -300.0

@export_category("Objects")
@export var _character_texture: CharacterTexture
@export var _attack_combo: Timer

func _physics_process(_delta: float) -> void:
	_vertical_movement(_delta)
	_horizontal_movement()
	_attack_handler()

	move_and_slide()
	_character_texture.animate(velocity)

func _vertical_movement(_delta: float) -> void:
	
		if is_on_floor():
			if _on_floor == false:
				global.spawn_effect("res://visual_effects/dust_particles/fall/fall_effect.tscn",
					Vector2(0, 2), global_position, false)
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
			global.spawn_effect("res://visual_effects/dust_particles/jump/jump_effect.tscn",
				Vector2(0, 2), global_position, _character_texture.flip_h)

func _horizontal_movement() -> void:
	var _direction := Input.get_axis("move_left", "move_right")
	if _direction:
		velocity.x = _direction * _speed
		return
	velocity.x = move_toward(velocity.x, 0, _speed)

func _attack_handler() -> void:
	if not _has_sword:
		return
	if Input.is_action_just_pressed("attack"):
		_character_texture.action_animation("attack_" + str(_attack_index))
		set_physics_process(false)
		_attack_combo.start()
		_attack_index += 1
		if _attack_index == 4:
			_attack_index = 1

func update_sword_state(_state: bool) -> void:
	_has_sword = _state
	_character_texture.update_suffix(_has_sword)

func _on_attack_combo_timeout() -> void:
	_attack_index = 1
