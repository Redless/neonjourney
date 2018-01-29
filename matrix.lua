matrix = {
{0,0,0,0,0},
{0,0,0,0,0},
{0,0,0,0,0},
{0,0,0,"N",0},
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
  return matrix[x] and matrix[x][y]
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
