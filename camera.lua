-- Converts HSL to RGB. (input and output range: 0 - 255)
function HSL(h, s, l, a)
	if s<=0 then return l,l,l,a end
	h, s, l = h/256*6, s/255, l/255
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return (r+m)*255,(g+m)*255,(b+m)*255,a
end
--[[I stole this shit from https://love2d.org/wiki/HSL_color.
According to that source, it was written by "Taehl". Thanks, Taehl!
]]

function rectangle(mode, x, y, width, height)
  love.graphics.rectangle(mode, moveside+(x/9*scale), movedown+(y/9*scale), width/9*scale, height/9*scale)
end

function drawImage(image, x, y, width, height)
	love.graphics.draw(image, moveside+(x/9*scale), movedown+(y/9*scale), 0, width/9*scale/image:getWidth(), height/9*scale/image:getWidth())
end

screenratio = 10/15

function drawImage(image, x, y, width, height)
	love.graphics.draw(image, moveside+(x/15*scale), movedown+(y/15*scale), 0, width/15*scale/image:getWidth(), height/15*scale/image:getWidth())
end

function rectangle(mode, x, y, width, height)
  love.graphics.rectangle(mode, moveside+(x/15*scale), movedown+(y/15*scale), width/15*scale, height/15*scale)
end

function calibrateWindow()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  movedown = 0
  moveside = 0
  if (width > (height*screenratio)) then
    moveside = (width - screenratio*height)/2
  else
    movedown = (height - 1/screenratio*width)/2
  end
  scale = math.min(1/screenratio*width,height)
  --yscale = xscale*14/9
  love.graphics.setColor(0, 0, 0)
  love.graphics.setLineWidth(5)
  love.graphics.rectangle('line', moveside, movedown, screenratio*scale, scale)
end
--[[I stole this shit from my past self. I used it on another project,
and now I'm using it here. Thanks, past self!
]]
