-- attach drag-item scrollview to widget library
require("dragitemscrollview")

-- load widget library
local widget = require("widget")

-- create drag-item scrollview
local c = widget.newDragItemsScrollView{
	backgroundColor = {1,0,0},
	left=100,
	top=100,
	width=500,
	height=800
}

-- create items to add to the scroll view (this will be dragged off the scrollview)
local circleA = display.newCircle( 0, 0, 50 )
local circleB = display.newCircle( 0, 0, 50 )
local circleC = display.newCircle( 0, 0, 50 )

-- create a listener to handle drag-item events
local function listen( item, touchevent )
	display.currentStage:insert( item )
	item.x, item.y = touchevent.x, touchevent.y
	
	local function touch(e)
		if (e.phase == "began") then
			display.currentStage:setFocus( e.target, e.id )
			e.target.hasFocus = true
			return true
		elseif (e.target.hasFocus) then
			e.target.x, e.target.y = e.x, e.y
			if (e.phase == "moved") then
			else
				display.currentStage:setFocus( e.target, nil )
				e.target.hasFocus = nil
			end
			return true
		end
		return false
	end
	
	item.hasFocus = true
	display.currentStage:setFocus( item, touchevent.id )
	item:addEventListener( "touch", touch )
end

-- add the drag-item to the scrollview
--[[
	Params:
		item: Item to add to the scrollview
		listener: Listener function to call when a drag-off is detected
		Dragtime: Milliseconds that a hold will begin a drag-off
		Angle: Angle at which a touch-motion will begin a drag-off event
		Radius: Radius around the angle within which the drag-off will begin, outside this will not
		Touch-threshold: Distance a touch must travel to begin a drag-off (default is .1 of screen width)
	
	Description:
		This example will cause the white circle to be dragged off the scrollview only if the
		touch begins and does not move further than the touch-threshold within 450 milliseconds
		OR if the touch moves further than .1 of the screen width within 450 millisecond
		BUT ONLY if the touch moves within 90 degrees of immediately east (right) of the initial touch.
		
		The Dragtime determines how long a touch-and-hold will cause a drag to fire. Leave nil to
		have only touch with distance begin a drag-off.
		
		Angle and Radius define a range of direction which will fire a drag-off event. Outside of that
		will result in the scrollview being scrolled. Leave nil to have only touch-and-hold to fire a
		drag-off event.
		
		The Touch-threshold can be used to define the distance that a touch-and-move will fire a
		drag-off event. The default is .1 of the screen width.
]]--
c:add( circleA, listen, 450, 90, 90 )
c:add( circleB, listen, 450, 90, 90 )
c:add( circleC, listen, 450, 90, 90 )

-- position the drag item in the scrollview
circleA.x, circleA.y = c.width/2, c.height*.25
circleB.x, circleB.y = c.width/2, c.height*.5
circleC.x, circleC.y = c.width/2, c.height*.75
