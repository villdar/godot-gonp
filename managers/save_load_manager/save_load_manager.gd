class_name SaveLoadManager

extends Node


func read_high_scores():
	var score_config = ConfigFile.new()
	var high_scores = {
		"player_one_score": 0,
		"player_two_score": 0,
	}
	
	var err = score_config.load("user://scores.cfg")
	
	if err != OK:
		return high_scores
	
	for player_score_entry in score_config.get_sections():
		var player_score = score_config.get_value(player_score_entry, "high_score")
		high_scores[player_score_entry] = player_score
	
	return high_scores

func save_high_score(high_scores: Dictionary):
	var score_config = ConfigFile.new()
	
	for player_score_entry in high_scores:
		var high_score = high_scores[player_score_entry]
		score_config.set_value(player_score_entry, "high_score", high_score)
	
	score_config.save("user://scores.cfg")
