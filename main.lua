-- Cobalt Replica - Exact Copy from Screenshot
-- Features: Remote Spy, Argument Viewer, Replay System

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// THEME (Exact from screenshot)
local THEME = {
    Background = Color3.fromRGB(25, 25, 30),
    Secondary = Color3.fromRGB(35, 35, 42),
    Accent = Color3.fromRGB(88, 101, 242),
    Text = Color3.fromRGB(220, 220, 220),
    SubText = Color3.fromRGB(150, 150, 150),
    Number = Color3.fromRGB(250, 168, 26), -- Yellow for numbers
    String = Color3.fromRGB(59, 165, 93), -- Green for strings
    Success = Color3.fromRGB(59, 165, 93),
    Error = Color3.fromRGB(237, 66, 69),
    Border = Color3.fromRGB(50, 50, 60)
}

--// UTILITY
local function Create(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
    return instance
end

--// MAIN GUI
local ScreenGui = Create("ScreenGui", {
    Name = "CobaltReplica",
    Parent = PlayerGui,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

-- Main Frame (Size from screenshot - compact)
local MainFrame = Create("Frame", {
    Name = "Main",
    Parent = ScreenGui,
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, -350, 0.5, -200),
    Size = UDim2.new(0, 700, 0, 400),
    ClipsDescendants = true
})

Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = MainFrame})
Create("UIStroke", {Color = THEME.Border, Thickness = 1, Parent = MainFrame})

--// TITLE BAR
local TitleBar = Create("Frame", {
    Name = "TitleBar",
    Parent = MainFrame,
    BackgroundColor3 = THEME.Secondary,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 35)
})

Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = TitleBar})

local TitleFix = Create("Frame", {
    Parent = TitleBar,
    BackgroundColor3 = THEME.Secondary,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 1, -10),
    Size = UDim2.new(1, 0, 0, 10)
})

-- Lightning Icon
local LightningIcon = Create("ImageLabel", {
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 12, 0.5, -10),
    Size = UDim2.new(0, 20, 0, 20),
    Image = "rbxassetid://3926307971",
    ImageRectOffset = Vector2.new(604, 324),
    ImageRectSize = Vector2.new(36, 36),
    ImageColor3 = THEME.Accent
})

local TitleText = Create("TextLabel", {
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 40, 0, 0),
    Size = UDim2.new(0, 100, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "Cobalt",
    TextColor3 = THEME.Text,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Top Right Buttons
local RunBtn = Create("ImageButton", {
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -100, 0.5, -10),
    Size = UDim2.new(0, 20, 0, 20),
    Image = "rbxassetid://3926307971",
    ImageRectOffset = Vector2.new(764, 244),
    ImageRectSize = Vector2.new(36, 36),
    ImageColor3 = THEME.SubText
})

local CopyBtn = Create("ImageButton", {
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -70, 0.5, -10),
    Size = UDim2.new(0, 20, 0, 20),
    Image = "rbxassetid://3926307971",
    ImageRectOffset = Vector2.new(644, 204),
    ImageRectSize = Vector2.new(36, 36),
    ImageColor3 = THEME.SubText
})

local SaveBtn = Create("ImageButton", {
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -40, 0.5, -10),
    Size = UDim2.new(0, 20, 0, 20),
    Image = "rbxassetid://3926307971",
    ImageRectOffset = Vector2.new(524, 444),
    ImageRectSize = Vector2.new(36, 36),
    ImageColor3 = THEME.SubText
})

local SettingsBtn = Create("ImageButton", {
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -15, 0.5, -10),
    Size = UDim2.new(0, 20, 0, 20),
    Image = "rbxassetid://3926307971",
    ImageRectOffset = Vector2.new(404, 484),
    ImageRectSize = Vector2.new(36, 36),
    ImageColor3 = THEME.SubText
})

--// LEFT PANEL - REMOTE LIST
local LeftPanel = Create("Frame", {
    Parent = MainFrame,
    BackgroundColor3 = THEME.Secondary,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0, 45),
    Size = UDim2.new(0, 200, 1, -55)
})

Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = LeftPanel})

-- Search Box
local SearchBox = Create("TextBox", {
    Parent = LeftPanel,
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(1, -20, 0, 28),
    Font = Enum.Font.Gotham,
    PlaceholderText = "Search...",
    PlaceholderColor3 = THEME.SubText,
    Text = "",
    TextColor3 = THEME.Text,
    TextSize = 12
})
Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = SearchBox})

-- Remote List
local RemoteList = Create("ScrollingFrame", {
    Parent = LeftPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 48),
    Size = UDim2.new(1, -20, 1, -58),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = THEME.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0)
})

