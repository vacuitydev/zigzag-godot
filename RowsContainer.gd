extends Control

@export var result_rows:=10
@export var result_word:="123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 "

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
	maxColumns = stateMachine.column
func _ready():
	calculateRowValues(self.result_word, self.result_rows)
	columns = maxColumns
	print("Columns", columns)
	for child in VerticalContainer.get_children():
		child.queue_free()
	print("Instantiating ", columns, " columns and rows: ", self.result_rows)

	for i in range(self.result_rows):
		var new_row = RowScene.instantiate()
		for J in range(columns+1):
			var emptyLetter = ResultLetterScene.instantiate()
			emptyLetter.character = ""
			new_row.add_child(emptyLetter)
		VerticalContainer.add_child(new_row)
		self.rows.push_back(new_row)

	for i in (self.columns+1):
		for j in range(len(self.rows)):
			var rowValue = self.rowValues[j][i]
			print("Row ", i, self.rowValues[j])
			if(rowValue.state == ResultCharacter.RESULT_CHARACTER_STATE.EMPTY):
				pass
			else:		
				var resultLetter = ResultLetterScene.instantiate()
				resultLetter.character = rowValue.character
				var previous_empty = self.rows[j].get_children()[i] 
				previous_empty.queue_free()
				await previous_empty.tree_exited
				self.rows[j].add_child(resultLetter)
				self.rows[j].move_child(resultLetter, i)
				
				
			# Wait 30 frames
#			for k in range(30):
#				await get_tree().process_frame
		
		# Wait 30 frames
#		for j in range(60):
#			await get_tree().process_frame
	pass # Replace with function body.

