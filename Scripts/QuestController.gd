extends Node


class Quest:
	var id_name: String = ""
	var active: bool = false
	var completed: bool = false
	
	var dependencies: Dictionary = {} 
	var description: String = ""
	
	func check_dependencies(quests: Array) -> bool:
		for quest in quests:
			for dependency in self.dependencies.keys():
				if quest.id_name == dependency:
					if !quest.completed:
						return false
					return true
		return false


var quests: Array = []

func _ready() -> void:
	var Quest1 = Quest.new()
	Quest1.id_name = "Quest1"
	Quest1.description = "The first quest"
	Quest1.dependencies = {
		"Quest2": false,
		"Quest3": false
		}
	quests.append(Quest1)
	
	
	var Quest2 = Quest.new()
	Quest2.id_name = "Quest2"
	Quest1.description = "The second quest"
	Quest2.dependencies = {
		"Quest1": true,
		"Quest3": false
		}
	quests.append(Quest2)
	
	
	var Quest3 = Quest.new()
	Quest3.id_name = "Quest3"
	Quest1.description = "Linus mamma"
	Quest3.dependencies = {
		"Quest2": true,
		"Quest3": true
		}
	quests.append(Quest3)
	
	
	print(Quest1.check_dependencies(quests))
