extends Panel
@export var letter= "3"
@onready var label = $Label


func setLetter(_letter):
	letter=_letter
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = letter
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
