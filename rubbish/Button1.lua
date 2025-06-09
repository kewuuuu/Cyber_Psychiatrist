-- [tsx]: Button1.tsx
local ____lualib = require("lualib_bundle") -- 1
local __TS__Class = ____lualib.__TS__Class -- 1
local __TS__ClassExtends = ____lualib.__TS__ClassExtends -- 1
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign -- 1
local ____exports = {} -- 1
local ____DoraX = require("DoraX") -- 2
local React = ____DoraX.React -- 2
____exports.ButtonLabel = function(props) -- 36
	return React.createElement("label", {text = props.text, fontName = "sarasa-mono-sc-regular", fontSize = props.fontSize or 24, color3 = props.color or 16777215}) -- 41
end -- 36
____exports.Button = __TS__Class() -- 51
local Button = ____exports.Button -- 51
Button.name = "Button" -- 51
__TS__ClassExtends(Button, React.Component) -- 51
function Button.prototype.____constructor(self, props) -- 72
	Button.____super.prototype.____constructor(self, props) -- 73
	self.defaultProps = { -- 52
		type = "click", -- 53
		x = 0, -- 55
		y = 0, -- 56
		width = 100, -- 57
		height = 50, -- 58
		textColor = 4294967295, -- 59
		fontSize = 20, -- 60
		onClick = function() -- 61
		end, -- 61
		onStateChange = function(____, state) -- 62
		end, -- 62
		normalImage = "Image/button/button_0.png", -- 63
		pressImage = "Image/button/button_2.png" -- 65
	} -- 65
	self.state = "normal" -- 67
	self.switched = false -- 68
	self.onTapBegan = function() -- 91
		print("onTapBegan") -- 92
		self.state = "pressed" -- 93
		print(self.state) -- 94
	end -- 91
	self.onTapEnded = function() -- 96
		print("onTapEnded") -- 97
		if self.props.type == "click" then -- 97
			self.state = "normal" -- 99
		else -- 99
			if self.switched == false then -- 99
				self.switched = true -- 102
			else -- 102
				self.switched = false -- 104
				self.state = "normal" -- 105
			end -- 105
		end -- 105
		print(self.state) -- 108
	end -- 96
	self.props = __TS__ObjectAssign({}, self.defaultProps, props) -- 74
end -- 72
function Button.prototype.render(self) -- 155
	local ____React_createElement_5 = React.createElement -- 155
	local ____React_Fragment_4 = React.Fragment -- 155
	local ____React_createElement_3 = React.createElement -- 155
	local ____temp_2 = {x = self.props.x, y = self.props.y} -- 155
	local ____React_createElement_1 = React.createElement -- 155
	local ____temp_0 -- 159
	if self.state == "normal" then -- 159
		____temp_0 = self.props.normalImage -- 159
	else -- 159
		____temp_0 = self.props.pressImage -- 159
	end -- 159
	return ____React_createElement_5( -- 156
		____React_Fragment_4, -- 156
		nil, -- 156
		____React_createElement_3( -- 156
			"node", -- 156
			____temp_2, -- 156
			____React_createElement_1("sprite", {file = ____temp_0, width = self.props.width, height = self.props.height}), -- 156
			React.createElement("node", {width = self.props.width or 100, height = self.props.height or 50, onTapBegan = self.onTapBegan, onTapEnded = self.onTapEnded}) -- 156
		) -- 156
	) -- 156
end -- 155
return ____exports -- 155