extends Path2D

# Emitted when item is ready for pickup
signal itemAtEndOfLine(item)

export var length : int # length in quarter notes

func _ready():
	self.connect("child_exiting_tree", self, "_onItemRemovedFromLine")

func _onItemAtEndOfLine(item):
	emit_signal("itemAtEndOfLine", item)

func _onItemRemovedFromLine(item):
	item.disconnect("itemAtEndOfLine", self, "_onItemAtEndOfLine")

# Adds item to this assembly line
func addItemToLine(item):
	item.connect("itemAtEndOfLine", self, "_onItemAtEndOfLine")
	add_child(item)
