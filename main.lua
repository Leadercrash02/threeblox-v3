-- Cobalt Replica - Fixed Version
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- THEME
local THEME = {
    Background = Color3.fromRGB(25, 25, 30),
    Secondary = Color3.fromRGB(35, 35, 42),
    Accent = Color3.fromRGB(88, 101, 242),
    Text = Color3.fromRGB(220, 220, 220),
    SubText = Color3.fromRGB(150, 150, 150),
    Number = Color3.fromRGB(250, 168, 26),
    String = Color3.fromRGB(59, 165, 93),
    Success = Color3.fromRGB(59, 165, 93),
    Error = Color3.fromRGB(237, 66, 69),
    Border = Color3.fromRGB(50, 50, 60)
}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CobaltReplica"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -200)
MainFrame.Size = UDim2.new(0, 700, 0, 400)

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = THEME.Secondary
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 35)

local TitleFix = Instance.new("Frame")
TitleFix.Parent = TitleBar
TitleFix.BackgroundColor3 = THEME.Secondary
TitleFix.BorderSizePixel = 0
TitleFix.Position = UDim2.new(0, 0, 1, -10)
TitleFix.Size = UDim2.new(1, 0, 0, 10)

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 40, 0, 0)
TitleText.Size = UDim2.new(0, 100, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "Cobalt"
TitleText.TextColor3 = THEME.Text
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Left Panel
local LeftPanel = Instance.new("Frame")
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = THEME.Secondary
LeftPanel.BorderSizePixel = 0
LeftPanel.Position = UDim2.new(0, 10, 0, 45)
LeftPanel.Size = UDim2.new(0, 200, 1, -55)

Instance.new("UICorner", LeftPanel).CornerRadius = UDim.new(0, 6)

-- Search
local SearchBox = Instance.new("TextBox")
SearchBox.Parent = LeftPanel
SearchBox.BackgroundColor3 = THEME.Background
SearchBox.BorderSizePixel = 0
SearchBox.Position = UDim2.new(0, 10, 0, 10)
SearchBox.Size = UDim2.new(1, -20, 0, 28)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "Search..."
SearchBox.PlaceholderColor3 = THEME.SubText
SearchBox.Text = ""
SearchBox.TextColor3 = THEME.Text
SearchBox.TextSize = 12

Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 4)

-- Remote List
local RemoteList = Instance.new("ScrollingFrame")
RemoteList.Parent = LeftPanel
RemoteList.BackgroundTransparency = 1
RemoteList.Position = UDim2.new(0, 10, 0, 48)
RemoteList.Size = UDim2.new(1, -20, 1, -58)
RemoteList.ScrollBarThickness = 4
RemoteList.ScrollBarImageColor3 = THEME.Accent
RemoteList.CanvasSize = UDim2.new(0, 0, 0, 0)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = RemoteList
ListLayout.Padding = UDim.new(0, 4)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Right Panel
local RightPanel = Instance.new("Frame")
RightPanel.Parent = MainFrame
RightPanel.BackgroundColor3 = THEME.Secondary
RightPanel.BorderSizePixel = 0
RightPanel.Position = UDim2.new(0, 220, 0, 45)
RightPanel.Size = UDim2.new(1, -230, 1, -55)

Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 6)

-- Remote Header
local RemoteHeader = Instance.new("Frame")
RemoteHeader.Parent = RightPanel
RemoteHeader.BackgroundColor3 = THEME.Background
RemoteHeader.BorderSizePixel = 0
RemoteHeader.Position = UDim2.new(0, 10, 0, 10)
RemoteHeader.Size = UDim2.new(1, -20, 0, 35)

Instance.new("UICorner", RemoteHeader).CornerRadius = UDim.new(0, 6)

local RemoteNameLabel = Instance.new("TextLabel")
RemoteNameLabel.Parent = RemoteHeader
RemoteNameLabel.BackgroundTransparency = 1
RemoteNameLabel.Position = UDim2.new(0, 10, 0, 0)
RemoteNameLabel.Size = UDim2.new(1, -20, 1, 0)
RemoteNameLabel.Font = Enum.Font.GothamSemibold
RemoteNameLabel.Text = "Select a remote..."
RemoteNameLabel.TextColor3 = THEME.Text
RemoteNameLabel.TextSize = 13
RemoteNameLabel.TextXAlignment = Enum.TextXAlignment.Left
RemoteNameLabel.TextTruncate = Enum.TextTruncate.AtEnd

-- Tabs
local TabContainer = Instance.new("Frame")
TabContainer.Parent = RightPanel
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 10, 0, 55)
TabContainer.Size = UDim2.new(1, -20, 0, 30)

local TabArgs = Instance.new("TextButton")
TabArgs.Parent = TabContainer
TabArgs.BackgroundColor3 = THEME.Background
TabArgs.BorderSizePixel = 0
TabArgs.Position = UDim2.new(0, 0, 0, 0)
TabArgs.Size = UDim2.new(0, 90, 1, 0)
TabArgs.Font = Enum.Font.GothamSemibold
TabArgs.Text = "  Arguments"
TabArgs.TextColor3 = THEME.Text
TabArgs.TextSize = 12
TabArgs.TextXAlignment = Enum.TextXAlignment.Left
TabArgs.AutoButtonColor = false

