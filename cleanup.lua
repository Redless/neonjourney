function cleanup()
  turnCounter = turnCounter + 1
  table.insert(deck,hand[indexSelected])
  table.insert(discard,table.remove(bank,indexSelected))
  for i = 1,4 do
    if not (i == indexSelected) then
      table.insert(discard,hand[i])
    end
  end
  if not (indexSelected == 4) then
    table.remove(bank,4)
    table.insert(bank,1,generateNewCard(3))
  end
  table.insert(bank,1,generateNewCard(3))
  hand = {}
  waitTimer = 20
  mode = RESHUFFLE
  setupHandandBank()
end

function reshuffleIntoDeck()
  for i = 1,table.getn(discard) do
    table.insert(deck,table.remove(discard,love.math.random(table.getn(discard))))
  end
  for i = 1,table.getn(deck) do
    deck[i].x = -5
    deck[i].y = 12.5
  end
end

function finishGame()
  mode = MENU
  totalScore = totalScore + score
  gamesPlayed = gamesPlayed + 1
end
