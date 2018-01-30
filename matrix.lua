matrix = {
{0,0,0,0,0},
{0,0,0,0,0},
{0,0,0,0,0},
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
  return matrix[x] and matrix[x][y] and not (matrix[x][y] == "X")
end

function xNorth()
  matrix[mainsquare.x/10][mainsquare.y/10] = "X"
  north()
end

function xSouth()
  matrix[mainsquare.x/10][mainsquare.y/10] = "X"
  south()
end

function xEast()
  matrix[mainsquare.x/10][mainsquare.y/10] = "X"
  east()
end

function xWest()
  matrix[mainsquare.x/10][mainsquare.y/10] = "X"
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
  
end
