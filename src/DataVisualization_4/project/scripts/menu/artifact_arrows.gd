#!sumer_arrows.gd
class_name SumerArrows
extends Node


@export_group("References")
@export var arrow_left: Node3D
@export var arrow_right: Node3D
@export var max_angle_pi: float = 0.80 #0.75
@export var min_angle_pi: float = 0.01 #0.0

static var counter: int = 0
var is_counted: Array[bool] = []
var rot_angle: float

@export_group("Collision")
@export var collision_left: Node3D
@export var collision_right: Node3D

@export var area_left:  Area3D
@export var area_right: Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_left.scale.z  = min_angle_pi
	collision_right.scale.z = min_angle_pi
	is_counted.resize(30)
	is_counted.fill(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_labels()
	count()


func set_left(normalized: float) -> void:
	normalized = clamp(normalized, min_angle_pi, 2)
	rot_angle = lerp(0.0, max_angle_pi, normalized)
	arrow_left.rotation.y = rot_angle
	collision_left.scale.z = normalized
	#if rot_angle == 0.0 && arrow_right.rotation.y == 0.0: counter = 0
	
func set_right(normalized: float) -> void:
	normalized = clamp(normalized, min_angle_pi, 2)
	rot_angle = lerp(0.0, max_angle_pi, normalized)
	arrow_right.rotation.y = -rot_angle
	collision_right.scale.z = normalized
	#if rot_angle == 0.0 && arrow_left.rotation.y == 0.0: counter = 0


func count() -> void:
	counter = 0
	for counted in is_counted:
		if counted == true:
			counter += 1
	
func update_labels() -> void:
	Persistent.label_cuneiform.text = _translate(counter)
	Persistent.label_arabic.text = str(counter)


func _translate(arabic: int) -> String:
	match arabic:
		0: return "𒎎"
		1: return "𒁹"
		2: return "𒁹𒁹"
		3: return "𒁹𒁹𒁹"
		4: return "𒁹𒁹𒁹𒁹"
		5: return "𒁹𒁹𒁹𒁹𒁹"
		6: return "𒁹𒁹𒁹𒁹𒁹𒁹"
		7: return "𒁹𒁹𒁹𒁹𒁹𒁹𒁹"
		8: return "𒁹𒁹𒁹𒁹𒁹𒁹𒁹𒁹"
		9: return "𒁹𒁹𒁹𒁹𒁹𒁹𒁹𒁹𒁹"
		10: return "𒌋"
		11: return "𒌋𒁹"
		12: return "𒌋𒁹𒁹"
		13: return "𒌋𒁹𒁹𒁹"
		14: return "𒌋𒁹𒁹𒁹𒁹"
		15: return "𒌋𒁹𒁹𒁹𒁹𒁹"
		16: return "𒌋𒁹𒁹𒁹𒁹𒁹𒁹"
		17: return "𒌋𒁹𒁹𒁹𒁹𒁹𒁹𒁹"
		18: return "𒌋𒁹𒁹𒁹𒁹𒁹𒁹𒁹𒁹"
		19: return "𒌋𒁹𒁹𒁹𒁹𒁹𒁹𒁹𒁹𒁹"
		20: return "𒌋𒌋"
		21: return "𒌋𒌋𒁹"
		22: return "𒌋𒌋𒁹𒁹"
		23: return "𒌋𒌋𒁹𒁹𒁹"
		24: return "𒌋𒌋𒁹𒁹𒁹𒁹"
		25: return "𒌋𒌋𒁹𒁹𒁹𒁹𒁹"
		26: return "𒌋𒌋𒁹𒁹𒁹𒁹𒁹𒁹"
		27: return "𒌋𒌋𒁹𒁹𒁹𒁹𒁹𒁹𒁹"
		28: return "𒌋𒌋𒁹𒁹𒁹𒁹𒁹𒁹𒁹𒁹"
		29: return "𒌋𒌋𒁹𒁹𒁹𒁹𒁹𒁹𒁹𒁹𒁹"
		30: return "𒌋𒌋𒌋"
	return ""
