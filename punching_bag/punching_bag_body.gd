extends RigidBody2D

#@onready var label = $Label
#@onready var timer = $Timer
@onready var animation = $AnimationPlayer

#func _on_timer_timeout():
#    label.text = "KALM"

func _ready():
    pass
#    get_node("Timer").timeout.connect(_on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass




func take_hit(push_force: Vector2):
#    label.text = "PANIK"
    apply_impulse(push_force)
    animation.play("take_punch")
    
#    timer.start()
    # var other_shape_owner = area.shape_find_owner(area_shape_index)
    