Create("UIListLayout", {
    Parent = RemoteList,
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder
})

--// RIGHT PANEL - DETAILS
local RightPanel = Create("Frame", {
    Parent = MainFrame,
    BackgroundColor3 = THEME.Secondary,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 220, 0, 45),
    Size = UDim2.new(1, -230, 1, -55)
})

Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = RightPanel})

-- Remote Name Header
local RemoteHeader = Create("Frame", {
    Parent = RightPanel,
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(1, -20, 0, 35)
})
Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = RemoteHeader})

local RemoteIcon = Create("ImageLabel", {
    Parent = RemoteHeader,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0.5, -8),
    Size = UDim2.new(0, 16, 0, 16),
    Image = "rbxassetid://3926307971",
    ImageRectOffset = Vector2.new(404, 484),
    ImageRectSize = Vector2.new(36, 36),
    ImageColor3 = THEME.Accent
})

local RemoteNameLabel = Create("TextLabel", {
    Parent = RemoteHeader,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 32, 0, 0),
    Size = UDim2.new(1, -60, 1, 0),
    Font = Enum.Font.GothamSemibold,
    Text = "RF/RequestFishingMinigameStarted",
    TextColor3 = THEME.Text,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd
})

local PinBtn = Create("ImageButton", {
    Parent = RemoteHeader,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -25, 0.5, -8),
    Size = UDim2.new(0, 16, 0, 16),
    Image = "rbxassetid://3926307971",
    ImageRectOffset = Vector2.new(644, 244),
    ImageRectSize = Vector2.new(36, 36),
    ImageColor3 = THEME.SubText
})

-- Tabs
local TabContainer = Create("Frame", {
    Parent = RightPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 55),
    Size = UDim2.new(1, -20, 0, 30)
})

local TabArgs = Create("TextButton", {
    Parent = TabContainer,
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0, 90, 1, 0),
    Font = Enum.Font.GothamSemibold,
    Text = "  Arguments",
    TextColor3 = THEME.Text,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    AutoButtonColor = false
})
Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = TabArgs})

local TabCode = Create("TextButton", {
    Parent = TabContainer,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 100, 0, 0),
    Size = UDim2.new(0, 70, 1, 0),
    Font = Enum.Font.GothamSemibold,
    Text = "<> Code",
    TextColor3 = THEME.SubText,
    TextSize = 12,
    AutoButtonColor = false
})

local TabInfo = Create("TextButton", {
    Parent = TabContainer,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 180, 0, 0),
    Size = UDim2.new(0, 100, 1, 0),
    Font = Enum.Font.GothamSemibold,
    Text = "ⓘ Function Info",
    TextColor3 = THEME.SubText,
    TextSize = 12,
    AutoButtonColor = false
})

-- Arguments Container
local ArgsContainer = Create("ScrollingFrame", {
    Parent = RightPanel,
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0, 95),
    Size = UDim2.new(1, -20, 1, -160),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = THEME.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0)
})
Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ArgsContainer})

Create("UIListLayout", {
    Parent = ArgsContainer,
    Padding = UDim.new(0, 2),
    SortOrder = Enum.SortOrder.LayoutOrder
})

--// BOTTOM BAR
local BottomBar = Create("Frame", {
    Parent = RightPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 1, -55),
    Size = UDim2.new(1, -20, 0, 50)
})

-- Code Button
local CodeBtn = Create("TextButton", {
    Parent = BottomBar,
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0, 80, 1, 0),
    Font = Enum.Font.GothamSemibold,
    Text = "<> Code",
    TextColor3 = THEME.SubText,
    TextSize = 12,
    AutoButtonColor = false
})
Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = CodeBtn})

-- Origin Button
local OriginBtn = Create("TextButton", {
    Parent = BottomBar,
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 90, 0, 0),
    Size = UDim2.new(0, 80, 1, 0),
    Font = Enum.Font.GothamSemibold,
    Text = "🔍 Origin",
    TextColor3 = THEME.SubText,
    TextSize = 12,
    AutoButtonColor = false
})
Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = OriginBtn})

-- Event Button
local EventBtn = Create("TextButton", {
    Parent = BottomBar,
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 180, 0, 0),
    Size = UDim2.new(0, 80, 1, 0),
    Font = Enum.Font.GothamSemibold,
    Text = "📋 Event",
    TextColor3 = THEME.SubText,
    TextSize = 12,
    AutoButtonColor = false
})
Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = EventBtn})

-- Replay Button (Main)
local ReplayMainBtn = Create("TextButton", {
    Parent = BottomBar,
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(1, -120, 0, 0),
    Size = UDim2.new(0, 110, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "↻ Replay",
    TextColor3 = THEME.Text,
    TextSize = 13,
    AutoButtonColor = false
})
Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ReplayMainBtn})

