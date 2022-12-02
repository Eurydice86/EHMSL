extends Control

var directory = Directory.new()
var db_name = Global.db_name

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
	if not doesFileExist:
		print("Database file does not exist")
		

