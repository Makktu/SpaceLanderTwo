extends Area2D


func _on_TriggerGeneral_body_entered(body: Node) -> void:
	if body.name == 'player':
		print('TRIGGERRRRR')
