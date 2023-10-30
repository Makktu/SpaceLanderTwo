extends Area2D

func _on_Boss_Trigger_body_entered(body: Node) -> void:
	if body.name == 'player':
		$"/root/Global".boss_active = true
