extends Node2D
class_name PlayerMovement

@export var movement_speed : float = 100;
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	
	var movement_input = get_movement_input();
	position += movement_input * movement_speed * delta;
	
	animate_player_movement(movement_input);
		
func get_movement_input() -> Vector2:
	
	var input_dir : Vector2;
	
	if(Input.is_action_pressed("Left")):
		input_dir.x -= 1;
	if(Input.is_action_pressed("Right")):
		input_dir.x += 1;
	if(Input.is_action_pressed("Up")):
		input_dir.y -= 1;
	if(Input.is_action_pressed("Down")):
		input_dir.y += 1;
		
	input_dir = input_dir.normalized();
	return input_dir;

func animate_player_movement(input_dir : Vector2):
	
	var h_flip = false;
	var animation_string : StringName;
	var any_input : bool = input_dir.length() > 0;
	
	if any_input:
		if(input_dir.y < 0):
			animation_string = "walk_up";
		if(input_dir.y > 0):
			animation_string = "walk_down";
		if(input_dir.x > 0):
			animation_string = "walk_side";
		if(input_dir.x < 0):
			animation_string = "walk_side";
			h_flip = true;
			
			
		animated_sprite_2d.play(animation_string);
		animated_sprite_2d.flip_h = h_flip;
		
	elif !any_input:
		animated_sprite_2d.stop();
		animated_sprite_2d.set_frame_and_progress(3, 0.99);
