matrix = {
{0,0,0,0,0,0,0},
{0,0,0,0,0,0,0},
{0,0,0,0,0,0,0},
{0,0,0,0,0,0,0},
{0,0,0,0,0,0,0},
{0,0,0,0,0,0,0},
{0,0,0,0,0,0,0},
}

function drawTile(x,y)
  if not (matrix[x][y] == 0) then
    love.graphics.setColor(sigcol("d"..matrix[x][y]))
    drawImage(sigtile(matrix[x][y]),(x-1)*1.2+.8,(y-1)*1.2+.8,1.2,1.2)
  end
end

function sigtile(symbol)
  if ((symbol == "N") or (symbol == "gN")) then
    return mnorthArrow
  end
  if ((symbol == "S") or (symbol == "gS")) then
    return msouthArrow
  end
  if ((symbol == "E") or (symbol == "gE")) then
    return meastArrow
  end
  if ((symbol == "W") or (symbol == "gW")) then
    return mwestArrow
  end
  if ((symbol == "X")) then
    return mX
  end
end

function drawOutline()
  love.graphics.setColor(255,255,255)
  rectangle("fill",0,0,10,10)
  love.graphics.setColor(0,0,0)
  rectangle("fill",.8,.8,8.4,8.4)
  love.graphics.setColor(210,125,220)
  if (mode == GAMEOVER) then
    love.graphics.setColor(0, 0, 0)
  end
  if (trashzone == 1) then
    rectangle("fill",.8,.8,1.2*4,1.2*3)
  end
  if (trashzone == 3) then
    rectangle("fill",.8+1.2*4,.8,1.2*3,1.2*4)
  end
  if (trashzone == 2) then
    rectangle("fill",.8,.8+1.2*3,1.2*3,1.2*4)
  end
  if (trashzone == 4) then
    rectangle("fill",.8+1.2*3,.8+1.2*4,1.2*4,1.2*3)
  end
end

