--==================================================
-- SERVICES & PLAYER
--==================================================
local Players, UIS, CoreGui = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

--==================================================
-- MODULES & NET
--==================================================
local Items = require(ReplicatedStorage.Items)
local Replion = require(ReplicatedStorage.Packages.Replion)
local Net = require(ReplicatedStorage.Packages.Net)

--==================================================
-- THEME
--==================================================
local THEME = {
    MAIN = Color3.fromRGB(160, 90, 255),
    TEXT = Color3.fromRGB(235, 220, 255),
    GLASS = Color3.fromRGB(0, 0, 0),
    MUTED = Color3.fromRGB(70, 70, 80),
    CARD = Color3.fromRGB(25, 25, 35),
    ACCENT = Color3.fromRGB(140, 101, 255),
    CLOSE = Color3.fromRGB(255, 120, 180)
}
local LOGO_ID = "rbxassetid://121625492591707"

--==================================================
-- SCREEN GUI + MAIN UI
--==================================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "ThreebloxHUB"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

-- Loading Screen
local Loading = Instance.new("Frame", Gui)
Loading.Size = UDim2.new(1, 0, 1, 0)
Loading.BackgroundColor3 = THEME.GLASS
Loading.BackgroundTransparency = 0.35

local LoadText = Instance.new("TextLabel", Loading)
LoadText.Size = UDim2.new(1, 0, 1, 0)
LoadText.BackgroundTransparency = 1
LoadText.Text = "Loading ThreebloxHUB..."
LoadText.Font = Enum.Font.GothamBold
LoadText.TextSize = 18
LoadText.TextColor3 = THEME.MAIN

task.wait(1)
Loading:Destroy()

-- Main Frame
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 460, 0, 280)
Main.Position = UDim2.new(0.5, -230, 0.5, -140)
Main.BackgroundColor3 = THEME.GLASS
Main.BackgroundTransparency = 0.45
Main.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = THEME.MAIN
MainStroke.Transparency = 0.45

-- Title Bar
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = THEME.GLASS
TitleBar.BackgroundTransparency = 0.4
TitleBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ThreebloxHUB | discord.gg/Threebloxhub"
Title.Font = Enum.Font.GothamMedium
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = THEME.MAIN

-- Window Controls
local function CreateControlButton(parent, text, pos, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 28, 0, 28)
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.Position = pos
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = text == "–" and 20 or 16
    btn.TextYAlignment = Enum.TextYAlignment.Center
    btn.TextColor3 = color or THEME.TEXT
    btn.BackgroundTransparency = 1
    return btn
end

local Min = CreateControlButton(TitleBar, "–", UDim2.new(1, -56, 0.5, 0))
local Close = CreateControlButton(TitleBar, "X", UDim2.new(1, -28, 0.5, 0), THEME.CLOSE)

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Position = UDim2.new(0, 6, 0, 40)
Sidebar.Size = UDim2.new(0, 120, 1, -46)
Sidebar.BackgroundColor3 = THEME.GLASS
Sidebar.BackgroundTransparency = 0.6
Sidebar.BorderSizePixel = 0

Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
local SideStroke = Instance.new("UIStroke", Sidebar)
SideStroke.Color = THEME.MAIN
SideStroke.Transparency = 0.7

local SideScroll = Instance.new("ScrollingFrame", Sidebar)
SideScroll.Size = UDim2.new(1, -4, 1, -4)
SideScroll.Position = UDim2.new(0, 2, 0, 2)
SideScroll.BackgroundTransparency = 1
SideScroll.BorderSizePixel = 0
SideScroll.ScrollBarThickness = 3
SideScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SideScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SideScroll.ScrollBarImageColor3 = THEME.MAIN

local SideList = Instance.new("UIListLayout", SideScroll)
SideList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideList.VerticalAlignment = Enum.VerticalAlignment.Top
SideList.SortOrder = Enum.SortOrder.LayoutOrder
SideList.Padding = UDim.new(0, 4)

-- Content Area
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 130, 0, 40)
Content.Size = UDim2.new(1, -140, 1, -50)
Content.BackgroundColor3 = THEME.GLASS
Content.BackgroundTransparency = 0.65
Content.BorderSizePixel = 0

Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 10)
local ContentStroke = Instance.new("UIStroke", Content)
ContentStroke.Color = THEME.MAIN
ContentStroke.Transparency = 0.6

-- Drag Functionality
do
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = i.Position
            startPos = Main.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function() dragging = false end)
end

-- Minimize Logo
local MiniLogo = Instance.new("ImageButton", Gui)
MiniLogo.Size = UDim2.new(0, 52, 0, 52)
MiniLogo.Position = UDim2.new(0, 20, 0.5, -26)
MiniLogo.Image = LOGO_ID
MiniLogo.BackgroundTransparency = 1
MiniLogo.Visible = false
MiniLogo.AutoButtonColor = false

-- Logo Drag & Click
do
    local dragging, dragStart, startPos, moved
    MiniLogo.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            moved = false
            dragStart = i.Position
            startPos = MiniLogo.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging then
            local delta = i.Position - dragStart
            if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then moved = true end
            MiniLogo.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function()
        if dragging then
            dragging = false
            if not moved then
                Main.Visible = true
                MiniLogo.Visible = false
            end
        end
    end)
end

Min.MouseButton1Click:Connect(function()
    Main.Visible = false
    MiniLogo.Visible = true
end)

Close.MouseButton1Click:Connect(function() Gui:Destroy() end)

-- Notification
local Notify = Instance.new("Frame", Gui)
Notify.Size = UDim2.new(0, 280, 0, 60)
Notify.Position = UDim2.new(1, -300, 1, -80)
Notify.BackgroundColor3 = THEME.GLASS
Notify.BackgroundTransparency = 0.35
Notify.BorderSizePixel = 0

Instance.new("UICorner", Notify).CornerRadius = UDim.new(0, 12)
local NotifyStroke = Instance.new("UIStroke", Notify)
NotifyStroke.Color = THEME.MAIN

local NLogo = Instance.new("ImageLabel", Notify)
NLogo.Size = UDim2.new(0, 36, 0, 36)
NLogo.Position = UDim2.new(0, 12, 0.5, -18)
NLogo.BackgroundTransparency = 1
NLogo.Image = LOGO_ID

local NText = Instance.new("TextLabel", Notify)
NText.Size = UDim2.new(1, -60, 1, 0)
NText.Position = UDim2.new(0, 56, 0, 0)
NText.BackgroundTransparency = 1
NText.Text = "Script Loaded Successfully"
NText.Font = Enum.Font.GothamBold
NText.TextSize = 14
NText.TextXAlignment = Enum.TextXAlignment.Left
NText.TextColor3 = THEME.MAIN

task.delay(2.5, function() if Notify then Notify:Destroy() end end)

--==================================================
-- NET EVENTS
--==================================================
local NetFolder = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")

local Events = {
    catch = NetFolder:WaitForChild("RF/CatchFishCompleted"),
    sell = NetFolder:WaitForChild("RF/SellAllItems"),
    charge = NetFolder:WaitForChild("RF/ChargeFishingRod"),
    minigame = NetFolder:WaitForChild("RF/RequestFishingMinigameStarted"),
    cancel = NetFolder:WaitForChild("RF/CancelFishingInputs"),
    equip = NetFolder:WaitForChild("RE/EquipToolFromHotbar"),
    unequip = NetFolder:WaitForChild("RE/UnequipToolFromHotbar"),
    purchaseWeather = NetFolder:WaitForChild("RF/PurchaseWeatherEvent"),
    purchaseRod = NetFolder:WaitForChild("RF/PurchaseFishingRod"),
    purchaseBait = NetFolder:WaitForChild("RF/PurchaseBait"),
    updateSellThreshold = NetFolder:WaitForChild("RF/UpdateAutoSellThreshold"),
    UpdateAutoFishing = NetFolder:WaitForChild("RF/UpdateAutoFishingState"),
}

--==================================================
-- FISHING ENGINE STATE
--==================================================
_G.RAY_AutoFishAFK = _G.RAY_AutoFishAFK or false
_G.RAY_LegitPerfect = _G.RAY_LegitPerfect or false
_G.RAY_DelayReel = _G.RAY_DelayReel or 0.3
_G.RAY_DelayCatch = _G.RAY_DelayCatch or 0.3
_G.RAY_LegitDelayReel = _G.RAY_LegitDelayReel or 0.25
_G.RAY_LegitDelayCatch = _G.RAY_LegitDelayCatch or 0.25

local isFishingAFK, isFishingLegit = false, false

--==================================================
-- FISHING FUNCTIONS
--==================================================
local function CompleteFish()
    pcall(function()
        if Events.catch then Events.catch:InvokeServer() end
    end)
end

local function CastRod(power, factor)
    pcall(function()
        if not (Events.minigame and Events.charge) then return end
        
        if Events.equip then Events.equip:FireServer(1) end
        Events.charge:InvokeServer()
        
        Events.minigame:InvokeServer(
            power or 3.376763343811035,
            factor or 0.623453255714559,
            Workspace:GetServerTimeNow()
        )
    end)
end

local function EngineAFK()
    if isFishingAFK or not _G.RAY_AutoFishAFK then return end
    isFishingAFK = true
    
    CastRod()
    task.wait(_G.RAY_DelayReel)
    CompleteFish()
    task.wait(_G.RAY_DelayCatch)
    
    isFishingAFK = false
end

local function EngineLegit()
    if isFishingLegit or not _G.RAY_LegitPerfect then return end
    isFishingLegit = true
    
    CastRod(3.376763343811035, 0.623453255714559)
    task.wait(_G.RAY_LegitDelayReel)
    CompleteFish()
    task.wait(_G.RAY_LegitDelayCatch)
    
    isFishingLegit = false
end

--==================================================
-- MAIN LOOP
--==================================================
task.spawn(function()
    while true do
        task.wait(0.05)
        if _G.RAY_LegitPerfect then
            EngineLegit()
        else
            EngineAFK()
        end
    end
end)

--==================================================
-- PAGE CONFIGURATION
--==================================================
local PAGE_CONFIG = {
    {Name = "About", Icon = "rbxassetid://89633575267800"},
    {Name = "Fishing", Icon = "rbxassetid://12644442470"},
    {Name = "Backpack", Icon = "rbxassetid://6870729295"},
    {Name = "Teleport", Icon = "rbxassetid://6031075931"},
    {Name = "Shop", Icon = "rbxassetid://6031265976"},
    {Name = "Misc", Icon = "rbxassetid://6034509993"},
}


--==================================================
-- PAGE SYSTEM
--==================================================
local Pages = {}
local CurrentHighlightHolder

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Name = name
    Page.Size = UDim2.new(1, -12, 1, -12)
    Page.Position = UDim2.new(0, 6, 0, 6)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 4
    Page.ScrollBarImageColor3 = THEME.MAIN
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false

    Instance.new("UIListLayout", Page).SortOrder = Enum.SortOrder.LayoutOrder
    Page.UIListLayout.Padding = UDim.new(0, 6)

    return Page
end

local function ShowPage(name)
    for pageName, page in pairs(Pages) do
        page.Visible = (pageName == name)
    end
end

local function SetActive(holder)
    if CurrentHighlightHolder and CurrentHighlightHolder:FindFirstChild("Highlight") then
        CurrentHighlightHolder.Highlight.BackgroundTransparency = 1
    end
    CurrentHighlightHolder = holder
    if holder and holder:FindFirstChild("Highlight") then
        holder.Highlight.BackgroundTransparency = 0
    end
end

--==================================================
-- HELPER: CREATE UI ELEMENTS
--==================================================
local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner", parent)
    corner.CornerRadius = UDim.new(0, radius or 6)
    return corner
end

local function CreateStroke(parent, color, transparency)
    local stroke = Instance.new("UIStroke", parent)
    stroke.Color = color or THEME.MAIN
    stroke.Transparency = transparency or 0.5
    return stroke
end

local function CreateLabel(parent, props)
    local label = Instance.new("TextLabel", parent)
    for k, v in pairs(props) do
        if k ~= "Parent" then label[k] = v end
    end
    return label
end

