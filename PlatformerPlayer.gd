extends KinematicBody2D
const GRAVITY = 200
const JUMP_POWER = 200
var SPEED = 200
var state = "idle"
var is_dashing = false
var vel = Vector2.ZERO
onready var sprite = $Sprite
onready var tween = $Tween
var double_jump = false
onready var dash_length = $Timer
const DASH_SPEED = 250
var has_dashed = false
func _physics_process(delta):
	vel.x = 0
	if is_on_floor() and not Input.is_action_pressed("ui_up"):
		vel.y = 0
		state = "idle"
		is_dashing = false
		has_dashed = false
		double_jump = false
	else:
		vel.y += GRAVITY * delta
	if Input.is_action_just_pressed("Dash") and not is_on_floor() and has_dashed == false:
		if sprite.flip_h == true:
			is_dashing = true
			has_dashed = true
			tween.interpolate_property(self,"position",Vector2(position.x,position.y),Vector2(position.x - DASH_SPEED,position.y),.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			tween.start()
			dash_length.start()
			state = "dash"
		if sprite.flip_h == false:
			is_dashing = true
			has_dashed = true
			tween.interpolate_property(self,"position",Vector2(position.x,position.y),Vector2(position.x + DASH_SPEED,position.y),.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			tween.start()
			dash_length.start()
			state = "dash"
	if Input.is_action_pressed("ui_left"):
		vel.x -= SPEED
		if is_on_floor() and state != "jumping":
			state = "left"
	if Input.is_action_pressed("ui_right"):
		vel.x += SPEED
		if is_on_floor() and state != "jumping":
			state = "right"
	move_and_slide(vel, Vector2.UP)
	if Input.is_action_just_pressed("ui_up") and double_jump == true and is_dashing == false:
		vel.y = 0
		vel.y -= JUMP_POWER
		state = "double jump"
		double_jump = false
	if Input.is_action_pressed("ui_up") and is_on_floor():
		vel.y -= JUMP_POWER
		state = "jumping"
		double_jump = true
	print(state)
	if not $RayCast2D.is_colliding():
		if state != "jumping":
			if state != "double jump":
				if state != "dash":
					state = "falling"
					double_jump = true


func _on_Timer_timeout():
	state = "falling"
	is_dashing = false
