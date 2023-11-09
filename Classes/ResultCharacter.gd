class_name ResultCharacter
@export var character:=""
enum RESULT_CHARACTER_STATE{EMPTY, CHARACTER}
@export var state:=RESULT_CHARACTER_STATE.EMPTY

func _init(_state, _char=""):
	self.state =_state
	self.character = _char 
func _to_string():
	if self.state == RESULT_CHARACTER_STATE.EMPTY:
		return "_"
	else:
		return "{0}".format([self.character])
