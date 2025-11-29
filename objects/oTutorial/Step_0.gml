
step.step()
if step.done() {
    step_index++
    if step_index >= array_length(steps) {
        step = step_template
        finishTutorial()
    } else {
        step.end_()
        step = steps[step_index]
        step.start()
    }
}
