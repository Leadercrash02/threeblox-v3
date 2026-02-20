-- Cobalt Mobile - Delta Executor Compatible
-- Optimized for Mobile UI & Touch

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// MOBILE CONFIG
local CONFIG = {
    MaxLogs = 50, -- Lebih sedikit untuk performa mobile
    Theme = {
        Background = Color3.fromRGB(20, 20, 25),
        Secondary = Color3.fromRGB(30, 30, 38),
        Accent = Color3.fromRGB(88, 101, 242),
        Text = Color3.fromRGB(240, 240, 240),
        SubText = Color3.fromRGB(150, 150, 150),
        Success = Color3.fromRGB(59, 165, 93),
        Warning = Color3.fromRGB(250, 168, 26),
        Error = Color3.fromRGB(237, 66, 69),
        Border = Color3.fromRGB(45, 45, 55)
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

--// SCREEN SETUP (Mobile Optimized)
local ScreenGui = Create("ScreenGui", {
    Name = "CobaltMobile",
    Parent = PlayerGui,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

-- Toggle Button (Floating)
local ToggleBtn = Create("TextButton", {
    Name = "Toggle",
    Parent = ScreenGui,
    BackgroundColor3 = CONFIG.Theme.Accent,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0.5, -25),
    Size = UDim2.new(0, 50, 0, 50),
    Text = "⚡",
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 24,
    ZIndex = 100
})

Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ToggleBtn})
Create("UIStroke", {Color = CONFIG.Theme.Border, Thickness = 2, Parent = ToggleBtn})

-- Shadow untuk Toggle
local ToggleShadow = Create("ImageLabel", {
    Parent = ToggleBtn,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, -5, 0, -5),
    Size = UDim2.new(1, 10, 1, 10),
    ZIndex = 99,
    Image = "rbxassetid://6015897843",
    ImageColor3 = Color3.new(0, 0, 0),
    ImageTransparency = 0.6,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(49, 49, 450, 450)
})

-- Main Frame (Full Screen untuk Mobile)
local MainFrame = Create("Frame", {
    Name = "Main",
    Parent = ScreenGui,
    BackgroundColor3 = CONFIG.Theme.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 1, 0), -- Start dari bawah
    Size = UDim2.new(1, 0, 1, 0),
    Visible = false
})

--// HEADER
local Header = Create("Frame", {
    Name = "Header",
    Parent = MainFrame,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 60)
})

local Title = Create("TextLabel", {
    Parent = Header,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 20, 0, 0),
    Size = UDim2.new(0, 200, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "⚡ Cobalt Mobile",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Close Button
local CloseBtn = Create("TextButton", {
    Parent = Header,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -60, 0, 0),
    Size = UDim2.new(0, 60, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "✕",
    TextColor3 = CONFIG.Theme.Error,
    TextSize = 24
})

-- Clear Button
local ClearBtn = Create("TextButton", {
    Parent = Header,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -120, 0, 0),
    Size = UDim2.new(0, 60, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "🗑",
    TextColor3 = CONFIG.Theme.SubText,
    TextSize = 20
})

--// CONTENT AREA
local Content = Create("Frame", {
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 60),
    Size = UDim2.new(1, 0, 1, -60)
})

--// LEFT: REMOTE LIST
local ListPanel = Create("Frame", {
    Parent = Content,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(0.45, -15, 1, -20)
})

Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = ListPanel})

local ListTitle = Create("TextLabel", {
    Parent = ListPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 10),
    Size = UDim2.new(1, -30, 0, 25),
    Font = Enum.Font.GothamBold,
    Text = "Remote Calls",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Search
local SearchBox = Create("TextBox", {
    Parent = ListPanel,
    BackgroundColor3 = CONFIG.Theme.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0, 40),
    Size = UDim2.new(1, -20, 0, 40),
    Font = Enum.Font.Gotham,
    PlaceholderText = "🔍 Search...",
    PlaceholderColor3 = CONFIG.Theme.SubText,
    Text = "",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 14
})

Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = SearchBox})

-- Remote List
local RemoteList = Create("ScrollingFrame", {
    Parent = ListPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 90),
    Size = UDim2.new(1, -20, 1, -100),
    ScrollBarThickness = 6,
    ScrollBarImageColor3 = CONFIG.Theme.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0)
})

Create("UIListLayout", {
    Parent = RemoteList,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
})

--// RIGHT: DETAILS & REPLAY
local DetailPanel = Create("Frame", {
    Parent = Content,
    BackgroundColor3 = CONFIG.Theme.Secondary,
    BorderSizePixel = 0,
    Position = UDim2.new(0.55, 0, 0, 10),
    Size = UDim2.new(0.45, -10, 1, -20)
})

Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = DetailPanel})

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

-- Args Container
local ArgsContainer = Create("ScrollingFrame", {
    Parent = DetailPanel,
    BackgroundColor3 = CONFIG.Theme.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0, 45),
    Size = UDim2.new(1, -20, 1, -140),
    ScrollBarThickness = 6,
    ScrollBarImageColor3 = CONFIG.Theme.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0)
})

Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = ArgsContainer})
Create("UIPadding", {
    Parent = ArgsContainer,
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10)
})

