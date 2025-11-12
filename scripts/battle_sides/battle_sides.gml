
//// Define somewhere
//enum BattleSides {
    //non_hitable,
    //ours,
    //theirs,
    //neutral,
//}

function SetFriendlyWith(side) {
    friendly_with |= power(2, side)
}

function InitBattleSide(my_side, friendly_arr=[]) {
    side = my_side
    for (var i = 0; i < array_length(friendly_arr); i++) {
        SetFriendlyWith(friendly_arr[i])
    }
}

function IsEnemySide(inst) {
    var _side = inst.side != side
    var _friendly_with = !(power(2, side) & inst.friendly_with)
    var _side_friendly_with = !(friendly_with & power(2, inst.side))
    return _side and _friendly_with and _side_friendly_with
}
