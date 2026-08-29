extends Node

var active_tool : Tool = Tool.NONE

enum Tool {
	ZANGE,
	BRUSH,
	KAROTTE,
	HAND,
	NONE
}
	
func get_name_for_tool(tool :Tool):
	match tool:
		0:
			return "Zange"
		1:
			return "Brush"
		2:
			return "Karotte"
		3:
			return "Hand"
		4:
			return ""
	