Instance.new("UICorner", TabArgs).CornerRadius = UDim.new(0, 4)

-- Args Container
local ArgsContainer = Instance.new("ScrollingFrame")
ArgsContainer.Parent = RightPanel
ArgsContainer.BackgroundColor3 = THEME.Background
ArgsContainer.BorderSizePixel = 0
ArgsContainer.Position = UDim2.new(0, 10, 0, 95)
ArgsContainer.Size = UDim2.new(1, -20, 1, -160)
ArgsContainer.ScrollBarThickness = 4
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
BottomBar.Position = UDim2.new(0, 10, 1, -55)
BottomBar.Size = UDim2.new(1, -20, 0, 50)

local ReplayBtn = Instance.new("TextButton")
ReplayBtn.Parent = BottomBar
ReplayBtn.BackgroundColor3 = THEME.Background
ReplayBtn.BorderSizePixel = 0
ReplayBtn.Position = UDim2.new(1, -110, 0, 0)
ReplayBtn.Size = UDim2.new(0, 110, 1, 0)
ReplayBtn.Font = Enum.Font.GothamBold
ReplayBtn.Text = "↻ Replay"
ReplayBtn.TextColor3 = THEME.Text
ReplayBtn.TextSize = 13
ReplayBtn.AutoButtonColor = false

Instance.new("UICorner", ReplayBtn).CornerRadius = UDim.new(0, 6)

-- Success Notification
local SuccessNotif = Instance.new("Frame")
SuccessNotif.Parent = RightPanel
SuccessNotif.BackgroundColor3 = THEME.Background
SuccessNotif.BorderSizePixel = 0
SuccessNotif.Position = UDim2.new(0, 10, 1, -25)
SuccessNotif.Size = UDim2.new(1, -20, 0, 25)
SuccessNotif.Visible = false

Instance.new("UICorner", SuccessNotif).CornerRadius = UDim.new(0, 4)

local SuccessText = Instance.new("TextLabel")
SuccessText.Parent = SuccessNotif
SuccessText.BackgroundTransparency = 1
SuccessText.Position = UDim2.new(0, 10, 0, 0)
SuccessText.Size = UDim2.new(1, -20, 1, 0)
SuccessText.Font = Enum.Font.Gotham
SuccessText.Text = "Replayed event successfully!"
SuccessText.TextColor3 = THEME.Success
SuccessText.TextSize = 12
SuccessText.TextXAlignment = Enum.TextXAlignment.Left

-- DATA
local RemoteLogs = {}
local SelectedLog = nil
local LogCounter = 0
local NetFolder = nil

-- FUNCTIONS
local function CreateArgRow(index, value, valueType)
    local Row = Instance.new("Frame")
    Row.Parent = ArgsContainer
    Row.BackgroundTransparency = 1
    Row.Size = UDim2.new(1, 0, 0, 28)
    Row.LayoutOrder = index
    
    local IndexLabel = Instance.new("TextLabel")
    IndexLabel.Parent = Row
    IndexLabel.BackgroundTransparency = 1
    IndexLabel.Position = UDim2.new(0, 10, 0, 0)
    IndexLabel.Size = UDim2.new(0, 25, 1, 0)
    IndexLabel.Font = Enum.Font.GothamBold
    IndexLabel.Text = tostring(index)
    IndexLabel.TextColor3 = THEME.Text
    IndexLabel.TextSize = 13
    IndexLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ValueColor = THEME.Number
    if valueType == "string" then ValueColor = THEME.String end
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Parent = Row
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Position = UDim2.new(0, 35, 0, 0)
    ValueLabel.Size = UDim2.new(0.6, -35, 1, 0)
    ValueLabel.Font = Enum.Font.GothamMono
    ValueLabel.Text = tostring(value)
    ValueLabel.TextColor3 = ValueColor
    ValueLabel.TextSize = 13
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local TypeLabel = Instance.new("TextLabel")
    TypeLabel.Parent = Row
    TypeLabel.BackgroundTransparency = 1
    TypeLabel.Position = UDim2.new(0.65, 0, 0, 0)
    TypeLabel.Size = UDim2.new(0.35, -10, 1, 0)
    TypeLabel.Font = Enum.Font.Gotham
    TypeLabel.Text = valueType:lower()
    TypeLabel.TextColor3 = THEME.SubText
    TypeLabel.TextSize = 12
    TypeLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    return Row
end

