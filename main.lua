--================ SERVICES =================--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ CLEAN =================--
pcall(function()
    if pg:FindFirstChild("ThreebloxV3") then
        pg.ThreebloxV3:Destroy()
    end
end)

--================ FLAGS =================--
_G.TB_AutoFish_Legit   = false
_G.TB_AutoFish_Blatant = false

--================ REMOTE (V2) =================--
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

--================ ENGINE =================--
local busy = false

local function cast()
    Events.equip:FireServer(1)
    task.wait(0.05)
    Events.charge:InvokeServer(1755848498.4834)
    task.wait(0.02)
    Events.minigame:InvokeServer(1.28,1)
end

local function reel()
    Events.fishing:FireServer()
end

task.spawn(function()
    while task.wait(0.05) do
        if _G.TB_AutoFish_Legit and not busy then
            busy = true
            cast()
            task.wait(0.8)
            reel()
            task.wait(0.2)
            busy = false
        end
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if _G.TB_AutoFish_Blatant and not busy then
            busy = true
            Events.equip:FireServer(1)
            for i=1,3 do
                task.spawn(function()
                    Events.charge:InvokeServer(1755848498.4834)
                    task.wait(0.01)
                    Events.minigame:InvokeServer(1.28,1)
                end)
                task.wait(0.03)
            end
            task.wait(0.6)
            for i=1,5 do
                reel()
                task.wait(0.01)
            end
            busy = false
        end
    end
end)

--================ GUI =================--
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,340)
main.Position = UDim2.new(0.5,-260,0.5,-170)
main.BackgroundColor3 = Color3.fromRGB(18,20,28)
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- drag
do
    local d,s,p
    main.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
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

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Threeblox V3 | Auto Option"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(235,235,235)

local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,16,0,50)
content.Size = UDim2.new(1,-32,1,-66)
content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0,10)

--================ TOGGLE =================--
local function ToggleRow(text, cb)
    local row = Instance.new("Frame", content)
    row.Size = UDim2.new(1,0,0,40)
    row.BackgroundColor3 = Color3.fromRGB(28,30,42)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,8)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1,-80,1,0)
    lbl.Position = UDim2.new(0,12,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(235,235,235)
    lbl.TextXAlignment = Enum.TextXAlignment.Left  -- ✅ FIX PENTING

    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(0,36,0,18)
    btn.Position = UDim2.new(1,-48,0.5,-9)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.fromRGB(90,90,120)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)

    local on=false
    btn.MouseButton1Click:Connect(function()
        on=not on
        btn.BackgroundColor3 = on and Color3.fromRGB(170,80,255) or Color3.fromRGB(90,90,120)
        cb(on)
    end)
end

--================ ITEMS =================--
ToggleRow("⚙ Auto Fishing (Legit)", function(v)
    _G.TB_AutoFish_Legit = v
    if v then _G.TB_AutoFish_Blatant = false end
end)

ToggleRow("🔥 Blatant Fishing", function(v)
    _G.TB_AutoFish_Blatant = v
    if v then _G.TB_AutoFish_Legit = false end
end)

print("[Threeblox V3] GUI + Engine OK")
