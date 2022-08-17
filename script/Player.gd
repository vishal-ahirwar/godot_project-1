extends Area2D

signal hurt
signal pickup

export var speed:int
var velocity:Vector2
var screenSize:Vector2=Vector2(480,720)

func _ready():
	print(screenSize)

func get_input():
	velocity=Vector2()
	if(Input.is_action_pressed("ui_left")):
		velocity.x-=1
	if(Input.is_action_pressed("ui_right")):
		velocity.x+=1
	if(Input.is_action_pressed("ui_up")):
		velocity.y-=1
	if(Input.is_action_pressed("ui_down")):
		velocity.y+=1
	
	if(velocity.length()>0):
		$player_body.animation="run"
		$player_body.flip_h=velocity.x<0
		velocity=velocity.normalized()*speed
	else:
		$player_body.animation="idle"

func _process(delta):
	get_input()
	position+=velocity*delta
	position.x=clamp(position.x,0,screenSize.x)
	position.y=clamp(position.y,0,screenSize.y)
	
		

func Start(pos:Vector2):
	set_process(true)
	position=pos
	$player_body.animation="idle"

func Die():
	set_process(false)
	$player_body.animation="hurt"
	


func _on_Player_area_entered(area):
	if(area.is_in_group("coins")):
		area.pickup()
		emit_signal("pickup")
	if(area.is_in_group("obstacles")):
		emit_signal("hurt")
		Die()
		
	#pass # Replace with function body.
