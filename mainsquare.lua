mainsquare = {
  x = 30,
  y = 30,
  xv = 0,
  yv = 0,
}

score = 0

function isStill()
  return (mainsquare.xv == 0) and (mainsquare.yv == 0)
end

function drawMainSquare()
  love.graphics.setColor(200, 215, 200, 100)
  rectangle("fill",(mainsquare.x/10-1)*8/5+1,(mainsquare.y/10-1)*8/5+1,8/5,8/5)
  love.graphics.setColor(200, 215, 200)
  drawImage(digits[math.fmod(math.floor(score/10),10)+1],(mainsquare.x/10-1)*8/5+1,(mainsquare.y/10-1)*8/5+1,4/5-1/8,8/5)
  drawImage(digits[math.fmod(score,10)+1],(mainsquare.x/10-.5)*8/5+1+1/8,(mainsquare.y/10-1)*8/5+1,4/5-1/8,8/5)
end

function north()
  if isHospitable(mainsquare.x/10,mainsquare.y/10-1) then
    score = score+1
    mainsquare.yv = mainsquare.yv - 10
    canSlide = true
  end
end

function south()
  if isHospitable(mainsquare.x/10,mainsquare.y/10+1) then
    score = score+1
    mainsquare.yv = mainsquare.yv + 10
    canSlide = true
  end
end

function east()
  if isHospitable(mainsquare.x/10+1,mainsquare.y/10) then
    score = score+1
    mainsquare.xv = mainsquare.xv + 10
    canSlide = true
  end
end

function west()
  if isHospitable(mainsquare.x/10-1,mainsquare.y/10) then
    score = score+1
    mainsquare.xv = mainsquare.xv - 10
    canSlide = true
  end
end
