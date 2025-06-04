-- [tsx]: Button.tsx
local ____lualib = require("lualib_bundle") -- 1
local __TS__Class = ____lualib.__TS__Class -- 1
local __TS__ClassExtends = ____lualib.__TS__ClassExtends -- 1
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign -- 1
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach -- 1
local ____exports = {} -- 1
local ____DoraX = require("DoraX") -- 2
local React = ____DoraX.React -- 2
local useRef = ____DoraX.useRef -- 2
local ____Dora = require("Dora") -- 3
local Vec2 = ____Dora.Vec2 -- 3
local Size = ____Dora.Size -- 3
____exports.Button = __TS__Class() -- 40
local Button = ____exports.Button -- 40
Button.name = "Button" -- 40
__TS__ClassExtends(Button, React.Component) -- 40
function Button.prototype.____constructor(self, props) -- 65
	Button.____super.prototype.____constructor(self, props) -- 66
	self.defaultProps = { -- 41
		type = "click", -- 42
		x = 0, -- 44
		y = 0, -- 45
		width = "60%", -- 46
		height = "60%", -- 47
		onClick = function() -- 48
		end, -- 48
		onStateChange = function(____, state) -- 49
		end, -- 49
		normalImage = "Image/button/button.clip|button_up", -- 50
		pressImage = "Image/button/button.clip|button_down", -- 51
		text = "", -- 52
		fontName = "sarasa-mono-sc-regular", -- 53
		fontSize = 40, -- 54
		color = 16777215 -- 55
	} -- 55
	self.state = "normal" -- 57
	self.tempchange = false -- 58
	self.switched = false -- 59
	self.setState = function(____, state) -- 73
		self.state = state -- 74
		if state == "pressed" then -- 74
			if self.spriteRef1.current then -- 74
				self.spriteRef1.current.visible = false -- 77
			end -- 77
			if self.spriteRef2.current then -- 77
				self.spriteRef2.current.visible = true -- 79
			end -- 79
		else -- 79
			if self.spriteRef1.current then -- 79
				self.spriteRef1.current.visible = true -- 82
			end -- 82
			if self.spriteRef2.current then -- 82
				self.spriteRef2.current.visible = false -- 84
			end -- 84
		end -- 84
	end -- 73
	self.onTapBegan = function() -- 88
		if self.state == "normal" then -- 88
			self.tempchange = true -- 91
			self:setState("pressed") -- 92
			local ____this_1 -- 92
			____this_1 = self.props -- 93
			local ____opt_0 = ____this_1.onStateChange -- 93
			if ____opt_0 ~= nil then -- 93
				____opt_0(____this_1, "pressed") -- 93
			end -- 93
		end -- 93
	end -- 88
	self.onTapEnded = function() -- 97
		if self.tempchange == true then -- 97
			self:setState("normal") -- 100
			local ____this_3 -- 100
			____this_3 = self.props -- 101
			local ____opt_2 = ____this_3.onStateChange -- 101
			if ____opt_2 ~= nil then -- 101
				____opt_2(____this_3, "normal") -- 101
			end -- 101
			self.tempchange = false -- 102
		end -- 102
	end -- 97
	self.onTapped = function() -- 106
		if self.props.type == "click" then -- 106
			self:setState("normal") -- 109
			local ____this_5 -- 109
			____this_5 = self.props -- 110
			local ____opt_4 = ____this_5.onStateChange -- 110
			if ____opt_4 ~= nil then -- 110
				____opt_4(____this_5, "normal") -- 110
			end -- 110
		else -- 110
			if self.switched == false then -- 110
				self.switched = true -- 113
				self:setState("pressed") -- 114
			else -- 114
				self.switched = false -- 116
				self:setState("normal") -- 117
				local ____this_7 -- 117
				____this_7 = self.props -- 118
				local ____opt_6 = ____this_7.onStateChange -- 118
				if ____opt_6 ~= nil then -- 118
					____opt_6(____this_7, "normal") -- 118
				end -- 118
			end -- 118
		end -- 118
		local ____this_9 -- 118
		____this_9 = self.props -- 121
		local ____opt_8 = ____this_9.onClick -- 121
		if ____opt_8 ~= nil then -- 121
			____opt_8(____this_9, self.switched) -- 121
		end -- 121
	end -- 106
	self.props = __TS__ObjectAssign({}, self.defaultProps, props) -- 67
	self.spriteRef1 = useRef() -- 68
	self.spriteRef2 = useRef() -- 69
	self.labelRef = useRef() -- 70
end -- 65
function Button.prototype.render(self) -- 123
	local ____self_props_10 = self.props -- 125
	local x = ____self_props_10.x -- 125
	local y = ____self_props_10.y -- 125
	local width = ____self_props_10.width -- 125
	local height = ____self_props_10.height -- 125
	local normalImage = ____self_props_10.normalImage -- 125
	local pressImage = ____self_props_10.pressImage -- 125
	local text = ____self_props_10.text -- 125
	local fontName = ____self_props_10.fontName -- 125
	local fontSize = ____self_props_10.fontSize -- 125
	local color = ____self_props_10.color -- 125
	return React.createElement( -- 126
		"align-node", -- 126
		{ -- 126
			style = { -- 126
				width = width, -- 127
				height = height, -- 127
				display = "flex", -- 128
				justifyContent = "center", -- 129
				alignItems = "center" -- 130
			}, -- 130
			x = x, -- 130
			y = y, -- 130
			onLayout = function(width, height) -- 130
				print(width) -- 134
				local position = Vec2(width / 2, height / 2) -- 135
				local size = Size(width, height) -- 136
				local refs = {self.spriteRef1, self.spriteRef2} -- 138
				__TS__ArrayForEach( -- 139
					refs, -- 139
					function(____, ref) -- 139
						local current = ref.current -- 140
						if current then -- 140
							current.position = position -- 142
							current.size = size -- 143
						end -- 143
					end -- 139
				) -- 139
				if self.labelRef.current then -- 139
					self.labelRef.current.position = position -- 147
				end -- 147
			end -- 133
		}, -- 133
		React.createElement("sprite", {ref = self.spriteRef1, file = self.props.normalImage, visible = not self.switched}), -- 133
		React.createElement("sprite", {ref = self.spriteRef2, file = self.props.pressImage, visible = self.switched}), -- 133
		React.createElement("label", { -- 133
			ref = self.labelRef, -- 133
			text = text, -- 133
			fontName = fontName or "sarasa-mono-sc-regular", -- 133
			fontSize = fontSize or 40, -- 133
			color3 = color -- 133
		}), -- 133
		React.createElement("align-node", {style = {width = "100%", height = "100%"}, onTapBegan = self.onTapBegan, onTapped = self.onTapped, onTapEnded = self.onTapEnded}) -- 133
	) -- 133
end -- 123
return ____exports -- 123