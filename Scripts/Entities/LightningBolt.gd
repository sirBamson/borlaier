extends Node2D
"""
Används ej nu
"""

onready var bolt: Line2D = $Bolt

var number_of_points: int = 5

export var origin_position: Vector2 = global_position
export var target_position: Vector2


var random: RandomNumberGenerator = RandomNumberGenerator.new()


func _ready() -> void:
	random.randomize()


func _physics_process(delta: float) -> void:
	bolt.add_point(origin_position)
	bolt.add_point(target_position)
	
	var point_length: Vector2 = (bolt.get_point_position(1) - bolt.get_point_position(0)) / number_of_points
	for number in number_of_points:
		var point_position: Vector2 = point_length.rotated(deg2rad(random.randi_range(-5, 5)))
		print("Added at:" + str(number * point_position))
		bolt.add_point(number * point_position, number + 1)
