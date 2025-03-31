extends Node2D

@onready var deck = get_node("../Deck")

var hand: Array = []
var card_path: String = "res://Graphics/Cards/"
var card_width: float
@export var card_scale: Vector2 = Vector2(1.5, 1.5)

func draw_cards(num: int) -> void:
	print("--- DRAW CARDS DEBUG ---")
	print("Deck node: ", deck)
	var new_cards = deck.give_cards(num)
	print("Cards received from deck: ", new_cards)

	if not new_cards:
		push_error("No cards received from deck!")
		return

	for card in new_cards:
		print("\nCard instance: ", card)
		print("Is instance valid? ", is_instance_valid(card))
		print("Card in tree before adding? ", card.is_inside_tree())

		if not is_instance_valid(card):
			continue
		if not card.is_inside_tree():
			add_child(card)

		print("Card in tree after adding? ", card.is_inside_tree())
		print("Card position: ", card.position)

		card.position = $DeckLocation.position
		card.scale = Vector2(0.1, 0.1)
		hand.append(card)

	await get_tree().create_timer(0.1).timeout
	sprite_cards()
	place_cards()

func place_cards() -> void:
	if hand.is_empty():
		return

	var start_pos = $Path2D/PathFollow2D/DeckSpawner.global_position
	var spacing = min(150, $Path2D.curve.get_baked_length() / hand.size())

	for i in hand.size():
		var target_pos = start_pos + Vector2(spacing * i, 0)
		hand[i].move_card(target_pos, 0)
		hand[i].z_index = i
		print("Card ", i, " placed at: ", target_pos)

func sprite_cards() -> void:
	for card in hand:
		if not card:
			continue

		card.card_scale = card_scale

		var suit_part: String = ""
		match card.card_suit:
			"spade": suit_part = "Spades_"
			"diamond": suit_part = "Diamonds_"
			"club": suit_part = "Clubs_"
			"heart": suit_part = "Hearts_"

		var value_part: String = ""
		match card.card_value:
			1: value_part = "Ace.png"
			11: value_part = "Jack.png"
			12: value_part = "Queen.png"
			13: value_part = "King.png"
			_: value_part = str(card.card_value) + ".png"

		var full_path = card_path + suit_part + value_part
		print("Loading card texture: ", full_path)
		card.change_sprite(full_path)

func reset_hand() -> void:
	for card in hand:
		if is_instance_valid(card):
			card.kill_card()
	hand.clear()
