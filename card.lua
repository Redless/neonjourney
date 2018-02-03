deck = {}
discard = {}

NORMAL = 1
MENU = 2
EXECUTING = 3
RESHUFFLE = 4
TUTORIAL = 5
CREDITS = 6
GAMEOVER = 7

cardOn = 1
commandOn = 1

function card(text,spawngeneration)
  outCard = {text = text}
  outCard.x = -5
  outCard.y = 10.3
  outCard.xv = 0
  outCard.yv = 0
  outCard.xa = 0
  outCard.ya = 0
  outCard.born = spawngeneration
  outCard.active = {}
  for i =1,table.getn(text) do
    table.insert(outCard.active,true)
  end
  return outCard
end

function setupHandandBank()
  for i = 1,4 do
    if not (mode == RESHUFFLE) then
      dropCard(hand[i],.7+2.2*(i-1),12.5)
    end
    dropCard(bank[i],.7+2.2*(i-1),10.3)
  end
  for i = 1,table.getn(discard) do
    dropCard(discard[i],12,12.5)
  end
  for i = 1,table.getn(deck) do
    deck[i].x = -2
    deck[i].y = 12
  end
end

function selectCard(index)
  indexSelected = index
  setupHandandBank()
  dropCard(bank[index],.7+2.2*(index-1),12.5)
end

function updateCardPosition(cardToUpdate)
  if (math.abs(cardToUpdate.xa - cardToUpdate.x) < .2) then
    cardToUpdate.x = cardToUpdate.xa
    cardToUpdate.xv = 0
  else
    cardToUpdate.x = cardToUpdate.x + cardToUpdate.xv
  end
  if (math.abs(cardToUpdate.ya - cardToUpdate.y) < .2) then
    cardToUpdate.y = cardToUpdate.ya
    cardToUpdate.yv = 0
  else
    cardToUpdate.y = cardToUpdate.y + cardToUpdate.yv
  end
end

function dropCard(cardToDrop, x, y)
  cardToDrop.xa = x
  cardToDrop.ya = y
  cardToDrop.xv = (cardToDrop.xa - cardToDrop.x)/15
  cardToDrop.yv = (cardToDrop.ya - cardToDrop.y)/15
end

function drawCard(cardToDraw)
  love.graphics.setColor(200,200,215)
  rectangle("fill",cardToDraw.x,cardToDraw.y,2,2)
  love.graphics.setColor(0, 0, 0)
  rectangle("fill",cardToDraw.x+.1,cardToDraw.y+.1,1.8,1.8)
  love.graphics.setColor(200,200,215)
  if table.getn(cardToDraw.text) == 1 then
    love.graphics.setColor(sigcol(cardToDraw.text[1]))
    if cardToDraw.active[1] then
      drawImage(sigim(cardToDraw.text[1]),cardToDraw.x+.2,cardToDraw.y+.2,1.6,1.6)
    end
  else
    for i = 1,table.getn(cardToDraw.text) do
      if cardToDraw.active[i] then
        love.graphics.setColor(sigcol(cardToDraw.text[i]))
        drawImage(ssigim(cardToDraw.text[i]),cardToDraw.x+.2+math.fmod(i+1,2)*.9,cardToDraw.y+.2+math.floor((i-1)/2)*.9,.7,.7)
      end
    end
  end
end

function drawCardSomewhere(cardToDraw,i)
  xtouse = .4 + 2.4*(math.fmod(i-1,4))
  ytouse = .4 + 2.4*math.floor((i-1)/4)
  love.graphics.setColor(200,200,215)
  rectangle("fill",xtouse,ytouse,2,2)
  love.graphics.setColor(0, 0, 0)
  rectangle("fill",xtouse+.1,ytouse+.1,1.8,1.8)
  love.graphics.setColor(200,200,215)
  if (table.getn(cardToDraw.text) == 1) then
    love.graphics.setColor(sigcol(cardToDraw.text[1]))
    drawImage(sigim(cardToDraw.text[1]),xtouse+.2,ytouse+.2,1.6,1.6)
  else
    for i = 1,table.getn(cardToDraw.text) do

      love.graphics.setColor(sigcol(cardToDraw.text[i]))
      drawImage(ssigim(cardToDraw.text[i]),xtouse+.2+math.fmod(i+1,2)*.9,ytouse+.2+math.floor((i-1)/2)*.9,.7,.7)
    end
  end
end

