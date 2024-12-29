class_name Paddle

extends CharacterBody2D

@export var is_player_one: bool = true
@export var is_ai: bool = false
@export var max_speed: float = 500.0
@export var ball: Ball

var player_height: int = 112
var viewport_size: Vector2 = Vector2(0, 0)

var ai_desired_y_destination: float = 0.0
var ai_start_position: Vector2 = Vector2(0, 0)
var ai_current_speed: float = 0.0
var ai_max_speed: float = 200.0
var ai_acceleration: float = 3.0

var player_up_action = "p1up"
var player_down_action = "p1down"

const MAX_MISS_AMOUNT = 100

var random = RandomNumberGenerator.new()

func _ready() -> void:
	viewport_size = get_viewport().get_visible_rect().size
	if (!is_player_one):
		player_up_action = "p2up"
		player_down_action = "p2down"
	if (is_ai):
		ai_desired_y_destination = position.y


func _physics_process(delta: float) -> void:
	if ((is_ai) and (ball.position.x > viewport_size.x * 0.5)):
		calculate_ai_movement(delta)
	else:
		get_player_input(delta)



func get_player_input(delta):
	if (Input.is_action_pressed(player_up_action) and (position.y > 0 + (player_height * 0.5))):
		position.y -= max_speed * delta
	elif (Input.is_action_pressed(player_down_action) and (position.y < viewport_size.y - (player_height * 0.5))):
		position.y += max_speed * delta


func calculate_ai_movement(delta):
	var half_player_height = player_height * 0.5
	var ai_move_direction = ai_desired_y_destination - ai_start_position.y
	
	if ((position.y > 0 + half_player_height) and 
		(ai_move_direction < 0) and 
		paddle_within_destination_bounds()):
			position.y = lerp(ai_start_position.y, ai_desired_y_destination, ai_current_speed / ai_max_speed)
			ai_current_speed = lerp(ai_current_speed, ai_max_speed, ai_acceleration * delta)
	elif ((position.y < viewport_size.y - half_player_height) and 
		(ai_move_direction > 0) and 
		paddle_within_destination_bounds()):
			position.y = lerp(ai_start_position.y, ai_desired_y_destination, ai_current_speed / ai_max_speed)
			ai_current_speed = lerp(ai_current_speed, ai_max_speed, ai_acceleration * delta)
	else: 
		ai_current_speed = 0.0


func paddle_within_destination_bounds():
	return (ai_desired_y_destination < position.y - 5 or 
		ai_desired_y_destination > position.y + 5)


func predict_ball_destination() -> void:
	if (ball.direction.x > 0):
		#var temp_ball_position = ball.position
		#var temp_ball_direction = ball.direction
		#var temp_speed = ball.speed
		#while temp_ball_position.x < position.x:
			#temp_ball_position.x += (temp_ball_direction.x * delta * temp_speed)
			#temp_ball_position.y += (temp_ball_direction.y * delta * temp_speed)
			#
			#
			#if temp_ball_position.y < 0 or temp_ball_position.y > viewport_size.y:
				#temp_ball_direction.y *= -1
		#
	
		var ball_displacement_y = (position.x - ball.position.x) * ball.direction.y / ball.direction.x
		var arena_height = viewport_size.y
		var final_y = abs(wrapf(ball.position.y + ball_displacement_y, -arena_height, arena_height))
		
		ai_desired_y_destination = final_y + random.randf_range(-MAX_MISS_AMOUNT, MAX_MISS_AMOUNT)
		ai_start_position = position


func reset(start_position: Vector2):
	position = start_position
	ai_desired_y_destination = start_position.y
