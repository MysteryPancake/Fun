import json, gzip, os

def export(kwargs):
	node = kwargs['node']
	out_file = str(node.parm("out_file").eval())
	startFrame = int(node.parm("frame_rangex").eval())
	endFrame = int(node.parm("frame_rangey").eval())

	json_out = {
		"detail": {},
		"prim": {},
		"point": {},
		#"vertex": {}
	}

	geo = node.inputGeometry(0)

	# GROUPS

	#for group in geo.primGroups():
		#print(group)
	
	#for group in geo.pointGroups():
		#print(group)
	
	#for group in geo.edgeGroups():
		#print(group)
	
	#for group in geo.vertexGroups():
		#print(group)

	# ATTRIBUTES

	# Detail attributes are imported to Blender as custom data
	for attr in geo.globalAttribs():
		json_out["detail"][attr.name()] = []
	
	for attr in geo.primAttribs():
		json_out["prim"][attr.name()] = []

	for attr in geo.pointAttribs():
		json_out["point"][attr.name()] = []
	
	#for attr in geo.vertexAttribs():
		#json_out["vertex"][attr.name()] = []

	for frame in range(startFrame, endFrame + 1):
		geo = node.inputGeometryAtFrame(frame, 0)

		for attr in json_out["detail"]:
			json_out["detail"][attr].append(geo.attribValue(attr))

		for attr in json_out["prim"]:
			frame_data = []
			for prim in geo.prims():
				frame_data.append(prim.attribValue(attr))
			json_out["prim"][attr].append(frame_data)

		for attr in json_out["point"]:
			frame_data = []
			for point in geo.points():
				frame_data.append(point.attribValue(attr))
			json_out["point"][attr].append(frame_data)
		
		# TODO: Vertex data, not sure how to use glob vertices yet
		# See https://www.sidefx.com/docs/houdini/hom/hou/Geometry.html#vertices
	
	if not os.path.exists(os.path.dirname(out_file)):
		os.makedirs(os.path.dirname(out_file))

	# Compress JSON data
	json_str = json.dumps(json_out) + "\n"
	json_bytes = json_str.encode("utf-8")
	with gzip.open(out_file, "wb") as jsonfile:
		jsonfile.write(json_bytes)