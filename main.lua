-- Cobalt V4 - Auto Display Real Args from Spy
-- Nilai asli langsung muncul tanpa edit manual

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- THEME
local THEME = {
    Background = Color3.fromRGB(20, 20, 25),
    Secondary = Color3.fromRGB(30, 30, 38),
    Accent = Color3.fromRGB(88, 101, 242),
    Text = Color3.fromRGB(220, 220, 220),
    SubText = Color3.fromRGB(120, 120, 140),
    Number = Color3.fromRGB(250, 168, 26),
    String = Color3.fromRGB(59, 165, 93),
    Boolean = Color3.fromRGB(88, 101, 242),
    Success = Color3.fromRGB(59, 165, 93),
    Error = Color3.fromRGB(237, 66, 69),
    Border = Color3.fromRGB(45, 45, 55)
}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CobaltV4"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
MainFrame.Size = UDim2.new(0, 500, 0, 320)

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = THEME.Secondary
TitleBar.Size = UDim2.new(1, 0, 0, 32)

local TitleFix = Instance.new("Frame")
TitleFix.Parent = TitleBar
TitleFix.BackgroundColor3 = THEME.Secondary
TitleFix.Position = UDim2.new(0, 0, 1, -8)
TitleFix.Size = UDim2.new(1, 0, 0, 8)

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 35, 0, 0)
TitleText.Size = UDim2.new(0, 80, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "Cobalt"
TitleText.TextColor3 = THEME.Text
TitleText.TextSize = 15

-- Close & Minimize
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = THEME.Error
CloseBtn.TextSize = 16

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.BackgroundTransparency = 1
MinBtn.Position = UDim2.new(1, -60, 0, 0)
MinBtn.Size = UDim2.new(0, 30, 1, 0)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "–"
MinBtn.TextColor3 = THEME.SubText
MinBtn.TextSize = 20

-- Left Panel
local LeftPanel = Instance.new("Frame")
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = THEME.Secondary
LeftPanel.Position = UDim2.new(0, 8, 0, 40)
LeftPanel.Size = UDim2.new(0, 140, 1, -48)

Instance.new("UICorner", LeftPanel).CornerRadius = UDim.new(0, 6)

-- Search
local SearchBox = Instance.new("TextBox")
SearchBox.Parent = LeftPanel
SearchBox.BackgroundColor3 = THEME.Background
SearchBox.Position = UDim2.new(0, 8, 0, 8)
SearchBox.Size = UDim2.new(1, -16, 0, 24)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "Search..."
SearchBox.PlaceholderColor3 = THEME.SubText
SearchBox.Text = ""
SearchBox.TextColor3 = THEME.Text
SearchBox.TextSize = 11

Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 4)

-- Remote List
local RemoteList = Instance.new("ScrollingFrame")
RemoteList.Parent = LeftPanel
RemoteList.BackgroundTransparency = 1
RemoteList.Position = UDim2.new(0, 8, 0, 40)
RemoteList.Size = UDim2.new(1, -16, 1, -48)
RemoteList.ScrollBarThickness = 3
RemoteList.ScrollBarImageColor3 = THEME.Accent
RemoteList.CanvasSize = UDim2.new(0, 0, 0, 0)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = RemoteList
ListLayout.Padding = UDim.new(0, 3)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Right Panel
local RightPanel = Instance.new("Frame")
RightPanel.Parent = MainFrame
RightPanel.BackgroundColor3 = THEME.Secondary
RightPanel.Position = UDim2.new(0, 156, 0, 40)
RightPanel.Size = UDim2.new(1, -164, 1, -48)

Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 6)

-- Remote Header
local RemoteHeader = Instance.new("Frame")
RemoteHeader.Parent = RightPanel
RemoteHeader.BackgroundColor3 = THEME.Background
RemoteHeader.Position = UDim2.new(0, 8, 0, 8)
RemoteHeader.Size = UDim2.new(1, -16, 0, 30)

Instance.new("UICorner", RemoteHeader).CornerRadius = UDim.new(0, 6)