Create("UIListLayout", {
    Parent = ArgsContainer,
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder
})

-- Replay Button (Big for mobile)
local ReplayBtn = Create("TextButton", {
    Parent = DetailPanel,
    BackgroundColor3 = CONFIG.Theme.Accent,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 1, -80),
    Size = UDim2.new(1, -20, 0, 50),
    Font = Enum.Font.GothamBold,
    Text = "↻  REPLAY EVENT",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 16,
    AutoButtonColor = false
})

Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = ReplayBtn})

-- Copy Code Button
local CopyBtn = Create("TextButton", {
    Parent = DetailPanel,
    BackgroundColor3 = CONFIG.Theme.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 1, -25),
    Size = UDim2.new(1, -20, 0, 40),
    Font = Enum.Font.GothamSemibold,
    Text = "📋 Copy Code",
    TextColor3 = CONFIG.Theme.Text,
    TextSize = 14,
    AutoButtonColor = false
})

Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = CopyBtn})

--// DATA STORAGE
local RemoteLogs = {}
local SelectedLog = nil
local LogCounter = 0

--// CREATE ARG INPUT (Mobile Friendly)
local function CreateArgInput(index, value, valueType)
    local Frame = Create("Frame", {
        Parent = ArgsContainer,
        BackgroundColor3 = CONFIG.Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 80),
        LayoutOrder = index
    })
    
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = Frame})
    
    -- Index Badge
    local Badge = Create("TextLabel", {
        Parent = Frame,
        BackgroundColor3 = CONFIG.Theme.Accent,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(0, 35, 0, 25),
        Font = Enum.Font.GothamBold,
        Text = "#"..index,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 14
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Badge})
    
    -- Type Label
    local TypeLabel = Create("TextLabel", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 55, 0, 10),
        Size = UDim2.new(0, 100, 0, 25),
        Font = Enum.Font.GothamSemibold,
        Text = valueType:lower(),
        TextColor3 = CONFIG.Theme.Warning,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Value Input (Bigger for mobile)
    local Input = Create("TextBox", {
        Parent = Frame,
        BackgroundColor3 = CONFIG.Theme.Background,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 45),
        Size = UDim2.new(1, -20, 0, 35),
        Font = Enum.Font.GothamMono,
        Text = tostring(value),
        TextColor3 = CONFIG.Theme.Text,
        TextSize = 14,
        ClearTextOnFocus = false,
        TextWrapped = true
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Input})
    
    Frame:SetAttribute("Input", Input)
    Frame:SetAttribute("Type", valueType)
    
    return Frame
end

