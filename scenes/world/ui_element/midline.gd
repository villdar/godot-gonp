extends Control

const STARTING_Y = 0
const BAR_COLOR: Color = Color.WHITE
const BAR_LENGHT = 15
const BAR_WIDTH = 6
const DISTANCE_BETWEEN_BARS = 10


func _draw() -> void:
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var current_y = STARTING_Y
	
	while (current_y < viewport_size.y):
		draw_line(Vector2(viewport_size.x * 0.5, current_y), Vector2(viewport_size.x * 0.5, current_y + BAR_LENGHT), BAR_COLOR, BAR_WIDTH)
		current_y += BAR_LENGHT + DISTANCE_BETWEEN_BARS
