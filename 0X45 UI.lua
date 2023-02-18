--discord.gg/boronide, code generated using luamin.js™




local b = {
	Unknown = 0,
	Root = 1,
	Category = 2,
	Section = 3,
	Header = 4,
	Entry = 5,
	UiElement = 6,
}
local c = {}
c.__index = c
function c:New(I, J, K)
	local L = setmetatable({}, c)
	L.Type = I or b.Unknown
	L.Parent = J or L.Parent
	L.Children = {}
	L.GuiObject = K or nil
	if J then
		J:AddChild(L)
	end
	return L
end
function c:AddChild(I)
	I.Parent = self
	table.insert(self.Children, I)
	if I.GuiObject and self.GuiObject then
		I.GuiObject.Parent = self.GuiObject
	end
end
function c:RecursiveUpdateGui()
	self:UpdateGui()
	for I, J in ipairs(self.Children) do
		J:RecursiveUpdateGui()
	end
end
function c:UpdateGui()
end
local d = {}
d.__index = d
setmetatable(d, c)
function d:New(I, J, K)
	local L = setmetatable(c:New(b.UiElement), d)
	L.Value = nil
	L.Title = K
	L.Size = I
	L.Position = J
	return L
end
function d:SetValue()
end
function d:GetValue()
	return self.Value
end
local e = {}
e.PrimaryColor = Color3.fromRGB(27, 38, 59)
e.SecondaryColor = Color3.fromRGB(13, 27, 42)
e.AccentColor = Color3.fromRGB(41, 115, 115)
e.TextColor = Color3.new(1, 1, 1)
e.Font = Enum.Font.Gotham
e.TextSize = 13
e.HeaderWidth = 300
e.HeaderHeight = 32
e.EntryMargin = 1
e.AnimationDuration = 0.4
e.AnimationEasingStyle = Enum.EasingStyle.Quint
e.DefaultEntryHeight = 35
local f = {}
f.__index = f
setmetatable(f, d)
function f:New()
	local I = setmetatable(d:New(UDim2.new(0, 20, 0, 20), UDim2.new(1, -20 - 5, 0.5, -20 / 2), ""), f)
	I.GuiObject = Instance.new("TextButton")
	I.GuiObject.MouseButton1Click:Connect(function()
		I.Parent.Parent.Collapsed = not I.Parent.Parent.Collapsed
		if I.Parent.Parent.Collapsed then
			I.Parent.Parent:Collapse()
		else
			I.Parent.Parent:Expand()
		end
	end)
	return I
end
function f:Collapse()
	self.GuiObject.Text = "+"
end
function f:Expand()
	self.GuiObject.Text = "-"
end
function f:UpdateGui()
	self.GuiObject.TextScaled = true
	self.GuiObject.TextColor3 = e.TextColor
	self.GuiObject.BackgroundTransparency = 1
	self.GuiObject.Size = self.Size
	self.GuiObject.Position = self.Position
	if self.Parent.Parent.Collapsed then
		self.GuiObject.Text = "+"
	else
		self.GuiObject.Text = "-"
	end
end
local g = {}
g.__index = g
setmetatable(g, c)
function g:New(I)
	local J = setmetatable(c:New(b.Header), g)
	J.GuiObject = Instance.new("TextLabel")
	J.CollapseButton = f:New()
	J:AddChild(J.CollapseButton)
	return J
end
function g:UpdateGui()
	self.GuiObject.Size = UDim2.new(1, 0, 0, e.HeaderHeight)
	self.GuiObject.Text = self.Parent.Title
	self.GuiObject.TextSize = e.TextSize * 1.25
	self.GuiObject.TextColor3 = e.TextColor
	self.GuiObject.Font = e.Font
	self.GuiObject.BorderSizePixel = 0
	self.GuiObject.BackgroundColor3 = e.SecondaryColor
	if self.Parent.Type == b.Category then
		self.TextSize = e.TextSize * 1.5
	end
end
local h = {}
h.__index = h
setmetatable(h, c)
function h:New(I)
	local J = setmetatable(c:New(b.Entry), h)
	J.Value = nil
	J.Height = I or e.DefaultEntryHeight
	J.GuiObject = Instance.new("Frame")
	return J
end
function h:SetValue()
end
function h:GetValue()
end
function h:UpdateGui()
	self.GuiObject.BackgroundColor3 = e.PrimaryColor
	self.GuiObject.BorderSizePixel = 0
	self.GuiObject.Size = UDim2.new(1, 0, 0, self.Height)
