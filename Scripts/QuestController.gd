extends Node


"""
En klass för quests
Används som en blueprint för att skapa alla quests.

Innehåller även en funktion som kollar om alla "dependencies" uppfylls.
Denna funktion tar in en lista av alla quests och retunerar antingen false om
det finns dependencies som inte uppfylls och annars retunerar true.
"""

class Quest:
	var id_name: String = ""
	var active: bool = false
	var completed: int = 0
	
	var dependencies: Dictionary = {} 
	var description: String = ""
	
	var dialogic_quest_series_name: String = ""
	var dialogic_quest_started_name: String = ""
	var dialogic_next_quest_avalible_name: String = ""
	var quest_series_number: int = 0
	
	func check_dependencies(quests: Array) -> bool:
		for dependency in dependencies.keys():
			for quest in quests:
				print("Dependency: %s | Quest id: %s" % [dependency, quest.id_name])
				if quest.id_name == dependency:
					print("Checking dependency for %s" % quest.id_name)
					if dependencies.get(dependency) == 0:
						if !(quest.completed == 0):
							print("Quest dependency check failed at 0")
							print("Dependency: %s | Status: %s" % [dependency, quest.completed])
							return false
					if dependencies.get(dependency) == 1:
						if !(quest.completed == 1):
							print("Quest dependency check failed at 1")
							print("Dependency: %s | Status: %s" % [dependency, quest.completed])
							return false
					if dependencies.get(dependency) == 2:
						if !(quest.completed == 2):
							print("Quest dependency check failed at 2")
							print("Dependency: %s | Status: %s" % [dependency, quest.completed])
							return false
		print("Quest dependency check OK")
		return true



var quests: Array = []

# Fatman quests
var FatMan1: Quest = Quest.new()
var FatMan2: Quest = Quest.new()

var FatMan_dialogic: Dictionary = {}
var FatMan1_dict: Dictionary = {}
var FatMan2_dict: Dictionary = {}

# Bartender2 quests
var Bartender21: Quest = Quest.new()

var Bartender2_dialogic: Dictionary = {}
var Bartender21_dict: Dictionary = {}

# Mohamed quests
var Mohamed1: Quest = Quest.new()

var Mohamed_dialogic: Dictionary = {}
var Mohamed1_dict: Dictionary = {}

# FlatCap quests
var FlatCap1: Quest = Quest.new()

var FlatCap_dialogic: Dictionary = {}
var FlatCap1_dict: Dictionary = {}


"""
Förbereder och sätter upp alla quests
"""

func _ready() -> void:
	FatMan1.id_name = "FatMan1"
	FatMan1.description = "Kill 20 chiplings"
	FatMan1.dependencies = {}
	FatMan1.dialogic_quest_series_name = "Npc/FatMan/FatManCurrentQuest"
	FatMan1.dialogic_quest_started_name = "Npc/FatMan/FatManQuestStarted"
	FatMan1.dialogic_next_quest_avalible_name = "Npc/FatMan/FatManNextQuestAvalible"
	FatMan1.quest_series_number = 1
	quests.append(FatMan1)
	
	
	FatMan2.id_name = "FatMan2"
	FatMan2.description = "Kill 20 chiplings"
	FatMan2.dependencies = {
		"FatMan1": 1,
		"Bartender21": 1
	}
	FatMan2.dialogic_quest_series_name = "Npc/FatMan/FatManCurrentQuest"
	FatMan2.dialogic_quest_started_name = "Npc/FatMan/FatManQuestStarted"
	FatMan2.dialogic_next_quest_avalible_name = "Npc/FatMan/FatManNextQuestAvalible"
	FatMan2.quest_series_number = 2
	quests.append(FatMan2)
	
	
	Bartender21.id_name = "Bartender21"
	Bartender21.description = "Get a drink"
	Bartender21.dependencies = {
		"FatMan1": 1
	}
	Bartender21.dialogic_quest_series_name = "Npc/Bartender2/Bartender2CurrentQuest"
	Bartender21.dialogic_quest_started_name = "Npc/Bartender2/Bartender2QuestStarted"
	Bartender21.dialogic_next_quest_avalible_name = "Npc/Bartender2/Bartender2NextQuestAvalible"
	Bartender21.quest_series_number = 1
	quests.append(Bartender21)
	
	
	Mohamed1.id_name = "Mohamed1"
	Mohamed1.description = "Get a drink"
	Mohamed1.dependencies = {
		"Bartender21": 2
	}
	Mohamed1.dialogic_quest_series_name = "Npc/Mohamed/MohamedCurrentQuest"
	Mohamed1.dialogic_quest_started_name = "Npc/Mohamed/MohamedQuestStarted"
	Mohamed1.dialogic_next_quest_avalible_name = "Npc/Mohamed/MohamedNextQuestAvalible"
	Mohamed1.quest_series_number = 1
	quests.append(Mohamed1)
	
	
	FlatCap1.id_name = "FlatCap1"
	FlatCap1.description = "Bounka"
	FlatCap1.dependencies = {}
	FlatCap1.dialogic_quest_series_name = "Npc/FlatCap/FlatCapCurrentQuest"
	FlatCap1.dialogic_quest_started_name = "Npc/FlatCap/FlatCapQuestStarted"
	FlatCap1.dialogic_next_quest_avalible_name = "Npc/FlatCap/FlatCapNextQuestAvalible"
	FlatCap1.quest_series_number = 1
	quests.append(FlatCap1)


