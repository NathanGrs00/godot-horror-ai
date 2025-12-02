extends TextureProgressBar

var max_stamina := 2.0

func update_stamina(current_stamina: float):
	value = (current_stamina / max_stamina) * 100
