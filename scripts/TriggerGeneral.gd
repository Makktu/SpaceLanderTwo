extends Area2D


func _on_TriggerGeneral_body_entered(body: Node) -> void:
	if body.name == 'player':
		print('TRIGGERRRRR')
		if !$"/root/Global".enemy_surround:
			$"/root/Global".enemy_surround = true
			$"/root/Global".global_amount_to_be_spawned = 30
			$"/root/Global".global_spawn_delay = 1
			$"/root/Global".basic_enemy_speed = 250
			$"/root/Global".reset_global_values()
