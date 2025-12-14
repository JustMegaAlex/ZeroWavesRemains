votes = []
total_voters = 751
// Assume all votes are random
repeat total_voters {
    array_push(votes, random(1))
}

pure_score = 0
sum_ = 0
for (var i = 0; i < array_length(votes); ++i) {
    var val = votes[i]
    sum_ += val
}
pure_score = sum_ / total_voters


function estimate_error(judges_num) {
    var error = 0
    repeat 1000 {
       var _sum = 0
       for (var i = 0; i < judges_num; ++i) {
           _sum += votes[i]
       }
       var _score = _sum / judges_num
       error = max(error, abs(pure_score - _score))
       votes = array_shuffle(votes) // randomise voters for the next "measurement"
    }
    return error
}
error_20 = estimate_error(20)
error_40 = estimate_error(40)
error_100 = estimate_error(100)
error_300 = estimate_error(300)
