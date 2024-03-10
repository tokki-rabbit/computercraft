local monitor = peripheral.find("monitor")
monitor.setTextScale(0.5)

local colors = {
    [1] = colors.white,
    [2] = colors.orange,
    [3] = colors.magenta,
    [4] = colors.lightBlue,
    [5] = colors.yellow,
    [6] = colors.lime,
    [7] = colors.pink,
    [8] = colors.gray,
    [9] = colors.lightGray,
    [10] = colors.cyan,
    [11] = colors.purple,
    [12] = colors.blue,
    [13] = colors.brown,
    [14] = colors.green,
    [15] = colors.red,
    [16] = colors.black
}

while true do
    sleep(0.05)
    for y=1, 24, 1 do
        for x = 1, 36, 1 do
            monitor.setCursorPos(x,y)
            monitor.setBackgroundColor(colors[math.random(16)])
            monitor.write(" ")
        end
    end
end