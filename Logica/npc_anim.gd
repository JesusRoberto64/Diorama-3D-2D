extends AnimatedSprite2D

var direction : Vector2 = Vector2.DOWN
var mov : Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	var input_mov = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_mov != Vector2.ZERO:
		mov = input_mov
	else:
		mov = mov
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
