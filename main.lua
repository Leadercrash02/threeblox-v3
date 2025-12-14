--// THREEBLOX V3 | FISH IT
--// FULL PATCH FINAL - EMOJI CLEAN (NO WEIRD ICON)
--// SAFE | TRANSPARENT | NO ROBLOX UI BUG
--// PC + ANDROID (XENO / DELTA)

--================ SERVICES =================--
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

--================ SAFE CLEAN =================--
pcall(function()
	for _,v in ipairs(CoreGui:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name == "ThreebloxV3" then
			v:Destroy()
		end
	end
end)

--================ CONFIG =================--
local LOGO_ID = "rbxassetid://121625492591707"

-- COLORS
local BG     = Color3.fromRGB(18,20,28)
local SIDE   = Color3.fromRGB(22,24,34)
local CARD   = Color3.fromRGB(28,30,42)
local TEXT   = Color3.fromRGB(235,235,235)
local MUTED  = Color3.fromRGB(180,180,180)
local ACCENT = Color3.fromRGB(170,80,255)

-- TRANSPARENCY
local ALPHA_MAIN = 0.08
local ALPHA_SIDE = 0.05
local ALPHA_CARD = 0.06

-- CLEAN EMOJI (STYLE LAMA / PREMIUM)
local PAGE_ICONS = {
	["Information"]  = "ℹ",
	["Auto Option"]  = "⚙",
	["Teleport"]     = "✦",
	["Quest"]        = "★",
	["Shop & Trade"] = "🛒",
	["Misc"]         = "⚡",
}

-- AUTO OPTION ICON (TETAP SIMPLE)
local AUTO_ICONS = {
	["Auto Fishing"]      = "⚙",
	["Legit Perfect"]    = "⭕",
	["Blatant Fishing"]  = "🔥",
	["Auto Farm Island"] = "✏",
	["Auto Favorite"]    = "🛒",
	["Auto Sell"]        = "💰",
	["Auto Totem"]       = "➕",
	["Auto Potion"]      = "🧪",
}

--================ ROOT GUI =================--
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = CoreGui

--================ MINI LOGO =================--
local mini = Instance.new("ImageButton", gui)
mini.Size = UDim2.new(0,56,0,56)
mini.Position = UDim2.new(0,20,1,-80)
mini.Image = LOGO_ID
mini.BackgroundColor3 = BG
mini.BackgroundTransparency = ALPHA_MAIN
mini.BorderSizePixel = 0
mini.Visible = false
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

-- DRAG MINI
do
	local d,s,p
	mini.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			d=true s=i.Position p=mini.Position
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if d then
			local dx=i.Position-s
			mini.Position=UDim2.new(p.X.Scale,p.X.Offset+dx.X,p.Y.Scale,p.Y.Offset+dx.Y)
		end
	end)
	UIS.InputEnded:Connect(function() d=false end)
end

--================ MAIN =================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,880,0,500)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
main.BackgroundTransparency = ALPHA_MAIN
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--================ HEADER =================--
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
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
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

-- HEADER BUTTON
local function hBtn(txt,color,x)
	local b=Instance.new("TextButton",header)
	b.Size=UDim2.new(0,30,0,30)
	b.Position=UDim2.new(1,x,0.5,-15)
	b.Text=txt
	b.Font=Enum.Font.GothamBold
	b.TextSize=16
	b.TextColor3=Color3.new(1,1,1)
	b.BackgroundColor3=color
	b.BorderSizePixel=0
	Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
	return b
end

local minBtn=hBtn("-",ACCENT,-72)
local closeBtn=hBtn("X",Color3.fromRGB(200,60,60),-36)

--================ SIDEBAR =================--
local sidebar=Instance.new("Frame",main)
sidebar.Position=UDim2.new(0,0,0,48)
sidebar.Size=UDim2.new(0,200,1,-48)
sidebar.BackgroundColor3=SIDE
sidebar.BackgroundTransparency=ALPHA_SIDE

local sideLayout=Instance.new("UIListLayout",sidebar)
sideLayout.Padding=UDim.new(0,8)
sideLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
Instance.new("UIPadding",sidebar).PaddingTop=UDim.new(0,12)

--================ CONTENT =================--
local content=Instance.new("Frame",main)
content.Position=UDim2.new(0,200,0,48)
content.Size=UDim2.new(1,-200,1,-48)
content.BackgroundTransparency=1

--================ PAGE SYSTEM =================--
local pages={}
local function newPage(name)
	local p=Instance.new("Frame",content)
	p.Size=UDim2.new(1,0,1,0)
	p.BackgroundTransparency=1
	p.Visible=false
	pages[name]=p
	return p
end

local autoPage=newPage("Auto Option")
newPage("Information")
newPage("Teleport")
newPage("Quest")
newPage("Shop & Trade")
newPage("Misc")

local function showPage(name)
	for _,p in pairs(pages) do p.Visible=false end
	pages[name].Visible=true
	title.Text="Threeblox V3 | "..name
end

--================ SIDEBAR BUTTON =================--
local function sideBtn(name)
	local b=Instance.new("TextButton",sidebar)
	b.Size=UDim2.new(1,-20,0,38)
	b.Text=PAGE_ICONS[name].."  "..name
	b.Font=Enum.Font.Gotham
	b.TextSize=14
	b.TextColor3=TEXT
	b.BackgroundColor3=CARD
	b.BackgroundTransparency=ALPHA_CARD
	b.BorderSizePixel=0
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
	b.MouseButton1Click:Connect(function()
		showPage(name)
	end)
end

for name,_ in pairs(PAGE_ICONS) do
	sideBtn(name)
end

--================ AUTO OPTION CONTENT =================--
local scroll=Instance.new("ScrollingFrame",autoPage)
scroll.Position=UDim2.new(0,16,0,16)
scroll.Size=UDim2.new(1,-32,1,-32)
scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
scroll.ScrollBarThickness=6
scroll.BackgroundTransparency=1

local layout=Instance.new("UIListLayout",scroll)
layout.Padding=UDim.new(0,10)

local function autoItem(text)
	local f=Instance.new("Frame",scroll)
	f.Size=UDim2.new(1,0,0,42)
	f.BackgroundColor3=CARD
	f.BackgroundTransparency=ALPHA_CARD
	Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)

	local t=Instance.new("TextLabel",f)
	t.Size=UDim2.new(1,-20,1,0)
	t.Position=UDim2.new(0,12,0,0)
	t.BackgroundTransparency=1
	t.Font=Enum.Font.Gotham
	t.TextSize=15
	t.TextXAlignment=Enum.TextXAlignment.Left
	t.TextColor3=TEXT
	t.Text=AUTO_ICONS[text].."  "..text
end

for name,_ in pairs(AUTO_ICONS) do
	autoItem(name)
end

pages["Auto Option"].Visible=true

--================ BUTTON ACTION =================--
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
