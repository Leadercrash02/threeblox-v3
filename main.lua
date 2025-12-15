--// THREEBLOX V3 | FIX FULL FINAL
--// UI V3 + Auto Fishing Engine (REMOTE V2)
--// FIX: Auto Option visible, Minimize OK, Close OK, Logo OK
--// ANDROID + PC SAFE

--================ SERVICES =================--
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ CLEAN =================--
pcall(function()
	for _,v in ipairs(pg:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name == "ThreebloxV3" then
			v:Destroy()
		end
	end
end)

--================ CONFIG =================--
local LOGO_ID = "rbxassetid://121625492591707"

local C = {
	BG     = Color3.fromRGB(18,20,28),
	SIDE   = Color3.fromRGB(22,24,34),
	CARD   = Color3.fromRGB(28,30,42),
	TEXT   = Color3.fromRGB(235,235,235),
	MUTED  = Color3.fromRGB(160,160,160),
	ACCENT = Color3.fromRGB(170,80,255),
	RED    = Color3.fromRGB(200,60,60),
}

local A = 0.08

--================ ROOT GUI =================--
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = pg

--================ MINI LOGO (MINIMIZE MODE) =================--
local mini = Instance.new("ImageButton")
mini.Parent = gui
mini.Size = UDim2.new(0,56,0,56)
mini.Position = UDim2.new(0,20,1,-80)
mini.Image = LOGO_ID
mini.BackgroundColor3 = C.BG
mini.BackgroundTransparency = A
mini.BorderSizePixel = 0
mini.Visible = false
mini.AutoButtonColor = false
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

-- drag mini
do
	local d,s,p
	mini.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
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

--================ MAIN WINDOW =================--
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,900,0,520)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = C.BG
main.BackgroundTransparency = A
main.BorderSizePixel = 0
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--================ HEADER =================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,50)
header.BackgroundTransparency = 1
header.Active = true

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-120,1,0)
title.Position = UDim2.new(0,16,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = C.TEXT
title.Text = "Threeblox V3 | Auto Option"

-- drag main
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
minBtn.BackgroundColor3 = C.ACCENT
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-36,0.5,-15)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = C.TEXT
closeBtn.BackgroundColor3 = C.RED
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

--================ SIDEBAR =================--
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,50)
sidebar.Size = UDim2.new(0,220,1,-50)
sidebar.BackgroundColor3 = C.SIDE
sidebar.BackgroundTransparency = A

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,8)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,12)

--================ CONTENT =================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,220,0,50)
content.Size = UDim2.new(1,-220,1,-50)
content.BackgroundTransparency = 1

--================ PAGE SYSTEM =================--
local pages = {}
local function newPage(name)
	local p = Instance.new("Frame", content)
	p.Size = UDim2.new(1,0,1,0)
	p.BackgroundTransparency = 1
	p.Visible = false
	pages[name] = p
	return p
end

local function showPage(name)
	for _,p in pairs(pages) do p.Visible = false end
	pages[name].Visible = true
	title.Text = "Threeblox V3 | "..name
end

local autoPage = newPage("Auto Option")
newPage("Information")
newPage("Teleport")
newPage("Quest")
newPage("Shop & Trade")
newPage("Misc")

local function sideBtn(name,icon)
	local b = Instance.new("TextButton", sidebar)
	b.Size = UDim2.new(1,-20,0,38)
	b.Text = icon.."  "..name
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = C.TEXT
	b.BackgroundColor3 = C.CARD
	b.BackgroundTransparency = A
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(function()
		showPage(name)
	end)
end

sideBtn("Information","ℹ")
sideBtn("Auto Option","⚙")
sideBtn("Teleport","➜")
sideBtn("Quest","★")
sideBtn("Shop & Trade","🛒")
sideBtn("Misc","⚡")

--================ AUTO OPTION CONTENT =================--
local holder = Instance.new("Frame", autoPage)
holder.Size = UDim2.new(1,0,1,0)
holder.BackgroundTransparency = 1

local list = Instance.new("UIListLayout", holder)
list.Padding = UDim.new(0,10)
Instance.new("UIPadding", holder).PaddingTop = UDim.new(0,16)
Instance.new("UIPadding", holder).PaddingLeft = UDim.new(0,16)
Instance.new("UIPadding", holder).PaddingRight = UDim.new(0,16)

--================ AUTO FISHING ENGINE (REMOTE V2) =================--
local Net = ReplicatedStorage.Packages.Index["sleitnick_net-0.2.0"].net
local Events = {
	fishing  = Net.RF.FishingCompleted,
	charge   = Net.RF.ChargeFishingRod,
	minigame = Net.RF.RequestFishingMinigameStarted,
	equip    = Net.RE.EquipToolFromHotbar,
}

_G.THREEBLOX_AutoFishing = false
local isFishing = false

local function AutoFishingEngine()
	if isFishing then return end
	isFishing = true
	pcall(function()
		Events.equip:FireServer(1)
		task.wait(0.02)
		Events.charge:InvokeServer(1755848498.4834)
		task.wait(0.01)
		Events.minigame:InvokeServer(1.2854545116425,1)
		task.wait(0.12)
		Events.fishing:FireServer()
	end)
	task.wait(0.25)
	isFishing = false
end

task.spawn(function()
	while task.wait(0.05) do
		if _G.THREEBLOX_AutoFishing then
			AutoFishingEngine()
		end
	end
end)

--================ AUTO ITEM =================--
local function autoItem(name,emoji,desc)
	local open=false
	local box = Instance.new("Frame", holder)
	box.Size = UDim2.new(1,0,0,42)
	box.BackgroundColor3 = C.CARD
	box.BackgroundTransparency = A
	Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)

	local btn = Instance.new("TextButton", box)
	btn.Size = UDim2.new(1,0,1,0)
	btn.Text = emoji.."  "..name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 15
	btn.TextColor3 = C.TEXT
	btn.BackgroundTransparency = 1
	btn.TextXAlignment = Enum.TextXAlignment.Left

	btn.MouseButton1Click:Connect(function()
		open = not open
		if name=="Auto Fishing" then
			_G.THREEBLOX_AutoFishing = open
		end
		box.Size = open and UDim2.new(1,0,0,100) or UDim2.new(1,0,0,42)
	end)

	local lbl = Instance.new("TextLabel", box)
	lbl.Position = UDim2.new(0,16,0,48)
	lbl.Size = UDim2.new(1,-32,0,40)
	lbl.BackgroundTransparency = 1
	lbl.TextWrapped = true
	lbl.Text = desc
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 14
	lbl.TextColor3 = C.MUTED
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextYAlignment = Enum.TextYAlignment.Top
end

autoItem("Auto Fishing","⚙","Auto fishing menggunakan remote stabil.")
autoItem("Legit Perfect","⭕","Kontrol legit fishing.")
autoItem("Blatant Fishing","🔥","Fishing agresif.")
autoItem("Auto Farm Island","✏","Farm island otomatis.")
autoItem("Auto Favorite","⭐","Favorite ikan otomatis.")
autoItem("Auto Sell","💰","Auto jual ikan.")
autoItem("Auto Totem","➕","Auto totem.")
autoItem("Auto Potion","🧪","Auto potion.")

--================ DEFAULT =================--
showPage("Auto Option")

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
