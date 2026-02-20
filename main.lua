-- Cobalt-style Remote Spy & Replay System
-- By: AI Assistant | Compatible with Roblox Executor

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// CONFIGURATION
local CONFIG = {
    MaxLogs = 100,
    Theme = {
        Background = Color3.fromRGB(25, 25, 30),
        Secondary = Color3.fromRGB(35, 35, 42),
        Accent = Color3.fromRGB(88, 101, 242), -- Discord blurple
        Text = Color3.fromRGB(220, 220, 220),
        SubText = Color3.fromRGB(150, 150, 150),
        Success = Color3.fromRGB(59, 165, 93),
        Warning = Color3.fromRGB(250, 168, 26),
        Error = Color3.fromRGB(237, 66, 69),
        Border = Color3.fromRGB(50, 50, 60)
    }
}

--// UTILITY FUNCTIONS
local function Create(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
    return instance
end

local function Tween(instance, properties, duration)
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad), properties)
    tween:Play()
    return tween
end

--// MAIN UI
local ScreenGui = Create("ScreenGui", {
    Name = "CobaltSpy",
    Parent = PlayerGui,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

local MainFrame = Create("Frame", {
    Name = "Main",
    Parent = ScreenGui,
    BackgroundColor3 = CONFIG.Theme.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, -400, 0.5, -250),
    Size = UDim2.new(0, 800, 0, 500),
    ClipsDescendants = true
})

-- Corner & Shadow
Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = MainFrame})
Create("UIStroke", {Color = CONFIG.Theme.Border, Thickness = 1, Parent = MainFrame})

-- Shadow
local Shadow = Create("ImageLabel", {
    Name = "Shadow",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, -20, 0, -20),
    Size = UDim2.new(1, 40, 1, 40),
    ZIndex = -1,
    Image = "rbxassetid://6015897843",
    ImageColor3 = Color3.new(0, 0, 0),
    ImageTransparency = 0.5,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(49, 49, 450, 450)
})

--// TITLE BAR
local TitleBar = Create("Frame", {
    Name = "TitleBar",
    Parent = MainFrame,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 40)
})

Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = TitleBar})

local TitleFix = Create("Frame", {
    Parent = TitleBar,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 1, -10),
    Size = UDim2.new(1, 0, 0, 10)
})

-- Logo & Title
local Logo = Create("ImageLabel", {
    Name = "Logo",
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 12, 0.5, -10),
    Size = UDim2.new(0, 20, 0, 20),
    Image = "rbxassetid://3926307971", -- Lightning bolt icon
    ImageRectOffset = Vector2.new(604, 324),
    ImageRectSize = Vector2.new(36, 36),
    ImageColor3 = CONFIG.Theme.Accent
})

local Title = Create("TextLabel", {
    Name = "Title",
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 40, 0, 0),
    Size = UDim2.new(0, 100, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "Cobalt",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Control Buttons
local MinimizeBtn = Create("TextButton", {
    Name = "Minimize",
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -80, 0, 0),
    Size = UDim2.new(0, 40, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "−",
    TextColor3 = CONFIG.Theme.SubText,
    TextSize = 20
})

local CloseBtn = Create("TextButton", {
    Name = "Close",
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -40, 0, 0),
    Size = UDim2.new(0, 40, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "×",
    TextColor3 = CONFIG.Theme.Error,
    TextSize = 20
})

--// CONTENT AREA
local Content = Create("Frame", {
    Name = "Content",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 40),
    Size = UDim2.new(1, 0, 1, -40)
})

--// LEFT PANEL (Remote List)
local LeftPanel = Create("Frame", {
    Name = "LeftPanel",
    Parent = Content,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(0, 250, 1, -20)
})

Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = LeftPanel})

local LeftTitle = Create("TextLabel", {
    Parent = LeftPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 8),
    Size = UDim2.new(1, -20, 0, 20),
    Font = Enum.Font.GothamSemibold,
    Text = "Remote Calls",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Search Box
local SearchBox = Create("TextBox", {
    Name = "Search",
    Parent = LeftPanel,
    BackgroundColor3 = CONFIG.Theme.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0, 35),
    Size = UDim2.new(1, -20, 0, 30),
    Font = Enum.Font.Gotham,
    PlaceholderText = "Search remotes...",
    PlaceholderColor3 = CONFIG.Theme.SubText,
    Text = "",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 12,
    ClearTextOnFocus = false
})

Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = SearchBox})

-- Remote List
local RemoteList = Create("ScrollingFrame", {
    Name = "RemoteList",
    Parent = LeftPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 75),
    Size = UDim2.new(1, -20, 1, -85),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = CONFIG.Theme.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0)
})