end
local i = {}
i.__index = i
setmetatable(i, c)
function i:New(I, J)
	local K = setmetatable(c:New(J), i)
	K.Collapsed = false
	K.Height = 0
	K.GuiObject = Instance.new("Frame")
	K.Header = g:New()
	K.Title = I or ""
	K:AddChild(K.Header)
	return K
end
function i:UpdateGui()
	self.GuiObject.Size = UDim2.new(0, e.HeaderWidth, 0, 0)
	self.GuiObject.BackgroundColor3 = e.SecondaryColor
	self.GuiObject.BorderSizePixel = 0
	self.GuiObject.ClipsDescendants = true
	self:ReorderGui(true)
end
function i:ReorderGui(I)
	I = I or false
	local J = e.AnimationDuration
	if I then
		J = 0
	end
	self.Height = e.HeaderHeight
	if not self.Collapsed then
		for K, L in pairs(self.Children) do
			if L.Type ~= b.Header then
				L.GuiObject:TweenPosition(UDim2.new(0, 0, 0, self.Height), Enum.EasingDirection.InOut, e.AnimationEasingStyle, J, true)
				self.Height = self.Height + L.Height + e.EntryMargin
			end
		end
		self.Height = self.Height - e.EntryMargin
	end
	self.GuiObject:TweenSize(UDim2.new(0, e.HeaderWidth, 0, self.Height), Enum.EasingDirection.InOut, e.AnimationEasingStyle, J, true)
	if self.Parent.Type ~= b.Root then
		self.Parent:ReorderGui(I)
	end
end
function i:Collapse()
	self.Collapsed = true
	self.Header.CollapseButton:Collapse()
	self:ReorderGui()
end
function i:Expand()
	self.Collapsed = false
	self.Header.CollapseButton:Expand()
	self:ReorderGui()
end
function i:AddEntry(I)
	self:AddChild(I)
	I:RecursiveUpdateGui()
	self:ReorderGui(true)
end
local j = {}
j.__index = j
setmetatable(j, i)
function j:New(I)
	local J = setmetatable(i:New(I, b.Section), j)
	return J
end
function i:CreateSection(I)
	local J = j:New(I)
	self:AddChild(J)
	J:RecursiveUpdateGui()
	return J
end
local k = game:GetService("UserInputService")
local l = {}
l.__index = l
setmetatable(l, i)
function l:New(I, J)
	local K = setmetatable(i:New(I, b.Category), l)
	K.Draggable = J or true
	K.Position = UDim2.new(0, 0, 00)
	K:ApplyDraggability()
	return K
end
function l:MoveTo(I)
	self.Position = I
	self.GuiObject.Position = I
