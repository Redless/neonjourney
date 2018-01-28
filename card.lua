deck = {}
discard = {}

NORMAL = 1
MENU = 2
EXECUTING = 3
RESHUFFLE = 4

cardOn = 1
commandOn = 1

function card(text)
  outCard = {text = text}
  outCard.x = -5
  outCard.y = 10
  outCard.xv = 0
  outCard.yv = 0
  outCard.xa = 0
  outCard.ya = 0
  outCard.active = {}
  for i =1,table.getn(text) do
    table.insert(outCard.active,true)
  end
  return outCard
end

function setupHandandBank()
  for i = 1,4 do
    dropCard(hand[i],.7+2.2*(i-1),12.5)
  end
  for i = 1,4 do
    dropCard(bank[i],.7+2.2*(i-1),10.3)
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
    if cardToDraw.active[1] then
      drawImage(sigim(cardToDraw.text[1]),cardToDraw.x+.2,cardToDraw.y+.2,1.6,1.6)
    end
  else
    for i = 1,table.getn(cardToDraw.text) do
      if cardToDraw.active[i] then
        drawImage(ssigim(cardToDraw.text[i]),cardToDraw.x+.2+math.fmod(i+1,2)*.9,cardToDraw.y+.2+math.floor((i-1)/2)*.9,.7,.7)
      end
    end
  end
end

function sigim(symbol)
  if symbol == "N" then
    return northArrow
  elseif symbol == "S" then
    return southArrow
  elseif symbol == "E" then
    return eastArrow
  elseif symbol == "W" then
    return westArrow
  end
end

function ssigim(symbol)
  if symbol == "N" then
    return snorthArrow
  elseif symbol == "S" then
    return ssouthArrow
  elseif symbol == "E" then
    return seastArrow
  elseif symbol == "W" then
    return swestArrow
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
    mode = RESHUFFLE
  end
end

function executeAll()
  if ((indexSelected) and (mode == NORMAL)) then
    mode = EXECUTING
    cardOn = 1
    commandOn = 1
  end
end
