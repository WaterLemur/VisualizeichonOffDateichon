extends Node


@onready var animation_player = $AnimationPlayer  as AnimationPlayer

@export_category("Variables")
@export var timer_max = 2.5 as float
var index     = 0         as int
var timer     = timer_max as int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		timer = timer_max
		index += 1
		if index > 6: index = 0
		match index:
			0: animation_player.play("Arm")
			1: animation_player.play("Measure_Window")
			2: animation_player.play("pot_l_b")
			3: animation_player.play("pot_grain_0")
			4: animation_player.play("pot_l_f")
			5: animation_player.play("pot_r_f")
			6: animation_player.play("Cogs")
