extends Path2D

# Emitted when item is ready for pickup
signal item_at_end_of_line(item)

export var length : int # length in eigtht notes

func _ready():
	self.connect("child_exiting_tree", self, "_on_item_removed_from_line")

func _on_item_at_end_of_line(item):
	emit_signal("item_at_end_of_line", item)

func _on_item_removed_from_line(item):
	item.disconnect("item_at_end_of_line", self, "_on_item_at_end_of_line")

# Adds item to this assembly line
func add_item_to_line(item):
	var parent = item.get_parent()
	if(parent):
		parent.remove_child(item)
	add_child(item)
	item.connect("item_at_end_of_line", self, "_on_item_at_end_of_line")
	item.set_eighth_on_line_remaining(self.length)

