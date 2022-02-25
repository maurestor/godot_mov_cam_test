extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var _mouse_sensitivity := 0.08
export var _move_speed := 4.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event) -> void:
	_aim(event)

func _physics_process(delta):
	movement()


# declara la funcionn aim como una funcion priv con e.inputevent...
func _aim(event: InputEvent) -> void:
	var mouse_motion = event as InputEventMouseMotion
	if mouse_motion:
		rotation_degrees.y -= mouse_motion.relative.x * _mouse_sensitivity
		
		var tildeo_actual: float = $Camera.rotation_degrees.x
		tildeo_actual -= mouse_motion.relative.y * _mouse_sensitivity
		
		$Camera.rotation_degrees.x = clamp(tildeo_actual, -90, 90)
		#print(mouse_motion.relative.x)


func movement():
	var movement_vector: Vector3
	var forward_vector: Vector3
	var sideways_movement: Vector3
	
	
	# Check transform.basis.z please
	if Input.is_action_pressed("move_forward"):
		forward_vector -= transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		forward_vector += transform.basis.z
	if Input.is_action_pressed("move_left"):
		sideways_movement -= transform.basis.x
	elif Input.is_action_pressed("move_right"):
		sideways_movement += transform.basis.x

	movement_vector = forward_vector + sideways_movement
	movement_vector = movement_vector.normalized()
	
	move_and_slide(movement_vector * _move_speed)
