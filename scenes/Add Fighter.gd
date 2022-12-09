extends Control


var SQLite = Global.SQLite
var db = Global.db
var db_name = Global.db_name

func _on_Button_Add_pressed():
	var fighterName = $NameInput.text
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	var tableName = "fighters"
	var dict : Dictionary = Dictionary()
	dict["name"] = fighterName
	dict["rating"] = 1000
	
	db.insert_row(tableName, dict)
	$NameInput.text = ""

func _on_Button_Return_pressed():
	var error_code = get_tree().change_scene("res://scenes/Main Screen.tscn")
	if error_code !=0:
		print("ERROR: ", error_code)
