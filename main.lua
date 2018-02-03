require("camera")
require("card")
require("cleanup")
require("mainsquare")
require("matrix")
require("menu")

totalScore = 0
gamesPlayed = 1

function love.load()
  loadFile()
  menubg = love.graphics.newImage("assets/neonjourneylogo.png")
  love.graphics.setDefaultFilter("nearest","nearest")
  mX = love.graphics.newImage("assets/mX.png")
  mnorthArrow = love.graphics.newImage("assets/midarrown.png")
  msouthArrow = love.graphics.newImage("assets/midarrows.png")
  meastArrow = love.graphics.newImage("assets/midarrowe.png")
  mwestArrow = love.graphics.newImage("assets/midarroww.png")
  northArrow = love.graphics.newImage("assets/north.png")
  southArrow = love.graphics.newImage("assets/south.png")
  eastArrow = love.graphics.newImage("assets/east.png")
  westArrow = love.graphics.newImage("assets/west.png")
  snorthArrow = love.graphics.newImage("assets/snorth.png")
  ssouthArrow = love.graphics.newImage("assets/ssouth.png")
  seastArrow = love.graphics.newImage("assets/seast.png")
  swestArrow = love.graphics.newImage("assets/swest.png")
  blockedSpace = love.graphics.newImage("assets/X.png")
  fixer = love.graphics.newImage("assets/fixer.png")
  sfixer = love.graphics.newImage("assets/sfixer.png")
  doubleNorth = love.graphics.newImage("assets/dnorth.png")
  doubleEast = love.graphics.newImage("assets/deast.png")
  doubleSouth = love.graphics.newImage("assets/dsouth.png")
  doubleWest = love.graphics.newImage("assets/dwest.png")
  sdoubleNorth = love.graphics.newImage("assets/sdnorth.png")
  sdoubleSouth = love.graphics.newImage("assets/sdsouth.png")
  sdoubleEast = love.graphics.newImage("assets/sdeast.png")
  sdoubleWest = love.graphics.newImage("assets/sdwest.png")
  tutorialimg = love.graphics.newImage("assets/tutorial.png")
  creditsimg = love.graphics.newImage("assets/credits.png")
  digits = {}
  for i=0,9 do
    table.insert(digits,love.graphics.newImage("assets/"..i..".png"))
  end
  bgm = love.audio.newSource("assets/day 27.mp3")
  bgm:play()

  calibrateWindow()
  hand = {card({"xN","EE","xS"},0),card({"NN"},0),card({"EE"},0),card({"W","S"},0)}
  bank = {card({"SS","EE","NN","WW"},0),card({"dN"},0),card({"xW"},0),card({"F"},0)}
  setupHandandBank()
  waitTimer = 0
  fiximageTimer = 0
  mode = MENU
  turnCounter = 0
end

function love.draw()
  if mode == MENU then
    drawMenu()
    return
  end
  if mode == TUTORIAL then
    drawTutorial()
    return
  end
  if mode == CREDITS then
    drawCredits()
    return
  end
  drawOutline()
  for i =1,7 do
    for j =1,7 do
      if not (mode == GAMEOVER) then
        drawTile(i,j)
      end
    end
  end
  if not (mode == GAMEOVER) then
    drawMainSquare()
  end
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
  drawTimer()
  drawFixer()
  love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), movedown)
	love.graphics.rectangle("fill", 0, 0, moveside, love.graphics.getHeight())
	love.graphics.rectangle("fill", love.graphics.getWidth()-moveside, 0, moveside, love.graphics.getHeight())
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-movedown, love.graphics.getWidth(), movedown)
  if (mode == GAMEOVER) then
    if score < 100 then
      love.graphics.setColor(200, 215, 200)
    end
    if score >= 100 then
      love.graphics.setColor(100,250,100)
    end
    if score >= 200 then
      love.graphics.setColor(250, 100, 100)
    end
    if score >= 300 then
      love.graphics.setColor(100, 100, 250)
    end
    drawImage(digits[math.fmod(math.floor((score/gamesPlayed)/10),10)+1],.8,.8,3.5,8.4)
    drawImage(digits[math.fmod(score/gamesPlayed,10)+1],5.7,.8,3.5,8.4)
    return
  end
  if (love.keyboard.isDown("a")) then
    for i =1,table.getn(deck) do
      drawCardSomewhere(deck[i],i)
    end
  elseif (love.keyboard.isDown("s")) then
    for i =1,table.getn(discard) do
      drawCardSomewhere(discard[i],i)
    end
  end
end

function love.update()
  --print(trashzone)
  --print(inTrashZone())
  if ((mode == NORMAL) and (isStill()) and (turnCounter == 20)) then
    mode = GAMEOVER
  end
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
      if (matrix[mainsquare.x/10][mainsquare.y/10] == "gW") then
        matrix[mainsquare.x/10][mainsquare.y/10] = "W"
      elseif (matrix[mainsquare.x/10][mainsquare.y/10] == "gN") then
        matrix[mainsquare.x/10][mainsquare.y/10] = "N"
      elseif (matrix[mainsquare.x/10][mainsquare.y/10] == "gS") then
        matrix[mainsquare.x/10][mainsquare.y/10] = "S"
      elseif (matrix[mainsquare.x/10][mainsquare.y/10] == "gE") then
        matrix[mainsquare.x/10][mainsquare.y/10] = "E"
      else
        matrix[mainsquare.x/10][mainsquare.y/10] = 0
      end
      waitTimer = 5
    end
  end
  if isStill() and (waitTimer > 0) then waitTimer = waitTimer - 1 end
  if fiximageTimer > 0 then fiximageTimer = fiximageTimer -1 end
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
  if bgm:tell() > 222.7 then
    bgm:seek(23.05)
  end
end

function love.resize(w, h)
  calibrateWindow()
end

function love.keypressed(key)
  if (mode == GAMEOVER) then
    finishGame()
    return
  end
  if mode == MENU then
    handlePressInMenu(key)
    return
  end
  if ((mode == TUTORIAL) or (mode == CREDITS)) then
    mode = MENU
    return
  end
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

function love.quit()
  love.filesystem.write('saves.txt',totalScore..'v'..gamesPlayed)
end
