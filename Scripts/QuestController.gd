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

# FlatCap2
var FlatCap21: Quest = Quest.new()
var FlatCap22: Quest = Quest.new()

var FlatCap2_dialogic: Dictionary = {}
var FlatCap21_dict: Dictionary = {}
var FlatCap22_dict: Dictionary = {}

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
		"FlatCap2": 1
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
	
	
	FlatCap21.id_name = "FlatCap21"
	FlatCap21.description = "Help FatMan"
	FlatCap21.dependencies = {}
	FlatCap21.dialogic_quest_series_name = "Npc/FlatCap2/FlatCap2CurrentQuest"
	FlatCap21.dialogic_quest_started_name = "Npc/FlatCap2/FlatCap2QuestStarted"
	FlatCap21.dialogic_next_quest_avalible_name = "Npc/FlatCap2/FlatCap2NextQuestAvalible"
	FlatCap21.quest_series_number = 1
	quests.append(FlatCap21)
	
	
	FlatCap22.id_name = "FlatCap22"
	FlatCap22.description = "Get all weapons"
	FlatCap22.dependencies = {
		"FatMan1": 1,
		"FatMan2": 1,
		"FlatCap21": 1
	}
	FlatCap22.dialogic_quest_series_name = "Npc/FlatCap2/FlatCap2CurrentQuest"
	FlatCap22.dialogic_quest_started_name = "Npc/FlatCap2/FlatCap2QuestStarted"
	FlatCap22.dialogic_next_quest_avalible_name = "Npc/FlatCap2/FlatCap2NextQuestAvalible"
	FlatCap22.quest_series_number = 2
	quests.append(FlatCap22)


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
		if Stats.chiplings_killed - chiplings_killed_start >= 10:
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "true")
			Dialogic.set_variable("Npc/FatMan/FatManQuestStarted", "false")
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuest", "2")
			quest.completed = 1
			PlayerGlobals.give_keycard(2)
	
	# FatMan2 quest objective
	# Quest init
	if quest.id_name == "FatMan2" and !quest.active:
		Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "false")
		quest.completed = 2
		chiplings_killed_start = Stats.chiplings_killed
	
	# Quest done check
	elif quest.id_name == "FatMan2" and quest.active:
		if Stats.chiplings_killed - chiplings_killed_start >= 20:
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", "true")
			Dialogic.set_variable("Npc/FatMan/FatManQuestStarted", "false")
			Dialogic.set_variable("Npc/FatMan/FatManCurrentQuest", "3")
			quest.completed = 1
	
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
			PlayerGlobals.coins += 200
	
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


	# FlatCap1 quest objective
	# Quest init
	if quest.id_name == "FlatCap1" and !quest.active:
		Dialogic.set_variable("Npc/FlatCap/FlatCapCurrentQuestDone", "false")
		quest.completed = 2
		bullet_man_killed_start = Stats.bullet_man_killed
	
	# Quest done check
	elif quest.id_name == "FlatCap1" and quest.active:
		if Stats.bullet_man_killed - bullet_man_killed_start >= 1:
			Dialogic.set_variable("Npc/FlatCap/FlatCapCurrentQuestDone", "true")
			Dialogic.set_variable("Npc/FlatCap/FlatCapQuestStarted", "false")
			Dialogic.set_variable("Npc/FlatCap/FlatCapCurrentQuest", "2")
			
			PlayerGlobals.weapon_tier += 1
			Dialogic.set_variable("Npc/WeaponWoman/WeaponWomanCurrentWeaponTier", str(PlayerGlobals.weapon_tier))
			quest.completed = 1


	# FlatCap21 quest objective
	# Quest init
	if quest.id_name == "FlatCap21" and !quest.active:
		Dialogic.set_variable("Npc/FlatCap2/FlatCap2CurrentQuestDone", "false")
		quest.completed = 2
		
	
	# Quest done check
	elif quest.id_name == "FlatCap21" and quest.active:
		if FatMan1.completed == 1 and FatMan2.completed == 1:
			Dialogic.set_variable("Npc/FlatCap2/FlatCap2CurrentQuestDone", "true")
			Dialogic.set_variable("Npc/FlatCap2/FlatCap2QuestStarted", "false")
			Dialogic.set_variable("Npc/FlatCap2/FlatCap2CurrentQuest", "2")
			
			PlayerGlobals.weapon_tier += 1
			Dialogic.set_variable("Npc/WeaponWoman/WeaponWomanCurrentWeaponTier", str(PlayerGlobals.weapon_tier))
			quest.completed = 1

	# FlatCap22 quest objective
	# Quest init
	if quest.id_name == "FlatCap22" and !quest.active:
		Dialogic.set_variable("Npc/FlatCap2/FlatCap2CurrentQuestDone", "false")
		quest.completed = 2
	
	# Quest done check
	elif quest.id_name == "FlatCap22" and quest.active:
		if PlayerGlobals.weapon_tier > 2:
			Dialogic.set_variable("Npc/FlatCap2/FlatCap2CurrentQuestDone", "true")
			Dialogic.set_variable("Npc/FlatCap2/FlatCap2QuestStarted", "false")
			Dialogic.set_variable("Npc/FlatCap2/FlatCap2CurrentQuest", "3")
			
			PlayerGlobals.give_keycard(3)
			
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
		"Active": FatMan1.active,
		"Completed": FatMan1.completed,
		"Description": FatMan1.description,
		"Dependencies": FatMan1.dependencies,
		"Dialogic_quest_series_name": FatMan1.dialogic_quest_series_name,
		"Dialogic_quest_started_name": FatMan1.dialogic_quest_started_name,
		"Dialogic_next_quest_avalible_name": FatMan1.dialogic_next_quest_avalible_name,
		"Quest_series_number": FatMan1.quest_series_number,
		}
	
	FatMan2_dict = {
		"Id_name": FatMan2.id_name,
		"Active": FatMan2.active,
		"Completed": FatMan2.completed,
		"Description": FatMan2.description,
		"Dependencies": FatMan2.dependencies,
		"Dialogic_quest_series_name": FatMan2.dialogic_quest_series_name,
		"Dialogic_quest_started_name": FatMan2.dialogic_quest_started_name,
		"Dialogic_next_quest_avalible_name": FatMan2.dialogic_next_quest_avalible_name,
		"Quest_series_number": FatMan2.quest_series_number
		}
	
	# ---
	
	Bartender2_dialogic = {
		"Bartender2CurrentQuestDone": Dialogic.get_variable("Npc/Bartender2/Bartender2CurrentQuestDone"),
		"Bartender2QuestStarted": Dialogic.get_variable("Npc/Bartender2/Bartender2QuestStarted"),
		"Bartender2CurrentQuest": Dialogic.get_variable("Npc/Bartender2/Bartender2CurrentQuest")
	}
	
	Bartender21_dict = {
		"Id_name": Bartender21.id_name,
		"Active": Bartender21.active,
		"Completed": Bartender21.completed,
		"Description": Bartender21.description,
		"Dependencies": Bartender21.dependencies,
		"Dialogic_quest_series_name": Bartender21.dialogic_quest_series_name,
		"Dialogic_quest_started_name": Bartender21.dialogic_quest_started_name,
		"Dialogic_next_quest_avalible_name": Bartender21.dialogic_next_quest_avalible_name,
		"Quest_series_number": Bartender21.quest_series_number,
		}
	
	# ---
	
	Mohamed_dialogic = {
		"MohamedCurrentQuestDone": Dialogic.get_variable("Npc/Mohamed/MohamedCurrentQuestDone"),
		"MohamedQuestStarted": Dialogic.get_variable("Npc/Mohamed/MohamedQuestStarted"),
		"MohamedCurrentQuest": Dialogic.get_variable("Npc/Mohamed/MohamedCurrentQuest")
	}
	
	Mohamed1_dict = {
		"Id_name": Mohamed1.id_name,
		"Active": Mohamed1.active,
		"Completed": Mohamed1.completed,
		"Description": Mohamed1.description,
		"Dependencies": Mohamed1.dependencies,
		"Dialogic_quest_series_name": Mohamed1.dialogic_quest_series_name,
		"Dialogic_quest_started_name": Mohamed1.dialogic_quest_started_name,
		"Dialogic_next_quest_avalible_name": Mohamed1.dialogic_next_quest_avalible_name,
		"Quest_series_number": Mohamed1.quest_series_number,
		}
	
	# ---

	FlatCap_dialogic = {
		"FlatCapCurrentQuestDone": Dialogic.get_variable("Npc/FlatCap/FlatCapCurrentQuestDone"),
		"FlatCapQuestStarted": Dialogic.get_variable("Npc/FlatCap/FlatCapQuestStarted"),
		"FlatCapCurrentQuest": Dialogic.get_variable("Npc/FlatCap/FlatCapCurrentQuest")
	}
	
	FlatCap1_dict = {
		"Id_name": FlatCap1.id_name,
		"Active": FlatCap1.active,
		"Completed": FlatCap1.completed,
		"Description": FlatCap1.description,
		"Dependencies": FlatCap1.dependencies,
		"Dialogic_quest_series_name": FlatCap1.dialogic_quest_series_name,
		"Dialogic_quest_started_name": FlatCap1.dialogic_quest_started_name,
		"Dialogic_next_quest_avalible_name": FlatCap1.dialogic_next_quest_avalible_name,
		"Quest_series_number": FlatCap1.quest_series_number,
		}
	# ---

	FlatCap2_dialogic = {
		"FlatCap2CurrentQuestDone": Dialogic.get_variable("Npc/FlatCap2/FlatCap2CurrentQuestDone"),
		"FlatCap2QuestStarted": Dialogic.get_variable("Npc/FlatCap2/FlatCap2QuestStarted"),
		"FlatCap2CurrentQuest": Dialogic.get_variable("Npc/FlatCap2/FlatCap2CurrentQuest")
	}
	
	FlatCap21_dict = {
		"Id_name": FlatCap21.id_name,
		"Active": FlatCap21.active,
		"Completed": FlatCap21.completed,
		"Description": FlatCap21.description,
		"Dependencies": FlatCap21.dependencies,
		"Dialogic_quest_series_name": FlatCap21.dialogic_quest_series_name,
		"Dialogic_quest_started_name": FlatCap21.dialogic_quest_started_name,
		"Dialogic_next_quest_avalible_name": FlatCap21.dialogic_next_quest_avalible_name,
		"Quest_series_number": FlatCap21.quest_series_number,
		}
	
	FlatCap22_dict = {
		"Id_name": FlatCap22.id_name,
		"Active": FlatCap22.active,
		"Completed": FlatCap22.completed,
		"Description": FlatCap22.description,
		"Dependencies": FlatCap22.dependencies,
		"Dialogic_quest_series_name": FlatCap22.dialogic_quest_series_name,
		"Dialogic_quest_started_name": FlatCap22.dialogic_quest_started_name,
		"Dialogic_next_quest_avalible_name": FlatCap22.dialogic_next_quest_avalible_name,
		"Quest_series_number": FlatCap22.quest_series_number,
		}



