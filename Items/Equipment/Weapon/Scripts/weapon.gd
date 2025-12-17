class_name Weapon

extends Equipment


# @export var dimensions : Vector3
@export var damages : int
@export var fullAtkSpeed : float

func mouvement() -> void:
	pass

# Attack animation of the weapon
func attack() -> void:
	pass # Replace with function body.
	
func ability() -> void:
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