local RemoteIcon = Instance.new("ImageLabel")
RemoteIcon.Parent = RemoteHeader
RemoteIcon.BackgroundTransparency = 1
RemoteIcon.Position = UDim2.new(0, 8, 0.5, -7)
RemoteIcon.Size = UDim2.new(0, 14, 0, 14)
RemoteIcon.Image = "rbxassetid://3926307971"
RemoteIcon.ImageRectOffset = Vector2.new(404, 484)
RemoteIcon.ImageRectSize = Vector2.new(36, 36)
RemoteIcon.ImageColor3 = THEME.Accent

local RemoteName = Instance.new("TextLabel")
RemoteName.Parent = RemoteHeader
RemoteName.BackgroundTransparency = 1
RemoteName.Position = UDim2.new(0, 28, 0, 0)
RemoteName.Size = UDim2.new(1, -50, 1, 0)
RemoteName.Font = Enum.Font.GothamSemibold
RemoteName.Text = "Select a remote..."
RemoteName.TextColor3 = THEME.Text
RemoteName.TextSize = 12
RemoteName.TextXAlignment = Enum.TextXAlignment.Left
RemoteName.TextTruncate = Enum.TextTruncate.AtEnd

-- Pin Button
local PinBtn = Instance.new("TextButton")
PinBtn.Parent = RemoteHeader
PinBtn.BackgroundTransparency = 1
PinBtn.Position = UDim2.new(1, -25, 0.5, -10)
PinBtn.Size = UDim2.new(0, 20, 0, 20)
PinBtn.Text = "📌"
PinBtn.TextColor3 = THEME.SubText
PinBtn.TextSize = 12

-- Tabs
local TabFrame = Instance.new("Frame")
TabFrame.Parent = RightPanel
TabFrame.BackgroundTransparency = 1
TabFrame.Position = UDim2.new(0, 8, 0, 44)
TabFrame.Size = UDim2.new(1, -16, 0, 26)

local TabArgs = Instance.new("TextButton")
TabArgs.Parent = TabFrame
TabArgs.BackgroundColor3 = THEME.Background
TabArgs.Position = UDim2.new(0, 0, 0, 0)
TabArgs.Size = UDim2.new(0, 80, 1, 0)
TabArgs.Font = Enum.Font.GothamSemibold
TabArgs.Text = "  Arguments"
TabArgs.TextColor3 = THEME.Text
TabArgs.TextSize = 11
TabArgs.TextXAlignment = Enum.TextXAlignment.Left
TabArgs.AutoButtonColor = false

Instance.new("UICorner", TabArgs).CornerRadius = UDim.new(0, 4)

local TabCode = Instance.new("TextButton")
TabCode.Parent = TabFrame
TabCode.BackgroundTransparency = 1
TabCode.Position = UDim2.new(0, 85, 0, 0)
TabCode.Size = UDim2.new(0, 60, 1, 0)
TabCode.Font = Enum.Font.GothamSemibold
TabCode.Text = "<> Code"
TabCode.TextColor3 = THEME.SubText
TabArgs.TextSize = 11

local TabInfo = Instance.new("TextButton")
TabInfo.Parent = TabFrame
TabInfo.BackgroundTransparency = 1
TabInfo.Position = UDim2.new(0, 150, 0, 0)
TabInfo.Size = UDim2.new(0, 90, 1, 0)
TabInfo.Font = Enum.Font.GothamSemibold
TabInfo.Text = "ⓘ Function Info"
TabInfo.TextColor3 = THEME.SubText
TabInfo.TextSize = 11

-- Args Container - DISPLAY ONLY (like screenshot)
local ArgsContainer = Instance.new("ScrollingFrame")
ArgsContainer.Parent = RightPanel
ArgsContainer.BackgroundColor3 = THEME.Background
ArgsContainer.Position = UDim2.new(0, 8, 0, 76)
ArgsContainer.Size = UDim2.new(1, -16, 1, -130)
ArgsContainer.ScrollBarThickness = 3
ArgsContainer.ScrollBarImageColor3 = THEME.Accent
ArgsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

local ArgsLayout = Instance.new("UIListLayout")
ArgsLayout.Parent = ArgsContainer
ArgsLayout.Padding = UDim.new(0, 2)
ArgsLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Bottom Bar
local BottomBar = Instance.new("Frame")
BottomBar.Parent = RightPanel
BottomBar.BackgroundTransparency = 1
BottomBar.Position = UDim2.new(0, 8, 1, -48)
BottomBar.Size = UDim2.new(1, -16, 0, 40)