--// CREATE LOG ENTRY
local function CreateLogEntry(remote, method, args)
    LogCounter = LogCounter + 1
    local logId = LogCounter
    
    local Entry = Create("TextButton", {
        Parent = RemoteList,
        BackgroundColor3 = CONFIG.Theme.Background,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 70),
        LayoutOrder = -logId,
        AutoButtonColor = false
    })
    
    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = Entry})
    
    -- Icon
    local isEvent = remote:IsA("RemoteEvent")
    local Icon = Create("TextLabel", {
        Parent = Entry,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(0, 30, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = isEvent and "🟢" or "🔵",
        TextSize = 20
    })
    
    -- Name
    local NameLabel = Create("TextLabel", {
        Parent = Entry,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 50, 0, 10),
        Size = UDim2.new(1, -60, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = remote.Name,
        TextColor3 = CONFIG.Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    })
    
    -- Info
    local Info = Create("TextLabel", {
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
    
    -- Store data
    local logData = {
        Id = logId,
        Remote = remote,
        Method = method,
        Args = args,
        Entry = Entry
    }
    RemoteLogs[logId] = logData
    
    -- Click to select
    Entry.MouseButton1Click:Connect(function()
        -- Deselect previous
        if SelectedLog then
            SelectedLog.Entry.BackgroundColor3 = CONFIG.Theme.Background
        end
        
        SelectedLog = logData
        Entry.BackgroundColor3 = CONFIG.Theme.Accent
        
        -- Clear and rebuild args
        for _, child in pairs(ArgsContainer:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        
        for i, arg in ipairs(args) do
            local t = typeof(arg)
            CreateArgInput(i, arg, t)
        end
        
        ArgsContainer.CanvasSize = UDim2.new(0, 0, 0, #args * 90)
        DetailTitle.Text = remote.Name:sub(1, 20)
    end)
    
    -- Touch feedback
    Entry.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            Entry.BackgroundColor3 = CONFIG.Theme.Secondary
        end
    end)
    
    Entry.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            if SelectedLog ~= logData then
                Entry.BackgroundColor3 = CONFIG.Theme.Background
            end
        end
    end)
    
    -- Limit logs
    if #RemoteList:GetChildren() > CONFIG.MaxLogs then
        local oldest = nil
        for _, child in pairs(RemoteList:GetChildren()) do
            if child:IsA("TextButton") then
                local id = tonumber(child.LayoutOrder) * -1
                if not oldest or id < oldest then oldest = id end
            end
        end
        if oldest and RemoteLogs[oldest] then
            RemoteLogs[oldest].Entry:Destroy()
            RemoteLogs[oldest] = nil
        end
    end
    
    RemoteList.CanvasSize = UDim2.new(0, 0, 0, #RemoteList:GetChildren() * 78)
end

--// HOOK REMOTES (Delta Compatible)
local function HookRemote(remote)
    if remote:IsA("RemoteEvent") then
        local oldFireServer = remote.FireServer
        remote.FireServer = function(self, ...)
            if self == remote then
                local args = {...}
                CreateLogEntry(remote, "FireServer", args)
            end
            return oldFireServer(self, ...)
        end
        
    elseif remote:IsA("RemoteFunction") then
        local oldInvokeServer = remote.InvokeServer
        remote.InvokeServer = function(self, ...)
            if self == remote then
                local args = {...}
                CreateLogEntry(remote, "InvokeServer", args)
            end
            return oldInvokeServer(self, ...)
        end
    end
end

-- Hook existing
for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        pcall(function() HookRemote(obj) end)
    end
end

-- Hook new
ReplicatedStorage.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("RemoteEvent") or descendant:IsA("RemoteFunction") then
        wait(0.5)
        pcall(function() HookRemote(descendant) end)
    end
end)

--// BUTTON FUNCTIONS

-- Toggle UI
local uiVisible = false
ToggleBtn.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    MainFrame.Visible = true
    
    if uiVisible then
        -- Slide up
        MainFrame:TweenPosition(
            UDim2.new(0, 0, 0, 0),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.3,
            true
        )
        ToggleBtn.Text = "✕"
        ToggleBtn.BackgroundColor3 = CONFIG.Theme.Error
    else
        -- Slide down
        MainFrame:TweenPosition(
            UDim2.new(0, 0, 1, 0),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.3,
            true
        )
        ToggleBtn.Text = "⚡"
        ToggleBtn.BackgroundColor3 = CONFIG.Theme.Accent
        wait(0.3)
        MainFrame.Visible = false
    end
end)

-- Close
CloseBtn.MouseButton1Click:Connect(function()
    uiVisible = false
    MainFrame:TweenPosition(
        UDim2.new(0, 0, 1, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.3,
        true
    )
    ToggleBtn.Text = "⚡"
    ToggleBtn.BackgroundColor3 = CONFIG.Theme.Accent
    wait(0.3)
    MainFrame.Visible = false
end)

-- Clear
ClearBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(RemoteList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, child in pairs(ArgsContainer:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    RemoteLogs = {}
    SelectedLog = nil
    RemoteList.CanvasSize = UDim2.new(0, 0, 0, 0)
    DetailTitle.Text = "Arguments"
end)

-- Replay
ReplayBtn.MouseButton1Click:Connect(function()
    if not SelectedLog then
        ReplayBtn.Text = "❌ Select Log First!"
        wait(1)
        ReplayBtn.Text = "↻  REPLAY EVENT"
        return
    end
    
    -- Collect args
    local newArgs = {}
    for _, child in pairs(ArgsContainer:GetChildren()) do
        if child:IsA("Frame") then
            local input = child:GetAttribute("Input")
            local t = child:GetAttribute("Type")
            local val = input.Text
            
            -- Convert
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
        ReplayBtn.Text = "✅ Replay Success!"
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Success
    else
        ReplayBtn.Text = "❌ Failed: " .. tostring(result):sub(1, 20)
        ReplayBtn.BackgroundColor3 = CONFIG.Theme.Error
    end
    
    wait(1.5)
    ReplayBtn.Text = "↻  REPLAY EVENT"
    ReplayBtn.BackgroundColor3 = CONFIG.Theme.Accent
end)

-- Copy
CopyBtn.MouseButton1Click:Connect(function()
    if not SelectedLog then return end
    
    local code = string.format([[
-- Cobalt Generated
local remote = game:GetService("ReplicatedStorage"):WaitForChild("%s")
remote:%s(%s)]],
        SelectedLog.Remote.Name,
        SelectedLog.Method,
        table.concat(SelectedLog.Args, ", ")
    )
    
    -- Delta Mobile clipboard
    if setclipboard then
        setclipboard(code)
        CopyBtn.Text = "✅ Copied!"
    else
        -- Fallback: print ke console
        print("=== COPY THIS CODE ===")
        print(code)
        print("======================")
        CopyBtn.Text = "📋 Check Console!"
    end
    
    wait(1.5)
    CopyBtn.Text = "📋 Copy Code"
end)

-- Search
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

-- Touch drag untuk toggle button
local dragging = false
local dragStart, startPos

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position
    end
end)

ToggleBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        ToggleBtn.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Init animation
ToggleBtn.Position = UDim2.new(0, -60, 0.5, -25)
ToggleBtn:TweenPosition(
    UDim2.new(0, 10, 0.5, -25),
    Enum.EasingDirection.Out,
    Enum.EasingStyle.Back,
    0.5,
    true
)

print("⚡ Cobalt Mobile loaded!")
print("✅ Delta Executor compatible")
print("👆 Tap ⚡ button to open")
