class_name StateMachine
@export var current:= 0
@export var rows:=0
@export var going_up:=false
@export var column := 0
@export var word:=""
@export var rowValues=[]
func _init(_word, _rows):
	self.word = _word
	self.rows = _rows
func solve():
	for i in self.rows:
		rowValues.push_back([])
	for i in range(len(self.word)):
		if self.going_up and self.current!=0:
			for j in range(self.rows):
				if j!=self.current:
					rowValues[j].push_back(
						ResultCharacter.new(
							ResultCharacter.RESULT_CHARACTER_STATE.EMPTY
						))
		rowValues[self.current].push_back(ResultCharacter.new(
			ResultCharacter.RESULT_CHARACTER_STATE.CHARACTER,
			self.word[i]))
		print("Rows", rowValues)
		print(self.column)
		self.progressCurrent()
	# Check the first row length
	var first_length = len(rowValues[0])
	# Check every other row
	for i in range(1, len(rowValues)):
		# If its length is not equal to first_length
		# pad it with emptys
		var difference = -(len(rowValues[i]) - first_length)
		if difference!=0:
			print ("Difference of ", difference, " in row ", i)
			for j in range(difference):
				print("Adding to that row")
				rowValues[i].push_back(
						ResultCharacter.new(
							ResultCharacter.RESULT_CHARACTER_STATE.EMPTY
						))
	self.column = first_length
func progressCurrent():
	if self.rows==1:
		self.current =0
		self.column +=1
		return
	if self.current == 0:
		self.current+=1
		self.going_up =false
		return 
	if current == rows-1 :
		self.current-=1
		self.going_up = true
		self.column+=1
		return
	if self.going_up:
		self.column+=1
	self.current += -1 if self.going_up else 1
