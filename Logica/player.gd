extends AnimatedSprite2D

var accel = Vector2.ZERO
@export_range(0.0, 250.0) var velocity = 20.0
@export var MAX_ACCEL = 7.0
@export var releace_time = 0.25
var direction : Vector2 = Vector2.DOWN

func  _ready():
	speed_scale = 1.25

func _process(_delta: float) -> void:
	var mov = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	#if mov != Vector2.ZERO:
		##Cambiar la direccion de sprite
		#if mov.x != 0.0:
			#flip_h = false if mov.x < 0.0 else true
		#
		#accel += mov * velocity * delta
		#if accel.length() > MAX_ACCEL:
			#accel = accel.normalized() * MAX_ACCEL
		#
		#direction = mov
		#
	#else:
		#var decel_amout = (MAX_ACCEL / releace_time) * delta
		#accel = accel.move_toward(Vector2.ZERO, decel_amout)
	#
	#position += accel
	
	# ANIMATION
	
	var current_frame = get_frame()
	var current_progress = get_frame_progress()
	
	var anim_type 
	if mov != Vector2.ZERO:
		anim_type = "walk"
		direction = mov
		if mov.x != 0.0:
			flip_h = false if mov.x < 0.0 else true
	else:
		anim_type = "idle"
	
	match direction:
		Vector2.UP:
			play(anim_type + " backward")
		Vector2.DOWN:
			play(anim_type + " fordward")
		Vector2.RIGHT , Vector2.LEFT:
			play(anim_type + " side")
		_:
			# Direcciones diagonales
			if direction.dot(Vector2.UP) > 0.0:
				play(anim_type + " diagonal backward")
			elif direction.dot(Vector2.UP) < 0.0:
				play(anim_type + " diagonal fordward")
	
	set_frame_and_progress(current_frame, current_progress)
