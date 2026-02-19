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
    {Name = "Quest", Icon = "rbxassetid://14228191542"},
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
    "Oceanic Harpoon", "Binary Edge", "The Vanquisher", "1x1x1x1 Ban Hammer"
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
-- RIGHT PANEL (SKIN LIST)
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

CreateCorner(RightPanel, 10)
CreateStroke(RightPanel, THEME.MAIN, 0.5)

CreateLabel(RightPanel, {
    Size = UDim2.new(1, -10, 0, 24),
    Position = UDim2.new(0, 5, 0, 6),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    ZIndex = 11,
    Text = "Skin Animation"
})

local rpSkin = CreateLabel(RightPanel, {
    Size = UDim2.new(1, -10, 0, 18),
    Position = UDim2.new(0, 5, 0, 30),
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

local rpScroll = Instance.new("ScrollingFrame", RightPanel)
rpScroll.Size = UDim2.new(1, -10, 1, -70)
rpScroll.Position = UDim2.new(0, 5, 0, 54)
rpScroll.BackgroundTransparency = 1
rpScroll.BorderSizePixel = 0
rpScroll.ScrollBarThickness = 3
rpScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
rpScroll.ScrollBarImageColor3 = THEME.MAIN
rpScroll.ZIndex = 10

Instance.new("UIListLayout", rpScroll).SortOrder = Enum.SortOrder.LayoutOrder
rpScroll.UIListLayout.Padding = UDim.new(0, 4)

local function CreateSkinEntry(skinName)
    local row = Instance.new("Frame", rpScroll)
    row.Size = UDim2.new(1, -4, 0, 24)
    row.BackgroundTransparency = 1
    row.ZIndex = 11

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
UpdateRightSkinLabel()

-- Close panel on outside click
UIS.InputBegan:Connect(function(input)
    if not RightPanel.Visible then return end
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
-- AUTO SELL SYSTEM
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
    
    -- Init globals
    _G.RAY_SellThreshold = _G.RAY_SellThreshold or "Legendary"
    _G.RAY_SellDelay = _G.RAY_SellDelay or 5
    _G.RAY_SellInventoryThreshold = _G.RAY_SellInventoryThreshold or 30
    _G.RAY_SellByTime = (_G.RAY_SellByTime ~= false)
    _G.RAY_SellByInventory = _G.RAY_SellByInventory or false
    
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
    
    -- Toggles
    CreateToggleRow(BackpackAutoSellSection, "Sell by Time", _G.RAY_SellByTime, function(state)
        _G.RAY_SellByTime = state
    end, { ActiveColor = Color3.fromRGB(0, 200, 100) })
    
    CreateToggleRow(BackpackAutoSellSection, "Sell by Inventory", _G.RAY_SellByInventory, function(state)
        _G.RAY_SellByInventory = state
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
-- AUTO SELL ENGINE
--==================================================
task.spawn(function()
    local lastSell = 0

    while true do
        local now = os.clock()
        local shouldSell = false

        -- Sell by Time
        if _G.RAY_SellByTime then
            local delay = tonumber(_G.RAY_SellDelay) or 5
            if now - lastSell >= delay then shouldSell = true end
        end

        -- Sell by Inventory
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

local TotemTypeId = { Lucky = 1, Mutasi = 2, Shiny = 3, Love = 17 }
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
-- PANEL SYSTEM (REUSABLE)
--==================================================
local function CreateSidePanel(parent, title, infoText)
    local panel = Instance.new("Frame", parent)
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
    scroll.Size = UDim2.new(1, -10, 1, -70)
    scroll.Position = UDim2.new(0, 5, 0, 54)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ScrollBarImageColor3 = THEME.MAIN
    scroll.ZIndex = 10
    
    Instance.new("UIListLayout", scroll).SortOrder = Enum.SortOrder.LayoutOrder
    scroll.UIListLayout.Padding = UDim.new(0, 4)
    
    return panel, scroll
end

--==================================================
-- AUTO TOTEM SECTION
--==================================================
if BackpackPage then
    local AutoTotemSection = CreateSectionDropdown(BackpackPage, "Auto Totem")
    
    Instance.new("UIListLayout", AutoTotemSection).SortOrder = Enum.SortOrder.LayoutOrder
    AutoTotemSection.UIListLayout.Padding = UDim.new(0, 6)
    
    -- Create Totem Panel
    local TotemPanel, TotemScroll = CreateSidePanel(Main, "Totem List", "Pilih totem yang mau dipasang.")
    
    local TO_TYPES = { "Lucky", "Mutasi", "Shiny", "Love" }
    
    local function rebuildTotemPanel()
        for _, c in ipairs(TotemScroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        
        for _, jenis in ipairs(TO_TYPES) do
            local id = TotemTypeId[jenis]
            local isSelected = (_G.RAYSelectedTotemType == jenis)
            
            local row = Instance.new("Frame", TotemScroll)
            row.Size = UDim2.new(1, -4, 0, 24)
            row.BackgroundTransparency = 1
            row.ZIndex = 11
            
            local line = Instance.new("Frame", row)
            line.Name = "Highlight"
            line.Size = UDim2.new(0, 3, 1, 0)
            line.BackgroundColor3 = Color3.fromRGB(160, 110, 255)
            line.Visible = isSelected
            line.ZIndex = 12
            
            local btn = Instance.new("TextButton", row)
            btn.Size = UDim2.new(1, -6, 1, 0)
            btn.Position = UDim2.new(0, 4, 0, 0)
            btn.BackgroundColor3 = isSelected and Color3.fromRGB(40, 40, 70) or Color3.fromRGB(30, 30, 50)
            btn.TextColor3 = THEME.TEXT
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 12
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Text = "  " .. jenis .. " Totem  [" .. tostring(id) .. "]"
            btn.ZIndex = 11
            
            CreateCorner(btn, 6)
            
            btn.MouseButton1Click:Connect(function()
                _G.RAYSelectedTotemType = isSelected and nil or jenis
                if NotifyFeature then NotifyFeature("Totem " .. jenis, not isSelected) end
                rebuildTotemPanel()
            end)
        end
    end
    
    rebuildTotemPanel()
    
    -- Enable Toggle
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
    
    -- Open Panel Button
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
    
    -- Close on outside click
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
    
    -- Helper for gear toggles
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
    
    -- Advance Diving Gear
    local function GetEquipTankRF()
        local ok, rf = pcall(function()
            return ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/EquipOxygenTank")
        end)
        return ok and rf or nil
    end
    
    CreateGearToggle(GearPresetSection, "Advance Diving Gear", "RAY_AdvanceDivingOn",
        function() -- ON
            local rf = GetEquipTankRF()
            if rf then
                local ok, res = pcall(function() return rf:InvokeServer(575) end)
                if not ok then warn("[Threeblox] Equip tank failed:", res) end
            else
                warn("[Threeblox] EquipOxygenTank RF not found")
            end
        end,
        function() -- OFF
            if Events and Events.unequip then
                pcall(function() Events.unequip:FireServer() end)
            end
        end
    )
    
    -- Fishing Radar
    local function GetRadarRF()
        local ok, rf = pcall(function()
            return ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/UpdateFishingRadar")
        end)
        return ok and rf or nil
    end
    
    CreateGearToggle(GearPresetSection, "Fishing Radar", "RAY_FishingRadarOn",
        function() -- ON
            local rf = GetRadarRF()
            if rf then
                local ok, res = pcall(function() return rf:InvokeServer(true) end)
                if not ok then warn("[Threeblox] Radar toggle failed:", res) end
            else
                warn("[Threeblox] UpdateFishingRadar RF not found")
            end
        end,
        function() -- OFF
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
    
    -- Create Panel
    local PotionPanel, PotionScroll = CreateSidePanel(Main, "Potion List", "Pilih potion dan set quantity.")
    
    local function rebuildPotionPanel()
        for _, c in ipairs(PotionScroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        
        for _, name in ipairs(POTION_NAMES) do
            local row = Instance.new("Frame", PotionScroll)
            row.Size = UDim2.new(1, -4, 0, 24)
            row.BackgroundTransparency = 1
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
    end
    
    rebuildPotionPanel()
    
    -- Quantity Row
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
    
    -- Open Panel Button
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
    
    -- Close on outside click
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

-- Auto-stop on target enchant
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
    
    -- Create Panels
    local StonePanel, StoneScroll = CreateSidePanel(Main, "Stone List", "Pilih batu enchant untuk slot.")
    local EnchantPanel, EnchantScroll = CreateSidePanel(Main, "Enchant List", "Pilih enchant target sesuai batu.")
    
    local function rebuildStonePanel()
        for _, c in ipairs(StoneScroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        
        for _, id in ipairs(StoneList) do
            local cfg = StoneConfig[id]
            if cfg then
                local row = Instance.new("Frame", StoneScroll)
                row.Size = UDim2.new(1, -4, 0, 24)
                row.BackgroundTransparency = 1
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
    end
    
    local function rebuildEnchantPanel()
        for _, c in ipairs(EnchantScroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        
        local cfg = StoneConfig[_G.RAY_EnchantStoneId]
        local list = cfg and cfg.Enchants or {}
        
        for _, name in ipairs(list) do
            local row = Instance.new("Frame", EnchantScroll)
            row.Size = UDim2.new(1, -4, 0, 24)
            row.BackgroundTransparency = 1
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
    end
    
    rebuildStonePanel()
    rebuildEnchantPanel()
    
    -- Target Slot Row
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
    
    -- Open Stone Panel
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
    
    -- Open Enchant Panel
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
    
    -- Auto Enchant Toggle
    CreateToggleRow(EnchantSection, "Auto Enchant", _G.RAY_EnchantAutoOn, function(state)
        _G.RAY_EnchantAutoOn = state
        if NotifyFeature then NotifyFeature("Auto Enchant", state) end
    end, { ActiveColor = THEME.ACCENT })
    
    -- Teleport Altar
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
    
    -- Close panels on outside click
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
--==================================================
-- TELEPORT DATA
--==================================================
--==================================================
-- ISLAND TELEPORT CF DATA
--==================================================
local IslandTeleportCF = {
    ["Arrow Artifact"] = CFrame.new(879.857178, 4.92162275, -339.661469, -0.195367768, 0, 0.980730057, 0, 1, 0, -0.980730057, 0, -0.195367768),
    ["Crescent Artifact"] = CFrame.new(1382.48401, 4.83972979, 113.104294, -0.956645668, 0, 0.291254193, 0, 1, 0, -0.291254193, 0, -0.956645668),
    ["Diamond Artifact"] = CFrame.new(1835.33704, 4.92876816, -314.988342, 0.219969183, 0, -0.975506842, 0, 1, 0, 0.975506842, 0, 0.219969183),
    ["Heartfelt Island"] = CFrame.new(1112.6106, 4.84564829, 2719.63818, -0.0125409178, -5.2643145e-08, -0.999921381, -1.06123528e-08, 1, -5.2514185e-08, 0.999921381, 9.95294158e-09, -0.0125409178),
    ["Hourglass Diamond Artifact"] = CFrame.new(1500.73413, 6.37703848, -849.561951, -0.983483791, 0, -0.180996269, 0, 1, 0, 0.180996269, 0, -0.983483791),
    ["Ancient Jungle"] = CFrame.new(1470.92688, 4.58799648, -323.604401, -0.240510166, 0, -0.97064662, 0, 1, 0, 0.97064662, 0, -0.240510166),
    ["Ancient Ruin"] = CFrame.new(6082.87842, -585.924316, 4633.71631, -0.681475937, 0, 0.731840551, 0, 1, 0, -0.731840551, 0, -0.681475937),
    ["Cavern Volcanic 1"] = CFrame.new(1258.64758, 83.4165039, -10248.0986, 0.00370242121, -1.42619994e-09, 0.999993145, -5.48521122e-14, 1, 1.42620993e-09, -0.999993145, -5.3352817e-12, 0.00370242121),
    ["Cavern Volcanic 2"] = CFrame.new(1106.69495, 86.072998, -10248.0986, -0.00201654364, -2.72424678e-08, 0.999997973, -5.50374711e-11, 1, 2.72424128e-08, -0.999997973, -1.01846327e-13, -0.00201654364),
    ["Coral Reefs"] = CFrame.new(-2917.92163, 3.24999928, 2073.65894, 0.185246676, 0, 0.982692063, 0, 1, 0, -0.982692063, 0, 0.185246676),
    ["Crater Island"] = CFrame.new(1021.73822, 22.0761662, 5075.62207, 0.110775813, 0, -0.993845403, 0, 1, 0, 0.993845403, 0, 0.110775813),
    ["Crystalline Passage"] = CFrame.new(6050.46533, -538.900208, 4374.14404, -0.999980807, 0, 0.00619776407, 0, 1, 0, -0.00619776407, 0, -0.999980807),
    ["Crystal Depths"] = CFrame.new(5816.59766, -905.712524, 15416.5459, 0.653240383, 0, -0.75715059, 0, 1, 0, 0.75715059, 0, 0.653240383),
    ["Esoteric Depths"] = CFrame.new(3232.90356, -1302.8551, 1401.0824, 0.483647138, 0, -0.875263095, 0, 1, 0, 0.875263095, 0, 0.483647138),
    ["Fisherman Spawn"] = CFrame.new(94.4113464, 17.0335178, 2832.35474, 0.997892678, 0, 0.0648857802, 0, 1, 0, -0.0648857802, 0, 0.997892678),
    ["Kohana"] = CFrame.new(-661.520142, 17.2500553, 525.53125, 0.379789084, -3.69101372e-08, -0.925073087, -4.96903567e-08, 1, -6.03000885e-08, 0.925073087, 6.88685304e-08, 0.379789084),
    ["Kohana Volcano"] = CFrame.new(-615.731567, 48.5698662, 189.133865, 0.256806821, 0, 0.966462731, 0, 1, 0, -0.966462731, 0, 0.256806821),
    ["Lava Basin"] = CFrame.new(893.590942, 89.0328979, -10196.835, -0.435751051, 6.88466599e-08, -0.90006721, -2.40178668e-08, 1, 8.81183837e-08, 0.90006721, 6.0015374e-08, -0.435751051),
    ["Maze Room"] = CFrame.new(3439.70679, -287.844818, 3390.59546, -0.96200937, 0, -0.273016393, 0, 1, 0, 0.273016393, 0, -0.96200937),
    ["Pirate Cove"] = CFrame.new(3408.83179, 3.73505521, 3444.31812, -0.76647383, 0, -0.642275512, 0, 1, 0, 0.642275512, 0, -0.76647383),
    ["Pirate Cove Leviathan"] = CFrame.new(3471.53125, -287.84317, 3474.38257, -0.962593496, 0, -0.270949841, 0, 1, 0, 0.270949841, 0, -0.962593496),
    ["Pirate Treasure Room"] = CFrame.new(3291.12646, -299.092438, 3068.04639, 0.483647138, 0, -0.875263095, 0, 1, 0, 0.875263095, 0, 0.483647138),
    ["Sacred Temple"] = CFrame.new(1496.13306, -22.1250019, -639.212097, 0.987680018, 0, 0.156487122, 0, 1, 0, -0.156487122, 0, 0.987680018),
    ["Sysphus State"] = CFrame.new(-3656.59058, -134.150406, -959.743469, -0.287091494, 0, 0.957903147, 0, 1, 0, -0.957903147, 0, -0.287091494),
    ["Temple Guardian"] = CFrame.new(1486.06165, 127.624977, -590.121094, 0.998732686, 0, 0.0503287315, 0, 1, 0, -0.0503287315, 0, 0.998732686),
    ["Treasure Room"] = CFrame.new(-3598.04102, -275.723602, -1640.93933, -0.203907222, 0, 0.978990197, 0, 1, 0, -0.978990197, 0, -0.203907222),
    ["Tropical Grove"] = CFrame.new(-2016.4812, 9.03753567, 3752.35327, -0.995569646, 0, 0.0940273255, 0, 1, 0, -0.0940273255, 0, -0.995569646),
    ["Underground Cellar"] = CFrame.new(2125.30005, -91.1976624, -750.400024, -0.661489964, 0, -0.749954045, 0, 1, 0, 0.749954045, 0, -0.661489964),
    ["Weather Machine"] = CFrame.new(-1476.29089, 3.49999928, 1909.09583, -0.429490566, 0, -0.903071344, 0, 1, 0, 0.903071344, 0, -0.429490566),
}

--==================================================
-- EVENT HUNT STATE
--==================================================
_G.GhostSharkHuntActive = _G.GhostSharkHuntActive or false
_G.MegalodonHuntActive = _G.MegalodonHuntActive or false

--==================================================
-- SAVED POSITIONS DATA
--==================================================
_G.RAY_SavedPositions = _G.RAY_SavedPositions or {}

--==================================================
-- TELEPORT PAGE
--==================================================
local TeleportPage = Pages["Teleport"]
if not TeleportPage then
    warn("TeleportPage not found")
    return
end

--==================================================
-- HELPER FUNCTIONS
--==================================================
local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner", parent)
    corner.CornerRadius = UDim.new(0, radius or 8)
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke", parent)
    stroke.Color = color or THEME.MAIN
    stroke.Thickness = thickness or 1
    stroke.Transparency = 0.5
    return stroke
end

local function CreateLabel(parent, props)
    local label = Instance.new("TextLabel", parent)
    for k, v in pairs(props) do
        label[k] = v
    end
    return label
end

--==================================================
-- HELPER: CREATE TELEPORT PANEL
--==================================================
local function CreateTeleportPanel(name, infoText)
    local panel = Instance.new("Frame", Main)
    panel.Name = name .. "RightPanel"
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
        Text = name
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
    scroll.Size = UDim2.new(1, -10, 1, -70)
    scroll.Position = UDim2.new(0, 5, 0, 54)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ScrollBarImageColor3 = THEME.MAIN
    scroll.ZIndex = 10
    
    Instance.new("UIListLayout", scroll).SortOrder = Enum.SortOrder.LayoutOrder
    scroll.UIListLayout.Padding = UDim.new(0, 4)
    
    return panel, scroll
end

--==================================================
-- HELPER: CREATE LIST ENTRY
--==================================================
local function CreateListEntry(parent, text, onClick)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -4, 0, 24)
    row.BackgroundTransparency = 1
    row.ZIndex = 11
    
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
    btn.Text = "  " .. text
    btn.ZIndex = 11
    
    CreateCorner(btn, 6)
    
    btn.MouseButton1Click:Connect(function()
        onClick()
        for _, child in ipairs(parent:GetChildren()) do
            local hl = child:FindFirstChild("Highlight")
            if hl then hl.Visible = (child == row) end
        end
    end)
    
    return row
end

--==================================================
-- HELPER: CREATE SECTION ROW
--==================================================
local function CreateSectionRow(parent, title, buttonText, onClick)
    local row = Instance.new("Frame", parent)
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
        Text = title
    })
    
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(0, 110, 0, 24)
    btn.Position = UDim2.new(1, -126, 0.5, -12)
    btn.BackgroundColor3 = THEME.CARD
    btn.BackgroundTransparency = 0.1
    btn.Text = buttonText
    btn.TextColor3 = THEME.TEXT
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    
    CreateCorner(btn, 8)
    btn.MouseButton1Click:Connect(onClick)
    
    return row
end

--==================================================
-- HELPER: CREATE TOGGLE PILL
--==================================================
local function CreateTogglePill(parent, defaultState, onToggle)
    local toggleFrame = Instance.new("Frame", parent)
    toggleFrame.Size = UDim2.new(0, 50, 0, 26)
    toggleFrame.Position = UDim2.new(1, -66, 0.5, -13)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toggleFrame.BorderSizePixel = 0
    CreateCorner(toggleFrame, 13)
    
    local circle = Instance.new("Frame", toggleFrame)
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 3, 0.5, -10)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    CreateCorner(circle, 10)
    
    local isOn = defaultState or false
    
    local function UpdateVisual()
        if isOn then
            toggleFrame.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
            circle:TweenPosition(UDim2.new(0, 27, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        else
            toggleFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
            circle:TweenPosition(UDim2.new(0, 3, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        end
    end
    
    UpdateVisual()
    
    local clickArea = Instance.new("TextButton", toggleFrame)
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    
    clickArea.MouseButton1Click:Connect(function()
        isOn = not isOn
        UpdateVisual()
        if onToggle then onToggle(isOn) end
    end)
    
    local function SetState(newState)
        isOn = newState
        UpdateVisual()
    end
    
    return toggleFrame, SetState
end

--==================================================
-- ISLAND TELEPORT
--==================================================
local IslandSection = CreateSectionDropdown(TeleportPage, "Teleport Island")
Instance.new("UIListLayout", IslandSection).SortOrder = Enum.SortOrder.LayoutOrder
IslandSection.UIListLayout.Padding = UDim.new(0, 6)

local IslandPanel, IslandScroll = CreateTeleportPanel("Teleport Island", "Pilih lokasi island untuk teleport.")

local function TpToIsland(cf, label)
    local hrp = (Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = cf
        if NotifyFeature then NotifyFeature("Teleport: " .. label, true) end
    end
end

local islandNames = {}
for name in pairs(IslandTeleportCF) do table.insert(islandNames, name) end
table.sort(islandNames)

for _, name in ipairs(islandNames) do
    CreateListEntry(IslandScroll, name, function() TpToIsland(IslandTeleportCF[name], name) end)
end

CreateSectionRow(IslandSection, "Teleport Island Panel", "Open", function()
    IslandPanel.Visible = not IslandPanel.Visible
end)

--==================================================
-- PLAYER TELEPORT
--==================================================
local PlayerSection = CreateSectionDropdown(TeleportPage, "Teleport Player")
Instance.new("UIListLayout", PlayerSection).SortOrder = Enum.SortOrder.LayoutOrder
PlayerSection.UIListLayout.Padding = UDim.new(0, 6)

local PlayerPanel, PlayerScroll = CreateTeleportPanel("Teleport Player", "Pilih player untuk teleport ke posisi mereka.")

local function TpToPlayer(targetPlayer)
    if not targetPlayer or targetPlayer == Player then return end
    
    local myHRP = (Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    local targetHRP = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if myHRP and targetHRP then
        myHRP.CFrame = targetHRP.CFrame
        if NotifyFeature then NotifyFeature("Teleport to: " .. targetPlayer.Name, true) end
    end
end

local function CreatePlayerEntry(plr)
    CreateListEntry(PlayerScroll, plr.Name, function() TpToPlayer(plr) end).Name = "PlayerRow_" .. plr.Name
end

for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= Player then CreatePlayerEntry(plr) end
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= Player then CreatePlayerEntry(plr) end
end)

Players.PlayerRemoving:Connect(function(plr)
    local row = PlayerScroll:FindFirstChild("PlayerRow_" .. plr.Name)
    if row then row:Destroy() end
end)

CreateSectionRow(PlayerSection, "Teleport Player Panel", "Open", function()
    PlayerPanel.Visible = not PlayerPanel.Visible
end)

--==================================================
-- EVENT HUNT LOGIC (GHOST SHARK + MEGALODON)
--==================================================

-- Ghost Shark Hunt Logic
local function getSharkHuntModel()
    local props = Workspace:FindFirstChild("Props")
    if not props then return nil end
    local model = props:FindFirstChild("Shark Hunt") or props:FindFirstChild("Ghost Shark Hunt")
    if model and model:IsA("Model") then
        return model
    end
    return nil
end

local ghostSharkFloor

local function ensureFloorUnderShark()
    local model = getSharkHuntModel()
    if not model then return nil, nil end

    if not model.PrimaryPart then
        local anyPart = model:FindFirstChildWhichIsA("BasePart", true)
        if anyPart then
            model.PrimaryPart = anyPart
        end
    end
    local anchor = model.PrimaryPart
    if not anchor then return nil, nil end

    if not ghostSharkFloor or not ghostSharkFloor.Parent then
        ghostSharkFloor = Instance.new("Part")
        ghostSharkFloor.Name = "SharkHuntFloor_Client"
        ghostSharkFloor.Anchored = true
        ghostSharkFloor.CanCollide = true
        ghostSharkFloor.Transparency = 1
        ghostSharkFloor.Size = Vector3.new(80, 1, 80)
        ghostSharkFloor.Material = Enum.Material.SmoothPlastic
        ghostSharkFloor.Parent = Workspace
    end

    local yOffset = -2
    ghostSharkFloor.CFrame = CFrame.new(
        Vector3.new(anchor.Position.X, anchor.Position.Y + yOffset, anchor.Position.Z)
    )

    return anchor, ghostSharkFloor
end

local function TeleportToGhostShark()
    local anchor, floor = ensureFloorUnderShark()
    if not anchor or not floor then
        warn("[SharkHunt] Failed to setup floor/anchor")
        return
    end

    local char = Player.Character or Player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

    local basePos = floor.Position + Vector3.new(0, floor.Size.Y/2 + 4, 0)
    local lookDir = anchor.CFrame.LookVector
    local cf = CFrame.new(basePos, basePos + lookDir)

    char:PivotTo(cf)
end

-- Auto-detect Ghost Shark via Replion
local function safeConnectGhostSharkReplion()
    local ok, ReplionPkg = pcall(function()
        return require(ReplicatedStorage.Packages.Replion)
    end)

    if not ok or not ReplionPkg or not ReplionPkg.Client then
        warn("[SharkHunt] Replion Client not found")
        return
    end

    local Client = ReplionPkg.Client
    local success, eventsReplion = pcall(function()
        return Client:WaitReplion("Events")
    end)

    if not success or not eventsReplion then
        warn("[SharkHunt] WaitReplion('Events') failed")
        return
    end

    local SharkHuntEventName = "Shark Hunt"

    local function OnEventInserted(index, eventName)
        if eventName == SharkHuntEventName then
            _G.GhostSharkHuntActive = true
            if NotifyFeature then NotifyFeature("Ghost Shark Hunt Spawned!", true) end
        end
    end

    local function OnEventRemoved(index, eventName)
        if eventName == SharkHuntEventName then
            _G.GhostSharkHuntActive = false
            if ghostSharkFloor then
                ghostSharkFloor:Destroy()
                ghostSharkFloor = nil
            end
            if NotifyFeature then NotifyFeature("Ghost Shark Hunt Ended", false) end
        end
    end

    eventsReplion:OnArrayInsert("Events", OnEventInserted)
    eventsReplion:OnArrayRemove("Events", OnEventRemoved)

    local current = eventsReplion:Get("Events") or {}
    for i, name in ipairs(current) do
        OnEventInserted(i, name)
    end
end

task.spawn(safeConnectGhostSharkReplion)

-- Megalodon Hunt Logic
local function TeleportToMegalodon()
    local anchor
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "Megalodon Hunt" then
            anchor = obj
            break
        end
    end
    if not anchor then
        return
    end

    local char = Player.Character or Player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

    local basePos = anchor.Position + Vector3.new(0, 5, 0)
    local lookDir = anchor.CFrame.LookVector

    local cf = CFrame.new(basePos, basePos + lookDir)
    char:PivotTo(cf)
end

--==================================================
-- EVENT HUNT SECTION (DENGAN PANEL KANAN)
--==================================================
local EventHuntSection = CreateSectionDropdown(TeleportPage, "Event Hunt")
Instance.new("UIListLayout", EventHuntSection).SortOrder = Enum.SortOrder.LayoutOrder
EventHuntSection.UIListLayout.Padding = UDim.new(0, 6)

local EventHuntPanel, EventHuntScroll = CreateTeleportPanel("Event Hunt", "Pilih hunt event untuk teleport.")

-- Create Ghost Shark Entry
CreateListEntry(EventHuntScroll, "Ghost Shark Hunt", function()
    if not _G.GhostSharkHuntActive then
        if NotifyFeature then NotifyFeature("Ghost Shark Hunt not active!", false) end
        return
    end
    TeleportToGhostShark()
    if NotifyFeature then NotifyFeature("Teleported to Ghost Shark Hunt", true) end
end)

-- Create Megalodon Entry
CreateListEntry(EventHuntScroll, "Megalodon Hunt", function()
    if not _G.MegalodonHuntActive then
        if NotifyFeature then NotifyFeature("Megalodon Hunt not found!", false) end
        return
    end
    TeleportToMegalodon()
    if NotifyFeature then NotifyFeature("Teleported to Megalodon Hunt", true) end
end)

-- Update entry colors based on status
task.spawn(function()
    while true do
        for _, entry in ipairs(EventHuntScroll:GetChildren()) do
            if entry:IsA("Frame") then
                local btn = entry:FindFirstChildOfClass("TextButton")
                local hl = entry:FindFirstChild("Highlight")
                if btn and hl then
                    local isGhostShark = btn.Text:find("Ghost Shark")
                    local isMegalodon = btn.Text:find("Megalodon")
                    
                    if isGhostShark then
                        if _G.GhostSharkHuntActive then
                            btn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
                            hl.Visible = true
                        else
                            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
                            hl.Visible = false
                        end
                    elseif isMegalodon then
                        -- Check Megalodon existence
                        local exists = false
                        for _, obj in ipairs(workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and obj.Name == "Megalodon Hunt" then
                                exists = true
                                break
                            end
                        end
                        _G.MegalodonHuntActive = exists
                        
                        if exists then
                            btn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
                            hl.Visible = true
                        else
                            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
                            hl.Visible = false
                        end
                    end
                end
            end
        end
        task.wait(1)
    end
end)

-- Open Panel Button
CreateSectionRow(EventHuntSection, "Event Hunt Panel", "Open", function()
    EventHuntPanel.Visible = not EventHuntPanel.Visible
end)

--==================================================
-- LOCH NESS EVENT SECTION (FIXED TIMER + STATE)
--==================================================

local LochNessSection = CreateSectionDropdown(TeleportPage, "Lochnes Event")
Instance.new("UIListLayout", LochNessSection).SortOrder = Enum.SortOrder.LayoutOrder
LochNessSection.UIListLayout.Padding = UDim.new(0, 6)

-- Koordinat Ancient Ruin
local ANCIENT_RUIN_CF = CFrame.new(6082.87842, -585.924316, 4633.71631, -0.681475937, 0, 0.731840551, 0, 1, 0, -0.731840551, 0, -0.681475937)

-- KONFIGURASI EVENT (sesuai game mechanics)
local EVENT_DURATION_MINUTES = 10        -- Event berlangsung 10 menit
local EVENT_HOURS_UTC = {0, 4, 8, 12, 16, 20}

-- State Machine
local EVENT_STATE = {
    IDLE = "IDLE",           -- Menunggu countdown
    ACTIVE = "ACTIVE",       -- Event sedang berlangsung (0-10 menit)
    ENDED = "ENDED"          -- Event selesai, menunggu next cycle
}

-- Global State
_G.LochNessState = {
    CurrentState = EVENT_STATE.IDLE,
    NextEventTime = 0,
    EventEndTime = 0,
    IsAutoTeleported = false,     -- Sudah auto-TP ke event?
    IsReturned = false,           -- Sudah balik ke posisi awal?
    SavedPosition = nil,
    AutoTeleportEnabled = false
}

--==================================================
-- HELPER FUNCTIONS
--================================================

local function GetNextEventStartUTC()
    local nowUTC = os.date("!*t", os.time())
    local nowMinutes = nowUTC.hour * 60 + nowUTC.min
    local nowSeconds = nowUTC.sec
    
    for _, hour in ipairs(EVENT_HOURS_UTC) do
        local eventMinutes = hour * 60
        if eventMinutes > nowMinutes then
            local target = {
                year = nowUTC.year, month = nowUTC.month, day = nowUTC.day,
                hour = hour, min = 0, sec = 0, isdst = false
            }
            return os.time(target)
        end
    end
    
    -- Next day first slot
    local target = {
        year = nowUTC.year, month = nowUTC.month, day = nowUTC.day + 1,
        hour = EVENT_HOURS_UTC[1], min = 0, sec = 0, isdst = false
    }
    return os.time(target)
end

local function FormatTime(seconds)
    seconds = math.max(0, math.floor(seconds))
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    return string.format("%02d:%02d:%02d", h, m, s)
end

local function SaveCurrentPosition()
    local char = Player.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    _G.LochNessState.SavedPosition = {
        Position = hrp.CFrame.Position,
        LookVector = hrp.CFrame.LookVector,
        Time = os.time()
    }
    return true
end

local function TeleportToAncientRuin()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    char:PivotTo(ANCIENT_RUIN_CF)
    
    if NotifyFeature then 
        NotifyFeature("Teleported to Ancient Ruin!", true) 
    end
end

local function ReturnToSavedPosition()
    local data = _G.LochNessState.SavedPosition
    if not data then 
        if NotifyFeature then NotifyFeature("No saved position!", false) end
        return 
    end
    
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local cf = CFrame.new(data.Position, data.Position + data.LookVector)
    hrp.CFrame = cf
    
    if NotifyFeature then 
        NotifyFeature("Returned to saved position!", true) 
    end
end

--==================================================
-- STATE MACHINE LOGIC (FIXED)
--================================================

local function UpdateState()
    local now = os.time()
    local state = _G.LochNessState
    
    if state.CurrentState == EVENT_STATE.IDLE then
        -- Cek apakah sudah waktunya mulai event
        if now >= state.NextEventTime then
            state.CurrentState = EVENT_STATE.ACTIVE
            state.EventEndTime = now + (EVENT_DURATION_MINUTES * 60)
            state.IsAutoTeleported = false
            state.IsReturned = false
            return "EVENT_START"
        end
        
    elseif state.CurrentState == EVENT_STATE.ACTIVE then
        -- Cek apakah event sudah selesai
        if now >= state.EventEndTime then
            state.CurrentState = EVENT_STATE.ENDED
            return "EVENT_END"
        end
        
    elseif state.CurrentState == EVENT_STATE.ENDED then
        -- Reset ke cycle berikutnya
        state.NextEventTime = GetNextEventStartUTC()
        state.CurrentState = EVENT_STATE.IDLE
        state.IsAutoTeleported = false
        state.IsReturned = false
        return "RESET"
    end
    
    return nil
end

local function GetDisplayTime()
    local now = os.time()
    local state = _G.LochNessState
    
    if state.CurrentState == EVENT_STATE.IDLE then
        -- Countdown ke event berikutnya
        local diff = state.NextEventTime - now
        return "Next Event:", diff, Color3.fromRGB(0, 255, 140) -- Hijau
        
    elseif state.CurrentState == EVENT_STATE.ACTIVE then
        -- Event sedang berlangsung, tampilkan sisa waktu
        local remaining = state.EventEndTime - now
        return "Event Ends:", remaining, Color3.fromRGB(255, 140, 0) -- Oranye
        
    elseif state.CurrentState == EVENT_STATE.ENDED then
        -- Event selesai, tunggu reset
        return "Event Ended!", 0, Color3.fromRGB(255, 80, 80) -- Merah
    end
end

--==================================================
-- AUTO ACTIONS
--================================================

local function HandleAutoActions()
    local state = _G.LochNessState
    
    -- Auto Teleport saat event MULAI (dan belum pernah TP)
    if state.CurrentState == EVENT_STATE.ACTIVE 
       and state.AutoTeleportEnabled 
       and not state.IsAutoTeleported then
        
        if SaveCurrentPosition() then
            task.wait(0.5)
            TeleportToAncientRuin()
            state.IsAutoTeleported = true
        end
    end
    
    -- Auto Return saat event SELESAI (dan sudah pernah TP tapi belum balik)
    if state.CurrentState == EVENT_STATE.ENDED 
       and state.AutoTeleportEnabled 
       and state.IsAutoTeleported 
       and not state.IsReturned then
        
        task.wait(1) -- Jeda sebentar sebelum balik
        ReturnToSavedPosition()
        state.IsReturned = true
    end
end

--==================================================
-- UI ELEMENTS
--================================================

-- Timer Display
local TimerRow = Instance.new("Frame", LochNessSection)
TimerRow.Size = UDim2.new(1, 0, 0, 40)
TimerRow.BackgroundTransparency = 1

local TimerLabel = CreateLabel(TimerRow, {
    Size = UDim2.new(0.4, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Next Event:"
})

local TimeDisplay = Instance.new("TextLabel", TimerRow)
TimeDisplay.Name = "LochNessTimeDisplay"
TimeDisplay.Size = UDim2.new(0.35, 0, 0, 28)
TimeDisplay.Position = UDim2.new(0.4, 0, 0.5, -14)
TimeDisplay.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TimeDisplay.BackgroundTransparency = 0.2
TimeDisplay.Font = Enum.Font.GothamBold
TimeDisplay.TextSize = 16
TimeDisplay.TextColor3 = Color3.fromRGB(0, 255, 140)
TimeDisplay.Text = "00:00:00"
CreateCorner(TimeDisplay, 6)

-- Status Indicator
local StatusLabel = CreateLabel(TimerRow, {
    Size = UDim2.new(0.25, 0, 0, 20),
    Position = UDim2.new(0.75, -5, 0.5, -10),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextColor3 = Color3.fromRGB(100, 100, 100),
    Text = "IDLE"
})

-- Teleport Button (manual)
local TeleportRow = Instance.new("Frame", LochNessSection)
TeleportRow.Size = UDim2.new(1, 0, 0, 36)
TeleportRow.BackgroundTransparency = 1

CreateLabel(TeleportRow, {
    Size = UDim2.new(1, -130, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Teleport to Ancient Ruin"
})

local TeleportBtn = Instance.new("TextButton", TeleportRow)
TeleportBtn.Size = UDim2.new(0, 110, 0, 26)
TeleportBtn.Position = UDim2.new(1, -126, 0.5, -13)
TeleportBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
TeleportBtn.Text = "Teleport"
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportBtn.Font = Enum.Font.GothamBold
TeleportBtn.TextSize = 12
CreateCorner(TeleportBtn, 8)

TeleportBtn.MouseButton1Click:Connect(function()
    -- Kalau event aktif, save dulu baru TP
    if _G.LochNessState.CurrentState == EVENT_STATE.ACTIVE then
        if not _G.LochNessState.SavedPosition then
            SaveCurrentPosition()
        end
    end
    TeleportToAncientRuin()
end)

-- Return Button (manual return)
local ReturnRow = Instance.new("Frame", LochNessSection)
ReturnRow.Size = UDim2.new(1, 0, 0, 36)
ReturnRow.BackgroundTransparency = 1

CreateLabel(ReturnRow, {
    Size = UDim2.new(1, -130, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Return to Saved Pos"
})

local ReturnBtn = Instance.new("TextButton", ReturnRow)
ReturnBtn.Size = UDim2.new(0, 110, 0, 26)
ReturnBtn.Position = UDim2.new(1, -126, 0.5, -13)
ReturnBtn.BackgroundColor3 = Color3.fromRGB(70, 40, 40)
ReturnBtn.Text = "Return"
ReturnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReturnBtn.Font = Enum.Font.GothamBold
ReturnBtn.TextSize = 12
CreateCorner(ReturnBtn, 8)

ReturnBtn.MouseButton1Click:Connect(function()
    ReturnToSavedPosition()
end)

-- Auto Teleport Toggle (Toggle Pill)
local AutoTeleportRow = Instance.new("Frame", LochNessSection)
AutoTeleportRow.Size = UDim2.new(1, 0, 0, 36)
AutoTeleportRow.BackgroundTransparency = 1

CreateLabel(AutoTeleportRow, {
    Size = UDim2.new(1, -70, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Auto TP + Return"
})

local AutoTeleportToggle, SetAutoTeleportState = CreateTogglePill(AutoTeleportRow, false, function(state)
    _G.LochNessState.AutoTeleportEnabled = state
    if NotifyFeature then 
        NotifyFeature("Loch Ness Auto: " .. (state and "ON" or "OFF"), state) 
    end
end)

--==================================================
-- MAIN LOOP (FIXED)
--================================================

-- Init - Set next event time immediately
_G.LochNessState.NextEventTime = GetNextEventStartUTC()

task.spawn(function()
    while true do
        -- Update state machine
        local stateChange = UpdateState()
        
        -- Handle auto actions berdasarkan state
        HandleAutoActions()
        
        -- Update UI
        local labelText, timeValue, color = GetDisplayTime()
        TimerLabel.Text = labelText
        TimeDisplay.Text = FormatTime(timeValue)
        TimeDisplay.TextColor3 = color
        
        -- Update status indicator
        local state = _G.LochNessState.CurrentState
        StatusLabel.Text = state
        if state == EVENT_STATE.IDLE then
            StatusLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
        elseif state == EVENT_STATE.ACTIVE then
            StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
        else
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        
        -- Debug notification untuk state change
        if stateChange and NotifyFeature then
            if stateChange == "EVENT_START" then
                NotifyFeature("Loch Ness Event STARTED!", true)
            elseif stateChange == "EVENT_END" then
                NotifyFeature("Loch Ness Event ENDED!", false)
            end
        end
        
        task.wait(0.5)
    end
end)

--==================================================
-- CHEST FARM SECTION (Replion-based, Toggle Pill)
--==================================================

local ChestFarmSection = CreateSectionDropdown(TeleportPage, "Chest Farm")
Instance.new("UIListLayout", ChestFarmSection).SortOrder = Enum.SortOrder.LayoutOrder
ChestFarmSection.UIListLayout.Padding = UDim.new(0, 6)

-- State global
_G.RAYChestFarmOn = _G.RAYChestFarmOn or false
_G.ChestFarmReplionReady = false

-- Status row dengan toggle pill
local ChestFarmStatusRow = Instance.new("Frame", ChestFarmSection)
ChestFarmStatusRow.Size = UDim2.new(1, 0, 0, 36)
ChestFarmStatusRow.BackgroundTransparency = 1

CreateLabel(ChestFarmStatusRow, {
    Size = UDim2.new(0.5, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = THEME.TEXT,
    Text = "Auto Claim Chests"
})

-- Toggle pill
local ChestFarmToggle, SetChestFarmState = CreateTogglePill(ChestFarmStatusRow, _G.RAYChestFarmOn, function(state)
    _G.RAYChestFarmOn = state
    if NotifyFeature then 
        NotifyFeature("Chest Farm: " .. (state and "ON" or "OFF"), state) 
    end
end)

-- Status label
local ChestFarmInfoLabel = CreateLabel(ChestFarmSection, {
    Size = UDim2.new(1, -32, 0, 20),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    Text = "Waiting Replion..."
})

-- Stats row
local ChestFarmStatsRow = Instance.new("Frame", ChestFarmSection)
ChestFarmStatsRow.Size = UDim2.new(1, 0, 0, 24)
ChestFarmStatsRow.BackgroundTransparency = 1

local ChestCountLabel = CreateLabel(ChestFarmStatsRow, {
    Size = UDim2.new(0.5, -10, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Color3.fromRGB(0, 255, 140),
    Text = "Chests: 0"
})

------------------------------------------------------------
-- REPLION SETUP
------------------------------------------------------------

local ClaimPirateChest = NetFolder:WaitForChild("RE/ClaimPirateChest")

local chestReplion

-- Inisialisasi Replion
task.spawn(function()
    local ok, r = pcall(function()
        return Replion.Client:WaitReplion("PirateTreasureChests")
    end)
    
    if not ok or not r or typeof(r.Data) ~= "table" then
        warn("[ChestFarm] Failed to get PirateTreasureChests")
        ChestFarmInfoLabel.Text = "Replion failed"
        ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    chestReplion = r
    _G.ChestFarmReplionReady = true
    ChestFarmInfoLabel.Text = "Replion connected"
    ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    -- Debug print
    print("[ChestFarm] Replion Data:", chestReplion.Data)
end)

-- Helper get chest UUIDs
local function GetAllChestUUIDs()
    if not chestReplion then return {} end
    local data = chestReplion.Data
    local spawned = data and data.SpawnedChests
    if typeof(spawned) ~= "table" then return {} end

    local list = {}
    for i, entry in ipairs(spawned) do
        local uuid = entry.Id
        if typeof(uuid) == "string" then
            table.insert(list, uuid)
        end
    end
    return list
end

------------------------------------------------------------
-- FARM LOOP
------------------------------------------------------------

task.spawn(function()
    while true do
        task.wait(0.25)

        -- Update status label berdasarkan state
        if not _G.ChestFarmReplionReady then
            ChestFarmInfoLabel.Text = "Connecting to Replion..."
            continue
        end

        if not _G.RAYChestFarmOn then
            ChestFarmInfoLabel.Text = "Paused"
            ChestFarmInfoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            continue
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
        end
    end
end)

print("[ChestFarm] Section loaded with Replion integration")

--==================================================
-- SAVED POSITIONS LOGIC
--==================================================

local function GetCurrentPosition()
    local char = Player.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    return hrp.CFrame
end

local function SavePosition(name)
    local cf = GetCurrentPosition()
    if not cf then
        if NotifyFeature then NotifyFeature("Failed to save position!", false) end
        return false
    end
    
    _G.RAY_SavedPositions[name] = {
        Position = cf.Position,
        LookVector = cf.LookVector,
        UpVector = cf.UpVector,
        Time = os.time()
    }
    
    if NotifyFeature then NotifyFeature("Saved position: " .. name, true) end
    return true
end

local function TeleportToSaved(name)
    local data = _G.RAY_SavedPositions[name]
    if not data then
        if NotifyFeature then NotifyFeature("Position not found: " .. name, false) end
        return
    end
    
    local hrp = (Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local cf = CFrame.new(data.Position, data.Position + data.LookVector)
    hrp.CFrame = cf
    
    if NotifyFeature then NotifyFeature("Teleported to: " .. name, true) end
end

local function DeleteSavedPosition(name)
    _G.RAY_SavedPositions[name] = nil
    if NotifyFeature then NotifyFeature("Deleted position: " .. name, true) end
end

-- Auto teleport ke posisi terakhir saat execute
task.spawn(function()
    task.wait(2)
    
    local lastSaved = nil
    local lastTime = 0
    
    for name, data in pairs(_G.RAY_SavedPositions) do
        if data.Time and data.Time > lastTime then
            lastTime = data.Time
            lastSaved = name
        end
    end
    
    if lastSaved then
        TeleportToSaved(lastSaved)
    end
end)

--==================================================
-- SAVED POSITIONS SECTION
--==================================================

local SavedPosSection = CreateSectionDropdown(TeleportPage, "Saved Positions")
Instance.new("UIListLayout", SavedPosSection).SortOrder = Enum.SortOrder.LayoutOrder
SavedPosSection.UIListLayout.Padding = UDim.new(0, 6)

local SavedPosPanel, SavedPosScroll = CreateTeleportPanel("Saved Positions", "Pilih posisi tersimpan untuk teleport.")

-- Helper untuk count table
local function TableCount(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

-- Refresh list function
local function RefreshSavedPositionsList()
    for _, child in ipairs(SavedPosScroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    local names = {}
    for name in pairs(_G.RAY_SavedPositions) do table.insert(names, name) end
    table.sort(names)
    
    for _, name in ipairs(names) do
        local row = Instance.new("Frame", SavedPosScroll)
        row.Size = UDim2.new(1, -4, 0, 24)
        row.BackgroundTransparency = 1
        row.ZIndex = 11
        
        local line = Instance.new("Frame", row)
        line.Name = "Highlight"
        line.Size = UDim2.new(0, 3, 1, 0)
        line.BackgroundColor3 = THEME.MAIN
        line.Visible = false
        line.ZIndex = 12
        
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(1, -30, 1, 0)
        btn.Position = UDim2.new(0, 4, 0, 0)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        btn.TextColor3 = THEME.TEXT
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Text = "  " .. name
        btn.ZIndex = 11
        
        CreateCorner(btn, 6)
        
        local delBtn = Instance.new("TextButton", row)
        delBtn.Size = UDim2.new(0, 20, 0, 20)
        delBtn.Position = UDim2.new(1, -26, 0.5, -10)
        delBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
        delBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
        delBtn.Font = Enum.Font.GothamBold
        delBtn.TextSize = 12
        delBtn.Text = "X"
        delBtn.ZIndex = 11
        
        CreateCorner(delBtn, 4)
        
        btn.MouseButton1Click:Connect(function()
            TeleportToSaved(name)
            for _, child in ipairs(SavedPosScroll:GetChildren()) do
                local hl = child:FindFirstChild("Highlight")
                if hl then hl.Visible = (child == row) end
            end
        end)
        
        delBtn.MouseButton1Click:Connect(function()
            DeleteSavedPosition(name)
            RefreshSavedPositionsList()
        end)
    end
end

-- Save Current Position Row
do
    local row = Instance.new("Frame", SavedPosSection)
    row.Size = UDim2.new(1, 0, 0, 36)
    row.BackgroundTransparency = 1
    
    CreateLabel(row, {
        Size = UDim2.new(0.5, -20, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = THEME.TEXT,
        Text = "Save Current Pos"
    })
    
    local nameBox = Instance.new("TextBox", row)
    nameBox.Size = UDim2.new(0.3, 0, 0, 24)
    nameBox.Position = UDim2.new(0.5, -10, 0.5, -12)
    nameBox.BackgroundColor3 = THEME.CARD
    nameBox.BackgroundTransparency = 0.12
    nameBox.Text = "Pos " .. (TableCount(_G.RAY_SavedPositions) + 1)
    nameBox.TextColor3 = THEME.TEXT
    nameBox.Font = Enum.Font.Gotham
    nameBox.TextSize = 12
    nameBox.ClearTextOnFocus = true
    
    CreateCorner(nameBox, 6)
    
    local saveBtn = Instance.new("TextButton", row)
    saveBtn.Size = UDim2.new(0, 60, 0, 24)
    saveBtn.Position = UDim2.new(1, -70, 0.5, -12)
    saveBtn.BackgroundColor3 = Color3.fromRGB(40, 70, 40)
    saveBtn.TextColor3 = THEME.TEXT
    saveBtn.Font = Enum.Font.GothamBold
    saveBtn.TextSize = 12
    saveBtn.Text = "Save"
    
    CreateCorner(saveBtn, 6)
    
    saveBtn.MouseButton1Click:Connect(function()
        local name = nameBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
        if #name == 0 then
            name = "Pos " .. (TableCount(_G.RAY_SavedPositions) + 1)
        end
        
        if SavePosition(name) then
            RefreshSavedPositionsList()
            nameBox.Text = "Pos " .. (TableCount(_G.RAY_SavedPositions) + 1)
        end
    end)
end

-- Open Panel Button
CreateSectionRow(SavedPosSection, "Saved Positions Panel", "Open", function()
    SavedPosPanel.Visible = not SavedPosPanel.Visible
    if SavedPosPanel.Visible then
        RefreshSavedPositionsList()
    end
end)

-- Initial refresh
RefreshSavedPositionsList()

--==================================================
-- CLOSE PANELS ON OUTSIDE CLICK (FIXED)
--==================================================

-- List semua panel yang perlu di-track
local AllPanels = {IslandPanel, PlayerPanel, EventHuntPanel, SavedPosPanel}

-- Fungsi cek posisi di dalam panel
local function IsInsidePanel(panel, pos)
    if not panel or not panel.Visible then return false end
    local absPos = panel.AbsolutePosition
    local absSize = panel.AbsoluteSize
    return (pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and 
            pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y)
end

-- Fungsi cek posisi di dalam section dropdown (untuk menghindari nutup panel saat klik dropdown)
local function IsInsideSection(section, pos)
    if not section then return false end
    local absPos = section.AbsolutePosition
    local absSize = section.AbsoluteSize
    return (pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and 
            pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y)
end

-- Input handler yang lebih robust
UIS.InputBegan:Connect(function(input)
    -- Cuma proses mouse/touch
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and 
       input.UserInputType ~= Enum.UserInputType.Touch then 
        return 
    end
    
    local pos = input.Position
    
    -- Cek kalo klik di dalam panel manapun, jangan tutup apa-apa
    for _, panel in ipairs(AllPanels) do
        if IsInsidePanel(panel, pos) then
            return -- Klik di dalam panel, abort
        end
    end
    
    -- Cek kalo klik di dalam section dropdown, juga jangan tutup
    local sections = {IslandSection, PlayerSection, EventHuntSection, LochNessSection, ChestFarmSection, SavedPosSection}
    for _, section in ipairs(sections) do
        if IsInsideSection(section, pos) then
            return -- Klik di dalam section, abort
        end
    end
    
    -- Klik di luar semua panel dan section, tutup semua panel
    for _, panel in ipairs(AllPanels) do
        if panel and panel.Visible then
            panel.Visible = false
        end
    end
end)
