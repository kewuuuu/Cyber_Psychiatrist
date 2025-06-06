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
____exports.Button = __TS__Class() -- 45
local Button = ____exports.Button -- 45
Button.name = "Button" -- 45
__TS__ClassExtends(Button, React.Component) -- 45
function Button.prototype.____constructor(self, props) -- 76
	Button.____super.prototype.____constructor(self, props) -- 77
	self.defaultProps = { -- 46
		type = "click", -- 47
		x = 0, -- 49
		y = 0, -- 50
		width = "60%", -- 51
		height = "60%", -- 52
		onClick = function() -- 53
		end, -- 53
		onStateChange = function(____, state) -- 54
		end, -- 54
		normalImage = "Image/button/button.clip|button_up", -- 55
		pressImage = "Image/button/button.clip|button_down", -- 56
		text = "", -- 57
		fontName = "sarasa-mono-sc-regular", -- 58
		fontSize = 40, -- 59
		color = 16777215, -- 60
		viewState = {scale = 1, NowViewWidth = 1000, NowViewHeight = 500} -- 61
	} -- 61
	self.state = "normal" -- 67
	self.tempchange = false -- 68
	self.switched = false -- 69
	self.setState = function(____, state) -- 85
		self.state = state -- 86
		if state == "pressed" then -- 86
			if self.spriteRef1.current then -- 86
				self.spriteRef1.current.visible = false -- 89
			end -- 89
			if self.spriteRef2.current then -- 89
				self.spriteRef2.current.visible = true -- 91
			end -- 91
		else -- 91
			if self.spriteRef1.current then -- 91
				self.spriteRef1.current.visible = true -- 94
			end -- 94
			if self.spriteRef2.current then -- 94
				self.spriteRef2.current.visible = false -- 96
			end -- 96
		end -- 96
	end -- 85
	self.onTapBegan = function() -- 100
		if self.state == "normal" then -- 100
			self.tempchange = true -- 103
			self:setState("pressed") -- 104
			local ____this_1 -- 104
			____this_1 = self.props -- 105
			local ____opt_0 = ____this_1.onStateChange -- 105
			if ____opt_0 ~= nil then -- 105
				____opt_0(____this_1, "pressed") -- 105
			end -- 105
		end -- 105
	end -- 100
	self.onTapEnded = function() -- 109
		if self.tempchange == true then -- 109
			self:setState("normal") -- 112
			local ____this_3 -- 112
			____this_3 = self.props -- 113
			local ____opt_2 = ____this_3.onStateChange -- 113
			if ____opt_2 ~= nil then -- 113
				____opt_2(____this_3, "normal") -- 113
			end -- 113
			self.tempchange = false -- 114
		end -- 114
	end -- 109
	self.onTapped = function() -- 118
		if self.props.type == "click" then -- 118
			self:setState("normal") -- 121
			local ____this_5 -- 121
			____this_5 = self.props -- 122
			local ____opt_4 = ____this_5.onStateChange -- 122
			if ____opt_4 ~= nil then -- 122
				____opt_4(____this_5, "normal") -- 122
			end -- 122
		else -- 122
			if self.switched == false then -- 122
				self.switched = true -- 125
				self:setState("pressed") -- 126
			else -- 126
				self.switched = false -- 128
				self:setState("normal") -- 129
				local ____this_7 -- 129
				____this_7 = self.props -- 130
				local ____opt_6 = ____this_7.onStateChange -- 130
				if ____opt_6 ~= nil then -- 130
					____opt_6(____this_7, "normal") -- 130
				end -- 130
			end -- 130
		end -- 130
		local ____this_9 -- 130
		____this_9 = self.props -- 133
		local ____opt_8 = ____this_9.onClick -- 133
		if ____opt_8 ~= nil then -- 133
			____opt_8(____this_9, self.switched) -- 133
		end -- 133
	end -- 118
	self.props = __TS__ObjectAssign({}, self.defaultProps, props) -- 78
	self.spriteRef1 = useRef() -- 79
	self.spriteRef2 = useRef() -- 80
	self.labelRef = useRef() -- 81
	self.nodeRef = useRef() -- 82
end -- 76
function Button.prototype.render(self) -- 135
	return React.createElement( -- 138
		"align-node", -- 138
		{ -- 138
			style = { -- 138
				width = self.props.width * self.props.viewState.scale, -- 139
				height = self.props.height * self.props.viewState.scale, -- 139
				display = "flex", -- 140
				justifyContent = "center", -- 141
				alignItems = "center", -- 142
				border = "2px" -- 143
			}, -- 143
			ref = self.nodeRef, -- 143
			x = self.props.x * self.props.viewState.scale, -- 143
			y = self.props.y * self.props.viewState.scale, -- 143
			onLayout = function(width, height) -- 143
				print("----")
				print(width) -- 149
				print(height) -- 150
				print(self.props.viewState.scale) -- 151
				print(self.props.width * self.props.viewState.scale) -- 152
				print(self.props.height * self.props.viewState.scale) -- 153
				local position = Vec2(width / 2, height / 2) -- 154
				local size = Size(self.props.width * self.props.viewState.scale, self.props.height * self.props.viewState.scale) -- 155
				print(position:add(Vec2(self.props.x * self.props.viewState.scale, self.props.y * self.props.viewState.scale))) -- 156
				if self.nodeRef.current then -- 156
					self.nodeRef.current.position = position:add(Vec2(self.props.x * self.props.viewState.scale, self.props.y * self.props.viewState.scale)) -- 159
				end -- 159
				local refs = {self.spriteRef1, self.spriteRef2} -- 162
				__TS__ArrayForEach( -- 163
					refs, -- 163
					function(____, ref) -- 163
						local current = ref.current -- 164
						if current then -- 164
							current.position = position -- 166
							current.size = size -- 167
						end -- 167
					end -- 163
				) -- 163
				if self.labelRef.current then -- 163
					self.labelRef.current.position = position -- 171
				end -- 171
			end, -- 147
			onMount = function(node) -- 147
				node:gslot( -- 175
					"ScaleUpdated", -- 175
					function(viewState) -- 175
						self.props.viewState = viewState -- 176
					end -- 175
				) -- 175
			end -- 174
		}, -- 174
		React.createElement("sprite", {ref = self.spriteRef1, file = self.props.normalImage, visible = not self.switched}), -- 174
		React.createElement("sprite", {ref = self.spriteRef2, file = self.props.pressImage, visible = self.switched}), -- 174
		React.createElement("label", { -- 174
			ref = self.labelRef, -- 174
			text = self.props.text, -- 174
			fontName = self.props.fontName or "sarasa-mono-sc-regular", -- 174
			fontSize = self.props.fontSize or 40, -- 174
			color3 = self.props.color -- 174
		}), -- 174
		React.createElement("align-node", {style = {width = "100%", height = "100%"}, onTapBegan = self.onTapBegan, onTapped = self.onTapped, onTapEnded = self.onTapEnded}) -- 174
	) -- 174
end -- 135
return ____exports -- 135