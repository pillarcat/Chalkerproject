class_name Movement


static func angleRotation(x: float, z : float)->float:
	print("x= ", x," z= ", z)
	if x > 0:
		return atan(z/x)
	elif x < 0 and z >= 0:
		return atan(z/x) + PI
	elif x < 0 and z < 0:
		return atan(z/x) + PI
	elif x == 0 and z > 0:
		return PI/2
	elif x == 0 and z < 0:
		return -PI/2
	else:
		return 0

static func getProjection(pos1 : Vector3, pos2 : Vector3, dist : float)->Vector3:
	var theta = angleRotation(pos2.x-pos1.x, pos2.z-pos1.z)
	print(theta)
	var x = dist*cos(theta)
	var z = dist*sin(theta)
	
	return Vector3(pos1.x + x, pos2.y, pos1.z + z)


static func distanceVect(pos1 : Vector3, pos2 : Vector3):
	var x = (pos1.x - pos2.x) * (pos1.x - pos2.x)
	var z = (pos1.z - pos2.z) * (pos1.z - pos2.z)
	return sqrt(x+z)
