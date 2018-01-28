require("camera")
require("card")
require("mainsquare")
require("matrix")

function love.load()
  calibrateWindow()
end

function love.draw()
  drawOutline()
  drawMainSquare()
  drawDeck()
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
