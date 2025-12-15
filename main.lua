-- =========================================================
-- THREEBLOX V2 (DEV MODE)
-- HWID + KEY DISABLED FOR GUI TESTING
-- ENGINE & REMOTE TETAP AKTIF
-- =========================================================

-- ================= SERVICES =================
local Players      = game:GetService("Players")
local HttpService  = game:GetService("HttpService")
local StarterGui   = game:GetService("StarterGui")
local Lighting     = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")
local VirtualUser  = game:GetService("VirtualUser")

local LP = Players.LocalPlayer

print("[DEV MODE] HWID & KEY CHECK DISABLED")

-- ================= NOTIFY =================
local function Notify(msg)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Threeblox V2",
			Text = msg,
			Duration = 3
		})
	end)
end

-- ================= ANTI AFK =================
LP.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

-- ================= CLEAN GUI =================
pcall(function()
	local old = LP.PlayerGui:FindFirstChild("RAYMOD_FISHIT_GUI")
	if old then old:Destroy() end
end)

-- ================= GUI ROOT =================
local gui = Instance.new("ScreenGui")
gui.Name = "RAYMOD_FISHIT_GUI"
gui.ResetOnSpawn = false
gui.Parent = LP:WaitForChild("PlayerGui")

-- ================= BLUR =================
local blur = Instance.new("BlurEffect")
blur.Parent = Lighting
blur.Size = 18

-- ================= MAIN =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 460, 0, 300)
main.Position = UDim2.new(0.5, -230, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(18,20,28)
main.BackgroundTransparency = 0.15
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- ================= HEADER =================
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,36)
top.BackgroundColor3 = Color3.fromRGB(22,24,34)
top.BackgroundTransparency = 0.1
top.BorderSizePixel = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,-100,1,0)
title.Position = UDim2.new(0,40,0,0)
title.BackgroundTransparency = 1
title.Text = "Threeblox V2"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(235,235,235)

local logo = Instance.new("ImageLabel", top)
logo.Size = UDim2.new(0,22,0,22)
logo.Position = UDim2.new(0,10,0.5,-11)
logo.Image = "rbxassetid://121625492591707"
logo.BackgroundTransparency = 1

-- ================= BUTTONS =================
local function TopBtn(txt, pos, color)
	local b = Instance.new("TextButton", top)
	b.Size = UDim2.new(0,26,0,22)
	b.Position = pos
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = color
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
	return b
end

local btnMin  = TopBtn("-", UDim2.new(1,-64,0.5,-11), Color3.fromRGB(120,120,180))
local btnClose= TopBtn("X", UDim2.new(1,-32,0.5,-11), Color3.fromRGB(200,70,80))

-- ================= CONTENT =================
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,0,0,36)
content.Size = UDim2.new(1,0,1,-36)
content.BackgroundTransparency = 1

-- ================= SIDEBAR =================
local sidebar = Instance.new("Frame", content)
sidebar.Size = UDim2.new(0,150,1,0)
sidebar.Position = UDim2.new(0,0,0,0)
sidebar.BackgroundColor3 = Color3.fromRGB(22,24,34)
sidebar.BackgroundTransparency = 0.15
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,10)

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,6)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function SideBtn(text)
	local b = Instance.new("TextButton", sidebar)
	b.Size = UDim2.new(1,-16,0,28)
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextSize = 13
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.TextColor3 = Color3.fromRGB(220,220,255)
	b.BackgroundColor3 = Color3.fromRGB(28,30,42)
	b.BackgroundTransparency = 0.2
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

local btnAuto  = SideBtn("⚙ Auto Option")
local btnTP    = SideBtn("➜ Teleport")
local btnQuest = SideBtn("★ Quest")
local btnMisc  = SideBtn("⚡ Misc")

-- ================= PAGE =================
local page = Instance.new("Frame", content)
page.Position = UDim2.new(0,150,0,0)
page.Size = UDim2.new(1,-150,1,0)
page.BackgroundTransparency = 1

local function ClearPage()
	for _,v in ipairs(page:GetChildren()) do
		if v:IsA("GuiObject") then v:Destroy() end
	end
end

-- ================= AUTO OPTION =================
local function AutoOptionPage()
	ClearPage()

	local lbl = Instance.new("TextLabel", page)
	lbl.Size = UDim2.new(1,-20,0,30)
	lbl.Position = UDim2.new(0,10,0,10)
	lbl.BackgroundTransparency = 1
	lbl.Text = "⚙ Auto Fishing Options"
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 16
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextColor3 = Color3.fromRGB(235,235,235)

	local function Item(text,y)
		local f = Instance.new("Frame", page)
		f.Size = UDim2.new(1,-20,0,36)
		f.Position = UDim2.new(0,10,0,y)
		f.BackgroundColor3 = Color3.fromRGB(28,30,42)
		f.BackgroundTransparency = 0.2
		Instance.new("UICorner", f).CornerRadius = UDim.new(0,8)

		local t = Instance.new("TextLabel", f)
		t.Size = UDim2.new(1,-20,1,0)
		t.Position = UDim2.new(0,10,0,0)
		t.BackgroundTransparency = 1
		t.Text = text
		t.Font = Enum.Font.Gotham
		t.TextSize = 13
		t.TextXAlignment = Enum.TextXAlignment.Left
		t.TextColor3 = Color3.fromRGB(220,220,255)
	end

	Item("🎣 Auto Fishing", 50)
	Item("🔥 Blatant Fishing", 92)
	Item("💰 Auto Sell", 134)
	Item("🧪 Auto Potion", 176)
end

-- ================= BUTTON LOGIC =================
btnAuto.MouseButton1Click:Connect(AutoOptionPage)

btnClose.MouseButton1Click:Connect(function()
	blur:Destroy()
	gui:Destroy()
end)

local minimized = false
btnMin.MouseButton1Click:Connect(function()
	minimized = not minimized
	main.Visible = not minimized
end)

-- ================= DEFAULT =================
AutoOptionPage()
Notify("Threeblox V2 GUI loaded (DEV MODE)")

print("[Threeblox V2] GUI TEST READY")