local function CreateLogEntry(name, remote, method, args)
    LogCounter = LogCounter + 1
    local logId = LogCounter
    
    local Entry = Instance.new("TextButton")
    Entry.Parent = RemoteList
    Entry.BackgroundColor3 = THEME.Background
    Entry.BorderSizePixel = 0
    Entry.Size = UDim2.new(1, 0, 0, 32)
    Entry.LayoutOrder = -logId
    Entry.AutoButtonColor = false
    
    Instance.new("UICorner", Entry).CornerRadius = UDim.new(0, 4)
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Parent = Entry
    NameLabel.BackgroundTransparency = 1
    NameLabel.Position = UDim2.new(0, 10, 0, 0)
    NameLabel.Size = UDim2.new(1, -20, 1, 0)
    NameLabel.Font = Enum.Font.Gotham
    NameLabel.Text = name
    NameLabel.TextColor3 = THEME.Text
    NameLabel.TextSize = 12
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    
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
            SelectedLog.Entry.BackgroundColor3 = THEME.Background
        end
        
        SelectedLog = logData
        Entry.BackgroundColor3 = THEME.Accent
        
        RemoteNameLabel.Text = name
        
        for _, child in pairs(ArgsContainer:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        
        for i, arg in ipairs(args) do
            CreateArgRow(i, arg, typeof(arg))
        end
        
        ArgsContainer.CanvasSize = UDim2.new(0, 0, 0, #args * 30)
        SuccessNotif.Visible = false
    end)
    
    Entry.MouseEnter:Connect(function()
        if SelectedLog ~= logData then
            Entry.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        end
    end)
    
    Entry.MouseLeave:Connect(function()
        if SelectedLog ~= logData then
            Entry.BackgroundColor3 = THEME.Background
        end
    end)
    
    RemoteList.CanvasSize = UDim2.new(0, 0, 0, #RemoteList:GetChildren() * 36)
end

-- FIND NET FOLDER
local function FindNetFolder()
    local paths = {
        "Packages/_Index/sleitnick_net@0.2.0/net",
        "Packages/_Index/sleitnick_net@0.1.0/net", 
        "Packages/_Index/sleitnick_net@0.3.0/net"
    }
    
    for _, path in pairs(paths) do
        local current = ReplicatedStorage
        local found = true
        
        for _, name in pairs(string.split(path, "/")) do
            current = current:FindFirstChild(name)
            if not current then
                found = false
                break
            end
        end
        
        if found then
            NetFolder = current
            return true
        end
    end
    
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj.Name == "net" and obj.Parent and string.find(obj.Parent.Name, "sleitnick") then
            if obj:FindFirstChild("RF") or obj:FindFirstChild("RE") then
                NetFolder = obj
                return true
            end
        end
    end
    
    return false
end

-- HOOK
local function HookRemote(remote, name)
    if not remote then return end
    
    local method = remote:IsA("RemoteEvent") and "FireServer" or "InvokeServer"
    
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
end

-- INIT
task.spawn(function()
    wait(1)
    
    -- Sample data for testing
    CreateLogEntry("RF/RequestFishingMinigameStarted", nil, "InvokeServer", {-1.233, 1000, 1771160142.806})
    CreateLogEntry("RF/CancelFishingInputs", nil, "InvokeServer", {})
    CreateLogEntry("RE/EquipToolFromHotbar", nil, "FireServer", {1})
    
    if not FindNetFolder() then return end
    
    local remotes = {
        {name = "RF/CatchFishCompleted", path = "RF/CatchFishCompleted"},
        {name = "RF/SellAllItems", path = "RF/SellAllItems"},
        {name = "RF/ChargeFishingRod", path = "RF/ChargeFishingRod"},
        {name = "RF/RequestFishingMinigameStarted", path = "RF/RequestFishingMinigameStarted"},
        {name = "RF/CancelFishingInputs", path = "RF/CancelFishingInputs"},
        {name = "RE/EquipToolFromHotbar", path = "RE/EquipToolFromHotbar"},
        {name = "RE/UnequipToolFromHotbar", path = "RE/UnequipToolFromHotbar"}
    }
    
    for _, info in pairs(remotes) do
        local remote = NetFolder:FindFirstChild(info.path)
        if remote then
            HookRemote(remote, info.name)
        end
    end
end)

-- REPLAY
ReplayBtn.MouseButton1Click:Connect(function()
    if not SelectedLog then
        RemoteNameLabel.Text = "Select a remote first!"
        return
    end
    
    if not SelectedLog.Remote then
        RemoteNameLabel.Text = "Remote not available!"
        return
    end
    
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
    else
        SuccessNotif.Visible = true
        SuccessText.Text = "Failed!"
        SuccessText.TextColor3 = THEME.Error
    end
    
    task.delay(3, function()
        SuccessNotif.Visible = false
    end)
end)

-- SEARCH
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(SearchBox.Text)
    for _, child in pairs(RemoteList:GetChildren()) do
        if child:IsA("TextButton") then
            local nameLabel = child:FindFirstChildOfClass("TextLabel")
            if nameLabel then
                child.Visible = string.find(string.lower(nameLabel.Text), query) ~= nil
            end
        end
    end
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

print("Cobalt Replica loaded!")
