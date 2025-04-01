extends Node


var card_names = ["Ace_Spades", "2_Spades", "3_Spades", 
				"4_Spades", "5_Spades", "6_Spades", "7_Spades", 
				"8_Spades", "9_Spades", "10_Spades", "Jack_Spades", 
				"Queen_Spades", "King_Spades", "Ace_Hearts", 
				"2_Hearts", "3_Hearts", "4_Hearts", "5_Hearts", 
				"6_Hearts", "7_Hearts", "8_Hearts", "9_Hearts", 
				"10_Hearts", "Jack_Hearts", "Queen_Hearts", 
				"King_Hearts", "Ace_Clubs", "2_Clubs", 
				"3_Clubs", "4_Clubs", "5_Clubs", "6_Clubs", 
				"7_Clubs", "8_Clubs", "9_Clubs", "10_Clubs", 
				"Jack_Clubs", "Queen_Clubs", "King_Clubs", 
				"Ace_Diamonds", "2_Diamonds", "3_Diamonds", 
				"4_Diamonds", "5_Diamonds", "6_Diamonds", 
				"7_Diamonds", "8_Diamonds", "9_Diamonds", 
				"10_Diamonds", "Jack_Diamonds", "Queen_Diamonds", 
				"King_Diamonds"]

var card_values = [1,2,3,4,5,6,7,8,9,10,11,12,13,
					1,2,3,4,5,6,7,8,9,10,11,12,13,
					1,2,3,4,5,6,7,8,9,10,11,12,13,
					1,2,3,4,5,6,7,8,9,10,11,12,13]

var card_suits = ["spade","spade","spade","spade","spade","spade","spade","spade",
				"spade","spade","spade","spade","spade",
				"heart","heart","heart","heart","heart","heart","heart","heart",
				"heart","heart","heart","heart","heart",
				"club","club","club","club","club","club","club","club",
				"club","club","club","club","club",
				"diamond","diamond","diamond","diamond","diamond","diamond","diamond","diamond",
				"diamond","diamond","diamond","diamond","diamond"]
var deck = []
# Called when the node enters the scene tree for the first time.
func makedeck():
	var cardscene = load("res://Scenes/Card.tscn")
	if not cardscene:
		push_error("Failed to load Card scene!")
		return
		
	for i in card_names.size():
		var card = cardscene.instantiate()
		card.card_name = card_names[i]
		card.card_value = card_values[i]
		card.card_suit = card_suits[i]
		
		# Immediately load and set texture
		var texture_path = _get_texture_path(card_suits[i], card_values[i])
		var texture = load(texture_path)
		if texture:
			card.get_node("Sprite").texture = texture
		else:
			push_error("Failed to load texture: ", texture_path)
		
		deck.append(card)
	
	deck.shuffle()
	print("Deck ready with ", deck.size(), " cards")

func _get_texture_path(suit: String, value: int) -> String:
	var suit_map = {
		"spade": "Spades",
		"heart": "Hearts",
		"club": "Clubs",
		"diamond": "Diamonds"
	}
	var value_map = {
		1: "Ace",
		11: "Jack",
		12: "Queen",
		13: "King"
	}
	
	var value_str = value_map.get(value, str(value))
	return "res://Graphics/Cards/%s_%s.png" % [suit_map[suit], value_str]

func give_cards(num):
	var cards = []
	for i in min(num,deck.size()):
		cards.append(deck.pop_back())
	return cards
