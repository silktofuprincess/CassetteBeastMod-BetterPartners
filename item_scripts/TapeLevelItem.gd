extends BaseItem

func get_rarity():
	return Rarity.RARITY_RARE

func get_use_options(_node, _context_kind:int, _context)->Array:
	return [{"label":"ITEM_USE_ON_SUBMENU", "arg":null}]

func custom_use_menu(_node, _context_kind:int, _context, arg = null):
	if arg != null:
		return arg
	
	var tapes = SaveState.party.get_tapes()
	return MenuHelper.show_choose_tape_menu(tapes, Bind.new(self, "_tape_filter"))

func _tape_filter(tape:MonsterTape)->bool:
	return tape.grade < MonsterTape.MAX_TAPE_GRADE

func _use_in_world(_node, _context, arg):
	assert (arg is MonsterTape)
	if not (arg is MonsterTape):
		return false
	yield (MenuHelper.level_up(arg), "completed")
	return true
