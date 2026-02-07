event_inherited()

if is_used {
    x = lerp(x, oShop.x, 0.1)
    y = lerp(y, oShop.y, 0.1)
    if InstDist(oShop) < 10 {
        instance_destroy()
    }
}
