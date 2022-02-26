extends KinematicBody2D
const GRAVITY = 200
const JUMP_POWER = 200
var SPEED = 200
var state = "idle"
var vel = Vector2.ZERO
func _physics_process(delta):
	vel.x = 0
	if is_on_floor() and not Input.is_action_pressed("ui_up"):
		vel.y = 0
		state = "idle"
		$Timer.stop()
		$Timer.wait_time = 2
	else:
		vel.y += GRAVITY * delta
	if Input.is_action_pressed("ui_left"):
		vel.x -= SPEED
		if is_on_floor() and state != "jumping":
			state = "left"
	if Input.is_action_pressed("ui_right"):
		vel.x += SPEED
		if is_on_floor() and state != "jumping":
			state = "right"
	move_and_slide(vel, Vector2.UP)
	if Input.is_action_pressed("ui_up") and is_on_floor(): #or double_jump == true
		vel.y -= JUMP_POWER
		state = "jumping"
	print(state)
	if not $RayCast2D.is_colliding():
		if state != "jumping":
			state = "falling"
