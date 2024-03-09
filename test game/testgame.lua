local monitor = peripheral.find("monitor")
term.redirect(monitor);
local w, h = 18/monitor.getTextSize(), 12/monitor.getTextSize()

local Player = {
    x,
    y,
    vy,
    height = 2/monitor.getTextSize(),
    isAlive
}
local Box = {
    x,
    y,
    width,
    height,
    isOn
}
local Stage = {
    ground = {
        gaprate = 0
    },
    obstacles = {
        spawnrate = 0
    }
}

function Box:new(o)
    o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Stage:initializeStage(self, resW, resH)
    for i=1, w / resW + 1, 1 do
        table.insert(self.ground, i+1, Box:new(i*resW, h-resH, resW, resH, true))
    end
    for i=1, w / resW + 1, 1 do
        table.insert(self.obstacles, i+1, Box:new(i*resW, h-resH*2, resW, resH, true))
    end
end

function Player:initializePlayer(self, resH)
    self.x, self.y, self.vy, self.isAlive = 4, h-resH*3, 0, true
    return self
end

local function draw(stage, player)
    paintutils.drawLine(player.x, player.y, player.x, player.y-player.height, colors.blue)
    for i = 2, #i, 1 do
        paintutils.drawFilledBox(stage.ground[i].x, stage.ground[i].y, stage.ground[i].x+stage.ground[i].width, stage.ground.y[i]-stage.ground.y[i].height)
    end
end

local function startup()
    local p
    local stage
    stage.initializeStage(stage, 6, 2)
    p.initializePlayer(p, 2)
    while (true) do
        draw()
    end
end

startup()