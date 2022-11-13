tool
extends AnimatedTexture
class_name AnimatedTextureSheet

export var atlasTexture : AtlasTexture setget set_atlasTexture
export var vFrame : int = 1 setget set_vFrame
export var hFrame : int = 1 setget set_hFrame
var flip = true

func _init():
	Events.connect("sixtenth_note", self, "_on_sixtenth_note")

func _on_sixtenth_note():
	set_pause(flip)
	flip = not flip

func get_plugin_icon():
	return Tree.get_editor_interface().get_base_control().get_icon("Node", "EditorIcons")

func set_atlasTexture(value):
	atlasTexture = value
	_on_change()

func set_vFrame(value):
	vFrame = value
	_on_change()

func set_hFrame(value):
	hFrame = value
	_on_change()


func _on_change():
	if(atlasTexture == null):
		return
	assert(hFrame >= 1 and vFrame >= 1)
	set_frames(hFrame * vFrame)
	
	var atlas_region : Rect2 = atlasTexture.get_region()
	var frame_width : int = int(atlas_region.size.x / vFrame)
	var frame_height : int = int(atlas_region.size.y / hFrame)
	var atlas_image : Image = atlasTexture.get_data()
	
	for h in range(hFrame):
		for v in range(vFrame):
			var rect := Rect2(Vector2(v * frame_width, h * frame_height), Vector2(frame_width, frame_height))
			var current_frame = v+h
			var image := Image.new()
			image.create(frame_width, frame_height, false, Image.FORMAT_RGBA8)
			image.resource_name = str("frameImage", current_frame)
			image.blit_rect(atlas_image, rect, Vector2(0, 0))
			var frame_texture := ImageTexture.new()
			frame_texture.create_from_image(image)
			frame_texture.set_flags(atlasTexture.get_flags())
			set_frame_texture(current_frame, frame_texture)
	print()
	property_list_changed_notify()

