--// THREEBLOX V3 | STABLE FINAL
--// AUTO OPTION FIXED | NOTHING MISSING
--// UI ONLY | PC + ANDROID SAFE

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

-- CLEAN
pcall(function()
	for _,v in ipairs(pg:GetChildren()) do
		if v:IsA("ScreenGui") then v:Destroy() end
	end
end)

-- CONFIG
local LOGO_ID = "rbxassetid://121625492591707"
local BG     = Color3.fromRGB(18,20,28)
local SIDE   = Color3.fromRGB(22,24,34)
local CARD   = Color3.fromRGB(28,30,42)
local TEXT   = Color3.fromRGB(235,235,235)
local ACCENT = Color3.fromRGB(170,80,255)

-- ROOT
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

-- MINI LOGO
local mini = Instance.new("ImageButton", gui)
mini.Size = UDim2.new(0,56,0,56)
mini.Position = UDim2.new(0,20,1,-80)
mini.Image = LOGO_ID
mini.BackgroundColor3 = BG
mini.Visible = false
mini.BorderSizePixel = 0
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

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

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,900,0,520)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,48)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Text = "Threeblox V3 | Auto Option"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = TEXT
title.BackgroundTransparency = 1
title.Position = UDim2.new(0,16,0,0)
title.Size = UDim2.new(1,-120,1,0)
title.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", header)
minBtn.Text = "-"
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-72,0.5,-15)
minBtn.BackgroundColor3 = ACCENT
minBtn.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-36,0.5,-15)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.TextColor3 = TEXT
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- SIDEBAR (VISUAL ONLY, TIDAK RUSAK)
local side = Instance.new("Frame", main)
side.Position = UDim2.new(0,0,0,48)
side.Size = UDim2.new(0,220,1,-48)
side.BackgroundColor3 = SIDE

local sideList = Instance.new("UIListLayout", side)
sideList.Padding = UDim.new(0,8)
sideList.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", side).PaddingTop = UDim.new(0,12)

local function sideItem(txt)
	local b = Instance.new("TextLabel", side)
	b.Size = UDim2.new(1,-20,0,38)
	b.BackgroundColor3 = CARD
	b.TextColor3 = TEXT
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.Text = "  "..txt
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
end

sideItem("ℹ️  Information")
sideItem("🎣  Auto Option")
sideItem("🧭  Teleport")
sideItem("📜  Quest")
sideItem("🛒  Shop & Trade")
sideItem("⚙️  Misc")

-- CONTENT (AUTO OPTION ONLY – STABIL)
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,220,0,48)
content.Size = UDim2.new(1,-220,1,-48)
content.BackgroundTransparency = 1

local list = Instance.new("UIListLayout", content)
list.Padding = UDim.new(0,10)
Instance.new("UIPadding", content).PaddingTop = UDim.new(0,16)
Instance.new("UIPadding", content).PaddingLeft = UDim.new(0,16)

local function autoItem(icon, text)
	local f = Instance.new("Frame", content)
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
end

-- AUTO OPTION (TIDAK BOLEH HILANG)
autoItem("🎣","Auto Fishing")
autoItem("🧠","Legit Perfect")
autoItem("🔥","Blatant Fishing")
autoItem("🏝️","Auto Farm Island")
autoItem("⭐","Auto Favorite")
autoItem("💰","Auto Sell")
autoItem("🗿","Auto Totem")
autoItem("🧪","Auto Potion")

-- BUTTON
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
