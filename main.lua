-- Cobalt Fishing Pro v2.0 - Delta Executor Optimized
-- Khusus sleitnick_net fishing games | Auto-hook + Replay + Mods
-- Fixed: Delta timing, hooking stability, memory leaks

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Anti-dupe & Delta safety
if getgenv().CobaltLoaded then return end
getgenv().CobaltLoaded = true

--// CONFIG
local CONFIG = {
    Theme = {
        Background = Color3.fromRGB(20, 20, 25),
        Secondary = Color3.fromRGB(30, 30, 38),
        Accent = Color3.fromRGB(88, 101, 242),
        Success = Color3.fromRGB(59, 165, 93),
        Error = Color3.fromRGB(237, 66, 69),
        Warning = Color3.fromRGB(250, 168, 26),
        Text = Color3.fromRGB(240, 240, 240),
        SubText = Color3.fromRGB(150, 150, 150)
    }
}

--// UTILITY
local function Create(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
    return instance
end

--// DELTA TIMING FIX
task.wait(3) -- Wait game load
repeat task.wait(0.5) until ReplicatedStorage.Parent -- Ensure RS ready

--// UI SETUP
local ScreenGui = Create("ScreenGui", {
    Name = "CobaltFishingPro",
    Parent = PlayerGui,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

-- Toggle Button (Draggable)
local ToggleBtn = Create("TextButton", {
    Name = "Toggle",
    Parent = ScreenGui,
    BackgroundColor3 = CONFIG.Theme.Accent,
    Position = UDim2.new(0, 10, 0.3, 0),
    Size = UDim2.new(0, 55, 0, 55),
    Text = "🎣",
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 28,
    ZIndex = 100
})
Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ToggleBtn})

-- Main Frame
local MainFrame = Create("Frame", {
    Name = "Main",
    Parent = ScreenGui,
    BackgroundColor3 = CONFIG.Theme.Background,
    Position = UDim2.new(0, 0, 1, 0),
    Size = UDim2.new(1, 0, 1, 0),
    Visible = false
})

-- Header
local Header = Create("Frame", {
    Parent = MainFrame,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    Size = UDim2.new(1, 0, 0, 60)
})

Create("TextLabel", {
    Parent = Header,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 0),
    Size = UDim2.new(0, 250, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "🎣 Cobalt Fishing Pro v2.0",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Left
})

local CloseBtn = Create("TextButton", {
    Parent = Header,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -50, 0, 0),
    Size = UDim2.new(0, 50, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "✕",
    TextColor3 = CONFIG.Theme.Error,
    TextSize = 24
})

-- Content
local Content = Create("Frame", {
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 60),
    Size = UDim2.new(1, 0, 1, -60)
})

-- Remote List Panel
local ListPanel = Create("Frame", {
    Parent = Content,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(0.5, -15, 1, -20)
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = ListPanel})

local ListTitle = Create("TextLabel", {
    Parent = ListPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 10),
    Size = UDim2.new(1, -30, 0, 25),
    Font = Enum.Font.GothamBold,
    Text = "📡 Fishing Remotes",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
})

local ClearBtn = Create("TextButton", {
    Parent = ListPanel,
    BackgroundColor3 = CONFIG.Theme.Warning,
    Position = UDim2.new(1, -70, 0, 8),
    Size = UDim2.new(0, 60, 0, 25),
    Font = Enum.Font.GothamBold,
    Text = "Clear",
    TextColor3 = Color3.new(1,1,1),
    TextSize = 12
})
Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ClearBtn})

local RemoteList = Create("ScrollingFrame", {
    Parent = ListPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 40),
    Size = UDim2.new(1, -20, 1, -55),
    ScrollBarThickness = 6,
    ScrollBarImageColor3 = CONFIG.Theme.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0)
})
Create("UIListLayout", {Parent = RemoteList, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})

