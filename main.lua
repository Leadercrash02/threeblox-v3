-- Cobalt Fishing Pro V2 - Delta Mobile Fixed
-- Fixed hook method for sleitnick_net

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

local function Create(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
    return instance
end

--// UI SETUP
local ScreenGui = Create("ScreenGui", {
    Name = "CobaltFishingV2",
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
    Text = "🎣 Cobalt Fishing V2",
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

-- Status Label
local StatusLabel = Create("TextLabel", {
    Parent = Content,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 5),
    Size = UDim2.new(1, -20, 0, 25),
    Font = Enum.Font.GothamSemibold,
    Text = "⏳ Mencari remotes...",
    TextColor3 = CONFIG.Theme.Warning,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Remote List Panel
local ListPanel = Create("Frame", {
    Parent = Content,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    Position = UDim2.new(0, 10, 0, 35),
    Size = UDim2.new(0.5, -15, 1, -45)
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
    Position = UDim2.new(0.5, 5, 0, 35),
    Size = UDim2.new(0.5, -15, 1, -45)
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
    Size = UDim2.new(1, -20, 1, -130),
    ScrollBarThickness = 6,
    ScrollBarImageColor3 = CONFIG.Theme.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0)
})
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = ArgsContainer})
Create("UIPadding", {Parent = ArgsContainer, PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10)})
Create("UIListLayout", {Parent = ArgsContainer, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder})

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
local HookedRemotes = {}

--// FIND NET FOLDER
local function FindNetFolder()
    -- Coba path exact
    local paths = {
        "Packages/_Index/sleitnick_net@0.2.0/net",
        "Packages/_Index/sleitnick_net@0.1.0/net",
        "Packages/_Index/sleitnick_net@0.3.0/net",
        "_Index/sleitnick_net@0.2.0/net"
    }
    
    for _, path in pairs(paths) do
        local current = ReplicatedStorage
        local found = true
        
        for _, name in pairs(path:split("/")) do
            current = current:FindFirstChild(name)
            if not current then
                found = false
                break
            end
        end
        
        if found then
            NetFolder = current
            print("✅ NetFolder found:", path)
            return true
        end
    end
    
    -- Search manually
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj.Name == "net" and obj:FindFirstChild("RF") or obj:FindFirstChild("RE") then
            if obj.Parent and obj.Parent.Name:find("sleitnick") then
                NetFolder = obj
                print("✅ NetFolder found (search):", obj:GetFullName())
                return true
            end
        end
    end
    
    return false
end

--// SAFE HOOK USING NAMECALL
local function HookRemote(remote, name)
    if not remote or HookedRemotes[remote] then return end
    HookedRemotes[remote] = true
    
    local method = remote:IsA("RemoteEvent") and "FireServer" or "InvokeServer"
    
    -- Gunakan hookmetamethod atau namecall hook
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if self == remote then
            local methodCalled = getnamecallmethod()
            if methodCalled == method then
                local args = {...}
                
                -- Spawn biar ga lag
                task.spawn(function()
                    AddLog(name, method, args, remote)
                end)
            end
        end
        return oldNamecall(self, ...)
    end)
    
    print("✅ Hooked:", name, "(" .. method .. ")")
end

--// ADD LOG TO UI
function AddLog(name, method, args, remote)
    LogCounter = LogCounter + 1
    local logId = LogCounter
    
    -- Buat entry di main thread
    local Entry = Create("TextButton", {
        Parent = RemoteList,
        BackgroundColor3 = CONFIG.Theme.Background,
        Size = UDim2.new(1, 0, 0, 70),
        LayoutOrder = -logId,
        AutoButtonColor = false
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = Entry})
    
    local icon = "🟢"
    if name:find("Catch") then icon = "🐟"
    elseif name:find("Sell") then icon = "💰"
    elseif name:find("Buy") or name:find("Purchase") then icon = "🛒"
    elseif name:find("Charge") then icon = "⚡"
    elseif name:find("Minigame") then icon = "🎮"
    elseif name:find("Cancel") then icon = "❌"
    elseif name:find("Equip") then icon = "🎒"
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
        Args = args,
        Entry = Entry
    }
    RemoteLogs[logId] = logData
    
    Entry.MouseButton1Click:Connect(function()
        if SelectedLog then
            RemoteLogs[SelectedLog.Id].Entry.BackgroundColor3 = CONFIG.Theme.Background
        end
        
        SelectedLog = logData
        Entry.BackgroundColor3 = CONFIG.Theme.Accent
        
        for _, child in pairs(ArgsContainer:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        
        for i, arg in ipairs(args) do
            local t = typeof(arg)
            local color = CONFIG.Theme.Text
            if t == "number" then color = CONFIG.Theme.Warning
            elseif t == "string" then color = CONFIG.Theme.Success
            elseif t == "boolean" then color = CONFIG.Theme.Accent end
            
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
            })
            
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
    
    RemoteList.CanvasSize = UDim2.new(0, 0, 0, #RemoteList:GetChildren() * 78)
end

--// INITIALIZE
task.spawn(function()
    wait(1)
    
    if not FindNetFolder() then
        StatusLabel.Text = "❌ NetFolder tidak ditemukan!"
        StatusLabel.TextColor3 = CONFIG.Theme.Error
        return
    end
    
    StatusLabel.Text = "✅ NetFolder ditemukan! Hooking..."
    
    -- Define remotes
    local remoteList = {
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
    
    local hookedCount = 0
    for _, info in pairs(remoteList) do
        local remote = NetFolder:FindFirstChild(info.path)
        if remote then
            HookRemote(remote, info.name)
            hookedCount = hookedCount + 1
        end
    end
    
    StatusLabel.Text = "✅ " .. hookedCount .. " remotes hooked! Siap mancing!"
    StatusLabel.TextColor3 = CONFIG.Theme.Success
    
    print("✅ Setup complete!")
end)

--// BUTTON FUNCTIONS
local uiVisible = false
ToggleBtn.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    MainFrame.Visible = true
    
    if uiVisible then
        MainFrame:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    else
        MainFrame:TweenPosition(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        task.wait(0.3)
        MainFrame.Visible = false
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    uiVisible = false
    MainFrame:TweenPosition(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    task.wait(0.3)
    MainFrame.Visible = false
end)

-- Replay
ReplayBtn.MouseButton1Click:Connect(function()
    if not SelectedLog then
        ReplayBtn.Text = "❌ Pilih Log Dulu!"
        task.wait(1)
        ReplayBtn.Text = "↻ REPLAY EVENT"
        return
    end
    
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
        ReplayBtn.Text = "❌ Gagal!"
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Error
        warn("Replay error:", result)
    end
    
    task.wait(1.5)
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

print("🎣 Cobalt Fishing V2 loaded!")
print("👆 Tap 🎣 untuk buka UI")
