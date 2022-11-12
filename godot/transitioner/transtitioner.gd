extends Node2D

export(PackedScene) var assembly_line_in_A
export(PackedScene) var assembly_line_in_B

export(PackedScene) var assembly_line_out_X
export(PackedScene) var assembly_line_out_Y

enum AssemblyLineOut {X, Y}
export(AssemblyLineOut) var connect_A_to = AssemblyLineOut.X
export(AssemblyLineOut) var connect_B_to = AssemblyLineOut.Y

func _ready():
	assembly_line_in_A.connect("item_at_end_of_line", self, "_on_item_at_end_of_line_A")
	assembly_line_in_B.connect("item_at_end_of_line", self, "_on_item_at_end_of_line_B")
	
	Events.connect("eighth_note", self, "_on_eighth_note")

func _on_item_at_end_of_line_A(item):
	if connect_A_to is AssemblyLineOut.X:
		assembly_line_out_X.add_item_to_line(item)
	else:
		assembly_line_out_Y.add_item_to_line(item)

func _on_item_at_end_of_line_B(item):
	if connect_B_to is AssemblyLineOut.X:
		assembly_line_out_X.add_item_to_line(item)
	else:
		assembly_line_out_Y.add_item_to_line(item)

func switch_connection():
	var prev_A_connection = connect_A_to
	connect_A_to = connect_B_to
	connect_B_to = prev_A_connection
