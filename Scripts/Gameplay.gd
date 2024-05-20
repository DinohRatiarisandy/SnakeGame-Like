class_name Gameplay extends Node2D

@onready var head: Head = $Head as Head
@onready var bounds: Bounds = $Bounds as Bounds
@onready var spawner: Spawner = $Spawner as Spawner

var time_between_move := 1000.0
var time_since_last_move := 0.0
var speed := 4000.0
var move_dir := Vector2.ZERO
var snake_parts: Array[SnakePart] = []


func _ready() -> void:
	head.food_eaten.connect(_on_food_eaten)
	head.collide_with_tail.connect(_on_tail_eaten)
	spawner.tail_added.connect(_on_tail_added)

	spawner.spanw_food()
	snake_parts.append(head)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up") and move_dir != Vector2.DOWN:
		move_dir = Vector2.UP
	elif event.is_action_pressed("move_down") and move_dir != Vector2.UP:
		move_dir = Vector2.DOWN
	elif event.is_action_pressed("move_left") and move_dir != Vector2.RIGHT:
		move_dir = Vector2.LEFT
	elif event.is_action_pressed("move_right") and move_dir != Vector2.LEFT:
		move_dir = Vector2.RIGHT


func _physics_process(delta: float) -> void:
	time_since_last_move += delta * speed
	if time_since_last_move >= time_between_move:
		update_snake()
		time_since_last_move = 0.0


func update_snake() -> void:
	var new_pos = head.position + move_dir * Global.GRID_SIZE
	new_pos = bounds.wrap_vector(new_pos)
	head.move_to(new_pos)

	for i in range(1, snake_parts.size()):
		snake_parts[i].move_to(snake_parts[i-1].last_position)


func _on_food_eaten() -> void:
	spawner.call_deferred("spanw_food")
	spawner.call_deferred("spanw_tail", snake_parts[-1].last_position)
	speed += 150.0


func _on_tail_added(tail: Tail) -> void:
	snake_parts.append(tail)


func _on_tail_eaten() -> void:
	print("Game Over")
