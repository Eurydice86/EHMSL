extends Control

func _on_Button_Exit_pressed():
	get_tree().quit()


func _on_Button_Show_Ranking_pressed():
	get_tree().change_scene("res://scenes/Ranking.tscn")


func _on_Button_Log_Fight_pressed():
	get_tree().change_scene("res://scenes/Log Fight.tscn")


func _on_Button_Add_Fighter_pressed():
	get_tree().change_scene("res://scenes/Add Fighter.tscn")