end
function l:AutoMove()
	self:MoveTo(UDim2.fromOffset(100 + (#self.Parent.Children - 1) * (e.HeaderWidth * 1.25), 36))
end
function l:ApplyDraggability()
	self.LastMousePosition = k:GetMouseLocation()
	self.DragActive = false
	self.Header.GuiObject.InputBegan:Connect(function(I)
		if I.UserInputType == Enum.UserInputType.MouseButton1 and self.Draggable then
			self.DragActive = true
		end
	end)
	self.Header.GuiObject.InputEnded:Connect(function(I)
		if I.UserInputType == Enum.UserInputType.MouseButton1 then
			self.DragActive = false
		end
	end)
	k.InputChanged:Connect(function(I)
		if I.UserInputType == Enum.UserInputType.MouseMovement then
			if self.DragActive then
				local J = k:GetMouseLocation() - self.LastMousePosition
				self:MoveTo(UDim2.new(self.GuiObject.Position.X.Scale, self.GuiObject.Position.X.Offset + J.X, self.GuiObject.Position.Y.Scale, self.GuiObject.Position.Y.Offset + J.Y))
			end
			self.LastMousePosition = k:GetMouseLocation()
		end
	end)
end
local m = {}
m.__index = m
setmetatable(m, d)
function m:New(I, J, K, L)
	local M = setmetatable(d:New(I, J, K), m)
	M.Callback = L
	M.GuiObject = Instance.new("TextButton")
	M.GuiObject.MouseButton1Click:Connect(M.Callback)
	return M
end
function m:UpdateGui()
	self.GuiObject.BorderSizePixel = 0
	self.GuiObject.BackgroundColor3 = e.SecondaryColor
	self.GuiObject.TextColor3 = e.TextColor
	self.GuiObject.Size = self.Size
	self.GuiObject.Position = self.Position
	self.GuiObject.Text = self.Title
	self.GuiObject.TextSize = e.TextSize
	self.GuiObject.Font = e.Font
end
function i:CreateButton(I, J)
	local K = h:New()
	K:AddChild(m:New(UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5), I, J))
	self:AddEntry(K)
	return K
end
local n = game:GetService("UserInputService")
local o = {}
o.__index = o
setmetatable(o, d)
function o:New(I, J, K, L, M, N, O, P, Q, R)
	local S = setmetatable(d:New(I, J, K), o)
	S.Callback = L
	S.Dynamic = P or false
	Q = Q or M
	S.Step = O or 0.01
	S.Max = N
	S.Min = M
	S.CustomColor = R
	S.Value = Q or S.Min
	S.GuiObject = Instance.new("Frame")
	S.Bg = Instance.new("Frame", S.GuiObject)
	S.Box = Instance.new("TextBox", S.GuiObject)
	S.Overlay = Instance.new("Frame", S.Bg)
	S.Handle = Instance.new("Frame", S.Overlay)
	S.Label = Instance.new("TextLabel", S.Bg)
	S.Active = false
	S.Bg.InputBegan:Connect(function(T)
		if T.UserInputType == Enum.UserInputType.MouseButton1 then
			S.Active = true
			local U = math.clamp(T.Position.X - S.Bg.AbsolutePosition.X, 0, S.Bg.AbsoluteSize.X) / S.Bg.AbsoluteSize.X
			S:SetValue(S.Min + (U * (S.Max - S.Min)))
		end
	end)
	S.Bg.InputEnded:Connect(function(T)
		if T.UserInputType == Enum.UserInputType.MouseButton1 then
			S.Active = false
			S.Callback(S.Value)
		end
	end)
	n.InputChanged:Connect(function(T)
		if T.UserInputType == Enum.UserInputType.MouseMovement then
			if S.Active then
				local U = math.clamp(T.Position.X - S.Bg.AbsolutePosition.X, 0, S.Bg.AbsoluteSize.X) / S.Bg.AbsoluteSize.X
				S:SetValue(S.Min + (U * (S.Max - S.Min)))
				if S.Dynamic then
					S.Callback(S.Value)
				end
			end
		end
	end)
	S.Box.FocusLost:Connect(function()
		local T = tonumber(S.Box.Text)
		if T then
			S:SetValue(T)
			S.Callback(S.Value)
		else
			S.Box.Text = S.Value
		end
	end)
	return S
end
function o:SetValue(I)
	self.Value = math.clamp(I - I % self.Step, self.Min, self.Max)
	self.Overlay.Size = UDim2.new((self.Value - self.Min) / (self.Max - self.Min), 0, 1, 0)
	self.Box.Text = tostring(self.Value)
end
function o:UpdateGui()
	self.GuiObject.BackgroundColor3 = e.SecondaryColor
	self.GuiObject.Size = self.Size
	self.GuiObject.Position = self.Position
	self.GuiObject.BorderSizePixel = 0
	self.GuiObject.BackgroundTransparency = 1
	self.Bg.BorderSizePixel = 0
	self.Bg.Size = UDim2.new(1 - 0.2, 0, 1, 0)
	self.Bg.BackgroundColor3 = e.SecondaryColor
	self.Box.Size = UDim2.new(0.2, -5, 1, 0)
	self.Box.Position = UDim2.new(0.8, 5, 0, 0)
	self.Box.BorderSizePixel = 0
	self.Box.BackgroundColor3 = e.SecondaryColor
	self.Box.TextColor3 = e.TextColor
	self.Box.TextWrapped = true
	self.Overlay.BorderSizePixel = 0
	self.Overlay.BackgroundColor3 = self.CustomColor or e.AccentColor
	self.Handle.Size = UDim2.new(0, 5, 1, 0)
	self.Handle.Position = UDim2.new(1, -(5 / 2), 0, 0)
	self.Handle.BackgroundColor3 = Color3.new(1, 1, 1)
	self.Handle.BorderSizePixel = 0
	self.Label.Text = self.Title
	self.Label.Font = e.Font
	self.Label.TextSize = e.TextSize
	self.Label.BackgroundTransparency = 1
	self.Label.Size = UDim2.new(1, 0, 1, 0)
	self.Label.TextColor3 = e.TextColor
	self:SetValue(self.Value)
end
local p = {}
p.__index = p
setmetatable(p, h)
function p:New(I, J, K, L, M, N, O)
	local P = setmetatable(h:New(), p)
	P.Slider = o:New(UDim2.new(1, -10, 1, -14), UDim2.new(0, 5, 0, 7), I, function(Q)
		P.Value = Q
		pcall(J, P.Value)
	end, K, L, M, N, O)
	P:SetValue(O or P:GetValue())
	P:AddChild(P.Slider)
	return P
end
function p:SetValue(I)
	self.Slider:SetValue(I)
end
function p:GetValue()
	return self.Slider.Value
end
function i:CreateSlider(I, J, K, L, M, N, O)
	local P = p:New(I, J, K, L, M, N, O)
	self:AddEntry(P)
	return P
end
local q = game:GetService("UserInputService")
local r = {}
r.__index = r
setmetatable(r, d)
function r:New(I, J, K, L, M, N, O)
	local P = setmetatable(d:New(I, J, K), r)
	P.Callback = L
	P.Dynamic = N or false
	P.Value = O or ""
	P.AcceptFormat = M or "^.*$"
	P.GuiObject = Instance.new("TextBox")
	P.GuiObject.FocusLost:Connect(function()
		if string.match(P.GuiObject.Text, P.AcceptFormat) then
			P:SetValue(P.GuiObject.Text)
			P.Callback(P.Value)
		else
			P.GuiObject.Text = P.Value
		end
	end)
	P.GuiObject.Changed:Connect(function(Q)
		if P.Dynamic and Q == "Text" and P.GuiObject:IsFocused() then
			if string.match(P.GuiObject.Text, P.AcceptFormat) then
				P:SetValue(P.GuiObject.Text)
				P.Callback(P.Value)
			else
				P.GuiObject.Text = P.Value
			end
		end
	end)
	return P
end
function r:SetValue(I)
	self.GuiObject.Text = I
	self.Value = I
end
function r:UpdateGui()
	self.GuiObject.BackgroundColor3 = e.SecondaryColor
	self.GuiObject.TextColor3 = e.TextColor
	self.GuiObject.PlaceholderText = self.Title
	self.GuiObject.Position = self.Position
	self.GuiObject.Size = self.Size
	self.GuiObject.TextSize = e.TextSize
	self.GuiObject.Font = e.Font
	self.GuiObject.BorderSizePixel = 0
	self:SetValue(self.Value)
end
local s = {}
s.__index = s
setmetatable(s, h)
function s:New(I, J, K, L, M)
	local N = setmetatable(h:New(), s)
	N.TextBox = r:New(UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5), I, J, K, L, M)
	N:AddChild(N.TextBox)
	return N
end
function s:SetValue(I)
	self.TextBox:SetValue(I)
end
function s:GetValue()
	return self.TextBox.Value
end
function i:CreateTextBox(I, J, K, L, M)
	local N = s:New(I, J, K, L, M)
	self:AddEntry(N)
	return N
end
local t = game:GetService("UserInputService")
local u = {}
u.__index = u
setmetatable(u, d)
function u:New(I, J, K, L, M, N, O)
	local P = setmetatable(d:New(I, J, K), u)
	P.Callback = L
	P.Dynamic = N or false
	P.Value = O or e.AccentColor
	P.GuiObject = Instance.new("Frame")
	P.ColorImg = Instance.new("ImageLabel", P.GuiObject)
	P.Cursor = Instance.new("Frame", P.ColorImg)
	P.RSlider = o:New(UDim2.new(0.5, -10, 1 / 6, 0), UDim2.new(0.5, 5, 0 / 6, 2), "Red", function(Q)
		P:SetValue(Color3.new(Q / 255, P.Value.G, P.Value.B))
	end, 0, 255, 1, true, P.Value.R, Color3.new(0.75, 0, 0))
	P:AddChild(P.RSlider)
	P.GSlider = o:New(UDim2.new(0.5, -10, 1 / 6, 0), UDim2.new(0.5, 5, 1 / 6, 4), "Green", function(Q)
		P:SetValue(Color3.new(P.Value.R, Q / 255, P.Value.B))
	end, 0, 255, 1, true, P.Value.G, Color3.new(0, 0.75, 0))
	P:AddChild(P.GSlider)
	P.BSlider = o:New(UDim2.new(0.5, -10, 1 / 6, 0), UDim2.new(0.5, 5, 2 / 6, 6), "Blue", function(Q)
		P:SetValue(Color3.new(P.Value.R, P.Value.G, Q / 255))
	end, 0, 255, 1, true, P.Value.B, Color3.new(0, 0, 0.75))
	P:AddChild(P.BSlider)
	P.HexBox = r:New(UDim2.new(0.5, -10, 1 / 6, 0), UDim2.new(0.5, 5, 3 / 6, 8), "", function(Q)
		local R = {}
		for S in Q:gmatch("%x%x") do
			table.insert(R, tonumber("0x" .. S))
		end
		P:SetValue(Color3.fromRGB(unpack(R)))
	end, "^%x%x%x%x%x%x$")
	P:AddChild(P.HexBox)
	P.VSlider = o:New(UDim2.new(0.5, -10, 1 / 6, 0), UDim2.new(0.5, 5, 5 / 6, -2), "Value", function(Q)
		local R, S = Color3.toHSV(P.Value)
		P:SetValue(Color3.fromHSV(R, S, Q / 255))
	end, 0, 255, 1, true, ({
		Color3.toHSV(P.Value)
	})[3], Color3.new(0.75, 0.75, 0.75))
	P:AddChild(P.VSlider)
	P.ColorImg.MouseMoved:Connect(function(Q, R)
		if t:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
			local S = Vector2.new(Q, R - 36) - P.ColorImg.AbsolutePosition
			local T, U = 1 - S.X / P.ColorImg.AbsoluteSize.X, 1 - S.Y / P.ColorImg.AbsoluteSize.Y
			P:SetValue(Color3.fromHSV(T, U, P.VSlider.Value / 255))
		end
	end)
	P.ColorImg.InputBegan:Connect(function(Q)
		if Q.UserInputType == Enum.UserInputType.MouseButton1 then
			local R = Vector2.new(Q.Position.X, Q.Position.Y) - P.ColorImg.AbsolutePosition
			local S, T = 1 - R.X / P.ColorImg.AbsoluteSize.X, 1 - R.Y / P.ColorImg.AbsoluteSize.Y
			P:SetValue(Color3.fromHSV(S, T, P.VSlider.Value / 255))
		end
	end)
	P:SetValue(P.Value)
	return P
end
function u:SetValue(I)
	self.Value = I
	local J, K, L = Color3.toHSV(I)
	self.Cursor.Position = UDim2.new(1 - J, -2, 1 - K, -2)
	self.VSlider:SetValue(L * 255)
	self.RSlider:SetValue(I.R * 255)
	self.GSlider:SetValue(I.G * 255)
	self.BSlider:SetValue(I.B * 255)
	self.HexBox:SetValue(string.format("%02x%02x%02x", self.Value.R * 255, self.Value.G * 255, self.Value.B * 255))
	self.Callback(self.Value)
end
function u:UpdateGui()
	self.GuiObject.Size = self.Size
	self.GuiObject.Position = self.Position
	self.GuiObject.BackgroundTransparency = 1
	self.ColorImg.Image = "rbxassetid://698052001"
	self.ColorImg.Size = UDim2.new(0.5, -10, 1, -10)
	self.ColorImg.BorderSizePixel = 0
	self.ColorImg.Position = UDim2.new(0, 5, 0, 5)
	self.Cursor.Size = UDim2.new(0, 4, 0, 4, 0)
	self.Cursor.BorderSizePixel = 0
	self.Cursor.BackgroundColor3 = Color3.new(1, 1, 1)
	self:SetValue(self.Value)
end
local v = {}
v.__index = v
setmetatable(v, h)
function v:New(I, J, K, L)
	local M = setmetatable(h:New(), v)
	M.Title = I
	M.Dynamic = K
	M.Callback = J
	M.Label = Instance.new("TextLabel", M.GuiObject)
	M.ColorButton = Instance.new("TextButton", M.Label)
	M.ColorPicker = u:New(UDim2.new(1, 0, 0, e.HeaderWidth / 2), UDim2.new(0, 0, 0, e.DefaultEntryHeight), I, function(N)
		M.ColorButton.BackgroundColor3 = N
		M.Value = N
		if M.Dynamic and M.Toggled then
			pcall(M.Callback, N)
		end
	end, L)
	M.Toggled = false
	M.ColorButton.MouseButton1Click:Connect(function()
		if M.Toggled then
			M.Height = e.DefaultEntryHeight
			pcall(J, M.Value)
		else
			M.Height = e.HeaderWidth / 2 + e.DefaultEntryHeight
		end
		M.GuiObject:TweenSize(UDim2.new(1, 0, 0, M.Height), Enum.EasingDirection.InOut, e.AnimationEasingStyle, e.AnimationDuration, true)
		M.Parent:ReorderGui()
		M.Toggled = not M.Toggled
	end)
	M:SetValue(L or M:GetValue())
	M:AddChild(M.ColorPicker)
	return M
end
function v:SetValue(I)
	self.ColorPicker:SetValue(I)
end
function v:GetValue()
	return self.ColorPicker.Value
end
function v:UpdateGui()
	self.Label.Size = UDim2.new(1, -16, 0, e.DefaultEntryHeight)
	self.Label.Position = UDim2.new(0, 0, 0, 0)
	self.Label.BackgroundTransparency = 1
	self.Label.Font = e.Font
	self.Label.Text = self.Title
	self.GuiObject.ClipsDescendants = true
	self.GuiObject.BackgroundColor3 = e.PrimaryColor
	self.GuiObject.BorderSizePixel = 0
	self.GuiObject.Size = UDim2.new(1, 0, 0, self.Height)
	self.Label.TextSize = e.TextSize
	self.Label.TextColor3 = e.TextColor
	self.ColorButton.Size = UDim2.new(0, 16, 0, 16, 0)
	self.ColorButton.Position = UDim2.new(1, -37, 0.5, -8)
	self.ColorButton.Text = ""
	self.ColorButton.AutoButtonColor = false
end
function i:CreateColorPicker(I, J, K, L)
	local M = v:New(I, J, K, L)
	self:AddEntry(M)
	M:RecursiveUpdateGui()
	return M
end
local w = game:GetService("UserInputService")
local function x(I, J)
	local K = {}
	for L, M in pairs(I) do
		if string.match(string.lower(tostring(M)), string.lower(J)) then
			table.insert(K, M)
		end
	end
	return K
end
local y = {}
y.__index = y
setmetatable(y, d)
function y:New(I, J, K, L, M)
	local N = setmetatable(d:New(I, J, K), y)
	N.Callback = L
	N.Getcall = M
	N.GuiObject = Instance.new("Frame")
	N.ScrollBox = Instance.new("ScrollingFrame", N.GuiObject)
	N.SearchBox = r:New(UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), "Search", function(O)
		N:SetList(x(M(), O))
	end, nil, true)
	N:AddChild(N.SearchBox)
	return N
