extends RigidBody2D

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@export var damping_factor = 0.0
@onready var audio_manager = $AudioManager
#test
#func _on_timer_timeout():
#    label.text = "KALM"

func handle_collision(body):
    pass
    # if body is CharacterBody2D:
    #     print("initial velocity: ", body.velocity)
    #     body.velocity = body.velocity * (1 - damping_factor)
    #     print("final velocity: ", body.velocity)

func _ready():
    body_entered.connect(handle_collision)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass




func take_hit(push_force: Vector2):
    if push_force.x > 0:
        sprite.flip_h = false
    else:
        sprite.flip_h = true

    apply_impulse(push_force)
    animation.play("take_punch")
    audio_manager.play_fx("bag")
