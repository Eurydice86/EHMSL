extends Control

var SQLite = Global.SQLite
var db = Global.db
var db_name = Global.db_name

var res
var winnerID
var loserID

var newRWinner
var newRLoser

var error = false

# Called when the node enters the scene tree for the first time.
func _ready():
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	var tableName = "fighters"
	var sortBy = "name"
	db.query("SELECT * FROM " + tableName + " ORDER BY " + sortBy + " ASC;")
	res = db.query_result
	for i in res:
		$VBoxContainer/HBoxContainerWinner/WinnerButton.add_item(i.name)
		$VBoxContainer/HBoxContainerLoser/LoserButton.add_item(i.name)

func _on_OK_pressed():
	winnerID = $VBoxContainer/HBoxContainerWinner/WinnerButton.get_selected_id()
	loserID = $VBoxContainer/HBoxContainerLoser/LoserButton.get_selected_id()
	if winnerID != loserID:
		$VBoxContainer/PopupDialog/RichTextLabel.text = "You are about to log a fight, in which " + res[winnerID].name + " defeated " + res[loserID].name + ". Are you sure you want to proceed?"
		$VBoxContainer/PopupDialog/VBoxContainer/HBoxContainer/Yes_Popup.disabled = false
	else:
		$VBoxContainer/PopupDialog/RichTextLabel.text = "You are trying to log an invalid fight. People are not allowed to defeat themselves. Continue?"
		$VBoxContainer/PopupDialog/VBoxContainer/HBoxContainer/Yes_Popup.disabled = true
	$VBoxContainer/PopupDialog.visible = true
	


func _on_Button_Return_pressed():
	get_tree().change_scene("res://scenes/Main Screen.tscn")

func _on_No_Popup_pressed():
	$VBoxContainer/PopupDialog.visible = false


func _on_Yes_Popup_pressed():
	$VBoxContainer/PopupDialog/Logged_Confirmation.visible = true
	$VBoxContainer/PopupDialog/Logged_Confirmation/Timer.start()


func _on_Timer_timeout():
	$VBoxContainer/PopupDialog/Logged_Confirmation.visible = false
	$VBoxContainer/PopupDialog.visible = false
	add_to_fighters_db()
	add_to_fights_db()

func add_to_fighters_db():
	calculate_elo()
	var dictW : Dictionary = Dictionary()
	var dictL : Dictionary = Dictionary()
	dictW["name"] = res[winnerID].name
	dictL["name"] = res[loserID].name
	dictW["rating"] = newRWinner
	dictL["rating"] = newRLoser
	print(dictL)
	
	db.update_rows("fighters", "uid = "+str(res[winnerID].uid), dictW)
	db.update_rows("fighters", "uid = "+str(res[loserID].uid), dictL)
	
func add_to_fights_db():
	var tableName = "fights"
	var dictFight : Dictionary = Dictionary()
	dictFight["winner_uid"] = res[winnerID].uid
	dictFight["loser_uid"] = res[loserID].uid
	dictFight["timestamp"] = Time.get_datetime_string_from_system()
	db.insert_row(tableName, dictFight)





# Elo calculations
func calculate_elo():
	var R_winner = res[winnerID].rating
	var R_loser = res[winnerID].rating
	var K = 30
	EloRating(R_winner, R_loser, K)

func EloRating(Ra, Rb, K):
	var Pb = Probability(Ra, Rb)
	var Pa = Probability(Rb, Ra)

	newRWinner = Ra + K * (1 - Pa)
	newRLoser = Rb + K * (0 - Pb)

func Probability(rating1, rating2):
	return 1.0 * 1.0 / (1 + 1.0 * pow(10, 1.0 * (rating1 - rating2) / 400))
