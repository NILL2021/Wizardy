extends KinematicBody

var mouse_sensitivity = 0.13
var speed = 10
var direction = Vector3()
var h_acceleration = 6
var h_velocity = Vector3()
var movement = Vector3()
var gravity = 20
var jump = 8
var gravity_vec = Vector3()
var full_contact = false
var normal_acceleration = 6
var air_acceleration = 1
var zoom_out = false
var zoom_enabled  = false

onready var head = $Head
onready var ground_check = $RayCast
onready var camera = $Head/Camera
onready var vars_show = $Label2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))






func _physics_process(delta):
	vars_show.text = "movement: " + str(movement) + "\ndirection: " + str(direction) + "\nspeed: " + str(speed) + "\ngravity vector: " + str(gravity_vec) + "\nh_vel: " + str(h_velocity) + "\nh_accel: " + str(h_acceleration) + "\nmouse_sensitivity: " + str(mouse_sensitivity)
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	direction = Vector3()
	
	if ground_check.is_colliding():
		full_contact = true
	else:
		full_contact = false
	
	if not is_on_floor():
		gravity_vec += Vector3.DOWN * gravity * delta
		h_acceleration = air_acceleration
	elif is_on_floor() and full_contact:
		gravity_vec = -get_floor_normal() * gravity
		h_acceleration = normal_acceleration
	else:
		gravity_vec = -get_floor_normal()
		h_acceleration = normal_acceleration
		
	if Input.is_action_pressed("jump") and (is_on_floor() or ground_check.is_colliding()):
		gravity_vec = Vector3.UP * jump
		
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	elif Input.is_action_pressed("move_back"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	direction = direction.normalized()
	h_velocity = h_velocity.linear_interpolate(direction * speed, h_acceleration * delta)
	movement.z = h_velocity.z + gravity_vec.z
	movement.x = h_velocity.x + gravity_vec.x
	movement.y = gravity_vec.y
	
	move_and_slide(movement, Vector3.UP)
	


