class_name HurtBox
extends Area2D

# Called when the node enters the scene tree for the first time.
func _init():
    collision_layer = 0;
    collision_mask = 2;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _on_area_entered(hitbox: HitBox):
    if hitbox == null:
        return
    if owner.has_method("take_hit"):
        var local_position = self.global_position.x
        var other_position = hitbox.global_position.x
        var direction = Vector2(1, 0)
        if local_position > other_position:
            direction = Vector2(1, 0)
        else:
            direction = Vector2(-1, 0)
        var push_force = hitbox.force * direction
        owner.take_hit(push_force)

func _ready():
    self.area_entered.connect(_on_area_entered)
