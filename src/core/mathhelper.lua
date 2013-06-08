function distance(x, y, xx, yy)
	dx = x - xx
	dy = y - yy
	return math.sqrt(dx*dx + dy*dy)
end

function fraction(el, slow)
	x, y = el.body:getLinearVelocity()
	--x = math.floor(x)
	--y = math.floor(y)
		if (x == 0) and (y == 0) then
			el.body:setLinearVelocity(0,0)
			
		elseif x == 0 then
			if y > 0 then
				el.body:setLinearVelocity(0,y-slow)
			else
				el.body:setLinearVelocity(0,y+slow)
			end

		elseif y == 0 then
			if x > 0 then
				el.body:setLinearVelocity(x-slow,0)
			else
				el.body:setLinearVelocity(x+slow,0)
			end
		elseif (x > 0) then
    		if y > 0 then
    			el.body:setLinearVelocity((x-slow),(y-slow))
    		else
    			el.body:setLinearVelocity((x-slow),(y+slow))
    		end
    	else
    		if y > 0 then
    			el.body:setLinearVelocity((x+slow),(y-slow))
    		else
    			el.body:setLinearVelocity((x+slow),(y+slow))
    		end
    	end


end
