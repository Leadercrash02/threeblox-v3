--// THREEBLOX V3 | FISH IT
--// FINAL FIX • CLEAN • SCROLL • NO DUMMY ITEM
--// PC + ANDROID SAFE

--================ SERVICES ================--
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ CLEAN OLD GUI ================--
pcall(function()
	for _,v in ipairs(pg:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name:find("Threeblox") then
			v:Destroy()
		end
	end
end)

--================ COLORS ================--
local BG     = Color3.fromRGB(18,20,28)
local SIDE   = Color3.fromRGB(22,24,34)
local CARD   = Color3.fromRGB(28,30,42)
local TEXT   = Color3.fromRGB(235,235,235)
local MUTED  = Color3.fromRGB(180,180,180)
local ACCENT = Color3.fromRGB(170,80,255)

--================ ROOT GUI ================--
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

--================ MAIN WINDOW ================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 880, 0, 500)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--================ HEADER ================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,48)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-120,1,0)
title.Position = UDim2.new(0,16,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = TEXT
title.Text = "Threeblox V3 | Information"

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-36,0.5,-15)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = TEXT
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- MINIMIZE
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-72,0.5,-15)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.TextColor3 = Color3.new(0,0,0)
minBtn.BackgroundColor3 = ACCENT
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

--================ SIDEBAR ================--
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,48)
sidebar.Size = UDim2.new(0,200,1,-48)
sidebar.BackgroundColor3 = SIDE
sidebar.BorderSizePixel = 0

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,8)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local sidePad = Instance.new("UIPadding", sidebar)
sidePad.PaddingTop = UDim.new(0,12)

--================ CONTENT ================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,200,0,48)
content.Size = UDim2.new(1,-200,1,-48)
content.BackgroundTransparency = 1

--================ PAGE SYSTEM ================--
local pages = {}

local function createPage(name)
	local p = Instance.new("Frame", content)
	p.Size = UDim2.new(1,0,1,0)
	p.BackgroundTransparency = 1
	p.Visible = false
	pages[name] = p
	return p
end

--================ BASE PAGE (SCROLL + TITLE) ================--
local function buildBasePage(pageName)
	local page = pages[pageName]

	local headerLbl = Instance.new("TextLabel", page)
	headerLbl.Size = UDim2.new(1,-32,0,34)
	headerLbl.Position = UDim2.new(0,16,0,12)
	headerLbl.BackgroundTransparency = 1
	headerLbl.Font = Enum.Font.GothamBold
	headerLbl.TextSize = 22
	headerLbl.TextXAlignment = Enum.TextXAlignment.Left
	headerLbl.TextColor3 = TEXT
	headerLbl.Text = pageName

	local scroll = Instance.new("ScrollingFrame", page)
	scroll.Position = UDim2.new(0,16,0,54)
	scroll.Size = UDim2.new(1,-32,1,-70)
	scroll.CanvasSize = UDim2.new(0,0,0,0)
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.ScrollBarThickness = 6
	scroll.ScrollBarImageTransparency = 0.4
	scroll.BackgroundTransparency = 1

	local layout = Instance.new("UIListLayout", scroll)
	layout.Padding = UDim.new(0,10)

	return scroll
end

--================ CREATE PAGES ================--
createPage("Information")
createPage("Auto Option")
createPage("Teleport")
createPage("Quest")
createPage("Shop & Trade")
createPage("Misc")

--================ BUILD BASE UI ================--
local infoScroll  = buildBasePage("Information")
local autoScroll  = buildBasePage("Auto Option")
local tpScroll    = buildBasePage("Teleport")
local questScroll = buildBasePage("Quest")
local shopScroll  = buildBasePage("Shop & Trade")
local miscScroll  = buildBasePage("Misc")

--================ AUTO OPTION ITEMS ================--
local function createAutoItem(text, iconId)
	local item = Instance.new("TextButton", autoScroll)
	item.Size = UDim2.new(1,0,0,42)
	item.BackgroundColor3 = CARD
	item.BorderSizePixel = 0
	item.Text = ""
	item.AutoButtonColor = false
	item.ClipsDescendants = true
	Instance.new("UICorner", item).CornerRadius = UDim.new(0,10)

	local icon = Instance.new("ImageLabel", item)
	icon.Size = UDim2.new(0,20,0,20)
	icon.Position = UDim2.new(0,16,0.5,-10)
	icon.BackgroundTransparency = 1
	icon.Image = iconId
	icon.ImageColor3 = MUTED

	local label = Instance.new("TextLabel", item)
	label.Position = UDim2.new(0,48,0,0)
	label.Size = UDim2.new(1,-96,1,0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 15
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.TextColor3 = TEXT
	label.TextWrapped = false
	label.TextTruncate = Enum.TextTruncate.AtEnd
	label.Text = text

	local arrow = Instance.new("TextLabel", item)
	arrow.Size = UDim2.new(0,32,1,0)
	arrow.Position = UDim2.new(1,-32,0,0)
	arrow.BackgroundTransparency = 1
	arrow.Font = Enum.Font.GothamBold
	arrow.TextSize = 18
	arrow.Text = ">"
	arrow.TextColor3 = MUTED
end

-- AUTO OPTION LIST
createAutoItem("Auto Fishing",     "rbxassetid://6034509993")
createAutoItem("Legit Perfect",    "rbxassetid://6031068433")
createAutoItem("Blatant Fishing",  "rbxassetid://6034287525")
createAutoItem("Auto Farm Island", "rbxassetid://6034328955")
createAutoItem("Auto Favorite",    "rbxassetid://6031265976")
createAutoItem("Auto Sell",        "rbxassetid://6034509983")
createAutoItem("Auto Totem",       "rbxassetid://6035047377")
createAutoItem("Auto Potion",      "rbxassetid://6034328940")

--================ SIDEBAR BUTTONS ================--
local function sideButton(name)
	local b = Instance.new("TextButton", sidebar)
	b.Size = UDim2.new(1,-20,0,38)
	b.BackgroundColor3 = CARD
	b.BorderSizePixel = 0
	b.Text = name
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = TEXT
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)

	b.MouseButton1Click:Connect(function()
		for n,p in pairs(pages) do
			p.Visible = (n == name)
		end
		title.Text = "Threeblox V3 | "..name
	end)
end

sideButton("Information")
sideButton("Auto Option")
sideButton("Teleport")
sideButton("Quest")
sideButton("Shop & Trade")
sideButton("Misc")

pages["Information"].Visible = true

--================ DRAG WINDOW ================--
local dragging, dragStart, startPos
header.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = i.Position
		startPos = main.Position
	end
end)

UIS.InputChanged:Connect(function(i)
	if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = i.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

--================ BUTTON ACTIONS ================--
minBtn.MouseButton1Click:Connect(function()
	main.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
