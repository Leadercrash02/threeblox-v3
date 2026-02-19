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
--==================================================
-- ULTRA MINIMIZED - AVOID 200 LOCAL LIMIT
--==================================================
IslandTeleportCF={["Arrow Artifact"]=CFrame.new(879.857178,4.92162275,-339.661469,-0.195367768,0,0.980730057,0,1,0,-0.980730057,0,-0.195367768),["Crescent Artifact"]=CFrame.new(1382.48401,4.83972979,113.104294,-0.956645668,0,0.291254193,0,1,0,-0.291254193,0,-0.956645668),["Diamond Artifact"]=CFrame.new(1835.33704,4.92876816,-314.988342,0.219969183,0,-0.975506842,0,1,0,0.975506842,0,0.219969183),["Heartfelt Island"]=CFrame.new(1112.6106,4.84564829,2719.63818,-0.0125409178,-5.2643145e-08,-0.999921381,-1.06123528e-08,1,-5.2514185e-08,0.999921381,9.95294158e-09,-0.0125409178),["Hourglass Diamond Artifact"]=CFrame.new(1500.73413,6.37703848,-849.561951,-0.983483791,0,-0.180996269,0,1,0,0.180996269,0,-0.983483791),["Ancient Jungle"]=CFrame.new(1470.92688,4.58799648,-323.604401,-0.240510166,0,-0.97064662,0,1,0,0.97064662,0,-0.240510166),["Ancient Ruin"]=CFrame.new(6082.87842,-585.924316,4633.71631,-0.681475937,0,0.731840551,0,1,0,-0.731840551,0,-0.681475937),["Cavern Volcanic 1"]=CFrame.new(1258.64758,83.4165039,-10248.0986,0.00370242121,-1.42619994e-09,0.999993145,-5.48521122e-14,1,1.42620993e-09,-0.999993145,-5.3352817e-12,0.00370242121),["Cavern Volcanic 2"]=CFrame.new(1106.69495,86.072998,-10248.0986,-0.00201654364,-2.72424678e-08,0.999997973,-5.50374711e-11,1,2.72424128e-08,-0.999997973,-1.01846327e-13,-0.00201654364),["Coral Reefs"]=CFrame.new(-2917.92163,3.24999928,2073.65894,0.185246676,0,0.982692063,0,1,0,-0.982692063,0,0.185246676),["Crater Island"]=CFrame.new(1021.73822,22.0761662,5075.62207,0.110775813,0,-0.993845403,0,1,0,0.993845403,0,0.110775813),["Crystalline Passage"]=CFrame.new(6050.46533,-538.900208,4374.14404,-0.999980807,0,0.00619776407,0,1,0,-0.00619776407,0,-0.999980807),["Crystal Depths"]=CFrame.new(5816.59766,-905.712524,15416.5459,0.653240383,0,-0.75715059,0,1,0,0.75715059,0,0.653240383),["Esoteric Depths"]=CFrame.new(3232.90356,-1302.8551,1401.0824,0.483647138,0,-0.875263095,0,1,0,0.875263095,0,0.483647138),["Fisherman Spawn"]=CFrame.new(94.4113464,17.0335178,2832.35474,0.997892678,0,0.0648857802,0,1,0,-0.0648857802,0,0.997892678),["Kohana"]=CFrame.new(-661.520142,17.2500553,525.53125,0.379789084,-3.69101372e-08,-0.925073087,-4.96903567e-08,1,-6.03000885e-08,0.925073087,6.88685304e-08,0.379789084),["Kohana Volcano"]=CFrame.new(-615.731567,48.5698662,189.133865,0.256806821,0,0.966462731,0,1,0,-0.966462731,0,0.256806821),["Lava Basin"]=CFrame.new(893.590942,89.0328979,-10196.835,-0.435751051,6.88466599e-08,-0.90006721,-2.40178668e-08,1,8.81183837e-08,0.90006721,6.0015374e-08,-0.435751051),["Maze Room"]=CFrame.new(3439.70679,-287.844818,3390.59546,-0.96200937,0,-0.273016393,0,1,0,0.273016393,0,-0.96200937),["Pirate Cove"]=CFrame.new(3408.83179,3.73505521,3444.31812,-0.76647383,0,-0.642275512,0,1,0,0.642275512,0,-0.76647383),["Pirate Cove Leviathan"]=CFrame.new(3471.53125,-287.84317,3474.38257,-0.962593496,0,-0.270949841,0,1,0,0.270949841,0,-0.962593496),["Pirate Treasure Room"]=CFrame.new(3291.12646,-299.092438,3068.04639,0.483647138,0,-0.875263095,0,1,0,0.875263095,0,0.483647138),["Sacred Temple"]=CFrame.new(1496.13306,-22.1250019,-639.212097,0.987680018,0,0.156487122,0,1,0,-0.156487122,0,0.987680018),["Sysphus State"]=CFrame.new(-3656.59058,-134.150406,-959.743469,-0.287091494,0,0.957903147,0,1,0,-0.957903147,0,-0.287091494),["Temple Guardian"]=CFrame.new(1486.06165,127.624977,-590.121094,0.998732686,0,0.0503287315,0,1,0,-0.0503287315,0,0.998732686),["Treasure Room"]=CFrame.new(-3598.04102,-275.723602,-1640.93933,-0.203907222,0,0.978990197,0,1,0,-0.978990197,0,-0.203907222),["Tropical Grove"]=CFrame.new(-2016.4812,9.03753567,3752.35327,-0.995569646,0,0.0940273255,0,1,0,-0.0940273255,0,-0.995569646),["Underground Cellar"]=CFrame.new(2125.30005,-91.1976624,-750.400024,-0.661489964,0,-0.749954045,0,1,0,0.749954045,0,-0.661489964),["Weather Machine"]=CFrame.new(-1476.29089,3.49999928,1909.09583,-0.429490566,0,-0.903071344,0,1,0,0.903071344,0,-0.429490566)}

_G.RAY=_G.RAY or{GhostSharkHuntActive=false,MegalodonHuntActive=false,SavedPositions={},SelectedMerchantItem=nil,MerchantBuyQty=1,ChestFarmOn=false,ChestFarmReplionReady=false,LochNess={CurrentState="IDLE",NextEventTime=0,EventEndTime=0,IsAutoTeleported=false,IsReturned=false,SavedPosition=nil,AutoTeleportEnabled=false},WeatherPreset={Selected=nil,AutoBuy=false,StatusText="Ready"}}

