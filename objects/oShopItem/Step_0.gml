
// wait until links set up shop tree
if !global.shop_links_initialized { exit }

// animate open/close
var mult = oShop.open_ratio
x = openx * mult
y = openy * mult

if highlight {
    cost_text_struct.color = can_buy_base() ? c_yellow : c_red
}
