-- ============================================
-- RAY DONATE BOOST - SMART TIMER CYCLE
-- ============================================

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- CONFIG
local CONFIG = {
    Keybind = Enum.KeyCode.K,
    SpamDelay = 0.05,
    AutoStart = false,
    TargetPoints = 1000,  -- Max points buat activate boost
    
    -- TAMBAHAN: Teleport Config
    MachineCFrame = CFrame.new(-3149.6748, -643.484253, -10448.9404, 0.0251379441, 7.20296143e-08, -0.999683976, 5.77469699e-08, 1, 7.35044807e-08, 0.999683976, -5.95764718e-08, 0.0251379441),
    EnableTeleport = true,  -- Bisa on/off kalo perlu
}

-- LOGO
local LOGO_ID = "rbxassetid://121625492591707"

-- STATE
local isRunning = false
local isMinimized = false
local donateCount = 0
local currentBoost = "None"
local timeLeft = "--:--"
local currentPoints = 0
local maxPoints = 1000

-- TAMBAHAN: Teleport State
local savedPosition = nil
local isAtMachine = false

-- REMOTES & DATA
local net = ReplicatedStorage:WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")

-- GANTI: Remote donate all
local remoteSellAll = net:WaitForChild("RF/0b62ff5e5cc0c77cb1b5ca5bf89d3dd73f1e54d689156ae345c138bc409d657f")

local Replion = require(ReplicatedStorage.Packages.Replion)
local AtlantisConfig = require(ReplicatedStorage.Shared.AtlantisMachineConfig)

local channel = Replion.Client:WaitReplion("AtlantisMachine")

-- GET INVENTORY
local function getInventory()
    local data = Replion.Client:WaitReplion("Data")
    if data then
        return data:Get({"Inventory", "Items"}) or {}
    end
    return {}
end

-- FORMAT TIMER
local function formatTime(seconds)
    local s = math.max(math.floor(seconds), 0)
    local h = math.floor(s / 3600)
    local m = math.floor((s % 3600) / 60)
    local sec = s % 60
    if h > 0 then
        return string.format("%i:%02i:%02i", h, m, sec)
    else
        return string.format("%02i:%02i", m, sec)
    end
end

-- GET BOOST INFO
local function getBoostInfo()
    if not channel then return nil end
    
    local boostId = channel:Get("ActiveBoostId")
    local endsAt = channel:Get("ActiveBoostEndsAt") or 0
    local points = channel:Get("CurrentPoints") or 0
    local max = channel:Get("MaxPoints") or AtlantisConfig.MaxPoints
    
    currentPoints = points
    maxPoints = max
    
    if boostId and boostId ~= "" and endsAt > workspace:GetServerTimeNow() then
        local boost = AtlantisConfig:GetBoost(boostId)
        local timeLeftSec = endsAt - workspace:GetServerTimeNow()
        timeLeft = formatTime(timeLeftSec)
        currentBoost = boost and boost.Name or "Unknown"
        return true, timeLeftSec  -- Boost aktif
    end
    
    timeLeft = "--:--"
    currentBoost = "None"
    return false, 0  -- Boost mati
end

-- ============================================
-- TAMBAHAN: TELEPORT FUNCTIONS
-- ============================================

local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

local function getHumanoidRootPart()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function teleportToMachine()
    if not CONFIG.EnableTeleport then return true end
    
    local hrp = getHumanoidRootPart()
    if not hrp then return false end
    
    -- Simpan posisi lama kalo belom disimpan
    if not savedPosition then
        savedPosition = hrp.CFrame
    end
    
    -- Teleport ke machine
    hrp.CFrame = CONFIG.MachineCFrame
    isAtMachine = true
    
    -- Delay biar server detect position
    task.wait(0.3)
    return true
end

local function teleportBack()
    if not CONFIG.EnableTeleport then return end
    if not savedPosition then return end
    
    local hrp = getHumanoidRootPart()
    if hrp then
        hrp.CFrame = savedPosition
    end
    
    isAtMachine = false
    savedPosition = nil
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "RayDonate"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 30, 20)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- TITLE BAR
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 32)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 50, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = frame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 24, 0, 24)
logo.Position = UDim2.new(0, 6, 0, 4)
logo.BackgroundTransparency = 1
logo.Image = LOGO_ID
logo.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.5, 0, 1, 0)
title.Position = UDim2.new(0, 34, 0, 0)
title.BackgroundTransparency = 1
title.Text = "RAY DONATE"
title.TextColor3 = Color3.fromRGB(100, 255, 100)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 26, 0, 22)
minBtn.Position = UDim2.new(1, -56, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
minBtn.TextSize = 16
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = titleBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 22)
closeBtn.Position = UDim2.new(1, -29, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

-- CONTENT
local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 1, -32)
content.Position = UDim2.new(0, 0, 0, 32)
content.BackgroundTransparency = 1
content.Parent = frame

