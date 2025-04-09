extends Node2D

var score_left = 0
var score_right = 0
@onready var scoreboard: Label = $UIBasic/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2dl_body_entered(body: Node2D) -> void:
	score_right += 1

func _on_area_2dr_body_entered(body: Node2D) -> void:
	score_left += 1

func updateLabel():
	scoreboard.text = str() 
