extends Control

@export var character:="B"
@onready var label = $Panel/Label
@export var emptyColor: Color
@export var emptyStyle: StyleBoxFlat
var style = StyleBoxFlat.new()
func _ready():
	if(character==" "):
		print("Empty detected")
		style.set_bg_color(emptyColor)
		(%Panel as Panel).add_theme_stylebox_override("panel",emptyStyle)
		%Panel.add_theme_color_override("bg_color", emptyColor)
	label.text = character


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
