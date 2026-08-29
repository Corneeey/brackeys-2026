extends Node

@warning_ignore("unused_signal")
signal ate_food

var active_tool : Tool = Tool.NONE

enum Tool {
	ZANGE,
	BRUSH,
	KAROTTE,
	HAND,
	NONE
}
