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
____exports.Button = __TS__Class() -- 41
local Button = ____exports.Button -- 41
Button.name = "Button" -- 41
__TS__ClassExtends(Button, React.Component) -- 41
function Button.prototype.____constructor(self, props) -- 68
	Button.____super.prototype.____constructor(self, props) -- 69
	self.defaultProps = { -- 42
		type = "click", -- 43
		x = 0, -- 45
		y = 0, -- 46
		width = "60%", -- 47
		height = "60%", -- 48
		onClick = function() -- 49
		end, -- 49
		onStateChange = function(____, state) -- 50
		end, -- 50
		normalImage = "Image/button/button.clip|button_up", -- 51
		pressImage = "Image/button/button.clip|button_down", -- 52
		text = "", -- 53
		fontName = "sarasa-mono-sc-regular", -- 54
		fontSize = 40, -- 55
		color = 16777215, -- 56
		scale = 1 -- 57
	} -- 57
	self.state = "normal" -- 59
	self.tempchange = false -- 60
	self.switched = false -- 61
	self.setState = function(____, state) -- 76
		self.state = state -- 77
		if state == "pressed" then -- 77
			if self.spriteRef1.current then -- 77
				self.spriteRef1.current.visible = false -- 80
			end -- 80
			if self.spriteRef2.current then -- 80
				self.spriteRef2.current.visible = true -- 82
			end -- 82
		else -- 82
			if self.spriteRef1.current then -- 82
				self.spriteRef1.current.visible = true -- 85
			end -- 85
			if self.spriteRef2.current then -- 85
				self.spriteRef2.current.visible = false -- 87
			end -- 87
		end -- 87
	end -- 76
	self.onTapBegan = function() -- 91
		if self.state == "normal" then -- 91
			self.tempchange = true -- 94
			self:setState("pressed") -- 95
			local ____this_1 -- 95
			____this_1 = self.props -- 96
			local ____opt_0 = ____this_1.onStateChange -- 96
			if ____opt_0 ~= nil then -- 96
				____opt_0(____this_1, "pressed") -- 96
			end -- 96
		end -- 96
	end -- 91
	self.onTapEnded = function() -- 100
		if self.tempchange == true then -- 100
			self:setState("normal") -- 103
			local ____this_3 -- 103
			____this_3 = self.props -- 104
			local ____opt_2 = ____this_3.onStateChange -- 104
			if ____opt_2 ~= nil then -- 104
				____opt_2(____this_3, "normal") -- 104
			end -- 104
			self.tempchange = false -- 105
		end -- 105
	end -- 100
	self.onTapped = function() -- 109
		if self.props.type == "click" then -- 109
			self:setState("normal") -- 112
			local ____this_5 -- 112
			____this_5 = self.props -- 113
			local ____opt_4 = ____this_5.onStateChange -- 113
			if ____opt_4 ~= nil then -- 113
				____opt_4(____this_5, "normal") -- 113
			end -- 113
		else -- 113
			if self.switched == false then -- 113
				self.switched = true -- 116
				self:setState("pressed") -- 117
			else -- 117
				self.switched = false -- 119
				self:setState("normal") -- 120
				local ____this_7 -- 120
				____this_7 = self.props -- 121
				local ____opt_6 = ____this_7.onStateChange -- 121
				if ____opt_6 ~= nil then -- 121
					____opt_6(____this_7, "normal") -- 121
				end -- 121
			end -- 121
		end -- 121
		local ____this_9 -- 121
		____this_9 = self.props -- 124
		local ____opt_8 = ____this_9.onClick -- 124
		if ____opt_8 ~= nil then -- 124
			____opt_8(____this_9, self.switched) -- 124
		end -- 124
	end -- 109
	self.props = __TS__ObjectAssign({}, self.defaultProps, props) -- 70
	self.spriteRef1 = useRef() -- 71
	self.spriteRef2 = useRef() -- 72
	self.labelRef = useRef() -- 73
end -- 68
function Button.prototype.render(self) -- 126
	local ____self_props_10 = self.props -- 128
	local x = ____self_props_10.x -- 128
	local y = ____self_props_10.y -- 128
	local width = ____self_props_10.width -- 128
	local height = ____self_props_10.height -- 128
	local normalImage = ____self_props_10.normalImage -- 128
	local pressImage = ____self_props_10.pressImage -- 128
	local text = ____self_props_10.text -- 128
	local fontName = ____self_props_10.fontName -- 128
	local fontSize = ____self_props_10.fontSize -- 128
	local color = ____self_props_10.color -- 128
	return React.createElement( -- 129
		"align-node", -- 129
		{ -- 129
			style = { -- 129
				width = width * self.props.scale, -- 130
				height = height * self.props.scale, -- 130
				display = "flex", -- 131
				justifyContent = "center", -- 132
				alignItems = "center", -- 133
				border = "2px" -- 134
			}, -- 134
			x = x * self.props.scale, -- 134
			y = y * self.props.scale, -- 134
			onLayout = function(width, height) -- 134
				print("----")
				print(width) -- 139
				print(height) -- 140
				print(self.props.scale) -- 141
				print(width * self.props.scale) -- 142
				print(height * self.props.scale) -- 143
				local position = Vec2(width / 2, height / 2) -- 144
				local size = Size(self.props.width * self.props.scale, self.props.height * self.props.scale) -- 145
				local refs = {self.spriteRef1, self.spriteRef2} -- 147
				__TS__ArrayForEach( -- 148
					refs, -- 148
					function(____, ref) -- 148
						local current = ref.current -- 149
						if current then -- 149
							current.position = position -- 151
							current.size = size -- 152
						end -- 152
					end -- 148
				) -- 148
				if self.labelRef.current then -- 148
					self.labelRef.current.position = position -- 156
				end -- 156
			end, -- 137
			onMount = function(node) -- 137
				node:gslot( -- 160
					"ScaleUpdated", -- 160
					function(scale) -- 160
						self.props.scale = scale -- 161
					end -- 160
				) -- 160
			end -- 159
		}, -- 159
		React.createElement("sprite", {ref = self.spriteRef1, file = self.props.normalImage, visible = not self.switched}), -- 159
		React.createElement("sprite", {ref = self.spriteRef2, file = self.props.pressImage, visible = self.switched}), -- 159
		React.createElement("label", { -- 159
			ref = self.labelRef, -- 159
			text = text, -- 159
			fontName = fontName or "sarasa-mono-sc-regular", -- 159
			fontSize = fontSize or 40, -- 159
			color3 = color -- 159
		}), -- 159
		React.createElement("align-node", {style = {width = "100%", height = "100%"}, onTapBegan = self.onTapBegan, onTapped = self.onTapped, onTapEnded = self.onTapEnded}) -- 159
	) -- 159
end -- 126
return ____exports -- 126