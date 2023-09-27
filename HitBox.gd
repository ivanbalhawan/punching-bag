class_name HitBox
extends Area2D


@export var force: int = 500;

# Called when the node enters the scene tree for the first time.
func _init():
    collision_layer = 2;
    collision_mask = 0;

func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
