--====================================================
-- THREEBLOX V3 | GUI + ENGINE FULL (LEGIT + BLATANT)
-- NO HWID | NO KEY | TEST READY
--====================================================

--================ SERVICES =================--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ CLEAN GUI =================--
pcall(function()
    if pg:FindFirstChild("ThreebloxV3") then
        pg.ThreebloxV3:Destroy()
    end
end)

--================ GLOBAL FLAGS =================--
_G.TB_AutoFish_Legit   = false
_G.TB_AutoFish_Blatant = false

_G.TB_DelayCast_Legit   = 0.9
_G.TB_DelayFinish_Legit = 0.2

_G.TB_DelayCast_Blatant   = 0.9
_G.TB_DelayFinish_Blatant = 0.2

--================ REMOTE (V2 STYLE) =================--
local Net = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")

local Events = {
    fishing  = Net:WaitForChild("RE/FishingCompleted"),
    sell     = Net:WaitForChild("RF/SellAllItems"),
    charge   = Net:WaitForChild("RF/ChargeFishingRod"),
    minigame = Net:WaitForChild("RF/RequestFishingMinigameStarted"),
    equip    = Net:WaitForChild("RE/EquipToolFromHotbar"),
}

--====================================================
-- ENGINE SECTION (JANGAN CAMPUR GUI)
--====================================================

local isFishing = false

local function CastRod()
    pcall(function()
        Events.equip:FireServer(1)
        task.wait(0.05)
        Events.charge:InvokeServer(1755848498.4834)
        task.wait(0.02)
        Events.minigame:InvokeServer(1.2854545116425, 1)
    end)
end

local function ReelIn()
    pcall(function()
        Events.fishing:FireServer()
    end)
end

-- LEGIT ENGINE
task.spawn(function()
    while task.wait(0.05) do
        if _G.TB_AutoFish_Legit and not isFishing then
            isFishing = true
            CastRod()
            task.wait(_G.TB_DelayCast_Legit)
            ReelIn()
            task.wait(_G.TB_DelayFinish_Legit)
            isFishing = false
        end
    end
end)

-- BLATANT ENGINE
task.spawn(function()
    while task.wait(0.05) do
        if _G.TB_AutoFish_Blatant and not isFishing then
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

            task.wait(_G.TB_DelayCast_Blatant)
            for _ = 1,5 do
                ReelIn()
                task.wait(0.01)
            end
            task.wait(_G.TB_DelayFinish_Blatant)
            isFishing = false
        end
    end
end)

--====================================================
-- GUI SECTION (V3 STYLE)
--====================================================

local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,360)
main.Position = UDim2.new(0.5,-260,0.5,-180)
main.BackgroundColor3 = Color3.fromRGB(18,20,28)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- DRAG
do
    local d,s,p
    main.InputBegan:Connect(function(i)
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

-- HEADER
local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(1,0,0,44)
header.BackgroundTransparency = 1
header.Text = "Threeblox V3 | Auto Option"
header.Font = Enum.Font.GothamBold
header.TextSize = 18
header.TextColor3 = Color3.fromRGB(235,235,235)

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,16,0,60)
content.Size = UDim2.new(1,-32,1,-76)
content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0,10)

--====================================================
-- UI HELPERS
--====================================================

local function ToggleRow(text, callback)
    local row = Instance.new("Frame", content)
    row.Size = UDim2.new(1,0,0,40)
    row.BackgroundColor3 = Color3.fromRGB(28,30,42)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,8)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1,-80,1,0)
    lbl.Position = UDim2.new(0,12,0,0)
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Left
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(235,235,235)
    lbl.Text = text

    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(0,36,0,18)
    btn.Position = UDim2.new(1,-48,0.5,-9)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.fromRGB(90,90,120)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.BackgroundColor3 = on and Color3.fromRGB(170,80,255) or Color3.fromRGB(90,90,120)
        callback(on)
    end)
end

--====================================================
-- AUTO OPTION ITEMS
--====================================================

ToggleRow("⚙ Auto Fishing (Legit)", function(v)
    _G.TB_AutoFish_Legit = v
    if v then _G.TB_AutoFish_Blatant = false end
end)

ToggleRow("🔥 Blatant Fishing", function(v)
    _G.TB_AutoFish_Blatant = v
    if v then _G.TB_AutoFish_Legit = false end
end)

print("[Threeblox V3] Loaded successfully")