end
function y:SetList(I)
	local J = 0
	self.ScrollBox:ClearAllChildren()
	for K, L in pairs(I) do
		local M = Instance.new("TextButton", self.ScrollBox)
		M.Text = tostring(L)
		M.BackgroundColor3 = e.SecondaryColor
		M.TextColor3 = e.TextColor
		M.BorderColor3 = e.PrimaryColor
		M.Size = UDim2.new(1, -4, 0, 30)
		M.Position = UDim2.new(0, 2, 0, M.AbsoluteSize.Y * (J))
		M.MouseButton1Click:Connect(function()
			self.Callback(L)
			self:SetList(x(self.Getcall(), self.SearchBox.Value))
		end)
		J = J + 1
	end
	self.ScrollBox.CanvasSize = UDim2.new(0, 0, 0, #I * 30)
end
function y:UpdateGui()
	self.GuiObject.BorderSizePixel = 0
	self.GuiObject.BackgroundTransparency = 1
	self.GuiObject.Size = self.Size
	self.GuiObject.Position = self.Position
	self.ScrollBox.Position = UDim2.new(0, 0, 0, 30 + 2)
	self.ScrollBox.BackgroundTransparency = 1
	self.ScrollBox.BorderSizePixel = 0
	self.ScrollBox.ScrollBarThickness = 3
	self.ScrollBox.Size = UDim2.new(1, 0, 1, -30)
	self:SetList(self.Getcall())
end
local z = {}
z.__index = z
setmetatable(z, h)
function z:New(I, J, K, L)
	local M = setmetatable(h:New(), z)
	M.Title = I
	M.Callback = J
	M.Selector = y:New(UDim2.new(1, 0, 0, e.DefaultEntryHeight * 5), UDim2.new(0, 0, 0, e.DefaultEntryHeight), I, function(N)
		if not w:IsKeyDown(Enum.KeyCode.LeftShift) then
			M:Toggle()
		end
		M:SetValue(N)
		M.Callback(N)
	end, K)
	M:AddChild(M.Selector)
	M.Button = Instance.new("TextButton", M.GuiObject)
	M.Indicator = Instance.new("TextLabel", M.Button)
	M.Indicator.Text = "▼"
	M.Toggled = false
	M.Button.MouseButton1Click:Connect(function()
		M:Toggle()
		M.Selector:SetList(x(M.Selector.Getcall(), M.Selector.SearchBox.Value))
	end)
	M:SetValue(L)
	return M
end
function z:Toggle()
	if self.Toggled then
		self.Height = e.DefaultEntryHeight
		self.Indicator.Text = "▼"
	else
		self.Height = e.DefaultEntryHeight * 6
		self.Indicator.Text = "▲"
	end
	self.GuiObject:TweenSize(UDim2.new(1, 0, 0, self.Height), Enum.EasingDirection.InOut, e.AnimationEasingStyle, e.AnimationDuration, true)
	self.Parent:ReorderGui()
	self.Toggled = not self.Toggled
end
function z:SetValue(I)
	self.Button.Text = string.format("%s [%s]", self.Title, tostring(I or "Empty"))
	self.Value = I
end
function z:GetValue()
	return self.Value
end
function z:UpdateGui()
	self.GuiObject.ClipsDescendants = true
	self.GuiObject.BackgroundColor3 = e.PrimaryColor
	self.GuiObject.BorderSizePixel = 0
	self.GuiObject.Size = UDim2.new(1, 0, 0, self.Height)
	self.Button.Position = UDim2.new(0, 5, 0, 5)
	self.Button.BorderSizePixel = 0
	self.Button.Font = e.Font
	self.Button.TextSize = e.TextSize
	self.Button.Size = UDim2.new(1, -10, 0, self.Height - 10)
	self.Button.BackgroundColor3 = e.SecondaryColor
	self.Button.TextColor3 = e.TextColor
	self.Button.AutoButtonColor = false
	self.Indicator.Size = UDim2.new(0, 20, 0, 20)
	self.Indicator.Position = UDim2.new(0, 0, 0.5, -10)
	self.Indicator.BackgroundTransparency = 1
	self.Indicator.TextColor3 = e.TextColor
end
function i:CreateSelector(I, J, K, L)
	local M = z:New(I, J, K, L)
	self:AddEntry(M)
	return M
end
local A = game:GetService("UserInputService")
local B = {}
B.__index = B
setmetatable(B, d)
function B:New(I, J, K, L, M)
	local N = setmetatable(d:New(I, J, K), B)
	N.Callback = L
	N.Value = M or false
	N.GuiObject = Instance.new("Frame")
	N.Label = Instance.new("TextLabel", N.GuiObject)
	N.Button = Instance.new("TextButton", N.GuiObject)
	N.Button.MouseButton1Click:Connect(function()
		N:SetValue(not N.Value)
		N.Callback(N.Value)
	end)
	return N
end
function B:SetValue(I)
	self.Value = I
	if self.Value then
		self.Button.BackgroundColor3 = e.AccentColor
	else
		self.Button.BackgroundColor3 = e.SecondaryColor
	end
end
function B:UpdateGui()
	self.GuiObject.Size = self.Size
	self.GuiObject.BackgroundTransparency = 1
	self.GuiObject.Position = self.Position
	self.Label.Text = self.Title
	self.Label.TextSize = e.TextSize
	self.Label.Font = e.Font
	self.Label.BackgroundTransparency = 1
	self.Label.Size = UDim2.new(0.8, 0, 1, 0)
	self.Label.TextColor3 = e.TextColor
	self.Button.Size = UDim2.new(0, 20, 0, 20)
	self.Button.BorderSizePixel = 2
	self.Button.BorderColor3 = e.SecondaryColor
	self.Button.Position = UDim2.new(0.9, -10, 0.5, -10)
	self.Button.Text = ""
	self:SetValue(self.Value)
end
local C = {}
C.__index = C
setmetatable(C, h)
function C:New(I, J, K)
	local L = setmetatable(h:New(), C)
	L.Switch = B:New(UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5), I, J, K)
	L:AddChild(L.Switch)
	return L
