extends Area2D

# Signals
signal active_card(node: Node)
signal card_selected(node: Node)

# Exported variables (Godot 4 syntax)
@export var focus_move_on_y: int = 40
@export var cardsprite: Texture2D
@export var cardscale: Vector2 = Vector2(1, 1):
	set(value):
		change_cardscale(value)

# Regular variables
var card_name: String
var card_value: int
var card_suit: String
var dealt: bool = false
var selectable: bool = false:
	set(value):
		set_selectable(value)
var selected_card: bool = false
var front_sprite_path: String
var cardowner
var touchable: bool = true

var handposition: Vector2 = Vector2.ZERO
var handrotation: float = 0.0

func set_selectable(val: bool) -> void:
	selectable = val

func move_card(dest: Vector2, rotate: Variant = null, _scale: Variant = null) -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", dest, 0.5)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
	
	if rotate != null:
		tween.parallel().tween_property(self, "rotation", rotate, 0.2)\
			.set_trans(Tween.TRANS_LINEAR)\
			.set_ease(Tween.EASE_IN)
	
	if _scale != null:
		tween.parallel().tween_property(self, "scale", _scale, 0.5)\
			.set_trans(Tween.TRANS_BACK)\
			.set_ease(Tween.EASE_OUT)

func change_sprite(res: String) -> void:
	$Sprite.texture = load(res)

func change_cardscale(_scale: Vector2) -> void:
	scale = _scale

func card_width() -> float:
	return $Sprite.texture.get_width() * scale.x

func kill_card() -> void:
	queue_free()

func make_focus() -> void:
	if selectable:
		var position_shift = position
		position_shift.y -= focus_move_on_y
		if position == handposition:
			move_card(position_shift, 0.0)
		z_index = 2
		selected_card = true
		emit_signal("active_card", self)

func off_focus() -> void:
	if selectable:
		move_card(handposition, handrotation)
		z_index = 1
		selected_card = false

func make_active(card: Node) -> void:
	if card != self:
		off_focus()

func _on_card_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if touchable:
		if event is InputEventMouseButton or event is InputEventScreenTouch:
			if (event.is_action_pressed("left_click") and selected_card or (event.is_pressed() and selected_card)):
				selected_card = false
				emit_signal("card_selected", self)
				touchable = false
				$TouchTimer.start()
			elif (not selected_card and event.is_action_pressed("left_click")) or (not selected_card and event.is_pressed()):
				touchable = false
				$TouchTimer.start()
				make_focus()

func _on_touch_timer_timeout() -> void:
	touchable = true