function predictlocation()
  curx = mainsquare.x/10
  cury = mainsquare.y/10
  clonedmatrix = {}
  for i =1,7 do
    table.insert(clonedmatrix,{})
    for j = 1,7 do
      table.insert(clonedmatrix[i],matrix[i][j])
    end
  end
  commandQ = {}
  for i =1,4 do
    cardToAdd = hand[i]
    if (i == indexSelected) then
      cardToAdd = bank[i]
    end
    for j =1,table.getn(cardToAdd.text) do
      table.insert(commandQ,1,cardToAdd.text[j])
    end
  end
  while ((table.getn(commandQ) > 0) or (not (clonedmatrix[curx][cury] == 0) and issliding)) do
    if ((clonedmatrix[curx][cury] == 0) or not issliding) then
      commandtoDo = table.remove(commandQ)
      if (commandtoDo == "xN") then
        if ((clonedmatrix[curx][cury-1]) and not (clonedmatrix[curx][cury-1] == "X")) then
          clonedmatrix[curx][cury] = "X"
          commandtoDo = "N"
          issliding = true
        end
      elseif (commandtoDo == "xS") then
        if ((clonedmatrix[curx][cury+1]) and not (clonedmatrix[curx][cury+1] == "X")) then
          clonedmatrix[curx][cury] = "X"
          commandtoDo = "S"
          issliding = true
        end
      elseif (commandtoDo == "xW") then
        if ((clonedmatrix[curx-1]) and ((clonedmatrix[curx-1][cury])) and not (clonedmatrix[curx-1][cury] == "X")) then
          clonedmatrix[curx][cury] = "X"
          commandtoDo = "W"
          issliding = true
        end
      elseif (commandtoDo == "xE") then
        if ((clonedmatrix[curx+1]) and (clonedmatrix[curx+1][cury]) and not (clonedmatrix[curx+1][cury] == "X")) then
          clonedmatrix[curx][cury] = "X"
          commandtoDo = "E"
          issliding = true
        end
      end
      if (commandtoDo == "NN") then
        if ((clonedmatrix[curx][cury-2]) and not (clonedmatrix[curx][cury-2] == "X")) then
          cury = math.max(cury-2,1)
          issliding = true
        else
          commandtoDo = "N"
        end
      elseif (commandtoDo == "SS") then
        if ((clonedmatrix[curx][cury+2]) and not (clonedmatrix[curx][cury+2] == "X")) then
          cury = math.min(cury+2,7)
          issliding = true
        else
          commandtoDo = "S"
        end
      elseif (commandtoDo == "WW") then
        if ((clonedmatrix[curx-2]) and ((clonedmatrix[curx-2][cury])) and not (clonedmatrix[curx-2][cury] == "X")) then
          curx = math.max(curx-2,1)
          issliding = true
        else
          commandtoDo = "W"
        end
      elseif (commandtoDo == "EE") then
        if ((clonedmatrix[curx+2]) and (clonedmatrix[curx+2][cury]) and not (clonedmatrix[curx+2][cury] == "X")) then
          curx = math.min(curx+2,7)
          issliding = true
        else
          commandtoDo = "E"
        end
      end
      if (commandtoDo == "N") then
        if ((clonedmatrix[curx][cury-1]) and not (clonedmatrix[curx][cury-1] == "X")) then
          cury = math.max(cury-1,1)
          issliding = true
        end
      elseif (commandtoDo == "S") then
        if ((clonedmatrix[curx][cury+1]) and not (clonedmatrix[curx][cury+1] == "X")) then
          cury = math.min(cury+1,7)
          issliding = true
        end
      elseif (commandtoDo == "W") then
        if ((clonedmatrix[curx-1]) and ((clonedmatrix[curx-1][cury])) and not (clonedmatrix[curx-1][cury] == "X")) then
          curx = math.max(curx-1,1)
          issliding = true
        end
      elseif (commandtoDo == "E") then
        if ((clonedmatrix[curx+1]) and (clonedmatrix[curx+1][cury]) and not (clonedmatrix[curx+1][cury] == "X")) then
          curx = math.min(curx+1,7)
          issliding = true
        end
      end
      if (commandtoDo == "dN") then
        clonedmatrix[curx][cury] = "N"
        issliding = false
      elseif (commandtoDo == "dS") then
        clonedmatrix[curx][cury] = "S"
        issliding = false
      elseif (commandtoDo == "dE") then
        clonedmatrix[curx][cury] = "E"
        issliding = false
      elseif (commandtoDo == "dW") then
        clonedmatrix[curx][cury] = "W"
        issliding = false
      end
      if (commandtoDo == "F") then
        for xadj = 1,3 do
          for yadj = 1,3 do
            if (clonedmatrix[curx-2+xadj] and clonedmatrix[curx-2+xadj][cury-2+yadj]) then
              if (clonedmatrix[curx-2+xadj][cury-2+yadj] == "N") then
                clonedmatrix[curx-2+xadj][cury-2+yadj] = "gW"
              elseif (clonedmatrix[curx-2+xadj][cury-2+yadj] == "W") then
                clonedmatrix[curx-2+xadj][cury-2+yadj] = "gS"
              elseif (clonedmatrix[curx-2+xadj][cury-2+yadj] == "E") then
                clonedmatrix[curx-2+xadj][cury-2+yadj] = "gN"
              elseif (clonedmatrix[curx-2+xadj][cury-2+yadj] == "S") then
                clonedmatrix[curx-2+xadj][cury-2+yadj] = "gE"
              elseif (clonedmatrix[curx-2+xadj][cury-2+yadj] == "X") then
                clonedmatrix[curx-2+xadj][cury-2+yadj] = 0
              end
            end
          end
        end
      end
    else
      commandtoDo = clonedmatrix[curx][cury]
      if (commandtoDo == "N") then
        clonedmatrix[curx][cury] = 0
        if (clonedmatrix[curx] and (clonedmatrix[curx][cury-1]) and not (clonedmatrix[curx][cury-1] == "X")) then
          cury = math.max(cury-1,1)
        end
      elseif (commandtoDo == "S") then
        clonedmatrix[curx][cury] = 0
        if (clonedmatrix[curx] and (clonedmatrix[curx][cury+1]) and not (clonedmatrix[curx][cury+1] == "X")) then
          cury = math.min(cury+1,7)
        end
      elseif (commandtoDo == "W") then
        clonedmatrix[curx][cury] = 0
        if ((clonedmatrix[curx-1]) and ((clonedmatrix[curx-1][cury])) and not (clonedmatrix[curx-1][cury] == "X")) then
          curx = math.max(curx-1,1)
        end
      elseif (commandtoDo == "E") then
        clonedmatrix[curx][cury] = 0
        if ((clonedmatrix[curx+1]) and (clonedmatrix[curx+1][cury]) and not (clonedmatrix[curx+1][cury] == "X")) then
          curx = math.min(curx+1,7)
        end
      end
      if (commandtoDo == "gN") then
        clonedmatrix[curx][cury] = "N"
        if (not(clonedmatrix[curx][cury-1]) and not (clonedmatrix[curx][cury-1] == "X")) then
          cury = math.max(cury-1,1)
        end
      elseif (commandtoDo == "gS") then
        clonedmatrix[curx][cury] = "S"
        if (not(clonedmatrix[curx][cury+1]) and not (clonedmatrix[curx][cury+1] == "X")) then
          cury = math.min(cury+1,7)
        end
      elseif (commandtoDo == "gW") then
        clonedmatrix[curx][cury] = "W"
        if ((clonedmatrix[curx-1]) and ((clonedmatrix[curx-1][cury])) and not (clonedmatrix[curx-1][cury] == "X")) then
          curx = math.max(curx-1,1)
        end
      elseif (commandtoDo == "gE") then
        clonedmatrix[curx][cury] = "E"
        if ((clonedmatrix[curx+1]) and (clonedmatrix[curx+1][cury]) and not (clonedmatrix[curx+1][cury] == "X")) then
          curx = math.min(curx+1,7)
        end
      end
    end
  end
  return curx, cury