-- Detail Panel
local DetailPanel = Create("Frame", {
    Parent = Content,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    Position = UDim2.new(0.5, 5, 0, 10),
    Size = UDim2.new(0.5, -15, 1, -20)
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = DetailPanel})

local DetailTitle = Create("TextLabel", {
    Parent = DetailPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 10),
    Size = UDim2.new(1, -30, 0, 25),
    Font = Enum.Font.GothamBold,
    Text = "Arguments",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
})

local ArgsContainer = Create("ScrollingFrame", {
    Parent = DetailPanel,
    BackgroundColor3 = CONFIG.Theme.Background,
    Position = UDim2.new(0, 10, 0, 45),
    Size = UDim2.new(1, -20, 1, -150),
    ScrollBarThickness = 6,
    ScrollBarImageColor3 = CONFIG.Theme.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0)
})
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = ArgsContainer})
Create("UIPadding", {Parent = ArgsContainer})
Create("UIListLayout", {Parent = ArgsContainer, Padding = UDim.new(0, 10)})

-- Quick Mods
local QuickMods = Create("Frame", {
    Parent = DetailPanel,
    BackgroundColor3 = CONFIG.Theme.Background,
    Position = UDim2.new(0, 10, 1, -135),
    Size = UDim2.new(1, -20, 0, 80)
})
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = QuickMods})

Create("TextLabel", {
    Parent = QuickMods,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 5),
    Size = UDim2.new(1, -20, 0, 20),
    Font = Enum.Font.GothamBold,
    Text = "⚡ Quick Mods",
    TextColor3 = CONFIG.Theme.Accent,
    TextSize = 14
})

local ModInstant = Create("TextButton", {
    Parent = QuickMods,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    Position = UDim2.new(0, 10, 0, 30),
    Size = UDim2.new(0.48, 0, 0, 35),
    Font = Enum.Font.GothamBold,
    Text = "Instant Catch",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 12
})
Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ModInstant})

local ModLegendary = Create("TextButton", {
    Parent = QuickMods,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    Position = UDim2.new(0.52, 0, 0, 30),
    Size = UDim2.new(0.48, 0, 0, 35),
    Font = Enum.Font.GothamBold,
    Text = "Legendary Fish",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 12
})
Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ModLegendary})

-- Replay Button
local ReplayBtn = Create("TextButton", {
    Parent = DetailPanel,
    BackgroundColor3 = CONFIG.Theme.Accent,
    Position = UDim2.new(0, 10, 1, -50),
    Size = UDim2.new(1, -20, 0, 45),
    Font = Enum.Font.GothamBold,
    Text = "↻ REPLAY EVENT",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 16
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = ReplayBtn})

--// DATA
local RemoteLogs = {}
local SelectedLog = nil
local LogCounter = 0
local NetFolder = nil
local FishingRemotes = {}

--// IMPROVED NETFOLDER FINDER (Delta safe)
local function FindNetFolder()
    print("🔍 Scanning for sleitnick_net...")
    local attempts = 0
    repeat
        attempts += 1
        local success, result = pcall(function()
            if ReplicatedStorage:FindFirstChild("Packages") then
                return ReplicatedStorage.Packages:FindFirstChild("_Index")
                    and ReplicatedStorage.Packages._Index:FindFirstChild("sleitnick_net@0.2.0")
                    and ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"]:FindFirstChild("net")
            end
        end)
        if success and result then 
            NetFolder = result
            print("✅ NetFolder found:", result:GetFullName())
            return true 
        end
        
        -- Manual scan
        for _, obj in ReplicatedStorage:GetDescendants() do
            if obj.Name:find("sleitnick_net") and obj:FindFirstChild("net") then
                NetFolder = obj.net
                print("✅ Manual NetFolder:", NetFolder:GetFullName())
                return true
            end
        end
        task.wait(1)
    until attempts > 15
    
    warn("❌ NetFolder not found after 15 attempts")
    return false
end

