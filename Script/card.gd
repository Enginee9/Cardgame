extends Area2D

var cardname
var cardvalue
var cardsuit
var dealt = false

@export var cardsprite: Texture2D
var cardscale: Vector2:       # setget in 4.0 version
	set(value):
		cardscale = value 
		change_cardscale(value)
		
var handposition = Vector2.ZERO
var handrotation = Vector2.ZERO

func move_card(dest, rotate = null, _scale = null):
		$Tween.interpolate_property(self, "position" , position, dest, 0.7, Tween.TRANS_BACK, Tween.EASE_OUT)
		if rotate != null:
			$Tween.interpolate_property(self, "rotation", rotation, rotate, 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN)
		if _scale != null:
			$Tween.interpolate_property(self, "scale", scale, _scale, 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()

func change_sprite(res):
	var texture = load(res)
	if texture:
		$Sprite.texture = texture
	else:
		push_error("Failed to load texture"+res)

func change_cardscale(_scale):
	scale = _scale

func card_width():
	var cardwidth = $Sprite.texture.get_width() * scale.x
	return cardwidth

# Called when the node enters the scene tree for the first time.
func _ready():
	visible=true
	print("Hand visibility:",visible)

func kill_card():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