end

function inTrashZone()
  if ((trashzone == 1) and (mainsquare.x/10 <= 4) and (mainsquare.y/10 <= 3)) then
    return true
  end
  if ((trashzone == 2) and (mainsquare.x/10 > 4) and (mainsquare.y/10 <= 4)) then
    return true
  end
  if ((trashzone == 3) and (mainsquare.x/10 <= 3) and (mainsquare.y/10 >= 4)) then
    return true
  end
  if ((trashzone == 4) and (mainsquare.x/10 >= 4) and (mainsquare.y/10 > 4)) then
    return true
  end
  return false
end

function isHospitable(x,y)
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
  rectangle("fill",(mainsquare.x/10-2)*1.2+.8,(mainsquare.y/10-2)*1.2+.8,3.6,3.6)
end

function drawTimer()
  love.graphics.setColor(0,0,0)
  if turnCounter > 0 then
    rectangle("fill",.2,.2,.4,.4)
  end
  if turnCounter > 5 then
    rectangle("fill",9.4,.2,.4,.4)
  end
  if turnCounter > 10 then
    rectangle("fill",9.4,9.4,.4,.4)
  end
  if turnCounter > 15 then
    rectangle("fill",.2,9.4,.4,.4)
  end
  for i = 1,4 do
    if turnCounter > 0+i then
      rectangle("fill",(i-1)*2.2+.6,.2,2.2,.4)
    end
    if turnCounter > 5+i then
      rectangle("fill",9.4,(i-1)*2.2+.6,.4,2.2)
    end
    if turnCounter > 10+i then
      rectangle("fill",(4-i)*2.2+.6,9.4,2.2,.4)
    end
    if turnCounter > 15+i then
      rectangle("fill",.2,(4-i)*2.2+.6,.4,2.2)
    end
  end
end