--// GET FISHING REMOTES
local function GetFishingRemotes()
    if not NetFolder then return false end
    
    local remotes = {
        {name = "CatchFish", path = "RF/CatchFishCompleted"},
        {name = "SellAll", path = "RF/SellAllItems"},
        {name = "ChargeRod", path = "RF/ChargeFishingRod"},
        {name = "Minigame", path = "RF/RequestFishingMinigameStarted"},
        {name = "Cancel", path = "RF/CancelFishingInputs"},
        {name = "EquipTool", path = "RE/EquipToolFromHotbar"},
        {name = "UnequipTool", path = "RE/UnequipToolFromHotbar"},
        {name = "BuyWeather", path = "RF/PurchaseWeatherEvent"},
        {name = "BuyRod", path = "RF/PurchaseFishingRod"},
        {name = "BuyBait", path = "RF/PurchaseBait"},
        {name = "AutoSell", path = "RF/UpdateAutoSellThreshold"},
        {name = "AutoFish", path = "RF/UpdateAutoFishingState"}
    }
    
    for _, info in remotes do
        local remote = NetFolder:FindFirstChild(info.path)
        if remote then
            FishingRemotes[info.name] = remote
            print("🎣 Found:", info.name, "("..info.path..")")
        end
    end
    return next(FishingRemotes) ~= nil
end

--// DELTA-SAFE HOOKING
local function HookRemote(remote, name, method)
    if not remote then return end
    
    local oldName = method == "FireServer" and "FireServer" or "InvokeServer"
    local oldFunc = remote[oldName]
    
    remote[oldName] = function(self, ...)
        if self == remote then
            local args = {...}
            AddLog(name, method, args, remote)
        end
        return oldFunc(self, ...)
    end
    
    print("✅ Hooked", method, name)
end

