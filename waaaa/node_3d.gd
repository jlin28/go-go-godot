extends Node3D

var areas: Array
@export var group: StringName

# $ = get_node()
# % looks up a unique name for a node (same as getDocumentById)
@onready var camera = $Camera3D
@onready var player = $CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	areas = get_tree().get_nodes_in_group('obstacles')

	for i: Area3D in areas:
		i.body_entered.connect(triggered)
		
func triggered(body) -> void:
	if body is CharacterBody3D:
		body.position = Vector3(-2.256,0.535,0)
		print("player contact")
		
func _process(delta):
	camera.global_position.x = player.global_position.x