end
function C:SetValue(I)
	self.Switch:SetValue(I)
end
function C:GetValue()
	return self.Switch.Value
end
function i:CreateSwitch(I, J, K)
	local L = C:New(I, J, K)
	self:AddEntry(L)
	return L
end
local D = {}
D.__index = D
setmetatable(D, d)
function D:New(I, J, K)
	local L = setmetatable(d:New(I, J, K), D)
	L.GuiObject = Instance.new("TextLabel")
	return L
end
function D:UpdateGui()
	self.GuiObject.BorderSizePixel = 0
	self.GuiObject.BackgroundTransparency = 1
	self.GuiObject.TextColor3 = e.TextColor
	self.GuiObject.Size = self.Size
	self.GuiObject.Position = self.Position
	self.GuiObject.Text = self.Title
	self.GuiObject.TextSize = e.TextSize
	self.GuiObject.Font = e.Font
end
function i:CreateTextLabel(I)
	local J = h:New()
	J:AddChild(D:New(UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5), I))
	self:AddEntry(J)
	return J
end
local E = game:GetService("UserInputService")
local F = {}
F.__index = F
setmetatable(F, d)
function F:New(I, J, K, L, M)
	local N = setmetatable(d:New(I, J, K), F)
	N.Callback = L
	N.Value = M or Enum.KeyCode.Unknown
	N.GuiObject = Instance.new("Frame")
	N.Label = Instance.new("TextLabel", N.GuiObject)
	N.Button = Instance.new("TextButton", N.GuiObject)
	N.Button.MouseButton1Click:Connect(function()
		N.Button.Text = "..."
		local O
		repeat
			O = E.InputBegan:Wait()
		until O.UserInputType == Enum.UserInputType.Keyboard
		N:SetValue(O.KeyCode)
		N.Callback(N.Value)
	end)
	return N
