

dbg_section("Lighting", true)
DebugViewAddRefs(oNMLighting, [
    ["light_z", dbg_slider, -1000, 300],
])
/// refs for in-struct variables
DebugViewAddRefs([oNMLighting, "ambience"], [
    ["r", dbg_slider, 0, 255],
    ["g", dbg_slider, 0, 255],
    ["b", dbg_slider, 0, 255],
])
