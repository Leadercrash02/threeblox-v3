--// THREEBLOX HUB - FISH IT
--// FULL GUI FINAL | NO FEATURE LOST | DRAG LOGO STABLE
--// PC + ANDROID (DELTA / XENO SAFE)

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
local BTN     = Color3.fromRGB(28,30,40)

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
miniLogo.Draggable = true -- 🔥 STABIL DI ANDROID
Instance.new("UICorner", miniLogo).CornerRadius = UDim.new(1,0)

--================ MAIN WINDOW ================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 760, 0, 430)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true -- WINDOW DRAG
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
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "Threeblox V3 | Fish It"

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

local sidePad = Instance.new("UIPadding", sidebar)
sidePad.PaddingTop = UDim.new(0, 10)

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0, 6)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--================ CONTENT ================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 180, 0, 44)
content.Size = UDim2.new(1, -180, 1, -44)
content.BackgroundTransparency = 1
Instance.new("UIPadding", content).PaddingTop = UDim.new(0, 12)

--================ PAGE SYSTEM ================--
local pages = {}

local function createPage(name)
	local p = Instance.new("Frame", content)
	p.Size = UDim2.new(1,0,1,0)
	p.Visible = false
	p.BackgroundTransparency = 1
	pages[name] = p

	local lbl = Instance.new("TextLabel", p)
	lbl.Size = UDim2.new(1, -20, 0, 30)
	lbl.Position = UDim2.new(0, 10, 0, 10)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 22
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextColor3 = Color3.fromRGB(255,255,255)
	lbl.Text = name
end

local tabs = {
	"Information",
	"Auto Option",
	"Teleport",
	"Quest",
	"Shop & Trade",
	"Misc"
}

local activeBtn
for _,name in ipairs(tabs) do
	createPage(name)

	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, -20, 0, 38)
	btn.Text = "  "..name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.TextColor3 = Color3.fromRGB(220,220,220)
	btn.BackgroundColor3 = BTN
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

	btn.MouseButton1Click:Connect(function()
		if activeBtn then
			activeBtn.BackgroundColor3 = BTN
			activeBtn.TextColor3 = Color3.fromRGB(220,220,220)
		end
		activeBtn = btn
		btn.BackgroundColor3 = ACCENT
		btn.TextColor3 = Color3.fromRGB(0,0,0)

		for n,p in pairs(pages) do
			p.Visible = (n == name)
		end
		title.Text = "Threeblox V3 | "..name
	end)

	if name == "Information" then
		activeBtn = btn
		btn.BackgroundColor3 = ACCENT
		btn.TextColor3 = Color3.fromRGB(0,0,0)
	end
end

pages["Information"].Visible = true

--================ BUTTON ACTIONS ================--
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
