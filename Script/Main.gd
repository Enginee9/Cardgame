extends Node2D

@onready var deck = $CardController/Deck
@onready var player = $CardController/PlayerHand

func _ready():
	# Verify critical nodes exist
	if not deck:
		push_error("Deck node not found at: $CardController/Deck")
		return
	if not player:
		push_error("PlayerHand node not found at: $CardController/PlayerHand")
		return
	
	await _deal_initial_cards()

func _deal_initial_cards():
	# Deal initial cards with delays
	await get_tree().create_timer(1.0).timeout
	get_tree().call_group("players", "draw_cards", 1)
	
	await get_tree().create_timer(1.0).timeout
	get_tree().call_group("players", "draw_cards", 1)
	
	await get_tree().create_timer(1.0).timeout
	get_tree().call_group("players", "draw_cards", 1)
	
	# Debug: Check if deck is giving cards properly
	var cards = deck.give_cards(2)  # Fixed typo from "give.cardfs" to "give_cards"
	print("Cards received from deck: ", cards)
