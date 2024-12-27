extends Node

@export var paddle_scene: PackedScene
@export var ball_scene: PackedScene

var ball: Ball
var left_paddle: Paddle
var right_paddle: Paddle

const LEFT_PADDLE_START_POS = Vector2(100, 360)
const RIGHT_PADDLE_START_POS = Vector2(1180, 360)
const BALL_START_POS = Vector2(640, 360)
#var global_delta: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball = ball_scene.instantiate() as Ball
	get_tree().current_scene.add_child.call_deferred(ball)
	ball.global_position = BALL_START_POS
	ball.ball_has_hit_paddle.connect(_on_paddle_hit)
	ball.x_boundry_hit.connect(_on_x_boundry_hit)
	
	left_paddle = paddle_scene.instantiate() as Paddle
	get_tree().current_scene.add_child.call_deferred(left_paddle)
	left_paddle.global_position = LEFT_PADDLE_START_POS
	left_paddle.ai_start_position = LEFT_PADDLE_START_POS
	left_paddle.is_player_one = true
	left_paddle.ball = ball
	
	right_paddle = paddle_scene.instantiate() as Paddle
	get_tree().current_scene.add_child.call_deferred(right_paddle)
	right_paddle.global_position = RIGHT_PADDLE_START_POS
	right_paddle.ai_start_position = RIGHT_PADDLE_START_POS
	right_paddle.is_player_one = false
	right_paddle.is_ai = true
	right_paddle.ai_desired_y_destination = RIGHT_PADDLE_START_POS.y
	right_paddle.ball = ball

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta: float) -> void:
	#global_delta = delta

func reset_match(boundry: String):
	ball.reset(boundry, BALL_START_POS)
	left_paddle.reset(LEFT_PADDLE_START_POS)
	right_paddle.reset(RIGHT_PADDLE_START_POS)


func _on_paddle_hit():
	right_paddle.predict_ball_destination()


func _on_x_boundry_hit(boundry: String):
	reset_match(boundry)
