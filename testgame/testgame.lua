local monitor = peripheral.find("monitor")
monitor.setBackgroundColor(colors.black)
monitor.setTextScale(0.5)

local w, h = 18/monitor.getTextScale(), 12/monitor.getTextScale()

local Player = {
    x,
    y,
    vy,
    height = 2/monitor.getTextScale(),
    isAlive
}
function Player:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
local Box = {
    box,
    y,
    width,
    height,
    isOn
}
function Box:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

local Stage = {
    ground = {
        gaprate = 0
    },
    obstacles = {
        obstaclerate = 0
    }
}
function Stage:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Stage:initializeStage(resW, resH)
    for i=1, w / resW + 1, 1 do
        self.ground[i+1] = Box:new({x = i*resW-resW+1, y = h-resH, width = resW, height = resH, isOn = true})
    end
    for i=1, w / resW + 1, 1 do
        self.obstacles[i+1] = Box:new({x = i*resW-resW+1, y = h-resH, width = resW, height = resH, isOn = true})
    end
end

function Player:initializePlayer(resW, resH)
    self.x = resW + resW/2
    self.y = h-resH*3
    self.vy = 0
    self.isAlive = true
end

local function draw(stage, player)
    monitor.setBackgroundColor(colors.white)
    for i=1, player.height+1, 1 do
        monitor.setCursorPos(player.x, player.y+i)
        monitor.write(" ")
    end
    for i=2, #stage.ground, 1 do
        for j=0, stage.ground[i].height, 1 do
            monitor.setCursorPos(stage.ground[i].x, stage.ground[i].y+j)
            monitor.write(string.rep(" ", stage.ground[i].width))
        end
    end
    for i=2, #stage.obstacles, 1 do
        for j=0, stage.obstacles[i].height, 1 do
            monitor.setCursorPos(stage.obstacles[i].x, stage.obstacles[i].y+j)
            monitor.write(string.rep(" ", stage.obstacles[i].width))
        end
    end 
end

local function startup()
    local p = Player:new({})
    local stage = Stage:new({})
    stage.initializeStage(stage, 6, 2)
    p.initializePlayer(p, 6, 2)
    local frame = 0

    while (true) do
        local timer = os.startTimer(0.05)
        local event, side, x, y = os.pullEvent()
        if (event == "monitor_touch") then
            os.cancelTimer(timer)
            monitor.setBackgroundColor(colors.black)
            monitor.setCursorPos(x, y)
            monitor.write("x")
        end
        draw(stage, p)
        monitor.setBackgroundColor(colors.black)
        monitor.setCursorPos(1,1)
        frame = frame + 1
        monitor.write(frame)
    end
end

startup()