-- Success Notification (Hidden by default)
local SuccessNotif = Create("Frame", {
    Parent = RightPanel,
    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 1, -25),
    Size = UDim2.new(1, -20, 0, 25),
    Visible = false
})
Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = SuccessNotif})

local CheckIcon = Create("TextLabel", {
    Parent = SuccessNotif,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 0),
    Size = UDim2.new(0, 20, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "✓",
    TextColor3 = THEME.Success,
    TextSize = 14
})

local SuccessText = Create("TextLabel", {
    Parent = SuccessNotif,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 30, 0, 0),
    Size = UDim2.new(1, -40, 1, 0),
    Font = Enum.Font.Gotham,
    Text = "Replayed event successfully!",
    TextColor3 = THEME.Success,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left
})

--// DATA STORAGE
local RemoteLogs = {}
local SelectedLog = nil
local LogCounter = 0
local NetFolder = nil

--// CREATE ARGUMENT ROW (Exact from screenshot)
local function CreateArgRow(index, value, valueType)
    local Row = Create("Frame", {
        Parent = ArgsContainer,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 28),
        LayoutOrder = index
    })
    
    -- Index Number
    local IndexLabel = Create("TextLabel", {
        Parent = Row,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(0, 25, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = tostring(index),
        TextColor3 = THEME.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Value (Yellow for number)
    local ValueColor = THEME.Number
    if valueType == "string" then ValueColor = THEME.String end
    
    local ValueLabel = Create("TextLabel", {
        Parent = Row,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 35, 0, 0),
        Size = UDim2.new(0.6, -35, 1, 0),
        Font = Enum.Font.GothamMono,
        Text = tostring(value),
        TextColor3 = ValueColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Type Label (Right side)
    local TypeLabel = Create("TextLabel", {
        Parent = Row,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.65, 0, 0, 0),
        Size = UDim2.new(0.35, -10, 1, 0),
        Font = Enum.Font.Gotham,
        Text = valueType:lower(),
        TextColor3 = THEME.SubText,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    return Row
end

--// CREATE LOG ENTRY
local function CreateLogEntry(name, remote, method, args)
    LogCounter = LogCounter + 1
    local logId = LogCounter
    
    local Entry = Create("TextButton", {
        Parent = RemoteList,
        BackgroundColor3 = THEME.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 32),
        LayoutOrder = -logId,
        AutoButtonColor = false
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = Entry})
    
    -- Icon
    local isRF = name:find("RF/") and true or false
    local Icon = Create("ImageLabel", {
        Parent = Entry,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0.5, -7),
        Size = UDim2.new(0, 14, 0, 14),
        Image = "rbxassetid://3926307971",
        ImageRectOffset = isRF and Vector2.new(404, 484) or Vector2.new(604, 324),
        ImageRectSize = Vector2.new(36, 36),
        ImageColor3 = isRF and THEME.Accent or THEME.Success
    })
    
    -- Name
    local NameLabel = Create("TextLabel", {
        Parent = Entry,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 28, 0, 0),
        Size = UDim2.new(1, -36, 1, 0),
        Font = Enum.Font.Gotham,
        Text = name,
        TextColor3 = THEME.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    })
    
    -- Store data
    local logData = {
        Id = logId,
        Name = name,
        Remote = remote,
        Method = method,
        Args = args,
        Entry = Entry
    }
    RemoteLogs[logId] = logData
    
    -- Click to select
    Entry.MouseButton1Click:Connect(function()
        if SelectedLog then
            SelectedLog.Entry.BackgroundColor3 = THEME.Background
        end
        
        SelectedLog = logData
        Entry.BackgroundColor3 = THEME.Accent
        
        -- Update header
        RemoteNameLabel.Text = name
        
        -- Clear and rebuild args
        for _, child in pairs(ArgsContainer:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        
        for i, arg in ipairs(args) do
            CreateArgRow(i, arg, typeof(arg))
        end
        
        ArgsContainer.CanvasSize = UDim2.new(0, 0, 0, #args * 30)
        
        -- Hide success notif
        SuccessNotif.Visible = false
    end)
    
    -- Hover
    Entry.MouseEnter:Connect(function()
        if SelectedLog ~= logData then
            Entry.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        end
    end)
    
    Entry.MouseLeave:Connect(function()
        if SelectedLog ~= logData then
            Entry.BackgroundColor3 = THEME.Background
        end
    end})
    
    RemoteList.CanvasSize = UDim2.new(0, 0, 0, #RemoteList:GetChildren() * 36)
end

--// FIND NET FOLDER
local function FindNetFolder()
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
    
    -- Manual search
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj.Name == "net" and obj.Parent and obj.Parent.Name:find("sleitnick") then
            if obj:FindFirstChild("RF") or obj:FindFirstChild("RE") then
                NetFolder = obj
                print("✅ NetFolder found (search):", obj:GetFullName())
                return true
            end
        end
    end
    
    return false
end

--// HOOK REMOTES
local function HookRemote(remote, name)
    if not remote then return end
    
    local method = remote:IsA("RemoteEvent") and "FireServer" or "InvokeServer"
    
    -- Use hookmetamethod for Delta compatibility
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if self == remote then
            local calledMethod = getnamecallmethod()
            if calledMethod == method then
                local args = {...}
                task.spawn(function()
                    CreateLogEntry(name, remote, method, args)
                end)
            end
        end
        return oldNamecall(self, ...)
    end)
    
    print("✅ Hooked:", name)
end

--// INITIALIZE
task.spawn(function()
    wait(1)
    
    if not FindNetFolder() then
        -- Create sample entry for testing UI
        CreateLogEntry("RF/RequestFishingMinigameStarted", nil, "InvokeServer", {-1.233, 1000, 1771160142.806})
        CreateLogEntry("RF/CancelFishingInputs", nil, "InvokeServer", {})
        CreateLogEntry("RE/EquipToolFromHotbar", nil, "FireServer", {1})
        return
    end
    
    local remotes = {
        {name = "RF/CatchFishCompleted", path = "RF/CatchFishCompleted"},
        {name = "RF/SellAllItems", path = "RF/SellAllItems"},
        {name = "RF/ChargeFishingRod", path = "RF/ChargeFishingRod"},
        {name = "RF/RequestFishingMinigameStarted", path = "RF/RequestFishingMinigameStarted"},
        {name = "RF/CancelFishingInputs", path = "RF/CancelFishingInputs"},
        {name = "RE/EquipToolFromHotbar", path = "RE/EquipToolFromHotbar"},
        {name = "RE/UnequipToolFromHotbar", path = "RE/UnequipToolFromHotbar"},
        {name = "RF/PurchaseWeatherEvent", path = "RF/PurchaseWeatherEvent"},
        {name = "RF/PurchaseFishingRod", path = "RF/PurchaseFishingRod"},
        {name = "RF/PurchaseBait", path = "RF/PurchaseBait"},
        {name = "RF/UpdateAutoSellThreshold", path = "RF/UpdateAutoSellThreshold"},
        {name = "RF/UpdateAutoFishingState", path = "RF/UpdateAutoFishingState"}
    }
    
    for _, info in pairs(remotes) do
        local remote = NetFolder:FindFirstChild(info.path)
        if remote then
            HookRemote(remote, info.name)
        end
    end
end)

--// REPLAY FUNCTION
ReplayMainBtn.MouseButton1Click:Connect(function()
    if not SelectedLog then
        RemoteNameLabel.Text = "❌ Select a remote first!"
        return
    end
    
    if not SelectedLog.Remote then
        RemoteNameLabel.Text = "❌ Remote not available!"
        return
    end
    
    -- Get args from display (in real implementation, store editable values)
    local args = SelectedLog.Args
    
    local success, result = pcall(function()
        if SelectedLog.Remote:IsA("RemoteEvent") then
            SelectedLog.Remote:FireServer(unpack(args))
        else
            return SelectedLog.Remote:InvokeServer(unpack(args))
        end
    end)
    
    if success then
        SuccessNotif.Visible = true
        SuccessText.Text = "Replayed event successfully!"
        SuccessText.TextColor3 = THEME.Success
        CheckIcon.TextColor3 = THEME.Success
    else
        SuccessNotif.Visible = true
        SuccessText.Text = "Failed: " .. tostring(result):sub(1, 30)
        SuccessText.TextColor3 = THEME.Error
        CheckIcon.Text = "✗"
        CheckIcon.TextColor3 = THEME.Error
    end
    
    task.delay(3, function()
        SuccessNotif.Visible = false
        CheckIcon.Text = "✓"
    end)
end)

--// SEARCH
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = SearchBox.Text:lower()
    for _, child in pairs(RemoteList:GetChildren()) do
        if child:IsA("TextButton") then
            local nameLabel = child:FindFirstChildOfClass("TextLabel")
            if nameLabel then
                child.Visible = nameLabel.Text:lower():find(query) ~= nil
            end
        end
    end
end)

--// DRAGGING
local dragging = false
local dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("✅ Cobalt Replica loaded!")
