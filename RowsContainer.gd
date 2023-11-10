extends Control

@export var result_rows:=4
@export var result_word:="Thieves"

@export var ResultLetterScene: PackedScene
@export var RowScene:PackedScene
var columns: int
@onready var VerticalContainer = %VBoxContainer as VBoxContainer
@onready var rows = []

func setWordRow(word, rows):
	self.result_rows = rows
	self.result_word = word

var rowValues = []
var maxColumns :=0
func calculateRowValues(_word, _rows):
	var stateMachine = StateMachine.new(_word, _rows)
	stateMachine.solve()
	rowValues = stateMachine.rowValues
	self.maxColumns = stateMachine.column
func _ready():
	calculateRowValues(self.result_word, self.result_rows)
	self.columns = maxColumns
	print("Columns", columns)
	for child in VerticalContainer.get_children():
		child.queue_free()
	print("Instantiating ", columns, " columns and rows: ", self.result_rows)

	for i in range(self.result_rows):
		var new_row = RowScene.instantiate()
		for J in range(self.columns):
			print("Instantiating column ", J, " in row ",i)
			var emptyLetter = ResultLetterScene.instantiate()
			emptyLetter.character = ""
			new_row.add_child(emptyLetter)
		VerticalContainer.add_child(new_row)
		self.rows.push_back(new_row)

	for i in (self.columns):
		for j in range(len(self.rows)):
			var rowValue = self.rowValues[j][i]
			print("Row ", i, self.rowValues[j])
			if(rowValue.state == ResultCharacter.RESULT_CHARACTER_STATE.EMPTY):
				pass
			else:
				var previous_empty = self.rows[j].get_children()[i]
				previous_empty.character = rowValue.character
				previous_empty.changeCharacter() 
				
				
			# Wait 30 frames
#			for k in range(30):
#				await get_tree().process_frame
		
		# Wait 30 frames
#		for j in range(60):
#			await get_tree().process_frame
	pass # Replace with function body.

