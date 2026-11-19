if counter > 180 {
	counter--
	y -= 0.05
} else if counter > 120 && counter <= 180 {
	counter--
	y += 0.05
} else if counter > 60 && counter <= 120{
	counter--
	y+= 0.05
} else if counter > 0 && counter <= 60 {
	counter--
	y -= 0.05
} else if counter = 0 {
	counter = 240
}

