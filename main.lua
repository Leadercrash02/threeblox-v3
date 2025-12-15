-- =====================================
-- THREEBLOX GUI TEST FIX (CLICK SAFE)
-- =====================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

-- HAPUS GUI LAMA
pcall(function()
	for _,v in ipairs(pg:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name == "Threeblox_Test" then
			v:Destroy()
		end
	end
end)

-- ================= SCREEN GUI =================
local gui = Instance.new("ScreenGui")
gui.Name = "Threeblox_Test"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = pg

-- ================= MAIN =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,700,0,420)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(18,20,28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- ================= HEADER =================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,42)
header.BackgroundTransparency = 1
header.Active = true

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-120,1,0)
title.Position = UDim2.new(0,16,0,0)
title.BackgroundTransparency = 1
title.Text = "Threeblox GUI (CLICK FIX)"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(235,235,235)

-- CLOSE
local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-36,0.5,-15)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(200,60,60)
close.Active = true
close.ZIndex = 10
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- ================= SIDEBAR =================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,42)
sidebar.Size = UDim2.new(0,200,1,-42)
sidebar.BackgroundColor3 = Color3.fromRGB(22,24,34)
sidebar.BorderSizePixel = 0
sidebar.Active = false -- PENTING
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,16)

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,6)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,10)

-- ================= CONTENT =================
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,200,0,42)
content.Size = UDim2.new(1,-200,1,-42)
content.BackgroundTransparency = 1
content.Active = false

-- ================= PAGE =================
local page = Instance.new("Frame", content)
page.Size = UDim2.new(1,0,1,0)
page.BackgroundTransparency = 1
page.Active = false

-- CLEAR PAGE
local function ClearPage()
	for _,v in ipairs(page:GetChildren()) do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end
end

-- ================= TELEPORT BUTTON =================
local function CreateTeleportButton(text, y, cf)
	local btn = Instance.new("TextButton", page)
	btn.Size = UDim2.new(1,-40,0,36)
	btn.Position = UDim2.new(0,20,0,y)
	btn.Text = text
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(235,235,235)
	btn.BackgroundColor3 = Color3.fromRGB(28,30,42)
	btn.BackgroundTransparency = 0.15
	btn.AutoButtonColor = true
	btn.Active = true
	btn.ZIndex = 5
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	btn.MouseButton1Click:Connect(function()
		local char = lp.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = cf
		end
	end)
end

-- ================= PAGE TELEPORT =================
local function ShowTeleport()
	ClearPage()

	local label = Instance.new("TextLabel", page)
	label.Size = UDim2.new(1,-40,0,30)
	label.Position = UDim2.new(0,20,0,10)
	label.Text = "➜ Teleport"
	label.Font = Enum.Font.GothamBold
	label.TextSize = 16
	label.TextColor3 = Color3.fromRGB(235,235,235)
	label.BackgroundTransparency = 1
	label.ZIndex = 3

	CreateTeleportButton("Spawn", 50, CFrame.new(0,10,0))
	CreateTeleportButton("Test Island", 92, CFrame.new(120,10,120))
end

-- ================= SIDEBAR BUTTON =================
local function SideButton(text, callback)
	local b = Instance.new("TextButton", sidebar)
	b.Size = UDim2.new(1,-20,0,36)
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = Color3.fromRGB(235,235,235)
	b.BackgroundColor3 = Color3.fromRGB(30,32,44)
	b.BackgroundTransparency = 0.1
	b.Active = true
	b.ZIndex = 5
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)

	b.MouseButton1Click:Connect(callback)
end

SideButton("➜ Teleport", ShowTeleport)

-- DEFAULT
ShowTeleport()

print("Threeblox GUI loaded | CLICK FIX OK")
