-- Cobalt Fishing Pro - Khusus untuk game dengan sleitnick_net
-- Auto-hook ke semua remote fishing yang udah diketahui

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

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

--// UI SETUP
local ScreenGui = Create("ScreenGui", {
    Name = "CobaltFishing",
    Parent = PlayerGui,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

-- Toggle Button
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
    Text = "🎣 Cobalt Fishing Pro",
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

Create("TextLabel", {
    Parent = ListPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 10),
    Size = UDim2.new(1, -30, 0, 25),
    Font = Enum.Font.GothamBold,
    Text = "Fishing Remotes",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
})

local RemoteList = Create("ScrollingFrame", {
    Parent = ListPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 40),
    Size = UDim2.new(1, -20, 1, -50),
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
Create("UIPadding", {Parent = ArgsContainer, PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10)})
Create("UIListLayout", {Parent = ArgsContainer, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder})

-- Quick Mods Section
local QuickMods = Create("Frame", {
    Parent = DetailPanel,
    BackgroundColor3 = CONFIG.Theme.Background,
    Position = UDim2.new(0, 10, 1, -135),
    Size = UDim2.new(1, -20, 0, 80),
    BorderSizePixel = 0
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
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
})

local ModInstant = Create("TextButton", {
    Parent = QuickMods,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    Position = UDim2.new(0, 10, 0, 30),
    Size = UDim2.new(0.48, 0, 0, 35),
    Font = Enum.Font.GothamBold,
    Text = "Instant Catch",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 12,
    AutoButtonColor = false
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
    TextSize = 12,
    AutoButtonColor = false
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
    TextSize = 16,
    AutoButtonColor = false
})
Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = ReplayBtn})

--// DATA
local RemoteLogs = {}
local SelectedLog = nil
local LogCounter = 0
local NetFolder = nil

--// FIND NET FOLDER
local function FindNetFolder()
    -- Coba path yang udah diketahui
    local success, result = pcall(function()
        return ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")
    end)
    
    if success then
        NetFolder = result
        print("✅ NetFolder ditemukan!")
        return true
    end
    
    -- Cari manual kalau versi berbeda
    for _, pkg in pairs(ReplicatedStorage:GetDescendants()) do
        if pkg.Name:find("sleitnick_net") and pkg:FindFirstChild("net") then
            NetFolder = pkg:FindFirstChild("net")
            print("✅ NetFolder ditemukan (manual):", NetFolder:GetFullName())
            return true
        end
    end
    
    return false
end

--// REMOTE REFERENCES
local FishingRemotes = {}

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
    
    for _, remoteInfo in pairs(remotes) do
        local remote = NetFolder:FindFirstChild(remoteInfo.path)
        if remote then
            FishingRemotes[remoteInfo.name] = remote
            print("🎣 Ditemukan:", remoteInfo.name)
        end
    end
    
    return true
end

--// HOOK FUNCTION
local function HookSpecificRemote(remote, name, method)
    if not remote then return end
    
    if remote:IsA("RemoteEvent") then
        local oldFireServer = remote.FireServer
        remote.FireServer = function(self, ...)
            if self == remote then
                local args = {...}
                AddLog(name, method, args, remote)
            end
            return oldFireServer(self, ...)
        end
        print("✅ Hooked RE:", name)
        
    elseif remote:IsA("RemoteFunction") then
        local oldInvokeServer = remote.InvokeServer
        remote.InvokeServer = function(self, ...)
            if self == remote then
                local args = {...}
                AddLog(name, method, args, remote)
            end
            return oldInvokeServer(self, ...)
        end
        print("✅ Hooked RF:", name)
    end
end

