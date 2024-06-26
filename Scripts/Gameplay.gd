class_name Gameplay extends Node2D

"""
	This class is responsable of the main logic of the game.
	- Spanw a new food
	- Growing the snake
	- Update the snake movement
	- Is game over ?
	- Is paused ?
"""

const GAMEOVER_SCN = preload("res://Scenes/game_over.tscn")
const PAUSE_SCN = preload("res://Scenes/pause_screen.tscn")

@onready var head: Head = $Head as Head
@onready var bounds: Bounds = $Bounds as Bounds
@onready var spawner: Spawner = $Spawner as Spawner
@onready var hud: HUD = $HUD as HUD

var time_between_move := 1000.0
var time_since_last_move := 0.0
var speed := 4000.0
var move_dir := Vector2.ZERO
var snake_parts: Array[SnakePart] = []
var gameover_menu: Gameover
var pause_menu: PauseScn
var score: int = 0:
	set(value):
		score = value
		hud.update_score(score)


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
	elif event.is_action_pressed("ui_cancel"):
		pause_game()


func _physics_process(delta: float) -> void:
	time_since_last_move += delta * speed
	if time_since_last_move >= time_between_move:
		update_snake()
		time_since_last_move = 0.0


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		pause_game()


func pause_game() -> void:
	if not pause_menu:
		pause_menu = PAUSE_SCN.instantiate() as PauseScn
		add_child(pause_menu)


func update_snake() -> void:
	"""
		Update the snake direction
	"""
	var new_pos = head.position + move_dir * Global.GRID_SIZE
	new_pos = bounds.wrap_vector(new_pos)
	head.move_to(new_pos)

	for i in range(1, snake_parts.size()):
		snake_parts[i].move_to(snake_parts[i-1].last_position)


func _on_food_eaten() -> void:
	spawner.call_deferred("spanw_food")
	spawner.call_deferred("spanw_tail", snake_parts[-1].last_position)
	speed += 150.0
	score += 1


func _on_tail_added(tail: Tail) -> void:
	"""
		The snake grow
	"""
	snake_parts.append(tail)


func _on_tail_eaten() -> void:
	"""
		Is Game over ?
	"""
	if not gameover_menu:
		gameover_menu = GAMEOVER_SCN.instantiate() as Gameover
		add_child(gameover_menu)
		gameover_menu.set_score(score)
