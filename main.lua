--// THREEBLOX V3 | FISH IT
--// FULL UI FINAL | ICON TEXT (ANTI BLOCK)
--// UI ONLY | PC + ANDROID SAFE (XENO / DELTA)

--================ SERVICES =================--
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ CLEAN OLD =================--
pcall(function()
	for _,v in ipairs(pg:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name:find("Threeblox") then
			v:Destroy()
		end
	end
end)

--================ CONFIG =================--
local LOGO_ID = "rbxassetid://121625492591707"

local BG     = Color3.fromRGB(18,20,28)
local SIDE   = Color3.fromRGB(22,24,34)
local CARD   = Color3.fromRGB(28,30,42)
local TEXT   = Color3.fromRGB(235,235,235)
local MUTED  = Color3.fromRGB(180,180,180)
local ACCENT = Color3.fromRGB(170,80,255)

--================ ROOT GUI =================--
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

--================ MINI LOGO =================--
local mini = Instance.new("ImageButton", gui)
mini.Size = UDim2.new(0,56,0,56)
mini.Position = UDim2.new(0,20,1,-80)
mini.Image = LOGO_ID
mini.BackgroundColor3 = BG
mini.Visible = false
mini.BorderSizePixel = 0
mini.AutoButtonColor = false
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

do
	local drag,start,pos
	mini.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			drag=true start=i.Position pos=mini.Position
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if drag then
			local d=i.Position-start
			mini.Position=UDim2.new(pos.X.Scale,pos.X.Offset+d.X,pos.Y.Scale,pos.Y.Offset+d.Y)
		end
	end)
	UIS.InputEnded:Connect(function() drag=false end)
end

--================ MAIN =================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,900,0,520)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--================ HEADER =================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,48)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-120,1,0)
title.Position = UDim2.new(0,16,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = TEXT
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "Threeblox V3"

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-72,0.5,-15)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.BackgroundColor3 = ACCENT
minBtn.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-36,0.5,-15)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.TextColor3 = TEXT
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

--================ SIDEBAR =================--
local side = Instance.new("Frame", main)
side.Position = UDim2.new(0,0,0,48)
side.Size = UDim2.new(0,200,1,-48)
side.BackgroundColor3 = SIDE
side.BorderSizePixel = 0

local sideLayout = Instance.new("UIListLayout", side)
sideLayout.Padding = UDim.new(0,8)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", side).PaddingTop = UDim.new(0,12)

--================ CONTENT =================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,200,0,48)
content.Size = UDim2.new(1,-200,1,-48)
content.BackgroundTransparency = 1

--================ PAGE SYSTEM =================--
local pages = {}

local function createPage(name)
	local p = Instance.new("Frame", content)
	p.Size = UDim2.new(1,0,1,0)
	p.BackgroundTransparency = 1
	p.Visible = false
	pages[name] = p
	return p
end

local pageNames = {
	"Information",
	"Auto Option",
	"Teleport",
	"Quest",
	"Shop & Trade",
	"Misc"
}

for _,n in ipairs(pageNames) do
	createPage(n)
end

--================ SIDEBAR BUTTON =================--
local function sideBtn(name)
	local b = Instance.new("TextButton", side)
	b.Size = UDim2.new(1,-20,0,38)
	b.Text = name
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = TEXT
	b.BackgroundColor3 = CARD
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)

	b.MouseButton1Click:Connect(function()
		for _,p in pairs(pages) do p.Visible=false end
		pages[name].Visible=true
		title.Text = "Threeblox V3 | "..name
	end)
end

for _,n in ipairs(pageNames) do
	sideBtn(n)
end

--================ AUTO OPTION CONTENT =================--
local auto = pages["Auto Option"]

local list = Instance.new("UIListLayout", auto)
list.Padding = UDim.new(0,10)
Instance.new("UIPadding", auto).PaddingTop = UDim.new(0,16)
Instance.new("UIPadding", auto).PaddingLeft = UDim.new(0,16)

local function autoItem(icon, text)
	local f = Instance.new("Frame", auto)
	f.Size = UDim2.new(1,-32,0,42)
	f.BackgroundColor3 = CARD
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

	local ic = Instance.new("TextLabel", f)
	ic.Size = UDim2.new(0,32,1,0)
	ic.Position = UDim2.new(0,10,0,0)
	ic.BackgroundTransparency = 1
	ic.Font = Enum.Font.GothamBold
	ic.TextSize = 18
	ic.TextColor3 = ACCENT
	ic.Text = icon

	local t = Instance.new("TextLabel", f)
	t.Text = text
	t.Font = Enum.Font.Gotham
	t.TextSize = 15
	t.TextColor3 = TEXT
	t.BackgroundTransparency = 1
	t.Position = UDim2.new(0,48,0,0)
	t.Size = UDim2.new(1,-80,1,0)
	t.TextXAlignment = Enum.TextXAlignment.Left

	local arrow = Instance.new("TextLabel", f)
	arrow.Text = "›"
	arrow.Font = Enum.Font.GothamBold
	arrow.TextSize = 22
	arrow.TextColor3 = MUTED
	arrow.BackgroundTransparency = 1
	arrow.Size = UDim2.new(0,24,1,0)
	arrow.Position = UDim2.new(1,-28,0,0)
end

autoItem("🎣","Auto Fishing")
autoItem("🧠","Legit Perfect")
autoItem("🔥","Blatant Fishing")
autoItem("🏝️","Auto Farm Island")
autoItem("⭐","Auto Favorite")
autoItem("💰","Auto Sell")
autoItem("🗿","Auto Totem")
autoItem("🧪","Auto Potion")

pages["Auto Option"].Visible = true

--================ ACTIONS =================--
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