end
function F:SetValue(I)
	self.Value = I
	self.Button.Text = I.Name
end
function F:UpdateGui()
	self.GuiObject.BackgroundTransparency = 1
	self.GuiObject.Size = self.Size
	self.GuiObject.Position = self.Position
	self.Label.Size = UDim2.new(0.8, 0, 1, 0)
	self.Label.BackgroundTransparency = 1
	self.Label.TextSize = e.TextSize
	self.Label.Text = self.Title
	self.Label.Font = e.Font
	self.Label.TextColor3 = e.TextColor
	self.Button.Size = UDim2.new(0.2, 0, 1, 0)
	self.Button.BorderSizePixel = 0
	self.Button.TextColor3 = e.TextColor
	self.Button.BackgroundColor3 = e.SecondaryColor
	self.Button.Position = UDim2.new(0.8, 0, 0, 0)
	self:SetValue(self.Value)
end
local G = {}
G.__index = G
setmetatable(G, h)
function G:New(I, J, K)
	local L = setmetatable(h:New(), G)
	L.KeyDetector = F:New(UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5), I, J, K)
	L:AddChild(L.KeyDetector)
	return L
end
function G:SetValue(I)
	self.KeyDetector:SetValue(I)
end
function G:GetValue()
	return self.KeyDetector.Value
