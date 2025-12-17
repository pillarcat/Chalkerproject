class_name Equipment

extends Node3D

signal equipment(new_stats) 
signal unequipment(old_stats)

# @export var name : String
@export var description : String
@export var stats : Statistics

# func equip() -> void:
#	equipment.emit(stats)
#	pass

#func unequip() -> void:
#	unequipment.emit(stats)
#	pass
