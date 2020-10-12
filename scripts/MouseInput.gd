extends Area2D

export var particle_speed : float = 0.1

onready var particles : Node = get_node("../Viewport/CPUParticles2D")

var _old_mouse_pos : Vector2
var _e_v : Vector2 = Vector2(0.0, 0.0)

func _on_input_event(viewport : Node, event : InputEvent, shape_idx : int):
	if event is InputEventMouseButton:
		if event.pressed:
			particles.emitting = true
			_old_mouse_pos = get_local_mouse_position() - get_viewport_rect().size / 2.0
		else:
			particles.emitting = false

func _physics_process(delta : float):
	var mouse_pos : Vector2 = get_local_mouse_position() - get_viewport_rect().size / 2.0
	var v : Vector2 = (mouse_pos - _old_mouse_pos)
	_e_v = lerp(_e_v, v, 0.5)
	var s : float = _e_v.length() / delta
	if particles.emitting:
		particles.emission_points[0] = mouse_pos
		particles.emission_normals[0] = _e_v.normalized()
		particles.initial_velocity = particle_speed * s
		particles.tangential_accel = (randf() - 0.5) * 10.0

	_old_mouse_pos = mouse_pos