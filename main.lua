--// THREEBLOX V3 | FINAL STABLE
--// NO SCROLL | MINIMIZE LOGO | ICON FIX | ANDROID + PC

local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- CLEAN OLD
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
local ACCENT = Color3.fromRGB(170,80,255)

local A_MAIN = 0.08
local A_SIDE = 0.05
local A_CARD = 0.06

-- PAGE ICONS (TELEPORT FIX)
local PAGES = {
	{"Information","ℹ"},
	{"Auto Option","⚙"},
	{"Teleport","➜"}, -- FIX
	{"Quest","★"},
	{"Shop & Trade","🛒"},
	{"Misc","⚡"},
}

-- AUTO OPTION
local AUTO_OPTIONS = {
	{"Auto Fishing","⚙"},
	{"Legit Perfect","⭕"},
	{"Blatant Fishing","🔥"},
	{"Auto Farm Island","✏"},
	{"Auto Favorite","⭐"},
	{"Auto Sell","💰"},
	{"Auto Totem","➕"},
	{"Auto Potion","🧪"},
}

-- ROOT
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true

-- MINI LOGO
local miniLogo = Instance.new("ImageButton", gui)
miniLogo.Size = UDim2.new(0,56,0,56)
miniLogo.Position = UDim2.new(0,20,1,-80)
miniLogo.Image = LOGO_ID
miniLogo.Visible = false
miniLogo.BackgroundColor3 = BG
miniLogo.BackgroundTransparency = A_MAIN
miniLogo.BorderSizePixel = 0
miniLogo.AutoButtonColor = false
Instance.new("UICorner", miniLogo).CornerRadius = UDim.new(1,0)

-- DRAG MINI LOGO
do
	local d,s,p
	miniLogo.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			d=true s=i.Position p=miniLogo.Position
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if d then
			local dx=i.Position-s
			miniLogo.Position=UDim2.new(p.X.Scale,p.X.Offset+dx.X,p.Y.Scale,p.Y.Offset+dx.Y)
		end
	end)
	UIS.InputEnded:Connect(function() d=false end)
end

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,880,0,500)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
main.BackgroundTransparency = A_MAIN
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
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = TEXT
title.Text = "Threeblox V3 | Auto Option"

-- DRAG MAIN
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

-- MINIMIZE
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-72,0.5,-15)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.TextColor3 = Color3.new(0,0,0)
minBtn.BackgroundColor3 = ACCENT
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-36,0.5,-15)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = TEXT
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,48)
sidebar.Size = UDim2.new(0,200,1,-48)
sidebar.BackgroundColor3 = SIDE
sidebar.BackgroundTransparency = A_SIDE

local sLayout = Instance.new("UIListLayout", sidebar)
sLayout.Padding = UDim.new(0,8)
sLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,12)

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,200,0,48)
content.Size = UDim2.new(1,-200,1,-48)
content.BackgroundTransparency = 1

-- PAGES
local pages = {}
local function newPage(name)
	local p = Instance.new("Frame", content)
	p.Size = UDim2.new(1,0,1,0)
	p.Visible = false
	p.BackgroundTransparency = 1
	pages[name]=p
	return p
end

local autoPage = newPage("Auto Option")
for _,v in ipairs(PAGES) do
	if not pages[v[1]] then newPage(v[1]) end
end

local function showPage(name)
	for _,p in pairs(pages) do p.Visible=false end
	pages[name].Visible=true
	title.Text="Threeblox V3 | "..name
end

-- SIDEBAR BUTTON
local function sideBtn(name,icon)
	local b = Instance.new("TextButton", sidebar)
	b.Size = UDim2.new(1,-20,0,38)
	b.Text = icon.."  "..name
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = TEXT
	b.BackgroundColor3 = CARD
	b.BackgroundTransparency = A_CARD
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(function()
		showPage(name)
	end)
end

for _,v in ipairs(PAGES) do
	sideBtn(v[1],v[2])
end

-- AUTO OPTION ITEMS
local layout = Instance.new("UIListLayout", autoPage)
layout.Padding = UDim.new(0,10)
Instance.new("UIPadding", autoPage).PaddingTop = UDim.new(0,16)
Instance.new("UIPadding", autoPage).PaddingLeft = UDim.new(0,16)

local function autoItem(text,emoji)
	local f = Instance.new("Frame", autoPage)
	f.Size = UDim2.new(1,-32,0,42)
	f.BackgroundColor3 = CARD
	f.BackgroundTransparency = A_CARD
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

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
end

for _,v in ipairs(AUTO_OPTIONS) do
	autoItem(v[1],v[2])
end

pages["Auto Option"].Visible = true

-- BUTTON ACTION
minBtn.MouseButton1Click:Connect(function()
	main.Visible=false
	miniLogo.Visible=true
end)

miniLogo.MouseButton1Click:Connect(function()
	main.Visible=true
	miniLogo.Visible=false
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
