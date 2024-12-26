extends Node

@export var ball: Ball
@export var left_paddle: Paddle
@export var right_paddle: Paddle

var global_delta: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball.ball_has_hit_paddle.connect(_on_paddle_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_delta = delta


func _on_paddle_hit():
	right_paddle.predict_ball_destination(global_delta)
