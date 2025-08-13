extends Node3D

@onready var player: CharacterBody3D = $Player3D
@onready var NPC: CharacterBody3D = $NPC_follower
@onready var npc_spr : AnimatedSprite2D = $NPC_follower/NPCViewport/npc

# Follow system
var trail_positions: Array = []
var save_interval = 0.0
var max_position = 5

var timer = 0.0
var follow_index = 1
var npc_speed : float = 0.0
var max_speed := 1.8

func _process(delta) -> void:
	if timer < 0.0:
		trail_positions.push_front(player.global_transform.origin)
		if trail_positions.size() > max_position:
			trail_positions.pop_back()
		timer = save_interval # Resetear el timer
	else:
		timer -= delta
	
	pass

func _physics_process(delta) -> void:
	# Move NPC
	if trail_positions.size() > follow_index:
		
		pass
	var target_pos = player.global_position#trail_positions[follow_index]
	var direction : Vector3 = (target_pos - NPC.global_position).normalized()
	
	
	if NPC.global_position.distance_to(target_pos) > 0.3:
		npc_speed = lerpf(npc_speed, max_speed, delta*10.0)
	else:
		npc_speed = lerpf(npc_speed, 0.0, delta)
		direction = direction.move_toward(Vector3.ZERO,delta *80.0)
	
	NPC.velocity = Vector3(direction.x, 0.0, direction.z) * npc_speed
	# Gravity
	if !NPC.is_on_floor():
		NPC.velocity.y -= 6.3
	NPC.move_and_slide()
	
	# Anim
	npc_spr.mov = Vector2(direction.x, direction.z)
	
