# Bow.gd
extends RangeWeapon
class_name Bow

# Exported variables allow configuration from the editor.
@export var chargeTime: float = 1.0       # Time (in seconds) needed for a full charge.
@export var arrow_scene: PackedScene      # Preloaded arrow scene to instantiate when firing.

# Internal state variables.
var is_charging: bool = false
var current_charge: float = 0.0

# Called when the node enters the scene tree.
func _ready() -> void:
	current_charge = 0.0
	is_charging = false
	# Initialize animations, sounds, etc., if needed.
	print("Bow ready. Charge time is ", chargeTime, " seconds.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_charging:
		# Increase the charge over time, capping at chargeTime.
		current_charge = min(current_charge + delta, chargeTime)
		# (Optional) Update UI or animation to reflect the charging state.
		# For example: update_charge_meter(current_charge / chargeTime)
	pass

# Begin charging the bow attack.
func charge() -> void:
	is_charging = true
	current_charge = 0.0
	# Play a charging sound or animation if available.
	print("Charging initiated.")

# Release the bow, firing an arrow based on the current charge level.
func release() -> void:
	# Only release if we were charging.
	if not is_charging:
		return

	is_charging = false
	# Compute the power as a ratio of current charge to full charge time.
	var power: float = clamp(current_charge / chargeTime, 0.0, 1.0)
	
	# Instantiate the arrow and set its initial position.
	if arrow_scene:
		var arrow = arrow_scene.instantiate()
		# Position the arrow at the Bow's global position (adjust as needed).
		arrow.global_position = global_position
		# If the arrow implements a launch method, pass the power value.
		if arrow.has_method("launch"):
			arrow.launch(power)
		else:
			push_warning("The arrow instance does not have a 'launch' method.")
		# Add the arrow to the active scene.
		get_tree().current_scene.add_child(arrow)
	else:
		push_warning("Arrow scene not assigned.")
	
	print("Arrow released with power: ", power)
	current_charge = 0.0

# Optional: Cancel the charging process (if the player aborts the shot).
func cancel_charge() -> void:
	if is_charging:
		is_charging = false
		current_charge = 0.0
		print("Charging cancelled.")
