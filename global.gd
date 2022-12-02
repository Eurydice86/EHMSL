extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db # database object
var db_file_name = "rankings"
var db_path = "user://rankings"
var db_name = db_path + "/rankings" # path to database