function sigcol(symbol)
  if ((symbol == "dS") or (symbol == "dW") or (symbol == "dE") or (symbol == "dN") or (symbol == "dN")) then
    return 100, 250, 215
  end
  if ((symbol == "xS") or (symbol == "xW") or (symbol == "xN") or (symbol == "xE") or (symbol == "dX")) then
    return 250, 100, 215
  end
  if (symbol == "F") then
    return 230, 230, 150
  end
  if ((symbol == "dgN") or (symbol == "dgS") or (symbol == "dgW") or (symbol == "dgE")) then
    return 230,230,150
  end
  return 200,200,200
end

function sigim(symbol)
  if ((symbol == "N") or (symbol == "dN") or (symbol == "xN") or (symbol == "gN")) then
    return northArrow
  elseif ((symbol == "S") or (symbol == "dS") or (symbol == "xS") or (symbol == "gS")) then
    return southArrow
  elseif ((symbol == "E") or (symbol == "dE") or (symbol == "xE") or (symbol == "gE")) then
    return eastArrow
  elseif ((symbol == "W") or (symbol == "dW") or (symbol == "xW") or (symbol == "gW")) then
    return westArrow
  end
  if (symbol == "NN") then
    return doubleNorth
  elseif (symbol == "SS") then
    return doubleSouth
  elseif (symbol == "EE") then
    return doubleEast
  elseif (symbol == "WW") then
    return doubleWest
  end
  if (symbol == "X") then
    return blockedSpace
  end
  if (symbol == "F") then
    return fixer
  end
end

function ssigim(symbol)
  if ((symbol == "N") or (symbol == "dN") or (symbol == "xN")) then
    return snorthArrow
  elseif ((symbol == "S") or (symbol == "dS") or (symbol == "xS")) then
    return ssouthArrow
  elseif ((symbol == "E") or (symbol == "dE") or (symbol == "xE")) then
    return seastArrow
  elseif ((symbol == "W") or (symbol == "dW") or (symbol == "xW")) then
    return swestArrow
  end
  if (symbol == "NN") then
    return sdoubleNorth
  elseif (symbol == "SS") then
    return sdoubleSouth
  elseif (symbol == "EE") then
    return sdoubleEast
  elseif (symbol == "WW") then
    return sdoubleWest
  end
  if (symbol == "F") then
    return sfixer
  end
end

function drawDeck()
  love.graphics.setColor(215, 200, 200)
  rectangle("fill",0,12.5,.5,2)
  rectangle("fill",9.5,12.5,.5,2)
end

function sicom(symbol)
  if symbol == "N" then
    return north
  elseif symbol == "S" then
    return south
  elseif symbol == "E" then
    return east
  elseif symbol == "W" then
    return west
  end
  if symbol == "gN" then
    return north
  elseif symbol == "gS" then
    return south
  elseif symbol == "gE" then
    return east
  elseif symbol == "gW" then
    return west
  end
  if symbol == "NN" then
    return function()
      if isHospitable(mainsquare.x/10,mainsquare.y/10-2) then score = score+2
      mainsquare.yv = mainsquare.yv - 20
      canSlide = true else north() end end
  elseif symbol == "SS" then
    return function()
      if isHospitable(mainsquare.x/10,mainsquare.y/10+2) then score = score+2
      mainsquare.yv = mainsquare.yv + 20
      canSlide = true else south() end end
  elseif symbol == "EE" then
    return function()
      if isHospitable(mainsquare.x/10+2,mainsquare.y/10) then score = score+2
      mainsquare.xv = mainsquare.xv + 20
      canSlide = true else east() end end
  elseif symbol == "WW" then
    return function()
      if isHospitable(mainsquare.x/10-2,mainsquare.y/10) then score = score+2
      mainsquare.xv = mainsquare.xv - 20
      canSlide = true else west() end end
  end
  if symbol == "dN" then
    return dropNorth
  elseif symbol == "dS" then
    return dropSouth
  elseif symbol == "dE" then
    return dropEast
  elseif symbol == "dW" then
    return dropWest
  end
  if symbol == "xN" then
    return xNorth
  elseif symbol == "xS" then
    return xSouth
  elseif symbol == "xE" then
    return xEast
  elseif symbol == "xW" then
    return xWest
  end
  if symbol == "F" then
    return fixtech
  end
  return function() end
end

function executeNext()
  waitTimer = 20
  if (cardOn == indexSelected) then
    sicom(bank[cardOn].text[commandOn])()
    bank[cardOn].active[commandOn] = false
    if (table.getn(bank[cardOn].text) == commandOn) then
      cardOn = cardOn + 1
      commandOn = 1
    else
      commandOn = commandOn + 1
    end
  else
    sicom(hand[cardOn].text[commandOn])()
    hand[cardOn].active[commandOn] = false
    if (table.getn(hand[cardOn].text) == commandOn) then
      cardOn = cardOn + 1
      commandOn = 1
    else
      commandOn = commandOn + 1
    end
  end
  if (cardOn == 5) then
    cleanup()
  end
