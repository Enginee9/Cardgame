extends Node2D

@onready var deck = $CardController/Deck as Node  # Add proper type hint

var cards = []  # Renamed from 'card' to 'cards' since it holds multiple

func _ready():
	cards = deck.give_cards(2)
	print(cards)