TeleportPage,ShopPage=Pages["Teleport"],Pages["Shop"]
if not TeleportPage or not ShopPage then warn("Pages not found")return end

-- Helper functions - minimized locals
function CC(p,r)local c=Instance.new("UICorner",p)c.CornerRadius=UDim.new(0,r or 8)return c end
function CS(p,c,t)local s=Instance.new("UIStroke",p)s.Color,s.Thickness,s.Transparency=c or THEME.MAIN,t or 1,0.5 return s end
function CL(p,pr)local l=Instance.new("TextLabel",p)for k,v in pairs(pr)do l[k]=v end return l end
function CTP(n,i)local p=Instance.new("Frame",Main)p.Name,p.Size,p.AnchorPoint,p.Position=n.."RightPanel",UDim2.new(0,220,1,-46),Vector2.new(1,0),UDim2.new(1,-10,0,40)p.BackgroundColor3,p.BackgroundTransparency,p.BorderSizePixel,p.Visible,p.ZIndex=THEME.CARD,0.25,0,false,10 CC(p,10)CS(p,THEME.MAIN,0.5)CL(p,{Size=UDim2.new(1,-10,0,24),Position=UDim2.new(0,5,0,6),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=16,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,ZIndex=11,Text=n})CL(p,{Size=UDim2.new(1,-10,0,18),Position=UDim2.new(0,5,0,30),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(200,200,200),ZIndex=11,Text=i})local s=Instance.new("ScrollingFrame",p)s.Size,s.Position,s.BackgroundTransparency,s.BorderSizePixel,s.ScrollBarThickness,s.AutomaticCanvasSize,s.ScrollBarImageColor3,s.ZIndex=UDim2.new(1,-10,1,-70),UDim2.new(0,5,0,54),1,0,3,Enum.AutomaticSize.Y,THEME.MAIN,10 Instance.new("UIListLayout",s).SortOrder=Enum.SortOrder.LayoutOrder s.UIListLayout.Padding=UDim.new(0,4)return p,s end
function CLE(p,t,o)local r=Instance.new("Frame",p)r.Size,r.BackgroundTransparency,r.ZIndex=UDim2.new(1,-4,0,24),1,11 Instance.new("Frame",r).Name,Instance.new("Frame",r).Size,Instance.new("Frame",r).BackgroundColor3,Instance.new("Frame",r).Visible,Instance.new("Frame",r).ZIndex="Highlight",UDim2.new(0,3,1,0),THEME.MAIN,false,12 local b=Instance.new("TextButton",r)b.Size,b.Position,b.BackgroundColor3,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment,b.Text,b.ZIndex=UDim2.new(1,-6,1,0),UDim2.new(0,4,0,0),Color3.fromRGB(30,30,50),THEME.TEXT,Enum.Font.Gotham,12,Enum.TextXAlignment.Left,"  "..t,11 CC(b,6)b.MouseButton1Click:Connect(function()o()for _,c in ipairs(p:GetChildren())do local h=c:FindFirstChild("Highlight")if h then h.Visible=(c==r)end end end)return r end
function CSR(p,t,b,o)local r=Instance.new("Frame",p)r.Size,r.BackgroundTransparency=UDim2.new(1,0,0,36),1 CL(r,{Size=UDim2.new(1,-110,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text=t})local btn=Instance.new("TextButton",r)btn.Size,btn.Position,btn.BackgroundColor3,btn.BackgroundTransparency,btn.Text,btn.TextColor3,btn.Font,btn.TextSize=UDim2.new(0,110,0,24),UDim2.new(1,-126,0.5,-12),THEME.CARD,0.1,b,THEME.TEXT,Enum.Font.GothamBold,12 CC(btn,8)btn.MouseButton1Click:Connect(o)return r end
function CTPi(p,d,o)local f=Instance.new("Frame",p)f.Size,f.Position,f.BackgroundColor3,f.BorderSizePixel=UDim2.new(0,50,0,26),UDim2.new(1,-66,0.5,-13),Color3.fromRGB(40,40,50),0 CC(f,13)local c=Instance.new("Frame",f)c.Size,c.Position,c.BackgroundColor3,c.BorderSizePixel=UDim2.new(0,20,0,20),UDim2.new(0,3,0.5,-10),Color3.fromRGB(255,255,255),0 CC(c,10)local s=d or false local function u()if s then f.BackgroundColor3=Color3.fromRGB(0,170,100)c:TweenPosition(UDim2.new(0,27,0.5,-10),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2,true)else f.BackgroundColor3=Color3.fromRGB(70,70,80)c:TweenPosition(UDim2.new(0,3,0.5,-10),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2,true)end end u()Instance.new("TextButton",f).Size,Instance.new("TextButton",f).BackgroundTransparency,Instance.new("TextButton",f).Text=UDim2.new(1,0,1,0),1,"" Instance.new("TextButton",f).MouseButton1Click:Connect(function()s=not s u()if o then o(s)end end)return f,function(n)s=n u()end end
function TC(t)local c=0 for _ in pairs(t)do c=c+1 end return c end
function FN(n)if n>=1000000 then return string.format("%.1fm",n/1000000)elseif n>=1000 then return string.format("%.1fk",n/1000)else return tostring(n)end end

-- Island Teleport
IslandSection=CreateSectionDropdown(TeleportPage,"Teleport Island")Instance.new("UIListLayout",IslandSection).SortOrder=Enum.SortOrder.LayoutOrder IslandSection.UIListLayout.Padding=UDim.new(0,6)IslandPanel,IslandScroll=CTP("Teleport Island","Pilih lokasi island untuk teleport.")function TTI(cf,l)local h=(Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")if h then h.CFrame=cf if NotifyFeature then NotifyFeature("Teleport: "..l,true)end end end islandNames={}for n in pairs(IslandTeleportCF)do table.insert(islandNames,n)end table.sort(islandNames)for _,n in ipairs(islandNames)do CLE(IslandScroll,n,function()TTI(IslandTeleportCF[n],n)end)end CSR(IslandSection,"Teleport Island Panel","Open",function()IslandPanel.Visible=not IslandPanel.Visible end)

-- Player Teleport
PlayerSection=CreateSectionDropdown(TeleportPage,"Teleport Player")Instance.new("UIListLayout",PlayerSection).SortOrder=Enum.SortOrder.LayoutOrder PlayerSection.UIListLayout.Padding=UDim.new(0,6)PlayerPanel,PlayerScroll=CTP("Teleport Player","Pilih player untuk teleport ke posisi mereka.")function TTP(tp)if not tp or tp==Player then return end local m,t=(Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart"),tp.Character and tp.Character:FindFirstChild("HumanoidRootPart")if m and t then m.CFrame=t.CFrame if NotifyFeature then NotifyFeature("Teleport to: "..tp.Name,true)end end end function CPE(plr)CLE(PlayerScroll,plr.Name,function()TTP(plr)end).Name="PlayerRow_"..plr.Name end for _,plr in ipairs(Players:GetPlayers())do if plr~=Player then CPE(plr)end end Players.PlayerAdded:Connect(function(plr)if plr~=Player then CPE(plr)end end)Players.PlayerRemoving:Connect(function(plr)local r=PlayerScroll:FindFirstChild("PlayerRow_"..plr.Name)if r then r:Destroy()end end)CSR(PlayerSection,"Teleport Player Panel","Open",function()PlayerPanel.Visible=not PlayerPanel.Visible end)

-- Event Hunt
ghostSharkFloor=nil function GSM()local pr=Workspace:FindFirstChild("Props")if not pr then return nil end local m=pr:FindFirstChild("Shark Hunt")or pr:FindFirstChild("Ghost Shark Hunt")return(m and m:IsA("Model"))and m or nil end function EFS()local m=GSM()if not m then return nil,nil end if not m.PrimaryPart then local a=m:FindFirstChildWhichIsA("BasePart",true)if a then m.PrimaryPart=a end end local an=m.PrimaryPart if not an then return nil,nil end if not ghostSharkFloor or not ghostSharkFloor.Parent then ghostSharkFloor=Instance.new("Part")ghostSharkFloor.Name,ghostSharkFloor.Anchored,ghostSharkFloor.CanCollide,ghostSharkFloor.Transparency,ghostSharkFloor.Size,ghostSharkFloor.Material,ghostSharkFloor.Parent="SharkHuntFloor_Client",true,true,1,Vector3.new(80,1,80),Enum.Material.SmoothPlastic,Workspace end ghostSharkFloor.CFrame=CFrame.new(Vector3.new(an.Position.X,an.Position.Y-2,an.Position.Z))return an,ghostSharkFloor end function TTGS()local a,f=EFS()if not a or not f then return end local c,r=Player.Character or Player.CharacterAdded:Wait(),(Player.Character or Player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")r.AssemblyLinearVelocity,r.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)c:PivotTo(CFrame.new(f.Position+Vector3.new(0,f.Size.Y/2+4,0),f.Position+Vector3.new(0,f.Size.Y/2+4,0)+a.CFrame.LookVector))end function TTM()local a for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name=="Megalodon Hunt"then a=o break end end if not a then return end local c,r=Player.Character or Player.CharacterAdded:Wait(),(Player.Character or Player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")r.AssemblyLinearVelocity,r.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)c:PivotTo(CFrame.new(a.Position+Vector3.new(0,5,0),a.Position+Vector3.new(0,5,0)+a.CFrame.LookVector))end task.spawn(function()local ok,rp=pcall(function()return require(ReplicatedStorage.Packages.Replion)end)if not ok or not rp or not rp.Client then return end local sc,er=pcall(function()return rp.Client:WaitReplion("Events")end)if not sc or not er then return end local function oi(i,n)if n=="Shark Hunt"then _G.RAY.GhostSharkHuntActive=true if NotifyFeature then NotifyFeature("Ghost Shark Hunt Spawned!",true)end end end local function orm(i,n)if n=="Shark Hunt"then _G.RAY.GhostSharkHuntActive=false if ghostSharkFloor then ghostSharkFloor:Destroy()ghostSharkFloor=nil end if NotifyFeature then NotifyFeature("Ghost Shark Hunt Ended",false)end end end er:OnArrayInsert("Events",oi)er:OnArrayRemove("Events",orm)for i,n in ipairs(er:Get("Events")or{})do oi(i,n)end end)EventHuntSection=CreateSectionDropdown(TeleportPage,"Event Hunt")Instance.new("UIListLayout",EventHuntSection).SortOrder=Enum.SortOrder.LayoutOrder EventHuntSection.UIListLayout.Padding=UDim.new(0,6)EventHuntPanel,EventHuntScroll=CTP("Event Hunt","Pilih hunt event untuk teleport.")CLE(EventHuntScroll,"Ghost Shark Hunt",function()if not _G.RAY.GhostSharkHuntActive then if NotifyFeature then NotifyFeature("Ghost Shark Hunt not active!",false)end return end TTGS()if NotifyFeature then NotifyFeature("Teleported to Ghost Shark Hunt",true)end end)CLE(EventHuntScroll,"Megalodon Hunt",function()if not _G.RAY.MegalodonHuntActive then if NotifyFeature then NotifyFeature("Megalodon Hunt not found!",false)end return end TTM()if NotifyFeature then NotifyFeature("Teleported to Megalodon Hunt",true)end end)task.spawn(function()while true do for _,e in ipairs(EventHuntScroll:GetChildren())do if e:IsA("Frame")then local b,h=e:FindFirstChildOfClass("TextButton"),e:FindFirstChild("Highlight")if b and h then if b.Text:find("Ghost Shark")then if _G.RAY.GhostSharkHuntActive then b.BackgroundColor3,h.Visible=Color3.fromRGB(40,70,40),true else b.BackgroundColor3,h.Visible=Color3.fromRGB(30,30,50),false end elseif b.Text:find("Megalodon")then local ex=false for _,o in ipairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Name=="Megalodon Hunt"then ex=true break end end _G.RAY.MegalodonHuntActive=ex if ex then b.BackgroundColor3,h.Visible=Color3.fromRGB(40,70,40),true else b.BackgroundColor3,h.Visible=Color3.fromRGB(30,30,50),false end end end end end task.wait(1)end end)CSR(EventHuntSection,"Event Hunt Panel","Open",function()EventHuntPanel.Visible=not EventHuntPanel.Visible end)

-- Loch Ness
ANCIENT_RUIN_CF=CFrame.new(6082.87842,-585.924316,4633.71631,-0.681475937,0,0.731840551,0,1,0,-0.731840551,0,-0.681475937)EVENT_DURATION_MINUTES,EVENT_HOURS_UTC=10,{0,4,8,12,16,20}EVENT_STATE={IDLE="IDLE",ACTIVE="ACTIVE",ENDED="ENDED"}function GNES()local n=os.date("!*t",os.time())local nm=n.hour*60+n.min for _,h in ipairs(EVENT_HOURS_UTC)do if h*60>nm then return os.time({year=n.year,month=n.month,day=n.day,hour=h,min=0,sec=0,isdst=false})end end return os.time({year=n.year,month=n.month,day=n.day+1,hour=EVENT_HOURS_UTC[1],min=0,sec=0,isdst=false})end function FT(s)s=math.max(0,math.floor(s))return string.format("%02d:%02d:%02d",math.floor(s/3600),math.floor((s%3600)/60),s%60)end function SCP()local c,h=Player.Character,Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")if not h then return false end _G.RAY.LochNess.SavedPosition={Position=h.CFrame.Position,LookVector=h.CFrame.LookVector,Time=os.time()}return true end function TTAR()local c,h=Player.Character or Player.CharacterAdded:Wait(),(Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")if not h then return end h.AssemblyLinearVelocity,h.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)c:PivotTo(ANCIENT_RUIN_CF)if NotifyFeature then NotifyFeature("Teleported to Ancient Ruin!",true)end end function RTSP()local d=_G.RAY.LochNess.SavedPosition if not d then if NotifyFeature then NotifyFeature("No saved position!",false)end return end local c,h=Player.Character or Player.CharacterAdded:Wait(),(Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")if not h then return end h.CFrame=CFrame.new(d.Position,d.Position+d.LookVector)if NotifyFeature then NotifyFeature("Returned to saved position!",true)end end function ULS()local n,s=os.time(),_G.RAY.LochNess if s.CurrentState==EVENT_STATE.IDLE then if n>=s.NextEventTime then s.CurrentState,s.EventEndTime,s.IsAutoTeleported,s.IsReturned=EVENT_STATE.ACTIVE,n+(EVENT_DURATION_MINUTES*60),false,false return"EVENT_START"end elseif s.CurrentState==EVENT_STATE.ACTIVE then if n>=s.EventEndTime then s.CurrentState=EVENT_STATE.ENDED return"EVENT_END"end elseif s.CurrentState==EVENT_STATE.ENDED then s.NextEventTime,s.CurrentState,s.IsAutoTeleported,s.IsReturned=GNES(),EVENT_STATE.IDLE,false,false return"RESET"end return nil end function GLDT()local n,s=os.time(),_G.RAY.LochNess if s.CurrentState==EVENT_STATE.IDLE then return"Next Event:",s.NextEventTime-n,Color3.fromRGB(0,255,140)elseif s.CurrentState==EVENT_STATE.ACTIVE then return"Event Ends:",s.EventEndTime-n,Color3.fromRGB(255,140,0)else return"Event Ended!",0,Color3.fromRGB(255,80,80)end end function HLAA()local s=_G.RAY.LochNess if s.CurrentState==EVENT_STATE.ACTIVE and s.AutoTeleportEnabled and not s.IsAutoTeleported then if SCP()then task.wait(0.5)TTAR()s.IsAutoTeleported=true end end if s.CurrentState==EVENT_STATE.ENDED and s.AutoTeleportEnabled and s.IsAutoTeleported and not s.IsReturned then task.wait(1)RTSP()s.IsReturned=true end end LochNessSection=CreateSectionDropdown(TeleportPage,"Lochnes Event")Instance.new("UIListLayout",LochNessSection).SortOrder=Enum.SortOrder.LayoutOrder LochNessSection.UIListLayout.Padding=UDim.new(0,6)TimerRow=Instance.new("Frame",LochNessSection)TimerRow.Size,TimerRow.BackgroundTransparency=UDim2.new(1,0,0,40),1 TimerLabel=CL(TimerRow,{Size=UDim2.new(0.4,-10,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Next Event:"})TimeDisplay=Instance.new("TextLabel",TimerRow)TimeDisplay.Name,TimeDisplay.Size,TimeDisplay.Position,TimeDisplay.BackgroundColor3,TimeDisplay.BackgroundTransparency,TimeDisplay.Font,TimeDisplay.TextSize,TimeDisplay.TextColor3,TimeDisplay.Text="LochNessTimeDisplay",UDim2.new(0.35,0,0,28),UDim2.new(0.4,0,0.5,-14),Color3.fromRGB(20,20,30),0.2,Enum.Font.GothamBold,16,Color3.fromRGB(0,255,140),"00:00:00"CC(TimeDisplay,6)StatusLabel=CL(TimerRow,{Size=UDim2.new(0.25,0,0,20),Position=UDim2.new(0.75,-5,0.5,-10),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=11,TextXAlignment=Enum.TextXAlignment.Center,TextColor3=Color3.fromRGB(100,100,100),Text="IDLE"})TeleportRow=Instance.new("Frame",LochNessSection)TeleportRow.Size,TeleportRow.BackgroundTransparency=UDim2.new(1,0,0,36),1 CL(TeleportRow,{Size=UDim2.new(1,-130,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Teleport to Ancient Ruin"})TeleportBtn=Instance.new("TextButton",TeleportRow)TeleportBtn.Size,TeleportBtn.Position,TeleportBtn.BackgroundColor3,TeleportBtn.Text,TeleportBtn.TextColor3,TeleportBtn.Font,TeleportBtn.TextSize=UDim2.new(0,110,0,26),UDim2.new(1,-126,0.5,-13),Color3.fromRGB(40,70,40),"Teleport",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12 CC(TeleportBtn,8)TeleportBtn.MouseButton1Click:Connect(function()if _G.RAY.LochNess.CurrentState==EVENT_STATE.ACTIVE and not _G.RAY.LochNess.SavedPosition then SCP()end TTAR()end)ReturnRow=Instance.new("Frame",LochNessSection)ReturnRow.Size,ReturnRow.BackgroundTransparency=UDim2.new(1,0,0,36),1 CL(ReturnRow,{Size=UDim2.new(1,-130,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Return to Saved Pos"})ReturnBtn=Instance.new("TextButton",ReturnRow)ReturnBtn.Size,ReturnBtn.Position,ReturnBtn.BackgroundColor3,ReturnBtn.Text,ReturnBtn.TextColor3,ReturnBtn.Font,ReturnBtn.TextSize=UDim2.new(0,110,0,26),UDim2.new(1,-126,0.5,-13),Color3.fromRGB(70,40,40),"Return",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12 CC(ReturnBtn,8)ReturnBtn.MouseButton1Click:Connect(RTSP)AutoTeleportRow=Instance.new("Frame",LochNessSection)AutoTeleportRow.Size,AutoTeleportRow.BackgroundTransparency=UDim2.new(1,0,0,36),1 CL(AutoTeleportRow,{Size=UDim2.new(1,-70,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Auto TP + Return"})AutoTeleportToggle,SetAutoTeleportState=CTPi(AutoTeleportRow,false,function(s)_G.RAY.LochNess.AutoTeleportEnabled=s if NotifyFeature then NotifyFeature("Loch Ness Auto: "..(s and"ON"or"OFF"),s)end end)_G.RAY.LochNess.NextEventTime=GNES()task.spawn(function()while true do local sc=ULS()HLAA()local lt,tv,tc=GLDT()TimerLabel.Text,TimeDisplay.Text,TimeDisplay.TextColor3=lt,FT(tv),tc local st=_G.RAY.LochNess.CurrentState StatusLabel.Text,StatusLabel.TextColor3=st,(st==EVENT_STATE.IDLE and Color3.fromRGB(100,200,100)or(st==EVENT_STATE.ACTIVE and Color3.fromRGB(255,200,100)or Color3.fromRGB(255,100,100)))if sc and NotifyFeature then if sc=="EVENT_START"then NotifyFeature("Loch Ness Event STARTED!",true)elseif sc=="EVENT_END"then NotifyFeature("Loch Ness Event ENDED!",false)end end task.wait(0.5)end end)

-- Chest Farm
ChestFarmSection=CreateSectionDropdown(TeleportPage,"Chest Farm")Instance.new("UIListLayout",ChestFarmSection).SortOrder=Enum.SortOrder.LayoutOrder ChestFarmSection.UIListLayout.Padding=UDim.new(0,6)ChestFarmStatusRow=Instance.new("Frame",ChestFarmSection)ChestFarmStatusRow.Size,ChestFarmStatusRow.BackgroundTransparency=UDim2.new(1,0,0,36),1 CL(ChestFarmStatusRow,{Size=UDim2.new(0.5,-10,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Auto Claim Chests"})ChestFarmToggle,SetChestFarmState=CTPi(ChestFarmStatusRow,_G.RAY.ChestFarmOn,function(s)_G.RAY.ChestFarmOn=s if NotifyFeature then NotifyFeature("Chest Farm: "..(s and"ON"or"OFF"),s)end end)ChestFarmInfoLabel=CL(ChestFarmSection,{Size=UDim2.new(1,-32,0,20),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(150,150,150),Text="Waiting Replion..."})ChestFarmStatsRow=Instance.new("Frame",ChestFarmSection)ChestFarmStatsRow.Size,ChestFarmStatsRow.BackgroundTransparency=UDim2.new(1,0,0,24),1 ChestCountLabel=CL(ChestFarmStatsRow,{Size=UDim2.new(0.5,-10,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(0,255,140),Text="Chests: 0"})ClaimPirateChest,chestReplion=NetFolder:WaitForChild("RE/ClaimPirateChest"),nil task.spawn(function()local ok,r=pcall(function()return Replion.Client:WaitReplion("PirateTreasureChests")end)if not ok or not r or typeof(r.Data)~="table"then ChestFarmInfoLabel.Text,ChestFarmInfoLabel.TextColor3="Replion failed",Color3.fromRGB(255,100,100)return end chestReplion,_G.RAY.ChestFarmReplionReady,ChestFarmInfoLabel.Text,ChestFarmInfoLabel.TextColor3=r,true,"Replion connected",Color3.fromRGB(100,255,100)end)function GCU()if not chestReplion then return{}end local s=chestReplion.Data and chestReplion.Data.SpawnedChests if typeof(s)~="table"then return{}end local l={}for _,e in ipairs(s)do if typeof(e.Id)=="string"then table.insert(l,e.Id)end end return l end task.spawn(function()while true do task.wait(0.25)if not _G.RAY.ChestFarmReplionReady then ChestFarmInfoLabel.Text="Connecting to Replion..."continue end if not _G.RAY.ChestFarmOn then ChestFarmInfoLabel.Text,ChestFarmInfoLabel.TextColor3="Paused",Color3.fromRGB(150,150,150)continue end local u=GCU()ChestCountLabel.Text="Chests: "..#u if#u==0 then ChestFarmInfoLabel.Text,ChestFarmInfoLabel.TextColor3="No chests spawned",Color3.fromRGB(255,200,100)else ChestFarmInfoLabel.Text,ChestFarmInfoLabel.TextColor3="Claiming "..#u.." chests...",Color3.fromRGB(0,255,140)for _,i in ipairs(u)do pcall(function()ClaimPirateChest:FireServer(i)end)end end end end)print("[ChestFarm] Section loaded")

-- Saved Positions
function GCP()local c,h=Player.Character,Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")return h and h.CFrame or nil end function SP(n)local cf=GCP()if not cf then if NotifyFeature then NotifyFeature("Failed to save position!",false)end return false end _G.RAY.SavedPositions[n]={Position=cf.Position,LookVector=cf.LookVector,UpVector=cf.UpVector,Time=os.time()}if NotifyFeature then NotifyFeature("Saved position: "..n,true)end return true end function TTS(n)local d=_G.RAY.SavedPositions[n]if not d then if NotifyFeature then NotifyFeature("Position not found: "..n,false)end return end local h=(Player.Character or Player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")if not h then return end h.CFrame=CFrame.new(d.Position,d.Position+d.LookVector)if NotifyFeature then NotifyFeature("Teleported to: "..n,true)end end function DSP(n)_G.RAY.SavedPositions[n]=nil if NotifyFeature then NotifyFeature("Deleted position: "..n,true)end end task.spawn(function()task.wait(2)local ls,lt=nil,0 for n,d in pairs(_G.RAY.SavedPositions)do if d.Time and d.Time>lt then lt,ls=d.Time,n end end if ls then TTS(ls)end end)SavedPosSection=CreateSectionDropdown(TeleportPage,"Saved Positions")Instance.new("UIListLayout",SavedPosSection).SortOrder=Enum.SortOrder.LayoutOrder SavedPosSection.UIListLayout.Padding=UDim.new(0,6)SavedPosPanel,SavedPosScroll=CTP("Saved Positions","Pilih posisi tersimpan untuk teleport.")function RSPL()for _,c in ipairs(SavedPosScroll:GetChildren())do if c:IsA("Frame")then c:Destroy()end end local ns={}for n in pairs(_G.RAY.SavedPositions)do table.insert(ns,n)end table.sort(ns)for _,n in ipairs(ns)do local r=Instance.new("Frame",SavedPosScroll)r.Size,r.BackgroundTransparency,r.ZIndex=UDim2.new(1,-4,0,24),1,11 Instance.new("Frame",r).Name,Instance.new("Frame",r).Size,Instance.new("Frame",r).BackgroundColor3,Instance.new("Frame",r).Visible,Instance.new("Frame",r).ZIndex="Highlight",UDim2.new(0,3,1,0),THEME.MAIN,false,12 local b=Instance.new("TextButton",r)b.Size,b.Position,b.BackgroundColor3,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment,b.Text,b.ZIndex=UDim2.new(1,-30,1,0),UDim2.new(0,4,0,0),Color3.fromRGB(30,30,50),THEME.TEXT,Enum.Font.Gotham,12,Enum.TextXAlignment.Left,"  "..n,11 CC(b,6)local d=Instance.new("TextButton",r)d.Size,d.Position,d.BackgroundColor3,d.TextColor3,d.Font,d.TextSize,d.Text,d.ZIndex=UDim2.new(0,20,0,20),UDim2.new(1,-26,0.5,-10),Color3.fromRGB(80,30,30),Color3.fromRGB(255,150,150),Enum.Font.GothamBold,12,"X",11 CC(d,4)b.MouseButton1Click:Connect(function()TTS(n)for _,c in ipairs(SavedPosScroll:GetChildren())do local h=c:FindFirstChild("Highlight")if h then h.Visible=(c==r)end end end)d.MouseButton1Click:Connect(function()DSP(n)RSPL()end)end end do local r=Instance.new("Frame",SavedPosSection)r.Size,r.BackgroundTransparency=UDim2.new(1,0,0,36),1 CL(r,{Size=UDim2.new(0.5,-20,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Save Current Pos"})local nb=Instance.new("TextBox",r)nb.Size,nb.Position,nb.BackgroundColor3,nb.BackgroundTransparency,nb.Text,nb.TextColor3,nb.Font,nb.TextSize,nb.ClearTextOnFocus=UDim2.new(0.3,0,0,24),UDim2.new(0.5,-10,0.5,-12),THEME.CARD,0.12,"Pos "..(TC(_G.RAY.SavedPositions)+1),THEME.TEXT,Enum.Font.Gotham,12,true CC(nb,6)local sb=Instance.new("TextButton",r)sb.Size,sb.Position,sb.BackgroundColor3,sb.TextColor3,sb.Font,sb.TextSize,sb.Text=UDim2.new(0,60,0,24),UDim2.new(1,-70,0.5,-12),Color3.fromRGB(40,70,40),THEME.TEXT,Enum.Font.GothamBold,12,"Save" CC(sb,6)sb.MouseButton1Click:Connect(function()local nm=nb.Text:gsub("^%s+",""):gsub("%s+$","")if#nm==0 then nm="Pos "..(TC(_G.RAY.SavedPositions)+1)end if SP(nm)then RSPL()nb.Text="Pos "..(TC(_G.RAY.SavedPositions)+1)end end)end CSR(SavedPosSection,"Saved Positions Panel","Open",function()SavedPosPanel.Visible=not SavedPosPanel.Visible if SavedPosPanel.Visible then RSPL()end end)RSPL()

-- Close panels
AllPanels={IslandPanel,PlayerPanel,EventHuntPanel,SavedPosPanel}function IIP(p,pos)if not p or not p.Visible then return false end return(pos.X>=p.AbsolutePosition.X and pos.X<=p.AbsolutePosition.X+p.AbsoluteSize.X and pos.Y>=p.AbsolutePosition.Y and pos.Y<=p.AbsolutePosition.Y+p.AbsoluteSize.Y)end function IIS(s,pos)if not s then return false end return(pos.X>=s.AbsolutePosition.X and pos.X<=s.AbsolutePosition.X+s.AbsoluteSize.X and pos.Y>=s.AbsolutePosition.Y and pos.Y<=s.AbsolutePosition.Y+s.AbsoluteSize.Y)end UIS.InputBegan:Connect(function(i)if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end local pos=i.Position for _,p in ipairs(AllPanels)do if IIP(p,pos)then return end end for _,s in ipairs({IslandSection,PlayerSection,EventHuntSection,LochNessSection,ChestFarmSection,SavedPosSection})do if IIS(s,pos)then return end end for _,p in ipairs(AllPanels)do if p and p.Visible then p.Visible=false end end end)

-- Traveling Merchant - Ultra minimized
MerchantReplion=Replion.Client:WaitReplion("Merchant")MarketItemData=require(ReplicatedStorage.Shared.MarketItemData)PurchaseMarketItemRF=NetFolder:WaitForChild("RF/PurchaseMarketItem")MERCHANT_ITEM_MAP={}for _,i in ipairs(MarketItemData)do MERCHANT_ITEM_MAP[i.Id]=i end function GMS()local ids,stock=MerchantReplion:GetExpect("Items")or{},{}for _,id in ipairs(ids)do local d=MERCHANT_ITEM_MAP[id]if d then table.insert(stock,{Id=d.Id,Name=d.Identifier or d.Name or("Item_"..id),Price=d.Price or 0,Currency=d.Currency or"Coins",MaxStock=d.MaxStock or 1,Data=d})end end return stock end function BMI(id,q)q=math.max(1,tonumber(q)or 1)for i=1,q do task.spawn(function()pcall(function()PurchaseMarketItemRF:InvokeServer(id)end)end)task.wait(0.1)end return true end MerchantSection=CreateSectionDropdown(ShopPage,"Traveling Merchant")Instance.new("UIListLayout",MerchantSection).SortOrder=Enum.SortOrder.LayoutOrder MerchantSection.UIListLayout.Padding=UDim.new(0,6)MerchantPanel,MerchantScroll=CTP("Merchant Stock","Select item to purchase")StatusRow=Instance.new("Frame",MerchantSection)StatusRow.Size,StatusRow.BackgroundTransparency=UDim2.new(1,0,0,30),1 CL(StatusRow,{Size=UDim2.new(0.5,-10,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Merchant Status:"})MerchantStatus=CL(StatusRow,{Size=UDim2.new(0.5,-10,1,0),Position=UDim2.new(0.5,0,0,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(255,100,100),Text="Checking..."})SelectedRow=Instance.new("Frame",MerchantSection)SelectedRow.Size,SelectedRow.BackgroundTransparency=UDim2.new(1,0,0,30),1 CL(SelectedRow,{Size=UDim2.new(0.4,-10,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Selected:"})SelectedItemLabel=CL(SelectedRow,{Size=UDim2.new(0.6,-10,1,0),Position=UDim2.new(0.4,0,0,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(150,150,150),Text="None"})QuantityRow=Instance.new("Frame",MerchantSection)QuantityRow.Size,QuantityRow.BackgroundTransparency=UDim2.new(1,0,0,36),1 CL(QuantityRow,{Size=UDim2.new(0.4,-10,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Buy Quantity"})qtyBox=Instance.new("TextBox",QuantityRow)qtyBox.Size,qtyBox.Position,qtyBox.BackgroundColor3,qtyBox.BackgroundTransparency,qtyBox.Text,qtyBox.TextColor3,qtyBox.Font,qtyBox.TextSize,qtyBox.ClearTextOnFocus=UDim2.new(0,60,0,24),UDim2.new(0.4,-10,0.5,-12),THEME.CARD,0.1,tostring(_G.RAY.MerchantBuyQty),THEME.TEXT,Enum.Font.Gotham,12,false CC(qtyBox,8)qtyBox.FocusLost:Connect(function()local n=tonumber(qtyBox.Text)if not n or n<1 then n=1 qtyBox.Text="1"end _G.RAY.MerchantBuyQty=math.min(n,99)end)buyBtn=Instance.new("TextButton",QuantityRow)buyBtn.Size,buyBtn.Position,buyBtn.BackgroundColor3,buyBtn.TextColor3,buyBtn.Font,buyBtn.TextSize,buyBtn.Text=UDim2.new(0,80,0,24),UDim2.new(1,-90,0.5,-12),Color3.fromRGB(40,100,40),Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12,"BUY"CC(buyBtn,8)buyBtn.MouseButton1Click:Connect(function()if not _G.RAY.SelectedMerchantItem then if NotifyFeature then NotifyFeature("No item selected!",false)end return end BMI(_G.RAY.SelectedMerchantItem.Id,_G.RAY.MerchantBuyQty or 1)if NotifyFeature then NotifyFeature("Buying ".._G.RAY.SelectedMerchantItem.Name.." x"..(_G.RAY.MerchantBuyQty or 1),true)end end)CSR(MerchantSection,"Merchant Stock Panel","Open",function()MerchantPanel.Visible=not MerchantPanel.Visible if MerchantPanel.Visible then RMP()end end)function RMP()for _,c in ipairs(MerchantScroll:GetChildren())do if c:IsA("Frame")then c:Destroy()end end local stock=GMS()if#stock==0 then MerchantStatus.Text,MerchantStatus.TextColor3="Not Available",Color3.fromRGB(255,100,100)local er=Instance.new("Frame",MerchantScroll)er.Size,er.BackgroundTransparency=UDim2.new(1,-4,0,60),1 CL(er,{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,5,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Center,TextColor3=Color3.fromRGB(150,150,150),Text="No merchant stock available.\nCheck back later!"})_G.RAY.SelectedMerchantItem,SelectedItemLabel.Text,SelectedItemLabel.TextColor3=nil,"None",Color3.fromRGB(150,150,150)return end MerchantStatus.Text,MerchantStatus.TextColor3=#stock.." Items",Color3.fromRGB(0,255,140)for _,it in ipairs(stock)do local r=Instance.new("Frame",MerchantScroll)r.Size,r.BackgroundTransparency,r.ZIndex=UDim2.new(1,-4,0,40),1,11 local l=Instance.new("Frame",r)l.Name,l.Size,l.Position,l.BackgroundColor3,l.BorderSizePixel,l.Visible,l.ZIndex="Highlight",UDim2.new(0,3,1,0),UDim2.new(0,0,0,0),THEME.MAIN,0,(_G.RAY.SelectedMerchantItem and _G.RAY.SelectedMerchantItem.Id==it.Id),12 local b=Instance.new("TextButton",r)local priceText=FN(it.Price)b.Size,b.Position,b.BackgroundColor3,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment,b.TextYAlignment,b.Text,b.ZIndex=UDim2.new(1,-6,1,0),UDim2.new(0,6,0,0),Color3.fromRGB(30,30,50),THEME.TEXT,Enum.Font.Gotham,11,Enum.TextXAlignment.Left,Enum.TextYAlignment.Top,string.format("  %s\n  %s %s",it.Name,priceText,it.Currency),11 CC(b,6)if it.Currency:lower():find("robux")or it.Currency:lower():find("premium")then b.TextColor3=Color3.fromRGB(255,200,100)end b.MouseButton1Click:Connect(function()_G.RAY.SelectedMerchantItem=it SelectedItemLabel.Text,SelectedItemLabel.TextColor3=it.Name,Color3.fromRGB(0,255,140)for _,c in ipairs(MerchantScroll:GetChildren())do if c:IsA("Frame")then local h=c:FindFirstChild("Highlight")if h then h.Visible=(c==r)end end end if NotifyFeature then NotifyFeature("Selected: "..it.Name.." ("..priceText.." "..it.Currency..")",true)end end)end end RMP()MerchantReplion:OnChange("Items",function()if MerchantPanel.Visible then RMP()end local stock=GMS()if#stock>0 then MerchantStatus.Text,MerchantStatus.TextColor3=#stock.." Items",Color3.fromRGB(0,255,140)else MerchantStatus.Text,MerchantStatus.TextColor3,_G.RAY.SelectedMerchantItem,SelectedItemLabel.Text,SelectedItemLabel.TextColor3="Not Available",Color3.fromRGB(255,100,100),nil,"None",Color3.fromRGB(150,150,150)end end)table.insert(AllPanels,MerchantPanel)

--==================================================
-- WEATHER PRESET SECTION - PANEL KANAN + AUTO BUY TOGGLE
--==================================================
WeatherSection=CreateSectionDropdown(ShopPage,"Weather Preset")Instance.new("UIListLayout",WeatherSection).SortOrder=Enum.SortOrder.LayoutOrder WeatherSection.UIListLayout.Padding=UDim.new(0,6)

-- Weather data
WeatherList={"Sunny","Rain","Thunderstorm","Foggy","Acid Rain","Snow","Blizzard","Sandstorm","Hurricane","Meteor Shower","Solar Eclipse","Blood Moon","Starfall","Void Storm","Aurora","Rainbow","Cherry Blossom","Halloween","Christmas"}

-- Initialize selected table
_G.RAY.WeatherPreset.Selected={}
for _,w in ipairs(WeatherList)do _G.RAY.WeatherPreset.Selected[w]=false end

-- Panel kanan untuk list weather
WeatherPanel,WeatherScroll=CTP("Weather Preset","Select weather to auto purchase")
table.insert(AllPanels,WeatherPanel)

-- Status row
WeatherStatusRow=Instance.new("Frame",WeatherSection)WeatherStatusRow.Size,WeatherStatusRow.BackgroundTransparency=UDim2.new(1,0,0,30),1
CL(WeatherStatusRow,{Size=UDim2.new(0.5,-10,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Status:"})
WeatherStatusLabel=CL(WeatherStatusRow,{Size=UDim2.new(0.5,-10,1,0),Position=UDim2.new(0.5,0,0,0),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.fromRGB(150,150,150),Text="Ready"})

-- Toggle Auto Buy row (sama seperti toggle lainnya)
WeatherAutoBuyRow=Instance.new("Frame",WeatherSection)WeatherAutoBuyRow.Size,WeatherAutoBuyRow.BackgroundTransparency=UDim2.new(1,0,0,36),1
CL(WeatherAutoBuyRow,{Size=UDim2.new(1,-70,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=THEME.TEXT,Text="Auto Buy Weather"})
WeatherAutoBuyToggle,SetWeatherAutoBuy=CTPi(WeatherAutoBuyRow,_G.RAY.WeatherPreset.AutoBuy,function(s)_G.RAY.WeatherPreset.AutoBuy=s if NotifyFeature then NotifyFeature("Weather Auto Buy: "..(s and"ON"or"OFF"),s)end end)

-- Open panel button
CSR(WeatherSection,"Weather Preset Panel","Open",function()WeatherPanel.Visible=not WeatherPanel.Visible end)

-- Create weather entries dengan garis ungu saat dipilih
function CreateWeatherEntry(name)
    local r=Instance.new("Frame",WeatherScroll)
    r.Size,r.BackgroundTransparency,r.ZIndex=UDim2.new(1,-4,0,28),1,11
    
    -- Garis ungu di kiri (highlight)
    local hl=Instance.new("Frame",r)
    hl.Name,hl.Size,hl.Position,hl.BackgroundColor3,hl.BorderSizePixel,hl.Visible,hl.ZIndex="Highlight",UDim2.new(0,3,1,0),UDim2.new(0,0,0,0),THEME.MAIN,0,false,12
    
    local b=Instance.new("TextButton",r)
    b.Size,b.Position,b.BackgroundColor3,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment,b.Text,b.ZIndex=UDim2.new(1,-6,1,0),UDim2.new(0,6,0,0),Color3.fromRGB(30,30,50),THEME.TEXT,Enum.Font.Gotham,12,Enum.TextXAlignment.Left,"  "..name,11
    CC(b,6)
    
    -- Update visual berdasarkan selected state
    local function updateVisual()
        if _G.RAY.WeatherPreset.Selected[name]then
            hl.Visible=true
            b.BackgroundColor3=Color3.fromRGB(40,70,40)
            b.TextColor3=Color3.fromRGB(0,255,140)
        else
            hl.Visible=false
            b.BackgroundColor3=Color3.fromRGB(30,30,50)
            b.TextColor3=THEME.TEXT
        end
    end
    
    updateVisual()
    
    b.MouseButton1Click:Connect(function()
        _G.RAY.WeatherPreset.Selected[name]=not _G.RAY.WeatherPreset.Selected[name]
        updateVisual()
        
        -- Update status label dengan jumlah terpilih
        local c=0
        for _,on in pairs(_G.RAY.WeatherPreset.Selected)do if on then c=c+1 end end
        WeatherStatusLabel.Text=c.." selected"
        WeatherStatusLabel.TextColor3=c>0 and Color3.fromRGB(0,255,140)or Color3.fromRGB(150,150,150)
        
        if NotifyFeature then NotifyFeature(((_G.RAY.WeatherPreset.Selected[name])and"Selected"or"Deselected")..": "..name,true)end
    end)
    
    return r
end

-- Populate weather list
for _,name in ipairs(WeatherList)do CreateWeatherEntry(name)end

-- Auto buy loop dengan 0.1 detik wait (spam cepat)
task.spawn(function()
    while true do
        task.wait(0.1) -- Spam cepat 0.1 detik
        
        if not _G.RAY.WeatherPreset.AutoBuy then
            WeatherStatusLabel.Text="Auto Buy: OFF"
            WeatherStatusLabel.TextColor3=Color3.fromRGB(150,150,150)
            continue
        end
        
        local c=0
        for _,on in pairs(_G.RAY.WeatherPreset.Selected)do if on then c=c+1 end end
        
        if c==0 then
            WeatherStatusLabel.Text="No weather selected"
            WeatherStatusLabel.TextColor3=Color3.fromRGB(255,200,100)
            continue
        end
        
        WeatherStatusLabel.Text="Auto Buying "..c.." weather..."
        WeatherStatusLabel.TextColor3=Color3.fromRGB(0,255,140)
        
        -- Purchase loop
        for name,on in pairs(_G.RAY.WeatherPreset.Selected)do
            if on then
                pcall(function()
                    local RS=game:GetService("ReplicatedStorage")
                    local rf=RS:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net"):WaitForChild("RF/PurchaseWeatherEvent")
                    rf:InvokeServer(name)
                end)
            end
        end
    end
end)

-- Tambah WeatherSection ke close detection
table.insert(AllPanels,WeatherPanel)