Create("UIListLayout", {
    Parent = RemoteList,
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
})

--// RIGHT PANEL (Details)
local RightPanel = Create("Frame", {
    Name = "RightPanel",
    Parent = Content,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 270, 0, 10),
    Size = UDim2.new(1, -280, 1, -20)
})

Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = RightPanel})

-- Tabs
local TabContainer = Create("Frame", {
    Name = "Tabs",
    Parent = RightPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(1, -20, 0, 35)
})

local TabLayout = Create("UIListLayout", {
    Parent = TabContainer,
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder
})

local Tabs = {}
local function CreateTab(name, icon)
    local TabBtn = Create("TextButton", {
        Name = name.."Tab",
        Parent = TabContainer,
        BackgroundColor3 = CONFIG.Theme.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 100, 1, 0),
        Font = Enum.Font.GothamSemibold,
        Text = "  "..name,
        TextColor3 = CONFIG.Theme.SubText,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false
    })
    
    local Icon = Create("ImageLabel", {
        Parent = TabBtn,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16),
        Image = icon,
        ImageColor3 = CONFIG.Theme.SubText
    })
    
    TabBtn.Text = "      "..name
    
    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = TabBtn})
    
    Tabs[name] = TabBtn
    return TabBtn
end

CreateTab("Arguments", "rbxassetid://3926305904") -- List icon
CreateTab("Code", "rbxassetid://3926307971") -- Code icon
CreateTab("Function Info", "rbxassetid://3926305904") -- Info icon

-- Tab Content Container
local TabContent = Create("Frame", {
    Name = "TabContent",
    Parent = RightPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 55),
    Size = UDim2.new(1, -20, 1, -65)
})

-- Arguments View (Default)
local ArgsView = Create("ScrollingFrame", {
    Name = "ArgsView",
    Parent = TabContent,
    BackgroundColor3 = CONFIG.Theme.Background,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, -50),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = CONFIG.Theme.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0)
})

Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ArgsView})
Create("UIPadding", {Parent = ArgsView, PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10)})

local ArgsLayout = Create("UIListLayout", {
    Parent = ArgsView,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
})

-- Action Buttons
local ActionBar = Create("Frame", {
    Name = "ActionBar",
    Parent = TabContent,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 1, -45),
    Size = UDim2.new(1, 0, 0, 40)
})

local ReplayBtn = Create("TextButton", {
    Name = "Replay",
    Parent = ActionBar,
    BackgroundColor3 = CONFIG.Theme.Accent,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0.32, 0, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "↻  Replay",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 12,
    AutoButtonColor = false
})

local CopyBtn = Create("TextButton", {
    Name = "Copy",
    Parent = ActionBar,
    BackgroundColor3 = CONFIG.Theme.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0.34, 0, 0, 0),
    Size = UDim2.new(0.32, 0, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "📋  Copy",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 12,
    AutoButtonColor = false
})

local ClearBtn = Create("TextButton", {
    Name = "Clear",
    Parent = ActionBar,
    BackgroundColor3 = CONFIG.Theme.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0.68, 0, 0, 0),
    Size = UDim2.new(0.32, 0, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "🗑  Clear",
    TextColor3 = CONFIG.Theme.Error,
    TextSize = 12,
    AutoButtonColor = false
})

for _, btn in pairs({ReplayBtn, CopyBtn, ClearBtn}) do
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = btn})
end

--// DATA STORAGE
local RemoteLogs = {}
local SelectedLog = nil
local LogIdCounter = 0

