extends Node2D

export(NodePath) var assembly_line_in_A_path
export(NodePath) var assembly_line_in_B_path

export(NodePath) var assembly_line_out_X_path
export(NodePath) var assembly_line_out_Y_path

var _assembly_line_out_X
var _assembly_line_out_Y

enum AssemblyLineOut {X, Y}
export(AssemblyLineOut) var connect_A_to = AssemblyLineOut.X
export(AssemblyLineOut) var connect_B_to = AssemblyLineOut.Y

func _ready():
	_assembly_line_out_X = get_node(assembly_line_out_X_path)
	_assembly_line_out_Y = get_node(assembly_line_out_Y_path)
	get_node(assembly_line_in_A_path).connect("item_at_end_of_line", self, "_on_item_at_end_of_line_A")
	get_node(assembly_line_in_B_path).connect("item_at_end_of_line", self, "_on_item_at_end_of_line_B")
	
	Events.connect("eighth_note", self, "_on_eighth_note")

func _on_item_at_end_of_line_A(item):
	if connect_A_to is AssemblyLineOut.X:
		_assembly_line_out_X.add_item_to_line(item)
	else:
		_assembly_line_out_Y.add_item_to_line(item)

func _on_item_at_end_of_line_B(item):
	if connect_B_to is AssemblyLineOut.X:
		_assembly_line_out_X.add_item_to_line(item)
	else:
		_assembly_line_out_Y.add_item_to_line(item)

func switch_connection():
	var prev_A_connection = connect_A_to
	connect_A_to = connect_B_to
	connect_B_to = prev_A_connection

func _on_eighth_note():
	pass
