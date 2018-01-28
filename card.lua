function card(text)
  outCard = {text = text}
  outCard.x = -5
  outCard.y = 10
  outCard.xv = 0
  outCard.yv = 0
  outCard.xa = 0
  outCard.ya = 0
  return outCard
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
  if table.getn(cardToDraw) == 0 then

  else

  end
end

function drawDeck()
  love.graphics.setColor(215, 200, 200)
  rectangle("fill",0,12.5,.5,2)
  rectangle("fill",9.5,12.5,.5,2)
end