-- TIMER LABEL (Boost + Time)
local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(1, 0, 0, 20)
timerLabel.Position = UDim2.new(0, 0, 0.05, 0)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "Boost: None | Time: --:--"
timerLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
timerLabel.TextSize = 11
timerLabel.Font = Enum.Font.GothamBold
timerLabel.Parent = content

-- PROGRESS LABEL
local progressLabel = Instance.new("TextLabel")
progressLabel.Size = UDim2.new(1, 0, 0, 18)
progressLabel.Position = UDim2.new(0, 0, 0.22, 0)
progressLabel.BackgroundTransparency = 1
progressLabel.Text = "Points: 0/1000"
progressLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
progressLabel.TextSize = 10
progressLabel.Parent = content

-- MAIN BUTTON
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.9, 0, 0, 38)
btn.Position = UDim2.new(0.05, 0, 0.38, 0)
btn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
btn.Text = "⏹ STOPPED (K)"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 13
btn.Font = Enum.Font.GothamBold
btn.Parent = content
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

-- STATUS LABEL
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 18)
statusLabel.Position = UDim2.new(0, 0, 0.68, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Waiting..."
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Parent = content

-- COUNT LABEL
local countLabel = Instance.new("TextLabel")
countLabel.Size = UDim2.new(1, 0, 0, 16)
countLabel.Position = UDim2.new(0, 0, 0.82, 0)
countLabel.BackgroundTransparency = 1
countLabel.Text = "Donated: 0"
countLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
countLabel.TextSize = 10
countLabel.Parent = content

-- MINIMIZED BUTTON
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 140, 0, 40)
miniBtn.Position = UDim2.new(0.5, -70, 0.9, 0)
miniBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 30)
miniBtn.Text = "RAY DONATE"
miniBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
miniBtn.TextSize = 12
miniBtn.Font = Enum.Font.GothamBold
miniBtn.Visible = false
miniBtn.Parent = gui

local miniLogo = Instance.new("ImageLabel")
miniLogo.Size = UDim2.new(0, 20, 0, 20)
miniLogo.Position = UDim2.new(0, 5, 0.5, -10)
miniLogo.BackgroundTransparency = 1
miniLogo.Image = LOGO_ID
miniLogo.Parent = miniBtn

Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 8)

-- DRAG
local dragging, dragStart, startPos
local function makeDraggable(element, target)
    element.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
        end
    end)
    element.InputEnded:Connect(function() dragging = false end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(titleBar, frame)
makeDraggable(miniBtn, miniBtn)

-- UPDATE UI
local function updateUI(status, canSpam)
    if isRunning then
        if canSpam then
            btn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)  -- Merah = Spamming
            btn.Text = "🔥 SPAMMING..."
        else
            btn.BackgroundColor3 = Color3.fromRGB(100, 150, 100)  -- Hijau tua = Standby
            btn.Text = "⏸ STANDBY"
        end
        miniBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 50)
    else
        btn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        btn.Text = "⏹ STOPPED (K)"
        miniBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 30)
    end
    
    timerLabel.Text = string.format("Boost: %s | Time: %s", currentBoost, timeLeft)
    progressLabel.Text = string.format("Points: %d/%d", currentPoints, maxPoints)
    
    if status then
        statusLabel.Text = "Status: " .. status
    end
    
    countLabel.Text = "Donated: " .. donateCount
end

-- MINIMIZE
local function toggleMinimize()
    isMinimized = not isMinimized
    frame.Visible = not isMinimized
    miniBtn.Visible = isMinimized
end

-- CLOSE
local function closeGUI()
    isRunning = false
    -- TAMBAHAN: Teleport balik kalo lagi di machine pas close
    if isAtMachine then
        teleportBack()
    end
    gui:Destroy()
    print("RAY DONATE CLOSED")
