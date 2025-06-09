-- [tsx]: Button2.tsx
local ____lualib = require("lualib_bundle") -- 1
local __TS__Class = ____lualib.__TS__Class -- 1
local __TS__ClassExtends = ____lualib.__TS__ClassExtends -- 1
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign -- 1
local ____exports = {} -- 1
local ____DoraX = require("DoraX") -- 2
local React = ____DoraX.React -- 2
local useRef = ____DoraX.useRef -- 2
____exports.ButtonLabel = function(props) -- 37
	return React.createElement("label", {text = props.text, fontName = "sarasa-mono-sc-regular", fontSize = props.fontSize or 24, color3 = props.color or 16777215}) -- 42
end -- 37
____exports.Button = __TS__Class() -- 52
local Button = ____exports.Button -- 52
Button.name = "Button" -- 52
__TS__ClassExtends(Button, React.Component) -- 52
function Button.prototype.____constructor(self, props) -- 74
	Button.____super.prototype.____constructor(self, props) -- 75
	self.defaultProps = { -- 53
		type = "click", -- 54
		x = 0, -- 56
		y = 0, -- 57
		width = 100, -- 58
		height = 50, -- 59
		textColor = 4294967295, -- 60
		fontSize = 20, -- 61
		onClick = function() -- 62
		end, -- 62
		onStateChange = function(____, state) -- 63
		end, -- 63
		normalImage = "Image/button/button.clip|button_up", -- 64
		pressImage = "Image/button/button.clip|button_down" -- 65
	} -- 65
	self.state = "normal" -- 67
	self.tempchange = false -- 68
	self.switched = false -- 69
	self.setState = function(____, state) -- 81
		self.state = state -- 82
		if state == "pressed" then -- 82
			if self.spriteRef1.current then -- 82
				self.spriteRef1.current.visible = false -- 85
			end -- 85
			if self.spriteRef2.current then -- 85
				self.spriteRef2.current.visible = true -- 87
			end -- 87
		else -- 87
			if self.spriteRef1.current then -- 87
				self.spriteRef1.current.visible = true -- 90
			end -- 90
			if self.spriteRef2.current then -- 90
				self.spriteRef2.current.visible = false -- 92
			end -- 92
		end -- 92
	end -- 81
	self.onTapBegan = function() -- 96
		if self.state == "normal" then -- 96
			self.tempchange = true -- 99
			self:setState("pressed") -- 100
			local ____this_1 -- 100
			____this_1 = self.props -- 101
			local ____opt_0 = ____this_1.onStateChange -- 101
			if ____opt_0 ~= nil then -- 101
				____opt_0(____this_1, "pressed") -- 101
			end -- 101
		end -- 101
	end -- 96
	self.onTapEnded = function() -- 105
		if self.tempchange == true then -- 105
			self:setState("normal") -- 108
			local ____this_3 -- 108
			____this_3 = self.props -- 109
			local ____opt_2 = ____this_3.onStateChange -- 109
			if ____opt_2 ~= nil then -- 109
				____opt_2(____this_3, "normal") -- 109
			end -- 109
			self.tempchange = false -- 110
		end -- 110
	end -- 105
	self.onTapped = function() -- 114
		if self.props.type == "click" then -- 114
			self:setState("normal") -- 117
			local ____this_5 -- 117
			____this_5 = self.props -- 118
			local ____opt_4 = ____this_5.onStateChange -- 118
			if ____opt_4 ~= nil then -- 118
				____opt_4(____this_5, "normal") -- 118
			end -- 118
		else -- 118
			if self.switched == false then -- 118
				self.switched = true -- 121
				self:setState("pressed") -- 122
			else -- 122
				self.switched = false -- 124
				self:setState("normal") -- 125
				local ____this_7 -- 125
				____this_7 = self.props -- 126
				local ____opt_6 = ____this_7.onStateChange -- 126
				if ____opt_6 ~= nil then -- 126
					____opt_6(____this_7, "normal") -- 126
				end -- 126
			end -- 126
		end -- 126
		local ____this_9 -- 126
		____this_9 = self.props -- 129
		local ____opt_8 = ____this_9.onClick -- 129
		if ____opt_8 ~= nil then -- 129
			____opt_8(____this_9, self.switched) -- 129
		end -- 129
	end -- 114
	self.props = __TS__ObjectAssign({}, self.defaultProps, props) -- 76
	self.spriteRef1 = useRef() -- 77
	self.spriteRef2 = useRef() -- 78
end -- 74
function Button.prototype.render(self) -- 131
	return React.createElement( -- 133
		React.Fragment, -- 133
		nil, -- 133
		React.createElement( -- 133
			"node", -- 133
			{x = self.props.x, y = self.props.y}, -- 133
			React.createElement("sprite", { -- 133
				ref = self.spriteRef1, -- 133
				file = self.props.normalImage, -- 133
				width = self.props.width, -- 133
				height = self.props.height, -- 133
				visible = not self.switched -- 133
			}), -- 133
			React.createElement("sprite", { -- 133
				ref = self.spriteRef2, -- 133
				file = self.props.pressImage, -- 133
				width = self.props.width, -- 133
				height = self.props.height, -- 133
				visible = self.switched -- 133
			}), -- 133
			self.props.children, -- 148
			React.createElement("node", { -- 148
				width = self.props.width or 100, -- 148
				height = self.props.height or 50, -- 148
				onTapBegan = self.onTapBegan, -- 148
				onTapped = self.onTapped, -- 148
				onTapEnded = self.onTapEnded -- 148
			}) -- 148
		) -- 148
	) -- 148
end -- 131
return ____exports -- 131