end
function i:CreateKeyDetector(I, J, K)
	local L = G:New(I, J, K)
	self:AddEntry(L)
	return L
end
local H = {}
H.__index = H
setmetatable(H, c)
function H:New(I)
	local J = setmetatable(c:New(b.Root), H)
	J.ScreenGui = Instance.new("ScreenGui", I or game.Players.LocalPlayer.PlayerGui)
	J.GuiObject = Instance.new("Frame", J.ScreenGui)
	return J
end
function H:UpdateGui()
	self.ScreenGui.ResetOnSpawn = false
	self.ScreenGui.IgnoreGuiInset = true
	self.GuiObject.Size = UDim2.new(1, 0, 1, 0)
	self.GuiObject.BackgroundTransparency = 1
end
function H:Hide()
	self.ScreenGui.Enabled = false
end
function H:Show()
	self.ScreenGui.Enabled = true
end
function H:CleanUp()
	self.ScreenGui:Destroy()
	self = nil
end
function H:CreateCategory(I, J)
	local K = l:New(I, J)
	self:AddChild(K)
	if J then
		K:MoveTo(J)
	else
		K:AutoMove()
	end
	K:RecursiveUpdateGui()
	return K
end
function H:LoadConfig(I)
	for J, K in pairs(I) do
		e[J] = K
	end
end
function H:Init(I, J)
	local K = H:New(J)
	K:LoadConfig(I or {})
	K:RecursiveUpdateGui()
	return K
end
return H
