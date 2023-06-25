import bpy, os, json, gzip
from typing import Any
from bpy_extras.io_utils import ImportHelper

bl_info = {
	"name": "Houdini Tools",
	"description": "Tools for data transfer between Blender and Houdini",
	"author": "Hallam Roberts",
	"version": (1, 0),
	"blender": (3, 4, 1),
	"location": "File > Import-Export",
	"support": "COMMUNITY",
	"category": "Import-Export",
}

# This is disgusting, if you know a better way destroy this
def auto_import(filepath: str) -> str:
	extension = filepath.split(".")[-1]
	match extension:
		case "abc":
			bpy.ops.wm.alembic_import(filepath=filepath)
		case "dae":
			bpy.ops.wm.collada_import(filepath=filepath)
		case "obj":
			bpy.ops.wm.obj_import(filepath=filepath)
		case "stl":
			bpy.ops.wm.stl_import(filepath=filepath)
		case "usd":
			bpy.ops.wm.usd_import(filepath=filepath)
		case "fbx":
			bpy.ops.import_scene.fbx(filepath=filepath)
		case "x3d":
			bpy.ops.import_scene.x3d(filepath=filepath)
		case "wrl":
			bpy.ops.import_scene.x3d(filepath=filepath)
		case "gltf":
			bpy.ops.import_scene.gltf(filepath=filepath)
		case "ply":
			bpy.ops.import_mesh.ply(filepath=filepath)
		case "svg":
			bpy.ops.import_curve.svg(filepath=filepath)
		case _:
			raise Exception(f"Unsupported file extension '{extension}'")

def unlink_everywhere(obj, col):
	"""Unlink an object from all subcollections"""
	try:
		col.objects.unlink(obj)
	except:
		pass
	for child in col.children:
		unlink_everywhere(obj, child)

def infer_type(name: str, data: Any) -> str:
	if isinstance(data, int):
		return "INT"
	elif isinstance(data, bool):
		return "BOOLEAN"
	elif isinstance(data, float):
		return "FLOAT"
	elif isinstance(data, str):
		return "STRING"
	elif isinstance(data, (list, tuple)):
		if len(data) == 2:
			return "FLOAT2"
		elif name == "Cd" or "color" in name:
			return "COLOR"
		else:
			return "FLOAT_VECTOR"
	else:
		return "STRING"

def set_data_value(data: Any, value: Any) -> None:
	if hasattr(data, "vector"):
		data.vector = value
	elif hasattr(data, "color"):
		data.color = value
	else:
		data.value = value

def transfer_attributes(attributes: list[Any], domain: str, obj: bpy.types.Object):
	for attr in attributes:
		anim_attr = obj.data.attributes.new(name=attr, type=infer_type(attr, attributes[attr][0][0]), domain=domain)
		for frame, frame_data in enumerate(attributes[attr]):
			for i, value in enumerate(frame_data):
				if isinstance(value, (list, tuple)) and len(value) > 3:
					continue
				set_data_value(anim_attr.data[i], value)
				# Strings and dicts can't be animated in Blender
				if isinstance(frame_data, (dict, str)):
					continue
				obj.data.keyframe_insert(data_path=f"attributes[\"{attr}\"]", index=-1, frame=frame + 1)

class Import_Point_Instances(bpy.types.Operator, ImportHelper):
	"""Import packed points as nulls and link instances to each point"""
	bl_idname = "houdini.import_instances"
	bl_label = "Import Instances"

	directory: bpy.props.StringProperty(name="Folder", options={"HIDDEN", "SKIP_SAVE"})
	files: bpy.props.CollectionProperty(name="Files", type=bpy.types.OperatorFileListElement, options={"HIDDEN", "SKIP_SAVE"})

	def execute(self, context):
		if len(self.files) != 2:
			self.report({"ERROR_INVALID_INPUT"}, "Please select a points file (containing points.usd) and an instance file")
			return {"CANCELLED"}
		
		points_file = instance_file = col_name = None
		for file in self.files:
			file_path = os.path.join(self.directory, file.name)
			if "points.usd" in file.name:
				points_file = file_path
			else:
				instance_file = file_path
				col_name = file.name.split(".")[0]
		
		if not points_file:
			self.report({"ERROR_INVALID_INPUT"}, "Please select a points file!")
			return {"CANCELLED"}
		if not instance_file:
			self.report({"ERROR_INVALID_INPUT"}, "Please select an instance file!")
			return {"CANCELLED"}

		# Make a collection to contain the instance geometry
		instance_col = bpy.data.collections.new(col_name)
		bpy.context.scene.collection.children.link(instance_col)
		# Make sure it's hidden
		bpy.context.view_layer.layer_collection.children[-1].exclude = True	

		# Import geometry to instance onto nulls
		try:
			auto_import(instance_file)
		except Exception as err:
			self.report({"ERROR_INVALID_INPUT"}, str(err))
			return {"CANCELLED"}
		
		# Move geometry to instance collection
		instances = bpy.context.selected_objects
		for instance in instances:
			unlink_everywhere(instance, bpy.context.collection)
			instance_col.objects.link(instance)

		# Import nulls, never use proxies for this
		bpy.ops.wm.usd_import(filepath=points_file, import_instance_proxies=False)
		nulls = bpy.context.selected_objects

		# Instance collection on nulls
		root = nulls[-1]
		for null in nulls:
			if null == root:
				continue
			null.instance_collection = instance_col
			null.instance_type = "COLLECTION"
		return {"FINISHED"}

