--// THREEBLOX HUB - FISH IT
--// FULL FINAL SCRIPT | DRAG LOGO | PC + ANDROID SAFE

--================ SERVICES ================--
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ CLEAN OLD GUI ================--
pcall(function()
	for _,v in ipairs(pg:GetChildren()) do
		if v.Name:find("Threeblox") then
			v:Destroy()
		end
	end
end)

--================ CONFIG ================--
local LOGO_ID = "rbxassetid://121625492591707"
local ACCENT  = Color3.fromRGB(170, 90, 255)
local DARK    = Color3.fromRGB(18, 20, 30)

--================ ROOT GUI ================--
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxHub"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = pg

--================ MINI LOGO (MINIMIZE MODE) ================--
local miniLogo = Instance.new("ImageButton", gui)
miniLogo.Size = UDim2.new(0, 54, 0, 54)
miniLogo.Position = UDim2.new(0, 16, 1, -80)
miniLogo.BackgroundColor3 = DARK
miniLogo.Image = LOGO_ID
miniLogo.Visible = false
miniLogo.BorderSizePixel = 0
miniLogo.ZIndex = 100
miniLogo.Active = true
Instance.new("UICorner", miniLogo).CornerRadius = UDim.new(1,0)

--================ MAIN WINDOW ================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 720, 0, 420)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = DARK
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

--================ HEADER ================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundTransparency = 1
header.Active = true

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -120, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "Threeblox V3 | Fish It"

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

--================ SIDEBAR ================--
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0, 0, 0, 42)
sidebar.Size = UDim2.new(0, 150, 1, -42)
sidebar.BackgroundColor3 = Color3.fromRGB(14,16,24)
sidebar.BorderSizePixel = 0

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0, 6)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0, 10)

--================ CONTENT ================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 150, 0, 42)
content.Size = UDim2.new(1, -150, 1, -42)
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
	"Misc",
	"Event",
	"Quest",
	"Shop & Trade"
}

for _,name in ipairs(tabs) do
	createPage(name)

	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, -20, 0, 34)
	btn.Text = name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 13
	btn.TextColor3 = Color3.fromRGB(220,220,220)
	btn.BackgroundColor3 = Color3.fromRGB(28,30,40)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

	btn.MouseButton1Click:Connect(function()
		for n,p in pairs(pages) do
			p.Visible = (n == name)
		end
		for _,b in ipairs(sidebar:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Color3.fromRGB(28,30,40)
				b.TextColor3 = Color3.fromRGB(220,220,220)
			end
		end
		btn.BackgroundColor3 = ACCENT
		btn.TextColor3 = Color3.fromRGB(0,0,0)
		title.Text = "Threeblox V3 | "..name
	end)
end

pages["Information"].Visible = true

--================ DRAG MAIN WINDOW ================--
do
	local dragging, dragStart, startPos
	header.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = i.Position
			startPos = main.Position
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
		or i.UserInputType == Enum.UserInputType.Touch) then
			local delta = i.Position - dragStart
			main.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

--================ DRAG MINI LOGO ================--
do
	local dragging, dragStart, startPos
	miniLogo.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = i.Position
			startPos = miniLogo.Position
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
		or i.UserInputType == Enum.UserInputType.Touch) then
			local delta = i.Position - dragStart
			miniLogo.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

--================ BUTTON ACTION ================--
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
