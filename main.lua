--// THREEBLOX V3 | FULL PAGE SYSTEM FIX

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

pcall(function()
	for _,v in ipairs(pg:GetChildren()) do
		if v.Name:find("Threeblox") then v:Destroy() end
	end
end)

-- CONFIG
local LOGO_ID = "rbxassetid://121625492591707"
local BG = Color3.fromRGB(18,18,24)
local SIDE = Color3.fromRGB(22,22,30)
local CARD = Color3.fromRGB(30,30,40)
local TEXT = Color3.fromRGB(230,230,230)
local ACCENT = Color3.fromRGB(160,90,255)

-- GUI
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,820,0,460)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,46)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Text = "Threeblox V3"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = TEXT
title.BackgroundTransparency = 1
title.Position = UDim2.new(0,16,0,0)
title.Size = UDim2.new(1,-120,1,0)
title.TextXAlignment = Enum.TextXAlignment.Left

-- MIN / CLOSE
local min = Instance.new("TextButton", header)
min.Text = "-"
min.Size = UDim2.new(0,28,0,28)
min.Position = UDim2.new(1,-72,0.5,-14)
min.BackgroundColor3 = ACCENT
Instance.new("UICorner", min).CornerRadius = UDim.new(1,0)

local close = Instance.new("TextButton", header)
close.Text = "X"
close.Size = UDim2.new(0,28,0,28)
close.Position = UDim2.new(1,-36,0.5,-14)
close.BackgroundColor3 = Color3.fromRGB(200,60,60)
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

-- SIDEBAR
local side = Instance.new("Frame", main)
side.Position = UDim2.new(0,0,0,46)
side.Size = UDim2.new(0,200,1,-46)
side.BackgroundColor3 = SIDE

local sideLayout = Instance.new("UIListLayout", side)
sideLayout.Padding = UDim.new(0,8)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", side).PaddingTop = UDim.new(0,12)

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,200,0,46)
content.Size = UDim2.new(1,-200,1,-46)
content.BackgroundTransparency = 1

-- PAGES
local pages = {}

local function createPage(name)
	local p = Instance.new("Frame", content)
	p.Size = UDim2.new(1,0,1,0)
	p.BackgroundTransparency = 1
	p.Visible = false
	pages[name] = p

	local lbl = Instance.new("TextLabel", p)
	lbl.Text = name.." Page"
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 24
	lbl.TextColor3 = TEXT
	lbl.BackgroundTransparency = 1
	lbl.Position = UDim2.new(0,20,0,20)
	lbl.TextXAlignment = Enum.TextXAlignment.Left

	return p
end

createPage("Information")
local autoPage = createPage("Auto Option")
createPage("Teleport")
createPage("Quest")
createPage("Shop & Trade")
createPage("Misc")

-- AUTO OPTION ITEMS
local list = Instance.new("UIListLayout", autoPage)
list.Padding = UDim.new(0,10)
Instance.new("UIPadding", autoPage).PaddingTop = UDim.new(0,60)
Instance.new("UIPadding", autoPage).PaddingLeft = UDim.new(0,20)

local function autoItem(text)
	local f = Instance.new("Frame", autoPage)
	f.Size = UDim2.new(1,-40,0,44)
	f.BackgroundColor3 = CARD
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

	local t = Instance.new("TextLabel", f)
	t.Text = text
	t.Font = Enum.Font.Gotham
	t.TextSize = 15
	t.TextColor3 = TEXT
	t.BackgroundTransparency = 1
	t.Position = UDim2.new(0,16,0,0)
	t.Size = UDim2.new(1,-32,1,0)
	t.TextXAlignment = Enum.TextXAlignment.Left
end

autoItem("Auto Fishing")
autoItem("Legit Perfect")
autoItem("Blatant Fishing")
autoItem("Auto Sell")
autoItem("Auto Potion")

-- SIDEBAR BUTTON
local function sideBtn(name)
	local b = Instance.new("TextButton", side)
	b.Text = name
	b.Size = UDim2.new(1,-20,0,38)
	b.BackgroundColor3 = CARD
	b.TextColor3 = TEXT
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)

	b.MouseButton1Click:Connect(function()
		for n,p in pairs(pages) do
			p.Visible = (n == name)
		end
		title.Text = "Threeblox V3 | "..name
	end)
end

sideBtn("Information")
sideBtn("Auto Option")
sideBtn("Teleport")
sideBtn("Quest")
sideBtn("Shop & Trade")
sideBtn("Misc")

pages["Auto Option"].Visible = true

-- BUTTON ACTION
min.MouseButton1Click:Connect(function()
	main.Visible = false
end)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