--// ADD LOG TO UI
function AddLog(name, method, args, remote)
    LogCounter = LogCounter + 1
    local logId = LogCounter
    
    local Entry = Create("TextButton", {
        Parent = RemoteList,
        BackgroundColor3 = CONFIG.Theme.Background,
        Size = UDim2.new(1, 0, 0, 70),
        LayoutOrder = -logId,
        AutoButtonColor = false
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = Entry})
    
    -- Icon berdasarkan tipe
    local icon = "🟢"
    if name:find("Catch") then icon = "🐟"
    elseif name:find("Sell") then icon = "💰"
    elseif name:find("Buy") then icon = "🛒"
    elseif name:find("Charge") then icon = "⚡"
    elseif name:find("Minigame") then icon = "🎮"
    end
    
    Create("TextLabel", {
        Parent = Entry,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(0, 30, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = icon,
        TextSize = 20
    })
    
    Create("TextLabel", {
        Parent = Entry,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 50, 0, 10),
        Size = UDim2.new(1, -60, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = name,
        TextColor3 = CONFIG.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    Create("TextLabel", {
        Parent = Entry,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 50, 0, 35),
        Size = UDim2.new(1, -60, 0, 20),
        Font = Enum.Font.Gotham,
        Text = method .. " • " .. #args .. " args",
        TextColor3 = CONFIG.Theme.SubText,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local logData = {
        Id = logId,
        Name = name,
        Remote = remote,
        Method = method,
        Args = args
    }
    RemoteLogs[logId] = logData
    
    -- Click handler
    Entry.MouseButton1Click:Connect(function()
        if SelectedLog then
            RemoteLogs[SelectedLog.Id].Entry.BackgroundColor3 = CONFIG.Theme.Background
        end
        
        SelectedLog = logData
        Entry.BackgroundColor3 = CONFIG.Theme.Accent
        
        -- Clear args
        for _, child in pairs(ArgsContainer:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        
        -- Build arg inputs
        for i, arg in ipairs(args) do
            local t = typeof(arg)
            local color = CONFIG.Theme.Text
            if t == "number" then color = CONFIG.Theme.Warning
            elseif t == "string" then color = CONFIG.Theme.Success end
            
            local ArgFrame = Create("Frame", {
                Parent = ArgsContainer,
                BackgroundColor3 = CONFIG.Theme.Secondary,
                Size = UDim2.new(1, 0, 0, 85)
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = ArgFrame})
            
            Create("TextLabel", {
                Parent = ArgFrame,
                BackgroundColor3 = CONFIG.Theme.Accent,
                Position = UDim2.new(0, 10, 0, 10),
                Size = UDim2.new(0, 40, 0, 25),
                Font = Enum.Font.GothamBold,
                Text = "#" .. i,
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 14
            }).CornerRadius = UDim.new(0, 6)
            
            Create("TextLabel", {
                Parent = ArgFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 60, 0, 10),
                Size = UDim2.new(0, 100, 0, 25),
                Font = Enum.Font.GothamBold,
                Text = t:lower(),
                TextColor3 = color,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local Input = Create("TextBox", {
                Parent = ArgFrame,
                BackgroundColor3 = CONFIG.Theme.Background,
                Position = UDim2.new(0, 10, 0, 45),
                Size = UDim2.new(1, -20, 0, 35),
                Font = Enum.Font.GothamMono,
                Text = tostring(arg),
                TextColor3 = CONFIG.Theme.Text,
                TextSize = 14,
                ClearTextOnFocus = false,
                TextWrapped = true
            })
            Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Input})
            
            ArgFrame:SetAttribute("Input", Input)
            ArgFrame:SetAttribute("Type", t)
        end
        
        ArgsContainer.CanvasSize = UDim2.new(0, 0, 0, #args * 95)
        DetailTitle.Text = name:sub(1, 25)
    end)
    
    logData.Entry = Entry
    RemoteList.CanvasSize = UDim2.new(0, 0, 0, #RemoteList:GetChildren() * 78)
end

--// INITIALIZE
wait(1) -- Tunggu game load
if FindNetFolder() then
    GetFishingRemotes()
    
    -- Hook semua remote
    for name, remote in pairs(FishingRemotes) do
        if remote:IsA("RemoteEvent") then
            HookSpecificRemote(remote, name, "FireServer")
        else
            HookSpecificRemote(remote, name, "InvokeServer")
        end
    end
    
    print("✅ Semua fishing remote sudah di-hook!")
else
    warn("❌ NetFolder tidak ditemukan!")
end

--// BUTTON FUNCTIONS

-- Toggle UI
local uiVisible = false
ToggleBtn.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    MainFrame.Visible = true
    
    if uiVisible then
        MainFrame:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    else
        MainFrame:TweenPosition(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        wait(0.3)
        MainFrame.Visible = false
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    uiVisible = false
    MainFrame:TweenPosition(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    wait(0.3)
    MainFrame.Visible = false
end)

-- Quick Mods
ModInstant.MouseButton1Click:Connect(function()
    if not SelectedLog then return end
    if SelectedLog.Name ~= "Minigame" then
        ModInstant.Text = "❌ Pilih Minigame!"
        wait(1)
        ModInstant.Text = "Instant Catch"
        return
    end
    
    -- Auto set argumen untuk instant catch
    for _, child in pairs(ArgsContainer:GetChildren()) do
        if child:IsA("Frame") then
            local input = child:GetAttribute("Input")
            local idx = child.LayoutOrder
            if idx == 2 then -- Force/Power
                input.Text = "99999"
            elseif idx == 3 then -- Timestamp atau instant flag
                input.Text = "0"
            end
        end
    end
    
    ModInstant.Text = "✅ Mod Applied!"
    wait(1)
    ModInstant.Text = "Instant Catch"
end)

ModLegendary.MouseButton1Click:Connect(function()
    if not SelectedLog then return end
    if SelectedLog.Name ~= "CatchFish" then
        ModLegendary.Text = "❌ Pilih CatchFish!"
        wait(1)
        ModLegendary.Text = "Legendary Fish"
        return
    end
    
    -- Mod untuk legendary fish
    for _, child in pairs(ArgsContainer:GetChildren()) do
        if child:IsA("Frame") then
            local input = child:GetAttribute("Input")
            local idx = child.LayoutOrder
            if idx == 1 then -- Fish ID/Rarity
                input.Text = "5" -- Legendary tier
            end
        end
    end
    
    ModLegendary.Text = "✅ Mod Applied!"
    wait(1)
    ModLegendary.Text = "Legendary Fish"
end)

-- Replay
ReplayBtn.MouseButton1Click:Connect(function()
    if not SelectedLog then
        ReplayBtn.Text = "❌ Pilih Log Dulu!"
        wait(1)
        ReplayBtn.Text = "↻ REPLAY EVENT"
        return
    end
    
    -- Collect modified args
    local newArgs = {}
    for _, child in pairs(ArgsContainer:GetChildren()) do
        if child:IsA("Frame") then
            local input = child:GetAttribute("Input")
            local t = child:GetAttribute("Type")
            local val = input.Text
            
            if t == "number" then val = tonumber(val) or 0
            elseif t == "boolean" then val = val:lower() == "true"
            end
            
            table.insert(newArgs, val)
        end
    end
    
    -- Fire
    local success, result = pcall(function()
        if SelectedLog.Remote:IsA("RemoteEvent") then
            SelectedLog.Remote:FireServer(unpack(newArgs))
        else
            return SelectedLog.Remote:InvokeServer(unpack(newArgs))
        end
    end)
    
    if success then
        ReplayBtn.Text = "✅ Replay Sukses!"
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Success
    else
        ReplayBtn.Text = "❌ Gagal: " .. tostring(result):sub(1, 20)
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Error
    end
    
    wait(1.5)
    ReplayBtn.Text = "↻ REPLAY EVENT"
    ReplayBtn.BackgroundColor3 = CONFIG.Theme.Accent
end)

-- Drag toggle
local dragging = false
local dragStart, startPos

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position
    end
end)

ToggleBtn.InputEnded:Connect(function(input)
    dragging = false
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        ToggleBtn.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

print("🎣 Cobalt Fishing Pro loaded!")
print("👆 Tap 🎣 untuk buka UI")
