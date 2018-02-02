function drawMenu()
  love.graphics.setColor(250, 250, 250)
  drawImage(menubg,0,0,10,10)
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
  drawImage(digits[math.fmod(math.floor((totalScore/gamesPlayed)/10),10)+1],3.8,11,1,2.4)
  drawImage(digits[math.fmod(totalScore/gamesPlayed,10)+1],5.2,11,1,2.4)
end

function handlePressInMenu(key)
  if key == "q" then
    setupGame()
  elseif key == "e" then
    mode = CREDITS
  elseif key == "w" then
    mode = TUTORIAL
  elseif key == "r" then
    if bgm:isPlaying() then
      bgm:stop()
    else
      bgm:play()
    end
  end
end

function setupGame()
  score = 0
  turnCounter = 0
  mode = NORMAL
  mainsquare.x = 40
  mainsquare.y = 40
  matrix = {
  {0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0},
  }
  hand = {card({"N"},0),card({"S"},0),card({"E"},0),card({"W"},0)}
  bank = {}
  for i = 1,4 do
    table.insert(bank,generateNewCard(3))
  end
  setupHandandBank()
  waitTimer = 0
  fiximageTimer = 0
end

function drawTutorial()
  love.graphics.setColor(255,255,255)
  drawImage(tutorialimg,0,0,10,15)
end

function drawCredits()
  love.graphics.setColor(255,255,255)
  drawImage(creditsimg,0,0,10,10)
end
