--========================================
-- THREEBLOX V2 | AUTO FISH FULL WORKING
-- GUI SIMPLE + ENGINE V2
--========================================

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

-- CLEAN OLD GUI
pcall(function()
	for _,v in ipairs(pg:GetChildren()) do
		if v:IsA("ScreenGui") and v.Name:find("Threeblox") then
			v:Destroy()
		end
	end
end)

--========================================
-- REMOTE (PUNYA LU)
--========================================
local Net = ReplicatedStorage
	:WaitForChild("Packages")
	:WaitForChild("_Index")
	:WaitForChild("sleitnick_net@0.2.0")
	:WaitForChild("net")

local Events = {
	fishing  = Net:WaitForChild("RE/FishingCompleted"),
	charge   = Net:WaitForChild("RF/ChargeFishingRod"),
	minigame = Net:WaitForChild("RF/RequestFishingMinigameStarted"),
	equip    = Net:WaitForChild("RE/EquipToolFromHotbar"),
}

--========================================
-- GLOBAL FLAG + DELAY (SAMA KAYAK V2 LU)
--========================================
_G.TB_AutoFish = false
_G.TB_BlatantFish = false

_G.TB_DelayCast = 0.9
_G.TB_DelayFinish = 0.2

--========================================
-- AUTO FISH ENGINE
--========================================
local isFishing = false

local function LegitCycle()
	if isFishing then return end
	isFishing = true

	pcall(function()
		Events.equip:FireServer(1)
		task.wait(0.05)
		Events.charge:InvokeServer(1755848498.4834)
		task.wait(0.02)
		Events.minigame:InvokeServer(1.2854545116425, 1)
	end)

	task.wait(_G.TB_DelayCast)

	pcall(function()
		Events.fishing:FireServer()
	end)

	task.wait(_G.TB_DelayFinish)
	isFishing = false
end

local function BlatantCycle()
	if isFishing then return end
	isFishing = true

	pcall(function()
		Events.equip:FireServer(1)
		task.wait(0.01)

		for _ = 1,3 do
			task.spawn(function()
				Events.charge:InvokeServer(1755848498.4834)
				task.wait(0.01)
				Events.minigame:InvokeServer(1.2854545116425, 1)
			end)
			task.wait(0.03)
		end
	end)

	task.wait(_G.TB_DelayCast)

	for _ = 1,5 do
		pcall(function()
			Events.fishing:FireServer()
		end)
		task.wait(0.01)
	end

	task.wait(_G.TB_DelayFinish)
	isFishing = false
end

task.spawn(function()
	while task.wait(0.05) do
		if _G.TB_BlatantFish then
			BlatantCycle()
		elseif _G.TB_AutoFish then
			LegitCycle()
		end
	end
end)

--========================================
-- GUI
--========================================
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV2"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,360,0,260)
main.Position = UDim2.new(0.5,-180,0.5,-130)
main.BackgroundColor3 = Color3.fromRGB(18,20,28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- HEADER
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,36)
title.BackgroundTransparency = 1
title.Text = "Threeblox V2 | Auto Option"
title.TextColor3 = Color3.fromRGB(235,235,235)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- CONTENT
local function makeToggle(text, y, callback)
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(1,-40,0,32)
	btn.Position = UDim2.new(0,20,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(28,30,42)
	btn.TextColor3 = Color3.fromRGB(235,235,235)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = text .. " : OFF"
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = text .. (state and " : ON" or " : OFF")
		callback(state)
	end)
end

makeToggle("⚙ Auto Fishing", 50, function(v)
	_G.TB_AutoFish = v
end)

makeToggle("🔥 Blatant Fishing", 90, function(v)
	_G.TB_BlatantFish = v
end)

-- DELAY BOX
local function makeBox(label, y, default, cb)
	local txt = Instance.new("TextLabel", main)
	txt.Position = UDim2.new(0,20,0,y)
	txt.Size = UDim2.new(0.5,-10,0,28)
	txt.BackgroundTransparency = 1
	txt.Text = label
	txt.TextColor3 = Color3.fromRGB(200,200,200)
	txt.Font = Enum.Font.Gotham
	txt.TextSize = 13

	local box = Instance.new("TextBox", main)
	box.Position = UDim2.new(0.5,10,0,y)
	box.Size = UDim2.new(0.5,-30,0,28)
	box.BackgroundColor3 = Color3.fromRGB(12,14,24)
	box.TextColor3 = Color3.fromRGB(235,235,235)
	box.Font = Enum.Font.Gotham
	box.TextSize = 13
	box.Text = tostring(default)
	Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)

	box.FocusLost:Connect(function()
		local n = tonumber(box.Text)
		if n then cb(n) end
	end)
end

makeBox("Cast Delay", 140, _G.TB_DelayCast, function(v)
	_G.TB_DelayCast = v
end)

makeBox("Finish Delay", 175, _G.TB_DelayFinish, function(v)
	_G.TB_DelayFinish = v
end)

print("[Threeblox V2] Loaded OK")
