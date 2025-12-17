class_name MovementAggressive
extends Movement

static func stillBehavior(entity_position : Vector3)->Vector3:
	return entity_position
	

static func fleeingBehavior(entity_position : Vector3, player_position : Vector3, dist_stop_fleeing : float)->Vector3:
	return Movement.getProjection(player_position, entity_position, dist_stop_fleeing)
	
	

static func distanceBehavior(entity_position : Vector3, player_position : Vector3, position_tab : Array)->Vector3:
	var dist_player = Movement.distanceVect(entity_position, player_position)
	if dist_player < position_tab[1]:
		return Movement.getProjection(player_position, entity_position, position_tab[1])
	elif dist_player == position_tab[1]:
		return entity_position
	else:
		return player_position
		
	
	

static func meleeBehavior(entity_position : Vector3, player_position : Vector3, position_tab : Array)->Vector3:
	var dist_player = Movement.distanceVect(entity_position, player_position)
	if dist_player < 1.5:
		return entity_position
	
	else:
		return player_position


static func meleeDistBehavior(entity_position : Vector3, player_position : Vector3, position_tab : Array)->Vector3:
	var dist_player = Movement.distanceVect(entity_position, player_position)
	if dist_player < 1.5:
		return entity_position
	elif dist_player < position_tab[0]:
		return player_position
	elif dist_player < position_tab[1]:
		return Movement.getProjection(player_position, entity_position, position_tab[1])
	elif dist_player == position_tab[1]:
		return entity_position
	else:
		return player_position