--// ARGUMENT INPUT COMPONENTS
local function CreateArgInput(parent, index, value, valueType)
    local Container = Create("Frame", {
        Name = "Arg"..index,
        Parent = parent,
        BackgroundColor3 = CONFIG.Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 60),
        LayoutOrder = index
    })
    
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Container})
    
    -- Index Label
    local IndexLabel = Create("TextLabel", {
        Parent = Container,
        BackgroundColor3 = CONFIG.Theme.Accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(0, 30, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = tostring(index),
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 12
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = IndexLabel})
    
    -- Type Label
    local TypeLabel = Create("TextLabel", {
        Parent = Container,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 50, 0, 10),
        Size = UDim2.new(0, 80, 0, 20),
        Font = Enum.Font.GothamSemibold,
        Text = valueType:lower(),
        TextColor3 = CONFIG.Theme.Warning,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Value Input
    local Input = Create("TextBox", {
        Parent = Container,
        BackgroundColor3 = CONFIG.Theme.Background,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 35),
        Size = UDim2.new(1, -20, 0, 25),
        Font = Enum.Font.GothamMono,
        Text = tostring(value),
        TextColor3 = CONFIG.Theme.Text,
        TextSize = 11,
        ClearTextOnFocus = false
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = Input})
    
    -- Store reference for replay
    Container:SetAttribute("OriginalValue", value)
    Container:SetAttribute("ValueType", valueType)
    Container:SetAttribute("Input", Input)
    
    return Container
end

--// REMOTE SPY LOGIC
local function GetTypeColor(value)
    local t = typeof(value)
    if t == "number" then return CONFIG.Theme.Warning, "number"
    elseif t == "string" then return CONFIG.Theme.Success, "string"
    elseif t == "boolean" then return CONFIG.Theme.Accent, "boolean"
    elseif t == "table" then return CONFIG.Theme.Text, "table"
    else return CONFIG.Theme.SubText, t end
end

local function FormatValue(value)
    local t = typeof(value)
    if t == "string" then return '"' .. value:sub(1, 50) .. (value:len() > 50 and "..." or "") .. '"'
    elseif t == "table" then return "{...}"
    else return tostring(value) end
end

local function CreateLogEntry(remote, method, args, scriptTrace)
    LogIdCounter = LogIdCounter + 1
    local logId = LogIdCounter
    
    local Entry = Create("TextButton", {
        Name = "Log_"..logId,
        Parent = RemoteList,
        BackgroundColor3 = CONFIG.Theme.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -10, 0, 50),
        Font = Enum.Font.Gotham,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = -logId -- Newest first
    })
    
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Entry})
    
    -- Remote Icon
    local isEvent = remote:IsA("RemoteEvent")
    local Icon = Create("ImageLabel", {
        Parent = Entry,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0.5, -10),
        Size = UDim2.new(0, 20, 0, 20),
        Image = isEvent and "rbxassetid://3926307971" or "rbxassetid://3926305904",
        ImageColor3 = isEvent and CONFIG.Theme.Success or CONFIG.Theme.Accent
    })
    
    -- Remote Name
    local NameLabel = Create("TextLabel", {
        Parent = Entry,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 40, 0, 8),
        Size = UDim2.new(1, -50, 0, 16),
        Font = Enum.Font.GothamSemibold,
        Text = remote.Name,
        TextColor3 = CONFIG.Theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    })
    
    -- Method & Args count
    local InfoLabel = Create("TextLabel", {
        Parent = Entry,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 40, 0, 26),
        Size = UDim2.new(1, -50, 0, 14),
        Font = Enum.Font.Gotham,
        Text = method .. " | " .. #args .. " args",
        TextColor3 = CONFIG.Theme.SubText,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Store log data
    local logData = {
        Id = logId,
        Remote = remote,
        Method = method,
        Args = args,
        Script = scriptTrace,
        Entry = Entry,
        ArgInputs = {}
    }
    RemoteLogs[logId] = logData
    
    -- Click to select
    Entry.MouseButton1Click:Connect(function()
        -- Deselect previous
        if SelectedLog then
            Tween(SelectedLog.Entry, {BackgroundColor3 = CONFIG.Theme.Background}, 0.1)
        end
        
        SelectedLog = logData
        Tween(Entry, {BackgroundColor3 = CONFIG.Theme.Accent}, 0.1)
        
        -- Update Args View
        for _, child in pairs(ArgsView:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        
        for i, arg in ipairs(args) do
            local color, t = GetTypeColor(arg)
            CreateArgInput(ArgsView, i, arg, t)
        end
        
        ArgsView.CanvasSize = UDim2.new(0, 0, 0, #args * 68)
    end)
    
    -- Hover effects
    Entry.MouseEnter:Connect(function()
        if SelectedLog ~= logData then
            Tween(Entry, {BackgroundColor3 = CONFIG.Theme.Secondary}, 0.1)
        end
    end)
    
    Entry.MouseLeave:Connect(function()
        if SelectedLog ~= logData then
            Tween(Entry, {BackgroundColor3 = CONFIG.Theme.Background}, 0.1)
        end
    end)
    
    -- Limit logs
    if #RemoteList:GetChildren() > CONFIG.MaxLogs then
        local oldest = nil
        for _, child in pairs(RemoteList:GetChildren()) do
            if child:IsA("TextButton") then
                local id = tonumber(child.Name:gsub("Log_", ""))
                if not oldest or id < oldest then oldest = id end
            end
        end
        if oldest and RemoteLogs[oldest] then
            RemoteLogs[oldest].Entry:Destroy()
            RemoteLogs[oldest] = nil
        end
    end
    
    RemoteList.CanvasSize = UDim2.new(0, 0, 0, #RemoteList:GetChildren() * 55)
end

--// HOOK REMOTES
local function HookRemote(remote)
    if remote:IsA("RemoteEvent") then
        local oldFireServer = remote.FireServer
        remote.FireServer = function(self, ...)
            if self == remote then
                local args = {...}
                local trace = debug.traceback():match("Script '([^']+)'")
                CreateLogEntry(remote, "FireServer", args, trace)
            end
            return oldFireServer(self, ...)
        end
        
        -- Hook OnClientEvent if needed
        -- (Optional: spy on incoming events)
        
    elseif remote:IsA("RemoteFunction") then
        local oldInvokeServer = remote.InvokeServer
        remote.InvokeServer = function(self, ...)
            if self == remote then
                local args = {...}
                local trace = debug.traceback():match("Script '([^']+)'")
                CreateLogEntry(remote, "InvokeServer", args, trace)
            end
            return oldInvokeServer(self, ...)
        end
    end
end

-- Initial hook
for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
    if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
        pcall(function() HookRemote(remote) end)
    end
end

-- Hook new remotes
ReplicatedStorage.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("RemoteEvent") or descendant:IsA("RemoteFunction") then
        wait(0.1) -- Wait for script to set up
        pcall(function() HookRemote(descendant) end)
    end
end)

--// BUTTON FUNCTIONS
ReplayBtn.MouseButton1Click:Connect(function()
    if not SelectedLog then return end
    
    -- Collect modified args
    local newArgs = {}
    for _, child in pairs(ArgsView:GetChildren()) do
        if child:IsA("Frame") then
            local input = child:FindFirstChildOfClass("TextBox")
            local t = child:GetAttribute("ValueType")
            local val = input.Text
            
            -- Convert type
            if t == "number" then val = tonumber(val) or 0
            elseif t == "boolean" then val = val:lower() == "true"
            elseif t == "string" then -- keep as is
            end
            
            table.insert(newArgs, val)
        end
    end
    
    -- Replay
    local success, err = pcall(function()
        if SelectedLog.Remote:IsA("RemoteEvent") then
            SelectedLog.Remote:FireServer(unpack(newArgs))
        else
            SelectedLog.Remote:InvokeServer(unpack(newArgs))
        end
    end)
    
    -- Visual feedback
    local originalText = ReplayBtn.Text
    if success then
        ReplayBtn.Text = "✓ Replayed!"
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Success
    else
        ReplayBtn.Text = "✗ Failed"
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Error
        warn("Replay error:", err)
    end
    
    wait(1.5)
    ReplayBtn.Text = originalText
    ReplayBtn.BackgroundColor3 = CONFIG.Theme.Accent
end)

CopyBtn.MouseButton1Click:Connect(function()
    if not SelectedLog then return end
    
    local code = string.format([[
-- Generated by Cobalt Spy
local remote = game:GetService("ReplicatedStorage"):WaitForChild("%s")

-- Original call: %s
remote:%s(%s)]], 
        SelectedLog.Remote:GetFullName(),
        SelectedLog.Method,
        SelectedLog.Method,
        table.concat(SelectedLog.Args, ", ")
    )
    
    -- Copy to clipboard (executor dependent)
    if setclipboard then
        setclipboard(code)
        CopyBtn.Text = "✓ Copied!"
    else
        CopyBtn.Text = "✗ No clipboard"
    end
    
    wait(1)
    CopyBtn.Text = "📋  Copy"
end)

ClearBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(RemoteList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, child in pairs(ArgsView:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    RemoteLogs = {}
    SelectedLog = nil
    RemoteList.CanvasSize = UDim2.new(0, 0, 0, 0)
end)

--// SEARCH FUNCTION
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = SearchBox.Text:lower()
    for _, child in pairs(RemoteList:GetChildren()) do
        if child:IsA("TextButton") then
            local name = child:FindFirstChildOfClass("TextLabel")
            if name then
                child.Visible = name.Text:lower():find(query) ~= nil
            end
        end
    end
end)

--// WINDOW CONTROLS
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Tween(MainFrame, {Size = UDim2.new(0, 800, 0, 40)}, 0.3)
        Content.Visible = false
    else
        Tween(MainFrame, {Size = UDim2.new(0, 800, 0, 500)}, 0.3)
        Content.Visible = true
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    Tween(MainFrame, {Position = UDim2.new(0.5, -400, 1.5, 0)}, 0.3)
    wait(0.3)
    ScreenGui:Destroy()
end)

--// DRAGGING
local dragging = false
local dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

--// ANIMATION ON START
MainFrame.Position = UDim2.new(0.5, -400, 1.5, 0)
Tween(MainFrame, {Position = UDim2.new(0.5, -400, 0.5, -250)}, 0.5)

print("✓ Cobalt Remote Spy loaded successfully!")
print("✓ Hooked into ReplicatedStorage remotes")
