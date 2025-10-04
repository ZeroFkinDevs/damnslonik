extends Node

var _current_units: Array[Dictionary]
var _next_unit_idx = 0

func execute_units(units:Array[Dictionary]):
	_current_units = units
	_next_unit_idx = 0
	_execute_next_unit()
	
func start_preparing_new_units():
	_current_units = []
	_next_unit_idx = 0
	
func append_unit(unit):
	_current_units.append(unit)
	
func execute_prepared():
	_next_unit_idx = 0
	_execute_next_unit()

func execute_next():
	_next_unit_idx += 1
	_execute_next_unit.call()

func _execute_next_unit():
	if _next_unit_idx >= _current_units.size():
		return
	
	var unit = _current_units[_next_unit_idx]
	if "method" in unit:
		unit["method"].call()
