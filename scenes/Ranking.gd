extends Control

var SQLite = Global.SQLite
var db = Global.db
var db_name = Global.db_name
# Called when the node enters the scene tree for the first time.
func _ready():
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	var tableName = "fighters"
	var sortBy = "rating"
	db.query("SELECT * FROM " + tableName + " ORDER BY " + sortBy + " DESC;")
	var res = db.query_result
	var names = ""
	var ratings = ""
	for i in res:
		names += i.name + "\n"
		ratings += str(i.rating) + "\n"
	$Names.text = names
	$Ratings.text = ratings


func _on_Button_Return_pressed():
	get_tree().change_scene("res://scenes/Main Screen.tscn")
