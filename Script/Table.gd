extends Node2D  # Changed from extending Hand.gd to be more explicit

class_name Table  # Add this if you need to reference the type

@export var card_distance: float = 65
@onready var start_point = $LeftPoint
@onready var deck_position = $DeckPosition
var hand: Array = []

func _ready():
	# Verify critical nodes exist
	if not start_point:
		push_error("Start point marker ($LeftPoint) not found!")
	if not deck_position:
		push_error("Deck position marker ($DeckPosition) not found!")

func draw_flop() -> void:
	if not deck_position:
		push_error("Cannot draw flop - deck position not set")
		return
	
	# Clear existing cards first
	reset_hand()
	
	# Draw 3 new cards
	for i in 3:
		var new_card = preload("res://Scenes/Card.tscn").instantiate()
		new_card.position = deck_position.position
		hand.append(new_card)
		add_child(new_card)
	
	place_cards()

func place_cards() -> void:
	if not start_point or hand.is_empty():
		return
	
	for i in hand.size():
		var target_pos = Vector2(
			start_point.position.x + (card_distance * i),
			start_point.position.y
		)
		hand[i].move_card(target_pos, 0)

func reset_hand() -> void:
	for card in hand:
		if is_instance_valid(card):
			card.queue_free()
	hand.clear()
