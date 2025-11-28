
step.step()
if step.done() {
    step_index++
    if step_index >= array_length(steps) {
        step = step_template
    } else {
        step = steps[step_index]
    }
}
