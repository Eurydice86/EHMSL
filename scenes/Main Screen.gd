extends Control

var directory = Directory.new()
var db_name = Global.db_name
var db_path = Global.db_path
var SQLite = Global.SQLite
var db = Global.db

func _ready():
	check_if_db_exists()

func _on_Button_Exit_pressed():
	get_tree().quit()


func _on_Button_Show_Ranking_pressed():
	get_tree().change_scene("res://scenes/Ranking.tscn")


func _on_Button_Log_Fight_pressed():
	get_tree().change_scene("res://scenes/Log Fight.tscn")


func _on_Button_Add_Fighter_pressed():
	get_tree().change_scene("res://scenes/Add Fighter.tscn")

func check_if_db_exists():
	var db_name_wExtension = db_name + ".db"
	var doesFileExist = directory.file_exists(db_name_wExtension)
	var doesPathExist = directory.dir_exists(db_path)
	if not doesPathExist:
		create_path_to_db()
	if not doesFileExist:
		create_db()

func create_path_to_db():
	directory.open("user://")
	directory.make_dir("rankings")


func create_db():
	db = SQLite.new()
	db.path = db_name
	print(db_name)
	db.open_db()


	db.create_table("fighters", {
		"uid": {"data_type": "integer", "primary_key": true, "not_null": true, "auto_increment": true},
		"name": {"data_type": "text", "not_null": true},
		"rating": {"data_type": "numeric", "not_null": true}
		}
	)
	db.create_table("fights", {
		"fight_uid": {"data_type": "integer", "primary_key": true, "not_null": true, "auto_increment": true},
		"winner_uid": {"data_type": "text", "not_null": true},
		"loser_uid": {"data_type": "numeric", "not_null": true},
		"timestamp": {"data_type": "text", "not_null": true}
		}
	)
