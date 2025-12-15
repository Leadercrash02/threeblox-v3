-- ===== THREEBLOX V2 | GUI PATCH (V3 STYLE) =====
-- GUI ONLY | ENGINE & REMOTE TIDAK DISENTUH

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

-- CLEAN OLD
pcall(function()
	for _,v in ipairs(pg:GetChildren()) do
		if v.Name == "ThreebloxV2_GUI" then
			v:Destroy()
		end
	end
end)

-- CONFIG
local LOGO_ID = "rbxassetid://121625492591707"

local C = {
	BG     = Color3.fromRGB(18,20,28),
	SIDE   = Color3.fromRGB(22,24,34),
	CARD   = Color3.fromRGB(28,30,42),
	TEXT   = Color3.fromRGB(235,235,235),
	ACCENT = Color3.fromRGB(170,80,255),
	RED    = Color3.fromRGB(200,60,60),
}

-- ROOT
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV2_GUI"
gui.ResetOnSpawn = false

-- MINI LOGO
local mini = Instance.new("ImageButton", gui)
mini.Size = UDim2.new(0,56,0,56)
mini.Position = UDim2.new(0,20,1,-80)
mini.Image = LOGO_ID
mini.Visible = false
mini.BackgroundColor3 = C.BG
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,900,0,520)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = C.BG
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,50)
header.BackgroundTransparency = 1
header.Active = true

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-120,1,0)
title.Position = UDim2.new(0,16,0,0)
title.BackgroundTransparency = 1
title.Text = "Threeblox V2"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = C.TEXT
title.TextXAlignment = Left

-- DRAG
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
minBtn.BackgroundColor3 = C.ACCENT
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-36,0.5,-15)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = C.RED
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,50)
sidebar.Size = UDim2.new(0,220,1,-50)
sidebar.BackgroundColor3 = C.SIDE

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,8)
sideLayout.HorizontalAlignment = Center
Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,12)

local function tab(txt, page)
	local b = Instance.new("TextButton", sidebar)
	b.Size = UDim2.new(1,-20,0,38)
	b.Text = txt
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = C.TEXT
	b.BackgroundColor3 = C.CARD
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(function()
		for _,p in pairs(page.Parent:GetChildren()) do
			if p:IsA("ScrollingFrame") then p.Visible=false end
		end
		page.Visible=true
	end)
end

-- CONTENT HOLDER (PAKAI PAGE V2 YANG SUDAH ADA)
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,220,0,50)
content.Size = UDim2.new(1,-220,1,-50)
content.BackgroundTransparency = 1

-- CATATAN:
-- pageFishing, pageBackpack, pageTeleport, pageQuest, pageBoat, pageMisc
-- SUDAH ADA DARI V2 LU → TINGGAL PARENT-IN KE content

pageFishing.Parent  = content
pageBackpack.Parent = content
pageTeleport.Parent = content
pageQuest.Parent    = content
pageBoat.Parent     = content
pageMisc.Parent     = content

-- TAB
tab("ℹ Information", pageFishing)
tab("⚙ Auto Option", pageFishing)
tab("➜ Teleport", pageTeleport)
tab("★ Quest", pageQuest)
tab("🛒 Shop & Trade", pageBackpack)
tab("⚡ Misc", pageMisc)

pageFishing.Visible = true

-- ACTION
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
