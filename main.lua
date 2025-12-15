--// THREEBLOX V3 | FINAL UI ENGINE
--// UI ONLY | NO FEATURE REMOVED | PC + ANDROID SAFE
--// READY FOR REMOTE / LOGIC INJECTION

--==================== SERVICES ====================--
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--==================== CLEAN ====================--
pcall(function()
	for _,v in ipairs(pg:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name == "ThreebloxV3" then
			v:Destroy()
		end
	end
end)

--==================== CONFIG ====================--
local LOGO_ID = "rbxassetid://121625492591707"

local COLORS = {
	BG      = Color3.fromRGB(16,18,26),
	SIDE    = Color3.fromRGB(20,22,32),
	CARD    = Color3.fromRGB(28,30,42),
	TEXT    = Color3.fromRGB(235,235,235),
	MUTED   = Color3.fromRGB(170,170,170),
	ACCENT  = Color3.fromRGB(165,90,255),
	RED     = Color3.fromRGB(200,60,60)
}

--==================== ROOT ====================--
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

--==================== MINI LOGO ====================--
local mini = Instance.new("ImageButton", gui)
mini.Size = UDim2.new(0,56,0,56)
mini.Position = UDim2.new(0,20,0.5,-28)
mini.Image = LOGO_ID
mini.BackgroundColor3 = COLORS.BG
mini.Visible = false
mini.AutoButtonColor = false
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

-- drag mini
do
	local d,s,p
	mini.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			d=true s=i.Position p=mini.Position
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if d then
			local delta=i.Position-s
			mini.Position=UDim2.new(p.X.Scale,p.X.Offset+delta.X,p.Y.Scale,p.Y.Offset+delta.Y)
		end
	end)
	UIS.InputEnded:Connect(function() d=false end)
end

--==================== MAIN ====================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,900,0,520)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = COLORS.BG
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--==================== HEADER ====================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,50)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Text = "Threeblox V3 | Auto Option"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = COLORS.TEXT
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,-120,1,0)
title.Position = UDim2.new(0,16,0,0)
title.TextXAlignment = Left

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-72,0.5,-15)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.TextColor3 = Color3.new(0,0,0)
minBtn.BackgroundColor3 = COLORS.ACCENT
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-36,0.5,-15)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = COLORS.TEXT
closeBtn.BackgroundColor3 = COLORS.RED
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

--==================== SIDEBAR ====================--
local side = Instance.new("Frame", main)
side.Position = UDim2.new(0,0,0,50)
side.Size = UDim2.new(0,220,1,-50)
side.BackgroundColor3 = COLORS.SIDE

local sideLayout = Instance.new("UIListLayout", side)
sideLayout.Padding = UDim.new(0,8)
sideLayout.HorizontalAlignment = Center
Instance.new("UIPadding", side).PaddingTop = UDim.new(0,12)

local pages = {}
local currentPage

local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,220,0,50)
content.Size = UDim2.new(1,-220,1,-50)
content.BackgroundTransparency = 1

local function createPage(name)
	local p = Instance.new("Frame", content)
	p.Size = UDim2.new(1,0,1,0)
	p.BackgroundTransparency = 1
	p.Visible = false
	pages[name] = p
	return p
end

local function switchPage(name)
	for k,v in pairs(pages) do v.Visible=false end
	currentPage=name
	pages[name].Visible=true
	title.Text = "Threeblox V3 | "..name
end

local function sideBtn(text, emoji, page)
	local b = Instance.new("TextButton", side)
	b.Size = UDim2.new(1,-20,0,40)
	b.Text = emoji.."  "..text
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = COLORS.TEXT
	b.BackgroundColor3 = COLORS.CARD
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(function()
		switchPage(page)
	end)
end

--==================== PAGES ====================--
createPage("Information")
createPage("Auto Option")
createPage("Teleport")
createPage("Quest")
createPage("Shop & Trade")
createPage("Misc")

sideBtn("Information","👤","Information")
sideBtn("Auto Option","⚙️","Auto Option")
sideBtn("Teleport","✨","Teleport")
sideBtn("Quest","📜","Quest")
sideBtn("Shop & Trade","🛒","Shop & Trade")
sideBtn("Misc","🧩","Misc")

--==================== AUTO OPTION ====================--
local auto = pages["Auto Option"]
local y = 16

local function section(titleText)
	local t = Instance.new("TextLabel", auto)
	t.Text = titleText
	t.Font = Enum.Font.GothamBold
	t.TextSize = 16
	t.TextColor3 = COLORS.TEXT
	t.BackgroundTransparency = 1
	t.Position = UDim2.new(0,20,0,y)
	t.Size = UDim2.new(1,-40,0,24)
	y = y + 30
end

local function toggle(text)
	local f = Instance.new("Frame", auto)
	f.Position = UDim2.new(0,20,0,y)
	f.Size = UDim2.new(1,-40,0,44)
	f.BackgroundColor3 = COLORS.CARD
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

	local l = Instance.new("TextLabel", f)
	l.Text = text
	l.Font = Enum.Font.Gotham
	l.TextSize = 14
	l.TextColor3 = COLORS.TEXT
	l.BackgroundTransparency = 1
	l.Position = UDim2.new(0,16,0,0)
	l.Size = UDim2.new(1,-80,1,0)
	l.TextXAlignment = Left

	local b = Instance.new("TextButton", f)
	b.Size = UDim2.new(0,40,0,20)
	b.Position = UDim2.new(1,-56,0.5,-10)
	b.Text = ""
	b.BackgroundColor3 = COLORS.MUTED
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)

	local on=false
	b.MouseButton1Click:Connect(function()
		on=not on
		b.BackgroundColor3 = on and COLORS.ACCENT or COLORS.MUTED
	end)

	y = y + 52
end

-- AUTO OPTION CONTENT (SAMA PERSIS)
section("Auto Fishing")
toggle("Enable Auto Fishing")

section("Legit Perfect")
toggle("Enable Legit Perfect")

section("Blatant Fishing")
toggle("Enable Blatant Fishing")

section("Auto Favorite")
toggle("Favorite by Tier")
toggle("Favorite by Variant")
toggle("Favorite by Fish Name")

section("Auto Farm Island")
toggle("Enable Auto Farm Island")

section("Auto Sell")
toggle("Enable Auto Sell")

section("Auto Totem")
toggle("Enable Auto Totem")

section("Auto Potion")
toggle("Enable Auto Potion")

--==================== DEFAULT ====================--
switchPage("Auto Option")

--==================== ACTION ====================--
minBtn.MouseButton1Click:Connect(function()
	main.Visible=false
	mini.Visible=true
end)

mini.MouseButton1Click:Connect(function()
	main.Visible=true
	mini.Visible=false
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
