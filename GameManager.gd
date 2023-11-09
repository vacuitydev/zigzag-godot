extends Control

@export var word:="ParrotParrot"
@export var rows:=1
enum GameState{WAITING_FOR_GO, GOING_TO_ROWS}
@export var state= GameState.WAITING_FOR_GO
var rowsGrid: GridContainer
var testPanel: Panel
var stringContainer: HBoxContainer
@onready var RowsField = $"Panel/VBoxContainer/Panel2/string container target/HBoxContainer/Rows edit"
@onready var WordField = $"Panel/VBoxContainer/Panel2/string container target/HBoxContainer/Word edit"
const string_container_scene = preload("res://string_container.tscn")
@onready var string_container_target = $"Panel/VBoxContainer/Panel2/string container target"
const rows_container_scene = preload("res://RowsContainer.tscn")
const SingleLetter = preload("res://SingleLetter.tscn")
@onready var rows_replacement_target = $Panel/VBoxContainer/Panel/MarginContainer/TestPanel/RowsReplacementTarget
# Called when the node enters the scene tree for the first time.
func _ready():
	testPanel = $Panel/VBoxContainer/Panel/MarginContainer/TestPanel as Panel
	# add_letters_to_box()	
	pass # Replace with function body.
func add_letters_to_box(container):
	for i in range(word.length()):
		var character = word[i]
		var newLetter = SingleLetter.instantiate()
		newLetter.setLetter(character)
		container.add_child(newLetter)
		

func on_go_pressed():
	print("Word: {word}, rows: {rows}".format({"word": WordField.text, "rows": RowsField.text}))
	var _rows:=0
	if(int(RowsField.text)==0):
		print("Invalid rows, try again")
		return
	_rows = int(RowsField.text)
	if(WordField.text ==""):
		print("Cannot have empty word")
		return
	if _rows > len(WordField.text):
		print("Please try a longer word or less rows")
		return
	self.rows = _rows
	self.word =WordField.text
	state= GameState.GOING_TO_ROWS
	replace_go_button()
	replace_inputs()
	
func replace_go_button():
	for child in rows_replacement_target.get_children():
		child.queue_free()
	var rows_container = rows_container_scene.instantiate()
	rows_container.setWordRow(self.word, self.rows)
	rows_replacement_target.add_child(rows_container)
	pass
	
	
func replace_inputs():
	for child in string_container_target.get_children():
		child.queue_free()
	var string_container = string_container_scene.instantiate()
	string_container_target.add_child(string_container)
	add_letters_to_box(string_container)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
