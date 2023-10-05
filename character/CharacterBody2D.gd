extends CharacterBody2D


const SPEED = 300.0
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
@onready var audio_player = $AudioStreamPlayer2D
@onready var audio_player_jump = $AudioStreamPlayer2D_jump
var is_on_floor = false

func punch():
    if orientation == 1:
        animation.play("punch")
        audio_player.play()
    elif orientation == -1:
        animation.play("punch_left")
        audio_player.play()

# func handle_collision(collision: KinematicCollision2D):
#     # Given a KinematicCollision2D object
#     # calculate the appropriate collision response
#     # and return a boolean indicating whether or not the collision is done
#     if not collision:
#         return true
#     var collider = collision.get_collider()
#     var remainder = collision.get_remainder()
#     if collider is StaticBody2D:
#         if collision.get_normal().y < 0:
#             if not is_on_floor:
#                 is_on_floor = true
#                 velocity = velocity.slide(Vector2(0, 1))
# 
#     elif collider is RigidBody2D:
#         print("here")
#         var force = collision.get_normal() * -push_force
#         collider.apply_force(force)
#     return not remainder

func _physics_process(delta):
    # Add the gravity.
    
    if not is_on_floor:
        velocity.y += gravity * delta
    if Input.is_action_just_pressed("punch"):
        punch()
    # Handle Jump.
    if Input.is_action_just_pressed("jump"):
        if is_on_floor:
            velocity.y = JUMP_VELOCITY
            audio_player_jump.play()
            is_on_floor = false

    # Handle character orientation
    if Input.is_action_just_pressed("move_left") and orientation != -1:
        character_sprite.flip_h = true
        effects_sprite.flip_h = true
        orientation = -1
        hitbox.position.x = - hitbox.position.x
        collision_shape.position.x = - collision_shape.position.x
    if Input.is_action_just_pressed("move_right") and orientation != 1:
        orientation = 1
        character_sprite.flip_h = false
        hitbox.position.x = - hitbox.position.x
        collision_shape.position.x = - collision_shape.position.x
        effects_sprite.flip_h = true

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction = Input.get_axis("move_left", "move_right")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

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
