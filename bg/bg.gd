extends ParallaxBackground

const SCROLL_SPEED = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.x -= SCROLL_SPEED * delta
