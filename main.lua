require("camera")
require("card")
require("cleanup")
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
  hand = {card({"N","E","S","S"}),card({"dS"}),card({"E"}),card({"W"})}
  bank = {card({"E"}),card({"N"}),card({"E","W"}),card({"E"})}
  setupHandandBank()
  waitTimer = 0
  mode = NORMAL
end

function love.draw()
  drawOutline()
  for i =1,5 do
    for j =1,5 do
      drawTile(i,j)
    end
  end
  drawMainSquare()
  drawDeck()
  if not (mode == RESHUFFLE) then
    for i =1,4 do
      drawCard(hand[i])
    end
  end
  for i =1,4 do
    drawCard(bank[i])
  end
  for i =1,table.getn(deck) do
    drawCard(deck[i])
  end
  for i =1,table.getn(discard) do
    drawCard(discard[i])
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
    if not (mode == RESHUFFLE) then
      updateCardPosition(hand[i])
    end
    updateCardPosition(bank[i])
  end
  for i = 1,table.getn(discard) do
    updateCardPosition(discard[i])
  end
  if isStill() and canSlide then
    if not (matrix[mainsquare.x/10][mainsquare.y/10] == 0) then
      sicom(matrix[mainsquare.x/10][mainsquare.y/10])()
      matrix[mainsquare.x/10][mainsquare.y/10] = 0 --here's where we'll actually have the durability decrease
      waitTimer = 5
    end
  end
  if isStill() and (waitTimer > 0) then waitTimer = waitTimer - 1 end
  if ((mode == EXECUTING) and (waitTimer == 0)) then
    executeNext()
  end
  if ((mode == RESHUFFLE) and (waitTimer == 0)) then
    for i = 1,4 do
      if (table.getn(deck) == 0) then
        reshuffleIntoDeck()
      end
      table.insert(hand,table.remove(deck,love.math.random(table.getn(deck))))
      hand[i].active = {}
      for j =1,table.getn(hand[i].text) do
        table.insert(hand[i].active,true)
      end
    end

    mode = NORMAL
    indexSelected = nil
    setupHandandBank()
  end
end

function love.resize(w, h)
  calibrateWindow()
end

function love.keypressed(key)
  if ((key == "q") and (mode == NORMAL)) then
    selectCard(1)
  end
  if ((key == "w") and (mode == NORMAL)) then
    selectCard(2)
  end
  if ((key == "e") and (mode == NORMAL)) then
    selectCard(3)
  end
  if ((key == "r") and (mode == NORMAL)) then
    selectCard(4)
  end
  if ((key == "space") and (mode == NORMAL)) then
    executeAll()
  end
end