func set_quest_variables():
	Dialogic.set_variable("Npc/FatMan/FatManCurrentQuestDone", FatMan_dialogic["FatManCurrentQuestDone"])
	Dialogic.set_variable("Npc/FatMan/FatManQuestStarted", FatMan_dialogic["FatManQuestStarted"])
	Dialogic.set_variable("Npc/FatMan/FatManCurrentQuest", FatMan_dialogic["FatManCurrentQuest"])
	
	FatMan1.id_name = FatMan1_dict["Id_name"]
	FatMan1.active = FatMan1_dict["Active"]
	FatMan1.completed = FatMan1_dict["Completed"]
	FatMan1.description = FatMan1_dict["Description"]
	FatMan1.dependencies = FatMan1_dict["Dependencies"]
	FatMan1.dialogic_quest_series_name = FatMan1_dict["Dialogic_quest_series_name"]
	FatMan1.dialogic_quest_started_name = FatMan1_dict["Dialogic_quest_started_name"]
	FatMan1.dialogic_next_quest_avalible_name = FatMan1_dict["Dialogic_next_quest_avalible_name"]
	FatMan1.quest_series_number = FatMan1_dict["Quest_series_number"]
	
	FatMan2.id_name = FatMan2_dict["Id_name"]
	FatMan2.active = FatMan2_dict["Active"]
	FatMan2.completed = FatMan2_dict["Completed"]
	FatMan2.description = FatMan2_dict["Description"]
	FatMan2.dependencies = FatMan2_dict["Dependencies"]
	FatMan2.dialogic_quest_series_name = FatMan2_dict["Dialogic_quest_series_name"]
	FatMan2.dialogic_quest_started_name = FatMan2_dict["Dialogic_quest_started_name"]
	FatMan2.dialogic_next_quest_avalible_name = FatMan2_dict["Dialogic_next_quest_avalible_name"]
	FatMan2.quest_series_number = FatMan2_dict["Quest_series_number"]
	
	# ---
	
	Dialogic.set_variable("Npc/Bartender2/Bartender2CurrentQuestDone", Bartender2_dialogic["Bartender2CurrentQuestDone"])
	Dialogic.set_variable("Npc/Bartender2/Bartender2QuestStarted", Bartender2_dialogic["Bartender2QuestStarted"])
	Dialogic.set_variable("Npc/Bartender2/Bartender2CurrentQuest", Bartender2_dialogic["Bartender2CurrentQuest"])
	
	Bartender21.id_name = Bartender21_dict["Id_name"]
	Bartender21.active = Bartender21_dict["Active"]
	Bartender21.completed = Bartender21_dict["Completed"]
	Bartender21.description = Bartender21_dict["Description"]
	Bartender21.dependencies = Bartender21_dict["Dependencies"]
	Bartender21.dialogic_quest_series_name = Bartender21_dict["Dialogic_quest_series_name"]
	Bartender21.dialogic_quest_started_name = Bartender21_dict["Dialogic_quest_started_name"]
	Bartender21.dialogic_next_quest_avalible_name = Bartender21_dict["Dialogic_next_quest_avalible_name"]
	Bartender21.quest_series_number = Bartender21_dict["Quest_series_number"]

	# ---
	
	Dialogic.set_variable("Npc/Mohamed/MohamedCurrentQuestDone", Mohamed_dialogic["MohamedCurrentQuestDone"])
	Dialogic.set_variable("Npc/Mohamed/MohamedQuestStarted", Mohamed_dialogic["MohamedQuestStarted"])
	Dialogic.set_variable("Npc/Mohamed/MohamedCurrentQuest", Mohamed_dialogic["MohamedCurrentQuest"])
	
	Mohamed1.id_name = Mohamed1_dict["Id_name"]
	Mohamed1.active = Mohamed1_dict["Active"]
	Mohamed1.completed = Mohamed1_dict["Completed"]
	Mohamed1.description = Mohamed1_dict["Description"]
	Mohamed1.dependencies = Mohamed1_dict["Dependencies"]
	Mohamed1.dialogic_quest_series_name = Mohamed1_dict["Dialogic_quest_series_name"]
	Mohamed1.dialogic_quest_started_name = Mohamed1_dict["Dialogic_quest_started_name"]
	Mohamed1.dialogic_next_quest_avalible_name = Mohamed1_dict["Dialogic_next_quest_avalible_name"]
	Mohamed1.quest_series_number = Mohamed1_dict["Quest_series_number"]

	# ---
	
	Dialogic.set_variable("Npc/FlatCap/FlatCapCurrentQuestDone", FlatCap_dialogic["FlatCapCurrentQuestDone"])
	Dialogic.set_variable("Npc/FlatCap/FlatCapQuestStarted", FlatCap_dialogic["FlatCapQuestStarted"])
	Dialogic.set_variable("Npc/FlatCap/FlatCapCurrentQuest", FlatCap_dialogic["FlatCapCurrentQuest"])
	
	FlatCap1.id_name = FlatCap1_dict["Id_name"]
	FlatCap1.active = FlatCap1_dict["Active"]
	FlatCap1.completed = FlatCap1_dict["Completed"]
	FlatCap1.description = FlatCap1_dict["Description"]
	FlatCap1.dependencies = FlatCap1_dict["Dependencies"]
	FlatCap1.dialogic_quest_series_name = FlatCap1_dict["Dialogic_quest_series_name"]
	FlatCap1.dialogic_quest_started_name = FlatCap1_dict["Dialogic_quest_started_name"]
	FlatCap1.dialogic_next_quest_avalible_name = FlatCap1_dict["Dialogic_next_quest_avalible_name"]
	FlatCap1.quest_series_number = FlatCap1_dict["Quest_series_number"]

	# ---
	
	Dialogic.set_variable("Npc/FlatCap2/FlatCap2CurrentQuestDone", FlatCap2_dialogic["FlatCap2CurrentQuestDone"])
	Dialogic.set_variable("Npc/FlatCap2/FlatCap2QuestStarted", FlatCap2_dialogic["FlatCap2QuestStarted"])
	Dialogic.set_variable("Npc/FlatCap2/FlatCap2CurrentQuest", FlatCap2_dialogic["FlatCap2CurrentQuest"])
	
	FlatCap21.id_name = FlatCap21_dict["Id_name"]
	FlatCap21.active = FlatCap21_dict["Active"]
	FlatCap21.completed = FlatCap21_dict["Completed"]
	FlatCap21.description = FlatCap21_dict["Description"]
	FlatCap21.dependencies = FlatCap21_dict["Dependencies"]
	FlatCap21.dialogic_quest_series_name = FlatCap21_dict["Dialogic_quest_series_name"]
	FlatCap21.dialogic_quest_started_name = FlatCap21_dict["Dialogic_quest_started_name"]
	FlatCap21.dialogic_next_quest_avalible_name = FlatCap21_dict["Dialogic_next_quest_avalible_name"]
	FlatCap21.quest_series_number = FlatCap21_dict["Quest_series_number"]
	
	FlatCap22.id_name = FlatCap22_dict["Id_name"]
	FlatCap22.active = FlatCap22_dict["Active"]
	FlatCap22.completed = FlatCap22_dict["Completed"]
	FlatCap22.description = FlatCap22_dict["Description"]
	FlatCap22.dependencies = FlatCap22_dict["Dependencies"]
	FlatCap22.dialogic_quest_series_name = FlatCap22_dict["Dialogic_quest_series_name"]
	FlatCap22.dialogic_quest_started_name = FlatCap22_dict["Dialogic_quest_started_name"]
	FlatCap22.dialogic_next_quest_avalible_name = FlatCap22_dict["Dialogic_next_quest_avalible_name"]
	FlatCap22.quest_series_number = FlatCap22_dict["Quest_series_number"]
