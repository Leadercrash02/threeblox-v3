--// THREEBLOX V3 | AUTO OPTION FIX FINAL
--// FIX: COLOR + EMOJI (AUTO SELL & AUTO POTION)
--// SAFE | TRANSPARENT | NO UI ROBLOX BUG

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- CLEAN ONLY THREEBLOX
pcall(function()
	for _,v in ipairs(CoreGui:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name == "ThreebloxV3" then
			v:Destroy()
		end
	end
end)

-- CONFIG
local LOGO_ID = "rbxassetid://121625492591707"

local BG     = Color3.fromRGB(18,20,28)
local SIDE   = Color3.fromRGB(22,24,34)
local CARD   = Color3.fromRGB(28,30,42)
local TEXT   = Color3.fromRGB(235,235,235)
local MUTED  = Color3.fromRGB(160,160,160)
local ACCENT = Color3.fromRGB(170,80,255)

local ALPHA_MAIN = 0.08
local ALPHA_SIDE = 0.05
local ALPHA_CARD = 0.06

-- PAGE ICON (CLEAN)
local PAGE_ICONS = {
	{"Information","ℹ"},
	{"Auto Option","⚙"},
	{"Teleport","✦"},
	{"Quest","★"},
	{"Shop & Trade","🛒"},
	{"Misc","⚡"},
}

-- AUTO OPTION LIST (FIXED & COMPLETE)
local AUTO_OPTIONS = {
	{"Auto Fishing","⚙"},
	{"Legit Perfect","⭕"},
	{"Blatant Fishing","🔥"},
	{"Auto Farm Island","✏"},
	{"Auto Favorite","⭐"},
	{"Auto Sell","💰"},      -- FIX
	{"Auto Totem","➕"},
	{"Auto Potion","🧪"},   -- FIX
}

-- ROOT GUI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,880,0,500)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
main.BackgroundTransparency = ALPHA_MAIN
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,48)
header.BackgroundTransparency = 1
header.Active = true

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-120,1,0)
title.Position = UDim2.new(0,16,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = TEXT
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "Threeblox V3 | Auto Option"

-- DRAG
do
	local d,s,p
	header.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
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

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,48)
sidebar.Size = UDim2.new(0,200,1,-48)
sidebar.BackgroundColor3 = SIDE
sidebar.BackgroundTransparency = ALPHA_SIDE

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,8)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,12)

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,200,0,48)
content.Size = UDim2.new(1,-200,1,-48)
content.BackgroundTransparency = 1

-- PAGE
local pages = {}
local function newPage(name)
	local p = Instance.new("Frame", content)
	p.Size = UDim2.new(1,0,1,0)
	p.Visible = false
	p.BackgroundTransparency = 1
	pages[name] = p
	return p
end

local autoPage = newPage("Auto Option")
newPage("Information")
newPage("Teleport")
newPage("Quest")
newPage("Shop & Trade")
newPage("Misc")

-- SIDEBAR BUTTON
local function sideBtn(name,emoji)
	local b = Instance.new("TextButton", sidebar)
	b.Size = UDim2.new(1,-20,0,38)
	b.Text = emoji.."  "..name
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = TEXT
	b.BackgroundColor3 = CARD
	b.BackgroundTransparency = ALPHA_CARD
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(function()
		for _,p in pairs(pages) do p.Visible=false end
		pages[name].Visible=true
		title.Text="Threeblox V3 | "..name
	end)
end

for _,v in ipairs(PAGE_ICONS) do
	sideBtn(v[1],v[2])
end

-- AUTO OPTION UI
local scroll = Instance.new("ScrollingFrame", autoPage)
scroll.Position = UDim2.new(0,16,0,16)
scroll.Size = UDim2.new(1,-32,1,-32)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,10)

-- AUTO ITEM (WITH COLOR)
local function autoItem(text,emoji)
	local f = Instance.new("Frame", scroll)
	f.Size = UDim2.new(1,0,0,42)
	f.BackgroundColor3 = CARD
	f.BackgroundTransparency = ALPHA_CARD
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

	-- ACCENT BAR
	local bar = Instance.new("Frame", f)
	bar.Size = UDim2.new(0,4,1,0)
	bar.BackgroundColor3 = ACCENT

	local lbl = Instance.new("TextLabel", f)
	lbl.Position = UDim2.new(0,12,0,0)
	lbl.Size = UDim2.new(1,-20,1,0)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 15
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextColor3 = TEXT
	lbl.Text = emoji.."  "..text

	-- HOVER EFFECT
	f.MouseEnter:Connect(function()
		f.BackgroundTransparency = 0
	end)
	f.MouseLeave:Connect(function()
		f.BackgroundTransparency = ALPHA_CARD
	end)
end

for _,v in ipairs(AUTO_OPTIONS) do
	autoItem(v[1],v[2])
end

pages["Auto Option"].Visible = true