end

-- SMART DONATE LOOP - MODIFIED FOR SELL ALL
local function smartDonateLoop()
    while isRunning do
        local hasBoost, timeLeftSec = getBoostInfo()
        
        -- KALO ADA BOOST AKTIF → STANDBY
        if hasBoost then
            -- TAMBAHAN: Kalo boost aktif dan kita di machine, balik dulu
            if isAtMachine then
                updateUI("Boost active, returning...", false)
                teleportBack()
            else
                updateUI("Boost active, waiting...", false)
            end
            task.wait(1)  -- Check tiap detik
            continue
        end
        
        -- TAMBAHAN: Kalo boost mati dan belom di machine, teleport ke machine
        if not isAtMachine and CONFIG.EnableTeleport then
            updateUI("Teleporting to machine...", false)
            if not teleportToMachine() then
                updateUI("Failed to teleport!", false)
                task.wait(2)
                continue
            end
        end
        
        -- KALO BOOST MATI → SPAM SAMPE PENUH
        updateUI("Spamming for boost...", true)
        
        -- GANTI: Cek inventory tapi pake donate all
        local inventory = getInventory()
        if #inventory == 0 then
            updateUI("No fish!", false)
            task.wait(2)
            continue
        end
        
        -- LOOP DONATE ALL - lebih cepet karena bulk
        while isRunning do
            -- Cek boost aktif
            hasBoost, _ = getBoostInfo()
            if hasBoost then
                updateUI("Boost activated!", false)
                -- TAMBAHAN: Boost aktif, balik ke tempat semula
                if isAtMachine then
                    task.wait(0.5)
                    teleportBack()
                end
                break
            end
            
            -- Cek kalo udah penuh
            if currentPoints >= maxPoints then
                updateUI("Max points reached!", false)
                -- TAMBAHAN: Point penuh, balik ke tempat semula
                if isAtMachine then
                    task.wait(0.5)
                    teleportBack()
                end
                task.wait(3)
                break
            end
            
            -- GANTI: Pake donate all (bulk)
            local success, result = pcall(function()
                return remoteSellAll:InvokeServer()
            end)
            
            if success and result then
                if result.Success then
                    donateCount = donateCount + (result.Count or 0)
                    updateUI("Donated all fish!", true)
                else
                    -- Kalo gagal (mungkin ga ada fish eligible)
                    updateUI("No eligible fish", false)
                    task.wait(2)
                    break
                end
            else
                updateUI("Failed to donate", false)
                task.wait(1)
                break
            end
            
            -- Refresh data
            getBoostInfo()
            
            -- Delay antar donate all
            task.wait(CONFIG.SpamDelay)
        end
        
        task.wait(0.5)
    end
    
    -- TAMBAHAN: Pastikan balik pas stop
    if isAtMachine then
        teleportBack()
    end
    
    updateUI("Stopped", false)
end

-- TOGGLE
local function toggle()
    isRunning = not isRunning
    if isRunning then
        -- Reset teleport state pas start
        savedPosition = nil
        isAtMachine = false
        task.spawn(smartDonateLoop)
    else
        -- TAMBAHAN: Kalo stop manual, balikin juga
        if isAtMachine then
            teleportBack()
        end
    end
    updateUI(isRunning and "Starting..." or "Stopped", false)
end

-- BUTTONS
btn.MouseButton1Click:Connect(toggle)
minBtn.MouseButton1Click:Connect(toggleMinimize)
closeBtn.MouseButton1Click:Connect(closeGUI)
miniBtn.MouseButton1Click:Connect(toggleMinimize)

-- KEYBIND
UserInputService.InputBegan:Connect(function(input, p)
    if p then return end
    if input.KeyCode == CONFIG.Keybind then
        if isMinimized then
            toggleMinimize()
        else
            toggle()
        end
    end
end)

-- TIMER UPDATE (Realtime)
task.spawn(function()
    while gui.Parent do
        if isRunning then
            getBoostInfo()
            updateUI(nil, currentBoost == "None" and currentPoints < maxPoints)
        end
        task.wait(1)
    end
end)

if CONFIG.AutoStart then
    task.delay(1, toggle)
end

print("RAY DONATE SMART CYCLE LOADED!")
print("Mode: Auto-spam when boost inactive + Auto-Teleport + DONATE ALL")
print("Press K to toggle")
