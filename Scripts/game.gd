extends Node2D

var score_left: int = 0
var score_right: int = 0
var lastPlayerScored: int = 1
var game_ended: bool = false  # Flag to check if the game has ended

@onready var scoreboard: Label = $UIBasic/Label
@onready var markerL: Marker2D = $Marker2DL
@onready var markerR: Marker2D = $Marker2DR
@onready var ball: RigidBody2D = $Ball
@export var targetscene: PackedScene

@export var winning_score: int = 5

func _ready() -> void:
	scoreboard.text = "0 - 0"
	ball.position = markerL.position

func _process(delta: float) -> void:
	if game_ended:  # Do nothing if the game has ended
		return
	
	if score_left >= winning_score:
		_end_game("Player 1 Wins with " + str(score_left) + " - " + str(score_right) + "!")
	elif score_right >= winning_score:
		_end_game("Player 2 Wins with " + str(score_left) + " - " + str(score_right) + "!")

func _on_area_2dl_body_entered(body: Node2D) -> void:
	if game_ended:  # Stop processing if the game has ended
		return
		
	if body.is_in_group("ball"):
		score_right += 1
		lastPlayerScored = 2
		updateLabel()
		call_deferred("reset_ball")

func _on_area_2dr_body_entered(body: Node2D) -> void:
	if game_ended:  # Stop processing if the game has ended
		return
		
	if body.is_in_group("ball"):
		score_left += 1
		lastPlayerScored = 1
		updateLabel()
		call_deferred("reset_ball")

func updateLabel():
	scoreboard.text = str(score_left) + " - " + str(score_right)

func reset_ball():
	ball.freeze = true
	if lastPlayerScored == 1:
		ball.global_transform.origin = markerL.position
	else:
		ball.global_transform.origin = markerR.position
	ball.freeze = false
	ball.linear_velocity = Vector2.ZERO

func _end_game(winning_text: String) -> void:
	# Set the flag to stop further game actions
	game_ended = true
	scoreboard.text = winning_text
	await get_tree().create_timer(5).timeout
	get_tree().reload_current_scene()
