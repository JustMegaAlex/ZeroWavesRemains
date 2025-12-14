arr = []
total = 751
repeat total {
    array_push(arr, random(1))
}

pure = 0
sum_ = 0
for (var i = 0; i < array_length(arr); ++i) {
    var val = arr[i]
    sum_ += val
}
pure = sum_ / total

real_scores = []

function estimate_error(judges_num) {
    var error = 0
   repeat 1000 {
       var _sum = 0
       for (var i = 0; i < judges_num; ++i) {
           _sum += arr[i]
       }
       var sc = _sum / judges_num
       error = max(error, abs(pure - sc))
       array_push(real_scores, )
       arr = array_shuffle(arr)
   }
    return error
}
error_20 = estimate_error(20)
error_40 = estimate_error(40)
error_100 = estimate_error(100)
error_300 = estimate_error(300)
