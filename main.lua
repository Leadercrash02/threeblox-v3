--==================================================
-- THREEBLOX V3 | RAW GUI (MATCH REFERENCE)
-- UI ONLY | NO ENGINE | NO REMOTE
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

pcall(function()
	if pg:FindFirstChild("ThreebloxV3") then
		pg.ThreebloxV3:Destroy()
	end
end)

--================ CONFIG =================
local LOGO_ID = "rbxassetid://121625492591707"

local C = {
	BG = Color3.fromRGB(18,20,28),
	SIDE = Color3.fromRGB(22,24,34),
	CARD = Color3.fromRGB(28,30,42),
	TEXT = Color3.fromRGB(235,235,235),
	MUTED = Color3.fromRGB(160,160,160),
	ACCENT = Color3.fromRGB(170,80,255),
	RED = Color3.fromRGB(220,70,70),
}

--================ ROOT ===================
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3"
gui.ResetOnSpawn = false

--================ MAIN ===================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,720,0,420)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = C.BG
main.BorderSizePixel = 0
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- drag
do
	local d,s,p
	main.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			d=true s=i.Position p=main.Position
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if d then
			local dx=i.Position-s
			main.Position=UDim2.new(p.X.Scale,p.X.Offset+dx.X,p.Y.Scale,p.Y.Offset+dx.Y)
		end
	end)
	UIS.InputEnded:Connect(function() d=false end)
end

--================ HEADER =================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,44)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-120,1,0)
title.Position = UDim2.new(0,16,0,0)
title.Text = "Threeblox V3 | Auto Option"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = C.TEXT
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0,28,0,24)
close.Position = UDim2.new(1,-36,0.5,-12)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = C.RED
Instance.new("UICorner", close).CornerRadius = UDim.new(0,6)
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

--================ SIDEBAR ================
local side = Instance.new("Frame", main)
side.Position = UDim2.new(0,0,0,44)
side.Size = UDim2.new(0,190,1,-44)
side.BackgroundColor3 = C.SIDE

local sl = Instance.new("UIListLayout", side)
sl.Padding = UDim.new(0,6)
Instance.new("UIPadding", side).PaddingTop = UDim.new(0,12)

local function SideBtn(txt)
	local b = Instance.new("TextButton", side)
	b.Size = UDim2.new(1,-20,0,36)
	b.Position = UDim2.new(0,10,0,0)
	b.Text = txt
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = C.TEXT
	b.BackgroundColor3 = C.CARD
	b.BackgroundTransparency = 0.05
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

SideBtn("ℹ  Information")
SideBtn("⚙  Auto Option")
SideBtn("➜  Teleport")
SideBtn("★  Quest")
SideBtn("🛒  Shop & Trade")
SideBtn("⚡  Misc")

--================ CONTENT =================
local content = Instance.new("ScrollingFrame", main)
content.Position = UDim2.new(0,190,0,44)
content.Size = UDim2.new(1,-190,1,-44)
content.ScrollBarImageTransparency = 1
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.CanvasSize = UDim2.new(0,0,0,0)
content.BackgroundTransparency = 1

local cl = Instance.new("UIListLayout", content)
cl.Padding = UDim.new(0,8)
Instance.new("UIPadding", content).PaddingTop = UDim.new(0,16)
Instance.new("UIPadding", content).PaddingLeft = UDim.new(0,16)
Instance.new("UIPadding", content).PaddingRight = UDim.new(0,16)

local function AutoItem(text)
	local f = Instance.new("Frame", content)
	f.Size = UDim2.new(1,0,0,44)
	f.BackgroundColor3 = C.CARD
	f.BackgroundTransparency = 0.05
	f.ClipsDescendants = true
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,8)

	local lbl = Instance.new("TextLabel", f)
	lbl.Size = UDim2.new(1,-40,1,0)
	lbl.Position = UDim2.new(0,14,0,0)
	lbl.Text = text
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 15
	lbl.TextColor3 = C.TEXT
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.BackgroundTransparency = 1

	local arrow = Instance.new("TextLabel", f)
	arrow.Size = UDim2.new(0,30,1,0)
	arrow.Position = UDim2.new(1,-30,0,0)
	arrow.Text = ">"
	arrow.Font = Enum.Font.GothamBold
	arrow.TextSize = 16
	arrow.TextColor3 = C.MUTED
	arrow.BackgroundTransparency = 1
end

-- AUTO OPTION ITEMS (MATCH FOTO)
AutoItem("⚙  Auto Fishing")
AutoItem("⭕  Legit Perfect")
AutoItem("🔥  Blatant Fishing")
AutoItem("✏  Auto Farm Island")
AutoItem("⭐  Auto Favorite")
AutoItem("💰  Auto Sell")
AutoItem("➕  Auto Totem")
AutoItem("🧪  Auto Potion")

print("[Threeblox V3] GUI raw loaded (match reference)")