local CodeBtn = Instance.new("TextButton")
CodeBtn.Parent = BottomBar
CodeBtn.BackgroundColor3 = THEME.Background
CodeBtn.Position = UDim2.new(0, 0, 0, 0)
CodeBtn.Size = UDim2.new(0, 60, 1, 0)
CodeBtn.Font = Enum.Font.GothamSemibold
CodeBtn.Text = "<> Code"
CodeBtn.TextColor3 = THEME.SubText
CodeBtn.TextSize = 11

Instance.new("UICorner", CodeBtn).CornerRadius = UDim.new(0, 4)

local OriginBtn = Instance.new("TextButton")
OriginBtn.Parent = BottomBar
OriginBtn.BackgroundColor3 = THEME.Background
OriginBtn.Position = UDim2.new(0, 65, 0, 0)
OriginBtn.Size = UDim2.new(0, 70, 1, 0)
OriginBtn.Font = Enum.Font.GothamSemibold
OriginBtn.Text = "🔍 Origin"
OriginBtn.TextColor3 = THEME.SubText
OriginBtn.TextSize = 11

Instance.new("UICorner", OriginBtn).CornerRadius = UDim.new(0, 4)

local EventBtn = Instance.new("TextButton")
EventBtn.Parent = BottomBar
EventBtn.BackgroundColor3 = THEME.Background
EventBtn.Position = UDim2.new(0, 140, 0, 0)
EventBtn.Size = UDim2.new(0, 70, 1, 0)
EventBtn.Font = Enum.Font.GothamSemibold
EventBtn.Text = "📋 Event"
EventBtn.TextColor3 = THEME.SubText
EventBtn.TextSize = 11

Instance.new("UICorner", EventBtn).CornerRadius = UDim.new(0, 4)

-- REPLAY BUTTON
local ReplayBtn = Instance.new("TextButton")
ReplayBtn.Parent = BottomBar
ReplayBtn.BackgroundColor3 = THEME.Background
ReplayBtn.Position = UDim2.new(1, -85, 0, 0)
ReplayBtn.Size = UDim2.new(0, 85, 1, 0)
ReplayBtn.Font = Enum.Font.GothamBold
ReplayBtn.Text = "↻ Replay"
ReplayBtn.TextColor3 = THEME.Text
ReplayBtn.TextSize = 12

Instance.new("UICorner", ReplayBtn).CornerRadius = UDim.new(0, 6)

-- Success Message
local SuccessMsg = Instance.new("Frame")
SuccessMsg.Parent = RightPanel
SuccessMsg.BackgroundColor3 = THEME.Background
SuccessMsg.Position = UDim2.new(0, 8, 1, -22)
SuccessMsg.Size = UDim2.new(1, -16, 0, 20)
SuccessMsg.Visible = false

Instance.new("UICorner", SuccessMsg).CornerRadius = UDim.new(0, 4)

local SuccessText = Instance.new("TextLabel")
SuccessText.Parent = SuccessMsg
SuccessText.BackgroundTransparency = 1
SuccessText.Position = UDim2.new(0, 28, 0, 0)
SuccessText.Size = UDim2.new(1, -36, 1, 0)
SuccessText.Font = Enum.Font.Gotham
SuccessText.Text = "Replayed event successfully!"
SuccessText.TextColor3 = THEME.Success
SuccessText.TextSize = 11
SuccessText.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = THEME.Accent
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -20)
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "⚡"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 20
ToggleBtn.Visible = false
ToggleBtn.ZIndex = 100

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

-- DATA
local RemoteLogs = {}
local SelectedLog = nil
local LogCounter = 0
local NetFolder = nil

