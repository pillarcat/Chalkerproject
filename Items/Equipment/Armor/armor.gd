# Armor.gd
# Enhanced Armor class for equippable items.
# This class extends Equipment and supports multiple armor types via an enum,
# additional stats, and functions to equip/unequip the armor.

extends Equipment
class_name Armor

# Define available armor types.
enum ArmorType { HELMET, CHESTPLATE, LEGGINGS, BOOTS }

# Exported properties
@export var armor_type: ArmorType = ArmorType.HELMET  # Selectable via the editor.
@export var armor_set: String = ""                      # Identifier for armor set (e.g., "Dragon", "Knight").
@export var defense: int = 5                            # Defense rating provided by this armor.
@export var durability: int = 100                       # Current durability (max can be an additional property).
@export var weight: float = 1.0                         # Weight of the armor, may affect movement/stamina.

# Signal to notify when armor is equipped or unequipped.
signal equipped(owner)
signal unequipped(owner)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialization logic: could include caching resources or setting up UI elements.
	print("Armor ready: ", str(armor_type), " from set: ", armor_set)
	# For example, you could adjust the durability based on rarity here.
	# durability = calculate_initial_durability()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Optionally update durability or check for breakage over time.
	# For instance, if durability reaches 0, you might disable the armor.
	pass

# Equip this armor to a given character.
func equip(owner) -> void:
	# Ensure the owner has a method to add defense; this method should be defined on the character.
	if owner and owner.has_method("add_defense"):
		owner.add_defense(defense)
		emit_signal("equipped", owner)
		print("Equipped ", str(armor_type), " armor with defense ", defense)
	else:
		push_warning("Owner does not support equipping armor!")
		
# Unequip this armor from the given character.
func unequip(owner) -> void:
	# Remove the armor's defense bonus.
	if owner and owner.has_method("remove_defense"):
		owner.remove_defense(defense)
		emit_signal("unequipped", owner)
		print("Unequipped ", str(armor_type), " armor.")
	else:
		push_warning("Owner does not support unequipping armor!")

# Optionally, implement a method to repair the armor.
func repair(amount: int) -> void:
	# Increase durability by a given amount, clamped to a maximum (if applicable).
	durability += amount
	# Optionally, define a maximum durability constant.
	durability = min(durability, 100)
	print("Repaired armor; durability is now ", durability)

# Optionally, implement a method to take damage (reducing durability).
func take_damage(amount: int) -> void:
	durability -= amount
	print("Armor took ", amount, " damage. Remaining durability: ", durability)
	if durability <= 0:
		# Handle broken armor: possibly auto-unequip or change appearance.
		print("Armor is broken!")
		# You might call unequip(owner) here if applicable.
