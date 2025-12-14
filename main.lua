--// THREEBLOX HUB - FISH IT
--// UPDATE 2 FULL GUI
--// READY FOR REMOTE (NO DUMMY CONTENT)
--// ANDROID + PC SAFE

--================ SERVICES ================--
local Players = game:GetService("Players")
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

--================ CONFIG ================--
local LOGO_ID = "rbxassetid://121625492591707"
local ACCENT  = Color3.fromRGB(170, 90, 255)
local BG      = Color3.fromRGB(18,20,30)
local SIDE    = Color3.fromRGB(14,16,24)
local CARD    = Color3.fromRGB(30,32,44)
local TEXT    = Color3.fromRGB(235,235,235)

--================ ROOT GUI ================--
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxHub"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = pg

--================ MINI LOGO (MINIMIZE MODE) ================--
local miniLogo = Instance.new("ImageButton", gui)
miniLogo.Size = UDim2.new(0, 56, 0, 56)
miniLogo.Position = UDim2.new(0, 20, 0.5, -28)
miniLogo.BackgroundColor3 = BG
miniLogo.Image = LOGO_ID
miniLogo.Visible = false
miniLogo.BorderSizePixel = 0
miniLogo.ZIndex = 999
miniLogo.Active = true
miniLogo.AutoButtonColor = false
miniLogo.Draggable = true
Instance.new("UICorner", miniLogo).CornerRadius = UDim.new(1,0)

--================ MAIN WINDOW ================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 760, 0, 440)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--================ HEADER ================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -140, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = TEXT
title.Text = "Threeblox V3 | Information"

-- MINIMIZE
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -70, 0.5, -14)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.TextColor3 = Color3.fromRGB(0,0,0)
minBtn.BackgroundColor3 = ACCENT
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0.5, -14)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

--================ SIDEBAR ================--
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0, 0, 0, 44)
sidebar.Size = UDim2.new(0, 180, 1, -44)
sidebar.BackgroundColor3 = SIDE
sidebar.BorderSizePixel = 0

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0, 6)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local sidePad = Instance.new("UIPadding", sidebar)
sidePad.PaddingTop = UDim.new(0, 10)

--================ CONTENT ================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 180, 0, 44)
content.Size = UDim2.new(1, -180, 1, -44)
content.BackgroundTransparency = 1

--================ PAGE SYSTEM ================--
local pages = {}

local function createPage(name)
	local p = Instance.new("Frame", content)
	p.Size = UDim2.new(1,0,1,0)
	p.Visible = false
	p.BackgroundTransparency = 1
	pages[name] = p
	return p
end

-- PAGES (READY FOR REMOTE)
createPage("Information")
local autoPage     = createPage("Auto Option")
createPage("Teleport")
createPage("Quest")
createPage("Shop & Trade")
createPage("Misc")

--================ AUTO OPTION CONTENT =================
local ICONS = {
	AutoFishing = "rbxassetid://6034509993",
	Legit       = "rbxassetid://6031068433",
	Blatant     = "rbxassetid://6034287525",
	Farm        = "rbxassetid://6034328955",
	Favorite    = "rbxassetid://6031265976",
	Sell        = "rbxassetid://6034509983",
	Totem       = "rbxassetid://6035047377",
	Potion      = "rbxassetid://6034328940",
}

local function createAutoItem(text, iconId, y)
	local item = Instance.new("TextButton", autoPage)
	item.Size = UDim2.new(1, -40, 0, 44)
	item.Position = UDim2.new(0, 20, 0, y)
	item.BackgroundColor3 = CARD
	item.BorderSizePixel = 0
	item.Text = ""
	item.AutoButtonColor = false
	Instance.new("UICorner", item).CornerRadius = UDim.new(0, 10)

	local icon = Instance.new("ImageLabel", item)
	icon.Size = UDim2.new(0, 22, 0, 22)
	icon.Position = UDim2.new(0, 14, 0.5, -11)
	icon.BackgroundTransparency = 1
	icon.Image = iconId
	icon.ImageColor3 = TEXT

	local label = Instance.new("TextLabel", item)
	label.Size = UDim2.new(1, -90, 1, 0)
	label.Position = UDim2.new(0, 44, 0, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 15
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextColor3 = TEXT
	label.Text = text

	local arrow = Instance.new("TextLabel", item)
	arrow.Size = UDim2.new(0, 40, 1, 0)
	arrow.Position = UDim2.new(1, -40, 0, 0)
	arrow.BackgroundTransparency = 1
	arrow.Font = Enum.Font.GothamBold
	arrow.TextSize = 20
	arrow.TextColor3 = TEXT
	arrow.Text = ">"

	-- LOGIC LU MASUK SINI NANTI
	item.MouseButton1Click:Connect(function()
		-- taruh remote / function lu di sini
	end)
end

createAutoItem("Auto Fishing", ICONS.AutoFishing, 10)
createAutoItem("Legit Perfect", ICONS.Legit, 60)
createAutoItem("Blatant Fishing", ICONS.Blatant, 110)
createAutoItem("Auto Farm Island", ICONS.Farm, 160)
createAutoItem("Auto Favorite", ICONS.Favorite, 210)
createAutoItem("Auto Sell", ICONS.Sell, 260)
createAutoItem("Auto Totem", ICONS.Totem, 310)
createAutoItem("Auto Potion", ICONS.Potion, 360)

--================ SIDEBAR BUTTONS =================
local function sideButton(name)
	local b = Instance.new("TextButton", sidebar)
	b.Size = UDim2.new(1, -20, 0, 38)
	b.Text = "  "..name
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.TextColor3 = TEXT
	b.BackgroundColor3 = CARD
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

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

--================ BUTTON ACTIONS =================
minBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	miniLogo.Visible = true
end)

miniLogo.MouseButton1Click:Connect(function()
	main.Visible = true
	miniLogo.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
