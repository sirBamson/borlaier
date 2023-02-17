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

var FatMan1: Quest = Quest.new()
var FatMan2: Quest = Quest.new()

var FatMan_dialogic: Dictionary = {}
var FatMan1_dict: Dictionary = {}
var FatMan2_dict: Dictionary = {}

func _ready() -> void:
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


var chiplings_killed_start: int = 0


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


func get_quest_variables():
	FatMan_dialogic = {
		"FatManCurrentQuestDone": Dialogic.get_variable("Npc/FatMan/FatManCurrentQuestDone"),
		"FatManQuestStarted": Dialogic.get_variable("Npc/FatMan/FatManQuestStarted"),
		"FatManCurrentQuest": Dialogic.get_variable("Npc/FatMan/FatManCurrentQuest")
	}
	
	FatMan1_dict = {
		"Id_name": FatMan1.id_name,
		"Description": FatMan1.description,
		"Dependencies": FatMan1.dependencies,
		"Dialogic_quest_series_name": FatMan1.dialogic_quest_series_name,
		"Dialogic_quest_started_name": FatMan1.dialogic_quest_started_name,
		"Dialogic_next_quest_avalible_name": FatMan1.dialogic_next_quest_avalible_name,
		"Quest_series_number": FatMan1.quest_series_number,
		}
	
	FatMan2_dict = {
		"Id_name": FatMan2.id_name,
		"Description": FatMan2.description,
		"Dependencies": FatMan2.dependencies,
		"Dialogic_quest_series_name": FatMan2.dialogic_quest_series_name,
		"Dialogic_quest_started_name": FatMan2.dialogic_quest_started_name,
		"Dialogic_next_quest_avalible_name": FatMan2.dialogic_next_quest_avalible_name,
		"Quest_series_number": FatMan2.quest_series_number
		}


func set_quest_variables():
	Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", FatMan_dialogic["FatManCurrentQuestDone"])
	Dialogic.set_variable("Npc/FatMan/FatManQuestStarted", FatMan_dialogic["FatManQuestStarted"])
	Dialogic.set_variable("Npc/FatMan/FatManCurrentQuest", FatMan_dialogic["FatManCurrentQuest"])
	
	FatMan1.id_name = FatMan1_dict["Id_name"]
	FatMan1.description = FatMan1_dict["Description"]
	FatMan1.dependencies = FatMan1_dict["Dependencies"]
	FatMan1.dialogic_quest_series_name = FatMan1_dict["Dialogic_quest_series_name"]
	FatMan1.dialogic_quest_started_name = FatMan1_dict["Dialogic_quest_started_name"]
	FatMan1.dialogic_next_quest_avalible_name = FatMan1_dict["Dialogic_next_quest_avalible_name"]
	FatMan1.quest_series_number = FatMan1_dict["Quest_series_number"]
	
	FatMan2.id_name = FatMan2_dict["Id_name"]
	FatMan2.description = FatMan2_dict["Description"]
	FatMan2.dependencies = FatMan2_dict["Dependencies"]
	FatMan2.dialogic_quest_series_name = FatMan2_dict["Dialogic_quest_series_name"]
	FatMan2.dialogic_quest_started_name = FatMan2_dict["Dialogic_quest_started_name"]
	FatMan2.dialogic_next_quest_avalible_name = FatMan2_dict["Dialogic_next_quest_avalible_name"]
	FatMan2.quest_series_number = FatMan2_dict["Quest_series_number"]
