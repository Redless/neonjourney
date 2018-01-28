matrix = {
{{},{},{},{},{}},
{{},{},{},{},{}},
{{},{},{},{},{}},
{{},{},{},{},{}},
{{},{},{},{},{}}}

function drawOutline()
  love.graphics.setColor(255,255,255)
  rectangle("fill",0,0,10,10)
  love.graphics.setColor(0,0,0)
  rectangle("fill",1,1,8,8)
end

function isHospitable(x,y)
  return matrix[x] and matrix[x][y]
end