--// ADD LOG (Memory safe)
function AddLog(name, method, args, remote)
    LogCounter += 1
    local logId = LogCounter
    
    local Entry = Create("TextButton", {
        Parent = RemoteList,
        BackgroundColor3 = CONFIG.Theme.Background,
        Size = UDim2.new(1, 0, 0, 70),
        LayoutOrder = -logId
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = Entry})
    
    -- Icon logic
    local icon = "🟢"
    if name:find("Catch") then icon = "🐟"
    elseif name:find("Sell") then icon = "💰"
    elseif name:find("Buy") then icon = "🛒"
    elseif name:find("Charge") then icon = "⚡"
    elseif name:find("Minigame") then icon = "🎮"
    end
    
    -- Icon label
    Create("TextLabel", {
        Parent = Entry, BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(0, 30, 0, 30), Font = Enum.Font.GothamBold, Text = icon,
        TextSize = 20
    })
    
    -- Name label
    Create("TextLabel", {
        Parent = Entry, BackgroundTransparency = 1, Position = UDim2.new(0, 50, 0, 10),
        Size = UDim2.new(1, -60, 0, 20), Font = Enum.Font.GothamBold, Text = name,
        TextColor3 = CONFIG.Theme.Text, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Method label
    Create("TextLabel", {
        Parent = Entry, BackgroundTransparency = 1, Position = UDim2.new(0, 50, 0, 35),
        Size = UDim2.new(1, -60, 0, 20), Font = Enum.Font.Gotham, 
        Text = method.." • "..#args.." args", TextColor3 = CONFIG.Theme.SubText,
        TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local logData = {Id = logId, Name = name, Remote = remote, Method = method, Args = args, Entry = Entry}
    RemoteLogs[logId] = logData
    
    -- Selection handler
    Entry.MouseButton1Click:Connect(function()
        if SelectedLog then
            SelectedLog.Entry.BackgroundColor3 = CONFIG.Theme.Background
        end
        SelectedLog = logData
        Entry.BackgroundColor3 = CONFIG.Theme.Accent
        
        -- Clear args
        for _, child in ArgsContainer:GetChildren() do
            if child:IsA("Frame") then child:Destroy() end
        end
        
        -- Build editable args
        for i, arg in args do
            local t = typeof(arg)
            local color = CONFIG.Theme.Text
            if t == "number" then color = CONFIG.Theme.Warning
            elseif t == "string" then color = CONFIG.Theme.Success end
            
            local ArgFrame = Create("Frame", {
                Parent = ArgsContainer, BackgroundColor3 = CONFIG.Theme.Secondary,
                Size = UDim2.new(1, 0, 0, 85), LayoutOrder = i
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = ArgFrame})
            
            -- Index badge
            local Badge = Create("Frame", {
                Parent = ArgFrame, BackgroundColor3 = CONFIG.Theme.Accent,
                Position = UDim2.new(0, 10, 0, 10), Size = UDim2.new(0, 40, 0, 25)
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Badge})
            Create("TextLabel", {
                Parent = Badge, BackgroundTransparency = 1, Size = UDim2.new(1,0,1,0),
                Font = Enum.Font.GothamBold, Text = "#"..i, TextColor3 = Color3.new(1,1,1),
                TextSize = 14
            })
            
            -- Type label
            Create("TextLabel", {
                Parent = ArgFrame, BackgroundTransparency = 1, Position = UDim2.new(0, 60, 0, 10),
                Size = UDim2.new(0, 100, 0, 25), Font = Enum.Font.GothamBold,
                Text = t:lower(), TextColor3 = color, TextSize = 14
            })
            
            -- Editable input
            local Input = Create("TextBox", {
                Parent = ArgFrame, BackgroundColor3 = CONFIG.Theme.Background,
                Position = UDim2.new(0, 10, 0, 45), Size = UDim2.new(1, -20, 0, 35),
                Font = Enum.Font.GothamMono, Text = tostring(arg), TextColor3 = CONFIG.Theme.Text,
                TextSize = 14, ClearTextOnFocus = false, TextWrapped = true
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Input})
            
            ArgFrame:SetAttribute("Input", Input)
            ArgFrame:SetAttribute("Type", t)
            ArgFrame:SetAttribute("Index", i)
        end
        
        ArgsContainer.CanvasSize = UDim2.new(0, 0, 0, #args * 95)
        DetailTitle.Text = name:sub(1, 25).." Args"
    end)
    
    UpdateCanvasSize()
end

function UpdateCanvasSize()
    RemoteList.CanvasSize = UDim2.new(0, 0, 0, #RemoteList:GetChildren() * 78)
end

--// INITIALIZE (Delta optimized)
task.spawn(function()
    if FindNetFolder() and GetFishingRemotes() then
        for name, remote in FishingRemotes do
            if remote:IsA("RemoteEvent") then
                HookRemote(remote, name, "FireServer")
            else
                HookRemote(remote, name, "InvokeServer")
            end
        end
        print("✅ All fishing remotes hooked! Delta ready.")
    end
end)

--// UI CONTROLS
local uiVisible = false

-- Toggle
ToggleBtn.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    MainFrame.Visible = true
    if uiVisible then
        MainFrame:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3)
    else
        MainFrame:TweenPosition(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.3)
        task.wait(0.3)
        MainFrame.Visible = false
    end
end)

-- Close
CloseBtn.MouseButton1Click:Connect(function()
    uiVisible = false
    MainFrame:TweenPosition(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.3)
    task.wait(0.3)
    MainFrame.Visible = false
end)

-- Clear logs
ClearBtn.MouseButton1Click:Connect(function()
    for id, log in RemoteLogs do
        log.Entry:Destroy()
    end
    RemoteLogs = {}
    LogCounter = 0
    SelectedLog = nil
    UpdateCanvasSize()
    print("🧹 Logs cleared")
end)

-- Quick Mods
ModInstant.MouseButton1Click:Connect(function()
    if not SelectedLog or SelectedLog.Name ~= "Minigame" then
        ModInstant.Text = "❌ Pilih Minigame!"
        ModInstant.BackgroundColor3 = CONFIG.Theme.Error
        task.wait(1)
        ModInstant.Text = "Instant Catch"
        ModInstant.BackgroundColor3 = CONFIG.Theme.Secondary
        return
    end
    
    for _, child in ArgsContainer:GetChildren() do
        if child:IsA("Frame") then
            local input = child:GetAttribute("Input")
            local idx = child:GetAttribute("Index")
            if idx == 2 then input.Text = "99999" -- Power
            elseif idx == 3 then input.Text = "0" -- Time
            end
        end
    end
    
    ModInstant.Text = "✅ Applied!"
    ModInstant.BackgroundColor3 = CONFIG.Theme.Success
    task.wait(1)
    ModInstant.Text = "Instant Catch"
    ModInstant.BackgroundColor3 = CONFIG.Theme.Secondary
end)

ModLegendary.MouseButton1Click:Connect(function()
    if not SelectedLog or SelectedLog.Name ~= "CatchFish" then
        ModLegendary.Text = "❌ Pilih CatchFish!"
        ModLegendary.BackgroundColor3 = CONFIG.Theme.Error
        task.wait(1)
        ModLegendary.Text = "Legendary Fish"
        ModLegendary.BackgroundColor3 = CONFIG.Theme.Secondary
        return
    end
    
    for _, child in ArgsContainer:GetChildren() do
        if child:IsA("Frame") then
            local input = child:GetAttribute("Input")
            local idx = child:GetAttribute("Index")
            if idx == 1 then input.Text = "5" -- Legendary
            end
        end
    end
    
    ModLegendary.Text = "✅ Legendary!"
    ModLegendary.BackgroundColor3 = CONFIG.Theme.Success
    task.wait(1)
    ModLegendary.Text = "Legendary Fish"
    ModLegendary.BackgroundColor3 = CONFIG.Theme.Secondary
end)

-- Replay (Type safe)
ReplayBtn.MouseButton1Click:Connect(function()
    if not SelectedLog then
        ReplayBtn.Text = "❌ Pilih Log!"
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Error
        task.wait(1)
        ReplayBtn.Text = "↻ REPLAY EVENT"
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Accent
        return
    end
    
    local newArgs = {}
    for _, child in ArgsContainer:GetChildren() do
        if child:IsA("Frame") then
            local input = child:GetAttribute("Input")
            local t = child:GetAttribute("Type")
            local val = input.Text
            
            if t == "number" then val = tonumber(val) or 0
            elseif t == "boolean" then val = val:lower() == "true"
            elseif t == "Vector3" then 
                local v = string.split(val, ", ")
                val = Vector3.new(tonumber(v[1])or0, tonumber(v[2])or0, tonumber(v[3])or0)
            end
            
            table.insert(newArgs, val)
        end
    end
    
    local success, result = pcall(function()
        if SelectedLog.Remote:IsA("RemoteEvent") then
            SelectedLog.Remote:FireServer(unpack(newArgs))
        else
            return SelectedLog.Remote:InvokeServer(unpack(newArgs))
        end
    end)
    
    if success then
        ReplayBtn.Text = "✅ Replay OK!"
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Success
    else
        ReplayBtn.Text = "❌ Error: "..tostring(result):sub(1,20)
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Error
    end
    
    task.wait(1.5)
    ReplayBtn.Text = "↻ REPLAY EVENT"
    ReplayBtn.BackgroundColor3 = CONFIG.Theme.Accent
end)

-- Draggable Toggle (Delta touch safe)
local dragging, dragStart, startPos
ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position
        TweenService:Create(ToggleBtn, TweenInfo.new(0.1), {Size = UDim2.new(0,60,0,60)}):Play()
    end
end)

ToggleBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        TweenService:Create(ToggleBtn, TweenInfo.new(0.1), {Size = UDim2.new(0,55,0,55)}):Play()
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("🎣 Cobalt Fishing Pro v2.0 LOADED - Delta Optimized!")
print("👆 Drag & tap 🎣 | Clear logs anytime | Index-based mods!")
