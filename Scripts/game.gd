extends Node2D

var score_left: int = 0
var score_right: int = 0
var lastPlayerScored: int = 1

@onready var scoreboard: Label = $UIBasic/Label
@onready var markerL: Marker2D = $Marker2DL
@onready var markerR: Marker2D = $Marker2DR
@onready var ball: RigidBody2D = $Ball

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scoreboard.text = "0 - 0"
	ball.position = markerL.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2dl_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		score_right += 1
		lastPlayerScored = 2  # ← fixed assignment
		updateLabel()
		call_deferred("reset_ball")

func _on_area_2dr_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		score_left += 1
		lastPlayerScored = 1  # ← fixed assignment
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
