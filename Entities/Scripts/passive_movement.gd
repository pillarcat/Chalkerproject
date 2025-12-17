class_name MovementPassive


static func stillBehavior(positionEntity : Vector3)->Vector3:
	return positionEntity
	

static func campBehavior(positionEntity : Vector3, rotationEntity : Vector3, spawnPosition : Vector3, radius : int):
	
	var rng = RandomNumberGenerator.new()
	var my_random_number = rng.randf_range(-90.0, 90.0)
	
	rotationEntity = Vector3(rotationEntity[0], rotationEntity[1]+my_random_number, rotationEntity[2])

	
	var ux = cos(rotationEntity.y)
	var uy = sin(rotationEntity.y)
	
	var a = pow(ux,2) + pow(uy,2)
	var b = 2*((positionEntity[0]-spawnPosition[0])*ux + (positionEntity[2]-spawnPosition[2])*uy)
	var c = pow(positionEntity[0]-spawnPosition[0],2) + pow(positionEntity[2]-spawnPosition[2],2) - pow(radius,2)

	var delta = b**2 - 4*a*c
	
	var distMax = (-b - sqrt(delta)) / (2*a)
	
	my_random_number = rng.randf_range(0, distMax)
	
	var new_pos_x = my_random_number*cos(rotationEntity.y) + positionEntity.x 
	var new_pos_z = my_random_number*sin(rotationEntity.y) + positionEntity.z
	
	return Vector3(new_pos_x, 0, new_pos_z)


static func followingPathBehavior(list_of_position, current_position : int, reverse : int)->Array:
	if reverse != 0: # If the entity have to retrace these steps
		if reverse == 1: # If the entity browse the list from the end
			if current_position == 0: # If the entity reach the start of the list
				current_position += 1
				reverse = 2
			else:
				current_position -= 1
		else:	# If the entity browse the list from the start 
			if current_position == list_of_position.size()-1: # If the entity reach the end of the list
				current_position -= 1
				reverse = 1
			else:
				current_position += 1
	else : # If the entity do a loop inside his position
		if current_position == list_of_position.size()-1: # If the entity reach the end of the list
			current_position = 0
		else:
			current_position += 1 
	print(list_of_position[current_position], current_position)
	return [list_of_position[current_position], current_position, reverse]
