extends KinematicBody2D
var SPEED = 200
var vel = Vector2.ZERO
func _physics_process(_delta):
	vel.x = 0
	vel.y = 0
	if Input.is_action_pressed("ui_left"):
		vel.x -= SPEED
	if Input.is_action_pressed("ui_right"):
		vel.x += SPEED
	if Input.is_action_pressed("ui_down"):
		vel.y += SPEED
	if Input.is_action_pressed("ui_up"):
		vel.y -= SPEED
# warning-ignore:return_value_discarded
	move_and_slide(vel)
