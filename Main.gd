extends Node2D

@onready var Deck = $CardController/Deck
@onready var Player = $CardController/PlayerHand
#@onready var Enemy = $CardController/EnemyHand
#@onready var Table = $CardController/Table

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1.0).timeout      # delate 1 second
	get_tree().call_group("players", "draw_cards", 1)
	await get_tree().create_timer(1.0).timeout      # delate 1 second
	get_tree().call_group("players", "draw_cards", 1)
	await get_tree().create_timer(1.0).timeout      # delate 1 second
	get_tree().call_group("players", "draw_cards", 1)
	Table.draw_flop()
	await get_tree().create_timer(1.0).timeout      # delate 1 second
	Table.draw_flop()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