-- CREATE ARG ROW - DISPLAY ONLY (like screenshot)
local function CreateArgRow(index, value, valueType)
    local Row = Instance.new("Frame")
    Row.Parent = ArgsContainer
    Row.BackgroundTransparency = 1
    Row.Size = UDim2.new(1, 0, 0, 26)
    Row.LayoutOrder = index
    
    -- Index (1, 2, 3...)
    local IndexLabel = Instance.new("TextLabel")
    IndexLabel.Parent = Row
    IndexLabel.BackgroundTransparency = 1
    IndexLabel.Position = UDim2.new(0, 12, 0, 0)
    IndexLabel.Size = UDim2.new(0, 20, 1, 0)
    IndexLabel.Font = Enum.Font.GothamBold
    IndexLabel.Text = tostring(index)
    IndexLabel.TextColor3 = THEME.Text
    IndexLabel.TextSize = 12
    
    -- Value (the actual spy data) - YELLOW for numbers
    local ValueColor = THEME.Number
    if valueType == "string" then ValueColor = THEME.String
    elseif valueType == "boolean" then ValueColor = THEME.Boolean end
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Parent = Row
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Position = UDim2.new(0, 40, 0, 0)
    ValueLabel.Size = UDim2.new(0.55, -40, 1, 0)
    ValueLabel.Font = Enum.Font.GothamMono
    ValueLabel.Text = tostring(value)
    ValueLabel.TextColor3 = ValueColor
    ValueLabel.TextSize = 12
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Type (number, string, etc) - GRAY on right
    local TypeLabel = Instance.new("TextLabel")
    TypeLabel.Parent = Row
    TypeLabel.BackgroundTransparency = 1
    TypeLabel.Position = UDim2.new(0.6, 0, 0, 0)
    TypeLabel.Size = UDim2.new(0.4, -12, 1, 0)
    TypeLabel.Font = Enum.Font.Gotham
    TypeLabel.Text = valueType:lower()
    TypeLabel.TextColor3 = THEME.SubText
    TypeLabel.TextSize = 11
    TypeLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    return Row
end