end

function executeAll()
  if ((indexSelected) and (mode == NORMAL)) then
    mode = EXECUTING
    cardOn = 1
    commandOn = 1
    if inTrashZone() then
      trashPrimed = true
      trashzone = 0
    end
  end
end

function generateNewCard(points)
  unorderedOptions = {}
  unorderedDroptions = {}
  dropSpaces = 1
  spaces = 4
  fixerType = love.math.random(2) == 1
  specialCount = 0
  while ((fixerType) and (specialCount < 1) and (points >= 3) and (spaces > 0)) do
    randvar = love.math.random(20)
    if (randvar <= 8) then
      table.insert(unorderedOptions,"F")
      specialCount = specialCount + 1
      points = points - 4
      spaces = spaces - 1
      dropSpaces = dropSpaces + 1
    elseif ((randvar <= 10) and (points > 1)) then
      table.insert(unorderedOptions,"double")
      points = points - 3
      spaces = spaces - 1
      dropSpaces = dropSpaces + 1
    else
      table.insert(unorderedOptions,"move")
      points = points - 2
      spaces = spaces - 1
      dropSpaces = dropSpaces + 1
    end
  end
  blocktaken = false
  while ((not fixerType) and (specialCount < 2) and (points >= 1) and (spaces > 0) and (dropSpaces > 0)) do
    randvar = love.math.random(20)
    if ((randvar <= 6) and (points < spaces*2) and (not blocktaken)) then
      table.insert(unorderedOptions,"block")
      specialCount = specialCount + 1
      points = points + 1
      spaces = spaces - 1
      blocktaken = true
    elseif ((randvar <= 8) and (points > 1)) then
      table.insert(unorderedOptions,"double")
      points = points - 3
      spaces = spaces - 1
      dropSpaces = dropSpaces + 1
    elseif (randvar <= 12) then
      table.insert(unorderedOptions,"move")
      points = points - 2
      spaces = spaces - 1
      dropSpaces = dropSpaces + 1
    elseif (dropSpaces > 0) then
      table.insert(unorderedDroptions,"drop")
      specialCount = specialCount + 1
      points = points - 2
      spaces = spaces - 1
      dropSpaces = dropSpaces - 1
    end
  end
  while ((spaces > 0) and (points > 0)) do
    randvar = love.math.random(20)
    if ((randvar <= 6) and (points > 1)) then
      table.insert(unorderedOptions,"double")
      points = points - 3
      spaces = spaces - 1
    else
      table.insert(unorderedOptions,"move")
      points = points - 2
      spaces = spaces - 1
    end
  end
  commandList = {}
  for i = 1,table.getn(unorderedOptions) do
    itemToInsert = table.remove(unorderedOptions,love.math.random(table.getn(unorderedOptions)))
    table.insert(commandList,itemToInsert)
  end
  while (table.getn(unorderedDroptions) > 0) do
    if (table.getn(commandList) == 0) then
      table.insert(commandList,1,table.remove(unorderedOptions))
    end
    indexToInsert = love.math.random(table.getn(commandList)+1)
    blockedbefore = (commandList[indexToInsert-1] == "drop")
    blockedafter = (commandList[indexToInsert] == "drop") or (commandList[indexToInsert] == "block")
    if not (blockedafter or blockedbefore) then
      table.insert(commandList, indexToInsert, table.remove(unorderedDroptions))
    end
  end
  truecommands = {}
  lookup = {{"N","S","E","W"},{"dN","dS","dE","dW"},{"NN","SS","EE","WW"},{"xN","xS","xE","xW"}}
  for i = 1,table.getn(commandList) do
    direction = love.math.random(4)
    if (commandList[i] == "move") then
      table.insert(truecommands,lookup[1][direction])
    elseif (commandList[i] == "double") then
      table.insert(truecommands,lookup[3][direction])
    elseif (commandList[i] == "drop") then
      table.insert(truecommands,lookup[2][direction])
    elseif (commandList[i] == "block") then
      table.insert(truecommands,lookup[4][direction])
    elseif (commandList[i] == "F") then
      table.insert(truecommands,"F")
    else
      print("REEEEEEEEEEEE!!!")
      print(commandList[i])
    end
  end
  return card(truecommands,generation)
end
