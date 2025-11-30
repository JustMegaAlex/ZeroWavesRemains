
waves = 30
strength = 1
growth = 1.1
growth_decrease = 0.05 / waves

for i in range(waves):
    strength *= growth
    growth -= growth_decrease
    print(strength)
