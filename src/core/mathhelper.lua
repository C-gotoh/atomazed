function distance(x, y, x2, y2)
	dx = x - x2
	dy = y - y2
	return math.sqrt(dx*dx + dy*dy)
end

function fraction(el)
	x, y = el.body:getLinearVelocity()
	x = math.floor(x)
	y = math.floor(y)
		if (x == 0) and (y == 0) then
			el.body:setLinearVelocity(0,0)
		end
		if x == 0 then
			if y > 0 then
				el.body:setLinearVelocity(0,y-1)
			else
				el.body:setLinearVelocity(0,y+1)
			end

		end
		if y == 0 then
			if x > 0 then
				el.body:setLinearVelocity(x-1,0)
			else
				el.body:setLinearVelocity(x+1,0)
			end
		end --]]
		
    	if (x > 0) then
    		if y > 0 then
    			el.body:setLinearVelocity((x-1),(y-1))
    		else
    			el.body:setLinearVelocity((x-1),(y+1))
    		end
    	else
    		if y > 0 then
    			el.body:setLinearVelocity((x+1),(y-1))
    		else
    			el.body:setLinearVelocity((x+1),(y+1))
    		end
    	end


end
