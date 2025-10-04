extends InteractiveArea

@export var narrative: NarrativeNode

func use():
	if narrative: narrative.execute()
	
func is_available():
	if narrative: return narrative.is_available()
	return false