local function CreateLogEntry(name, remote, method, args, timestamp)
    LogCounter = LogCounter + 1
    local logId = LogCounter
    
    local Entry = Instance.new("TextButton")
    Entry.Parent = RemoteList
    Entry.BackgroundColor3 = THEME.Background
    Entry.Size = UDim2.new(1, 0, 0, 28)
    Entry.LayoutOrder = -logId
    Entry.AutoButtonColor = false
    
    Instance.new("UICorner", Entry).CornerRadius = UDim.new(0, 4)
    
    -- RF/RE Indicator
    local isRF = string.find(name, "RF/") ~= nil
    local Indicator = Instance.new("Frame")
    Indicator.Parent = Entry
    Indicator.BackgroundColor3 = isRF and THEME.Accent or THEME.Success
    Indicator.BorderSizePixel = 0
    Indicator.Position = UDim2.new(0, 6, 0.5, -3)
    Indicator.Size = UDim2.new(0, 6, 0, 6)
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)
    
    -- Name
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Parent = Entry
    NameLabel.BackgroundTransparency = 1
    NameLabel.Position = UDim2.new(0, 18, 0, 0)
    NameLabel.Size = UDim2.new(1, -24, 1, 0)
    NameLabel.Font = Enum.Font.Gotham
    NameLabel.Text = name
    NameLabel.TextColor3 = THEME.Text
    NameLabel.TextSize = 11
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    
    -- Store data
    local logData = {
        Id = logId,
        Name = name,
        Remote = remote,
        Method = method,
        Args = args,
        Timestamp = timestamp or tick(),
        Entry = Entry
    }
    RemoteLogs[logId] = logData
    
    -- CLICK TO SHOW ARGS
    Entry.MouseButton1Click:Connect(function()
        if SelectedLog then
            SelectedLog.Entry.BackgroundColor3 = THEME.Background
        end
        
        SelectedLog = logData
        Entry.BackgroundColor3 = THEME.Accent
        
        -- Update header
        RemoteName.Text = name
        
        -- Clear old args
        for _, child in pairs(ArgsContainer:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        
        -- Show REAL args from spy
        for i, arg in ipairs(args) do
            CreateArgRow(i, arg, typeof(arg))
        end
        
        ArgsContainer.CanvasSize = UDim2.new(0, 0, 0, #args * 28)
        SuccessMsg.Visible = false
        
        print("📊 Showing args for:", name)
        for i, v in ipairs(args) do
            print("  ["..i.."]", v, "("..typeof(v)..")")
        end
    end)
    
    Entry.MouseEnter:Connect(function()
        if SelectedLog ~= logData then
            Entry.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
    end)
    
    Entry.MouseLeave:Connect(function()
        if SelectedLog ~= logData then
            Entry.BackgroundColor3 = THEME.Background
        end
    end)
    
    RemoteList.CanvasSize = UDim2.new(0, 0, 0, #RemoteList:GetChildren() * 31)
end

-- FIND NET FOLDER
local function FindNetFolder()
    local paths = {
        "Packages/_Index/sleitnick_net@0.2.0/net",
        "Packages/_Index/sleitnick_net@0.1.0/net",
        "Packages/_Index/sleitnick_net@0.3.0/net"
    }
    
    for _, path in ipairs(paths) do
        local current = ReplicatedStorage
        local found = true
        
        for _, name in ipairs(string.split(path, "/")) do
            current = current:FindFirstChild(name)
            if not current then
                found = false
                break
            end
        end
        
        if found then
            NetFolder = current
            print("✅ NetFolder:", path)
            return true
        end
    end
    
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj.Name == "net" and obj.Parent and string.find(obj.Parent.Name, "sleitnick") then
            NetFolder = obj
            print("✅ NetFolder (search):", obj:GetFullName())
            return true
        end
    end
    
    return false
end

-- HOOK REMOTE - CAPTURE REAL ARGS
local HookedRemotes = {}
local function HookRemote(remote, name)
    if not remote or HookedRemotes[remote] then return end
    HookedRemotes[remote] = true
    
    local method = remote:IsA("RemoteEvent") and "FireServer" or "InvokeServer"
    
    print("🔌 Hooking:", name, "-", method)
    
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if self == remote then
            local calledMethod = getnamecallmethod()
            if calledMethod == method then
                local args = {...}
                
                -- CAPTURE REAL ARGS HERE
                task.spawn(function()
                    print("🎣 CAPTURED:", name)
                    for i, v in ipairs(args) do
                        print("  Arg["..i.."]:", v, "| Type:", typeof(v))
                    end
                    CreateLogEntry(name, remote, method, args, tick())
                end)
            end
        end
        return oldNamecall(self, ...)
    end)
end

-- INITIALIZE
task.spawn(function()
    wait(1)
    
    if not FindNetFolder() then
        -- Demo mode with fake data
        print("⚠️ Demo mode - NetFolder not found")
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
        {name = "RF/PurchaseBait", path = "RF/PurchaseBait"}
    }
    
    for _, info in ipairs(remotes) do
        local remote = NetFolder:FindFirstChild(info.path)
        if remote then
            HookRemote(remote, info.name)
        else
            print("❌ Not found:", info.path)
        end
    end
    
    print("✅ All remotes hooked! Go fishing now!")
end)

-- REPLAY
ReplayBtn.MouseButton1Click:Connect(function()
    if not SelectedLog then
        RemoteName.Text = "Select a remote first!"
        return
    end
    
    if not SelectedLog.Remote then
        SuccessMsg.Visible = true
        SuccessText.Text = "Demo mode - no real remote"
        SuccessText.TextColor3 = THEME.Warning
        task.delay(2, function() SuccessMsg.Visible = false end)
        return
    end
    
    -- Replay with SAME args (no edit)
    local args = SelectedLog.Args
    
    local success, result = pcall(function()
        if SelectedLog.Remote:IsA("RemoteEvent") then
            SelectedLog.Remote:FireServer(unpack(args))
        else
            return SelectedLog.Remote:InvokeServer(unpack(args))
        end
    end)
    
    if success then
        SuccessMsg.Visible = true
        SuccessText.Text = "Replayed event successfully!"
        SuccessText.TextColor3 = THEME.Success
    else
        SuccessMsg.Visible = true
        SuccessText.Text = "Failed!"
        SuccessText.TextColor3 = THEME.Error
    end
    
    task.delay(3, function() SuccessMsg.Visible = false end)
end)

-- WINDOW CONTROLS
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleBtn.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleBtn.Visible = false
end)

-- DRAG
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
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- SEARCH
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(SearchBox.Text)
    for _, child in ipairs(RemoteList:GetChildren()) do
        if child:IsA("TextButton") then
            local label = child:FindFirstChildOfClass("TextLabel")
            if label then
                child.Visible = string.find(string.lower(label.Text), query) ~= nil
            end
        end
    end
end)

print("⚡ Cobalt V4 Loaded!")
print("🎣 Go fishing to see real args!")
