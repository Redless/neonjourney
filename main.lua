require("camera")
require("card")
require("mainsquare")
require("matrix")

function love.load()
  love.graphics.setDefaultFilter("nearest","nearest")
  northArrow = love.graphics.newImage("assets/north.png")
  southArrow = love.graphics.newImage("assets/south.png")
  eastArrow = love.graphics.newImage("assets/east.png")
  westArrow = love.graphics.newImage("assets/west.png")
  snorthArrow = love.graphics.newImage("assets/snorth.png")
  ssouthArrow = love.graphics.newImage("assets/ssouth.png")
  seastArrow = love.graphics.newImage("assets/seast.png")
  swestArrow = love.graphics.newImage("assets/swest.png")
  calibrateWindow()
  hand = {card({"N","E","S","S"}),card({"S"}),card({"E"}),card({"W"})}
  bank = {card({"E"}),card({"N"}),card({"E","W"}),card({"E"})}
  setupHandandBank()
  waitTimer = 0
  mode = NORMAL
end

function love.draw()
  drawOutline()
  drawMainSquare()
  drawDeck()
  for i =1,4 do
    drawCard(hand[i])
  end
  for i =1,4 do
    drawCard(bank[i])
  end
end

function love.update()
  if mainsquare.xv > 0 then
    mainsquare.x = mainsquare.x + 1
    mainsquare.xv = mainsquare.xv - 1
  end
  if mainsquare.xv < 0 then
    mainsquare.x = mainsquare.x - 1
    mainsquare.xv = mainsquare.xv + 1
  end
  if mainsquare.yv > 0 then
    mainsquare.y = mainsquare.y + 1
    mainsquare.yv = mainsquare.yv - 1
  end
  if mainsquare.yv < 0 then
    mainsquare.y = mainsquare.y - 1
    mainsquare.yv = mainsquare.yv + 1
  end
  for i = 1,4 do
    updateCardPosition(hand[i])
    updateCardPosition(bank[i])
  end
  if isStill() and (waitTimer > 0) then waitTimer = waitTimer - 1 end
  print(mode, mode == EXECUTING, waitTimer, waitTimer == 0, ((mode == EXECUTING) and (waitTimer == 0)))
  if ((mode == EXECUTING) and (waitTimer == 0)) then
    print("hello")
    executeNext()
  end
end

function love.resize(w, h)
  calibrateWindow()
end

function love.keypressed(key)
  if key == "q" then
    selectCard(1)
  end
  if key == "w" then
    selectCard(2)
  end
  if key == "e" then
    selectCard(3)
  end
  if key == "r" then
    selectCard(4)
  end
  if key == "space" then
    executeAll()
  end
end
