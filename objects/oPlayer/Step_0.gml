event_inherited()


dir_to = MouseDir()
dirApproach(dir_to)

accelerate(oInput.Hold("up"), dir)

move()


if oInput.Pressed("lclick") {
    Shoot(dir)
}
