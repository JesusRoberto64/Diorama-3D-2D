extends CharacterBody3D

var accel : Vector2 = Vector2.ZERO
@export_range(0.0, 250.0) var speed = 20.0
@export var MAX_ACCEL = 7.0
@export var releace_time = 0.25

var gravity: float = 6.3

func _process(delta: float) -> void:
	var mov = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var cam_basis = $CamAncher.basis
	# Rotate axis of input movement
	var rotate_mov = Vector2(
		cam_basis.x.x * mov.x + cam_basis.z.x * mov.y, # Componente X
		cam_basis.x.z * mov.x + cam_basis.z.z * mov.y # Componente Y
	)
	
	if mov != Vector2.ZERO:
		#Cambiar la direccion de sprite
		
		accel += rotate_mov * speed * delta
		if accel.length() > MAX_ACCEL:
			accel = accel.normalized() * MAX_ACCEL
	else:
		var decel_amout = (MAX_ACCEL / releace_time) * delta
		accel = accel.move_toward(Vector2.ZERO, decel_amout)
	
	velocity = Vector3(accel.x, 0.0, accel.y)
	
	if not is_on_floor():
		velocity.y -= gravity
	
	move_and_slide()