"""
Kallas av dialogic och försöker starta quest.
Kollar om questet har rätt behörigheter
Funktionen tar in en string som är namnet på det quest som ska aktiveras.
"""

func start_quest(string) -> void:
	for quest in quests:
		if quest.id_name == string:
			if quest.check_dependencies(quests):
				Dialogic.set_variable(quest.dialogic_quest_started_name, "true")
				Dialogic.set_variable(quest.dialogic_quest_series_name, str(quest.quest_series_number))
				quest.active = true
				check_and_set_quest_objectives(quest.id_name)
			else:
				print("Could not start quest")


"""
En funktion som körs av både koden och dialogic.
Används för att aktivera quest.

Används också för att kolla om varje quest uppfyller en custom made quest objective.
Om questet är klarat så sätts några dialogic variablar som sedan används i dialog systemet.

Denna funktion tar in en string vilket symboliserar namnet av det quest som ska kollas.
"""
var bullet_man_killed_start: int = 0
var chiplings_killed_start: int = 0
func check_and_set_quest_objectives(string: String) -> void:
	var quest: Quest
	for quest_item in quests:
		if quest_item.id_name == string:
			quest = quest_item
	
	# FatMan1 quest objective
	# Quest init
	if quest.id_name == "FatMan1" and !quest.active:
		Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "false")
		quest.completed = 2
		chiplings_killed_start = Stats.chiplings_killed
	
	# Quest done check
	elif quest.id_name == "FatMan1" and quest.active:
		if Stats.chiplings_killed - chiplings_killed_start >= 2:
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "true")
			Dialogic.set_variable("Npc/FatMan/FatManQuestStarted", "false")
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuest", "2")
			quest.completed = 1
			PlayerGlobals.give_next_keycard(2)
	
	# FatMan2 quest objective
	# Quest init
	if quest.id_name == "FatMan2" and !quest.active:
		Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "false")
		quest.completed = 2
		chiplings_killed_start = Stats.chiplings_killed
	
	# Quest done check
	elif quest.id_name == "FatMan2" and quest.active:
		if Stats.chiplings_killed - chiplings_killed_start >= 40:
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "true")
			Dialogic.set_variable("Npc/FatMan/FatManQuestStarted", "false")
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuest", "3")
			quest.completed = 1
			PlayerGlobals.coins += 200
	
	# Bartender21 quest objective
	# Quest init
	if quest.id_name == "Bartender21" and !quest.active:
		Dialogic.set_variable("Npc/Bartender2/Bartender2CurrentQuestDone", "false")
		quest.completed = 2
		chiplings_killed_start = Stats.chiplings_killed
	
	# Quest done check
	elif quest.id_name == "Bartender21" and quest.active:
		if Mohamed1.completed == 1:
			Dialogic.set_variable("Npc/Bartender2/Bartender2CurrentQuestDone", "true")
			Dialogic.set_variable("Npc/Bartender2/Bartender2QuestStarted", "false")
			Dialogic.set_variable("Npc/Bartender2/Bartender2CurrentQuest", "2")
			quest.completed = 1
			PlayerGlobals.coins += 250
	
	# Mohamed1 quest objective
	# Quest init
	if quest.id_name == "Mohamed1" and !quest.active:
		Dialogic.set_variable("Npc/Mohamed/MohamedCurrentQuestDone", "false")
		quest.completed = 2
	
	# Quest done check
	elif quest.id_name == "Mohamed1" and quest.active:
		if Stats.kgbs_times_won > 0:
			Dialogic.set_variable("Npc/Mohamed/MohamedCurrentQuestDone", "true")
			Dialogic.set_variable("Npc/Mohamed/MohamedQuestStarted", "false")
			Dialogic.set_variable("Npc/Mohamed/MohamedCurrentQuest", "2")
			quest.completed = 1
			PlayerGlobals.coins += 250


	# FlatCap1 quest objective
	# Quest init
	if quest.id_name == "FlatCap1" and !quest.active:
		Dialogic.set_variable("Npc/FlatCap/FlatCapCurrentQuestDone", "false")
		quest.completed = 2
		bullet_man_killed_start = Stats.bullet_man_killed
	
	# Quest done check
	elif quest.id_name == "FlatCap1" and quest.active:
		if Stats.bullet_man_killed - bullet_man_killed_start >= 5:
			Dialogic.set_variable("Npc/FlatCap/FlatCapCurrentQuestDone", "true")
			Dialogic.set_variable("Npc/FlatCap/FlatCapQuestStarted", "false")
			Dialogic.set_variable("Npc/FlatCap/FlatCapCurrentQuest", "2")
			quest.completed = 1





"""
Körs av dialogic för att komma åt quest objecten.

Denna funktion tar in en string vilket symboliserar namnet av det quest som ska kollas.
"""

func check_dependencies(string: String):
	for quest in quests:
		if quest.id_name == string:
			if quest.check_dependencies(quests):
				Dialogic.set_variable(quest.dialogic_next_quest_avalible_name, "true")
			else:
				Dialogic.set_variable(quest.dialogic_next_quest_avalible_name, "false")



"""
Dessa två funktioner använda för att spara quest och hämta information.

Detta är nödvändigt då spelet sparas som en .save fil. I detta formatet kan vi
inte spara objeckt och krävs därför att vi plockar isär varje objeckt och lägger
det i en dict.
"""

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
