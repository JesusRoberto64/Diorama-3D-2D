extends Node3D

@onready var ray_cast = $RayCast3D
@onready var camera = $Camera3D

var ray : Vector3

func _ready():
	ray_cast.position = camera.position
	ray = -camera.position.normalized() * ray_cast.position.distance_to(Vector3.ZERO)

func _process(delta) -> void:
	if Input.is_action_pressed("cam_rotate_L"):
		rotation.y += delta
	elif Input.is_action_pressed("cam_rotate_R"):
		rotation.y -= delta
	
	# Direccion
	
	ray_cast.target_position = ray
	
	if !ray_cast.is_colliding():
		camera.set_cull_mask_value(2, false)
	else:
		camera.set_cull_mask_value(2, true)
