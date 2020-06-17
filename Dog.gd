extends Sprite


var desired_pos = null

var mouse_inside = false


var follow = false



func _physics_process(delta):
	if desired_pos != null:
		if desired_pos.distance_to(global_position) > 1:
			global_position = (global_position*4.0 + desired_pos)/5.0
		
			
	if mouse_inside and Input.is_action_just_pressed("click"):
		follow = true
	
	if Input.is_action_just_released("click"):
		follow = false	
	
	if follow and Input.is_action_pressed("click"):
		desired_pos = get_global_mouse_position()


func load_position(pos):
	#print("pawn: ",name," received: ",pos)
	desired_pos = pos


func _on_Area2D2_mouse_exited():
	mouse_inside = false



func _on_Area2D2_mouse_entered():
	mouse_inside = true

