matrix = {
{0,0,0,0,0},
{0,0,"N",0,0},
{"gE",0,0,0,0},
{0,0,0,"X",0},
{0,0,0,0,0},
}

function drawTile(x,y)
  if not (matrix[x][y] == 0) then
    love.graphics.setColor(sigcol("d"..matrix[x][y]))
    drawImage(sigim(matrix[x][y]),(x-1)*8/5+1,(y-1)*8/5+1,1.6,1.6)
  end
end

function drawOutline()
  love.graphics.setColor(255,255,255)
  rectangle("fill",0,0,10,10)
  love.graphics.setColor(0,0,0)
  rectangle("fill",1,1,8,8)
end

function isHospitable(x,y)
  print(x,y)
  return matrix[x] and matrix[x][y] and not (matrix[x][y] == "X")
end

function xNorth()
  if isHospitable(mainsquare.x/10,mainsquare.y/10-1) then
    matrix[mainsquare.x/10][mainsquare.y/10] = "X"
  end
  north()
end

function xSouth()
  if isHospitable(mainsquare.x/10,mainsquare.y/10+1) then
    matrix[mainsquare.x/10][mainsquare.y/10] = "X"
  end
  south()
end

function xEast()
  if isHospitable(mainsquare.x/10+1,mainsquare.y/10) then
    matrix[mainsquare.x/10][mainsquare.y/10] = "X"
  end
  east()
end

function xWest()
  if isHospitable(mainsquare.x/10-1,mainsquare.y/10) then
    matrix[mainsquare.x/10][mainsquare.y/10] = "X"
  end
  west()
end

function dropEast()
  matrix[mainsquare.x/10][mainsquare.y/10] = "E"
  canSlide = false
end

function dropWest()
  matrix[mainsquare.x/10][mainsquare.y/10] = "W"
  canSlide = false
end

function dropSouth()
  matrix[mainsquare.x/10][mainsquare.y/10] = "S"
  canSlide = false
end

function dropNorth()
  matrix[mainsquare.x/10][mainsquare.y/10] = "N"
  canSlide = false
end

function fixtech()
  for i = -1,1 do
    for j = -1,1 do
      if matrix[mainsquare.x/10+i] and matrix[mainsquare.x/10+i][mainsquare.y/10+j] then
        if (matrix[mainsquare.x/10+i][mainsquare.y/10+j] == "X") then
          matrix[mainsquare.x/10+i][mainsquare.y/10+j] = 0
        end
        if (matrix[mainsquare.x/10+i][mainsquare.y/10+j] == "W") then
          matrix[mainsquare.x/10+i][mainsquare.y/10+j] = "gN"
        end
        if (matrix[mainsquare.x/10+i][mainsquare.y/10+j] == "E") then
          matrix[mainsquare.x/10+i][mainsquare.y/10+j] = "gS"
        end
        if (matrix[mainsquare.x/10+i][mainsquare.y/10+j] == "S") then
          matrix[mainsquare.x/10+i][mainsquare.y/10+j] = "gW"
        end
        if (matrix[mainsquare.x/10+i][mainsquare.y/10+j] == "N") then
          matrix[mainsquare.x/10+i][mainsquare.y/10+j] = "gE"
        end
      end
      fiximageTimer = 20
    end
  end
end

function drawFixer()
  love.graphics.setColor(230,230,150,fiximageTimer/20*255)
  rectangle("fill",(mainsquare.x/10-2)*8/5+1,(mainsquare.y/10-2)*8/5+1,24/5,24/5)
end

function drawTimer()
  love.graphics.setColor(0,0,0)
  if turnCounter > 0 then
    rectangle("fill",.2,.2,.6,.6)
  end
  if turnCounter > 5 then
    rectangle("fill",9.2,.2,.6,.6)
  end
  if turnCounter > 10 then
    rectangle("fill",9.2,9.2,.6,.6)
  end
  if turnCounter > 15 then
    rectangle("fill",.2,9.2,.6,.6)
  end
  for i = 1,4 do
    if turnCounter > 0+i then
      rectangle("fill",(i-1)*2.1+.8,.2,2.1,.6)
    end
    if turnCounter > 5+i then
      rectangle("fill",9.2,(i-1)*2.1+.8,.6,2.1)
    end
    if turnCounter > 10+i then
      rectangle("fill",(4-i)*2.1+.8,9.2,2.1,.6)
    end
    if turnCounter > 15+i then
      rectangle("fill",.2,(4-i)*2.1+.8,.6,2.1)
    end
  end
end
