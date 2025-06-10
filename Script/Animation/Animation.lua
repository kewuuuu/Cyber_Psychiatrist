-- [tsx]: Animation.tsx
local ____exports = {} -- 1
local ____Dora = require("Dora") -- 3
local Sprite = ____Dora.Sprite -- 3
local Vec2 = ____Dora.Vec2 -- 3
local cycle = ____Dora.cycle -- 3
local sleep = ____Dora.sleep -- 3
local thread = ____Dora.thread -- 3
local wait = ____Dora.wait -- 3
____exports.playAnimation = function(node, names, interval, loop) -- 7
	node:removeAllChildren() -- 8
	local frames = {} -- 13
	for ____, name in ipairs(names) do -- 14
		local frame = Sprite(name) or Sprite() -- 15
		frame.visible = false -- 16
		frame:addTo(node) -- 17
		frames[#frames + 1] = frame -- 18
	end -- 18
	local i = 0 -- 20
	frames[i + 1].visible = true -- 21
	node:loop(function() -- 22
		sleep(interval) -- 23
		frames[(i + 1) % #names + 1].visible = true -- 24
		frames[i + 1].visible = false -- 25
		i = (i + 1) % #names -- 26
		return not loop -- 27
	end) -- 22
end -- 7
____exports.NodeMove = function(node, speed, pos, loop) -- 37
	if #pos < 1 then -- 37
		print("nodemove: 至少需要一个位置点") -- 40
		return nil -- 41
	end -- 41
	local pathSegments = {} -- 45
	if #pos == 1 then -- 45
		pathSegments[#pathSegments + 1] = {start = pos[1], ["end"] = pos[1], distance = 0, time = 0} -- 49
	else -- 49
		do -- 49
			local i = 0 -- 56
			while i < #pos - 1 do -- 56
				local start = pos[i + 1] -- 57
				local ____end = pos[i + 1 + 1] -- 58
				local dx = ____end.x - start.x -- 61
				local dy = ____end.y - start.y -- 62
				local distance = math.sqrt(dx * dx + dy * dy) -- 63
				local time = distance / (speed * 10) -- 68
				pathSegments[#pathSegments + 1] = {start = start, ["end"] = ____end, distance = distance, time = time} -- 70
				i = i + 1 -- 56
			end -- 56
		end -- 56
		if loop then -- 56
			local start = pos[#pos] -- 75
			local ____end = pos[1] -- 76
			local dx = ____end.x - start.x -- 79
			local dy = ____end.y - start.y -- 80
			local distance = math.sqrt(dx * dx + dy * dy) -- 81
			local time = distance / (speed * 10) -- 84
			pathSegments[#pathSegments + 1] = {start = start, ["end"] = ____end, distance = distance, time = time} -- 86
		end -- 86
	end -- 86
	node.position = pos[1] -- 91
	return thread(function() -- 94
		local currentNode = 0 -- 95
		while true do -- 95
			if not loop and currentNode >= #pathSegments then -- 95
				break -- 100
			end -- 100
			currentNode = currentNode % #pathSegments -- 102
			local segment = pathSegments[currentNode + 1] -- 104
			local finished = false -- 107
			cycle( -- 111
				segment.time, -- 111
				function(time) -- 111
					local currentPos = Vec2(segment.start.x + (segment["end"].x - segment.start.x) * time, segment.start.y + (segment["end"].y - segment.start.y) * time) -- 113
					node.position = currentPos -- 119
					if time == 1 then -- 119
						finished = true -- 121
					end -- 121
				end -- 111
			) -- 111
			wait(function() -- 125
				return finished -- 126
			end) -- 125
			currentNode = currentNode + 1 -- 130
		end -- 130
	end) -- 94
end -- 37
return ____exports -- 37