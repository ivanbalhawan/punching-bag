extends CharacterBody2D


const ACCELERATION = 10
const TOP_SPEED = 800.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var orientation = 1
@onready var hitbox = $HitBox/CollisionShape2D
@onready var collision_shape = $CollisionShape2D
@onready var character_sprite = $character_sprite
@onready var effects_sprite = $effects_sprite
@onready var animation = $AnimationPlayer
@export var push_force = 300
@export var max_collisions = 100
@onready var audio_grunt = $AudioStreamPlayer2D_punch
@onready var audio_jump = $AudioStreamPlayer2D_jump
var is_on_floor = false


func _ready():
    animation.set_autoplay("idle")
        
func punch():
    animation.play("punch")

func _physics_process(delta):
    if not is_on_floor:
        velocity.y += gravity * delta
    if Input.is_action_just_pressed("punch"):
        punch()
    # Handle Jump.
    if Input.is_action_just_pressed("jump"):
        if is_on_floor:
            velocity.y = JUMP_VELOCITY
            audio_jump.play()
            is_on_floor = false

    # Handle character orientation
    if Input.is_action_just_pressed("move_left") and orientation != -1:
        orientation = -1
        scale.x = -scale.x
    if Input.is_action_just_pressed("move_right") and orientation != 1:
        orientation = 1
        scale.x = -scale.x

    var direction = Input.get_axis("move_left", "move_right")
    if direction:
        if (
            animation.get_current_animation() == "idle"
            or not animation.is_playing()
        ):
            animation.stop()
            animation.play("run")
        velocity.x = move_toward(velocity.x, (direction * TOP_SPEED), ACCELERATION)
    else:
        if (
            animation.get_current_animation() == "run"
            or not animation.is_playing()
        ):
            animation.stop()
            animation.play("idle")
        velocity.x = move_toward(velocity.x, 0, ACCELERATION)

    var collision = move_and_collide(velocity * delta)
    if collision:
        var collider = collision.get_collider()
        if collider is StaticBody2D:
            if collision.get_normal().y < 0:
                if not is_on_floor:
                    is_on_floor = true
                    velocity = velocity.slide(Vector2(0, 1))

            


    # for i in get_slide_collision_count():
    #     var collision = get_slide_collision(i)
    #     if collision.get_collider() is RigidBody2D:
    #         var collision_normal = collision.get_normal()
    #         if collision_normal.y > 0.9:

    #         collision.get_collider().apply_force(collision.get_normal() * -push_force)

func _on_timer_timeout():
    hitbox.set_disabled(true)
