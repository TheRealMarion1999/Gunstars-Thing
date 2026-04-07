extends Enemy

##Perform any unique actions/animations for this entity, then queue free
func destroy():
	super()
	print("dead grunt")

##Used for general enemy logic
func _process(delta: float) -> void:
	if is_on_floor() && $RoamTimer.is_stopped():
		$RoamTimer.start()

##TODO: Maybe try to move this to the superclass? Every character entity will have hitboxes, after all.
func _on_hit_box_area_entered(_area: Area2D) -> void:
	var contacts = $HitBox.get_overlapping_areas()
	for area in contacts:
		if area is Bullet_Base:
			take_damage(area.bullet_type.damage)
			area.destroy()


func _on_roam_timer_timeout() -> void:
	var contacts = $DetectBox.get_overlapping_bodies()
	for body in contacts:
		if body is Player:
			
			print("attack")
	$RoamTimer.start()
