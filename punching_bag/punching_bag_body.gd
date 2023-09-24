extends RigidBody2D

@onready var label = $Label
@onready var timer = $Timer


func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_timer_timeout():
    label.text = "KALM"


func _on_hurtbox_area_shape_entered(
    area_rid,
    area,
    area_shape_index,
    local_shape_index,
):
    var other_shape_node = area.shape_owner_get_owner(area_shape_index)
    var local_shape_owner = shape_find_owner(local_shape_index)
    var local_shape_node = shape_owner_get_owner(local_shape_owner)
    var local_position_x = local_shape_node.global_position.x
    var other_position_x = other_shape_node.global_position.x
    var impulse_vector

    if local_position_x > other_position_x:
        impulse_vector = Vector2(600, 0)
    else:
        impulse_vector = Vector2(-600, 0)

    label.text = "PANIK"
    apply_impulse(impulse_vector)
    timer.start()
    # var other_shape_owner = area.shape_find_owner(area_shape_index)
    
