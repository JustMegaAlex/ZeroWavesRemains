
item_template = {

}

var heal_amount = 20
item_heal = {
    heal_amount: heal_amount,
    prompt_text: $"Heal {heal_amount} hp",
    apply: function() {
        oPlayer.heal(heal_amount)
    }
}