--==================================================
-- SIDEBAR BUTTON CREATOR
--==================================================
local function CreateSideButton(conf)
    local Holder = Instance.new("Frame", SideScroll)
    Holder.Size = UDim2.new(1, -4, 0, 34)
    Holder.BackgroundTransparency = 1
    Holder.BorderSizePixel = 0

    local Highlight = Instance.new("Frame", Holder)
    Highlight.Name = "Highlight"
    Highlight.Size = UDim2.new(0, 3, 1, -6)
    Highlight.Position = UDim2.new(0, 0, 0, 3)
    Highlight.BackgroundColor3 = THEME.MAIN
    Highlight.BackgroundTransparency = 1
    Highlight.BorderSizePixel = 0

    local Btn = Instance.new("TextButton", Holder)
    Btn.Size = UDim2.new(1, -4, 1, 0)
    Btn.Position = UDim2.new(0, 4, 0, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Btn.BackgroundTransparency = 0.05
    Btn.BorderSizePixel = 0
    Btn.AutoButtonColor = false
    Btn.Text = ""

    CreateCorner(Btn, 6)

    local Icon = Instance.new("ImageLabel", Btn)
    Icon.Size = UDim2.new(0, 18, 0, 18)
    Icon.Position = UDim2.new(0, 6, 0.5, -9)
    Icon.BackgroundTransparency = 1
    Icon.Image = conf.Icon
    Icon.ImageColor3 = Color3.new(1, 1, 1)

    local Sep = Instance.new("Frame", Btn)
    Sep.Size = UDim2.new(0, 1, 0.6, 0)
    Sep.Position = UDim2.new(0, 28, 0.2, 0)
    Sep.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Sep.BackgroundTransparency = 0.2
    Sep.BorderSizePixel = 0

    CreateLabel(Btn, {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 34, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.new(1, 1, 1),
        Text = conf.Name
    })

    Btn.MouseEnter:Connect(function() Btn.BackgroundTransparency = 0 end)
    Btn.MouseLeave:Connect(function() Btn.BackgroundTransparency = 0.05 end)

    return Holder, Btn
end

--==================================================
-- INITIALIZE PAGES
--==================================================
do
    local first = true
    for _, conf in ipairs(PAGE_CONFIG) do
        local holder, btn = CreateSideButton(conf)
        local page = CreatePage(conf.Name)
        Pages[conf.Name] = page

        btn.MouseButton1Click:Connect(function()
            SetActive(holder)
            ShowPage(conf.Name)
        end)

        if first then
            first = false
            SetActive(holder)
            ShowPage(conf.Name)
        end
    end
end

--==================================================
-- ABOUT PAGE CONTENT
--==================================================
local InfoPage = Pages["About"]
if InfoPage then
    -- Main Card
    local Card = Instance.new("Frame", InfoPage)
    Card.Size = UDim2.new(1, 0, 0, 90)
    Card.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    Card.BackgroundTransparency = 0.45
    Card.BorderSizePixel = 0

    CreateCorner(Card, 10)
    CreateStroke(Card, THEME.MAIN, 0.8)

    -- Title
    CreateLabel(Card, {
        Size = UDim2.new(1, -20, 0, 22),
        Position = UDim2.new(0, 10, 0, 8),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = THEME.TEXT,
        Text = "ThreebloxHUB - About"
    })

    -- Underline
    local Line = Instance.new("Frame", Card)
    Line.Size = UDim2.new(0, 60, 0, 1)
    Line.Position = UDim2.new(0, 10, 0, 30)
    Line.BackgroundColor3 = THEME.MAIN
    Line.BackgroundTransparency = 0.3
    Line.BorderSizePixel = 0

    -- Description
    CreateLabel(Card, {
        Size = UDim2.new(1, -20, 0, 36),
        Position = UDim2.new(0, 10, 0, 36),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextColor3 = Color3.fromRGB(230, 230, 255),
        TextWrapped = true,
        Text = "Universal UI for ThreebloxHUB."
    })

    -- Author Info
    CreateLabel(Card, {
        Size = UDim2.new(0, 140, 0, 32),
        Position = UDim2.new(1, -150, 0, 8),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextColor3 = Color3.fromRGB(220, 220, 245),
        TextWrapped = true,
        Text = "Made by: Threeblox"
    })

    --==================================================
    -- BUTTON CREATOR HELPER
    --==================================================
    local function CreateActionButton(props)
        local btn = Instance.new("TextButton", Card)
        btn.Size = props.Size or UDim2.new(0, 120, 0, 24)
        btn.Position = props.Position
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        btn.BackgroundTransparency = 0.3
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = true
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = props.TextSize or 12
        btn.TextColor3 = THEME.TEXT
        btn.Text = props.Text

        CreateCorner(btn, 6)
        CreateStroke(btn, THEME.MAIN, 0.5)

        btn.MouseButton1Click:Connect(props.Callback)
        return btn
    end

    local discordUrl = "https://discord.gg/Threebloxhub"

    -- Join Discord Button
    CreateActionButton({
        Position = UDim2.new(0, 10, 1, -30),
        Text = "Join Discord",
        Callback = function()
            local ok = false
            if syn and syn.openurl then
                ok = pcall(function() syn.openurl(discordUrl) end)
            elseif openurl then
                ok = pcall(function() openurl(discordUrl) end)
            end

            if setclipboard then setclipboard(discordUrl) end

            NText.Text = ok and "Opening Discord invite..." or "Discord link copied to clipboard"
            Notify.Visible = true
            task.delay(1.5, function() Notify.Visible = false end)
        end
    })

    -- Copy Link Button
    CreateActionButton({
        Position = UDim2.new(0, 140, 1, -30),
        TextSize = 11,
        Text = "Copy Discord Link",
        Callback = function()
            if setclipboard then setclipboard(discordUrl) end
            NText.Text = "Discord link copied!"
            Notify.Visible = true
            task.delay(1.5, function() Notify.Visible = false end)
        end
    })

    -- Changelog Section
    CreateLabel(InfoPage, {
        Size = UDim2.new(1, -20, 0, 18),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.new(1, 1, 1),
        Text = "Changelog",
        LayoutOrder = 10
    })

    local function AddChangeLine(text)
        CreateLabel(InfoPage, {
            Size = UDim2.new(1, -24, 0, 16),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Color3.new(1, 1, 1),
            Text = text,
            LayoutOrder = 11
        })
    end

    AddChangeLine("(+) Added New GUI layout")
    AddChangeLine("(+) Added New GUI layout")
    AddChangeLine("(+) Added New GUI layout")
end

--==================================================
-- COMPONENT: TOGGLE PILL
--==================================================
local function CreateTogglePill(parent, labelText, default)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 36)
    row.BackgroundTransparency = 1

    CreateLabel(row, {
        Size = UDim2.new(1, -100, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = THEME.TEXT,
        Text = labelText
    })

    local pill = Instance.new("TextButton", row)
    pill.Size = UDim2.new(0, 50, 0, 24)
    pill.Position = UDim2.new(1, -80, 0.5, -12)
    pill.BackgroundTransparency = 0.1
    pill.Text = ""
    pill.AutoButtonColor = false

    CreateCorner(pill, 999)

    local knob = Instance.new("Frame", pill)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    CreateCorner(knob, 999)

    local state = not not default

    local function refresh()
        pill.BackgroundColor3 = state and THEME.ACCENT or THEME.MUTED
        knob.Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    end
    refresh()

    pill.MouseButton1Click:Connect(function()
        state = not state
        refresh()
    end)

    return function() return state end, function(v) state = not not v; refresh() end
end

--==================================================
-- COMPONENT: SECTION DROPDOWN
--==================================================
local function CreateSectionDropdown(parent, titleText)
    local Holder = Instance.new("Frame", parent)
    Holder.Size = UDim2.new(1, -10, 0, 30)
    Holder.BackgroundTransparency = 1
    Holder.BorderSizePixel = 0

    local Header = Instance.new("TextButton", Holder)
    Header.Size = UDim2.new(1, 0, 0, 30)
    Header.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    Header.BackgroundTransparency = 0.4
    Header.BorderSizePixel = 0
    Header.AutoButtonColor = false
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 14
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.TextColor3 = THEME.TEXT
    Header.Text = "  " .. titleText

    CreateCorner(Header, 8)

    local Arrow = Instance.new("TextLabel", Header)
    Arrow.Size = UDim2.new(0, 20, 0, 20)
    Arrow.Position = UDim2.new(1, -24, 0.5, -10)
    Arrow.BackgroundTransparency = 1
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 14
    Arrow.TextColor3 = THEME.TEXT
    Arrow.Text = "▼"

    local ContentFrame = Instance.new("Frame", parent)
    ContentFrame.Size = UDim2.new(1, -10, 0, 0)
    ContentFrame.Position = UDim2.new(0, 5, 0, 40)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0

    Instance.new("UIListLayout", ContentFrame).SortOrder = Enum.SortOrder.LayoutOrder
    ContentFrame.UIListLayout.Padding = UDim.new(0, 6)

    local opened = false

    local function refresh()
        Arrow.Text = opened and "▲" or "▼"
        ContentFrame.Visible = opened

        if opened then
            local total = 0
            for _, child in ipairs(ContentFrame:GetChildren()) do
                if child:IsA("GuiObject") then
                    total = total + child.AbsoluteSize.Y + 6
                end
            end
            ContentFrame.Size = UDim2.new(1, -10, 0, total)
        else
            ContentFrame.Size = UDim2.new(1, -10, 0, 0)
        end
    end
    refresh()

    Header.MouseButton1Click:Connect(function()
        opened = not opened
        refresh()
    end)

    ContentFrame.ChildAdded:Connect(function()
        task.delay(0.05, refresh)
    end)

    return ContentFrame
end

--==================================================
-- FISHING PAGE
--==================================================
local AutoPage = Pages["Fishing"]
if AutoPage then
    Instance.new("UIListLayout", AutoPage).SortOrder = Enum.SortOrder.LayoutOrder
    AutoPage.UIListLayout.Padding = UDim.new(0, 6)
end

--==================================================
-- HELPER: CREATE INPUT CARD
--==================================================
local function CreateInputCard(parent, labelText, defaultValue, callback)
    local Card = Instance.new("Frame", parent)
    Card.Size = UDim2.new(1, -4, 0, 32)
    Card.BackgroundColor3 = Color3.fromRGB(25, 28, 35)
    Card.BackgroundTransparency = 0.55
    Card.BorderSizePixel = 0
    
    CreateCorner(Card, 8)
    CreateStroke(Card, THEME.MAIN, 0.8)
    
    CreateLabel(Card, {
        Size = UDim2.new(0.6, -20, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = THEME.TEXT,
        Text = labelText
    })
    
    local Box = Instance.new("TextBox", Card)
    Box.Size = UDim2.new(0, 80, 0, 24)
    Box.Position = UDim2.new(1, -94, 0.5, -12)
    Box.Text = tostring(defaultValue)
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 13
    Box.TextXAlignment = Enum.TextXAlignment.Center
    Box.TextColor3 = THEME.TEXT
    Box.ClearTextOnFocus = false
    Box.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Box.BackgroundTransparency = 0.3
    
    CreateCorner(Box, 8)
    
    Box.FocusLost:Connect(function()
        local n = tonumber(Box.Text:match("[%d%.]+"))
        if n and n > 0 then
            callback(n)
            Box.Text = tostring(n)
        else
            Box.Text = tostring(defaultValue)
        end
    end)
    
    return Box
end

--==================================================
-- HELPER: CREATE TOGGLE ROW
--==================================================
local function CreateToggleRow(parent, labelText, default, callback, options)
    options = options or {}
    local row = Instance.new("Frame", parent)
    row.Size = options.Size or UDim2.new(1, 0, 0, 36)
    row.BackgroundTransparency = 1
    
    if options.Hint then
        CreateLabel(row, {
            Size = UDim2.new(1, -110, 0, 20),
            Position = UDim2.new(0, 16, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = THEME.TEXT,
            Text = labelText
        })
        
        CreateLabel(row, {
            Size = UDim2.new(1, -110, 0, 30),
            Position = UDim2.new(0, 16, 0, 20),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextColor3 = Color3.fromRGB(180, 180, 180),
            TextWrapped = true,
            Text = options.Hint
        })
    else
        CreateLabel(row, {
            Size = UDim2.new(1, -100, 1, 0),
            Position = UDim2.new(0, 16, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = options.TextColor or THEME.TEXT,
            Text = labelText
        })
    end
    
    local pill = Instance.new("TextButton", row)
    pill.Size = UDim2.new(0, 50, 0, 24)
    pill.Position = UDim2.new(1, -80, 0.5, -12)
    pill.BackgroundColor3 = options.PillColor or THEME.MUTED
    pill.BackgroundTransparency = 0.1
    pill.Text = ""
    pill.AutoButtonColor = false
    
    CreateCorner(pill, 999)
    
    local knob = Instance.new("Frame", pill)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    CreateCorner(knob, 999)
    
    local state = not not default
    
    local function refresh()
        pill.BackgroundColor3 = state and (options.ActiveColor or THEME.MAIN) or (options.PillColor or THEME.MUTED)
        knob.Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    end
    
    pill.MouseButton1Click:Connect(function()
        state = not state
        refresh()
        if callback then callback(state) end
        if NotifyFeature then
            NotifyFeature(labelText, state)
        end
    end)
    
    refresh()
    
    return function() return state end, function(v) 
        state = not not v 
        refresh() 
        if callback then callback(state) end
    end, refresh
end

--==================================================
-- HELPER: CREATE SECTION LINE
--==================================================
local function CreateSectionLine(parent)
    local Line = Instance.new("Frame", parent)
    Line.Size = UDim2.new(1, 0, 0, 2)
    Line.Position = UDim2.new(0, 0, 0, 2)
    Line.BackgroundColor3 = THEME.MAIN
    Line.BorderSizePixel = 0
    return Line
end

--==================================================
-- INSTANT FISHING SECTION
--==================================================
if AutoPage then
    local AutoFishSection = CreateSectionDropdown(AutoPage, "Instant Fishing")
    
    Instance.new("UIListLayout", AutoFishSection).SortOrder = Enum.SortOrder.LayoutOrder
    AutoFishSection.UIListLayout.Padding = UDim.new(0, 6)
    
    CreateSectionLine(AutoFishSection)
    
    -- Input Cards
    CreateInputCard(AutoFishSection, "Reel Delay (sec)", _G.RAY_DelayReel, function(n)
        _G.RAY_DelayReel = n
    end)
    
    CreateInputCard(AutoFishSection, "Catch Delay (sec)", _G.RAY_DelayCatch, function(n)
        _G.RAY_DelayCatch = n
    end)
    
    -- Enable Toggle
    local ToggleCard = Instance.new("Frame", AutoFishSection)
    ToggleCard.Size = UDim2.new(1, -4, 0, 32)
    ToggleCard.BackgroundColor3 = Color3.fromRGB(25, 28, 35)
    ToggleCard.BackgroundTransparency = 0.55
    ToggleCard.BorderSizePixel = 0
    
    CreateCorner(ToggleCard, 8)
    CreateStroke(ToggleCard, THEME.MAIN, 0.8)
    
    CreateLabel(ToggleCard, {
        Size = UDim2.new(0.6, -20, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = THEME.TEXT,
        Text = "Enable Instant Auto Fishing"
    })
    
    local pill = Instance.new("TextButton", ToggleCard)
    pill.Size = UDim2.new(0, 50, 0, 24)
    pill.Position = UDim2.new(1, -60, 0.5, -12)
    pill.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    pill.BackgroundTransparency = 0.2
    pill.Text = ""
    pill.AutoButtonColor = false
    
    CreateCorner(pill, 999)
    
    local knob = Instance.new("Frame", pill)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    CreateCorner(knob, 999)
    
    local state = _G.RAY_AutoFishAFK
    
    local function refresh()
        pill.BackgroundColor3 = state and THEME.MAIN or Color3.fromRGB(40, 40, 55)
        knob.Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        _G.RAY_AutoFishAFK = state
    end
    
    pill.MouseButton1Click:Connect(function()
        state = not state
        refresh()
        if NotifyFeature then NotifyFeature("Instant Fishing", state) end
    end)
    
    refresh()
    
    -- Auto-apply loop
    task.spawn(function()
        local last = state
        while true do
            if state ~= last then
                last = state
                refresh()
            end
            task.wait(0.1)
        end
    end)
end

--==================================================
-- VFX UTILS
--==================================================
local VFXHidden = {}
local VFXCacheFolder = Instance.new("Folder", ReplicatedStorage)
VFXCacheFolder.Name = "VFX_HIDDEN_CACHE"

local function HideAllVFX()
    local vfxRoot = ReplicatedStorage:FindFirstChild("VFX")
    if not vfxRoot then return end
    
    for _, obj in ipairs(vfxRoot:GetChildren()) do
        if not VFXHidden[obj] then
            VFXHidden[obj] = obj.Parent
            obj.Parent = VFXCacheFolder
        end
    end
end

local function RestoreAllVFX()
    for obj, oldParent in pairs(VFXHidden) do
        if obj and obj.Parent == VFXCacheFolder then
            obj.Parent = oldParent
        end
    end
    table.clear(VFXHidden)
end

--==================================================
-- WATER WALK LOGIC
--==================================================
local waterWalkOn = false
local waterHb = nil
local Surfaces = {}
local lastCenter = nil

local WATER_CONFIG = {
    SIZE_XZ = 350,
    HEIGHT_OFFSET = 4,
    STEP_DIST = 220
}

local function ClearWaterSurfaces()
    for _, p in ipairs(Surfaces) do
        if p and p.Parent then p:Destroy() end
    end
    table.clear(Surfaces)
    lastCenter = nil
end

local function createWaterSurface(root)
    local pos = root.Position
    local part = Instance.new("Part")
    part.Name = "WaterWalkSurface"
    part.Size = Vector3.new(WATER_CONFIG.SIZE_XZ, 1, WATER_CONFIG.SIZE_XZ)
    part.Position = Vector3.new(pos.X, pos.Y - WATER_CONFIG.HEIGHT_OFFSET, pos.Z)
    part.Anchored = true
    part.CanCollide = true
    part.CanTouch = false
    part.CanQuery = false
    part.Transparency = 1
    part.Material = Enum.Material.SmoothPlastic
    part.Parent = workspace
    
    table.insert(Surfaces, part)
    lastCenter = part.Position
end

local function StartWaterWalk()
    ClearWaterSurfaces()
    
    local char = Player.Character or Player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    
    createWaterSurface(root)
    
    waterHb = RunService.Heartbeat:Connect(function()
        if #Surfaces == 0 or not root or not root.Parent or not lastCenter then return end
        
        local pos = root.Position
        local dist = (Vector3.new(pos.X, 0, pos.Z) - Vector3.new(lastCenter.X, 0, lastCenter.Z)).Magnitude
        
        if dist > WATER_CONFIG.STEP_DIST then
            createWaterSurface(root)
        end
    end)
end

local function StopWaterWalk()
    if waterHb then
        waterHb:Disconnect()
        waterHb = nil
    end
    ClearWaterSurfaces()
end

local function SetWaterWalk(on)
    if waterWalkOn == on then return end
    waterWalkOn = on and true or false
    
    if waterWalkOn then StartWaterWalk() else StopWaterWalk() end
end

Player.CharacterAdded:Connect(function()
    if waterWalkOn then
        task.wait(0.3)
        StartWaterWalk()
    end
end)

--==================================================
-- GUI CONTROL & CAMERA GUARD
--==================================================
local GuiControl = require(ReplicatedStorage.Modules.GuiControl)

_G.__RAY_OldGuiControlClose = _G.__RAY_OldGuiControlClose or GuiControl.Close
_G.__RAY_OldGuiControlLock = _G.__RAY_OldGuiControlLock or GuiControl.Lock
_G.__RAY_OldGuiControlHUD = _G.__RAY_OldGuiControlHUD or GuiControl.SetHUDVisibility

local camConn

local function ForcePlayerCamera()
    local cam = Workspace.CurrentCamera
    if not cam or not Player.Character then return end
    
    local hum = Player.Character:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    cam.CameraType = Enum.CameraType.Custom
    cam.CameraSubject = hum
end

local function StartCameraGuard()
    ForcePlayerCamera()
    if camConn then camConn:Disconnect() end
    camConn = Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(ForcePlayerCamera)
    
    Player.CharacterAdded:Connect(function()
        task.delay(0.2, ForcePlayerCamera)
    end)
end

local function StopCameraGuard()
    if camConn then
        camConn:Disconnect()
        camConn = nil
    end
end

local function ReapplyGuiPatches()
    local disableAll = _G.RAY_DisableCutscene
    local noPause = _G.RAY_NoCutscenePause
    
    -- Restore originals
    if _G.__RAY_OldGuiControlClose then GuiControl.Close = _G.__RAY_OldGuiControlClose end
    if _G.__RAY_OldGuiControlLock then GuiControl.Lock = _G.__RAY_OldGuiControlLock end
    if _G.__RAY_OldGuiControlHUD then GuiControl.SetHUDVisibility = _G.__RAY_OldGuiControlHUD end
    
    StopCameraGuard()
    
    if disableAll then
        GuiControl.Close = function() end
        GuiControl.Lock = function() end
        GuiControl.SetHUDVisibility = function() end
        StartCameraGuard()
    elseif noPause then
        GuiControl.Lock = function() end
    end
end

--==================================================
-- FISHING SUPPORT SECTION
--==================================================
if AutoPage then
    local FishingSupportSection = CreateSectionDropdown(AutoPage, "Fishing Support")
    
    Instance.new("UIListLayout", FishingSupportSection).SortOrder = Enum.SortOrder.LayoutOrder
    FishingSupportSection.UIListLayout.Padding = UDim.new(0, 6)
    
    CreateSectionLine(FishingSupportSection)
    
    -- Water Walk Toggle
    CreateToggleRow(FishingSupportSection, "Walk On Water", waterWalkOn, function(state)
        SetWaterWalk(state)
    end, {
        Size = UDim2.new(1, 0, 0, 60),
        Hint = "Aktifkan di dataran rendah supaya tinggi kaki pas di permukaan air."
    })
    
    -- Disable Cutscene Toggle
    CreateToggleRow(FishingSupportSection, "Disable All Cutscenes", _G.RAY_DisableCutscene, function(state)
        _G.RAY_DisableCutscene = state
        if state then _G.RAY_NoCutscenePause = false end
        ReapplyGuiPatches()
    end)
    
    -- No Cutscene Pause Toggle
    CreateToggleRow(FishingSupportSection, "No Cutscene Pause (BETA)", _G.RAY_NoCutscenePause, function(state)
        _G.RAY_NoCutscenePause = state
        if state then _G.RAY_DisableCutscene = false end
        ReapplyGuiPatches()
    end)
    
    -- Disable Fish Image Toggle
    do
        local gui = Player:WaitForChild("PlayerGui")
        local conn
        
        local function attach()
            for _, v in ipairs(gui:GetDescendants()) do
                if v.Name == "Small Notification" then v:Destroy() end
            end
            conn = gui.DescendantAdded:Connect(function(v)
                if v.Name == "Small Notification" then v:Destroy() end
            end)
        end
        
        local function detach()
            if conn then conn:Disconnect(); conn = nil end
        end
        
        CreateToggleRow(FishingSupportSection, "Disable Fish Image", _G.RAY_DisableFishImage, function(state)
            _G.RAY_DisableFishImage = state
            if state then attach() else detach() end
        end)
        
        if _G.RAY_DisableFishImage then attach() end
    end
    
    -- Disable Rod Skin Toggle
    CreateToggleRow(FishingSupportSection, "Disable Rod Skin", _G.RAY_DisableRodSkin, function(state)
        _G.RAY_DisableRodSkin = state
        if state then HideAllVFX() else RestoreAllVFX() end
    end)
    
    Player.CharacterAdded:Connect(function()
        if _G.RAY_DisableRodSkin then
            task.delay(0.5, HideAllVFX)
        end
    end)
    
    if _G.RAY_DisableRodSkin then HideAllVFX() end
    
    -- Rod Freeze Toggle
    do
        local AnimController = require(ReplicatedStorage.Controllers.AnimationController)
        _G.__RAY_OldPlayAnimation = _G.__RAY_OldPlayAnimation or AnimController.PlayAnimation
        local OldPlay = _G.__RAY_OldPlayAnimation
        
        local ROD_ANIMS = {
            ["RodThrow"] = true,
            ["ReelStart"] = true,
            ["ReelingIdle"] = true,
            ["ReelIntermission"] = true,
            ["FishCaught"] = true,
        }
        
        local hardFreezeConn
        
        local function startHardFreeze()
            if hardFreezeConn then hardFreezeConn:Disconnect() end
            hardFreezeConn = RunService.Heartbeat:Connect(function()
                local char = Player.Character
                if not char then return end
                
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if not hum then return end
                
                for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                    track:AdjustSpeed(0)
                end
            end)
        end
        
        local function stopHardFreeze()
            if hardFreezeConn then
                hardFreezeConn:Disconnect()
                hardFreezeConn = nil
            end
            
            local char = Player.Character
            if char then
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if hum then
                    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                        track:AdjustSpeed(1)
                    end
                end
            end
        end
        
        local function applyPatch()
            AnimController.PlayAnimation = function(self, animName, waitEnd)
                if _G.RAY_RodFreeze and ROD_ANIMS[animName] then
                    return {
                        Play = function() end,
                        Stop = function() end,
                        Destroy = function() end,
                        Stopped = { Connect = function() end, Once = function() end },
                        Ended = { Connect = function() end, Once = function() end },
                        TimePosition = 0,
                        Length = 0,
                    }
                end
                return OldPlay(self, animName, waitEnd)
            end
        end
        
        local function restorePatch()
            AnimController.PlayAnimation = OldPlay
        end
        
        local _, setRodFreeze = CreateToggleRow(FishingSupportSection, "Rod Freeze", _G.RAY_RodFreeze, function(state)
            _G.RAY_RodFreeze = state
            if state then
                applyPatch()
                startHardFreeze()
            else
                restorePatch()
                stopHardFreeze()
            end
        end, {
            PillColor = Color3.fromRGB(120, 120, 120),
            ActiveColor = Color3.fromRGB(0, 200, 100)
        })
        
        if _G.RAY_RodFreeze then
            applyPatch()
            startHardFreeze()
        end
    end
end

-- Initial patches
task.delay(1, function()
    if _G.RAY_DisableCutscene or _G.RAY_NoCutscenePause then
        ReapplyGuiPatches()
    end
end)


--==================================================
-- SKIN ANIMATION SYSTEM
--==================================================
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local Modules = ReplicatedStorage:WaitForChild("Modules")

local AnimModule = require(Controllers:WaitForChild("AnimationController"))
local Animations_upvr = require(Modules:WaitForChild("Animations"))
local oldGetAnimationData = AnimModule.GetAnimationData

if type(oldGetAnimationData) ~= "function" then
    warn("[SkinOverride] GetAnimationData tidak ada di AnimationController")
end

local SKINS = {
    "Eclipse Katana", "Holy Trident", "Soul Scythe",
    "Oceanic Harpoon", "Binary Edge", "The Vanquisher", "1x1x1x1 Ban Hammer",
    "Ethereal Sword",        -- baru
    "Cursed Katana",         -- baru
    "Blackhole"              -- baru
}

local SelectedAnimSkin, OverrideEnabled = nil, false

function AnimModule:SetAnimationSkin(skinName)
    SelectedAnimSkin = (typeof(skinName) == "string" and #skinName > 0) and skinName or nil
end

function AnimModule:SetSkinOverrideEnabled(enabled)
    OverrideEnabled = not not enabled
end

AnimModule.GetAnimationData = function(self, animName)
    local baseData, baseKey = oldGetAnimationData(self, animName)
    if not baseData then return nil, nil end
    if not OverrideEnabled or not SelectedAnimSkin then return baseData, baseKey end
    
    local overrideKey = ("%s - %s"):format(SelectedAnimSkin, animName)
    local overrideData = Animations_upvr[overrideKey]
    
    return (overrideData and overrideData.AnimationId) and overrideData, overrideKey or baseData, baseKey
end

--==================================================
-- RIGHT PANEL (SKIN LIST) - FIXED
--==================================================
local RightPanel = Instance.new("Frame", Main)
RightPanel.Name = "SkinAnimationRightPanel"
RightPanel.Size = UDim2.new(0, 220, 1, -46)
RightPanel.AnchorPoint = Vector2.new(1, 0)
RightPanel.Position = UDim2.new(1, -10, 0, 40)
RightPanel.BackgroundColor3 = THEME.CARD
RightPanel.BackgroundTransparency = 0.25
RightPanel.BorderSizePixel = 0
RightPanel.Visible = false
RightPanel.ZIndex = 10
RightPanel.ClipsDescendants = true  -- FIX: prevent bleed

CreateCorner(RightPanel, 10)
CreateStroke(RightPanel, THEME.MAIN, 0.5)

-- Header dengan Close Button
local headerFrame = Instance.new("Frame", RightPanel)
headerFrame.Name = "Header"
headerFrame.Size = UDim2.new(1, 0, 0, 30)
headerFrame.BackgroundTransparency = 1
headerFrame.ZIndex = 11

CreateLabel(headerFrame, {
    Size = UDim2.new(1, -35, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    ZIndex = 12,
    Text = "Skin Animation"
})

-- CLOSE BUTTON X
local closeBtn = Instance.new("TextButton", headerFrame)
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -26, 0.5, -11)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.ZIndex = 12
CreateCorner(closeBtn, 4)

closeBtn.MouseButton1Click:Connect(function()
    RightPanel.Visible = false
end)

local rpSkin = CreateLabel(RightPanel, {
    Size = UDim2.new(1, -10, 0, 18),
    Position = UDim2.new(0, 5, 0, 32),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    ZIndex = 11,
    Text = "Skin: default (ikut rod)"
})

local function UpdateRightSkinLabel()
    rpSkin.Text = SelectedAnimSkin and #SelectedAnimSkin > 0 and "Skin: " .. SelectedAnimSkin or "Skin: default (ikut rod)"
end

-- FIXED: ScrollingFrame dengan proper canvas size
local rpScroll = Instance.new("ScrollingFrame", RightPanel)
rpScroll.Size = UDim2.new(1, -10, 1, -75)  -- 75 = 30(header) + 18(label) + padding
rpScroll.Position = UDim2.new(0, 5, 0, 55)
rpScroll.BackgroundTransparency = 1
rpScroll.BorderSizePixel = 0
rpScroll.ScrollBarThickness = 3
rpScroll.ScrollingDirection = Enum.ScrollingDirection.Y  -- FIX: Y only
rpScroll.ScrollBarImageColor3 = THEME.MAIN
rpScroll.ZIndex = 10
rpScroll.ClipsDescendants = true

-- FIX: Manual CanvasSize instead of Automatic
local listLayout = Instance.new("UIListLayout", rpScroll)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 4)

local function UpdateCanvasSize()
    rpScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end

listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)

local function CreateSkinEntry(skinName)
    local row = Instance.new("Frame")
    row.Name = skinName .. "_Row"
    row.Size = UDim2.new(1, -4, 0, 24)
    row.BackgroundTransparency = 1
    row.ZIndex = 11
    row.Parent = rpScroll  -- FIX: parent after setup

    local line = Instance.new("Frame", row)
    line.Name = "Highlight"
    line.Size = UDim2.new(0, 3, 1, 0)
    line.BackgroundColor3 = THEME.MAIN
    line.Visible = false
    line.ZIndex = 12

    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1, -6, 1, 0)
    btn.Position = UDim2.new(0, 4, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.TextColor3 = THEME.TEXT
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "  " .. skinName
    btn.ZIndex = 11
    
    CreateCorner(btn, 6)

    btn.MouseButton1Click:Connect(function()
        AnimModule:SetAnimationSkin(skinName)
        SelectedAnimSkin = skinName
        UpdateRightSkinLabel()
        
        for _, child in ipairs(rpScroll:GetChildren()) do
            if child:IsA("Frame") and child:FindFirstChild("Highlight") then
                child.Highlight.Visible = (child == row)
            end
        end
    end)
end

for _, sn in ipairs(SKINS) do CreateSkinEntry(sn) end
UpdateCanvasSize()  -- FIX: initial update
UpdateRightSkinLabel()

-- Close panel on outside click - FIXED dengan gameProcessed check
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not RightPanel.Visible then return end
    if gameProcessed then return end  -- FIX: jangan close pas typing
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
    
    local pos = input.Position
    local absPos, absSize = RightPanel.AbsolutePosition, RightPanel.AbsoluteSize
    
    local inside = pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
                   pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y
    
    if not inside then RightPanel.Visible = false end
end)

--==================================================
-- SKIN ANIMATION SECTION (IN FISHING PAGE)
--==================================================
if AutoPage then
    local SkinAnimationSection = CreateSectionDropdown(AutoPage, "Skin Animation")
    
    Instance.new("UIListLayout", SkinAnimationSection).SortOrder = Enum.SortOrder.LayoutOrder
    SkinAnimationSection.UIListLayout.Padding = UDim.new(0, 6)
    
    CreateSectionLine(SkinAnimationSection)
    
    -- Override Toggle
    CreateToggleRow(SkinAnimationSection, "Skin Override", OverrideEnabled, function(state)
        OverrideEnabled = state
        AnimModule:SetSkinOverrideEnabled(state)
    end)
    
    -- Open Panel Button
    do
        local row = Instance.new("Frame", SkinAnimationSection)
        row.Size = UDim2.new(1, 0, 0, 40)
        row.BackgroundTransparency = 1
        
        CreateLabel(row, {
            Size = UDim2.new(1, -110, 1, 0),
            Position = UDim2.new(0, 16, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = THEME.TEXT,
            Text = "Open Skin Panel"
        })
        
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0, 80, 0, 24)
        btn.Position = UDim2.new(1, -100, 0.5, -12)
        btn.BackgroundColor3 = THEME.CARD
        btn.BackgroundTransparency = 0.1
        btn.Text = "Open"
        btn.TextColor3 = THEME.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        
        CreateCorner(btn, 8)
        
        btn.MouseButton1Click:Connect(function() RightPanel.Visible = not RightPanel.Visible end)
    end
end

--==================================================
-- AUTO SELL SYSTEM - FIXED DEFAULT OFF
--==================================================
local BackpackPage = Pages["Backpack"]
if BackpackPage then
    Instance.new("UIListLayout", BackpackPage).SortOrder = Enum.SortOrder.LayoutOrder
    BackpackPage.UIListLayout.Padding = UDim.new(0, 6)
end

if BackpackPage then
    local BackpackAutoSellSection = CreateSectionDropdown(BackpackPage, "Auto Sell")
    
    Instance.new("UIListLayout", BackpackAutoSellSection).SortOrder = Enum.SortOrder.LayoutOrder
    BackpackAutoSellSection.UIListLayout.Padding = UDim.new(0, 4)
    
    -- FIX: Default semua OFF (tidak auto nyala)
    _G.RAY_SellThreshold = _G.RAY_SellThreshold or "Legendary"
    _G.RAY_SellDelay = _G.RAY_SellDelay or 5
    _G.RAY_SellInventoryThreshold = _G.RAY_SellInventoryThreshold or 30
    _G.RAY_SellByTime = _G.RAY_SellByTime or false  -- FIX: Default false, bukan true!
    _G.RAY_SellByInventory = _G.RAY_SellByInventory or false  -- FIX: Default false
    
    local ThresholdMap = { Legendary = 5, Mythic = 6, Secret = 7 }
    
    -- Helper: Create Input Row
    local function CreateInputRow(parent, label, default, callback, isNumber)
        local row = Instance.new("Frame", parent)
        row.Size = UDim2.new(1, 0, 0, 32)
        row.BackgroundTransparency = 1
        
        CreateLabel(row, {
            Size = UDim2.new(0.55, 0, 1, 0),
            Position = UDim2.new(0, 16, 0, -2),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Color3.new(1, 1, 1),
            Text = label
        })
        
        local box = Instance.new("TextBox", row)
        box.Size = UDim2.new(0.38, 0, 1, 0)
        box.Position = UDim2.new(0.58, 0, 0, 0)
        box.Text = tostring(default)
        box.Font = Enum.Font.Gotham
        box.TextSize = 13
        box.TextXAlignment = Enum.TextXAlignment.Center
        box.TextColor3 = Color3.new(1, 1, 1)
        box.ClearTextOnFocus = false
        box.BackgroundColor3 = THEME.CARD
        box.BackgroundTransparency = 0.12
        
        CreateCorner(box, 8)
        
        box.FocusLost:Connect(function()
            local pattern = isNumber and "%d+" or "[%d%.]+"
            local n = tonumber(box.Text:match(pattern))
            if n and n > 0 then
                callback(n)
                box.Text = tostring(n)
            else
                box.Text = tostring(default)
            end
            if NotifyFeature then NotifyFeature(label .. " = " .. box.Text, true) end
        end)
        
        return box
    end
    
    -- Helper: Create Dropdown
    local function CreateDropdownRow(parent, label, options, default, callback)
        local row = Instance.new("Frame", parent)
        row.Size = UDim2.new(1, 0, 0, 32)
        row.BackgroundTransparency = 1
        
        CreateLabel(row, {
            Size = UDim2.new(0.55, 0, 1, 0),
            Position = UDim2.new(0, 16, 0, -2),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Color3.new(1, 1, 1),
            Text = label
        })
        
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0.38, 0, 0, 28)
        btn.Position = UDim2.new(0.58, 0, 0.5, -14)
        btn.BackgroundColor3 = THEME.CARD
        btn.BackgroundTransparency = 0.12
        btn.Text = default .. "  ▼"
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 13
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.AutoButtonColor = false
        
        CreateCorner(btn, 8)
        
        local drop = Instance.new("Frame", row)
        drop.Position = UDim2.new(0.58, 0, 1, 4)
        drop.Size = UDim2.new(0.38, 0, 0, #options * 28)
        drop.BackgroundColor3 = THEME.CARD
        drop.BackgroundTransparency = 0.06
        drop.Visible = false
        drop.ZIndex = 5
        
        CreateCorner(drop, 8)
        
        Instance.new("UIListLayout", drop).Padding = UDim.new(0, 4)
        drop.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        for _, opt in ipairs(options) do
            local b = Instance.new("TextButton", drop)
            b.Size = UDim2.new(1, -8, 0, 24)
            b.BackgroundColor3 = THEME.CARD
            b.BackgroundTransparency = 0.18
            b.Text = opt
            b.Font = Enum.Font.Gotham
            b.TextSize = 12
            b.TextColor3 = Color3.new(1, 1, 1)
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.ZIndex = 6
            
            CreateCorner(b, 6)
            
            b.MouseButton1Click:Connect(function()
                callback(opt)
                btn.Text = opt .. "  ▼"
                drop.Visible = false
            end)
        end
        
        local open = false
        btn.MouseButton1Click:Connect(function()
            open = not open
            drop.Visible = open
        end)
    end
    
    -- Sell Threshold Dropdown
    CreateDropdownRow(BackpackAutoSellSection, "Sell Threshold", 
        {"Legendary", "Mythic", "Secret"}, 
        _G.RAY_SellThreshold,
        function(rar)
            _G.RAY_SellThreshold = rar
            local code = ThresholdMap[rar]
            if code then pcall(function() Events.updateSellThreshold:InvokeServer(code) end) end
            if NotifyFeature then NotifyFeature("Sell Threshold: " .. rar, true) end
        end
    )
    
    -- Sell Delay Input
    CreateInputRow(BackpackAutoSellSection, "Sell Delay (seconds)", _G.RAY_SellDelay, function(n)
        _G.RAY_SellDelay = n
    end)
    
    -- Inventory Threshold Input
    CreateInputRow(BackpackAutoSellSection, "Inventory Threshold", _G.RAY_SellInventoryThreshold, function(n)
        _G.RAY_SellInventoryThreshold = n
    end, true)
    
    -- FIX: Toggle dengan default false (tidak selalu ON)
    CreateToggleRow(BackpackAutoSellSection, "Sell by Time", _G.RAY_SellByTime, function(state)
        _G.RAY_SellByTime = state
        if NotifyFeature then 
            NotifyFeature("Sell by Time: " .. (state and "ON" or "OFF"), state) 
        end
    end, { ActiveColor = Color3.fromRGB(0, 200, 100) })
    
    CreateToggleRow(BackpackAutoSellSection, "Sell by Inventory", _G.RAY_SellByInventory, function(state)
        _G.RAY_SellByInventory = state
        if NotifyFeature then 
            NotifyFeature("Sell by Inventory: " .. (state and "ON" or "OFF"), state) 
        end
    end, { ActiveColor = Color3.fromRGB(0, 200, 100) })
end

--==================================================
-- INVENTORY HELPER
--==================================================
local ItemDataById = {}
for _, v in Items do
    if v.Data and v.Data.Id then ItemDataById[v.Data.Id] = v.Data end
end

local function getFishCountInInventory()
    local ok, repl = pcall(function() return Replion.Client:WaitReplion("Data") end)
    if not ok or not repl or not repl.Data then return 0 end
    
    local items = repl.Data.Inventory and repl.Data.Inventory.Items
    if typeof(items) ~= "table" then return 0 end
    
    local count = 0
    for _, entry in pairs(items) do
        local data = entry.Id and ItemDataById[entry.Id]
        if data and data.Type == "Fish" then count = count + 1 end
    end
    return count
end

--==================================================
-- AUTO SELL ENGINE - CHECK BOTH TOGGLES
--==================================================
task.spawn(function()
    local lastSell = 0

    while true do
        local now = os.clock()
        local shouldSell = false

        -- Sell by Time (hanya jika toggle ON)
        if _G.RAY_SellByTime then
            local delay = tonumber(_G.RAY_SellDelay) or 5
            if now - lastSell >= delay then shouldSell = true end
        end

        -- Sell by Inventory (hanya jika toggle ON)
        if _G.RAY_SellByInventory and not shouldSell then
            local count = getFishCountInInventory()
            local limit = tonumber(_G.RAY_SellInventoryThreshold) or 30
            if count >= limit and now - lastSell >= 0.5 then shouldSell = true end
        end

        if shouldSell then
            local ok, err = pcall(function() Events.sell:InvokeServer() end)
            if ok then
                lastSell = now
            else
                warn("[AUTO SELL] error:", err)
            end
        end

        task.wait(0.5)
    end
end)

--==================================================
-- AUTO TOTEM SYSTEM
--==================================================
_G.RAYAutoTotemOn = _G.RAYAutoTotemOn or false
_G.RAYSelectedTotemType = _G.RAYSelectedTotemType or "Lucky"

local TotemTypeId = { Lucky = 1, Mutasi = 2, Shiny = 3, Love = 5}
local TOTEM_DURATION = 3600

local SpawnTotemRemote = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")
    :WaitForChild("RE/SpawnTotem")

local function GetReplionData()
    local ok, data = pcall(function()
        return Replion.Client:WaitReplion("Data").Data
    end)
    return ok and data or nil
end

local function findTotemUuidByType(jenis)
    local targetId = TotemTypeId[jenis]
    if not targetId then return nil end
    
    local data = GetReplionData()
    if not data then return nil end
    
    local totems = data.Inventory and data.Inventory.Totems
    if typeof(totems) ~= "table" then return nil end
    
    for _, entry in pairs(totems) do
        if entry.Id == targetId then return entry.UUID end
    end
    return nil
end

local function SpawnTotemUUID(uuid)
    if uuid then pcall(function() SpawnTotemRemote:FireServer(uuid) end) end
end

--==================================================
-- FIXED CREATE SIDE PANEL FUNCTION (HANYA 1 KALI)
--==================================================
local function CreateSidePanel(parent, title, infoText)
    local panel = Instance.new("Frame", parent)
    panel.Name = title:gsub(" ", "") .. "Panel"
    panel.Size = UDim2.new(0, 220, 1, -46)
    panel.AnchorPoint = Vector2.new(1, 0)
    panel.Position = UDim2.new(1, -10, 0, 40)
    panel.BackgroundColor3 = THEME.CARD
    panel.BackgroundTransparency = 0.25
    panel.BorderSizePixel = 0
    panel.Visible = false
    panel.ZIndex = 10
    
    CreateCorner(panel, 10)
    CreateStroke(panel, THEME.MAIN, 0.5)
    
    CreateLabel(panel, {
        Size = UDim2.new(1, -10, 0, 24),
        Position = UDim2.new(0, 5, 0, 6),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = THEME.TEXT,
        ZIndex = 11,
        Text = title
    })
    
    CreateLabel(panel, {
        Size = UDim2.new(1, -10, 0, 18),
        Position = UDim2.new(0, 5, 0, 30),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        ZIndex = 11,
        Text = infoText
    })
    
    local scroll = Instance.new("ScrollingFrame", panel)
    scroll.Name = title:gsub(" ", "") .. "Scroll"
    scroll.Size = UDim2.new(1, -10, 1, -70)
    scroll.Position = UDim2.new(0, 5, 0, 54)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = THEME.MAIN
    scroll.ZIndex = 10
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.None
    
    local listLayout = Instance.new("UIListLayout", scroll)
    listLayout.Name = "ListLayout"
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 4)
    
    local padding = Instance.new("UIPadding", scroll)
    padding.PaddingTop = UDim.new(0, 4)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.PaddingLeft = UDim.new(0, 4)
    padding.PaddingRight = UDim.new(0, 4)
    
    local function updateCanvasSize()
        task.wait()
        local contentHeight = listLayout.AbsoluteContentSize.Y
        scroll.CanvasSize = UDim2.new(0, 0, 0, contentHeight + 16)
    end
    
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
    task.spawn(updateCanvasSize)
    
    return panel, scroll
end

--==================================================
-- AUTO TOTEM SECTION
--==================================================
if BackpackPage then
    local AutoTotemSection = CreateSectionDropdown(BackpackPage, "Auto Totem")
    
    Instance.new("UIListLayout", AutoTotemSection).SortOrder = Enum.SortOrder.LayoutOrder
    AutoTotemSection.UIListLayout.Padding = UDim.new(0, 6)
    
    local TotemPanel, TotemScroll = CreateSidePanel(Main, "Totem List", "Pilih totem yang mau dipasang.")
    
    local TO_TYPES = { "Lucky", "Mutasi", "Shiny", "Love" }
    
    local function rebuildTotemPanel()
        for _, c in ipairs(TotemScroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        
        for i, jenis in ipairs(TO_TYPES) do
            local id = TotemTypeId[jenis]
            local isSelected = (_G.RAYSelectedTotemType == jenis)
            
            local row = Instance.new("Frame", TotemScroll)
            row.Size = UDim2.new(1, -8, 0, 28)
            row.BackgroundTransparency = 1
            row.LayoutOrder = i
            row.ZIndex = 11
            
            local line = Instance.new("Frame", row)
            line.Name = "Highlight"
            line.Size = UDim2.new(0, 3, 1, 0)
            line.BackgroundColor3 = Color3.fromRGB(160, 110, 255)
            line.Visible = isSelected
            line.ZIndex = 12
            
            local btn = Instance.new("TextButton", row)
            btn.Size = UDim2.new(1, -6, 1, 0)
            btn.Position = UDim2.new(0, 6, 0, 0)
            btn.BackgroundColor3 = isSelected and Color3.fromRGB(40, 40, 70) or Color3.fromRGB(30, 30, 50)
            btn.TextColor3 = THEME.TEXT
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 12
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Text = "  " .. jenis .. " Totem"
            btn.ZIndex = 11
            
            CreateCorner(btn, 6)
            
            btn.MouseButton1Click:Connect(function()
                _G.RAYSelectedTotemType = isSelected and nil or jenis
                if NotifyFeature then NotifyFeature("Totem " .. jenis, not isSelected) end
                rebuildTotemPanel()
            end)
        end
        
        task.wait()
        local listLayout = TotemScroll:FindFirstChild("ListLayout")
        if listLayout then
            TotemScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 16)
        end
    end
    
    rebuildTotemPanel()
    
    CreateToggleRow(AutoTotemSection, "Enable Auto Totem (1x Cast)", _G.RAYAutoTotemOn, function(state)
        _G.RAYAutoTotemOn = state
        if state then
            local uuid = findTotemUuidByType(_G.RAYSelectedTotemType or "Lucky")
            if uuid then
                SpawnTotemUUID(uuid)
                if NotifyFeature then NotifyFeature("Spawn " .. (_G.RAYSelectedTotemType or "Lucky") .. " Totem", true) end
            else
                if NotifyFeature then NotifyFeature("Totem " .. (_G.RAYSelectedTotemType or "Lucky") .. " tidak ditemukan", false) end
            end
        else
            if NotifyFeature then NotifyFeature("Auto Totem OFF", false) end
        end
    end, { ActiveColor = Color3.fromRGB(0, 200, 150) })
    
    do
        local row = Instance.new("Frame", AutoTotemSection)
        row.Size = UDim2.new(1, 0, 0, 40)
        row.BackgroundTransparency = 1
        
        CreateLabel(row, {
            Size = UDim2.new(1, -110, 1, 0),
            Position = UDim2.new(0, 16, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = THEME.TEXT,
            Text = "Totem List Panel"
        })
        
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0, 120, 0, 24)
        btn.Position = UDim2.new(1, -136, 0.5, -12)
        btn.BackgroundColor3 = THEME.CARD
        btn.BackgroundTransparency = 0.1
        btn.Text = "Open"
        btn.TextColor3 = THEME.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        
        CreateCorner(btn, 8)
        
        btn.MouseButton1Click:Connect(function()
            TotemPanel.Visible = not TotemPanel.Visible
            if TotemPanel.Visible then rebuildTotemPanel() end
        end)
    end
    
    UIS.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        if not TotemPanel.Visible then return end
        
        local pos = input.Position
        local absPos, absSize = TotemPanel.AbsolutePosition, TotemPanel.AbsoluteSize
        
        local inside = pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
                       pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y
        
        if not inside then TotemPanel.Visible = false end
    end)
end

--==================================================
-- GEAR PRESET SECTION
--==================================================
if BackpackPage then
    local GearPresetSection = CreateSectionDropdown(BackpackPage, "Gear Preset")
    
    Instance.new("UIListLayout", GearPresetSection).SortOrder = Enum.SortOrder.LayoutOrder
    GearPresetSection.UIListLayout.Padding = UDim.new(0, 6)
    
    local function CreateGearToggle(parent, name, globalKey, onCallback, offCallback)
        _G[globalKey] = _G[globalKey] or false
        
        CreateToggleRow(parent, name, _G[globalKey], function(state)
            _G[globalKey] = state
            if state then
                if onCallback then onCallback() end
            else
                if offCallback then offCallback() end
            end
        end, { ActiveColor = Color3.fromRGB(0, 200, 150) })
    end
    
    local function GetEquipTankRF()
        local ok, rf = pcall(function()
            return ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/EquipOxygenTank")
        end)
        return ok and rf or nil
    end
    
    CreateGearToggle(GearPresetSection, "Advance Diving Gear", "RAY_AdvanceDivingOn",
        function()
            local rf = GetEquipTankRF()
            if rf then
                local ok, res = pcall(function() return rf:InvokeServer(575) end)
                if not ok then warn("[Threeblox] Equip tank failed:", res) end
            else
                warn("[Threeblox] EquipOxygenTank RF not found")
            end
        end,
        function()
            if Events and Events.unequip then
                pcall(function() Events.unequip:FireServer() end)
            end
        end
    )
    
    local function GetRadarRF()
        local ok, rf = pcall(function()
            return ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/UpdateFishingRadar")
        end)
        return ok and rf or nil
    end
    
    CreateGearToggle(GearPresetSection, "Fishing Radar", "RAY_FishingRadarOn",
        function()
            local rf = GetRadarRF()
            if rf then
                local ok, res = pcall(function() return rf:InvokeServer(true) end)
                if not ok then warn("[Threeblox] Radar toggle failed:", res) end
            else
                warn("[Threeblox] UpdateFishingRadar RF not found")
            end
        end,
        function()
            local rf = GetRadarRF()
            if rf then pcall(function() rf:InvokeServer(false) end) end
        end
    )
end

--==================================================
-- POTION SYSTEM
--==================================================
_G.RAYSelectedPotionType = _G.RAYSelectedPotionType or "Luck I Potion"
_G.RAYPotionQty = _G.RAYPotionQty or 1

local ConsumePotionRF = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/ConsumePotion")
local ConsumeCaveCrystalRF = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/ConsumeCaveCrystal")

local PotionTypeId = {
    ["Luck I Potion"] = 1,
    ["Luck II Potion"] = 6,
    ["Mutation I Potion"] = 4,
    ["Love I Potion"] = 15,
}

local POTION_NAMES = { "Luck I Potion", "Luck II Potion", "Mutation I Potion", "Love I Potion", "Cave Crystal" }

local function GetReplionData()
    local ok, data = pcall(function() return Replion.Client:WaitReplion("Data").Data end)
    return ok and data or nil
end

local function findPotionUuidByType(potionName)
    local targetId = PotionTypeId[potionName]
    if not targetId then return nil end
    
    local data = GetReplionData()
    if not data then return nil end
    
    local potions = data.Inventory and data.Inventory.Potions
    if typeof(potions) ~= "table" then return nil end
    
    for _, entry in pairs(potions) do
        if entry.Id == targetId then return entry.UUID end
    end
    return nil
end

local function ConsumeSelectedPotion()
    local potionName = _G.RAYSelectedPotionType or "Luck I Potion"
    local qty = math.max(1, tonumber(_G.RAYPotionQty) or 1)
    
    if potionName == "Cave Crystal" then
        for i = 1, qty do pcall(function() ConsumeCaveCrystalRF:InvokeServer() end) end
        if NotifyFeature then NotifyFeature("Consume Cave Crystal x" .. qty, true) end
        return
    end
    
    local uuid = findPotionUuidByType(potionName)
    if not uuid then
        if NotifyFeature then NotifyFeature("Potion " .. potionName .. " tidak ditemukan", false) end
        return
    end
    
    pcall(function() ConsumePotionRF:InvokeServer(uuid, qty) end)
    if NotifyFeature then NotifyFeature("Consume " .. potionName .. " x" .. qty, true) end
end

--==================================================
-- POTION SECTION
--==================================================
if BackpackPage then
    local PotionSection = CreateSectionDropdown(BackpackPage, "Potion Preset")
    
    Instance.new("UIListLayout", PotionSection).SortOrder = Enum.SortOrder.LayoutOrder
    PotionSection.UIListLayout.Padding = UDim.new(0, 6)
    
    local PotionPanel, PotionScroll = CreateSidePanel(Main, "Potion List", "Pilih potion dan set quantity.")
    
    local function rebuildPotionPanel()
        for _, c in ipairs(PotionScroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        
        for i, name in ipairs(POTION_NAMES) do
            local row = Instance.new("Frame", PotionScroll)
            row.Size = UDim2.new(1, -8, 0, 28)
            row.BackgroundTransparency = 1
            row.LayoutOrder = i
            row.ZIndex = 11
            
            local line = Instance.new("Frame", row)
            line.Name = "Highlight"
            line.Size = UDim2.new(0, 3, 1, 0)
            line.BackgroundColor3 = THEME.MAIN
            line.Visible = (_G.RAYSelectedPotionType == name)
            line.ZIndex = 12
            
            local btn = Instance.new("TextButton", row)
            btn.Size = UDim2.new(1, -6, 1, 0)
            btn.Position = UDim2.new(0, 4, 0, 0)
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            btn.TextColor3 = THEME.TEXT
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 12
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Text = "  " .. name
            btn.ZIndex = 11
            
            CreateCorner(btn, 6)
            
            btn.MouseButton1Click:Connect(function()
                _G.RAYSelectedPotionType = name
                for _, child in ipairs(PotionScroll:GetChildren()) do
                    local hl = child:FindFirstChild("Highlight")
                    if hl then hl.Visible = (child == row) end
                end
                if NotifyFeature then NotifyFeature("Selected " .. name, true) end
            end)
        end
        
        task.wait()
        local listLayout = PotionScroll:FindFirstChild("ListLayout")
        if listLayout then
            PotionScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 16)
        end
    end
    
    rebuildPotionPanel()
    
    do
        local row = Instance.new("Frame", PotionSection)
        row.Size = UDim2.new(1, 0, 0, 36)
        row.BackgroundTransparency = 1
        
        CreateLabel(row, {
            Size = UDim2.new(1, -110, 1, 0),
            Position = UDim2.new(0, 16, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = THEME.TEXT,
            Text = "Potion Quantity"
        })
        
        local qtyBox = Instance.new("TextBox", row)
        qtyBox.Size = UDim2.new(0, 60, 0, 24)
        qtyBox.Position = UDim2.new(1, -150, 0.5, -12)
        qtyBox.BackgroundColor3 = THEME.CARD
        qtyBox.BackgroundTransparency = 0.1
        qtyBox.Text = tostring(_G.RAYPotionQty)
        qtyBox.TextColor3 = THEME.TEXT
        qtyBox.Font = Enum.Font.Gotham
        qtyBox.TextSize = 12
        qtyBox.ClearTextOnFocus = false
        
        CreateCorner(qtyBox, 8)
        
        qtyBox.FocusLost:Connect(function()
            local n = tonumber(qtyBox.Text)
            if not n or n < 1 then n = 1; qtyBox.Text = "1" end
            _G.RAYPotionQty = n
        end)
        
        local useBtn = Instance.new("TextButton", row)
        useBtn.Size = UDim2.new(0, 80, 0, 24)
        useBtn.Position = UDim2.new(1, -60, 0.5, -12)
        useBtn.BackgroundColor3 = THEME.CARD
        useBtn.BackgroundTransparency = 0.1
        useBtn.Text = "Use"
        useBtn.TextColor3 = THEME.TEXT
        useBtn.Font = Enum.Font.GothamBold
        useBtn.TextSize = 12
        
        CreateCorner(useBtn, 8)
        useBtn.MouseButton1Click:Connect(ConsumeSelectedPotion)
    end
    
    do
        local row = Instance.new("Frame", PotionSection)
        row.Size = UDim2.new(1, 0, 0, 40)
        row.BackgroundTransparency = 1
        
        CreateLabel(row, {
            Size = UDim2.new(1, -110, 1, 0),
            Position = UDim2.new(0, 16, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = THEME.TEXT,
            Text = "Potion List Panel"
        })
        
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0, 120, 0, 24)
        btn.Position = UDim2.new(1, -136, 0.5, -12)
        btn.BackgroundColor3 = THEME.CARD
        btn.BackgroundTransparency = 0.1
        btn.Text = "Open"
        btn.TextColor3 = THEME.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        
        CreateCorner(btn, 8)
        btn.MouseButton1Click:Connect(function()
            PotionPanel.Visible = not PotionPanel.Visible
            if PotionPanel.Visible then rebuildPotionPanel() end
        end)
    end
    
    UIS.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        if not PotionPanel.Visible then return end
        
        local pos = input.Position
        local absPos, absSize = PotionPanel.AbsolutePosition, PotionPanel.AbsoluteSize
        local inside = pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y
        
        if not inside then PotionPanel.Visible = false end
    end)
end

--==================================================
-- ENCHANT SYSTEM
--==================================================
_G.RAY_EnchantAutoOn = _G.RAY_EnchantAutoOn or false
_G.RAY_EnchantTargetSlot = _G.RAY_EnchantTargetSlot or 1
_G.RAY_EnchantStoneId = _G.RAY_EnchantStoneId or 10
_G.RAY_EnchantTargetName = _G.RAY_EnchantTargetName or "Leprechaun I"

local EnchantingController = require(ReplicatedStorage.Controllers.EnchantingController)
local RollEnchantRE = Net:RemoteEvent("RollEnchant")

local StoneConfig = {
    [10] = { Name = "Enchant Stone", Enchants = {"Leprechaun I", "Leprechaun II", "Mutation Hunter I", "Mutation Hunter II", "Gold Digger I", "Reeler I", "Big Hunter I", "Empowered I", "Glistening I", "Stargazer I", "Stormhunter I", "XPerienced I", "Cursed I", "Prismatic I"} },
    [125] = { Name = "Super Enchant Stone", Enchants = {"Leprechaun II", "Mutation Hunter II", "Empowered I", "Cursed I", "Prismatic I"} },
    [558] = { Name = "Evolved Enchant Stone", Enchants = {"Leprechaun II", "Mutation Hunter II", "Mutation Hunter III", "Reeler II", "Gold Digger I", "Fairy Hunter I", "Stargazer II", "Stormhunter II", "Empowered I", "Cursed I", "Prismatic I", "Shark Hunter", "SECRET Hunter"} },
    [246] = { Name = "Transcended Stone", Enchants = {"Perfection", "Leprechaun I", "Leprechaun II", "Mutation Hunter I", "Mutation Hunter II", "Gold Digger I", "Reeler I", "Big Hunter I", "Empowered I", "Glistening I", "Stargazer I", "Stormhunter I", "XPerienced I", "Cursed I", "Prismatic I"} },
}

local StoneList = {10, 125, 558, 246}

local EnchantIdToName = {
    [3] = "Big Hunter I", [12] = "Cursed I", [9] = "Empowered I", [4] = "Gold Digger I",
    [1] = "Glistening I", [24] = "Glistening II", [5] = "Leprechaun I", [6] = "Leprechaun II",
    [7] = "Mutation Hunter I", [14] = "Mutation Hunter II", [22] = "Mutation Hunter III",
    [15] = "Perfection", [13] = "Prismatic I", [2] = "Reeler I", [21] = "Reeler II",
    [16] = "SECRET Hunter", [20] = "Shark Hunter", [8] = "Stargazer I", [17] = "Stargazer II",
    [11] = "Stormhunter I", [19] = "Stormhunter II", [10] = "XPerienced I",
}

local CF_Altar = {
    CFrame.new(3232.90356, -1302.8551, 1401.0824, 0.483647138, 0, -0.875263095, 0, 1, 0, 0.875263095, 0, 0.483647138),
    CFrame.new(1486.06165, 127.624977, -590.121094, 0.998732686, 0, 0.0503287315, 0, 1, 0, -0.0503287315, 0, 0.998732686)
}

local EquipItemRE = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RE/EquipItem")
local EquipToolFromHotbarRE = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RE/EquipToolFromHotbar")

local function TpAltar(slot)
    local chr = Player.Character or Player.CharacterAdded:Wait()
    local hrp = chr:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CF_Altar[slot]
        if NotifyFeature then NotifyFeature("TP Altar Slot " .. slot, true) end
    end
end

local function GetMainData()
    local ok, r = pcall(function() return Replion.Client:WaitReplion("Data").Data end)
    return ok and r or nil
end

local function findStoneEntryById(stoneId)
    local data = GetMainData()
    if not data then return nil end
    local items = data.Inventory and data.Inventory.Items
    if typeof(items) ~= "table" then return nil end
    for _, entry in pairs(items) do
        if entry.Id == stoneId then return entry end
    end
    return nil
end

local function EquipStoneById(stoneId)
    local entry = findStoneEntryById(stoneId)
    if not entry then
        if NotifyFeature then NotifyFeature("Stone Id " .. stoneId .. " tidak ditemukan", false) end
        return
    end
    pcall(function() EquipItemRE:FireServer(entry.UUID or entry.Uuid, "Enchant Stones") end)
    if NotifyFeature then NotifyFeature("Equip Stone Id " .. stoneId, true) end
end

local TargetId = nil
local function refreshTarget()
    TargetId = nil
    for id, name in pairs(EnchantIdToName) do
        if name == _G.RAY_EnchantTargetName then TargetId = id; break end
    end
end
refreshTarget()

RollEnchantRE.OnClientEvent:Connect(function(_, winningEnchantId)
    if _G.RAY_EnchantAutoOn and TargetId and winningEnchantId == TargetId then
        _G.RAY_EnchantAutoOn = false
        if NotifyFeature then NotifyFeature("Stop: dapet " .. _G.RAY_EnchantTargetName, true) end
    end
end)

local function DoAltarEnchantOnce()
    task.spawn(function()
        pcall(function() EquipToolFromHotbarRE:FireServer(2) end)
        task.wait(0.2)
        
        if _G.RAY_EnchantStoneId then
            EquipStoneById(_G.RAY_EnchantStoneId)
            task.wait(0.2)
        end
        
        local ok = pcall(function()
            return EnchantingController:Activate(_G.RAY_EnchantTargetSlot == 2):catch(function(msg)
                if NotifyFeature then NotifyFeature("Enchant error: " .. msg, false) end
            end):await()
        end)
        
        if NotifyFeature then NotifyFeature(ok and "Enchant roll" or "Enchant failed", ok) end
    end)
end

task.spawn(function()
    while true do
        if _G.RAY_EnchantAutoOn then DoAltarEnchantOnce() end
        task.wait(0.8)
    end
end)

--==================================================
-- ENCHANT SECTION
--==================================================
if BackpackPage then
    local EnchantSection = CreateSectionDropdown(BackpackPage, "Enchant Preset")
    
    Instance.new("UIListLayout", EnchantSection).SortOrder = Enum.SortOrder.LayoutOrder
    EnchantSection.UIListLayout.Padding = UDim.new(0, 6)
    
    CreateLabel(EnchantSection, {
        Size = UDim2.new(1, -20, 0, 18),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(255, 200, 120),
        Text = "NOTE: Taruh batu enchant di slot kanan tas (hotbar 2)."
    })
    
    local StonePanel, StoneScroll = CreateSidePanel(Main, "Stone List", "Pilih batu enchant untuk slot.")
    local EnchantPanel, EnchantScroll = CreateSidePanel(Main, "Enchant List", "Pilih enchant target sesuai batu.")
    
    local function rebuildStonePanel()
        for _, c in ipairs(StoneScroll:GetChildren()) do 
            if c:IsA("Frame") then c:Destroy() end 
        end
        
        for i, id in ipairs(StoneList) do
            local cfg = StoneConfig[id]
            if cfg then
                local row = Instance.new("Frame", StoneScroll)
                row.Size = UDim2.new(1, -8, 0, 28)
                row.BackgroundTransparency = 1
                row.LayoutOrder = i
                row.ZIndex = 11
                
                local line = Instance.new("Frame", row)
                line.Name = "Highlight"
                line.Size = UDim2.new(0, 3, 1, 0)
                line.BackgroundColor3 = THEME.MAIN
                line.Visible = (_G.RAY_EnchantStoneId == id)
                line.ZIndex = 12
                
                local btn = Instance.new("TextButton", row)
                btn.Size = UDim2.new(1, -6, 1, 0)
                btn.Position = UDim2.new(0, 4, 0, 0)
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
                btn.TextColor3 = THEME.TEXT
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 12
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.Text = string.format("  %s (Id %d)", cfg.Name, id)
                btn.ZIndex = 11
                
                CreateCorner(btn, 6)
                
                btn.MouseButton1Click:Connect(function()
                    _G.RAY_EnchantStoneId = id
                    _G.RAY_EnchantTargetName = cfg.Enchants[1] or _G.RAY_EnchantTargetName
                    refreshTarget()
                    if NotifyFeature then NotifyFeature("Enchant Stone: " .. cfg.Name, true) end
                    rebuildStonePanel()
                    rebuildEnchantPanel()
                end)
            end
        end
        
        task.wait()
        local listLayout = StoneScroll:FindFirstChild("ListLayout")
        if listLayout then
            StoneScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 16)
        end
    end
    
    local function rebuildEnchantPanel()
        for _, c in ipairs(EnchantScroll:GetChildren()) do 
            if c:IsA("Frame") then c:Destroy() end 
        end
        
        local cfg = StoneConfig[_G.RAY_EnchantStoneId]
        local list = cfg and cfg.Enchants or {}
        
        for i, name in ipairs(list) do
            local row = Instance.new("Frame", EnchantScroll)
            row.Size = UDim2.new(1, -8, 0, 28)
            row.BackgroundTransparency = 1
            row.LayoutOrder = i
            row.ZIndex = 11
            
            local line = Instance.new("Frame", row)
            line.Name = "Highlight"
            line.Size = UDim2.new(0, 3, 1, 0)
            line.BackgroundColor3 = THEME.MAIN
            line.Visible = (_G.RAY_EnchantTargetName == name)
            line.ZIndex = 12
            
            local btn = Instance.new("TextButton", row)
            btn.Size = UDim2.new(1, -6, 1, 0)
            btn.Position = UDim2.new(0, 4, 0, 0)
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            btn.TextColor3 = THEME.TEXT
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 12
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Text = "  " .. name
            btn.ZIndex = 11
            
            CreateCorner(btn, 6)
            
            btn.MouseButton1Click:Connect(function()
                _G.RAY_EnchantTargetName = name
                refreshTarget()
                if NotifyFeature then NotifyFeature("Target Enchant: " .. name, true) end
                rebuildEnchantPanel()
            end)
        end
        
        task.wait()
        local listLayout = EnchantScroll:FindFirstChild("ListLayout")
        if listLayout then
            EnchantScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 16)
        end
    end
    
    rebuildStonePanel()
    rebuildEnchantPanel()
    
    do
        local row = Instance.new("Frame", EnchantSection)
        row.Size = UDim2.new(1, 0, 0, 36)
        row.BackgroundTransparency = 1
        
        CreateLabel(row, {
            Size = UDim2.new(1, -110, 1, 0),
            Position = UDim2.new(0, 16, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = THEME.TEXT,
            Text = "Target Slot"
        })
        
        for i = 1, 2 do
            local btn = Instance.new("TextButton", row)
            btn.Size = UDim2.new(0, 60, 0, 24)
            btn.Position = UDim2.new(1, -130 + (i-1) * 65, 0.5, -12)
            btn.BackgroundColor3 = THEME.CARD
            btn.BackgroundTransparency = 0.1
            btn.TextColor3 = THEME.TEXT
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 12
            btn.Text = "Slot " .. i
            
            CreateCorner(btn, 8)
            
            btn.MouseButton1Click:Connect(function()
                _G.RAY_EnchantTargetSlot = i
                for j = 1, 2 do
                    local other = row:FindFirstChild("Slot" .. j) or row:GetChildren()[j + 1]
                    if other and other:IsA("TextButton") then
                        other.BackgroundColor3 = (j == i) and THEME.ACCENT or THEME.CARD
                    end
                end
                if NotifyFeature then NotifyFeature("Target Slot " .. i, true) end
            end)
            
            btn.Name = "Slot" .. i
            if i == _G.RAY_EnchantTargetSlot then btn.BackgroundColor3 = THEME.ACCENT end
        end
    end
    
    do
        local row = Instance.new("Frame", EnchantSection)
        row.Size = UDim2.new(1, 0, 0, 36)
        row.BackgroundTransparency = 1
        
        CreateLabel(row, {
            Size = UDim2.new(1, -110, 1, 0),
            Position = UDim2.new(0, 16, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = THEME.TEXT,
            Text = "Stone List Panel"
        })
        
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0, 120, 0, 24)
        btn.Position = UDim2.new(1, -136, 0.5, -12)
        btn.BackgroundColor3 = THEME.CARD
        btn.BackgroundTransparency = 0.1
        btn.Text = "Open"
        btn.TextColor3 = THEME.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        
        CreateCorner(btn, 8)
        btn.MouseButton1Click:Connect(function()
            StonePanel.Visible = not StonePanel.Visible
            if StonePanel.Visible then rebuildStonePanel() end
        end)
    end
    
    do
        local row = Instance.new("Frame", EnchantSection)
        row.Size = UDim2.new(1, 0, 0, 36)
        row.BackgroundTransparency = 1
        
        CreateLabel(row, {
            Size = UDim2.new(1, -110, 1, 0),
            Position = UDim2.new(0, 16, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = THEME.TEXT,
            Text = "Enchant List Panel"
        })
        
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0, 120, 0, 24)
        btn.Position = UDim2.new(1, -136, 0.5, -12)
        btn.BackgroundColor3 = THEME.CARD
        btn.BackgroundTransparency = 0.1
        btn.Text = "Open"
        btn.TextColor3 = THEME.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        
        CreateCorner(btn, 8)
        btn.MouseButton1Click:Connect(function()
            EnchantPanel.Visible = not EnchantPanel.Visible
            if EnchantPanel.Visible then rebuildEnchantPanel() end
        end)
    end
    
    CreateToggleRow(EnchantSection, "Auto Enchant", _G.RAY_EnchantAutoOn, function(state)
        _G.RAY_EnchantAutoOn = state
        if NotifyFeature then NotifyFeature("Auto Enchant", state) end
    end, { ActiveColor = THEME.ACCENT })
    
    do
        local row = Instance.new("Frame", EnchantSection)
        row.Size = UDim2.new(1, 0, 0, 36)
        row.BackgroundTransparency = 1
        
        CreateLabel(row, {
            Size = UDim2.new(1, -170, 1, 0),
            Position = UDim2.new(0, 16, 0, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = THEME.TEXT,
            Text = "Teleport Altar"
        })
        
        for i, name in ipairs({"Esoteric", "Temple"}) do
            local btn = Instance.new("TextButton", row)
            btn.Size = UDim2.new(0, 80, 0, 24)
            btn.Position = UDim2.new(1, -170 + (i-1) * 85, 0.5, -12)
            btn.BackgroundColor3 = THEME.CARD
            btn.BackgroundTransparency = 0.1
            btn.Text = name
            btn.TextColor3 = THEME.TEXT
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 12
            
            CreateCorner(btn, 8)
            btn.MouseButton1Click:Connect(function() TpAltar(i) end)
        end
    end
    
    UIS.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        
        local function outside(panel)
            if not panel or not panel.Visible then return false end
            local pos = input.Position
            local absPos, absSize = panel.AbsolutePosition, panel.AbsoluteSize
            return not (pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y)
        end
        
        if outside(StonePanel) then StonePanel.Visible = false end
        if outside(EnchantPanel) then EnchantPanel.Visible = false end
    end)
end

print("[Backpack] All sections loaded with fixed scrolling (no duplicates)")



--==================================================
-- ISLAND TELEPORT CF DATA
--==================================================

--==================================================
-- FIXED CTP FUNCTION - Proper Scrolling
--==================================================
function CTP(n,i)
    local p=Instance.new("Frame",Main)
    p.Name,p.Size,p.AnchorPoint,p.Position=n.."RightPanel",UDim2.new(0,220,1,-46),Vector2.new(1,0),UDim2.new(1,-10,0,40)
    p.BackgroundColor3,p.BackgroundTransparency,p.BorderSizePixel,p.Visible,p.ZIndex=THEME.CARD,0.25,0,false,10
    CC(p,10)
    CS(p,THEME.MAIN,0.5)
    
    -- Title
    CL(p,{
        Size=UDim2.new(1,-10,0,24),
        Position=UDim2.new(0,5,0,6),
        BackgroundTransparency=1,
        Font=Enum.Font.GothamBold,
        TextSize=16,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextColor3=THEME.TEXT,
        ZIndex=11,
        Text=n
    })
    
    -- Subtitle
    CL(p,{
        Size=UDim2.new(1,-10,0,18),
        Position=UDim2.new(0,5,0,30),
        BackgroundTransparency=1,
        Font=Enum.Font.Gotham,
        TextSize=12,
        TextXAlignment=Enum.TextXAlignment.Left,
        TextColor3=Color3.fromRGB(200,200,200),
        ZIndex=11,
        Text=i
    })
    
    -- ScrollingFrame dengan proper setup
    local s=Instance.new("ScrollingFrame",p)
    s.Name=n.."Scroll"
    s.Size=UDim2.new(1,-10,1,-70)
    s.Position=UDim2.new(0,5,0,54)
    s.BackgroundTransparency=1
    s.BorderSizePixel=0
    s.ScrollBarThickness=3
    s.ScrollBarImageColor3=THEME.MAIN
    s.ZIndex=10
    -- FIX: AutomaticCanvasSize untuk auto resize
    s.AutomaticCanvasSize=Enum.AutomaticSize.Y
    s.CanvasSize=UDim2.new(0,0,0,0)
    
    -- UIListLayout
    local layout=Instance.new("UIListLayout",s)
    layout.SortOrder=Enum.SortOrder.LayoutOrder
    layout.Padding=UDim.new(0,4)
    
    return p,s
end

--==================================================
-- ISLAND TELEPORT CF DATA
--==================================================
IslandTeleportCF={["Arrow Artifact"]=CFrame.new(879.857178,4.92162275,-339.661469,-0.195367768,0,0.980730057,0,1,0,-0.980730057,0,-0.195367768),["Crescent Artifact"]=CFrame.new(1382.48401,4.83972979,113.104294,-0.956645668,0,0.291254193,0,1,0,-0.291254193,0,-0.956645668),["Diamond Artifact"]=CFrame.new(1835.33704,4.92876816,-314.988342,0.219969183,0,-0.975506842,0,1,0,0.975506842,0,0.219969183),["Heartfelt Island"]=CFrame.new(1112.6106,4.84564829,2719.63818,-0.0125409178,-5.2643145e-08,-0.999921381,-1.06123528e-08,1,-5.2514185e-08,0.999921381,9.95294158e-09,-0.0125409178),["Hourglass Diamond Artifact"]=CFrame.new(1500.73413,6.37703848,-849.561951,-0.983483791,0,-0.180996269,0,1,0,0.180996269,0,-0.983483791),["Ancient Jungle"]=CFrame.new(1470.92688,4.58799648,-323.604401,-0.240510166,0,-0.97064662,0,1,0,0.97064662,0,-0.240510166),["Ancient Ruin"]=CFrame.new(6082.87842,-585.924316,4633.71631,-0.681475937,0,0.731840551,0,1,0,-0.731840551,0,-0.681475937),["Cavern Volcanic 1"]=CFrame.new(1258.64758,83.4165039,-10248.0986,0.00370242121,-1.42619994e-09,0.999993145,-5.48521122e-14,1,1.42620993e-09,-0.999993145,-5.3352817e-12,0.00370242121),["Cavern Volcanic 2"]=CFrame.new(1106.69495,86.072998,-10248.0986,-0.00201654364,-2.72424678e-08,0.999997973,-5.50374711e-11,1,2.72424128e-08,-0.999997973,-1.01846327e-13,-0.00201654364),["Coral Reefs"]=CFrame.new(-2917.92163,3.24999928,2073.65894,0.185246676,0,0.982692063,0,1,0,-0.982692063,0,0.185246676),["Crater Island"]=CFrame.new(1021.73822,22.0761662,5075.62207,0.110775813,0,-0.993845403,0,1,0,0.993845403,0,0.110775813),["Crystalline Passage"]=CFrame.new(6050.46533,-538.900208,4374.14404,-0.999980807,0,0.00619776407,0,1,0,-0.00619776407,0,-0.999980807),["Crystal Depths"]=CFrame.new(5816.59766,-905.712524,15416.5459,0.653240383,0,-0.75715059,0,1,0,0.75715059,0,0.653240383),["Esoteric Depths"]=CFrame.new(3232.90356,-1302.8551,1401.0824,0.483647138,0,-0.875263095,0,1,0,0.875263095,0,0.483647138),["Fisherman Spawn"]=CFrame.new(94.4113464,17.0335178,2832.35474,0.997892678,0,0.0648857802,0,1,0,-0.0648857802,0,0.997892678),["Kohana"]=CFrame.new(-661.520142,17.2500553,525.53125,0.379789084,-3.69101372e-08,-0.925073087,-4.96903567e-08,1,-6.03000885e-08,0.925073087,6.88685304e-08,0.379789084),["Kohana Volcano"]=CFrame.new(-615.731567,48.5698662,189.133865,0.256806821,0,0.966462731,0,1,0,-0.966462731,0,0.256806821),["Lava Basin"]=CFrame.new(893.590942,89.0328979,-10196.835,-0.435751051,6.88466599e-08,-0.90006721,-2.40178668e-08,1,8.81183837e-08,0.90006721,6.0015374e-08,-0.435751051),["Maze Room"]=CFrame.new(3439.70679,-287.844818,3390.59546,-0.96200937,0,-0.273016393,0,1,0,0.273016393,0,-0.96200937),["Pirate Cove"]=CFrame.new(3408.83179,3.73505521,3444.31812,-0.76647383,0,-0.642275512,0,1,0,0.642275512,0,-0.76647383),["Pirate Cove Leviathan"]=CFrame.new(3471.53125,-287.84317,3474.38257,-0.962593496,0,-0.270949841,0,1,0,0.270949841,0,-0.962593496),["Pirate Treasure Room"]=CFrame.new(3291.12646,-299.092438,3068.04639,0.483647138,0,-0.875263095,0,1,0,0.875263095,0,0.483647138),["Sacred Temple"]=CFrame.new(1496.13306,-22.1250019,-639.212097,0.987680018,0,0.156487122,0,1,0,-0.156487122,0,0.987680018),["Sysphus State"]=CFrame.new(-3656.59058,-134.150406,-959.743469,-0.287091494,0,0.957903147,0,1,0,-0.957903147,0,-0.287091494),["Temple Guardian"]=CFrame.new(1486.06165,127.624977,-590.121094,0.998732686,0,0.0503287315,0,1,0,-0.0503287315,0,0.998732686),["Treasure Room"]=CFrame.new(-3598.04102,-275.723602,-1640.93933,-0.203907222,0,0.978990197,0,1,0,-0.978990197,0,-0.203907222),["Tropical Grove"]=CFrame.new(-2016.4812,9.03753567,3752.35327,-0.995569646,0,0.0940273255,0,1,0,-0.0940273255,0,-0.995569646),["Underground Cellar"]=CFrame.new(2125.30005,-91.1976624,-750.400024,-0.661489964,0,-0.749954045,0,1,0,0.749954045,0,-0.661489964),["Weather Machine"]=CFrame.new(-1476.29089,3.49999928,1909.09583,-0.429490566,0,-0.903071344,0,1,0,0.903071344,0,-0.429490566)}

_G.RAY=_G.RAY or{GhostSharkHuntActive=false,MegalodonHuntActive=false,SavedPositions={},SelectedMerchantItem=nil,MerchantBuyQty=1,ChestFarmOn=false,ChestFarmReplionReady=false,LochNess={CurrentState="IDLE",NextEventTime=0,EventEndTime=0,IsAutoTeleported=false,IsReturned=false,SavedPosition=nil,AutoTeleportEnabled=false}}

TeleportPage,ShopPage=Pages["Teleport"],Pages["Shop"]
if not TeleportPage or not ShopPage then warn("Pages not found")return end

-- Helper functions - minimized locals
function CC(p,r)local c=Instance.new("UICorner",p)c.CornerRadius=UDim.new(0,r or 8)return c end
function CS(p,c,t)local s=Instance.new("UIStroke",p)s.Color,s.Thickness,s.Transparency=c or THEME.MAIN,t or 1,0.5 return s end
function CL(p,pr)local l=Instance.new("TextLabel",p)for k,v in pairs(pr)do l[k]=v end return l end
function CLE(p,t,o)local r=Instance.new("Frame",p)r.Size,r.BackgroundTransparency,r.ZIndex=UDim2.new(1,-4,0,28),1,11 Instance.new("Frame",r).Name,Instance.new("Frame",r).Size,Instance.new("Frame",r).BackgroundColor3,Instance.new("Frame",r).Visible,Instance.new("Frame",r).ZIndex="Highlight",UDim2.new(0,3,1,0),THEME.MAIN,false,12 local b=Instance.new("TextButton",r)b.Size,b.Position,b.BackgroundColor3,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment,b.Text,b.ZIndex=UDim2.new(1,-6,1,0),UDim2.new(0,4,0,0),Color3.fromRGB(30,30,50),Color3.fromRGB(255,255,255),Enum.Font.Gotham,12,Enum.TextXAlignment.Left,"  "..t,11 CC(b,6)b.MouseButton1Click:Connect(function()o()for _,c in ipairs(p:GetChildren())do local h=c:FindFirstChild("Highlight")if h then h.Visible=(c==r)end end end)return r end
function CSR(p,t,b,o)local r=Instance.new("Frame",p)r.Size,r.BackgroundTransparency=UDim2.new(1,0,0,36),1 CL(r,{Size=UDim2.new(1,-110,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text=t})local btn=Instance.new("TextButton",r)btn.Size,btn.Position,btn.BackgroundColor3,btn.BackgroundTransparency,btn.Text,btn.TextColor3,btn.Font,btn.TextSize=UDim2.new(0,110,0,24),UDim2.new(1,-126,0.5,-12),THEME.CARD,0.1,b,THEME.TEXT,Enum.Font.GothamBold,12 CC(btn,8)btn.MouseButton1Click:Connect(o)return r end
function TC(t)local c=0 for _ in pairs(t)do c=c+1 end return c end
function FN(n)if n>=1000000 then return string.format("%.1fm",n/1000000)elseif n>=1000 then return string.format("%.1fk",n/1000)else return tostring(n)end end

-- Island Teleport
IslandSection=CreateSectionDropdown(TeleportPage,"Teleport Island")Instance.new("UIListLayout",IslandSection).SortOrder=Enum.SortOrder.LayoutOrder IslandSection.UIListLayout.Padding=UDim.new(0,6)IslandPanel,IslandScroll=CTP("Teleport Island","Pilih lokasi island untuk teleport.")function TTI(cf,l)local h=(Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")if h then h.CFrame=cf if NotifyFeature then NotifyFeature("Teleport: "..l,true)end end end islandNames={}for n in pairs(IslandTeleportCF)do table.insert(islandNames,n)end table.sort(islandNames)for _,n in ipairs(islandNames)do CLE(IslandScroll,n,function()TTI(IslandTeleportCF[n],n)end)end CSR(IslandSection,"Teleport Island Panel","Open",function()IslandPanel.Visible=not IslandPanel.Visible end)

-- Player Teleport
PlayerSection=CreateSectionDropdown(TeleportPage,"Teleport Player")Instance.new("UIListLayout",PlayerSection).SortOrder=Enum.SortOrder.LayoutOrder PlayerSection.UIListLayout.Padding=UDim.new(0,6)PlayerPanel,PlayerScroll=CTP("Teleport Player","Pilih player untuk teleport ke posisi mereka.")function TTP(tp)if not tp or tp==Player then return end local m,t=(Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart"),tp.Character and tp.Character:FindFirstChild("HumanoidRootPart")if m and t then m.CFrame=t.CFrame if NotifyFeature then NotifyFeature("Teleport to: "..tp.Name,true)end end end function CPE(plr)CLE(PlayerScroll,plr.Name,function()TTP(plr)end).Name="PlayerRow_"..plr.Name end for _,plr in ipairs(Players:GetPlayers())do if plr~=Player then CPE(plr)end end Players.PlayerAdded:Connect(function(plr)if plr~=Player then CPE(plr)end end)Players.PlayerRemoving:Connect(function(plr)local r=PlayerScroll:FindFirstChild("PlayerRow_"..plr.Name)if r then r:Destroy()end end)CSR(PlayerSection,"Teleport Player Panel","Open",function()PlayerPanel.Visible=not PlayerPanel.Visible end)

-- Event Hunt
ghostSharkFloor=nil function GSM()local pr=Workspace:FindFirstChild("Props")if not pr then return nil end local m=pr:FindFirstChild("Shark Hunt")or pr:FindFirstChild("Ghost Shark Hunt")return(m and m:IsA("Model"))and m or nil end function EFS()local m=GSM()if not m then return nil,nil end if not m.PrimaryPart then local a=m:FindFirstChildWhichIsA("BasePart",true)if a then m.PrimaryPart=a end end local an=m.PrimaryPart if not an then return nil,nil end if not ghostSharkFloor or not ghostSharkFloor.Parent then ghostSharkFloor=Instance.new("Part")ghostSharkFloor.Name,ghostSharkFloor.Anchored,ghostSharkFloor.CanCollide,ghostSharkFloor.Transparency,ghostSharkFloor.Size,ghostSharkFloor.Material,ghostSharkFloor.Parent="SharkHuntFloor_Client",true,true,1,Vector3.new(80,1,80),Enum.Material.SmoothPlastic,Workspace end ghostSharkFloor.CFrame=CFrame.new(Vector3.new(an.Position.X,an.Position.Y-2,an.Position.Z))return an,ghostSharkFloor end function TTGS()local a,f=EFS()if not a or not f then return end local c,r=Player.Character or Player.CharacterAdded:Wait(),(Player.Character or Player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")r.AssemblyLinearVelocity,r.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)c:PivotTo(CFrame.new(f.Position+Vector3.new(0,f.Size.Y/2+4,0),f.Position+Vector3.new(0,f.Size.Y/2+4,0)+a.CFrame.LookVector))end function TTM()local a for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name=="Megalodon Hunt"then a=o break end end if not a then return end local c,r=Player.Character or Player.CharacterAdded:Wait(),(Player.Character or Player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")r.AssemblyLinearVelocity,r.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)c:PivotTo(CFrame.new(a.Position+Vector3.new(0,5,0),a.Position+Vector3.new(0,5,0)+a.CFrame.LookVector))end task.spawn(function()local ok,rp=pcall(function()return require(ReplicatedStorage.Packages.Replion)end)if not ok or not rp or not rp.Client then return end local sc,er=pcall(function()return rp.Client:WaitReplion("Events")end)if not sc or not er then return end local function oi(i,n)if n=="Shark Hunt"then _G.RAY.GhostSharkHuntActive=true if NotifyFeature then NotifyFeature("Ghost Shark Hunt Spawned!",true)end end end local function orm(i,n)if n=="Shark Hunt"then _G.RAY.GhostSharkHuntActive=false if ghostSharkFloor then ghostSharkFloor:Destroy()ghostSharkFloor=nil end if NotifyFeature then NotifyFeature("Ghost Shark Hunt Ended",false)end end end er:OnArrayInsert("Events",oi)er:OnArrayRemove("Events",orm)for i,n in ipairs(er:Get("Events")or{})do oi(i,n)end end)EventHuntSection=CreateSectionDropdown(TeleportPage,"Event Hunt")Instance.new("UIListLayout",EventHuntSection).SortOrder=Enum.SortOrder.LayoutOrder EventHuntSection.UIListLayout.Padding=UDim.new(0,6)EventHuntPanel,EventHuntScroll=CTP("Event Hunt","Pilih hunt event untuk teleport.")CLE(EventHuntScroll,"Ghost Shark Hunt",function()if not _G.RAY.GhostSharkHuntActive then if NotifyFeature then NotifyFeature("Ghost Shark Hunt not active!",false)end return end TTGS()if NotifyFeature then NotifyFeature("Teleported to Ghost Shark Hunt",true)end end)CLE(EventHuntScroll,"Megalodon Hunt",function()if not _G.RAY.MegalodonHuntActive then if NotifyFeature then NotifyFeature("Megalodon Hunt not found!",false)end return end TTM()if NotifyFeature then NotifyFeature("Teleported to Megalodon Hunt",true)end end)task.spawn(function()while true do for _,e in ipairs(EventHuntScroll:GetChildren())do if e:IsA("Frame")then local b,h=e:FindFirstChildOfClass("TextButton"),e:FindFirstChild("Highlight")if b and h then if b.Text:find("Ghost Shark")then if _G.RAY.GhostSharkHuntActive then b.BackgroundColor3,h.Visible=Color3.fromRGB(40,70,40),true else b.BackgroundColor3,h.Visible=Color3.fromRGB(30,30,50),false end elseif b.Text:find("Megalodon")then local ex=false for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name=="Megalodon Hunt"then ex=true break end end _G.RAY.MegalodonHuntActive=ex if ex then b.BackgroundColor3,h.Visible=Color3.fromRGB(40,70,40),true else b.BackgroundColor3,h.Visible=Color3.fromRGB(30,30,50),false end end end end end task.wait(1)end end)CSR(EventHuntSection,"Event Hunt Panel","Open",function()EventHuntPanel.Visible=not EventHuntPanel.Visible end)

--==================================================
-- LOCH NESS EVENT - FIXED TIMER LOGIC
--==================================================
ANCIENT_RUIN_CF=CFrame.new(6082.87842,-585.924316,4633.71631,-0.681475937,0,0.731840551,0,1,0,-0.731840551,0,-0.681475937)
EVENT_DURATION_MINUTES=10
EVENT_HOURS_UTC={0,4,8,12,16,20}
EVENT_STATE={IDLE="IDLE",ACTIVE="ACTIVE",ENDED="ENDED"}

-- FIX: Calculate next event time properly
function GNES()
    local n=os.date("!*t",os.time())
    local nm=n.hour*60+n.min
    
    for _,h in ipairs(EVENT_HOURS_UTC) do
        if h*60 > nm then
            -- Event is later today
            return os.time({year=n.year,month=n.month,day=n.day,hour=h,min=0,sec=0,isdst=false})
        end
    end
    -- Next event is tomorrow at first hour
    return os.time({year=n.year,month=n.month,day=n.day+1,hour=EVENT_HOURS_UTC[1],min=0,sec=0,isdst=false})
end

function FT(s)
    s=math.max(0,math.floor(s))
    return string.format("%02d:%02d:%02d",math.floor(s/3600),math.floor((s%3600)/60),s%60)
end

function SCP()
    local c,h=Player.Character,Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not h then return false end
    _G.RAY.LochNess.SavedPosition={Position=h.CFrame.Position,LookVector=h.CFrame.LookVector,Time=os.time()}
    return true
end

function TTAR()
    local c,h=Player.Character or Player.CharacterAdded:Wait(),(Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if not h then return end
    h.AssemblyLinearVelocity,h.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)
    c:PivotTo(ANCIENT_RUIN_CF)
    if NotifyFeature then NotifyFeature("Teleported to Ancient Ruin!",true) end
end

function RTSP()
    local d=_G.RAY.LochNess.SavedPosition
    if not d then
        if NotifyFeature then NotifyFeature("No saved position!",false) end
        return
    end
    local c,h=Player.Character or Player.CharacterAdded:Wait(),(Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if not h then return end
    h.CFrame=CFrame.new(d.Position,d.Position+d.LookVector)
    if NotifyFeature then NotifyFeature("Returned to saved position!",true) end
end

-- FIXED: Timer logic - when reaches 0, start 10 min countdown, then reset to 4 hours
function ULS()
    local n,s=os.time(),_G.RAY.LochNess
    
    if s.CurrentState==EVENT_STATE.IDLE then
        if n >= s.NextEventTime then
            -- Event starts now
            s.CurrentState=EVENT_STATE.ACTIVE
            s.EventEndTime=n+(EVENT_DURATION_MINUTES*60)
            s.IsAutoTeleported=false
            s.IsReturned=false
            return"EVENT_START"
        end
    elseif s.CurrentState==EVENT_STATE.ACTIVE then
        if n >= s.EventEndTime then
            -- Event ends, go to ENDED state
            s.CurrentState=EVENT_STATE.ENDED
            return"EVENT_END"
        end
    elseif s.CurrentState==EVENT_STATE.ENDED then
        -- FIX: Reset to IDLE and calculate next event (4 hours later)
        s.NextEventTime=GNES()
        s.CurrentState=EVENT_STATE.IDLE
        s.IsAutoTeleported=false
        s.IsReturned=false
        return"RESET"
    end
    return nil
end

function GLDT()
    local n,s=os.time(),_G.RAY.LochNess
    if s.CurrentState==EVENT_STATE.IDLE then
        local remaining=s.NextEventTime-n
        if remaining <= 0 then
            return"Starting...",0,Color3.fromRGB(0,255,140)
        end
        return"Next Event:",remaining,Color3.fromRGB(0,255,140)
    elseif s.CurrentState==EVENT_STATE.ACTIVE then
        local remaining=s.EventEndTime-n
        if remaining <= 0 then
            return"Ending...",0,Color3.fromRGB(255,140,0)
        end
        return"Event Ends:",remaining,Color3.fromRGB(255,140,0)
    else
        return"Resetting...",0,Color3.fromRGB(255,80,80)
    end
end

function HLAA()
    local s=_G.RAY.LochNess
    if s.CurrentState==EVENT_STATE.ACTIVE and s.AutoTeleportEnabled and not s.IsAutoTeleported then
        if SCP() then
            task.wait(0.5)
            TTAR()
            s.IsAutoTeleported=true
        end
    end
    if s.CurrentState==EVENT_STATE.ENDED and s.AutoTeleportEnabled and s.IsAutoTeleported and not s.IsReturned then
        task.wait(1)
        RTSP()
        s.IsReturned=true
    end
end

LochNessSection=CreateSectionDropdown(TeleportPage,"Lochnes Event")
Instance.new("UIListLayout",LochNessSection).SortOrder=Enum.SortOrder.LayoutOrder
LochNessSection.UIListLayout.Padding=UDim.new(0,6)

TimerRow=Instance.new("Frame",LochNessSection)
TimerRow.Size,TimerRow.BackgroundTransparency=UDim2.new(1,0,0,40),1

TimerLabel=CL(TimerRow,{
    Size=UDim2.new(0.4,-10,1,0),
    Position=UDim2.new(0,16,0,0),
    BackgroundTransparency=1,
    Font=Enum.Font.Gotham,
    TextSize=13,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextColor3=THEME.TEXT,
    Text="Next Event:"
})

TimeDisplay=Instance.new("TextLabel",TimerRow)
TimeDisplay.Name,TimeDisplay.Size,TimeDisplay.Position,TimeDisplay.BackgroundColor3,TimeDisplay.BackgroundTransparency,TimeDisplay.Font,TimeDisplay.TextSize,TimeDisplay.TextColor3,TimeDisplay.Text="LochNessTimeDisplay",UDim2.new(0.35,0,0,28),UDim2.new(0.4,0,0.5,-14),Color3.fromRGB(20,20,30),0.2,Enum.Font.GothamBold,16,Color3.fromRGB(0,255,140),"00:00:00"
CC(TimeDisplay,6)

StatusLabel=CL(TimerRow,{
    Size=UDim2.new(0.25,0,0,20),
    Position=UDim2.new(0.75,-5,0.5,-10),
    BackgroundTransparency=1,
    Font=Enum.Font.GothamBold,
    TextSize=11,
    TextXAlignment=Enum.TextXAlignment.Center,
    TextColor3=Color3.fromRGB(100,100,100),
    Text="IDLE"
})

TeleportRow=Instance.new("Frame",LochNessSection)
TeleportRow.Size,TeleportRow.BackgroundTransparency=UDim2.new(1,0,0,36),1
CL(TeleportRow,{
    Size=UDim2.new(1,-130,1,0),
    Position=UDim2.new(0,16,0,0),
    BackgroundTransparency=1,
    Font=Enum.Font.Gotham,
    TextSize=13,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextColor3=THEME.TEXT,
    Text="Teleport to Ancient Ruin"
})

TeleportBtn=Instance.new("TextButton",TeleportRow)
TeleportBtn.Size,TeleportBtn.Position,TeleportBtn.BackgroundColor3,TeleportBtn.Text,TeleportBtn.TextColor3,TeleportBtn.Font,TeleportBtn.TextSize=UDim2.new(0,110,0,26),UDim2.new(1,-126,0.5,-13),Color3.fromRGB(40,70,40),"Teleport",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12
CC(TeleportBtn,8)
TeleportBtn.MouseButton1Click:Connect(function()
    if _G.RAY.LochNess.CurrentState==EVENT_STATE.ACTIVE and not _G.RAY.LochNess.SavedPosition then
        SCP()
    end
    TTAR()
end)

ReturnRow=Instance.new("Frame",LochNessSection)
ReturnRow.Size,ReturnRow.BackgroundTransparency=UDim2.new(1,0,0,36),1
CL(ReturnRow,{
    Size=UDim2.new(1,-130,1,0),
    Position=UDim2.new(0,16,0,0),
    BackgroundTransparency=1,
    Font=Enum.Font.Gotham,
    TextSize=13,
    TextXAlignment=Enum.TextXAlignment.Left,
    TextColor3=THEME.TEXT,
    Text="Return to Saved Pos"
})

ReturnBtn=Instance.new("TextButton",ReturnRow)
ReturnBtn.Size,ReturnBtn.Position,ReturnBtn.BackgroundColor3,ReturnBtn.Text,ReturnBtn.TextColor3,ReturnBtn.Font,ReturnBtn.TextSize=UDim2.new(0,110,0,26),UDim2.new(1,-126,0.5,-13),Color3.fromRGB(70,40,40),"Return",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12
CC(ReturnBtn,8)
ReturnBtn.MouseButton1Click:Connect(RTSP)

-- FIX: Auto TP Toggle dengan CreateTogglePill callback yang benar
AutoTeleportRow=Instance.new("Frame",LochNessSection)
AutoTeleportRow.Size=UDim2.new(1,0,0,36)
AutoTeleportRow.BackgroundTransparency=1

-- Gunakan CreateTogglePill dengan callback
local AutoTeleportGet, AutoTeleportSet = CreateTogglePill(AutoTeleportRow, "Auto TP + Return", _G.RAY.LochNess.AutoTeleportEnabled, function(isOn)
    _G.RAY.LochNess.AutoTeleportEnabled = isOn
    if NotifyFeature then 
        NotifyFeature("Loch Ness Auto: "..(isOn and "ON" or "OFF"), isOn) 
    end
end)

-- Init Next Event Time
_G.RAY.LochNess.NextEventTime=GNES()

-- Main Loop
task.spawn(function()
    while true do
        local sc=ULS()
        HLAA()
        local lt,tv,tc=GLDT()
        TimerLabel.Text,TimeDisplay.Text,TimeDisplay.TextColor3=lt,FT(tv),tc
        local st=_G.RAY.LochNess.CurrentState
        StatusLabel.Text=st
        StatusLabel.TextColor3=(st==EVENT_STATE.IDLE and Color3.fromRGB(100,200,100) or (st==EVENT_STATE.ACTIVE and Color3.fromRGB(255,200,100) or Color3.fromRGB(255,100,100)))
        
        if sc and NotifyFeature then
            if sc=="EVENT_START" then
                NotifyFeature("Loch Ness Event STARTED!",true)
            elseif sc=="EVENT_END" then
                NotifyFeature("Loch Ness Event ENDED!",false)
            end
        end
        task.wait(0.5)
    end
end)

--==================================================
-- CHEST FARM SECTION (FIXED - Manual Claim)
--==================================================
ChestFarmSection = CreateSectionDropdown(TeleportPage, "Chest Pirate Treasureroom")
Instance.new("UIListLayout", ChestFarmSection).SortOrder = Enum.SortOrder.LayoutOrder
ChestFarmSection.UIListLayout.Padding = UDim.new(0, 6)

-- Status Row
local ChestFarmStatusRow = Instance.new("Frame", ChestFarmSection)
ChestFarmStatusRow.Size = UDim2.new(1, 0, 0, 30)
ChestFarmStatusRow.BackgroundTransparency = 1

ChestFarmInfoLabel = CL(ChestFarmStatusRow, {
    Size = UDim2.new(0.6, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    Text = "Waiting Replion..."
})

-- Count label
ChestCountLabel = CL(ChestFarmStatusRow, {
    Size = UDim2.new(0.4, -10, 1, 0),
    Position = UDim2.new(0.6, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextColor3 = Color3.fromRGB(0, 255, 140),
    Text = "Chests: 0"
})

-- Chest Farm Variables
local chestReplion = nil
local ClaimPirateChest = nil

-- Ambil RE dengan pcall (sama persis)
task.spawn(function()
    local success, result = pcall(function()
        local netFolder = ReplicatedStorage
            :WaitForChild("Packages")
            :WaitForChild("_Index")
            :WaitForChild("sleitnick_net@0.2.0")
            :WaitForChild("net")
        return netFolder:WaitForChild("RE/ClaimPirateChest")
    end)
    
    if success then
        ClaimPirateChest = result
        print("[ChestFarm] RE initialized:", ClaimPirateChest:GetFullName())
    else
        warn("[ChestFarm] Failed to get RE:", result)
        ChestFarmInfoLabel.Text = "RE Error!"
        ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Init Replion (sama persis)
task.spawn(function()
    local ok, r = pcall(function()
        return Replion.Client:WaitReplion("PirateTreasureChests")
    end)
    
    print("[ChestFarm] WaitReplion:", ok, r)
    
    if not ok or not r or typeof(r.Data) ~= "table" then
        ChestFarmInfoLabel.Text = "Replion failed"
        ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("[ChestFarm] Failed to get PirateTreasureChests")
        return
    end
    
    chestReplion = r
    ChestFarmInfoLabel.Text = "Replion ready"
    ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    print("[ChestFarm] Replion Data:", chestReplion.Data)
end)

-- Function GetAllChestUUIDs (SAMA PERSIS)
local function GetAllChestUUIDs()
    if not chestReplion then return {} end
    local data = chestReplion.Data
    local spawned = data and data.SpawnedChests
    if typeof(spawned) ~= "table" then return {} end

    local list = {}
    for i, entry in ipairs(spawned) do
        local uuid = entry.Id
        local pos = entry.Location
        if typeof(uuid) == "string" then
            table.insert(list, uuid)
        end
    end
    return list
end

-- MANUAL CLAIM BUTTON (GANTI TOGGLE AUTO)
local ClaimButtonRow = Instance.new("Frame", ChestFarmSection)
ClaimButtonRow.Size = UDim2.new(1, 0, 0, 40)
ClaimButtonRow.BackgroundTransparency = 1

CL(ClaimButtonRow, {
    Size = UDim2.new(1, -110, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Claim All Chests"
})

local claimBtn = Instance.new("TextButton", ClaimButtonRow)
claimBtn.Size = UDim2.new(0, 90, 0, 28)
claimBtn.Position = UDim2.new(1, -110, 0.5, -14)
claimBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)  -- Green
claimBtn.Text = "CLAIM"
claimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
claimBtn.Font = Enum.Font.GothamBold
claimBtn.TextSize = 12
CreateCorner(claimBtn, 6)

-- Claim logic (sama persis dari farm loop tapi manual)
claimBtn.MouseButton1Click:Connect(function()
    if not chestReplion then
        ChestFarmInfoLabel.Text = "Replion not ready!"
        ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    if not ClaimPirateChest then
        ChestFarmInfoLabel.Text = "RE not ready!"
        ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    local uuids = GetAllChestUUIDs()
    ChestCountLabel.Text = "Chests: " .. #uuids
    
    if #uuids == 0 then
        ChestFarmInfoLabel.Text = "No chests spawned"
        ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    else
        ChestFarmInfoLabel.Text = "Claiming " .. #uuids .. " chests..."
        ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(0, 255, 140)
        
        for _, uuid in ipairs(uuids) do
            pcall(function()
                ClaimPirateChest:FireServer(uuid)
            end)
        end
        
        -- Feedback visual
        claimBtn.Text = "DONE!"
        claimBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
        task.delay(1, function()
            claimBtn.Text = "CLAIM"
            claimBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        end)
    end
end)

-- AUTO UPDATE COUNT (opsional - biar tau jumlah chest tanpa claim)
task.spawn(function()
    while true do
        task.wait(1)
        if chestReplion then
            local uuids = GetAllChestUUIDs()
            ChestCountLabel.Text = "Chests: " .. #uuids
            
            if #uuids > 0 and ChestFarmInfoLabel.Text == "Replion ready" then
                ChestFarmInfoLabel.Text = #uuids .. " chests available"
                ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            end
        end
    end
end)

print("[ChestFarm] Section loaded with manual claim")

-- Saved Positions
--==================================================
-- SAVED POSITIONS SYSTEM - AUTO TELEPORT ON RESPAWN
--==================================================

function GCP()
    local c, h = Player.Character, Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    return h and h.CFrame or nil
end

function SP(n)
    local cf = GCP()
    if not cf then
        if NotifyFeature then NotifyFeature("Failed to save position!", false) end
        return false
    end
    _G.RAY.SavedPositions[n] = {
        Position = cf.Position,
        LookVector = cf.LookVector,
        UpVector = cf.UpVector,
        Time = os.time()
    }
    -- Save ke file/datastore persisten (opsional)
    _G.RAY.LastSavedPosition = n
    if NotifyFeature then NotifyFeature("Saved position: " .. n, true) end
    return true
end

function TTS(n)
    local d = _G.RAY.SavedPositions[n]
    if not d then
        if NotifyFeature then NotifyFeature("Position not found: " .. n, false) end
        return false
    end
    local h = (Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if not h then return false end
    h.CFrame = CFrame.new(d.Position, d.Position + d.LookVector)
    if NotifyFeature then NotifyFeature("Teleported to: " .. n, true) end
    return true
end

function DSP(n)
    _G.RAY.SavedPositions[n] = nil
    if _G.RAY.LastSavedPosition == n then
        _G.RAY.LastSavedPosition = nil
    end
    if NotifyFeature then NotifyFeature("Deleted position: " .. n, true) end
end

--==================================================
-- AUTO TELEPORT SYSTEM (RESPAWN + EXECUTE)
--==================================================

-- Function untuk auto teleport ke posisi terakhir
local function AutoTeleportToLast()
    -- Cari posisi dengan Time paling baru (terakhir disave)
    local lastPosName, latestTime = nil, 0
    
    for n, d in pairs(_G.RAY.SavedPositions) do
        if d.Time and d.Time > latestTime then
            latestTime = d.Time
            lastPosName = n
        end
    end
    
    -- Kalau ada LastSavedPosition preferensi, pake itu dulu
    if _G.RAY.LastSavedPosition and _G.RAY.SavedPositions[_G.RAY.LastSavedPosition] then
        lastPosName = _G.RAY.LastSavedPosition
    end
    
    if lastPosName then
        -- Tunggu character ready
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        
        if hrp then
            -- Small delay biar spawn fully complete
            task.wait(0.5)
            TTS(lastPosName)
            print("[SavedPos] Auto teleported to:", lastPosName)
        end
    end
end

-- 1. AUTO TP PAS EXECUTE SCRIPT (delay 2 detik biar semua loaded)
task.spawn(function()
    task.wait(2)
    AutoTeleportToLast()
end)

-- 2. AUTO TP PAS RESPAWN
Player.CharacterAdded:Connect(function(newChar)
    -- Delay biar character fully loaded
    task.wait(1)
    
    -- Cek kalau ada Humanoid (pastikan bukan false respawn)
    local hum = newChar:WaitForChild("Humanoid", 3)
    if hum then
        AutoTeleportToLast()
    end
end)

--==================================================
-- SAVED POSITIONS SECTION UI
--==================================================

SavedPosSection = CreateSectionDropdown(TeleportPage, "Saved Positions")
Instance.new("UIListLayout", SavedPosSection).SortOrder = Enum.SortOrder.LayoutOrder
SavedPosSection.UIListLayout.Padding = UDim.new(0, 6)

SavedPosPanel, SavedPosScroll = CTP("Saved Positions", "Pilih posisi tersimpan untuk teleport.")

function RSPL()
    -- Clear existing
    for _, c in ipairs(SavedPosScroll:GetChildren()) do
        if c:IsA("Frame") then
            c:Destroy()
        end
    end
    
    -- Sort names by time (newest first)
    local ns = {}
    for n, d in pairs(_G.RAY.SavedPositions) do
        table.insert(ns, {name = n, time = d.Time or 0})
    end
    table.sort(ns, function(a, b) return a.time > b.time end)
    
    -- Create entries
    for _, entry in ipairs(ns) do
        local n = entry.name
        local r = Instance.new("Frame", SavedPosScroll)
        r.Size = UDim2.new(1, -4, 0, 28)
        r.BackgroundTransparency = 1
        r.ZIndex = 11
        
        -- Highlight indicator (mark last saved)
        local hl = Instance.new("Frame", r)
        hl.Name = "Highlight"
        hl.Size = UDim2.new(0, 3, 1, 0)
        hl.BackgroundColor3 = THEME.MAIN
        hl.Visible = (_G.RAY.LastSavedPosition == n)
        hl.ZIndex = 12
        
        -- Teleport button
        local b = Instance.new("TextButton", r)
        b.Size = UDim2.new(1, -30, 1, 0)
        b.Position = UDim2.new(0, 4, 0, 0)
        b.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.Gotham
        b.TextSize = 12
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.Text = "  " .. n
        b.ZIndex = 11
        CreateCorner(b, 6)
        
        -- Delete button
        local d = Instance.new("TextButton", r)
        d.Size = UDim2.new(0, 20, 0, 20)
        d.Position = UDim2.new(1, -26, 0.5, -10)
        d.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
        d.TextColor3 = Color3.fromRGB(255, 150, 150)
        d.Font = Enum.Font.GothamBold
        d.TextSize = 12
        d.Text = "X"
        d.ZIndex = 11
        CreateCorner(d, 4)
        
        -- Teleport click
        b.MouseButton1Click:Connect(function()
            TTS(n)
            for _, c in ipairs(SavedPosScroll:GetChildren()) do
                local h = c:FindFirstChild("Highlight")
                if h then h.Visible = false end
            end
            hl.Visible = true
        end)
        
        -- Delete click
        d.MouseButton1Click:Connect(function()
            DSP(n)
            RSPL()
        end)
    end
end

-- Save position row
do
    local r = Instance.new("Frame", SavedPosSection)
    r.Size = UDim2.new(1, 0, 0, 36)
    r.BackgroundTransparency = 1
    
    CreateLabel(r, {
        Size = UDim2.new(0.5, -20, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = THEME.TEXT,
        Text = "Save Current Pos"
    })
    
    -- Name textbox
    local nb = Instance.new("TextBox", r)
    nb.Size = UDim2.new(0.3, 0, 0, 24)
    nb.Position = UDim2.new(0.5, -10, 0.5, -12)
    nb.BackgroundColor3 = THEME.CARD
    nb.BackgroundTransparency = 0.12
    nb.Text = "Pos " .. (function() 
        local count = 0
        for _ in pairs(_G.RAY.SavedPositions) do count = count + 1 end
        return count
    end)()
    nb.TextColor3 = THEME.TEXT
    nb.Font = Enum.Font.Gotham
    nb.TextSize = 12
    nb.ClearTextOnFocus = true
    CreateCorner(nb, 6)
    
    -- Save button
    local sb = Instance.new("TextButton", r)
    sb.Size = UDim2.new(0, 60, 0, 24)
    sb.Position = UDim2.new(1, -70, 0.5, -12)
    sb.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
    sb.TextColor3 = THEME.TEXT
    sb.Font = Enum.Font.GothamBold
    sb.TextSize = 12
    sb.Text = "Save"
    CreateCorner(sb, 6)
    
    sb.MouseButton1Click:Connect(function()
        local nm = nb.Text:gsub("^%s+", ""):gsub("%s+$", "")
        if #nm == 0 then
            local count = 0
            for _ in pairs(_G.RAY.SavedPositions) do count = count + 1 end
            nm = "Pos " .. (count + 1)
        end
        if SP(nm) then
            RSPL()
            local newCount = 0
            for _ in pairs(_G.RAY.SavedPositions) do newCount = newCount + 1 end
            nb.Text = "Pos " .. (newCount + 1)
        end
    end)
end

-- Open panel button
CSR(SavedPosSection, "Saved Positions Panel", "Open", function()
    SavedPosPanel.Visible = not SavedPosPanel.Visible
    if SavedPosPanel.Visible then
        RSPL()
    end
end)

RSPL()

-- Close panels
AllPanels={IslandPanel,PlayerPanel,EventHuntPanel,SavedPosPanel}function IIP(p,pos)if not p or not p.Visible then return false end return(pos.X>=p.AbsolutePosition.X and pos.X<=p.AbsolutePosition.X+p.AbsoluteSize.X and pos.Y>=p.AbsolutePosition.Y and pos.Y<=p.AbsolutePosition.Y+p.AbsoluteSize.Y)end function IIS(s,pos)if not s then return false end return(pos.X>=s.AbsolutePosition.X and pos.X<=s.AbsolutePosition.X+s.AbsoluteSize.X and pos.Y>=s.AbsolutePosition.Y and pos.Y<=s.AbsolutePosition.Y+s.AbsoluteSize.Y)end UIS.InputBegan:Connect(function(i)if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end local pos=i.Position for _,p in ipairs(AllPanels)do if IIP(p,pos)then return end end for _,s in ipairs({IslandSection,PlayerSection,EventHuntSection,LochNessSection,ChestFarmSection,SavedPosSection})do if IIS(s,pos)then return end end for _,p in ipairs(AllPanels)do if p and p.Visible then p.Visible=false end end end)

-- Traveling Merchant - Ultra minimized
MerchantReplion=Replion.Client:WaitReplion("Merchant")MarketItemData=require(ReplicatedStorage.Shared.MarketItemData)PurchaseMarketItemRF=NetFolder:WaitForChild("RF/PurchaseMarketItem")MERCHANT_ITEM_MAP={}for _,i in ipairs(MarketItemData)do MERCHANT_ITEM_MAP[i.Id]=i end function GMS()local ids,stock=MerchantReplion:GetExpect("Items")or{},{}for _,id in ipairs(ids)do local d=MERCHANT_ITEM_MAP[id]if d then table.insert(stock,{Id=d.Id,Name=d.Identifier or d.Name or("Item_"..id),Price=d.Price or 0,Currency=d.Currency or"Coins",MaxStock=d.MaxStock or 1,Data=d})end end return stock end function BMI(id,q)q=math.max(1,tonumber(q)or 1)for i=1,q do task.spawn(function()pcall(function()PurchaseMarketItemRF:InvokeServer(id)end)end)task.wait(0.1)end return true end MerchantSection=CreateSectionDropdown(ShopPage,"Traveling Merchant")Instance.new("UIListLayout",MerchantSection).SortOrder=Enum.SortOrder.LayoutOrder MerchantSection.UIListLayout.Padding=UDim.new(0,6)MerchantPanel,MerchantScroll=CTP("Merchant Stock","Select item to purchase")StatusRow=Instance.new("Frame",MerchantSection)StatusRow.Size,StatusRow.BackgroundTransparency=UDim2.new(1,0,0,30),1 CL(StatusRow,{Size=UDim2.new(0.5,-10,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Merchant Status:"})MerchantStatus=CL(StatusRow,{Size=UDim2.new(0.5,-10,1,0),Position=UDim2.new(0.5,0,0,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(255,100,100),Text="Checking..."})SelectedRow=Instance.new("Frame",MerchantSection)SelectedRow.Size,SelectedRow.BackgroundTransparency=UDim2.new(1,0,0,30),1 CL(SelectedRow,{Size=UDim2.new(0.4,-10,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Selected:"})SelectedItemLabel=CL(SelectedRow,{Size=UDim2.new(0.6,-10,1,0),Position=UDim2.new(0.4,0,0,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(150,150,150),Text="None"})QuantityRow=Instance.new("Frame",MerchantSection)QuantityRow.Size,QuantityRow.BackgroundTransparency=UDim2.new(1,0,0,36),1 CL(QuantityRow,{Size=UDim2.new(0.4,-10,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Buy Quantity"})qtyBox=Instance.new("TextBox",QuantityRow)qtyBox.Size,qtyBox.Position,qtyBox.BackgroundColor3,qtyBox.BackgroundTransparency,qtyBox.Text,qtyBox.TextColor3,qtyBox.Font,qtyBox.TextSize,qtyBox.ClearTextOnFocus=UDim2.new(0,60,0,24),UDim2.new(0.4,-10,0.5,-12),THEME.CARD,0.1,tostring(_G.RAY.MerchantBuyQty),THEME.TEXT,Enum.Font.Gotham,12,false CC(qtyBox,8)qtyBox.FocusLost:Connect(function()local n=tonumber(qtyBox.Text)if not n or n<1 then n=1 qtyBox.Text="1"end _G.RAY.MerchantBuyQty=math.min(n,99)end)buyBtn=Instance.new("TextButton",QuantityRow)buyBtn.Size,buyBtn.Position,buyBtn.BackgroundColor3,buyBtn.TextColor3,buyBtn.Font,buyBtn.TextSize,buyBtn.Text=UDim2.new(0,80,0,24),UDim2.new(1,-90,0.5,-12),Color3.fromRGB(40,100,40),Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12,"BUY"CC(buyBtn,8)buyBtn.MouseButton1Click:Connect(function()if not _G.RAY.SelectedMerchantItem then if NotifyFeature then NotifyFeature("No item selected!",false)end return end BMI(_G.RAY.SelectedMerchantItem.Id,_G.RAY.MerchantBuyQty or 1)if NotifyFeature then NotifyFeature("Buying ".._G.RAY.SelectedMerchantItem.Name.." x"..(_G.RAY.MerchantBuyQty or 1),true)end end)CSR(MerchantSection,"Merchant Stock Panel","Open",function()MerchantPanel.Visible=not MerchantPanel.Visible if MerchantPanel.Visible then RMP()end end)function RMP()for _,c in ipairs(MerchantScroll:GetChildren())do if c:IsA("Frame")then c:Destroy()end end local stock=GMS()if#stock==0 then MerchantStatus.Text,MerchantStatus.TextColor3="Not Available",Color3.fromRGB(255,100,100)local er=Instance.new("Frame",MerchantScroll)er.Size,er.BackgroundTransparency=UDim2.new(1,-4,0,60),1 CL(er,{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,5,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Center,TextColor3=Color3.fromRGB(150,150,150),Text="No merchant stock available.\nCheck back later!"})_G.RAY.SelectedMerchantItem,SelectedItemLabel.Text,SelectedItemLabel.TextColor3=nil,"None",Color3.fromRGB(150,150,150)return end MerchantStatus.Text,MerchantStatus.TextColor3=#stock.." Items",Color3.fromRGB(0,255,140)for _,it in ipairs(stock)do local r=Instance.new("Frame",MerchantScroll)r.Size,r.BackgroundTransparency,r.ZIndex=UDim2.new(1,-4,0,40),1,11 local l=Instance.new("Frame",r)l.Name,l.Size,l.Position,l.BackgroundColor3,l.BorderSizePixel,l.Visible,l.ZIndex="Highlight",UDim2.new(0,3,1,0),UDim2.new(0,0,0,0),THEME.MAIN,0,(_G.RAY.SelectedMerchantItem and _G.RAY.SelectedMerchantItem.Id==it.Id),12 local b=Instance.new("TextButton",r)local priceText=FN(it.Price)b.Size,b.Position,b.BackgroundColor3,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment,b.TextYAlignment,b.Text,b.ZIndex=UDim2.new(1,-6,1,0),UDim2.new(0,6,0,0),Color3.fromRGB(30,30,50),THEME.TEXT,Enum.Font.Gotham,11,Enum.TextXAlignment.Left,Enum.TextYAlignment.Top,string.format("  %s\n  %s %s",it.Name,priceText,it.Currency),11 CC(b,6)if it.Currency:lower():find("robux")or it.Currency:lower():find("premium")then b.TextColor3=Color3.fromRGB(255,200,100)end b.MouseButton1Click:Connect(function()_G.RAY.SelectedMerchantItem=it SelectedItemLabel.Text,SelectedItemLabel.TextColor3=it.Name,Color3.fromRGB(0,255,140)for _,c in ipairs(MerchantScroll:GetChildren())do if c:IsA("Frame")then local h=c:FindFirstChild("Highlight")if h then h.Visible=(c==r)end end end if NotifyFeature then NotifyFeature("Selected: "..it.Name.." ("..priceText.." "..it.Currency..")",true)end end)end end RMP()MerchantReplion:OnChange("Items",function()if MerchantPanel.Visible then RMP()end local stock=GMS()if#stock>0 then MerchantStatus.Text,MerchantStatus.TextColor3=#stock.." Items",Color3.fromRGB(0,255,140)else MerchantStatus.Text,MerchantStatus.TextColor3,_G.RAY.SelectedMerchantItem,SelectedItemLabel.Text,SelectedItemLabel.TextColor3="Not Available",Color3.fromRGB(255,100,100),nil,"None",Color3.fromRGB(150,150,150)end end)table.insert(AllPanels,MerchantPanel)

--==================================================
-- COMPONENT: TOGGLE PILL (MODIFIED WITH CALLBACK)
--==================================================
local function CreateTogglePill(parent, labelText, default, onChangeCallback)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 36)
    row.BackgroundTransparency = 1

    CreateLabel(row, {
        Size = UDim2.new(1, -100, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = THEME.TEXT,
        Text = labelText
    })

    local pill = Instance.new("TextButton", row)
    pill.Size = UDim2.new(0, 50, 0, 24)
    pill.Position = UDim2.new(1, -80, 0.5, -12)
    pill.BackgroundTransparency = 0.1
    pill.Text = ""
    pill.AutoButtonColor = false

    CreateCorner(pill, 999)

    local knob = Instance.new("Frame", pill)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    CreateCorner(knob, 999)

    local state = not not default

    local function refresh()
        pill.BackgroundColor3 = state and THEME.ACCENT or THEME.MUTED
        knob.Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    end
    refresh()

    pill.MouseButton1Click:Connect(function()
        state = not state
        refresh()
        -- Panggil callback kalau ada
        if onChangeCallback then
            onChangeCallback(state)
        end
    end)

    return function() return state end, function(v) state = not not v; refresh() end
end

--==================================================
-- WEATHER PRESET SECTION (SHOP PAGE) - FIXED SCROLLING
--==================================================
WeatherSection = CreateSectionDropdown(ShopPage, "Weather Preset")
Instance.new("UIListLayout", WeatherSection).SortOrder = Enum.SortOrder.LayoutOrder
WeatherSection.UIListLayout.Padding = UDim.new(0, 6)

-- Panel kanan dengan scrolling yang proper
WeatherPanel = Instance.new("Frame", Main)
WeatherPanel.Name = "WeatherPresetRightPanel"
WeatherPanel.Size = UDim2.new(0, 220, 1, -46)
WeatherPanel.AnchorPoint = Vector2.new(1, 0)
WeatherPanel.Position = UDim2.new(1, -10, 0, 40)
WeatherPanel.BackgroundColor3 = THEME.CARD
WeatherPanel.BackgroundTransparency = 0.25
WeatherPanel.BorderSizePixel = 0
WeatherPanel.Visible = false
WeatherPanel.ZIndex = 10

CC(WeatherPanel, 10)
CS(WeatherPanel, THEME.MAIN, 0.5)

-- Title
CL(WeatherPanel, {
    Size = UDim2.new(1, -10, 0, 24),
    Position = UDim2.new(0, 5, 0, 6),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    ZIndex = 11,
    Text = "Weather Preset"
})

-- Subtitle
CL(WeatherPanel, {
    Size = UDim2.new(1, -10, 0, 18),
    Position = UDim2.new(0, 5, 0, 30),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    ZIndex = 11,
    Text = "Pilih weather untuk auto buy (max 4)"
})

-- Scrolling Frame dengan proper setup
WeatherScroll = Instance.new("ScrollingFrame", WeatherPanel)
WeatherScroll.Name = "WeatherScroll"
WeatherScroll.Size = UDim2.new(1, -10, 1, -70)
WeatherScroll.Position = UDim2.new(0, 5, 0, 54)
WeatherScroll.BackgroundTransparency = 1
WeatherScroll.BorderSizePixel = 0
WeatherScroll.ScrollBarThickness = 3
WeatherScroll.ScrollBarImageColor3 = THEME.MAIN
WeatherScroll.ZIndex = 10
-- PENTING: AutomaticCanvasSize untuk auto resize
WeatherScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
WeatherScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

-- UIListLayout untuk scrolling
local scrollLayout = Instance.new("UIListLayout", WeatherScroll)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.Padding = UDim.new(0, 4)

-- Data weather
local WEATHER_OPTIONS = {
    "Cloudy",
    "Radiant", 
    "Shark Hunt",
    "Snow",
    "Storm",
    "Wind",
}

local selectedWeather = {}

-- Ambil RF
local rf = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")
    :WaitForChild("RF/PurchaseWeatherEvent")

-- Helper
local function countSelected()
    local c = 0
    for _, on in pairs(selectedWeather) do
        if on then c = c + 1 end
    end
    return c
end

local function updateWeatherRows()
    for _, row in ipairs(WeatherScroll:GetChildren()) do
        if row:IsA("Frame") and row.Name:match("^WeatherRow_") then
            local highlight = row:FindFirstChild("Highlight")
            if highlight then
                local weatherName = row.Name:gsub("WeatherRow_", "")
                highlight.Visible = selectedWeather[weatherName] == true
            end
        end
    end
    if WeatherCountLabel then
        WeatherCountLabel.Text = "Selected: " .. countSelected() .. "/4"
    end
end

-- Buat list item dengan proper parent ke WeatherScroll
for i, weatherName in ipairs(WEATHER_OPTIONS) do
    local row = Instance.new("Frame", WeatherScroll)
    row.Size = UDim2.new(1, -4, 0, 28)
    row.BackgroundTransparency = 1
    row.Name = "WeatherRow_" .. weatherName
    row.LayoutOrder = i
    row.ZIndex = 11
    
    -- Purple highlight di kiri
    local highlight = Instance.new("Frame", row)
    highlight.Name = "Highlight"
    highlight.Size = UDim2.new(0, 3, 1, 0)
    highlight.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    highlight.BorderSizePixel = 0
    highlight.Visible = false
    highlight.ZIndex = 12
    
    -- Button dengan teks putih
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1, -6, 1, 0)
    btn.Position = UDim2.new(0, 6, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.Text = "  " .. weatherName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 11
    CC(btn, 6)
    
    btn.MouseButton1Click:Connect(function()
        if selectedWeather[weatherName] then
            selectedWeather[weatherName] = nil
        else
            if countSelected() >= 4 then
                if NotifyFeature then NotifyFeature("Max 4 weather only!", false) end
                return
            end
            selectedWeather[weatherName] = true
        end
        updateWeatherRows()
    end)
end

-- Counter label
local CountRow = Instance.new("Frame", WeatherSection)
CountRow.Size = UDim2.new(1, 0, 0, 30)
CountRow.BackgroundTransparency = 1

WeatherCountLabel = CL(CountRow, {
    Size = UDim2.new(0.5, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    Text = "Selected: 0/4"
})

-- Status label
local StatusRow = Instance.new("Frame", WeatherSection)
StatusRow.Size = UDim2.new(1, 0, 0, 24)
StatusRow.BackgroundTransparency = 1

local statusLabel = CL(StatusRow, {
    Size = UDim2.new(1, -32, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    Text = "Ready..."
})

-- Open/Close panel
CSR(WeatherSection, "Weather Panel", "Open", function()
    WeatherPanel.Visible = not WeatherPanel.Visible
end)

table.insert(AllPanels, WeatherPanel)

--==================================================
-- AUTO WEATHER TOGGLE PILL (PAKAI CALLBACK)
--==================================================
local AutoWeatherRow = Instance.new("Frame", WeatherSection)
AutoWeatherRow.Size = UDim2.new(1, 0, 0, 36)
AutoWeatherRow.BackgroundTransparency = 1

-- Auto weather variables
local autoWeatherEnabled = false
local autoWeatherThread = nil

-- Auto loop function
local function autoWeatherLoop()
    while autoWeatherEnabled do
        local count = countSelected()
        if count > 0 then
            statusLabel.Text = "Auto buying " .. count .. " weather..."
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 140)
            
            for name, on in pairs(selectedWeather) do
                if on then
                    local success, result = pcall(function()
                        return rf:InvokeServer(name)
                    end)
                    if success then
                        print("[WeatherAuto] Bought:", name, "Result:", result)
                    else
                        warn("[WeatherAuto] Failed:", name, "Error:", result)
                    end
                end
            end
        else
            statusLabel.Text = "No weather selected!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        task.wait(0.1)
    end
    
    statusLabel.Text = "Auto stopped"
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    autoWeatherThread = nil
end

-- TOGGLE PILL dengan callback
local AutoWeatherGet, AutoWeatherSet = CreateTogglePill(AutoWeatherRow, "Auto Weather", false, function(isOn)
    if isOn then
        if countSelected() == 0 then
            statusLabel.Text = "Select weather first!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            AutoWeatherSet(false)
            return
        end
        
        autoWeatherEnabled = true
        if not autoWeatherThread then
            autoWeatherThread = task.spawn(autoWeatherLoop)
        end
        if NotifyFeature then NotifyFeature("Auto Weather: ON", true) end
    else
        autoWeatherEnabled = false
        if NotifyFeature then NotifyFeature("Auto Weather: OFF", false) end
    end
end)

--==================================================
-- CHARM PRESET SECTION (SHOP PAGE) - TIER IN DATA ONLY
--==================================================
CharmSection = CreateSectionDropdown(ShopPage, "Charm Preset")
Instance.new("UIListLayout", CharmSection).SortOrder = Enum.SortOrder.LayoutOrder
CharmSection.UIListLayout.Padding = UDim.new(0, 6)

-- Panel kanan untuk Charm
CharmPanel = Instance.new("Frame", Main)
CharmPanel.Name = "CharmPresetRightPanel"
CharmPanel.Size = UDim2.new(0, 220, 1, -46)
CharmPanel.AnchorPoint = Vector2.new(1, 0)
CharmPanel.Position = UDim2.new(1, -10, 0, 40)
CharmPanel.BackgroundColor3 = THEME.CARD
CharmPanel.BackgroundTransparency = 0.25
CharmPanel.BorderSizePixel = 0
CharmPanel.Visible = false
CharmPanel.ZIndex = 10

CC(CharmPanel, 10)
CS(CharmPanel, THEME.MAIN, 0.5)

-- Title
CL(CharmPanel, {
    Size = UDim2.new(1, -10, 0, 24),
    Position = UDim2.new(0, 5, 0, 6),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    ZIndex = 11,
    Text = "Charm Preset"
})

-- Subtitle
CL(CharmPanel, {
    Size = UDim2.new(1, -10, 0, 18),
    Position = UDim2.new(0, 5, 0, 30),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    ZIndex = 11,
    Text = "Select charm to purchase/craft"
})

-- Scrolling Frame
CharmScroll = Instance.new("ScrollingFrame", CharmPanel)
CharmScroll.Name = "CharmScroll"
CharmScroll.Size = UDim2.new(1, -10, 1, -70)
CharmScroll.Position = UDim2.new(0, 5, 0, 54)
CharmScroll.BackgroundTransparency = 1
CharmScroll.BorderSizePixel = 0
CharmScroll.ScrollBarThickness = 3
CharmScroll.ScrollBarImageColor3 = THEME.MAIN
CharmScroll.ZIndex = 10
CharmScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
CharmScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local charmLayout = Instance.new("UIListLayout", CharmScroll)
charmLayout.SortOrder = Enum.SortOrder.LayoutOrder
charmLayout.Padding = UDim.new(0, 4)

-- FIX: Ambil remote langsung
local netPath = ReplicatedStorage.Packages["_Index"]["sleitnick_net@0.2.0"].net
local purchaseRemote = netPath:WaitForChild("RF/PurchaseCharm")
local startCraftRemote = netPath:WaitForChild("RF/StartCrafting")
local confirmCraftRemote = netPath:WaitForChild("RF/ConfirmCrafting")

print("[Charm] All remotes loaded!")

-- Data Charm (tier tetap ada di data tapi tidak ditampilkan)
local CHARM_DATA = {
    -- SHOP CHARMS
    {type = "shop", id = 14, name = "Heart Charm", price = "20k", tier = 3},
    {type = "shop", id = 4, name = "Clover Charm", price = "5k", tier = 3},
    {type = "shop", id = 1, name = "Bone Charm", price = "70k", tier = 6},
    {type = "shop", id = 2, name = "Algae Charm", price = "40k", tier = 5},
    {type = "shop", id = 3, name = "Magma Charm", price = "20k", tier = 6},
    
    -- CRAFT CHARMS
    {type = "craft", name = "Hook Charm", mats = "3x Rope", tier = 3},
    {type = "craft", name = "Winged Charm", mats = "2x Rope + Driftwood", tier = 3},
    {type = "craft", name = "Anchor Charm", mats = "Pyrafruit + Embercrux", tier = 5},
    {type = "craft", name = "Oculus Charm", mats = "Full Recipe", tier = 6},
    
    -- INFO ONLY
    {type = "info", name = "Silver Kraken", tier = 5},
    {type = "info", name = "Black Kraken", tier = 7},
    {type = "info", name = "Coral Charm", tier = 2},
    {type = "info", name = "Mermaid Charm", tier = 4}
}

-- Global variables
_G.RAY = _G.RAY or {}
_G.RAY.SelectedCharmItem = nil
_G.RAY.CharmBuyQty = 1

local selectedCharms = {}

local function updateCharmRows()
    for _, row in ipairs(CharmScroll:GetChildren()) do
        if row:IsA("Frame") and row.Name:match("^CharmRow_") then
            local highlight = row:FindFirstChild("Highlight")
            if highlight then
                local charmName = row.Name:gsub("CharmRow_", "")
                highlight.Visible = selectedCharms[charmName] == true
            end
        end
    end
end

-- Buat list charm (hanya nama, tanpa ID, tanpa emoji, TANPA TIER DI DISPLAY)
for i, charm in ipairs(CHARM_DATA) do
    local row = Instance.new("Frame", CharmScroll)
    row.Size = UDim2.new(1, -4, 0, 32)
    row.BackgroundTransparency = 1
    row.Name = "CharmRow_" .. charm.name
    row.LayoutOrder = i
    row.ZIndex = 11
    
    -- Purple highlight di kiri
    local highlight = Instance.new("Frame", row)
    highlight.Name = "Highlight"
    highlight.Size = UDim2.new(0, 3, 1, 0)
    highlight.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    highlight.BorderSizePixel = 0
    highlight.Visible = false
    highlight.ZIndex = 12
    
    -- Button dengan teks
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1, -6, 1, 0)
    btn.Position = UDim2.new(0, 6, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    
    -- FIX: Format display text (tanpa tier!)
    local displayText = "  " .. charm.name
    if charm.type == "shop" then
        displayText = displayText .. "\n  " .. charm.price .. " Coins"
    elseif charm.type == "craft" then
        displayText = displayText .. " [Craft]"
    elseif charm.type == "info" then
        displayText = displayText .. " [Info]"
    end
    -- TIDAK ADA TIER DI SINI!
    
    btn.Text = displayText
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextYAlignment = Enum.TextYAlignment.Top
    btn.ZIndex = 11
    CC(btn, 6)
    
    btn.MouseButton1Click:Connect(function()
        -- Single select
        for k, _ in pairs(selectedCharms) do
            selectedCharms[k] = nil
        end
        
        selectedCharms[charm.name] = true
        _G.RAY.SelectedCharmItem = charm
        
        updateCharmRows()
        
        if SelectedCharmLabel then
            SelectedCharmLabel.Text = charm.name
            SelectedCharmLabel.TextColor3 = Color3.fromRGB(0, 255, 140)
        end
        
        if NotifyFeature then
            NotifyFeature("Selected: " .. charm.name, true)
        end
    end)
end

-- Selected Row
local SelectedCharmRow = Instance.new("Frame", CharmSection)
SelectedCharmRow.Size = UDim2.new(1, 0, 0, 30)
SelectedCharmRow.BackgroundTransparency = 1

CL(SelectedCharmRow, {
    Size = UDim2.new(0.4, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Selected:"
})

SelectedCharmLabel = CL(SelectedCharmRow, {
    Size = UDim2.new(0.6, -10, 1, 0),
    Position = UDim2.new(0.4, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    Text = "None"
})

-- Quantity Row
local CharmQtyRow = Instance.new("Frame", CharmSection)
CharmQtyRow.Size = UDim2.new(1, 0, 0, 36)
CharmQtyRow.BackgroundTransparency = 1

CL(CharmQtyRow, {
    Size = UDim2.new(0.4, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Quantity"
})

-- Quantity Input
local charmQtyBox = Instance.new("TextBox", CharmQtyRow)
charmQtyBox.Size = UDim2.new(0, 60, 0, 24)
charmQtyBox.Position = UDim2.new(0.4, -10, 0.5, -12)
charmQtyBox.BackgroundColor3 = THEME.CARD
charmQtyBox.BackgroundTransparency = 0.1
charmQtyBox.Text = tostring(_G.RAY.CharmBuyQty)
charmQtyBox.TextColor3 = THEME.TEXT
charmQtyBox.Font = Enum.Font.Gotham
charmQtyBox.TextSize = 12
charmQtyBox.ClearTextOnFocus = false
CC(charmQtyBox, 8)

charmQtyBox.FocusLost:Connect(function()
    local n = tonumber(charmQtyBox.Text)
    if not n or n < 1 then
        n = 1
    end
    _G.RAY.CharmBuyQty = math.min(n, 99)
    charmQtyBox.Text = tostring(_G.RAY.CharmBuyQty)
end)

-- BUY Button
local charmBuyBtn = Instance.new("TextButton", CharmQtyRow)
charmBuyBtn.Size = UDim2.new(0, 80, 0, 24)
charmBuyBtn.Position = UDim2.new(1, -90, 0.5, -12)
charmBuyBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 40)
charmBuyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
charmBuyBtn.Font = Enum.Font.GothamBold
charmBuyBtn.TextSize = 12
charmBuyBtn.Text = "BUY"
CC(charmBuyBtn, 8)

-- Function Execute Charm
function ExecuteCharm(charmData, qty)
    qty = math.max(1, tonumber(qty) or 1)
    
    if charmData.type == "shop" then
        for i = 1, qty do
            task.spawn(function()
                pcall(function()
                    purchaseRemote:InvokeServer(charmData.id)
                    print("[Charm] Purchased:", charmData.name)
                end)
            end)
            task.wait(0.1)
        end
        return true
        
    elseif charmData.type == "craft" then
        for i = 1, qty do
            task.spawn(function()
                pcall(function()
                    startCraftRemote:InvokeServer(charmData.name)
                    task.wait(0.1)
                    confirmCraftRemote:InvokeServer()
                    print("[Charm] Crafted:", charmData.name)
                end)
            end)
            task.wait(0.2)
        end
        return true
        
    elseif charmData.type == "info" then
        if NotifyFeature then
            NotifyFeature(charmData.name .. " is info only!", false)
        end
        return false
    end
    
    return false
end

charmBuyBtn.MouseButton1Click:Connect(function()
    if not _G.RAY.SelectedCharmItem then
        if NotifyFeature then NotifyFeature("No charm selected!", false) end
        return
    end
    
    local charm = _G.RAY.SelectedCharmItem
    local qty = _G.RAY.CharmBuyQty or 1
    
    local success = ExecuteCharm(charm, qty)
    
    if success and NotifyFeature then
        local action = charm.type == "shop" and "Buying" or "Crafting"
        NotifyFeature(action .. " " .. charm.name .. " x" .. qty, true)
    end
end)

-- Open/Close panel
CSR(CharmSection, "Charm Panel", "Open", function()
    CharmPanel.Visible = not CharmPanel.Visible
end)

table.insert(AllPanels, CharmPanel)

--==================================================
-- BUY ROD SECTION - SAMA PERSIS KAYA CHARM
--==================================================

local BuyRodSection = CreateSectionDropdown(ShopPage, "Buy Rod")
Instance.new("UIListLayout", BuyRodSection).SortOrder = Enum.SortOrder.LayoutOrder
BuyRodSection.UIListLayout.Padding = UDim.new(0, 6)

-- Format harga ke K/M
local function FormatPrice(num)
    if num >= 1000000 then
        return string.format("%.1fM", num / 1000000)
    elseif num >= 1000 then
        return string.format("%.1fK", num / 1000)
    else
        return tostring(num)
    end
end

-- Data Rods
local RODS_DATA = {
    {Id = 657, Name = "Carbon Rod", Price = 750, Tier = 1},
    {Id = 85, Name = "Grass Rod", Price = 1500, Tier = 2},
    {Id = 78, Name = "Ice Rod", Price = 5000, Tier = 2},
    {Id = 4, Name = "Lucky Rod", Price = 15000, Tier = 3},
    {Id = 80, Name = "Midnight Rod", Price = 50000, Tier = 3},
    {Id = 6, Name = "Steampunk Rod", Price = 215000, Tier = 4},
    {Id = 7, Name = "Chrome Rod", Price = 437000, Tier = 4},
    {Id = 255, Name = "Fluorescent Rod", Price = 715000, Tier = 5},
    {Id = 5, Name = "Astral Rod", Price = 1000000, Tier = 5},
    {Id = 126, Name = "Ares Rod", Price = 3000000, Tier = 6},
    {Id = 168, Name = "Angler Rod", Price = 8000000, Tier = 6},
    {Id = 258, Name = "Bamboo Rod", Price = 12000000, Tier = 6},
}

table.sort(RODS_DATA, function(a, b) return a.Price < b.Price end)

-- Remote Function
local PurchaseRF = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")
    :WaitForChild("RF/PurchaseFishingRod")

-- Variables - MULTI SELECT
local SelectedRods = {}
local BuyRodPanel = nil
local BuyRodScroll = nil
local TotalPriceLabel = nil
local BuyRodButton = nil

--==================================================
-- RIGHT PANEL (SAMA PERSIS KAYA CHARM)
--==================================================

BuyRodPanel = Instance.new("Frame", Main)
BuyRodPanel.Name = "BuyRodRightPanel"
BuyRodPanel.Size = UDim2.new(0, 220, 1, -46) -- SAMA KAYA CHARM
BuyRodPanel.AnchorPoint = Vector2.new(1, 0)
BuyRodPanel.Position = UDim2.new(1, -10, 0, 40)
BuyRodPanel.BackgroundColor3 = THEME.CARD
BuyRodPanel.BackgroundTransparency = 0.25
BuyRodPanel.BorderSizePixel = 0
BuyRodPanel.Visible = false
BuyRodPanel.ZIndex = 10

CC(BuyRodPanel, 10)
CS(BuyRodPanel, THEME.MAIN, 0.5)

-- Title (sama persis kaya charm)
CL(BuyRodPanel, {
    Size = UDim2.new(1, -10, 0, 24),
    Position = UDim2.new(0, 5, 0, 6),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    ZIndex = 11,
    Text = "Buy Rod"
})

-- Subtitle
CL(BuyRodPanel, {
    Size = UDim2.new(1, -10, 0, 18),
    Position = UDim2.new(0, 5, 0, 30),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    ZIndex = 11,
    Text = "Select rods to purchase"
})

-- Scrolling Frame (SAMA PERSIS KAYA CHARM)
BuyRodScroll = Instance.new("ScrollingFrame", BuyRodPanel)
BuyRodScroll.Name = "RodScroll"
BuyRodScroll.Size = UDim2.new(1, -10, 1, -70) -- SAMA KAYA CHARM
BuyRodScroll.Position = UDim2.new(0, 5, 0, 54)
BuyRodScroll.BackgroundTransparency = 1
BuyRodScroll.BorderSizePixel = 0
BuyRodScroll.ScrollBarThickness = 3
BuyRodScroll.ScrollBarImageColor3 = THEME.MAIN
BuyRodScroll.ZIndex = 10
BuyRodScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
BuyRodScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local rodLayout = Instance.new("UIListLayout", BuyRodScroll)
rodLayout.SortOrder = Enum.SortOrder.LayoutOrder
rodLayout.Padding = UDim.new(0, 4)

-- Function update total price (untuk section di luar panel)
local function UpdateTotalPrice()
    local total = 0
    for rod, _ in pairs(SelectedRods) do
        total = total + rod.Price
    end
    
    if TotalPriceLabel then
        if total > 0 then
            TotalPriceLabel.Text = "Total: " .. FormatPrice(total)
            TotalPriceLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        else
            TotalPriceLabel.Text = "Total: --"
            TotalPriceLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
    
    -- Update button text juga
    if BuyRodButton then
        local count = 0
        for _ in pairs(SelectedRods) do count = count + 1 end
        if count > 0 then
            BuyRodButton.Text = "BUY (" .. count .. ")"
            BuyRodButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        else
            BuyRodButton.Text = "BUY"
            BuyRodButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end
    end
end

-- Create Rod Entry (TOGGLE SELECT - SAMA KAYA CHARM STYLE)
for i, rod in ipairs(RODS_DATA) do
    local row = Instance.new("Frame", BuyRodScroll)
    row.Size = UDim2.new(1, -4, 0, 32)
    row.BackgroundTransparency = 1
    row.Name = "RodRow_" .. rod.Name
    row.LayoutOrder = i
    row.ZIndex = 11
    
    -- Purple highlight di kiri (sama kaya charm)
    local highlight = Instance.new("Frame", row)
    highlight.Name = "Highlight"
    highlight.Size = UDim2.new(0, 3, 1, 0)
    highlight.BackgroundColor3 = Color3.fromRGB(138, 43, 226) -- Ungu
    highlight.BorderSizePixel = 0
    highlight.Visible = false
    highlight.ZIndex = 12
    
    -- Button dengan teks
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1, -6, 1, 0)
    btn.Position = UDim2.new(0, 6, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.Text = "  " .. rod.Name .. "\n  " .. FormatPrice(rod.Price) .. " Coins"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextYAlignment = Enum.TextYAlignment.Top
    btn.ZIndex = 11
    CC(btn, 6)
    
    -- Hover effects
    btn.MouseEnter:Connect(function()
        if not SelectedRods[rod] then
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if not SelectedRods[rod] then
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
        end
    end)
    
    -- Click = TOGGLE SELECT
    btn.MouseButton1Click:Connect(function()
        if SelectedRods[rod] then
            -- Deselect
            SelectedRods[rod] = nil
            highlight.Visible = false
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        else
            -- Select
            SelectedRods[rod] = true
            highlight.Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
        end
        UpdateTotalPrice()
    end)
end

--==================================================
-- TOTAL PRICE & BUY BUTTON (DI SECTION - SAMA KAYA CHARM)
--==================================================

-- Total Price Row (sama kaya charm quantity row)
local TotalPriceRow = Instance.new("Frame", BuyRodSection)
TotalPriceRow.Size = UDim2.new(1, 0, 0, 30)
TotalPriceRow.BackgroundTransparency = 1

CL(TotalPriceRow, {
    Size = UDim2.new(0.4, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Total Price:"
})

TotalPriceLabel = CL(TotalPriceRow, {
    Size = UDim2.new(0.6, -10, 1, 0),
    Position = UDim2.new(0.4, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    Text = "--"
})

-- Buy Button Row (sama kaya charm)
local BuyButtonRow = Instance.new("Frame", BuyRodSection)
BuyButtonRow.Size = UDim2.new(1, 0, 0, 36)
BuyButtonRow.BackgroundTransparency = 1

CL(BuyButtonRow, {
    Size = UDim2.new(0.4, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Buy Selected"
})

BuyRodButton = Instance.new("TextButton", BuyButtonRow)
BuyRodButton.Size = UDim2.new(0, 80, 0, 24)
BuyRodButton.Position = UDim2.new(1, -90, 0.5, -12)
BuyRodButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- Disabled color
BuyRodButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BuyRodButton.Font = Enum.Font.GothamBold
BuyRodButton.TextSize = 12
BuyRodButton.Text = "BUY"
CC(BuyRodButton, 8)

BuyRodButton.MouseButton1Click:Connect(function()
    local rodList = {}
    for rod, _ in pairs(SelectedRods) do
        table.insert(rodList, rod)
    end
    
    if #rodList == 0 then
        if NotifyFeature then NotifyFeature("No rods selected!", false) end
        return
    end
    
    BuyRodButton.Text = "Buying..."
    BuyRodButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    task.spawn(function()
        local successCount = 0
        
        for _, rod in ipairs(rodList) do
            local success, result = pcall(function()
                return PurchaseRF:InvokeServer(rod.Id)
            end)
            
            if success and result then
                successCount = successCount + 1
            end
            
            task.wait(0.1)
        end
        
        -- Clear selection after buy
        SelectedRods = {}
        for _, child in ipairs(BuyRodScroll:GetChildren()) do
            if child:IsA("Frame") then
                local hl = child:FindFirstChild("Highlight")
                local btn = child:FindFirstChildOfClass("TextButton")
                if hl then hl.Visible = false end
                if btn then btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50) end
            end
        end
        UpdateTotalPrice()
        
        -- Feedback
        if successCount > 0 then
            BuyRodButton.Text = "BOUGHT!"
            BuyRodButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
            if NotifyFeature then
                NotifyFeature("Purchased " .. successCount .. " rods!", true)
            end
        else
            BuyRodButton.Text = "FAILED!"
            BuyRodButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            if NotifyFeature then
                NotifyFeature("Failed to buy rods!", false)
            end
        end
        
        task.wait(1.5)
        UpdateTotalPrice()
    end)
end)

--==================================================
-- OPEN/CLOSE PANEL (SAMA KAYA CHARM)
--==================================================

CSR(BuyRodSection, "Rod Panel", "Open", function()
    BuyRodPanel.Visible = not BuyRodPanel.Visible
end)

table.insert(AllPanels, BuyRodPanel)

print("[BuyRod] Section loaded (Charm style)")

--==================================================
-- BUY BAIT SECTION - SAMA PERSIS KAYA BUY ROD
--==================================================

local BuyBaitSection = CreateSectionDropdown(ShopPage, "Buy Bait")
Instance.new("UIListLayout", BuyBaitSection).SortOrder = Enum.SortOrder.LayoutOrder
BuyBaitSection.UIListLayout.Padding = UDim.new(0, 6)

-- Data Baits (dari decompile lu)
local BAITS_DATA = {
    {Id = 2, Name = "Luck Bait", Price = 1000, Tier = 2},
    {Id = 3, Name = "Midnight Bait", Price = 3000, Tier = 3},
    {Id = 17, Name = "Nature Bait", Price = 83500, Tier = 4},
    {Id = 6, Name = "Chroma Bait", Price = 290000, Tier = 5},
    {Id = 8, Name = "Dark Matter Bait", Price = 630000, Tier = 6},
    {Id = 15, Name = "Corrupt Bait", Price = 1148484, Tier = 6},
    {Id = 16, Name = "Aether Bait", Price = 3700000, Tier = 6},
    {Id = 20, Name = "Floral Bait", Price = 4000000, Tier = 6},
}

table.sort(BAITS_DATA, function(a, b) return a.Price < b.Price end)

-- Remote Function (sama kaya rod)
local PurchaseBaitRF = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")
    :WaitForChild("RF/PurchaseBait")

-- Variables - MULTI SELECT
local SelectedBaits = {}
local BuyBaitPanel = nil
local BuyBaitScroll = nil
local BaitTotalPriceLabel = nil
local BuyBaitButton = nil

--==================================================
-- RIGHT PANEL (SAMA PERSIS KAYA BUY ROD)
--==================================================

BuyBaitPanel = Instance.new("Frame", Main)
BuyBaitPanel.Name = "BuyBaitRightPanel"
BuyBaitPanel.Size = UDim2.new(0, 220, 1, -46) -- SAMA KAYA CHARM & BUY ROD
BuyBaitPanel.AnchorPoint = Vector2.new(1, 0)
BuyBaitPanel.Position = UDim2.new(1, -10, 0, 40)
BuyBaitPanel.BackgroundColor3 = THEME.CARD
BuyBaitPanel.BackgroundTransparency = 0.25
BuyBaitPanel.BorderSizePixel = 0
BuyBaitPanel.Visible = false
BuyBaitPanel.ZIndex = 10

CC(BuyBaitPanel, 10)
CS(BuyBaitPanel, THEME.MAIN, 0.5)

-- Title
CL(BuyBaitPanel, {
    Size = UDim2.new(1, -10, 0, 24),
    Position = UDim2.new(0, 5, 0, 6),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    ZIndex = 11,
    Text = "Buy Bait"
})

-- Subtitle
CL(BuyBaitPanel, {
    Size = UDim2.new(1, -10, 0, 18),
    Position = UDim2.new(0, 5, 0, 30),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    ZIndex = 11,
    Text = "Select baits to purchase"
})

-- Scrolling Frame
BuyBaitScroll = Instance.new("ScrollingFrame", BuyBaitPanel)
BuyBaitScroll.Name = "BaitScroll"
BuyBaitScroll.Size = UDim2.new(1, -10, 1, -70)
BuyBaitScroll.Position = UDim2.new(0, 5, 0, 54)
BuyBaitScroll.BackgroundTransparency = 1
BuyBaitScroll.BorderSizePixel = 0
BuyBaitScroll.ScrollBarThickness = 3
BuyBaitScroll.ScrollBarImageColor3 = THEME.MAIN
BuyBaitScroll.ZIndex = 10
BuyBaitScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
BuyBaitScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local baitLayout = Instance.new("UIListLayout", BuyBaitScroll)
baitLayout.SortOrder = Enum.SortOrder.LayoutOrder
baitLayout.Padding = UDim.new(0, 4)

-- Function update total price
local function UpdateBaitTotalPrice()
    local total = 0
    for bait, _ in pairs(SelectedBaits) do
        total = total + bait.Price
    end
    
    if BaitTotalPriceLabel then
        if total > 0 then
            BaitTotalPriceLabel.Text = "Total: " .. FormatPrice(total)
            BaitTotalPriceLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        else
            BaitTotalPriceLabel.Text = "Total: --"
            BaitTotalPriceLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
    
    if BuyBaitButton then
        local count = 0
        for _ in pairs(SelectedBaits) do count = count + 1 end
        if count > 0 then
            BuyBaitButton.Text = "BUY (" .. count .. ")"
            BuyBaitButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        else
            BuyBaitButton.Text = "BUY"
            BuyBaitButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end
    end
end

-- Create Bait Entry (SAMA PERSIS KAYA ROD)
for i, bait in ipairs(BAITS_DATA) do
    local row = Instance.new("Frame", BuyBaitScroll)
    row.Size = UDim2.new(1, -4, 0, 32)
    row.BackgroundTransparency = 1
    row.Name = "BaitRow_" .. bait.Name
    row.LayoutOrder = i
    row.ZIndex = 11
    
    -- Purple highlight di kiri
    local highlight = Instance.new("Frame", row)
    highlight.Name = "Highlight"
    highlight.Size = UDim2.new(0, 3, 1, 0)
    highlight.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    highlight.BorderSizePixel = 0
    highlight.Visible = false
    highlight.ZIndex = 12
    
    -- Button dengan teks
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1, -6, 1, 0)
    btn.Position = UDim2.new(0, 6, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.Text = "  " .. bait.Name .. "\n  " .. FormatPrice(bait.Price) .. " Coins"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextYAlignment = Enum.TextYAlignment.Top
    btn.ZIndex = 11
    CC(btn, 6)
    
    -- Hover effects
    btn.MouseEnter:Connect(function()
        if not SelectedBaits[bait] then
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if not SelectedBaits[bait] then
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
        end
    end)
    
    -- Click = TOGGLE SELECT
    btn.MouseButton1Click:Connect(function()
        if SelectedBaits[bait] then
            SelectedBaits[bait] = nil
            highlight.Visible = false
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        else
            SelectedBaits[bait] = true
            highlight.Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
        end
        UpdateBaitTotalPrice()
    end)
end

--==================================================
-- TOTAL PRICE & BUY BUTTON (DI SECTION)
--==================================================

-- Total Price Row
local BaitTotalPriceRow = Instance.new("Frame", BuyBaitSection)
BaitTotalPriceRow.Size = UDim2.new(1, 0, 0, 30)
BaitTotalPriceRow.BackgroundTransparency = 1

CL(BaitTotalPriceRow, {
    Size = UDim2.new(0.4, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Total Price:"
})

BaitTotalPriceLabel = CL(BaitTotalPriceRow, {
    Size = UDim2.new(0.6, -10, 1, 0),
    Position = UDim2.new(0.4, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    Text = "--"
})

-- Buy Button Row
local BaitBuyButtonRow = Instance.new("Frame", BuyBaitSection)
BaitBuyButtonRow.Size = UDim2.new(1, 0, 0, 36)
BaitBuyButtonRow.BackgroundTransparency = 1

CL(BaitBuyButtonRow, {
    Size = UDim2.new(0.4, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Buy Selected"
})

BuyBaitButton = Instance.new("TextButton", BaitBuyButtonRow)
BuyBaitButton.Size = UDim2.new(0, 80, 0, 24)
BuyBaitButton.Position = UDim2.new(1, -90, 0.5, -12)
BuyBaitButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
BuyBaitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BuyBaitButton.Font = Enum.Font.GothamBold
BuyBaitButton.TextSize = 12
BuyBaitButton.Text = "BUY"
CC(BuyBaitButton, 8)

BuyBaitButton.MouseButton1Click:Connect(function()
    local baitList = {}
    for bait, _ in pairs(SelectedBaits) do
        table.insert(baitList, bait)
    end
    
    if #baitList == 0 then
        if NotifyFeature then NotifyFeature("No baits selected!", false) end
        return
    end
    
    BuyBaitButton.Text = "Buying..."
    BuyBaitButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    task.spawn(function()
        local successCount = 0
        
        for _, bait in ipairs(baitList) do
            local success, result = pcall(function()
                return PurchaseBaitRF:InvokeServer(bait.Id)
            end)
            
            if success and result then
                successCount = successCount + 1
            end
            
            task.wait(0.1)
        end
        
        -- Clear selection after buy
        SelectedBaits = {}
        for _, child in ipairs(BuyBaitScroll:GetChildren()) do
            if child:IsA("Frame") then
                local hl = child:FindFirstChild("Highlight")
                local btn = child:FindFirstChildOfClass("TextButton")
                if hl then hl.Visible = false end
                if btn then btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50) end
            end
        end
        UpdateBaitTotalPrice()
        
        -- Feedback
        if successCount > 0 then
            BuyBaitButton.Text = "BOUGHT!"
            BuyBaitButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
            if NotifyFeature then
                NotifyFeature("Purchased " .. successCount .. " baits!", true)
            end
        else
            BuyBaitButton.Text = "FAILED!"
            BuyBaitButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            if NotifyFeature then
                NotifyFeature("Failed to buy baits!", false)
            end
        end
        
        task.wait(1.5)
        UpdateBaitTotalPrice()
    end)
end)

--==================================================
-- OPEN/CLOSE PANEL
--==================================================

CSR(BuyBaitSection, "Bait Panel", "Open", function()
    BuyBaitPanel.Visible = not BuyBaitPanel.Visible
end)

table.insert(AllPanels, BuyBaitPanel)

print("[BuyBait] Section loaded")
