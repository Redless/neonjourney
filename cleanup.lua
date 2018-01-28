function cleanup()
  table.insert(deck,hand[indexSelected])
  table.insert(discard,table.remove(bank,indexSelected))
  for i = 1,4 do
    if not (i == indexSelected) then
      table.insert(discard,hand[i])
    end
  end
  if not (indexSelected == 4) then
    table.remove(bank,4)
    table.insert(bank,1,generateNewCard())
  end
  table.insert(bank,1,generateNewCard())
  hand = {}

  for i = 1,4 do
    if (table.getn(deck) == 0) then
      reshuffleIntoDeck()
    end
    table.insert(hand,table.remove(deck,love.math.random(table.getn(deck))))
    hand[i].active = {}
    for j =1,table.getn(hand[i].text) do
      table.insert(hand[i].active,true)
    end
  end

  setupHandandBank()
  mode = NORMAL
  indexSelected = nil
end

function reshuffleIntoDeck()
  for i = 1,table.getn(discard) do
    table.insert(deck,table.remove(discard,love.math.random(table.getn(discard))))
  end
end