class Import_Geometry_Attributes(bpy.types.Operator, ImportHelper):
	"""Import geometry and attach attributes from a JSON file"""
	bl_idname = "houdini.import_geo_attribs"
	bl_label = "Import Geometry"

	directory: bpy.props.StringProperty(name="Folder", options={"HIDDEN", "SKIP_SAVE"})
	files: bpy.props.CollectionProperty(name="Files", type=bpy.types.OperatorFileListElement, options={"HIDDEN", "SKIP_SAVE"})

	def execute(self, context):
		if len(self.files) != 2:
			self.report({"ERROR_INVALID_INPUT"}, "Please select a JSON file and a geometry file")
			return {"CANCELLED"}

		attrib_file = geo_file = None
		for file in self.files:
			file_path = os.path.join(self.directory, file.name)
			if file.name.endswith(".json"):
				attrib_file = file_path
			else:
				geo_file = file_path
		
		if not attrib_file:
			self.report({"ERROR_INVALID_INPUT"}, "Please select a JSON file!")
			return {"CANCELLED"}
		if not geo_file:
			self.report({"ERROR_INVALID_INPUT"}, "Please select a geometry file!")
			return {"CANCELLED"}

		try:
			auto_import(geo_file)
		except Exception as err:
			self.report({"ERROR_INVALID_INPUT"}, str(err))
			return {"CANCELLED"}
		
		# Decompress JSON data
		with gzip.open(attrib_file, "rb") as jsonfile:
			json_bytes = jsonfile.read()
			json_str = json_bytes.decode("utf-8")
			data = json.loads(json_str)

			detail_data = data["detail"]
			prim_data = data["prim"]
			point_data = data["point"]
			#vertex_data = data["vertex"]

			for obj in bpy.context.selected_objects:
				# Transfer detail attributes as custom data
				for attr in detail_data:
					for frame, frame_data in enumerate(detail_data[attr]):
						obj[attr] = frame_data
						# Strings and dicts can't be animated in Blender
						if isinstance(frame_data, (dict, str)):
							continue
						obj.keyframe_insert(data_path=f"[\"{attr}\"]", index=-1, frame=frame + 1)

				# Attributes only work on curves, meshes and point clouds
				if not hasattr(obj.data, "attributes"):
					continue

				# Transfer attributes as mesh data
				transfer_attributes(prim_data, "FACE", obj)
				transfer_attributes(point_data, "POINT", obj)
				#transfer_attributes(vertex_data, "CORNER", obj)
				
		return {"FINISHED"}

def menu_func_import(self, context):
	self.layout.operator(Import_Point_Instances.bl_idname, text="Houdini: Instances on Points (.any, .usd pair)")
	self.layout.operator(Import_Geometry_Attributes.bl_idname, text="Houdini: Geometry and Attributes (.any, .json pair)")

# Dump all classes to register in here
classes = [
	Import_Point_Instances, Import_Geometry_Attributes
]

def register() -> None:
	for cls in classes:
		bpy.utils.register_class(cls)
	bpy.types.TOPBAR_MT_file_import.append(menu_func_import)

def unregister() -> None:
	for cls in classes:
		bpy.utils.unregister_class(cls)
	bpy.types.TOPBAR_MT_file_import.remove(menu_func_import)

if __name__ == "__main__":
	register()