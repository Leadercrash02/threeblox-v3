--====================================================
-- THREEBLOX V3 | GUI CORE (ENGINE READY)
-- SAFE GUI ONLY - NO REMOTE / NO AUTO EXEC
--====================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

pcall(function()
	if pg:FindFirstChild("ThreebloxV3") then
		pg.ThreebloxV3:Destroy()
	end
end)

--================ CONFIG ================--
local LOGO_ID = "rbxassetid://121625492591707"

local C = {
	BG     = Color3.fromRGB(18,20,28),
	SIDE   = Color3.fromRGB(22,24,34),
	CARD   = Color3.fromRGB(28,30,42),
	TEXT   = Color3.fromRGB(235,235,235),
	MUTED  = Color3.fromRGB(150,150,150),
	ACCENT = Color3.fromRGB(170,80,255),
	RED    = Color3.fromRGB(200,60,60),
}

--================ FLAGS (ENGINE HOOK) ================--
_G.TB_AutoFishing   = false
_G.TB_BlatantFishing= false
_G.TB_AutoSell      = false
_G.TB_AutoPotion   = false

_G.TB_DelayCast     = 0.9
_G.TB_DelayFinish   = 0.2

--================ GUI ROOT ================--
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3"
gui.ResetOnSpawn = false

--================ MAIN ================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,880,0,500)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = C.BG
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--================ HEADER ================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,46)
header.BackgroundTransparency = 1
header.Active = true

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-120,1,0)
title.Position = UDim2.new(0,52,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = C.TEXT
title.Text = "Threeblox V3 | Auto Option"

local logo = Instance.new("ImageLabel", header)
logo.Size = UDim2.new(0,28,0,28)
logo.Position = UDim2.new(0,14,0.5,-14)
logo.BackgroundTransparency = 1
logo.Image = LOGO_ID

-- drag
do
	local d,s,p
	header.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
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

-- close
local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0,28,0,28)
close.Position = UDim2.new(1,-36,0.5,-14)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.TextColor3 = C.TEXT
close.BackgroundColor3 = C.RED
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

--================ SIDEBAR ================--
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,46)
sidebar.Size = UDim2.new(0,210,1,-46)
sidebar.BackgroundColor3 = C.SIDE
sidebar.BorderSizePixel = 0

local sl = Instance.new("UIListLayout", sidebar)
sl.Padding = UDim.new(0,8)
sl.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,14)

--================ CONTENT ================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,210,0,46)
content.Size = UDim2.new(1,-210,1,-46)
content.BackgroundTransparency = 1

local pages = {}
local function NewPage(name)
	local p = Instance.new("ScrollingFrame", content)
	p.Size = UDim2.new(1,0,1,0)
	p.CanvasSize = UDim2.new(0,0,0,0)
	p.ScrollBarImageTransparency = 1
	p.Visible = false
	p.BackgroundTransparency = 1
	local l = Instance.new("UIListLayout", p)
	l.Padding = UDim.new(0,10)
	l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		p.CanvasSize = UDim2.new(0,0,0,l.AbsoluteContentSize.Y+20)
	end)
	Instance.new("UIPadding", p).PaddingTop = UDim.new(0,16)
	Instance.new("UIPadding", p).PaddingLeft = UDim.new(0,16)
	pages[name]=p
	return p
end

local function ShowPage(n)
	for _,p in pairs(pages) do p.Visible=false end
	pages[n].Visible=true
	title.Text="Threeblox V3 | "..n
end

local function SideBtn(name,icon)
	local b = Instance.new("TextButton", sidebar)
	b.Size = UDim2.new(1,-20,0,36)
	b.Text = icon.."  "..name
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = C.TEXT
	b.BackgroundColor3 = C.CARD
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(function()
		ShowPage(name)
	end)
end

-- pages
local auto = NewPage("Auto Option")
NewPage("Teleport")
NewPage("Quest")
NewPage("Shop & Trade")
NewPage("Misc")

SideBtn("Auto Option","⚙")
SideBtn("Teleport","➜")
SideBtn("Quest","★")
SideBtn("Shop & Trade","🛒")
SideBtn("Misc","⚡")

--================ UI COMPONENT ================--
local function Toggle(parent,text,flag)
	local f = Instance.new("Frame", parent)
	f.Size = UDim2.new(1,0,0,40)
	f.BackgroundColor3 = C.CARD
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

	local t = Instance.new("TextLabel", f)
	t.Size = UDim2.new(1,-70,1,0)
	t.Position = UDim2.new(0,12,0,0)
	t.BackgroundTransparency = 1
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.TextColor3 = C.TEXT
	t.Font = Enum.Font.Gotham
	t.TextSize = 14
	t.Text = text

	local b = Instance.new("TextButton", f)
	b.Size = UDim2.new(0,40,0,20)
	b.Position = UDim2.new(1,-52,0.5,-10)
	b.BackgroundColor3 = Color3.fromRGB(70,70,90)
	b.Text=""
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)

	local on=false
	b.MouseButton1Click:Connect(function()
		on=not on
		_G[flag]=on
		b.BackgroundColor3 = on and C.ACCENT or Color3.fromRGB(70,70,90)
	end)
end

local function Delay(parent,text,def,flag)
	local f = Instance.new("Frame", parent)
	f.Size = UDim2.new(1,0,0,36)
	f.BackgroundColor3 = C.CARD
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

	local t = Instance.new("TextLabel", f)
	t.Size = UDim2.new(0.6,0,1,0)
	t.Position = UDim2.new(0,12,0,0)
	t.BackgroundTransparency = 1
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.TextColor3 = C.TEXT
	t.Font = Enum.Font.Gotham
	t.TextSize = 13
	t.Text = text

	local box = Instance.new("TextBox", f)
	box.Size = UDim2.new(0.3,0,0,22)
	box.Position = UDim2.new(0.65,0,0.5,-11)
	box.BackgroundColor3 = Color3.fromRGB(14,16,26)
	box.TextColor3 = C.TEXT
	box.Text = tostring(def)
	Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)

	box.FocusLost:Connect(function()
		local v=tonumber(box.Text)
		if v then _G[flag]=v end
	end)
end

--================ AUTO OPTION CONTENT ================--
Toggle(auto,"⚙ Auto Fishing (Legit)","TB_AutoFishing")
Delay(auto,"Cast Delay (s)",0.9,"TB_DelayCast")
Delay(auto,"Finish Delay (s)",0.2,"TB_DelayFinish")

Toggle(auto,"🔥 Blatant Fishing","TB_BlatantFishing")
Toggle(auto,"💰 Auto Sell","TB_AutoSell")
Toggle(auto,"🧪 Auto Potion","TB_AutoPotion")

ShowPage("Auto Option")
