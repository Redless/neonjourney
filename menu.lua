function drawMenu()
  love.graphics.setColor(250, 250, 250)
  drawImage(menubg,0,0,10,10)
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
  --run when it's time to load the game
end

function drawTutorial()

end

function drawCredits()

end
