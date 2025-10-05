extends Trigger
class_name NarrativeTrigger

@export var narrative: NarrativeNode

func is_available():
	if narrative != null:
		return narrative.is_available()
	return false

func trigger(obj):
	narrative.execute()
