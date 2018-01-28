require("camera")
require("card")
require("mainsquare")
require("matrix")

function love.load()
  northArrow = love.graphics.newImage("assets/north.png")
  southArrow = love.graphics.newImage("assets/south.png")
  eastArrow = love.graphics.newImage("assets/east.png")
  westArrow = love.graphics.newImage("assets/west.png")
  calibrateWindow()
  hand = {card({"N"}),card({"S"}),card({"E"}),card({"W"})}
  for i = 1,4 do
    dropCard(hand[i],.7+2.2*(i-1),12.5)
  end
end

function love.draw()
  drawOutline()
  drawMainSquare()
  drawDeck()
  for i =1,4 do
    drawCard(hand[i])
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
  end
end

function love.resize(w, h)
  calibrateWindow()
end

function love.keypressed(key)
  if key == "s" then
    south()
  end
  if key == "w" then
    north()
  end
  if key == "a" then
    west()
  end
  if key == "d" then
    east()
  end
end
