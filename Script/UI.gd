extends CanvasLayer


@onready var PlayerHealth := $HealthContainer/PlayerHFull as TextureRect
@onready var EnemyHealth := $HealthContainer/EnemyHFull as TextureRect

var msgqueue = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if msgqueue.size() > 0:
		if not $AnimationPlayer.is_playing():
			display_next_message()

func display_next_message() -> void:
	$Alert.text = msgqueue.pop_front()
	$AnimationPlayer.play("DisplayAlert")
	await $AnimationPlayer.animation_finished

func send_alert(msg):
	msgqueue.append(msg)

func still_running():
	if msgqueue.size() != 0 or $AnimationPlayer.is_playing() == true:
		return true
	else: 
		return false

func _on_PlayerHand_health_change(value) -> void:
	var hidehealth = false
	PlayerHealth.rect_size.x = 16 * value + 1
	if value <= 0:
		hidehealth = false
	else:
		hidehealth = true
	PlayerHealth.visible = hidehealth

func _on_EnemyHand_health_change(value) -> void:
	var hidehealth = false
	EnemyHealth.rect_size.x = 16 * value + 1
	if value <= 0:
		hidehealth = false
	else:
		hidehealth = true
	PlayerHealth.visible = hidehealth
