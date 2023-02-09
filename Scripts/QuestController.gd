extends Node


class Quest:
	var id_name: String = ""
	var active: bool = false
	var completed: bool = false
	
	var dependencies: Dictionary = {} 
	var description: String = ""
	
	var dialogic_quest_series_name: String = ""
	var dialogic_quest_started_name: String = ""
	var dialogic_next_quest_avalible_name: String = ""
	var quest_series_number: int = 0
	
	func check_dependencies(quests: Array) -> bool:
		for quest in quests:
			for dependency in dependencies.keys():
				print("Dependency: " + str(dependency))
				if quest.id_name == dependency:
					if !dependencies.get(dependency) == quest.completed:
						return false
					return true
		return false


var quests: Array = []


func _ready() -> void:
	var FatMan1 = Quest.new()
	FatMan1.id_name = "FatMan1"
	FatMan1.description = "Kill 10 chiplings"
	FatMan1.dependencies = {
		"FatMan1": false
	}
	FatMan1.dialogic_quest_series_name = "Npc/FatMan/FatManCurrentQuest"
	FatMan1.dialogic_quest_started_name = "Npc/FatMan/FatManQuestStarted"
	FatMan1.dialogic_next_quest_avalible_name = "Npc/FatMan/FatManNextQuestAvalible"
	FatMan1.quest_series_number = 1
	quests.append(FatMan1)
	
	
	var FatMan2 = Quest.new()
	FatMan2.id_name = "FatMan2"
	FatMan2.description = "Kill 10 chiplings"
	FatMan2.dependencies = {
		"FatMan1": true,
		"FatMan2": false
	}
	FatMan2.dialogic_quest_series_name = "Npc/FatMan/FatManCurrentQuest"
	FatMan2.dialogic_quest_started_name = "Npc/FatMan/FatManQuestStarted"
	FatMan2.dialogic_next_quest_avalible_name = "Npc/FatMan/FatManNextQuestAvalible"
	FatMan2.quest_series_number = 2
	quests.append(FatMan2)
	
	
	var Quest3 = Quest.new()
	Quest3.id_name = "Quest3"
	Quest3.description = "Linus mamma"
	Quest3.dependencies = {
		"Quest2": true,
		"Quest3": true
		}
	quests.append(Quest3)


func start_quest(string) -> void:
	for quest in quests:
		if quest.id_name == string:
			if quest.check_dependencies(quests):
				Dialogic.set_variable(quest.dialogic_quest_started_name, "true")
				Dialogic.set_variable(quest.dialogic_quest_series_name, str(quest.quest_series_number))
				check_and_set_quest_objectives(quest.id_name)
				quest.active = true
				print("Quest started: " + quest.id_name)
				return


var chiplings_killed_start: int


func check_and_set_quest_objectives(string: String) -> void:
	var quest: Quest
	for quest_item in quests:
		if quest_item.id_name == string:
			quest = quest_item
	
	# FatMan1 quest objective
	# Quest init
	if quest.id_name == "FatMan1" and !quest.active:
		print("Quest start")
		Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "false")
		chiplings_killed_start = Stats.chiplings_killed
	
	# Quest done check
	elif quest.id_name == "FatMan1" and quest.active:
		print("Quest check")
		if Stats.chiplings_killed - chiplings_killed_start >= 2:
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "true")
			Dialogic.set_variable("Npc/FatMan/FatManQuestStarted", "false")
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuest", "2")
			quest.completed = true
			PlayerGlobals.coins += 100
	
	# FatMan1 quest objective
	# Quest init
	if quest.id_name == "FatMan2" and !quest.active:
		print("Quest start")
		Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "false")
		chiplings_killed_start = Stats.chiplings_killed
	
	# Quest done check
	elif quest.id_name == "FatMan2" and quest.active:
		print("Quest check")
		if Stats.chiplings_killed - chiplings_killed_start >= 2:
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "true")
			Dialogic.set_variable("Npc/FatMan/FatManQuestStarted", "false")
			quest.completed = true
			PlayerGlobals.coins += 100


func check_dependencies(string: String):
	for quest in quests:
		if quest.id_name == string:
			if quest.check_dependencies(quests):
				Dialogic.set_variable(quest.dialogic_next_quest_avalible_name, "true")
			else:
				Dialogic.set_variable(quest.dialogic_next_quest_avalible_name, "false")
