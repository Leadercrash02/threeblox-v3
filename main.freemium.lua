--==================================================
-- SERVICES & PLAYER
--==================================================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer

--==================================================
-- THEME
--==================================================
local THEME_MAIN = Color3.fromRGB(160, 90, 255)
local THEME_TEXT = Color3.fromRGB(235, 220, 255)
local GLASS = Color3.fromRGB(0, 0, 0)
local LOGO_ID = "rbxassetid://121625492591707"

-- palette untuk section2 baru
local MUTED      = Color3.fromRGB(70, 70, 80)
local CARD       = Color3.fromRGB(25, 25, 35)
local ACCENT     = Color3.fromRGB(140, 101, 255)

--==================================================
-- SCREEN GUI + MAIN UI
--==================================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "ThreebloxHUB"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local Loading = Instance.new("Frame", Gui)
Loading.Size = UDim2.new(1,0,1,0)
Loading.BackgroundColor3 = GLASS
Loading.BackgroundTransparency = 0.35

local LoadText = Instance.new("TextLabel", Loading)
LoadText.Size = UDim2.new(1,0,1,0)
LoadText.BackgroundTransparency = 1
LoadText.Text = "Loading ThreebloxHUB..."
LoadText.Font = Enum.Font.GothamBold
LoadText.TextSize = 18
LoadText.TextColor3 = THEME_MAIN

task.wait(1)
Loading:Destroy()

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,460,0,280)
Main.Position = UDim2.new(0.5,-230,0.5,-140)
Main.BackgroundColor3 = GLASS
Main.BackgroundTransparency = 0.45
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = THEME_MAIN
MainStroke.Transparency = 0.45

local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1,0,0,36)
TitleBar.BackgroundColor3 = GLASS
TitleBar.BackgroundTransparency = 0.4
TitleBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1,-100,1,0)
Title.Position = UDim2.new(0,12,0,0)
Title.BackgroundTransparency = 1
Title.Text = "ThreebloxHUB | discord.gg/Threebloxhub"
Title.Font = Enum.Font.GothamMedium
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = THEME_MAIN

local Min = Instance.new("TextButton", TitleBar)
Min.Size = UDim2.new(0,28,0,28)
Min.AnchorPoint = Vector2.new(0.5,0.5)
Min.Position = UDim2.new(1,-56,0.5,0)
Min.Text = "–"
Min.Font = Enum.Font.GothamBold
Min.TextSize = 20
Min.TextYAlignment = Enum.TextYAlignment.Center
Min.TextColor3 = THEME_TEXT
Min.BackgroundTransparency = 1

local Close = Instance.new("TextButton", TitleBar)
Close.Size = UDim2.new(0,28,0,28)
Close.AnchorPoint = Vector2.new(0.5,0.5)
Close.Position = UDim2.new(1,-28,0.5,0)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Close.TextColor3 = Color3.fromRGB(255,120,180)
Close.BackgroundTransparency = 1

local Sidebar = Instance.new("Frame", Main)
Sidebar.Position = UDim2.new(0, 6, 0, 40)
Sidebar.Size = UDim2.new(0, 120, 1, -46)
Sidebar.BackgroundColor3 = GLASS
Sidebar.BackgroundTransparency = 0.6
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,10)
local SideStroke = Instance.new("UIStroke", Sidebar)
SideStroke.Color = THEME_MAIN
SideStroke.Transparency = 0.7

local SideScroll = Instance.new("ScrollingFrame", Sidebar)
SideScroll.Size = UDim2.new(1, -4, 1, -4)
SideScroll.Position = UDim2.new(0, 2, 0, 2)
SideScroll.BackgroundTransparency = 1
SideScroll.BorderSizePixel = 0
SideScroll.ScrollBarThickness = 3
SideScroll.CanvasSize = UDim2.new(0,0,0,0)
SideScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SideScroll.ScrollBarImageColor3 = THEME_MAIN

local SideList = Instance.new("UIListLayout", SideScroll)
SideList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideList.VerticalAlignment = Enum.VerticalAlignment.Top
SideList.SortOrder = Enum.SortOrder.LayoutOrder
SideList.Padding = UDim.new(0, 4)

local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 130, 0, 40)
Content.Size = UDim2.new(1, -140, 1, -50)
Content.BackgroundColor3 = GLASS
Content.BackgroundTransparency = 0.65
Content.BorderSizePixel = 0
Instance.new("UICorner", Content).CornerRadius = UDim.new(0,10)
local ContentStroke = Instance.new("UIStroke", Content)
ContentStroke.Color = THEME_MAIN
ContentStroke.Transparency = 0.6

-- drag main
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
            local d = i.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
    UIS.InputEnded:Connect(function()
        dragging = false
    end)
end

-- minimize
local MiniLogo = Instance.new("ImageButton", Gui)
MiniLogo.Size = UDim2.new(0,52,0,52)
MiniLogo.Position = UDim2.new(0,20,0.5,-26)
MiniLogo.Image = LOGO_ID
MiniLogo.BackgroundTransparency = 1
MiniLogo.Visible = false
MiniLogo.AutoButtonColor = false

do
    local draggingLogo = false
    local dragStartLogo
    local logoStart
    local moved = false

    MiniLogo.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            draggingLogo = true
            moved = false
            dragStartLogo = i.Position
            logoStart = MiniLogo.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if draggingLogo then
            local d = i.Position - dragStartLogo
            if math.abs(d.X) > 5 or math.abs(d.Y) > 5 then
                moved = true
            end
            MiniLogo.Position = UDim2.new(
                logoStart.X.Scale, logoStart.X.Offset + d.X,
                logoStart.Y.Scale, logoStart.Y.Offset + d.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function()
        if draggingLogo then
            draggingLogo = false
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

Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

-- notify
local Notify = Instance.new("Frame", Gui)
Notify.Size = UDim2.new(0,280,0,60)
Notify.Position = UDim2.new(1,-300,1,-80)
Notify.BackgroundColor3 = GLASS
Notify.BackgroundTransparency = 0.35
Notify.BorderSizePixel = 0
Instance.new("UICorner", Notify).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke", Notify).Color = THEME_MAIN

local NLogo = Instance.new("ImageLabel", Notify)
NLogo.Size = UDim2.new(0,36,0,36)
NLogo.Position = UDim2.new(0,12,0.5,-18)
NLogo.BackgroundTransparency = 1
NLogo.Image = LOGO_ID

local NText = Instance.new("TextLabel", Notify)
NText.Size = UDim2.new(1,-60,1,0)
NText.Position = UDim2.new(0,56,0,0)
NText.BackgroundTransparency = 1
NText.Text = "Script Loaded Successfully"
NText.Font = Enum.Font.GothamBold
NText.TextSize = 14
NText.TextXAlignment = Enum.TextXAlignment.Left
NText.TextColor3 = THEME_MAIN

task.delay(2.5, function()
    if Notify then Notify:Destroy() end
end)

----------------------------------------------------------------
-- MODULES & NET
----------------------------------------------------------------
local Items   = require(ReplicatedStorage.Items)
local Replion = require(ReplicatedStorage.Packages.Replion)

local Net = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")

local Events = {
    catch   = Net:WaitForChild("RF/CatchFishCompleted"),
    sell    = Net:WaitForChild("RF/SellAllItems"),
    charge  = Net:WaitForChild("RF/ChargeFishingRod"),
    minigame= Net:WaitForChild("RF/RequestFishingMinigameStarted"),
    cancel  = Net:WaitForChild("RF/CancelFishingInputs"),
    equip   = Net:WaitForChild("RE/EquipToolFromHotbar"),
    unequip = Net:WaitForChild("RE/UnequipToolFromHotbar"),

    purchaseWeather     = Net:WaitForChild("RF/PurchaseWeatherEvent"),
    purchaseRod         = Net:WaitForChild("RF/PurchaseFishingRod"),
    purchaseBait        = Net:WaitForChild("RF/PurchaseBait"),
    updateSellThreshold = Net:WaitForChild("RF/UpdateAutoSellThreshold"),
    UpdateAutoFishing   = Net:WaitForChild("RF/UpdateAutoFishingState"),
}

----------------------------------------------------------------
-- ENGINE STATE
----------------------------------------------------------------
local AutoFishAFK    = _G.RAY_AutoFishAFK or false
_G.RAY_AutoFishAFK   = AutoFishAFK

local LegitPerfectOn = _G.RAY_LegitPerfect or false
_G.RAY_LegitPerfect  = LegitPerfectOn

local isFishingAFK   = false
local isFishingLegit = false

-- AFK mode
local DelayReel  = _G.RAY_DelayReel  or 0.3
local DelayCatch = _G.RAY_DelayCatch or 0.3

----------------------------------------------------------------
-- FUNGSI DASAR CAST / COMPLETE
----------------------------------------------------------------
local function Complete_V3()
    pcall(function()
        if not Events or not Events.catch then
            warn("[RAY] Events.catch nil")
            return
        end
        Events.catch:InvokeServer()
    end)
end

local function Cast_V3_Base()
    pcall(function()
        if not Events or not Events.minigame or not Events.charge then
            warn("[RAY] Events.minigame / Events.charge nil")
            return
        end

        -- Equip rod di slot 1
        if Events.equip then
            Events.equip:FireServer(1)
        else
            warn("[RAY] Events.equip nil")
        end



        -- 1) Charge rod (tanpa argumen)
        Events.charge:InvokeServer()

        -- 2) Start minigame (power, factor, serverTime)
        local serverTime = Workspace:GetServerTimeNow()

        local basePower  = 3.376763343811035
        local baseFactor = 0.623453255714559

        Events.minigame:InvokeServer(basePower, baseFactor, serverTime)
    end)
end

----------------------------------------------------------------
-- ENGINE: AUTO FISH FEEL V2 (AFK SAJA)
----------------------------------------------------------------
local function Engine_V3_Delayed()
    if isFishingAFK or not AutoFishAFK then return end
    isFishingAFK = true

    Cast_V3_Base()
    task.wait(DelayReel)

    Complete_V3()
    task.wait(DelayCatch)

    isFishingAFK = false
end

----------------------------------------------------------------
-- ENGINE: LEGIT PERFECT V1
----------------------------------------------------------------
-- delay khusus legit (boleh sama dengan AFK, boleh beda)
local LegitDelayReel  = _G.RAY_LegitDelayReel  or 0.25
local LegitDelayCatch = _G.RAY_LegitDelayCatch or 0.25

local function Cast_V3_LegitPerfect()
    pcall(function()
        if not Events or not Events.minigame or not Events.charge then
            return
        end

        -- Equip rod di slot 1
        if Events.equip then
            Events.equip:FireServer(1)
        end

        -- charge
        Events.charge:InvokeServer()

        local serverTime = Workspace:GetServerTimeNow()

        local basePower  = 3.376763343811035
        local baseFactor = 0.623453255714559

        -- versi awal: full PERFECT
        local power  = basePower
        local factor = baseFactor

        -- nanti kalau mau 98%, tinggal tambah jitter kecil di sini

        Events.minigame:InvokeServer(power, factor, serverTime)
    end)
end

local function Engine_LegitPerfect()
    if isFishingLegit or not LegitPerfectOn then return end
    isFishingLegit = true

    Cast_V3_LegitPerfect()
    task.wait(LegitDelayReel)

    Complete_V3()
    task.wait(LegitDelayCatch)

    isFishingLegit = false
end

----------------------------------------------------------------
-- LOOP UTAMA ENGINE
----------------------------------------------------------------
task.spawn(function()
    while true do
        task.wait(0.05)

        if LegitPerfectOn then
            -- kalau Legit ON, AFK diabaikan
            Engine_LegitPerfect()
        else
            -- kalau Legit OFF, baru AFK yang jalan (kalau flag-nya true)
            Engine_V3_Delayed()
        end
    end
end)



----------------------------------------------------------------
-- PAGE SYSTEM (SIDEBAR + CONTENT + INFORMATION PAGE)
----------------------------------------------------------------
local PAGE_CONFIG = {
    {Name = "About",        Icon = "rbxassetid://89633575267800"},
    {Name = "Fishing",     Icon = "rbxassetid://12644442470"}, -- backpack / tas putih pun bisa jadi “peralatan fishing”
    {Name = "Backpack",    Icon = "rbxassetid://6870729295"},
    {Name = "Teleport",    Icon = "rbxassetid://6031075931"},
    {Name = "Quest",       Icon = "rbxassetid://14228191542"},
    {Name = "Shop",        Icon = "rbxassetid://6031265976"},
    {Name = "Misc",        Icon = "rbxassetid://6034509993"},
}


local Pages = {}
local CurrentHighlightHolder

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Parent = Content
    Page.Size = UDim2.new(1, -12, 1, -12)
    Page.Position = UDim2.new(0, 6, 0, 6)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 4
    Page.ScrollBarImageColor3 = THEME_MAIN
    Page.CanvasSize = UDim2.new(0,0,0,0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false

    local layout = Instance.new("UIListLayout", Page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)

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

local function CreateSideButton(conf)
    local Holder = Instance.new("Frame")
    Holder.Parent = SideScroll
    Holder.Size = UDim2.new(1, -4, 0, 34)
    Holder.BackgroundTransparency = 1
    Holder.BorderSizePixel = 0

    local Highlight = Instance.new("Frame")
    Highlight.Name = "Highlight"
    Highlight.Parent = Holder
    Highlight.Size = UDim2.new(0, 3, 1, -6)
    Highlight.Position = UDim2.new(0, 0, 0, 3)
    Highlight.BackgroundColor3 = THEME_MAIN
    Highlight.BackgroundTransparency = 1
    Highlight.BorderSizePixel = 0

    local Btn = Instance.new("TextButton")
    Btn.Parent = Holder
    Btn.Size = UDim2.new(1, -4, 1, 0)
    Btn.Position = UDim2.new(0, 4, 0, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Btn.BackgroundTransparency = 0.05
    Btn.BorderSizePixel = 0
    Btn.AutoButtonColor = false
    Btn.Text = ""

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local Icon = Instance.new("ImageLabel")
    Icon.Parent = Btn
    Icon.Size = UDim2.new(0, 18, 0, 18)
    Icon.Position = UDim2.new(0, 6, 0.5, -9)
    Icon.BackgroundTransparency = 1
    Icon.Image = conf.Icon
    Icon.ImageColor3 = Color3.fromRGB(255,255,255)

    local Sep = Instance.new("Frame")
    Sep.Parent = Btn
    Sep.Size = UDim2.new(0, 1, 0.6, 0)
    Sep.Position = UDim2.new(0, 28, 0.2, 0)
    Sep.BackgroundColor3 = Color3.fromRGB(200,200,200)
    Sep.BackgroundTransparency = 0.2
    Sep.BorderSizePixel = 0

    local Label = Instance.new("TextLabel")
    Label.Parent = Btn
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Position = UDim2.new(0, 34, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.Text = conf.Name

    Btn.MouseEnter:Connect(function()
        Btn.BackgroundTransparency = 0
    end)
    Btn.MouseLeave:Connect(function()
        Btn.BackgroundTransparency = 0.05
    end)

    return Holder, Btn
end

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
-- INFORMATION PAGE CONTENT
--==================================================

local InfoPage = Pages["About"]
if InfoPage then
    -- CARD UTAMA
    local Card = Instance.new("Frame")
    Card.Parent = InfoPage
    Card.Size = UDim2.new(1, 0, 0, 90)
    Card.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    Card.BackgroundTransparency = 0.45 -- glassy
    Card.BorderSizePixel = 0

    local cardCorner = Instance.new("UICorner", Card)
    cardCorner.CornerRadius = UDim.new(0, 10)

    local cardStroke = Instance.new("UIStroke", Card)
    cardStroke.Color = THEME_MAIN
    cardStroke.Transparency = 0.8

    -- TITLE
    local TitleInfo = Instance.new("TextLabel")
    TitleInfo.Parent = Card
    TitleInfo.Size = UDim2.new(1, -20, 0, 22)
    TitleInfo.Position = UDim2.new(0, 10, 0, 8)
    TitleInfo.BackgroundTransparency = 1
    TitleInfo.Font = Enum.Font.GothamBold
    TitleInfo.TextSize = 16
    TitleInfo.TextXAlignment = Enum.TextXAlignment.Left
    TitleInfo.TextColor3 = THEME_TEXT
    TitleInfo.Text = "ThreebloxHUB - About"

    -- LINE KECIL DI BAWAH TITLE
    local Line = Instance.new("Frame")
    Line.Parent = Card
    Line.Size = UDim2.new(0, 60, 0, 1)
    Line.Position = UDim2.new(0, 10, 0, 30)
    Line.BackgroundColor3 = THEME_MAIN
    Line.BackgroundTransparency = 0.3
    Line.BorderSizePixel = 0

    -- DESKRIPSI
    local Desc = Instance.new("TextLabel")
    Desc.Parent = Card
    Desc.Size = UDim2.new(1, -20, 0, 36)
    Desc.Position = UDim2.new(0, 10, 0, 36)
    Desc.BackgroundTransparency = 1
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 12
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextYAlignment = Enum.TextYAlignment.Top
    Desc.TextColor3 = Color3.fromRGB(230,230,255)
    Desc.TextWrapped = true
    Desc.Text = "Universal UI for ThreebloxHUB."

    -- INFO KECIL DI KANAN (VERSI + AUTHOR)
    local SmallInfo = Instance.new("TextLabel")
    SmallInfo.Parent = Card
    SmallInfo.Size = UDim2.new(0, 140, 0, 32)
    SmallInfo.Position = UDim2.new(1, -150, 0, 8)
    SmallInfo.BackgroundTransparency = 1
    SmallInfo.Font = Enum.Font.Gotham
    SmallInfo.TextSize = 11
    SmallInfo.TextXAlignment = Enum.TextXAlignment.Right
    SmallInfo.TextYAlignment = Enum.TextYAlignment.Top
    SmallInfo.TextColor3 = Color3.fromRGB(220,220,245)
    SmallInfo.TextWrapped = true
    SmallInfo.Text = "Made by: Threeblox"

    -- TOMBOL JOIN DISCORD (OPEN URL + COPY)
    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Parent = Card
    CopyBtn.Size = UDim2.new(0, 120, 0, 24)
    CopyBtn.Position = UDim2.new(0, 10, 1, -30)
    CopyBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    CopyBtn.BackgroundTransparency = 0.3
    CopyBtn.BorderSizePixel = 0
    CopyBtn.AutoButtonColor = true
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.TextSize = 12
    CopyBtn.TextColor3 = THEME_TEXT
    CopyBtn.Text = "Join Discord"

    local copyCorner = Instance.new("UICorner", CopyBtn)
    copyCorner.CornerRadius = UDim.new(0, 6)

    local copyStroke = Instance.new("UIStroke", CopyBtn)
    copyStroke.Color = THEME_MAIN
    copyStroke.Transparency = 0.5

    CopyBtn.MouseButton1Click:Connect(function()
        local url = "https://discord.gg/Threebloxhub"

        -- Coba buka browser dulu
        local ok = false
        if syn and syn.openurl then
            ok = pcall(function() syn.openurl(url) end)
        elseif openurl then
            ok = pcall(function() openurl(url) end)
        end

        -- Fallback: copy ke clipboard
        if setclipboard then
            setclipboard(url)
        end

        if ok then
            NText.Text = "Opening Discord invite..."
        else
            NText.Text = "Discord link copied to clipboard"
        end
        Notify.Visible = true
        task.delay(1.5, function()
            if Notify then
                Notify.Visible = false
            end
        end)
    end)

    -- TOMBOL COPY LINK DISCORD SAJA
    local CopyLinkBtn = Instance.new("TextButton")
    CopyLinkBtn.Parent = Card
    CopyLinkBtn.Size = UDim2.new(0, 120, 0, 24)
    CopyLinkBtn.Position = UDim2.new(0, 140, 1, -30) -- di kanan Join Discord
    CopyLinkBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    CopyLinkBtn.BackgroundTransparency = 0.3
    CopyLinkBtn.BorderSizePixel = 0
    CopyLinkBtn.AutoButtonColor = true
    CopyLinkBtn.Font = Enum.Font.GothamBold
    CopyLinkBtn.TextSize = 11
    CopyLinkBtn.TextColor3 = THEME_TEXT
    CopyLinkBtn.Text = "Copy Discord Link"

    local copyLinkCorner = Instance.new("UICorner", CopyLinkBtn)
    copyLinkCorner.CornerRadius = UDim.new(0, 6)

    local copyLinkStroke = Instance.new("UIStroke", CopyLinkBtn)
    copyLinkStroke.Color = THEME_MAIN
    copyLinkStroke.Transparency = 0.5

    CopyLinkBtn.MouseButton1Click:Connect(function()
        local url = "https://discord.gg/Threebloxhub"
        if setclipboard then
            setclipboard(url)
        end
        NText.Text = "Discord link copied!"
        Notify.Visible = true
        task.delay(1.5, function()
            if Notify then
                Notify.Visible = false
            end
        end)
    end)

    -- CHANGELOG SIMPLE (TANPA FRAME)
    local ChangeTitle = Instance.new("TextLabel")
    ChangeTitle.Parent = InfoPage
    ChangeTitle.Size = UDim2.new(1, -20, 0, 18)
    ChangeTitle.BackgroundTransparency = 1
    ChangeTitle.Font = Enum.Font.GothamBold
    ChangeTitle.TextSize = 13
    ChangeTitle.TextXAlignment = Enum.TextXAlignment.Left
    ChangeTitle.TextColor3 = Color3.fromRGB(255,255,255)
    ChangeTitle.Text = "Changelog"
    ChangeTitle.LayoutOrder = 10

    local function AddChangeLine(text)
        local LineText = Instance.new("TextLabel")
        LineText.Parent = InfoPage
        LineText.Size = UDim2.new(1, -24, 0, 16)
        LineText.BackgroundTransparency = 1
        LineText.Font = Enum.Font.GothamBold
        LineText.TextSize = 11
        LineText.TextXAlignment = Enum.TextXAlignment.Left
        LineText.TextColor3 = Color3.fromRGB(255,255,255)
        LineText.Text = text
        LineText.LayoutOrder = 11
        return LineText
    end

    AddChangeLine("(+) Added New GUI layout")
    AddChangeLine("(+) Added New GUI layout")

end

----------------------------------------------------------------
-- HELPER: TOGGLE PILL
----------------------------------------------------------------
local function CreateTogglePill(parent, labelText, default)
    local row = Instance.new("Frame")
    row.Parent = parent
    row.Size = UDim2.new(1,0,0,36)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel")
    label.Parent = row
    label.Size = UDim2.new(1,-100,1,0)
    label.Position = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = TEXT or THEME_TEXT
    label.Text = labelText

    local pill = Instance.new("TextButton")
    pill.Parent = row
    pill.Size = UDim2.new(0,50,0,24)
    pill.Position = UDim2.new(1,-80,0.5,-12)
    pill.BackgroundColor3 = MUTED or Color3.fromRGB(70,70,90)
    pill.BackgroundTransparency = 0.1
    pill.Text = ""
    pill.AutoButtonColor = false
    Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

    local knob = Instance.new("Frame")
    knob.Parent = pill
    knob.Size = UDim2.new(0,18,0,18)
    knob.Position = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BackgroundTransparency = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local state = default and true or false

    local function refresh()
        pill.BackgroundColor3 = state and (ACCENT or THEME_MAIN) or (MUTED or Color3.fromRGB(70,70,90))
        knob.Position = state and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
    end
    refresh()

    pill.MouseButton1Click:Connect(function()
        state = not state
        refresh()
    end)

    return function()
        return state
    end, function(v)
        state = v and true or false
        refresh()
    end
end


----------------------------------------------------------------
-- HELPER: SECTION DROPDOWN
----------------------------------------------------------------
local function CreateSectionDropdown(parent, titleText)
    local Holder = Instance.new("Frame")
    Holder.Parent = parent
    Holder.Size = UDim2.new(1, -10, 0, 30)
    Holder.BackgroundTransparency = 1
    Holder.BorderSizePixel = 0

    local Header = Instance.new("TextButton")
    Header.Parent = Holder
    Header.Size = UDim2.new(1, 0, 0, 30)
    Header.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    Header.BackgroundTransparency = 0.4
    Header.BorderSizePixel = 0
    Header.AutoButtonColor = false
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 14
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.TextColor3 = THEME_TEXT
    Header.Text = "  " .. titleText

    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

    local Arrow = Instance.new("TextLabel")
    Arrow.Parent = Header
    Arrow.Size = UDim2.new(0, 20, 0, 20)
    Arrow.Position = UDim2.new(1, -24, 0.5, -10)
    Arrow.BackgroundTransparency = 1
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 14
    Arrow.TextColor3 = THEME_TEXT
    Arrow.Text = "▼"

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Parent = parent
    ContentFrame.Size = UDim2.new(1, -10, 0, 0)
    ContentFrame.Position = UDim2.new(0, 5, 0, 40)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0

    local layout = Instance.new("UIListLayout", ContentFrame)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)

    local opened = false

    local function refresh()
        Arrow.Text = opened and "▲" or "▼"
        ContentFrame.Visible = opened

        if opened then
            local total = 0
            for _, child in ipairs(ContentFrame:GetChildren()) do
                if child:IsA("GuiObject") then
                    total += child.AbsoluteSize.Y + 6
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

--------------------------
--- KHUSUS Fishing Page ---
--------------------------

----------------------------------------------------------------
-- Fishing Page
----------------------------------------------------------------
local AutoPage = Pages["Fishing"]
if AutoPage then
    local layout = Instance.new("UIListLayout", AutoPage)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
end

----------------------------------------------------------------
-- FISHING MODE SECTION
----------------------------------------------------------------
local AutoFishSection
local getAFK, setAFK

if AutoPage then
    -- DROPDOWN "Instant Fishing"
    AutoFishSection = CreateSectionDropdown(AutoPage, "Instant Fishing")

    -- layout isi section
    local sectionLayout = Instance.new("UIListLayout", AutoFishSection)
    sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sectionLayout.Padding = UDim.new(0, 6)

    ------------------------------------------------------------
    -- GARIS UNGU FULL DI BAWAH TITLE
    ------------------------------------------------------------
    local Line = Instance.new("Frame")
    Line.Parent = AutoFishSection
    Line.Size = UDim2.new(1, 0, 0, 2)      -- full width
    Line.Position = UDim2.new(0, 0, 0, 2)
    Line.BackgroundColor3 = THEME_MAIN
    Line.BackgroundTransparency = 0
    Line.BorderSizePixel = 0

    ------------------------------------------------------------
    -- CARD KECIL 1: REEL DELAY
    ------------------------------------------------------------
    local ReelCard = Instance.new("Frame")
    ReelCard.Parent = AutoFishSection
    ReelCard.Size = UDim2.new(1, -4, 0, 32)
    ReelCard.BackgroundColor3 = Color3.fromRGB(25, 28, 35)
    ReelCard.BackgroundTransparency = 0.55
    ReelCard.BorderSizePixel = 0
    Instance.new("UICorner", ReelCard).CornerRadius = UDim.new(0, 8)

    local ReelStroke = Instance.new("UIStroke", ReelCard)
    ReelStroke.Color = THEME_MAIN
    ReelStroke.Transparency = 0.8

    local ReelLabel = Instance.new("TextLabel")
    ReelLabel.Parent = ReelCard
    ReelLabel.Size = UDim2.new(0.6, -20, 1, 0)
    ReelLabel.Position = UDim2.new(0, 14, 0, 0)
    ReelLabel.BackgroundTransparency = 1
    ReelLabel.Font = Enum.Font.Gotham
    ReelLabel.TextSize = 13
    ReelLabel.TextXAlignment = Enum.TextXAlignment.Left
    ReelLabel.TextColor3 = THEME_TEXT
    ReelLabel.Text = "Reel Delay (sec)"

    local ReelBox = Instance.new("TextBox")
    ReelBox.Parent = ReelCard
    ReelBox.Size = UDim2.new(0, 80, 0, 24)
    ReelBox.Position = UDim2.new(1, -94, 0.5, -12)
    ReelBox.Text = tostring(DelayReel)
    ReelBox.Font = Enum.Font.Gotham
    ReelBox.TextSize = 13
    ReelBox.TextXAlignment = Enum.TextXAlignment.Center
    ReelBox.TextColor3 = THEME_TEXT
    ReelBox.ClearTextOnFocus = false
    ReelBox.BackgroundColor3 = Color3.fromRGB(25,25,35)
    ReelBox.BackgroundTransparency = 0.3
    Instance.new("UICorner", ReelBox).CornerRadius = UDim.new(0,8)

    ReelBox.FocusLost:Connect(function()
        local n = tonumber(ReelBox.Text:match("[%d%.]+"))
        if n and n > 0 then
            DelayReel = n
            ReelBox.Text = tostring(n)
        else
            ReelBox.Text = tostring(DelayReel)
        end
    end)

    ------------------------------------------------------------
    -- CARD KECIL 2: CATCH DELAY
    ------------------------------------------------------------
    local CatchCard = Instance.new("Frame")
    CatchCard.Parent = AutoFishSection
    CatchCard.Size = UDim2.new(1, -4, 0, 32)
    CatchCard.BackgroundColor3 = Color3.fromRGB(25, 28, 35)
    CatchCard.BackgroundTransparency = 0.55
    CatchCard.BorderSizePixel = 0
    Instance.new("UICorner", CatchCard).CornerRadius = UDim.new(0, 8)

    local CatchStroke = Instance.new("UIStroke", CatchCard)
    CatchStroke.Color = THEME_MAIN
    CatchStroke.Transparency = 0.8

    local CatchLabel = Instance.new("TextLabel")
    CatchLabel.Parent = CatchCard
    CatchLabel.Size = UDim2.new(0.6, -20, 1, 0)
    CatchLabel.Position = UDim2.new(0, 14, 0, 0)
    CatchLabel.BackgroundTransparency = 1
    CatchLabel.Font = Enum.Font.Gotham
    CatchLabel.TextSize = 13
    CatchLabel.TextXAlignment = Enum.TextXAlignment.Left
    CatchLabel.TextColor3 = THEME_TEXT
    CatchLabel.Text = "Catch Delay (sec)"

    local CatchBox = Instance.new("TextBox")
    CatchBox.Parent = CatchCard
    CatchBox.Size = UDim2.new(0, 80, 0, 24)
    CatchBox.Position = UDim2.new(1, -94, 0.5, -12)
    CatchBox.Text = tostring(DelayCatch)
    CatchBox.Font = Enum.Font.Gotham
    CatchBox.TextSize = 13
    CatchBox.TextXAlignment = Enum.TextXAlignment.Center
    CatchBox.TextColor3 = THEME_TEXT
    CatchBox.ClearTextOnFocus = false
    CatchBox.BackgroundColor3 = Color3.fromRGB(25,25,35)
    CatchBox.BackgroundTransparency = 0.3
    Instance.new("UICorner", CatchBox).CornerRadius = UDim.new(0,8)

    CatchBox.FocusLost:Connect(function()
        local n = tonumber(CatchBox.Text:match("[%d%.]+"))
        if n and n > 0 then
            DelayCatch = n
            CatchBox.Text = tostring(DelayCatch)
        else
            CatchBox.Text = tostring(DelayCatch)
        end
    end)

    ------------------------------------------------------------
    -- CARD KECIL 3: ENABLE AUTO FISHING (INSTANT)
    ------------------------------------------------------------
    local ToggleCard = Instance.new("Frame")
    ToggleCard.Parent = AutoFishSection
    ToggleCard.Size = UDim2.new(1, -4, 0, 32)
    ToggleCard.BackgroundColor3 = Color3.fromRGB(25, 28, 35)
    ToggleCard.BackgroundTransparency = 0.55
    ToggleCard.BorderSizePixel = 0
    Instance.new("UICorner", ToggleCard).CornerRadius = UDim.new(0, 8)

    local ToggleStroke = Instance.new("UIStroke", ToggleCard)
    ToggleStroke.Color = THEME_MAIN
    ToggleStroke.Transparency = 0.8

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Parent = ToggleCard
    ToggleLabel.Size = UDim2.new(0.6, -20, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 14, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextSize = 13
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.TextColor3 = THEME_TEXT
    ToggleLabel.Text = "Enable Instant Auto Fishing"

    local pill = Instance.new("TextButton")
    pill.Parent = ToggleCard
    pill.Size = UDim2.new(0,50,0,24)
    pill.Position = UDim2.new(1,-60,0.5,-12)
    pill.BackgroundColor3 = Color3.fromRGB(40,40,55)
    pill.BackgroundTransparency = 0.2
    pill.Text = ""
    pill.AutoButtonColor = false
    Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

    local knob = Instance.new("Frame")
    knob.Parent = pill
    knob.Size = UDim2.new(0,18,0,18)
    knob.Position = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BackgroundTransparency = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local state = AutoFishAFK
    local function refresh()
        pill.BackgroundColor3 = state and THEME_MAIN or Color3.fromRGB(40,40,55)
        knob.Position = state and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
    end
    refresh()

    pill.MouseButton1Click:Connect(function()
        state = not state
        refresh()
    end)

    local function applyAFK()
        AutoFishAFK = state
        if NotifyFeature then
            NotifyFeature("Instant Fishing", state)
        end
    end

    applyAFK()

    task.spawn(function()
        local last = state
        while true do
            if state ~= last then
                last = state
                applyAFK()
            end
            task.wait(0.1)
        end
    end)
end

-----------------------------------------------------------------
--- ALL LOGIC VFX (DISABLE ROD SKIN, DLL)
----------------------------------------------------------------
local VFXHidden = {}
local VFXCacheFolder = Instance.new("Folder")
VFXCacheFolder.Name = "VFX_HIDDEN_CACHE"
VFXCacheFolder.Parent = ReplicatedStorage

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



local RunService = game:GetService("RunService")
local Stats      = game:GetService("Stats")


----------------------------------------------------------------
-- WATER WALK UTILS (PASIF) - LOGIC SEBENARNYA
----------------------------------------------------------------
local waterWalkOn   = false
local waterHb       = nil
local Surfaces      = {}
local lastCenter    = nil

local SIZE_XZ       = 350
local HEIGHT_OFFSET = 4
local STEP_DIST     = 220

local function ClearWaterSurfaces()
    for _, p in ipairs(Surfaces) do
        if p and p.Parent then
            p:Destroy()
        end
    end
    table.clear(Surfaces)
    lastCenter = nil
end

local function createWaterSurface(root)
    local pos = root.Position
    local part = Instance.new("Part")
    part.Name = "WaterWalkSurface"
    part.Size = Vector3.new(SIZE_XZ, 1, SIZE_XZ)
    part.Position = Vector3.new(pos.X, pos.Y - HEIGHT_OFFSET, pos.Z)
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
        if #Surfaces == 0 then return end
        if not root or not root.Parent or not lastCenter then return end

        local pos  = root.Position
        local dist = (Vector3.new(pos.X, 0, pos.Z)
                    - Vector3.new(lastCenter.X, 0, lastCenter.Z)).Magnitude
        if dist > STEP_DIST then
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

    if waterWalkOn then
        StartWaterWalk()
    else
        StopWaterWalk()
    end
end

-- Kalau karakter respawn dan masih ON, nyalikan lagi otomatis
Player.CharacterAdded:Connect(function()
    if waterWalkOn then
        task.wait(0.3)
        StartWaterWalk()
    end
end)


----------------------------------------------------------------
-- FISHING SUPPORT SECTION + UI WALK ON WATER
----------------------------------------------------------------
local FishingSupportSection

if AutoPage then
    -- DROPDOWN "Fishing Support"
    FishingSupportSection = CreateSectionDropdown(AutoPage, "Fishing Support")

    -- layout isi section
    local supportLayout = Instance.new("UIListLayout")
    supportLayout.Parent = FishingSupportSection
    supportLayout.SortOrder = Enum.SortOrder.LayoutOrder
    supportLayout.Padding = UDim.new(0, 6)

    ------------------------------------------------------------
    -- GARIS UNGU FULL DI BAWAH TITLE
    ------------------------------------------------------------
    local LineFS = Instance.new("Frame")
    LineFS.Parent = FishingSupportSection
    LineFS.Size = UDim2.new(1, 0, 0, 2)
    LineFS.Position = UDim2.new(0, 0, 0, 2)
    LineFS.BackgroundColor3 = THEME_MAIN
    LineFS.BackgroundTransparency = 0
    LineFS.BorderSizePixel = 0

    ----------------------------------------------------------------
    -- WALK ON WATER (PASIF) DI DALAM FISHING SUPPORT
    ----------------------------------------------------------------
    do
        local row = Instance.new("Frame")
        row.Parent = FishingSupportSection
        row.Size = UDim2.new(1,0,0,60)
        row.BackgroundTransparency = 1

        local label = Instance.new("TextLabel")
        label.Parent = row
        label.Size = UDim2.new(1,-110,0,20)
        label.Position = UDim2.new(0,16,0,0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextColor3 = TEXT or THEME_TEXT
        label.TextWrapped = true
        label.Text = "Walk On Water"

        local hint = Instance.new("TextLabel")
        hint.Parent = row
        hint.Size = UDim2.new(1,-110,0,30)
        hint.Position = UDim2.new(0,16,0,20)
        hint.BackgroundTransparency = 1
        hint.Font = Enum.Font.Gotham
        hint.TextSize = 11
        hint.TextXAlignment = Enum.TextXAlignment.Left
        hint.TextYAlignment = Enum.TextYAlignment.Top
        hint.TextColor3 = Color3.fromRGB(180,180,180)
        hint.TextWrapped = true
        hint.Text = "Aktifkan di dataran rendah supaya tinggi kaki pas di permukaan air."

        local pill = Instance.new("TextButton")
        pill.Parent = row
        pill.Size = UDim2.new(0,50,0,24)
        pill.Position = UDim2.new(1,-80,0.5,-12)
        pill.BackgroundColor3 = MUTED or Color3.fromRGB(70,70,90)
        pill.BackgroundTransparency = 0.1
        pill.Text = ""
        pill.AutoButtonColor = false
        Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

        local knob = Instance.new("Frame")
        knob.Parent = pill
        knob.Size = UDim2.new(0,18,0,18)
        knob.Position = UDim2.new(0,3,0.5,-9)
        knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
        knob.BackgroundTransparency = 0
        Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

        local function refresh()
            pill.BackgroundColor3 = waterWalkOn and THEME_MAIN or (MUTED or Color3.fromRGB(70,70,90))
            knob.Position = waterWalkOn
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        pill.MouseButton1Click:Connect(function()
            SetWaterWalk(not waterWalkOn)
            refresh()
            if NotifyFeature then
                NotifyFeature("Water Walk", waterWalkOn)
            end
        end)

        refresh()
    end
end

----------------------------------------------------------------
-- SETUP GLOBAL (GUI CONTROL & CAMERA GUARD)
----------------------------------------------------------------
local GuiControl = require(ReplicatedStorage.Modules.GuiControl)
local RunService = game:GetService("RunService")
local Stats      = game:GetService("Stats")

_G.__RAY_OldGuiControlClose = _G.__RAY_OldGuiControlClose or GuiControl.Close
_G.__RAY_OldGuiControlLock  = _G.__RAY_OldGuiControlLock  or GuiControl.Lock
_G.__RAY_OldGuiControlHUD   = _G.__RAY_OldGuiControlHUD   or GuiControl.SetHUDVisibility

local camConn

local function ForcePlayerCamera()
    local cam = Workspace.CurrentCamera
    if not cam or not Player.Character then return end

    local hum = Player.Character:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    cam.CameraType   = Enum.CameraType.Custom
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
    local noPause   = _G.RAY_NoCutscenePause

    if _G.__RAY_OldGuiControlClose then
        GuiControl.Close = _G.__RAY_OldGuiControlClose
    end
    if _G.__RAY_OldGuiControlLock then
        GuiControl.Lock = _G.__RAY_OldGuiControlLock
    end
    if _G.__RAY_OldGuiControlHUD then
        GuiControl.SetHUDVisibility = _G.__RAY_OldGuiControlHUD
    end

    StopCameraGuard()

    if disableAll then
        function GuiControl.Close(skipHud)
            return
        end
        function GuiControl.Lock()
            return
        end
        function GuiControl.SetHUDVisibility(flag)
            return
        end

        StartCameraGuard()

    elseif noPause then
        function GuiControl.Lock()
            return
        end
    end
end


-----------------------------------------------------------------
-- DISABLE CUTSCENE (SKIP VISUAL, MANCING LANJUT)
----------------------------------------------------------------
do
    local row = Instance.new("Frame")
    row.Parent = FishingSupportSection
    row.Size = UDim2.new(1,0,0,36)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel")
    label.Parent = row
    label.Size = UDim2.new(1,-100,1,0)
    label.Position = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = TEXT or THEME_TEXT or Color3.fromRGB(230,230,255)
    label.Text = "Disable All Cutscenes"

    local pill = Instance.new("TextButton")
    pill.Parent = row
    pill.Size = UDim2.new(0,50,0,24)
    pill.Position = UDim2.new(1,-80,0.5,-12)
    pill.BackgroundColor3 = MUTED or Color3.fromRGB(70,70,90)
    pill.BackgroundTransparency = 0.1
    pill.Text = ""
    pill.AutoButtonColor = false
    Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

    local knob = Instance.new("Frame")
    knob.Parent = pill
    knob.Size = UDim2.new(0,18,0,18)
    knob.Position = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BackgroundTransparency = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local enabled = _G.RAY_DisableCutscene or false

    local function refresh()
        pill.BackgroundColor3 = enabled
            and (THEME_MAIN or Color3.fromRGB(140,90,255))
            or  (MUTED or Color3.fromRGB(70,70,90))

        knob.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.RAY_DisableCutscene = enabled

        if enabled then
            _G.RAY_NoCutscenePause = false
        end

        ReapplyGuiPatches()
        refresh()

        if NotifyFeature then
            NotifyFeature("Disable Cutscene", enabled)
        end
    end)

    task.delay(1, function()
        if enabled then
            ReapplyGuiPatches()
        end
        refresh()
    end)

    refresh()
end

----------------------------------------------------------------
-- NO CUTSCENE PAUSE (CUTSCENE JALAN, MANCING TETAP LANJUT)
----------------------------------------------------------------
do
    local row = Instance.new("Frame")
    row.Parent = FishingSupportSection
    row.Size = UDim2.new(1,0,0,36)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel")
    label.Parent = row
    label.Size = UDim2.new(1,-120,1,0)
    label.Position = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = TEXT or THEME_TEXT or Color3.fromRGB(230,230,255)
    label.Text = "No Cutscene Pause (BETA)"

    local pill = Instance.new("TextButton")
    pill.Parent = row
    pill.Size = UDim2.new(0,50,0,24)
    pill.Position = UDim2.new(1,-80,0.5,-12)
    pill.BackgroundColor3 = MUTED or Color3.fromRGB(70,70,90)
    pill.BackgroundTransparency = 0.1
    pill.Text = ""
    pill.AutoButtonColor = false
    Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

    local knob = Instance.new("Frame")
    knob.Parent = pill
    knob.Size = UDim2.new(0,18,0,18)
    knob.Position = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BackgroundTransparency = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local enabled = _G.RAY_NoCutscenePause or false

    local function refresh()
        pill.BackgroundColor3 = enabled
            and (THEME_MAIN or Color3.fromRGB(140,90,255))
            or  (MUTED or Color3.fromRGB(70,70,90))

        knob.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.RAY_NoCutscenePause = enabled

        if enabled then
            _G.RAY_DisableCutscene = false
        end

        ReapplyGuiPatches()
        refresh()

        if NotifyFeature then
            NotifyFeature("No Cutscene Pause", enabled)
        end
    end)

    task.delay(1, function()
        if enabled then
            ReapplyGuiPatches()
        end
        refresh()
    end)

    refresh()
end

----------------------------------------------------------------
-- DISABLE FISH IMAGE
----------------------------------------------------------------
do
    local row = Instance.new("Frame")
    row.Parent = FishingSupportSection
    row.Size = UDim2.new(1,0,0,36)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel")
    label.Parent = row
    label.Size = UDim2.new(1,-120,1,0)
    label.Position = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = TEXT or THEME_TEXT
    label.Text = "Disable Fish Image"

    local pill = Instance.new("TextButton")
    pill.Parent = row
    pill.Size = UDim2.new(0,50,0,24)
    pill.Position = UDim2.new(1,-80,0.5,-12)
    pill.BackgroundColor3 = MUTED or Color3.fromRGB(70,70,90)
    pill.BackgroundTransparency = 0.1
    pill.Text = ""
    pill.AutoButtonColor = false
    Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

    local knob = Instance.new("Frame")
    knob.Parent = pill
    knob.Size = UDim2.new(0,18,0,18)
    knob.Position = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BackgroundTransparency = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local enabled = _G.RAY_DisableFishImage or false
    local conn
    local gui = Player:WaitForChild("PlayerGui")

    local function refresh()
        pill.BackgroundColor3 = enabled
            and (ACCENT or THEME_MAIN)
            or  (MUTED or Color3.fromRGB(70,70,90))

        knob.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    local function attach()
        for _, v in ipairs(gui:GetDescendants()) do
            if v.Name == "Small Notification" then
                v:Destroy()
            end
        end
        conn = gui.DescendantAdded:Connect(function(v)
            if v.Name == "Small Notification" then
                v:Destroy()
            end
        end)
    end

    local function detach()
        if conn then
            conn:Disconnect()
            conn = nil
        end
    end

    pill.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.RAY_DisableFishImage = enabled

        if enabled then
            attach()
        else
            detach()
        end

        refresh()
        if NotifyFeature then
            NotifyFeature("Disable Fish Image", enabled)
        end
    end)

    if enabled then
        attach()
    end

    refresh()
end

----------------------------------------------------------------
-- DISABLE ROD SKIN
----------------------------------------------------------------
do
    local row = Instance.new("Frame")
    row.Parent = FishingSupportSection
    row.Size = UDim2.new(1,0,0,36)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel")
    label.Parent = row
    label.Size = UDim2.new(1,-120,1,0)
    label.Position = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = TEXT or THEME_TEXT
    label.Text = "Disable Rod Skin"

    local pill = Instance.new("TextButton")
    pill.Parent = row
    pill.Size = UDim2.new(0,50,0,24)
    pill.Position = UDim2.new(1,-80,0.5,-12)
    pill.BackgroundColor3 = MUTED or Color3.fromRGB(70,70,90)
    pill.BackgroundTransparency = 0.1
    pill.Text = ""
    pill.AutoButtonColor = false
    Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

    local knob = Instance.new("Frame")
    knob.Parent = pill
    knob.Size = UDim2.new(0,18,0,18)
    knob.Position = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local enabled = _G.RAY_DisableRodSkin or false

    local function refresh()
        pill.BackgroundColor3 = enabled
            and (ACCENT or THEME_MAIN)
            or  (MUTED or Color3.fromRGB(70,70,90))

        knob.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    local function apply()
        if enabled then
            HideAllVFX()
        else
            RestoreAllVFX()
        end
    end

    pill.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.RAY_DisableRodSkin = enabled

        apply()
        refresh()
        if NotifyFeature then
            NotifyFeature("Disable Rod Skin", enabled)
        end
    end)

    Player.CharacterAdded:Connect(function()
        if enabled then
            task.delay(0.5, HideAllVFX)
        end
    end)

    apply()
    refresh()
end



----------------------------------------------------------------
-- ROD FREEZE
----------------------------------------------------------------
do
    local row = Instance.new("Frame")
    row.Parent = FishingSupportSection
    row.Size = UDim2.new(1,0,0,36)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel")
    label.Parent = row
    label.Size = UDim2.new(1,-120,1,0)
    label.Position = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = TEXT or THEME_TEXT
    label.Text = "Rod Freeze"

    local pill = Instance.new("TextButton")
    pill.Parent = row
    pill.Size = UDim2.new(0,50,0,24)
    pill.Position = UDim2.new(1,-80,0.5,-12)
    pill.BackgroundColor3 = Color3.fromRGB(120,120,120)
    pill.BackgroundTransparency = 0.1
    pill.Text = ""
    pill.AutoButtonColor = true
    Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

    local knob = Instance.new("Frame")
    knob.Parent = pill
    knob.Size = UDim2.new(0,18,0,18)
    knob.Position = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BackgroundTransparency = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local enabled = _G.RAY_RodFreeze or false

    local AnimController = require(ReplicatedStorage.Controllers.AnimationController)
    print("[RodFreeze] AnimController =", AnimController)

    _G.__RAY_OldPlayAnimation = _G.__RAY_OldPlayAnimation or AnimController.PlayAnimation
    local OldPlay = _G.__RAY_OldPlayAnimation

    local ROD_ANIMS = {
        ["RodThrow"]         = true,
        ["ReelStart"]        = true,
        ["ReelingIdle"]      = true,
        ["ReelIntermission"] = true,
        ["FishCaught"]       = true,
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

    local function refresh()
        if enabled then
            pill.BackgroundColor3 = Color3.fromRGB(0,200,100)
        else
            pill.BackgroundColor3 = Color3.fromRGB(120,120,120)
        end

        knob.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    local function applyPatch()
        AnimController.PlayAnimation = function(self, animName, waitEnd)
            if _G.RAY_RodFreeze and ROD_ANIMS[animName] then
                print("[RodFreeze] BLOCK", animName)
                local dummy = {
                    Play = function() end;
                    Stop = function() end;
                    Destroy = function() end;
                    Stopped = { Connect = function() end; Once = function() end };
                    Ended   = { Connect = function() end; Once = function() end };
                    TimePosition = 0;
                    Length = 0;
                }
                return dummy, nil
            end

            return OldPlay(self, animName, waitEnd)
        end
    end

    local function restorePatch()
        AnimController.PlayAnimation = OldPlay
    end

    pill.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.RAY_RodFreeze = enabled

        if enabled then
            applyPatch()
            startHardFreeze()
        else
            restorePatch()
            stopHardFreeze()
        end

        refresh()
        print("[RodFreeze] Enabled:", enabled)
        if NotifyFeature then
            NotifyFeature("Rod Freeze", enabled)
        end
    end)

    if enabled then
        applyPatch()
        startHardFreeze()
    else
        restorePatch()
        stopHardFreeze()
    end

    refresh()
end


----------------------------------------------------------------
-- SKIN ANIMATION SECTION (MUNCUL DI BAWAH FISHING SUPPORT)
----------------------------------------------------------------
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local Modules     = ReplicatedStorage:WaitForChild("Modules")

local AnimControllerModule = Controllers:WaitForChild("AnimationController")
local AnimationsModule      = Modules:WaitForChild("Animations")

local AnimModule       = require(AnimControllerModule)
local Animations_upvr  = require(AnimationsModule)
local oldGetAnimationData = AnimModule.GetAnimationData

if type(oldGetAnimationData) ~= "function" then
    warn("[SkinOverride] GetAnimationData tidak ada di AnimationController")
end

local SKINS = {
    "Eclipse Katana",
    "Holy Trident",
    "Soul Scythe",
    "Oceanic Harpoon",
    "Binary Edge",
    "The Vanquisher",
    "1x1x1x1 Ban Hammer",
}

local SelectedAnimSkin = nil
local OverrideEnabled  = false

function AnimModule:SetAnimationSkin(skinName)
    if typeof(skinName) == "string" and #skinName > 0 then
        SelectedAnimSkin = skinName
    else
        SelectedAnimSkin = nil
    end
end

function AnimModule:SetSkinOverrideEnabled(enabled)
    OverrideEnabled = not not enabled
end

AnimModule.GetAnimationData = function(self, animName)
    local baseData, baseKey = oldGetAnimationData(self, animName)
    if not baseData then
        return nil, nil
    end

    if not OverrideEnabled or not SelectedAnimSkin or not baseData.Variants then
        return baseData, baseKey
    end

    local overrideKey  = ("%s - %s"):format(SelectedAnimSkin, animName)
    local overrideData = Animations_upvr[overrideKey]

    if overrideData and overrideData.AnimationId then
        return overrideData, overrideKey
    end

    return baseData, baseKey
end



----------------------------------------------------------------
-- PANEL KANAN MENEMPEL KE MAIN (HANYA LIST SKIN)
----------------------------------------------------------------
local RightPanel = Instance.new("Frame")
RightPanel.Name = "SkinAnimationRightPanel"
RightPanel.Size = UDim2.new(0, 220, 1, -46)   -- tinggi = tinggi Main - TitleBar
RightPanel.AnchorPoint = Vector2.new(1, 0)
RightPanel.Position = UDim2.new(1, -10, 0, 40) -- nempel kanan Main, di bawah TitleBar
RightPanel.BackgroundColor3 = CARD or Color3.fromRGB(15, 15, 25)
RightPanel.BackgroundTransparency = 0.25
RightPanel.BorderSizePixel = 0
RightPanel.Visible = false
RightPanel.ZIndex = 10
RightPanel.Parent = Main          -- parent ke Main

Instance.new("UICorner", RightPanel).CornerRadius = UDim.new(0, 10)
local rStroke = Instance.new("UIStroke", RightPanel)
rStroke.Color = THEME_MAIN
rStroke.Transparency = 0.5

local rpTitle = Instance.new("TextLabel")
rpTitle.Parent = RightPanel
rpTitle.Size = UDim2.new(1, -10, 0, 24)
rpTitle.Position = UDim2.new(0, 5, 0, 6)
rpTitle.BackgroundTransparency = 1
rpTitle.Font = Enum.Font.GothamBold
rpTitle.TextSize = 16
rpTitle.TextXAlignment = Enum.TextXAlignment.Left
rpTitle.TextColor3 = THEME_TEXT
rpTitle.ZIndex = 11
rpTitle.Text = "Skin Animation"

local rpSkin = Instance.new("TextLabel")
rpSkin.Parent = RightPanel
rpSkin.Size = UDim2.new(1, -10, 0, 18)
rpSkin.Position = UDim2.new(0, 5, 0, 30)
rpSkin.BackgroundTransparency = 1
rpSkin.Font = Enum.Font.Gotham
rpSkin.TextSize = 12
rpSkin.TextXAlignment = Enum.TextXAlignment.Left
rpSkin.TextColor3 = Color3.fromRGB(200,200,200)
rpSkin.ZIndex = 11

local function UpdateRightSkinLabel()
    if SelectedAnimSkin and #SelectedAnimSkin > 0 then
        rpSkin.Text = "Skin: " .. SelectedAnimSkin
    else
        rpSkin.Text = "Skin: default (ikut rod)"
    end
end

local rpScroll = Instance.new("ScrollingFrame")
rpScroll.Parent = RightPanel
rpScroll.Size = UDim2.new(1, -10, 1, -70)
rpScroll.Position = UDim2.new(0, 5, 0, 54)
rpScroll.BackgroundTransparency = 1
rpScroll.BorderSizePixel = 0
rpScroll.ScrollBarThickness = 3
rpScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
rpScroll.CanvasSize = UDim2.new(0,0,0,0)
rpScroll.ScrollBarImageColor3 = THEME_MAIN
rpScroll.ZIndex = 10

local rpList = Instance.new("UIListLayout", rpScroll)
rpList.SortOrder = Enum.SortOrder.LayoutOrder
rpList.Padding = UDim.new(0,4)

local function CreateSkinEntry(skinName)
    local row = Instance.new("Frame")
    row.Parent = rpScroll
    row.Size = UDim2.new(1, -4, 0, 24)
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    row.ZIndex = 11

    local line = Instance.new("Frame")
    line.Name = "Highlight"
    line.Parent = row
    line.Size = UDim2.new(0, 3, 1, 0)
    line.Position = UDim2.new(0, 0, 0, 0)
    line.BackgroundColor3 = THEME_MAIN or Color3.fromRGB(170, 90, 255)
    line.BorderSizePixel = 0
    line.Visible = false
    line.ZIndex = 12

    local btn = Instance.new("TextButton")
    btn.Parent = row
    btn.Size = UDim2.new(1, -6, 1, 0)
    btn.Position = UDim2.new(0, 4, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,50)
    btn.BorderSizePixel = 0
    btn.TextColor3 = THEME_TEXT
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "  " .. skinName
    btn.AutoButtonColor = true
    btn.ZIndex = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

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

for _, sn in ipairs(SKINS) do
    CreateSkinEntry(sn)
end

UpdateRightSkinLabel()

----------------------------------------------------------------
-- CLOSE PANEL (MOUSE & TOUCH, KLIK DI MANA PUN)
----------------------------------------------------------------
UIS.InputBegan:Connect(function(input)
    if not RightPanel.Visible then return end

    if input.UserInputType ~= Enum.UserInputType.MouseButton1
    and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local pos = input.Position
    local absPos = RightPanel.AbsolutePosition
    local absSize = RightPanel.AbsoluteSize

    local inside =
        pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
        pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y

    if not inside then
        RightPanel.Visible = false
    end
end)

----------------------------------------------------------------
-- DROPDOWN “Skin Animation” DI BAWAH FISHING SUPPORT
----------------------------------------------------------------
local SkinAnimationSection

if AutoPage then
    SkinAnimationSection = CreateSectionDropdown(AutoPage, "Skin Animation")

    local layout = Instance.new("UIListLayout")
    layout.Parent = SkinAnimationSection
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)

    local LineSA = Instance.new("Frame")
    LineSA.Parent = SkinAnimationSection
    LineSA.Size = UDim2.new(1, 0, 0, 2)
    LineSA.Position = UDim2.new(0, 0, 0, 2)
    LineSA.BackgroundColor3 = THEME_MAIN
    LineSA.BorderSizePixel = 0

    -- Row 1: toggle override
    do
        local row = Instance.new("Frame")
        row.Parent = SkinAnimationSection
        row.Size = UDim2.new(1,0,0,36)
        row.BackgroundTransparency = 1

        local label = Instance.new("TextLabel")
        label.Parent = row
        label.Size = UDim2.new(1,-100,1,0)
        label.Position = UDim2.new(0,16,0,0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextColor3 = TEXT or THEME_TEXT
        label.Text = "Skin Override"

        local pill = Instance.new("TextButton")
        pill.Parent = row
        pill.Size = UDim2.new(0,50,0,24)
        pill.Position = UDim2.new(1,-80,0.5,-12)
        pill.BackgroundColor3 = MUTED or Color3.fromRGB(70,70,90)
        pill.BackgroundTransparency = 0.1
        pill.Text = ""
        pill.AutoButtonColor = false
        Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

        local knob = Instance.new("Frame")
        knob.Parent = pill
        knob.Size = UDim2.new(0,18,0,18)
        knob.Position = UDim2.new(0,3,0.5,-9)
        knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
        knob.BackgroundTransparency = 0
        Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

        local function refreshToggle()
            pill.BackgroundColor3 = OverrideEnabled and THEME_MAIN or (MUTED or Color3.fromRGB(70,70,90))
            knob.Position = OverrideEnabled
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        pill.MouseButton1Click:Connect(function()
            OverrideEnabled = not OverrideEnabled
            AnimModule:SetSkinOverrideEnabled(OverrideEnabled)
            refreshToggle()
            if NotifyFeature then
                NotifyFeature("Skin Override", OverrideEnabled)
            end
        end)

        refreshToggle()
    end

    -- Row 2: tombol buka panel kanan
    do
        local row = Instance.new("Frame")
        row.Parent = SkinAnimationSection
        row.Size = UDim2.new(1,0,0,40)
        row.BackgroundTransparency = 1

        local label = Instance.new("TextLabel")
        label.Parent = row
        label.Size = UDim2.new(1,-110,1,0)
        label.Position = UDim2.new(0,16,0,0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextColor3 = TEXT or THEME_TEXT
        label.Text = "Open Skin Panel"

        local btn = Instance.new("TextButton")
        btn.Parent = row
        btn.Size = UDim2.new(0,80,0,24)
        btn.Position = UDim2.new(1,-100,0.5,-12)
        btn.BackgroundColor3 = CARD or Color3.fromRGB(40,40,60)
        btn.BackgroundTransparency = 0.1
        btn.Text = "Open"
        btn.TextColor3 = THEME_TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.AutoButtonColor = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

        btn.MouseButton1Click:Connect(function()
            RightPanel.Visible = not RightPanel.Visible
        end)
    end
end

----------------------------------------------
--- AUTO SELL ---
--- ------------------------------------------

local Items   = require(ReplicatedStorage.Items)
local Replion = require(ReplicatedStorage.Packages.Replion)

local BackpackPage = Pages["Backpack"]
if BackpackPage then
    local layout = Instance.new("UIListLayout", BackpackPage)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
end

local BackpackAutoSellSection
if BackpackPage then
    BackpackAutoSellSection = CreateSectionDropdown(BackpackPage, "Auto Sell")

    local sectionLayout = Instance.new("UIListLayout", BackpackAutoSellSection)
    sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sectionLayout.Padding = UDim.new(0, 4)

    ----------------------------------------------------------------
    -- STATE GLOBAL
    ----------------------------------------------------------------
    _G.RAY_SellThreshold          = _G.RAY_SellThreshold          or "Legendary"
    _G.RAY_SellDelay              = _G.RAY_SellDelay              or 5
    _G.RAY_SellInventoryThreshold = _G.RAY_SellInventoryThreshold or 30
    _G.RAY_SellByTime             = (_G.RAY_SellByTime ~= false)       -- default ON
    _G.RAY_SellByInventory        = _G.RAY_SellByInventory or false    -- default OFF

    ----------------------------------------------------------------
    -- HELPER ROW
    ----------------------------------------------------------------
    local function makeRow(title, height)
        local row = Instance.new("Frame")
        row.Parent = BackpackAutoSellSection
        row.Size = UDim2.new(1,0,0,height or 32)
        row.BackgroundTransparency = 1

        local label = Instance.new("TextLabel")
        label.Parent = row
        label.Size = UDim2.new(0.55,0,1,0)
        label.Position = UDim2.new(0,16,0,-2)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.Text = title

        return row
    end

    ----------------------------------------------------------------
    -- Sell Threshold (Legendary/Mythic/Secret)
    ----------------------------------------------------------------
    local ThresholdMap = {
        Legendary = 5,
        Mythic    = 6,
        Secret    = 7,
    }

    local thRow = makeRow("Sell Threshold")

    local thBtn = Instance.new("TextButton")
    thBtn.Parent = thRow
    thBtn.Size = UDim2.new(0.38,0,0,28)
    thBtn.Position = UDim2.new(0.58,0,0.5,-14)
    thBtn.BackgroundColor3 = CARD or Color3.fromRGB(25,25,35)
    thBtn.BackgroundTransparency = 0.12
    thBtn.Text = _G.RAY_SellThreshold.."  ▼"
    thBtn.Font = Enum.Font.Gotham
    thBtn.TextSize = 13
    thBtn.TextColor3 = Color3.fromRGB(255,255,255)
    thBtn.AutoButtonColor = false
    Instance.new("UICorner", thBtn).CornerRadius = UDim.new(0,8)

    local thDrop = Instance.new("Frame")
    thDrop.Parent = thRow
    thDrop.Position = UDim2.new(0.58,0,1,4)
    thDrop.Size = UDim2.new(0.38,0,0,72)
    thDrop.BackgroundColor3 = CARD or Color3.fromRGB(25,25,35)
    thDrop.BackgroundTransparency = 0.06
    thDrop.Visible = false
    thDrop.ZIndex = 5
    Instance.new("UICorner", thDrop).CornerRadius = UDim.new(0,8)

    local thList = Instance.new("UIListLayout")
    thList.Parent = thDrop
    thList.Padding = UDim.new(0,4)
    thList.SortOrder = Enum.SortOrder.LayoutOrder

    for _, rar in ipairs({"Legendary","Mythic","Secret"}) do
        local b = Instance.new("TextButton")
        b.Parent = thDrop
        b.Size = UDim2.new(1,-8,0,24)
        b.BackgroundColor3 = CARD or Color3.fromRGB(25,25,35)
        b.BackgroundTransparency = 0.18
        b.Text = rar
        b.Font = Enum.Font.Gotham
        b.TextSize = 12
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.ZIndex = 6
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

        b.MouseButton1Click:Connect(function()
            _G.RAY_SellThreshold = rar
            thBtn.Text = rar.."  ▼"
            thDrop.Visible = false

            local code = ThresholdMap[rar]
            if code then
                pcall(function()
                    Events.updateSellThreshold:InvokeServer(code)
                end)
            end

            if NotifyFeature then
                NotifyFeature("Sell Threshold: "..rar, true)
            end
        end)
    end

    local thOpen = false
    thBtn.MouseButton1Click:Connect(function()
        thOpen = not thOpen
        thDrop.Visible = thOpen
    end)

    ----------------------------------------------------------------
    -- Sell Delay (seconds) - dipakai kalau Sell by Time ON
    ----------------------------------------------------------------
    local delayRow = makeRow("Sell Delay (seconds)")

    local delayBox = Instance.new("TextBox")
    delayBox.Parent = delayRow
    delayBox.Size = UDim2.new(0.38,0,1,0)
    delayBox.Position = UDim2.new(0.58,0,0,0)
    delayBox.Text = tostring(_G.RAY_SellDelay)
    delayBox.Font = Enum.Font.Gotham
    delayBox.TextSize = 13
    delayBox.TextXAlignment = Enum.TextXAlignment.Center
    delayBox.TextColor3 = Color3.fromRGB(255,255,255)
    delayBox.ClearTextOnFocus = false
    delayBox.BackgroundColor3 = CARD or Color3.fromRGB(25,25,35)
    delayBox.BackgroundTransparency = 0.12
    Instance.new("UICorner", delayBox).CornerRadius = UDim.new(0,8)

    delayBox.FocusLost:Connect(function()
        local n = tonumber(delayBox.Text:match("[%d%.]+"))
        if n and n > 0 then
            _G.RAY_SellDelay = n
            delayBox.Text = tostring(n)
        else
            delayBox.Text = tostring(_G.RAY_SellDelay)
        end
        if NotifyFeature then
            NotifyFeature("Sell Delay = "..tostring(_G.RAY_SellDelay).."s", true)
        end
    end)

    ----------------------------------------------------------------
    -- Inventory Threshold (jumlah ikan di tas)
    ----------------------------------------------------------------
    local invRow = makeRow("Inventory Threshold")

    local invBox = Instance.new("TextBox")
    invBox.Parent = invRow
    invBox.Size = UDim2.new(0.38,0,1,0)
    invBox.Position = UDim2.new(0.58,0,0,0)
    invBox.Text = tostring(_G.RAY_SellInventoryThreshold)
    invBox.Font = Enum.Font.Gotham
    invBox.TextSize = 13
    invBox.TextXAlignment = Enum.TextXAlignment.Center
    invBox.TextColor3 = Color3.fromRGB(255,255,255)
    invBox.ClearTextOnFocus = false
    invBox.BackgroundColor3 = CARD or Color3.fromRGB(25,25,35)
    invBox.BackgroundTransparency = 0.12
    Instance.new("UICorner", invBox).CornerRadius = UDim.new(0,8)

    invBox.FocusLost:Connect(function()
        local n = tonumber(invBox.Text:match("%d+"))
        if n and n > 0 then
            _G.RAY_SellInventoryThreshold = n
            invBox.Text = tostring(n)
        else
            invBox.Text = tostring(_G.RAY_SellInventoryThreshold)
        end
        if NotifyFeature then
            NotifyFeature("Inventory Limit = "..tostring(_G.RAY_SellInventoryThreshold), true)
        end
    end)

    ----------------------------------------------------------------
    -- Toggle: Sell by Time
    ----------------------------------------------------------------
    local rowTime = makeRow("Sell by Time")

    local pillTime = Instance.new("TextButton")
    pillTime.Parent = rowTime
    pillTime.Size = UDim2.new(0,50,0,24)
    pillTime.Position = UDim2.new(1,-80,0.5,-12)
    pillTime.BackgroundColor3 = MUTED or Color3.fromRGB(70,70,90)
    pillTime.BackgroundTransparency = 0.1
    pillTime.Text = ""
    pillTime.AutoButtonColor = false
    Instance.new("UICorner", pillTime).CornerRadius = UDim.new(0,999)

    local knobTime = Instance.new("Frame")
    knobTime.Parent = pillTime
    knobTime.Size = UDim2.new(0,18,0,18)
    knobTime.Position = UDim2.new(0,3,0.5,-9)
    knobTime.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knobTime.BackgroundTransparency = 0
    Instance.new("UICorner", knobTime).CornerRadius = UDim.new(0,999)

    local function refreshTime()
        local on = _G.RAY_SellByTime
        pillTime.BackgroundColor3 =
            on and (ACCENT or Color3.fromRGB(0,200,100))
            or (MUTED or Color3.fromRGB(70,70,90))
        knobTime.Position = on and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
    end

    pillTime.MouseButton1Click:Connect(function()
        _G.RAY_SellByTime = not _G.RAY_SellByTime
        refreshTime()
        if NotifyFeature then
            NotifyFeature("Sell by Time", _G.RAY_SellByTime)
        end
    end)

    ----------------------------------------------------------------
    -- Toggle: Sell by Inventory
    ----------------------------------------------------------------
    local rowInv = makeRow("Sell by Inventory")

    local pillInv = Instance.new("TextButton")
    pillInv.Parent = rowInv
    pillInv.Size = UDim2.new(0,50,0,24)
    pillInv.Position = UDim2.new(1,-80,0.5,-12)
    pillInv.BackgroundColor3 = MUTED or Color3.fromRGB(70,70,90)
    pillInv.BackgroundTransparency = 0.1
    pillInv.Text = ""
    pillInv.AutoButtonColor = false
    Instance.new("UICorner", pillInv).CornerRadius = UDim.new(0,999)

    local knobInv = Instance.new("Frame")
    knobInv.Parent = pillInv
    knobInv.Size = UDim2.new(0,18,0,18)
    knobInv.Position = UDim2.new(0,3,0.5,-9)
    knobInv.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knobInv.BackgroundTransparency = 0
    Instance.new("UICorner", knobInv).CornerRadius = UDim.new(0,999)

    local function refreshInv()
        local on = _G.RAY_SellByInventory
        pillInv.BackgroundColor3 =
            on and (ACCENT or Color3.fromRGB(0,200,100))
            or (MUTED or Color3.fromRGB(70,70,90))
        knobInv.Position = on and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
    end

    pillInv.MouseButton1Click:Connect(function()
        _G.RAY_SellByInventory = not _G.RAY_SellByInventory
        refreshInv()
        if NotifyFeature then
            NotifyFeature("Sell by Inventory", _G.RAY_SellByInventory)
        end
    end)

    refreshTime()
    refreshInv()
end

----------------------------------------------------------------
-- HELPER: HITUNG JUMLAH IKAN DI INVENTORY
----------------------------------------------------------------
local ItemDataById = {}
for _, v in Items do
    if v.Data and v.Data.Id then
        ItemDataById[v.Data.Id] = v.Data
    end
end

local function getFishCountInInventory()
    local ok, repl = pcall(function()
        return Replion.Client:WaitReplion("Data")
    end)
    if not ok or not repl or not repl.Data then
        return 0
    end

    local root = repl.Data
    local inv  = root and root.Inventory
    local items = inv and inv.Items
    if typeof(items) ~= "table" then
        return 0
    end

    local count = 0
    for _, entry in pairs(items) do
        local id   = entry.Id
        local data = id and ItemDataById[id]
        if data and data.Type == "Fish" then
            count += 1
        end
    end
    return count
end

----------------------------------------------------------------
-- AUTO SELL ENGINE
----------------------------------------------------------------
task.spawn(function()
    local lastSell = 0

    while true do
        local now = os.clock()

        -- Sell by Time
        if _G.RAY_SellByTime then
            local delay = tonumber(_G.RAY_SellDelay) or 5
            if now - lastSell >= delay then
                local ok, err = pcall(function()
                    Events.sell:InvokeServer()
                end)
                if ok then
                    lastSell = now
                else
                    warn("[AUTO SELL] sell (time) error:", err)
                end
            end
        end

        -- Sell by Inventory
        if _G.RAY_SellByInventory then
            local count = getFishCountInInventory()
            local limit = tonumber(_G.RAY_SellInventoryThreshold) or 30

            if count >= limit and now - lastSell >= 0.5 then
                local ok, err = pcall(function()
                    Events.sell:InvokeServer()
                end)
                if ok then
                    lastSell = now
                else
                    warn("[AUTO SELL] sell (inv) error:", err)
                end
            end
        end

        task.wait(0.5)
    end
end)


----------------------------------------------------------------
-- STATE GLOBAL AUTO TOTEM
----------------------------------------------------------------
_G.RAYAutoTotemOn       = _G.RAYAutoTotemOn       or false
_G.RAYSelectedTotemType = _G.RAYSelectedTotemType or "Lucky"  -- "Lucky"/"Mutasi"/"Shiny"/"Love"

----------------------------------------------------------------
-- BACKEND AUTO TOTEM
----------------------------------------------------------------
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")
local UIS               = game:GetService("UserInputService")

local Replion = require(ReplicatedStorage.Packages.Replion)

local SpawnTotemRemote = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")
    :WaitForChild("RE/SpawnTotem")  -- remote spawn totem [web:10][web:186]

-- durasi totem (kalau mau dipakai di auto recast)
local TOTEM_DURATION = 3600

local TotemTypeId = {
    Mutasi = 2,
    Shiny  = 3,
    Lucky  = 1,
    Love   = 17,  -- Love Totem
}

local function GetTotemDataReplion()
    local ok, data = pcall(function()
        local r = Replion.Client:WaitReplion("Data")
        return r.Data
    end)
    if not ok or not data then return nil end
    return data
end

local function findTotemUuidByType(jenis)
    local targetId = TotemTypeId[jenis]
    if not targetId then return nil end

    local data = GetTotemDataReplion()
    if not data then return nil end

    local inv    = data.Inventory
    local totems = inv and inv.Totems
    if typeof(totems) ~= "table" then return nil end

    for _, entry in pairs(totems) do
        if entry.Id == targetId then
            return entry.UUID
        end
    end
    return nil
end

local function SpawnTotemUUID(uuid)
    if not uuid then return end
    pcall(function()
        SpawnTotemRemote:FireServer(uuid)
        -- kalau butuh table:
        -- SpawnTotemRemote:FireServer({UUID = uuid})
    end)
end

----------------------------------------------------------------
-- SECTION "AUTO TOTEM" DI BACKPACK
----------------------------------------------------------------

local BackpackPage = Pages and Pages["Backpack"]
if BackpackPage then
    local AutoTotemSection = CreateSectionDropdownBackpackPage and CreateSectionDropdownBackpackPage(BackpackPage, "Auto Totem")
        or CreateSectionDropdown(BackpackPage, "Auto Totem")

    local sectionLayout = Instance.new("UIListLayout")
    sectionLayout.Parent    = AutoTotemSection
    sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sectionLayout.Padding   = UDim.new(0, 6)

    local function makeRow(title, height)
        local row = Instance.new("Frame")
        row.Parent                 = AutoTotemSection
        row.Size                   = UDim2.new(1,0,0,height or 36)
        row.BackgroundTransparency = 1

        local label = Instance.new("TextLabel")
        label.Parent               = row
        label.Size                 = UDim2.new(1,-110,1,0)
        label.Position             = UDim2.new(0,16,0,0)
        label.BackgroundTransparency = 1
        label.Font                 = Enum.Font.Gotham
        label.TextSize             = 13
        label.TextXAlignment       = Enum.TextXAlignment.Left
        label.TextColor3           = TEXT or THEME_TEXT
        label.Text                 = title

        return row
    end

    local function makeSmallButton(row, text)
        local btn = Instance.new("TextButton")
        btn.Parent                 = row
        btn.Size                   = UDim2.new(0,120,0,24)
        btn.Position               = UDim2.new(1,-136,0.5,-12)
        btn.BackgroundColor3       = CARD or Color3.fromRGB(40,40,60)
        btn.BackgroundTransparency = 0.1
        btn.Text                   = text
        btn.TextColor3             = THEME_TEXT
        btn.Font                   = Enum.Font.GothamBold
        btn.TextSize               = 12
        btn.AutoButtonColor        = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
        return btn
    end

    ------------------------------------------------------------
    -- PANEL KANAN: LIST TOTEM
    ------------------------------------------------------------
    local TotemRightPanel = Instance.new("Frame")
    TotemRightPanel.Name                  = "TotemRightPanel"
    TotemRightPanel.Size                  = UDim2.new(0, 220, 1, -46)
    TotemRightPanel.AnchorPoint           = Vector2.new(1, 0)
    TotemRightPanel.Position              = UDim2.new(1, -10, 0, 40)
    TotemRightPanel.BackgroundColor3      = CARD or Color3.fromRGB(15, 15, 25)
    TotemRightPanel.BackgroundTransparency= 0.25
    TotemRightPanel.BorderSizePixel       = 0
    TotemRightPanel.Visible               = false
    TotemRightPanel.ZIndex                = 10
    TotemRightPanel.Parent                = Main or BackpackPage

    Instance.new("UICorner", TotemRightPanel).CornerRadius = UDim.new(0, 10)
    local trStroke = Instance.new("UIStroke", TotemRightPanel)
    trStroke.Color        = THEME_MAIN or THEMEMAIN
    trStroke.Transparency = 0.5

    local trTitle = Instance.new("TextLabel")
    trTitle.Parent               = TotemRightPanel
    trTitle.Size                 = UDim2.new(1, -10, 0, 24)
    trTitle.Position             = UDim2.new(0, 5, 0, 6)
    trTitle.BackgroundTransparency = 1
    trTitle.Font                 = Enum.Font.GothamBold
    trTitle.TextSize             = 16
    trTitle.TextXAlignment       = Enum.TextXAlignment.Left
    trTitle.TextColor3           = THEME_TEXT
    trTitle.ZIndex               = 11
    trTitle.Text                 = "Totem List"

    local trInfo = Instance.new("TextLabel")
    trInfo.Parent               = TotemRightPanel
    trInfo.Size                 = UDim2.new(1, -10, 0, 18)
    trInfo.Position             = UDim2.new(0, 5, 0, 30)
    trInfo.BackgroundTransparency = 1
    trInfo.Font                 = Enum.Font.Gotham
    trInfo.TextSize             = 12
    trInfo.TextXAlignment       = Enum.TextXAlignment.Left
    trInfo.TextColor3           = Color3.fromRGB(200,200,200)
    trInfo.ZIndex               = 11
    trInfo.Text                 = "Pilih totem yang mau dipasang."

    local trScroll = Instance.new("ScrollingFrame")
    trScroll.Parent               = TotemRightPanel
    trScroll.Size                 = UDim2.new(1, -10, 1, -70)
    trScroll.Position             = UDim2.new(0, 5, 0, 54)
    trScroll.BackgroundTransparency = 1
    trScroll.BorderSizePixel      = 0
    trScroll.ScrollBarThickness   = 3
    trScroll.AutomaticCanvasSize  = Enum.AutomaticSize.Y
    trScroll.CanvasSize           = UDim2.new(0,0,0,0)
    trScroll.ScrollBarImageColor3 = THEME_MAIN or THEMEMAIN
    trScroll.ZIndex               = 10

    local trList = Instance.new("UIListLayout", trScroll)
    trList.SortOrder = Enum.SortOrder.LayoutOrder
    trList.Padding   = UDim.new(0,4)

    local TO_TYPES = { "Lucky", "Mutasi", "Shiny", "Love" }

    local function rebuildTotemPanel()
        for _, c in ipairs(trScroll:GetChildren()) do
            if c:IsA("Frame") and c ~= trList then
                c:Destroy()
            end
        end

        for _, jenis in ipairs(TO_TYPES) do
            local id = TotemTypeId[jenis]

            local row = Instance.new("Frame")
            row.Parent                 = trScroll
            row.Size                   = UDim2.new(1, -4, 0, 24)
            row.BackgroundTransparency = 1
            row.BorderSizePixel        = 0
            row.ZIndex                 = 11

            local line = Instance.new("Frame")
            line.Name                  = "Highlight"
            line.Parent                = row
            line.Size                  = UDim2.new(0, 3, 1, 0)
            line.Position              = UDim2.new(0, 0, 0, 0)
            line.BackgroundColor3      = Color3.fromRGB(160,110,255)
            line.BorderSizePixel       = 0
            line.Visible               = (_G.RAYSelectedTotemType == jenis)
            line.ZIndex                = 12

            local btn = Instance.new("TextButton")
            btn.Parent                 = row
            btn.Size                   = UDim2.new(1, -6, 1, 0)
            btn.Position               = UDim2.new(0, 4, 0, 0)
            btn.BackgroundColor3       = (_G.RAYSelectedTotemType == jenis)
                                        and Color3.fromRGB(40,40,70)
                                        or  Color3.fromRGB(30,30,50)
            btn.BorderSizePixel        = 0
            btn.TextColor3             = THEME_TEXT
            btn.Font                   = Enum.Font.Gotham
            btn.TextSize               = 12
            btn.TextXAlignment         = Enum.TextXAlignment.Left
            btn.Text                   = "  "..jenis.." Totem  ["..tostring(id).."]"
            btn.AutoButtonColor        = true
            btn.ZIndex                 = 11
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

            btn.MouseButton1Click:Connect(function()
                if _G.RAYSelectedTotemType == jenis then
                    _G.RAYSelectedTotemType = nil
                    if NotifyFeature then
                        NotifyFeature("Totem "..jenis, false)
                    end
                else
                    _G.RAYSelectedTotemType = jenis
                    if NotifyFeature then
                        NotifyFeature("Totem "..jenis, true)
                    end
                end
                rebuildTotemPanel()
            end)
        end
    end

    rebuildTotemPanel()

    ------------------------------------------------------------
    -- ROW TOGGLE AUTO TOTEM (1x CAST SAAT ON)
    ------------------------------------------------------------
    do
        local row = makeRow("Enable Auto Totem (1x Cast)")

        local pill = Instance.new("TextButton")
        pill.Parent                 = row
        pill.Size                   = UDim2.new(0,50,0,24)
        pill.Position               = UDim2.new(1,-80,0.5,-12)
        pill.BackgroundColor3       = MUTED or Color3.fromRGB(70,70,90)
        pill.BackgroundTransparency = 0.1
        pill.Text                   = ""
        pill.AutoButtonColor        = false
        Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

        local knob = Instance.new("Frame")
        knob.Parent                 = pill
        knob.Size                   = UDim2.new(0,18,0,18)
        knob.Position               = UDim2.new(0,3,0.5,-9)
        knob.BackgroundColor3       = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

        local function refresh()
            pill.BackgroundColor3 = _G.RAYAutoTotemOn
                and (ACCENT or Color3.fromRGB(0,200,150))
                or  (MUTED or Color3.fromRGB(70,70,90))
            knob.Position = _G.RAYAutoTotemOn
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        local function castTotemOnce()
            local jenis = _G.RAYSelectedTotemType or "Lucky"
            local uuid  = findTotemUuidByType(jenis)
            if not uuid then
                if NotifyFeature then
                    NotifyFeature("Totem "..jenis.." tidak ditemukan", false)
                end
                return
            end

            SpawnTotemUUID(uuid)

            if NotifyFeature then
                NotifyFeature("Spawn "..jenis.." Totem", true)
            end
        end

        pill.MouseButton1Click:Connect(function()
            _G.RAYAutoTotemOn = not _G.RAYAutoTotemOn
            refresh()

            if _G.RAYAutoTotemOn then
                castTotemOnce()
            else
                if NotifyFeature then
                    NotifyFeature("Auto Totem OFF", false)
                end
            end
        end)

        refresh()
    end

    ------------------------------------------------------------
    -- ROW BUKA PANEL TOTEM LIST
    ------------------------------------------------------------
    do
        local row = makeRow("Totem List Panel")
        local btn = makeSmallButton(row, "Open")
        btn.MouseButton1Click:Connect(function()
            TotemRightPanel.Visible = not TotemRightPanel.Visible
            if TotemRightPanel.Visible then
                rebuildTotemPanel()
            end
        end)
    end

    ------------------------------------------------------------
    -- CLOSE PANEL TOTEM DARI KLIK DI LUAR (MIRIP POTION)
    ------------------------------------------------------------
    UIS.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
           and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local function shouldClose(panel)
            if not panel or not panel.Visible then
                return false
            end
            local pos    = input.Position
            local absPos = panel.AbsolutePosition
            local absSize= panel.AbsoluteSize
            local inside =
                pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
                pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y
            return not inside
        end

        if shouldClose(TotemRightPanel) then
            TotemRightPanel.Visible = false
        end
    end)
end




----------------------------------------------------------------
-- SECTION "GEAR PRESET"
----------------------------------------------------------------

local BackpackPage = Pages and Pages["Backpack"]
if BackpackPage then
    local GearPresetSection = CreateSectionDropdown(BackpackPage, "Gear Preset")

    local gpLayout = Instance.new("UIListLayout")
    gpLayout.Parent    = GearPresetSection
    gpLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gpLayout.Padding   = UDim.new(0, 6)

    -- helper row (mapping gaya baru)
    local function makeGearRow(title)
        local row = Instance.new("Frame")
        row.Parent                  = GearPresetSection
        row.Size                    = UDim2.new(1,0,0,36)
        row.BackgroundTransparency  = 1

        local label = Instance.new("TextLabel")
        label.Parent                = row
        label.Size                  = UDim2.new(1,-100,1,0)
        label.Position              = UDim2.new(0,16,0,0)
        label.BackgroundTransparency= 1
        label.Font                  = Enum.Font.Gotham
        label.TextSize              = 13
        label.TextXAlignment        = Enum.TextXAlignment.Left
        label.TextColor3            = TEXT or THEME_TEXT
        label.Text                  = title

        return row
    end

    ----------------------------------------------------------------
    -- ADVANCE DIVING GEAR (TOGGLE ON = EQUIP, OFF = UNEQUIP)
    ----------------------------------------------------------------
    do
        local row = makeGearRow("Advance Diving Gear")

        local pill = Instance.new("TextButton", row)
        pill.Size                   = UDim2.new(0,50,0,24)
        pill.Position               = UDim2.new(1,-80,0.5,-12)
        pill.BackgroundColor3       = MUTED or Color3.fromRGB(70,70,90)
        pill.BackgroundTransparency = 0.1
        pill.Text                   = ""
        pill.AutoButtonColor        = false
        Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

        local knob = Instance.new("Frame", pill)
        knob.Size                     = UDim2.new(0,18,0,18)
        knob.Position                 = UDim2.new(0,3,0.5,-9)
        knob.BackgroundColor3         = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

        _G.RAY_AdvanceDivingOn = _G.RAY_AdvanceDivingOn or false
        local divingOn = _G.RAY_AdvanceDivingOn

        local function refreshDiving()
            pill.BackgroundColor3 = divingOn
                and (ACCENT or Color3.fromRGB(0,200,150))
                or  (MUTED or Color3.fromRGB(70,70,90))
            knob.Position = divingOn
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        local function GetEquipTankRF()
            local ok, rf = pcall(function()
                return ReplicatedStorage
                    :WaitForChild("Packages")
                    :WaitForChild("_Index")
                    :WaitForChild("sleitnick_net@0.2.0")
                    :WaitForChild("net")
                    :WaitForChild("RF/EquipOxygenTank")
            end)
            return ok and rf or nil
        end

        pill.MouseButton1Click:Connect(function()
            local newState = not divingOn

            if newState then
                -- ON: equip tank
                local rf = GetEquipTankRF()
                if not rf then
                    warn("[Threeblox] EquipOxygenTank RF not found")
                    return
                end

                local ok, res = pcall(function()
                    return rf:InvokeServer(575) -- id tank
                end)
                if not ok then
                    warn("[Threeblox] Equip tank failed:", res)
                    return
                end
            else
                -- OFF: unequip via Events.unequip (kalau ada)
                if Events and Events.unequip then
                    pcall(function()
                        Events.unequip:FireServer()
                    end)
                end
            end

            divingOn = newState
            _G.RAY_AdvanceDivingOn = divingOn
            refreshDiving()
            if NotifyFeature then
                NotifyFeature("Advance Diving Gear", divingOn)
            end
        end)

        refreshDiving()
    end

    ----------------------------------------------------------------
    -- FISHING RADAR (DI DALAM GEAR PRESET)
    ----------------------------------------------------------------
    do
        local rowRadar = makeGearRow("Fishing Radar")

        local pillRadar = Instance.new("TextButton", rowRadar)
        pillRadar.Size                   = UDim2.new(0,50,0,24)
        pillRadar.Position               = UDim2.new(1,-80,0.5,-12)
        pillRadar.BackgroundColor3       = MUTED or Color3.fromRGB(70,70,90)
        pillRadar.BackgroundTransparency = 0.1
        pillRadar.Text                   = ""
        pillRadar.AutoButtonColor        = false
        Instance.new("UICorner", pillRadar).CornerRadius = UDim.new(0,999)

        local knobRadar = Instance.new("Frame", pillRadar)
        knobRadar.Size                     = UDim2.new(0,18,0,18)
        knobRadar.Position                 = UDim2.new(0,3,0.5,-9)
        knobRadar.BackgroundColor3         = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", knobRadar).CornerRadius = UDim.new(0,999)

        _G.RAY_FishingRadarOn = _G.RAY_FishingRadarOn or false
        local radarOn = _G.RAY_FishingRadarOn

        local function refreshRadar()
            pillRadar.BackgroundColor3 = radarOn
                and (ACCENT or Color3.fromRGB(0,200,150))
                or  (MUTED or Color3.fromRGB(70,70,90))
            knobRadar.Position = radarOn
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        local function GetRadarRF()
            local ok, rf = pcall(function()
                return ReplicatedStorage
                    :WaitForChild("Packages")
                    :WaitForChild("_Index")
                    :WaitForChild("sleitnick_net@0.2.0")
                    :WaitForChild("net")
                    :WaitForChild("RF/UpdateFishingRadar")
            end)
            return ok and rf or nil
        end

        pillRadar.MouseButton1Click:Connect(function()
            local rf = GetRadarRF()
            if not rf then
                warn("[Threeblox] UpdateFishingRadar RF not found")
                return
            end

            local newState = not radarOn
            local ok, res = pcall(function()
                return rf:InvokeServer(newState)
            end)

            if ok then
                radarOn = newState
                _G.RAY_FishingRadarOn = radarOn
                refreshRadar()
                if NotifyFeature then
                    NotifyFeature("Fishing Radar", radarOn)
                end
            else
                warn("[Threeblox] Radar toggle failed:", res)
            end
        end)

        refreshRadar()
    end
end


----------------------------------------------------------------
-- STATE GLOBAL POTION
----------------------------------------------------------------
_G.RAYSelectedPotionType = _G.RAYSelectedPotionType or "Luck I Potion"
_G.RAYPotionQty          = _G.RAYPotionQty          or 1

----------------------------------------------------------------
-- BACKEND POTION
----------------------------------------------------------------
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Replion = require(ReplicatedStorage.Packages.Replion)

local ConsumePotionRF = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")
    :WaitForChild("RF/ConsumePotion")

local ConsumeCaveCrystalRF = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")
    :WaitForChild("RF/ConsumeCaveCrystal")

----------------------------------------------------------------
-- MAPPING NAMA POTION -> ID DI INVENTORY (TANPA CAVE CRYSTAL)
----------------------------------------------------------------
local PotionTypeId = {
    ["Luck I Potion"]     = 1,
    ["Luck II Potion"]    = 6,
    ["Mutation I Potion"] = 4,
    ["Love I Potion"]     = 15,
    -- Cave Crystal pakai remote khusus, tidak perlu ID di sini
}

local function GetDataReplion()
    local ok, data = pcall(function()
        local r = Replion.Client:WaitReplion("Data")
        return r.Data
    end)
    if not ok or not data then return nil end
    return data
end

local function findPotionUuidByType(potionName)
    local targetId = PotionTypeId[potionName]
    if not targetId then return nil end

    local data = GetDataReplion()
    if not data then return nil end

    local inv = data.Inventory
    local potions = inv and inv.Potions   -- asumsi potions tersimpan di sini
    if typeof(potions) ~= "table" then return nil end

    for _, entry in pairs(potions) do
        if entry.Id == targetId then
            return entry.UUID
        end
    end
    return nil
end

local function ConsumePotionUUID(uuid, qty)
    if not uuid then return end
    local args = {uuid, qty or 1}
    pcall(function()
        ConsumePotionRF:InvokeServer(unpack(args))
    end)
end

local function ConsumeSelectedPotion()
    local potionName = _G.RAYSelectedPotionType or "Luck I Potion"
    local qty = tonumber(_G.RAYPotionQty) or 1
    if qty < 1 then qty = 1 end

    -- KHUSUS CAVE CRYSTAL: pakai RF/ConsumeCaveCrystal (tanpa UUID)
    if potionName == "Cave Crystal" then
        for i = 1, qty do
            pcall(function()
                ConsumeCaveCrystalRF:InvokeServer()
            end)
        end
        if NotifyFeature then
            NotifyFeature("Consume Cave Crystal x"..qty, true)
        end
        return
    end

    -- POTION BIASA
    local uuid = findPotionUuidByType(potionName)
    if not uuid then
        if NotifyFeature then
            NotifyFeature("Potion "..potionName.." tidak ditemukan", false)
        end
        return
    end

    ConsumePotionUUID(uuid, qty)

    if NotifyFeature then
        NotifyFeature("Consume "..potionName.." x"..qty, true)
    end
end

----------------------------------------------------------------
-- SECTION "POTION PRESET" + PANEL KANAN LIST POTION
----------------------------------------------------------------

local BackpackPage = Pages and Pages["Backpack"]
if BackpackPage then
    local PotionPresetSection = CreateSectionDropdown(BackpackPage, "Potion Preset")

    local ppLayout = Instance.new("UIListLayout")
    ppLayout.Parent    = PotionPresetSection
    ppLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ppLayout.Padding   = UDim.new(0, 6)

    local function makePotionRow(title)
        local row = Instance.new("Frame")
        row.Parent                  = PotionPresetSection
        row.Size                    = UDim2.new(1,0,0,36)
        row.BackgroundTransparency  = 1

        local label = Instance.new("TextLabel")
        label.Parent                = row
        label.Size                  = UDim2.new(1,-110,1,0)
        label.Position              = UDim2.new(0,16,0,0)
        label.BackgroundTransparency= 1
        label.Font                  = Enum.Font.Gotham
        label.TextSize              = 13
        label.TextXAlignment        = Enum.TextXAlignment.Left
        label.TextColor3            = TEXT or THEME_TEXT
        label.Text                  = title

        return row
    end

    ----------------------------------------------------------------
    -- PANEL KANAN LIST POTION (NEMPEL MAIN)
    ----------------------------------------------------------------
    local PotionRightPanel = Instance.new("Frame")
    PotionRightPanel.Name = "PotionRightPanel"
    PotionRightPanel.Size = UDim2.new(0, 220, 1, -46)
    PotionRightPanel.AnchorPoint = Vector2.new(1, 0)
    PotionRightPanel.Position = UDim2.new(1, -10, 0, 40)
    PotionRightPanel.BackgroundColor3 = CARD or Color3.fromRGB(15, 15, 25)
    PotionRightPanel.BackgroundTransparency = 0.25
    PotionRightPanel.BorderSizePixel = 0
    PotionRightPanel.Visible = false
    PotionRightPanel.ZIndex = 10
    PotionRightPanel.Parent = Main or BackpackPage

    Instance.new("UICorner", PotionRightPanel).CornerRadius = UDim.new(0, 10)
    local prStroke = Instance.new("UIStroke", PotionRightPanel)
    prStroke.Color = THEME_MAIN
    prStroke.Transparency = 0.5

    local prTitle = Instance.new("TextLabel")
    prTitle.Parent = PotionRightPanel
    prTitle.Size = UDim2.new(1, -10, 0, 24)
    prTitle.Position = UDim2.new(0, 5, 0, 6)
    prTitle.BackgroundTransparency = 1
    prTitle.Font = Enum.Font.GothamBold
    prTitle.TextSize = 16
    prTitle.TextXAlignment = Enum.TextXAlignment.Left
    prTitle.TextColor3 = THEME_TEXT
    prTitle.ZIndex = 11
    prTitle.Text = "Potion List"

    local prInfo = Instance.new("TextLabel")
    prInfo.Parent = PotionRightPanel
    prInfo.Size = UDim2.new(1, -10, 0, 18)
    prInfo.Position = UDim2.new(0, 5, 0, 30)
    prInfo.BackgroundTransparency = 1
    prInfo.Font = Enum.Font.Gotham
    prInfo.TextSize = 12
    prInfo.TextXAlignment = Enum.TextXAlignment.Left
    prInfo.TextColor3 = Color3.fromRGB(200,200,200)
    prInfo.ZIndex = 11
    prInfo.Text = "Pilih potion dan set quantity."

    local prScroll = Instance.new("ScrollingFrame")
    prScroll.Parent = PotionRightPanel
    prScroll.Size = UDim2.new(1, -10, 1, -70)
    prScroll.Position = UDim2.new(0, 5, 0, 54)
    prScroll.BackgroundTransparency = 1
    prScroll.BorderSizePixel = 0
    prScroll.ScrollBarThickness = 3
    prScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    prScroll.CanvasSize = UDim2.new(0,0,0,0)
    prScroll.ScrollBarImageColor3 = THEME_MAIN
    prScroll.ZIndex = 10

    local prList = Instance.new("UIListLayout", prScroll)
    prList.SortOrder = Enum.SortOrder.LayoutOrder
    prList.Padding = UDim.new(0,4)

    ----------------------------------------------------------------
    -- ENTRY LIST POTION (NAMA SAMA DENGAN MAPPING/UI)
    ----------------------------------------------------------------
    local POTION_NAMES = {
        "Luck I Potion",
        "Luck II Potion",
        "Mutation I Potion",
        "Love I Potion",
        "Cave Crystal",   -- tetap muncul di panel kanan
    }

    local function CreatePotionEntry(potionName)
        local row = Instance.new("Frame")
        row.Parent = prScroll
        row.Size = UDim2.new(1, -4, 0, 24)
        row.BackgroundTransparency = 1
        row.BorderSizePixel = 0
        row.ZIndex = 11

        local line = Instance.new("Frame")
        line.Name = "Highlight"
        line.Parent = row
        line.Size = UDim2.new(0, 3, 1, 0)
        line.Position = UDim2.new(0, 0, 0, 0)
        line.BackgroundColor3 = THEME_MAIN or Color3.fromRGB(170, 90, 255)
        line.BorderSizePixel = 0
        line.Visible = (_G.RAYSelectedPotionType == potionName)
        line.ZIndex = 12

        local btn = Instance.new("TextButton")
        btn.Parent = row
        btn.Size = UDim2.new(1, -6, 1, 0)
        btn.Position = UDim2.new(0, 4, 0, 0)
        btn.BackgroundColor3 = Color3.fromRGB(30,30,50)
        btn.BorderSizePixel = 0
        btn.TextColor3 = THEME_TEXT
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Text = "  " .. potionName
        btn.AutoButtonColor = true
        btn.ZIndex = 11
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

        btn.MouseButton1Click:Connect(function()
            _G.RAYSelectedPotionType = potionName

            for _, child in ipairs(prScroll:GetChildren()) do
                if child:IsA("Frame") then
                    local hl = child:FindFirstChild("Highlight")
                    if hl and hl:IsA("Frame") then
                        hl.Visible = (child == row)
                    end
                end
            end

            if NotifyFeature then
                NotifyFeature("Selected "..potionName, true)
            end
        end)
    end

    local function rebuildPotionPanel()
        for _, c in ipairs(prScroll:GetChildren()) do
            if c:IsA("Frame") and c ~= prList then
                c:Destroy()
            end
        end
        for _, name in ipairs(POTION_NAMES) do
            CreatePotionEntry(name)
        end
    end

    rebuildPotionPanel()

    ----------------------------------------------------------------
    -- ROW: QUANTITY INPUT + BUTTON CONSUME
    ----------------------------------------------------------------
    do
        local row = makePotionRow("Potion Quantity")

        local qtyBox = Instance.new("TextBox")
        qtyBox.Parent = row
        qtyBox.Size = UDim2.new(0,60,0,24)
        qtyBox.Position = UDim2.new(1,-150,0.5,-12)
        qtyBox.BackgroundColor3 = CARD or Color3.fromRGB(40,40,60)
        qtyBox.BackgroundTransparency = 0.1
        qtyBox.Text = tostring(_G.RAYPotionQty or 1)
        qtyBox.TextColor3 = THEME_TEXT
        qtyBox.Font = Enum.Font.Gotham
        qtyBox.TextSize = 12
        qtyBox.ClearTextOnFocus = false
        Instance.new("UICorner", qtyBox).CornerRadius = UDim.new(0,8)

        qtyBox.FocusLost:Connect(function(enterPressed)
            local n = tonumber(qtyBox.Text)
            if not n or n < 1 then
                n = 1
                qtyBox.Text = "1"
            end
            _G.RAYPotionQty = n
            if enterPressed and NotifyFeature then
                NotifyFeature("Set potion qty: "..n, true)
            end
        end)

        local useBtn = Instance.new("TextButton")
        useBtn.Parent = row
        useBtn.Size = UDim2.new(0,80,0,24)
        useBtn.Position = UDim2.new(1,-60,0.5,-12)
        useBtn.BackgroundColor3 = CARD or Color3.fromRGB(40,40,60)
        useBtn.BackgroundTransparency = 0.1
        useBtn.Text = "Use"
        useBtn.TextColor3 = THEME_TEXT
        useBtn.Font = Enum.Font.GothamBold
        useBtn.TextSize = 12
        useBtn.AutoButtonColor = true
        Instance.new("UICorner", useBtn).CornerRadius = UDim.new(0,8)

        useBtn.MouseButton1Click:Connect(function()
            ConsumeSelectedPotion()
        end)
    end

    ----------------------------------------------------------------
    -- ROW BUKA PANEL POTION LIST
    ----------------------------------------------------------------
    do
        local row = makePotionRow("Potion List Panel")

        local btn = Instance.new("TextButton")
        btn.Parent = row
        btn.Size = UDim2.new(0,120,0,24)
        btn.Position = UDim2.new(1,-136,0.5,-12)
        btn.BackgroundColor3 = CARD or Color3.fromRGB(40,40,60)
        btn.BackgroundTransparency = 0.1
        btn.Text = "Open"
        btn.TextColor3 = THEME_TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.AutoButtonColor = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

        btn.MouseButton1Click:Connect(function()
            PotionRightPanel.Visible = not PotionRightPanel.Visible
            if PotionRightPanel.Visible then
                rebuildPotionPanel()
            end
        end)
    end

    ----------------------------------------------------------------
    -- CLOSE PANEL DARI KLIK DI LUAR (OPSIONAL)
    ----------------------------------------------------------------
    UIS.InputBegan:Connect(function(input)
        if not PotionRightPanel.Visible then return end

        if input.UserInputType ~= Enum.UserInputType.MouseButton1
        and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local pos = input.Position
        local absPos = PotionRightPanel.AbsolutePosition
        local absSize = PotionRightPanel.AbsoluteSize

        local inside =
            pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
            pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y

        if not inside then
            PotionRightPanel.Visible = false
        end
    end)
end

----------------------------------------------------------------
-- ENCHANT PRESET (BACKEND + UI, MIRIP POTION / AUTO SELL)
----------------------------------------------------------------

-----------------------------
-- STATE GLOBAL
-----------------------------
_G.RAY_EnchantAutoOn      = _G.RAY_EnchantAutoOn      or false
_G.RAY_EnchantTargetSlot  = _G.RAY_EnchantTargetSlot  or 1      -- 1 = altar slot 1, 2 = altar slot 2
_G.RAY_EnchantStoneId     = _G.RAY_EnchantStoneId     or 10     -- Id batu dari StoneConfig
_G.RAY_EnchantTargetName  = _G.RAY_EnchantTargetName  or "Leprechaun I"

-----------------------------
-- KONFIG BATU & ENCHANT
-----------------------------
local StoneConfig = {
    [10] = {
        Name = "Enchant Stone",
        Slot = 1,
        Enchants = {
            "Leprechaun I",
            "Leprechaun II",
            "Mutation Hunter I",
            "Mutation Hunter II",
            "Gold Digger I",
            "Reeler I",
            "Big Hunter I",
            "Empowered I",
            "Glistening I",
            "Stargazer I",
            "Stormhunter I",
            "XPerienced I",
            "Cursed I",
            "Prismatic I",
        },
    },
    [125] = {
        Name = "Super Enchant Stone",
        Slot = 1,
        Enchants = {
            "Leprechaun II",
            "Mutation Hunter II",
            "Empowered I",
            "Cursed I",
            "Prismatic I",
        },
    },
    [558] = {
        Name = "Evolved Enchant Stone",
        Slot = 1,
        Enchants = {
            "Leprechaun II",
            "Mutation Hunter II",
            "Mutation Hunter III",
            "Reeler II",
            "Gold Digger I",
            "Fairy Hunter I",      -- kalau ini ga ada di Enchants, tinggal hapus
            "Stargazer II",
            "Stormhunter II",
            "Empowered I",
            "Cursed I",
            "Prismatic I",
            "Shark Hunter",
            "SECRET Hunter",
        },
    },
    [246] = {
        Name   = "Transcended Stone",
        Slot   = 2,
        Second = true,
        Enchants = {
            "Perfection",
            "Leprechaun I",
            "Leprechaun II",
            "Mutation Hunter I",
            "Mutation Hunter II",
            "Gold Digger I",
            "Reeler I",
            "Big Hunter I",
            "Empowered I",
            "Glistening I",
            "Stargazer I",
            "Stormhunter I",
            "XPerienced I",
            "Cursed I",
            "Prismatic I",
        },
    },
}

local StoneList = {10, 125, 558, 246}

----------------------------------------------------------------
-- MAPPING ENCHANT ID -> NAMA (URUT ABJAD NAMA)
----------------------------------------------------------------

local EnchantIdToName = {
    [3]  = "Big Hunter I",
    [12] = "Cursed I",
    [9]  = "Empowered I",
    [4]  = "Gold Digger I",
    [1]  = "Glistening I",
    [24] = "Glistening II",
    [5]  = "Leprechaun I",
    [6]  = "Leprechaun II",
    [7]  = "Mutation Hunter I",
    [14] = "Mutation Hunter II",
    [22] = "Mutation Hunter III",
    [15] = "Perfection",
    [13] = "Prismatic I",
    [2]  = "Reeler I",
    [21] = "Reeler II",
    [16] = "SECRET Hunter",
    [20] = "Shark Hunter",
    [8]  = "Stargazer I",
    [17] = "Stargazer II",
    [11] = "Stormhunter I",
    [19] = "Stormhunter II",
    [10] = "XPerienced I",
}

local function getEnchantNameFromId(id)
    return EnchantIdToName[id]
end

-----------------------------
-- BACKEND: REMOTE & REPLION
-----------------------------
local RS      = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player  = Players.LocalPlayer
local Replion = require(RS.Packages.Replion)
local Net     = require(RS.Packages.Net)

-- CFrame altar (punya kamu)
local CF_Altar_Slot1 = CFrame.new(
    3232.90356, -1302.8551, 1401.0824,
    0.483647138, 0, -0.875263095,
    0, 1, 0,
    0.875263095, 0, 0.483647138
)

local CF_Altar_Slot2 = CFrame.new(
    1486.06165, 127.624977, -590.121094,
    0.998732686, 0, 0.0503287315,
    0, 1, 0,
    -0.0503287315, 0, 0.998732686
)

local function TpAltar(slot)
    local cf  = slot == 2 and CF_Altar_Slot2 or CF_Altar_Slot1
    local chr = Player.Character or Player.CharacterAdded:Wait()
    local hrp = chr:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = cf
        if NotifyFeature then
            NotifyFeature("TP Altar Slot "..tostring(slot), true)
        end
    end
end

local function GetMainData()
    local ok, r = pcall(function()
        return Replion.Client:WaitReplion("Data")
    end)
    if not ok or not r or not r.Data then
        return nil
    end
    return r.Data
end

----------------------------------------------------------------
-- AUTO EQUIP BATU DI HAND (PAKAI ID -> UUID)
----------------------------------------------------------------

local EquipItemRE = RS
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")
    :WaitForChild("RE/EquipItem")

local EquipToolFromHotbarRE = RS
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")
    :WaitForChild("RE/EquipToolFromHotbar")

local function EquipFromHotbar2()
    pcall(function()
        EquipToolFromHotbarRE:FireServer(2)
    end)
end

local function findStoneEntryById(stoneId)
    local data = GetMainData()
    if not data then return nil end

    local inv   = data.Inventory
    local items = inv and inv.Items
    if typeof(items) ~= "table" then return nil end

    for _, entry in pairs(items) do
        if entry.Id == stoneId then
            return entry
        end
    end
    return nil
end

local function EquipStoneById(stoneId)
    local entry = findStoneEntryById(stoneId)
    if not entry then
        if NotifyFeature then
            NotifyFeature("Stone Id "..tostring(stoneId).." tidak ditemukan di inventory", false)
        end
        return
    end

    local uuid = entry.UUID or entry.Uuid
    if not uuid then return end

    local category = "Enchant Stones"

    pcall(function()
        EquipItemRE:FireServer(uuid, category)
    end)

    if NotifyFeature then
        NotifyFeature("Equip Stone Id "..tostring(stoneId), true)
    end
end

----------------------------------------------------------------
-- AUTO STOP BERDASARKAN WINNING ENCHANT (ROLLENCHANT REMOTEEVENT)
----------------------------------------------------------------

local RollEnchantRE = Net:RemoteEvent("RollEnchant")

local TargetName  = _G.RAY_EnchantTargetName
local TargetId    = nil

local function refreshTarget()
    TargetName = _G.RAY_EnchantTargetName
    -- kalau kamu mau pakai ID langsung: tinggal bikin tabel Name->Id
    TargetId   = nil
    for id, name in pairs(EnchantIdToName) do
        if name == TargetName then
            TargetId = id
            break
        end
    end
    print("[EnchantDebug] TargetName =", TargetName, "TargetId =", TargetId)
end

refreshTarget()

_G.RAY_EnchantTargetChanged = function()
    refreshTarget()
end

RollEnchantRE.OnClientEvent:Connect(function(_, _, winningEnchantId, stoneId)
    -- arg1, arg2 tidak kita pakai; arg3 = winning enchant id, arg4 = stone id
    print("[EnchantDebug] RollEnchant winId =", winningEnchantId, "stoneId =", stoneId)
    if _G.RAY_EnchantAutoOn and TargetId and winningEnchantId == TargetId then
        _G.RAY_EnchantAutoOn = false
        if NotifyFeature then
            NotifyFeature("Stop: dapet "..tostring(TargetName), true)
        end
    end
end)

----------------------------------------------------------------
-- ENCHANTINGCONTROLLER
----------------------------------------------------------------
local EnchantingController = require(RS.Controllers.EnchantingController)

local function DoAltarEnchantOnce()
    local second = (_G.RAY_EnchantTargetSlot == 2)

    task.spawn(function()
        print("[EnchantDebug] DoAltarEnchantOnce, second =", second, "stoneId =", _G.RAY_EnchantStoneId)

        EquipFromHotbar2()
        task.wait(0.2)

        local stoneId = _G.RAY_EnchantStoneId
        if stoneId then
            EquipStoneById(stoneId)
            task.wait(0.2)
        end

        local ok, result = pcall(function()
            return EnchantingController:Activate(second)
                :catch(function(msg)
                    warn("[EnchantDebug] Activate catch:", msg)
                    if NotifyFeature then
                        NotifyFeature("Enchant error: "..tostring(msg), false)
                    end
                end)
                :await()
        end)

        if not ok then
            warn("[EnchantDebug] pcall Activate error:", result)
            if NotifyFeature then
                NotifyFeature("Enchant failed (pcall)", false)
            end
        else
            print("[EnchantDebug] Activate ok, result =", result)
            if NotifyFeature then
                NotifyFeature("Enchant roll", true)
            end
        end
    end)
end

----------------------------------------------------------------
-- LOOP AUTO ENCHANT: TIDAK CEK INVENTORY, HANYA SPAM ACTIVATE
-- STOP DIHOOK DARI RollEnchantRE (lihat handler di atas)
----------------------------------------------------------------
task.spawn(function()
    while true do
        if _G.RAY_EnchantAutoOn then
            DoAltarEnchantOnce()
        end
        task.wait(0.8)
    end
end)

----------------------------------------------------------------
-- SECTION "ENCHANT PRESET" + PANEL KANAN
----------------------------------------------------------------

local BackpackPage = Pages and Pages["Backpack"]
if not BackpackPage then return end

local EnchantPresetSection = CreateSectionDropdown(BackpackPage, "Enchant Preset")

local layout = Instance.new("UIListLayout")
layout.Parent    = EnchantPresetSection
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding   = UDim.new(0, 6)

local note = Instance.new("TextLabel")
note.Parent                 = EnchantPresetSection
note.Size                   = UDim2.new(1, -20, 0, 18)
note.Position               = UDim2.new(0, 10, 0, 0)
note.BackgroundTransparency = 1
note.Font                   = Enum.Font.Gotham
note.TextSize               = 11
note.TextXAlignment         = Enum.TextXAlignment.Left
note.TextColor3             = Color3.fromRGB(255, 200, 120)
note.Text                   = "NOTE: Taruh batu enchant di slot kanan tas (hotbar 2)."

local function makeRow(title, height)
    local row = Instance.new("Frame")
    row.Parent                 = EnchantPresetSection
    row.Size                   = UDim2.new(1,0,0,height or 36)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel")
    label.Parent                 = row
    label.Size                   = UDim2.new(1,-110,1,0)
    label.Position               = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font                   = Enum.Font.Gotham
    label.TextSize               = 13
    label.TextXAlignment         = Enum.TextXAlignment.Left
    label.TextColor3             = TEXT or THEME_TEXT
    label.Text                   = title

    return row
end

local function makeSmallButton(row, text)
    local btn = Instance.new("TextButton")
    btn.Parent                 = row
    btn.Size                   = UDim2.new(0,120,0,24)
    btn.Position               = UDim2.new(1,-136,0.5,-12)
    btn.BackgroundColor3       = CARD or Color3.fromRGB(40,40,60)
    btn.BackgroundTransparency = 0.1
    btn.Text                   = text
    btn.TextColor3             = THEME_TEXT
    btn.Font                   = Enum.Font.GothamBold
    btn.TextSize               = 12
    btn.AutoButtonColor        = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    return btn
end

----------------------------------------------------------------
-- PANEL KANAN: STONE LIST
----------------------------------------------------------------
local StoneRightPanel = Instance.new("Frame")
StoneRightPanel.Name                   = "StoneRightPanel"
StoneRightPanel.Size                   = UDim2.new(0, 220, 1, -46)
StoneRightPanel.AnchorPoint            = Vector2.new(1, 0)
StoneRightPanel.Position               = UDim2.new(1, -10, 0, 40)
StoneRightPanel.BackgroundColor3       = CARD or Color3.fromRGB(15, 15, 25)
StoneRightPanel.BackgroundTransparency = 0.25
StoneRightPanel.BorderSizePixel        = 0
StoneRightPanel.Visible                = false
StoneRightPanel.ZIndex                 = 10
StoneRightPanel.Parent                 = Main

Instance.new("UICorner", StoneRightPanel).CornerRadius = UDim.new(0, 10)
local stStroke = Instance.new("UIStroke", StoneRightPanel)
stStroke.Color        = THEME_MAIN
stStroke.Transparency = 0.5

local stTitle = Instance.new("TextLabel")
stTitle.Parent                 = StoneRightPanel
stTitle.Size                   = UDim2.new(1, -10, 0, 24)
stTitle.Position               = UDim2.new(0, 5, 0, 6)
stTitle.BackgroundTransparency = 1
stTitle.Font                   = Enum.Font.GothamBold
stTitle.TextSize               = 16
stTitle.TextXAlignment         = Enum.TextXAlignment.Left
stTitle.TextColor3             = THEME_TEXT
stTitle.ZIndex                 = 11
stTitle.Text                   = "Stone List"

local stInfo = Instance.new("TextLabel")
stInfo.Parent                 = StoneRightPanel
stInfo.Size                   = UDim2.new(1, -10, 0, 18)
stInfo.Position               = UDim2.new(0, 5, 0, 30)
stInfo.BackgroundTransparency = 1
stInfo.Font                   = Enum.Font.Gotham
stInfo.TextSize               = 12
stInfo.TextXAlignment         = Enum.TextXAlignment.Left
stInfo.TextColor3             = Color3.fromRGB(200,200,200)
stInfo.ZIndex                 = 11
stInfo.Text                   = "Pilih batu enchant untuk slot."

local stScroll = Instance.new("ScrollingFrame")
stScroll.Parent                 = StoneRightPanel
stScroll.Size                   = UDim2.new(1, -10, 1, -70)
stScroll.Position               = UDim2.new(0, 5, 0, 54)
stScroll.BackgroundTransparency = 1
stScroll.BorderSizePixel        = 0
stScroll.ScrollBarThickness     = 3
stScroll.AutomaticCanvasSize    = Enum.AutomaticSize.Y
stScroll.CanvasSize             = UDim2.new(0,0,0,0)
stScroll.ScrollBarImageColor3   = THEME_MAIN
stScroll.ZIndex                 = 10

local stList = Instance.new("UIListLayout", stScroll)
stList.SortOrder = Enum.SortOrder.LayoutOrder
stList.Padding   = UDim.new(0, 4)

local function rebuildStonePanel()
    for _, c in ipairs(stScroll:GetChildren()) do
        if c:IsA("Frame") and c ~= stList then
            c:Destroy()
        end
    end

    local list = StoneList or {}
    for _, id in ipairs(list) do
        local cfg = StoneConfig[id]
        if cfg then
            local row = Instance.new("Frame")
            row.Parent                 = stScroll
            row.Size                   = UDim2.new(1, -4, 0, 24)
            row.BackgroundTransparency = 1
            row.BorderSizePixel        = 0
            row.ZIndex                 = 11

            local line = Instance.new("Frame")
            line.Name             = "Highlight"
            line.Parent           = row
            line.Size             = UDim2.new(0, 3, 1, 0)
            line.Position         = UDim2.new(0, 0, 0, 0)
            line.BackgroundColor3 = THEME_MAIN or Color3.fromRGB(170, 90, 255)
            line.BorderSizePixel  = 0
            line.Visible          = (_G.RAY_EnchantStoneId == id)
            line.ZIndex           = 12

            local btn = Instance.new("TextButton")
            btn.Parent                 = row
            btn.Size                   = UDim2.new(1, -6, 1, 0)
            btn.Position               = UDim2.new(0, 4, 0, 0)
            btn.BackgroundColor3       = Color3.fromRGB(30,30,50)
            btn.BorderSizePixel        = 0
            btn.TextColor3             = THEME_TEXT
            btn.Font                   = Enum.Font.Gotham
            btn.TextSize               = 12
            btn.TextXAlignment         = Enum.TextXAlignment.Left
            btn.Text                   = string.format("  %s (Id %d)", cfg.Name, id)
            btn.AutoButtonColor        = true
            btn.ZIndex                 = 11
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

            btn.MouseButton1Click:Connect(function()
                _G.RAY_EnchantStoneId    = id
                _G.RAY_EnchantTargetName = cfg.Enchants[1] or _G.RAY_EnchantTargetName
                if _G.RAY_EnchantTargetChanged then
                    _G.RAY_EnchantTargetChanged()
                end
                if NotifyFeature then
                    NotifyFeature("Enchant Stone: "..cfg.Name, true)
                end
                rebuildStonePanel()
                rebuildEnchantPanel()
            end)
        end
    end
end

----------------------------------------------------------------
-- PANEL KANAN: ENCHANT LIST
----------------------------------------------------------------
local EnchantRightPanel = Instance.new("Frame")
EnchantRightPanel.Name                   = "EnchantRightPanel"
EnchantRightPanel.Size                   = UDim2.new(0, 220, 1, -46)
EnchantRightPanel.AnchorPoint            = Vector2.new(1, 0)
EnchantRightPanel.Position               = UDim2.new(1, -10, 0, 40)
EnchantRightPanel.BackgroundColor3       = CARD or Color3.fromRGB(15, 15, 25)
EnchantRightPanel.BackgroundTransparency = 0.25
EnchantRightPanel.BorderSizePixel        = 0
EnchantRightPanel.Visible                = false
EnchantRightPanel.ZIndex                 = 10
EnchantRightPanel.Parent                 = Main

Instance.new("UICorner", EnchantRightPanel).CornerRadius = UDim.new(0, 10)
local enStroke = Instance.new("UIStroke", EnchantRightPanel)
enStroke.Color        = THEME_MAIN
enStroke.Transparency = 0.5

local enTitle = Instance.new("TextLabel")
enTitle.Parent                 = EnchantRightPanel
enTitle.Size                   = UDim2.new(1, -10, 0, 24)
enTitle.Position               = UDim2.new(0, 5, 0, 6)
enTitle.BackgroundTransparency = 1
enTitle.Font                   = Enum.Font.GothamBold
enTitle.TextSize               = 16
enTitle.TextXAlignment         = Enum.TextXAlignment.Left
enTitle.TextColor3             = THEME_TEXT
enTitle.ZIndex                 = 11
enTitle.Text                   = "Enchant List"

local enInfo = Instance.new("TextLabel")
enInfo.Parent                 = EnchantRightPanel
enInfo.Size                   = UDim2.new(1, -10, 0, 18)
enInfo.Position               = UDim2.new(0, 5, 0, 30)
enInfo.BackgroundTransparency = 1
enInfo.Font                   = Enum.Font.Gotham
enInfo.TextSize               = 12
enInfo.TextXAlignment         = Enum.TextXAlignment.Left
enInfo.TextColor3             = Color3.fromRGB(200,200,200)
enInfo.ZIndex                 = 11
enInfo.Text                   = "Pilih enchant target sesuai batu."

local enScroll = Instance.new("ScrollingFrame")
enScroll.Parent                 = EnchantRightPanel
enScroll.Size                   = UDim2.new(1, -10, 1, -70)
enScroll.Position               = UDim2.new(0, 5, 0, 54)
enScroll.BackgroundTransparency = 1
enScroll.BorderSizePixel        = 0
enScroll.ScrollBarThickness     = 3
enScroll.AutomaticCanvasSize    = Enum.AutomaticSize.Y
enScroll.CanvasSize             = UDim2.new(0,0,0,0)
enScroll.ScrollBarImageColor3   = THEME_MAIN
enScroll.ZIndex                 = 10

local enList = Instance.new("UIListLayout", enScroll)
enList.SortOrder = Enum.SortOrder.LayoutOrder
enList.Padding   = UDim.new(0, 4)

local function getCurrentEnchantList()
    local cfg = StoneConfig[_G.RAY_EnchantStoneId]
    return cfg and cfg.Enchants or {}
end

function rebuildEnchantPanel()
    for _, c in ipairs(enScroll:GetChildren()) do
        if c:IsA("Frame") and c ~= enList then
            c:Destroy()
        end
    end

    local list = getCurrentEnchantList()
    for _, name in ipairs(list) do
        local row = Instance.new("Frame")
        row.Parent                 = enScroll
        row.Size                   = UDim2.new(1, -4, 0, 24)
        row.BackgroundTransparency = 1
        row.BorderSizePixel        = 0
        row.ZIndex                 = 11

        local line = Instance.new("Frame")
        line.Name             = "Highlight"
        line.Parent           = row
        line.Size             = UDim2.new(0, 3, 1, 0)
        line.Position         = UDim2.new(0, 0, 0, 0)
        line.BackgroundColor3 = THEME_MAIN or Color3.fromRGB(170, 90, 255)
        line.BorderSizePixel  = 0
        line.Visible          = (_G.RAY_EnchantTargetName == name)
        line.ZIndex           = 12

        local btn = Instance.new("TextButton")
        btn.Parent                 = row
        btn.Size                   = UDim2.new(1, -6, 1, 0)
        btn.Position               = UDim2.new(0, 4, 0, 0)
        btn.BackgroundColor3       = Color3.fromRGB(30,30,50)
        btn.BorderSizePixel        = 0
        btn.TextColor3             = THEME_TEXT
        btn.Font                   = Enum.Font.Gotham
        btn.TextSize               = 12
        btn.TextXAlignment         = Enum.TextXAlignment.Left
        btn.Text                   = "  "..name
        btn.AutoButtonColor        = true
        btn.ZIndex                 = 11
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

        btn.MouseButton1Click:Connect(function()
            _G.RAY_EnchantTargetName = name
            if _G.RAY_EnchantTargetChanged then
                _G.RAY_EnchantTargetChanged()
            end
            if NotifyFeature then
                NotifyFeature("Target Enchant: "..name, true)
            end
            rebuildEnchantPanel()
        end)
    end
end

rebuildStonePanel()
rebuildEnchantPanel()

----------------------------------------------------------------
-- ROW: TARGET SLOT (altar slot 1 / 2)
----------------------------------------------------------------
do
    local row = makeRow("Target Slot")

    local btn1 = Instance.new("TextButton")
    btn1.Parent                 = row
    btn1.Size                   = UDim2.new(0, 60, 0, 24)
    btn1.Position               = UDim2.new(1, -130, 0.5, -12)
    btn1.BackgroundColor3       = CARD or Color3.fromRGB(40,40,60)
    btn1.BackgroundTransparency = 0.1
    btn1.TextColor3             = THEME_TEXT
    btn1.Font                   = Enum.Font.Gotham
    btn1.TextSize               = 12
    btn1.Text                   = "Slot 1"
    btn1.AutoButtonColor        = true
    Instance.new("UICorner", btn1).CornerRadius = UDim.new(0,8)

    local btn2 = Instance.new("TextButton")
    btn2.Parent                 = row
    btn2.Size                   = UDim2.new(0, 60, 0, 24)
    btn2.Position               = UDim2.new(1, -65, 0.5, -12)
    btn2.BackgroundColor3       = CARD or Color3.fromRGB(40,40,60)
    btn2.BackgroundTransparency = 0.1
    btn2.TextColor3             = THEME_TEXT
    btn2.Font                   = Enum.Font.Gotham
    btn2.TextSize               = 12
    btn2.Text                   = "Slot 2"
    btn2.AutoButtonColor        = true
    Instance.new("UICorner", btn2).CornerRadius = UDim.new(0,8)

    local function refreshSlot()
        local slot = _G.RAY_EnchantTargetSlot or 1
        btn1.BackgroundColor3 = (slot == 1)
            and (ACCENT or Color3.fromRGB(0,200,150))
            or  (CARD   or Color3.fromRGB(40,40,60))
        btn2.BackgroundColor3 = (slot == 2)
            and (ACCENT or Color3.fromRGB(0,200,150))
            or  (CARD   or Color3.fromRGB(40,40,60))
    end

    btn1.MouseButton1Click:Connect(function()
        _G.RAY_EnchantTargetSlot = 1
        if NotifyFeature then
            NotifyFeature("Target Slot 1", true)
        end
        refreshSlot()
    end)

    btn2.MouseButton1Click:Connect(function()
        _G.RAY_EnchantTargetSlot = 2
        if NotifyFeature then
            NotifyFeature("Target Slot 2", true)
        end
        refreshSlot()
    end)

    refreshSlot()
end

----------------------------------------------------------------
-- ROW: OPEN STONE PANEL
----------------------------------------------------------------
do
    local row = makeRow("Stone List Panel")
    local btn = makeSmallButton(row, "Open")
    btn.MouseButton1Click:Connect(function()
        StoneRightPanel.Visible = not StoneRightPanel.Visible
        if StoneRightPanel.Visible then
            rebuildStonePanel()
        end
    end)
end

----------------------------------------------------------------
-- ROW: OPEN ENCHANT PANEL
----------------------------------------------------------------
do
    local row = makeRow("Enchant List Panel")
    local btn = makeSmallButton(row, "Open")
    btn.MouseButton1Click:Connect(function()
        EnchantRightPanel.Visible = not EnchantRightPanel.Visible
        if EnchantRightPanel.Visible then
            rebuildEnchantPanel()
        end
    end)
end

----------------------------------------------------------------
-- ROW: TOGGLE AUTO ENCHANT
----------------------------------------------------------------
do
    local row = makeRow("Auto Enchant")

    local pill = Instance.new("TextButton")
    pill.Parent                 = row
    pill.Size                   = UDim2.new(0, 50, 0, 24)
    pill.Position               = UDim2.new(1, -80, 0.5, -12)
    pill.BackgroundColor3       = MUTED or Color3.fromRGB(70,70,90)
    pill.BackgroundTransparency = 0.1
    pill.Text                   = ""
    pill.AutoButtonColor        = false
    Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

    local knob = Instance.new("Frame")
    knob.Parent                 = pill
    knob.Size                   = UDim2.new(0,18,0,18)
    knob.Position               = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3       = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local function refreshAuto()
        local on = _G.RAY_EnchantAutoOn
        pill.BackgroundColor3 = on
            and (ACCENT or Color3.fromRGB(0,200,150))
            or  (MUTED  or Color3.fromRGB(70,70,90))
        knob.Position = on
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        _G.RAY_EnchantAutoOn = not _G.RAY_EnchantAutoOn
        print("[EnchantDebug] AutoOn =", _G.RAY_EnchantAutoOn)
        refreshAuto()
        if NotifyFeature then
            NotifyFeature("Auto Enchant", _G.RAY_EnchantAutoOn)
        end
    end)

    refreshAuto()
end

----------------------------------------------------------------
-- ROW: TELEPORT ALTAR
----------------------------------------------------------------
do
    local row = makeRow("Teleport Altar")

    local btn1 = Instance.new("TextButton")
    btn1.Parent                 = row
    btn1.Size                   = UDim2.new(0, 80, 0, 24)
    btn1.Position               = UDim2.new(1, -170, 0.5, -12)
    btn1.BackgroundColor3       = CARD or Color3.fromRGB(40,40,60)
    btn1.BackgroundTransparency = 0.1
    btn1.Text                   = "Esoteric"
    btn1.TextColor3             = THEME_TEXT
    btn1.Font                   = Enum.Font.GothamBold
    btn1.TextSize               = 12
    btn1.AutoButtonColor        = true
    Instance.new("UICorner", btn1).CornerRadius = UDim.new(0,8)

    local btn2 = Instance.new("TextButton")
    btn2.Parent                 = row
    btn2.Size                   = UDim2.new(0, 80, 0, 24)
    btn2.Position               = UDim2.new(1, -85, 0.5, -12)
    btn2.BackgroundColor3       = CARD or Color3.fromRGB(40,40,60)
    btn2.BackgroundTransparency = 0.1
    btn2.Text                   = "Temple"
    btn2.TextColor3             = THEME_TEXT
    btn2.Font                   = Enum.Font.GothamBold
    btn2.TextSize               = 12
    btn2.AutoButtonColor        = true
    Instance.new("UICorner", btn2).CornerRadius = UDim.new(0,8)

    btn1.MouseButton1Click:Connect(function()
        TpAltar(1)
    end)

    btn2.MouseButton1Click:Connect(function()
        TpAltar(2)
    end)
end

----------------------------------------------------------------
-- CLOSE PANEL DARI KLIK DI LUAR (STONE + ENCHANT)
----------------------------------------------------------------
UIS.InputBegan:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
       and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local function outside(panel)
        if not panel or not panel.Visible then return false end
        local pos    = input.Position
        local absPos = panel.AbsolutePosition
        local absSize= panel.AbsoluteSize
        local inside =
            pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
            pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y
        return not inside
    end

    if outside(StoneRightPanel) then
        StoneRightPanel.Visible = false
    end
    if outside(EnchantRightPanel) then
        EnchantRightPanel.Visible = false
    end
end)

----------------------------------------------------------------
-- DATA: TELEPORT ISLAND (MAP NAME -> CFrame)
----------------------------------------------------------------

local IslandTeleportCF = {
    ["Arrow Artifact"] = CFrame.new(879.857178, 4.92162275, -339.661469,
        -0.195367768, 0, 0.980730057,
        0, 1, 0,
        -0.980730057, 0, -0.195367768
    ),

    ["Crescent Artifact"] = CFrame.new(1382.48401, 4.83972979, 113.104294,
        -0.956645668, 0, 0.291254193,
        0, 1, 0,
        -0.291254193, 0, -0.956645668
    ),

    ["Diamond Artifact"] = CFrame.new(1835.33704, 4.92876816, -314.988342,
        0.219969183, 0, -0.975506842,
        0, 1, 0,
        0.975506842, 0, 0.219969183
    ),

    ["Heartfelt Island"] = CFrame.new(1112.6106, 4.84564829, 2719.63818,
        -0.0125409178, -5.2643145e-08, -0.999921381,
        -1.06123528e-08, 1, -5.2514185e-08,
        0.999921381, 9.95294158e-09, -0.0125409178
    ),

    ["Hourglass Diamond Artifact"] = CFrame.new(1500.73413, 6.37703848, -849.561951,
        -0.983483791, 0, -0.180996269,
        0, 1, 0,
        0.180996269, 0, -0.983483791
    ),

    ["Ancient Jungle"] = CFrame.new(1470.92688, 4.58799648, -323.604401,
        -0.240510166, 0, -0.97064662,
        0, 1, 0,
        0.97064662, 0, -0.240510166
    ),

    ["Ancient Ruin"] = CFrame.new(6082.87842, -585.924316, 4633.71631,
        -0.681475937, 0, 0.731840551,
        0, 1, 0,
        -0.731840551, 0, -0.681475937
    ),

    ["Cavern Volcanic 1"] = CFrame.new(1258.64758, 83.4165039, -10248.0986,
        0.00370242121, -1.42619994e-09, 0.999993145,
        -5.48521122e-14, 1, 1.42620993e-09,
        -0.999993145, -5.3352817e-12, 0.00370242121
    ),

    ["Cavern Volcanic 2"] = CFrame.new(1106.69495, 86.072998, -10248.0986,
        -0.00201654364, -2.72424678e-08, 0.999997973,
        -5.50374711e-11, 1, 2.72424128e-08,
        -0.999997973, -1.01846327e-13, -0.00201654364
    ),

    ["Coral Reefs"] = CFrame.new(-2917.92163, 3.24999928, 2073.65894,
        0.185246676, 0, 0.982692063,
        0, 1, 0,
        -0.982692063, 0, 0.185246676
    ),

    ["Crater Island"] = CFrame.new(1021.73822, 22.0761662, 5075.62207,
        0.110775813, 0, -0.993845403,
        0, 1, 0,
        0.993845403, 0, 0.110775813
    ),

    ["Crystalline Passage"] = CFrame.new(6050.46533, -538.900208, 4374.14404,
        -0.999980807, 0, 0.00619776407,
        0, 1, 0,
        -0.00619776407, 0, -0.999980807
    ),

    ["Crystal Depths"] = CFrame.new(5816.59766, -905.712524, 15416.5459,
        0.653240383, 0, -0.75715059,
        0, 1, 0,
        0.75715059, 0, 0.653240383
    ),

    ["Esoteric Depths"] = CFrame.new(3232.90356, -1302.8551, 1401.0824,
        0.483647138, 0, -0.875263095,
        0, 1, 0,
        0.875263095, 0, 0.483647138
    ),

    ["Fisherman Spawn"] = CFrame.new(94.4113464, 17.0335178, 2832.35474,
        0.997892678, 0, 0.0648857802,
        0, 1, 0,
        -0.0648857802, 0, 0.997892678
    ),

    ["Kohana"] = CFrame.new(-661.520142, 17.2500553, 525.53125,
        0.379789084, -3.69101372e-08, -0.925073087,
        -4.96903567e-08, 1, -6.03000885e-08,
        0.925073087, 6.88685304e-08, 0.379789084
    ),

    ["Kohana Volcano"] = CFrame.new(-615.731567, 48.5698662, 189.133865,
        0.256806821, 0, 0.966462731,
        0, 1, 0,
        -0.966462731, 0, 0.256806821
    ),

    ["Lava Basin"] = CFrame.new(893.590942, 89.0328979, -10196.835,
        -0.435751051, 6.88466599e-08, -0.90006721,
        -2.40178668e-08, 1, 8.81183837e-08,
        0.90006721, 6.0015374e-08, -0.435751051
    ),

    ["Maze Room"] = CFrame.new(3439.70679, -287.844818, 3390.59546,
        -0.96200937, 0, -0.273016393,
        0, 1, 0,
        0.273016393, 0, -0.96200937
    ),

    ["Pirate Cove"] = CFrame.new(3408.83179, 3.73505521, 3444.31812,
        -0.76647383, 0, -0.642275512,
        0, 1, 0,
        0.642275512, 0, -0.76647383
    ),

    ["Pirate Cove Leviathan"] = CFrame.new(3471.53125, -287.84317, 3474.38257,
        -0.962593496, 0, -0.270949841,
        0, 1, 0,
        0.270949841, 0, -0.962593496
    ),

    ["Pirate Treasure Room"] = CFrame.new(3291.12646, -299.092438, 3068.04639,
        0.483647138, 0, -0.875263095,
        0, 1, 0,
        0.875263095, 0, 0.483647138
    ),

    ["Sacred Temple"] = CFrame.new(1496.13306, -22.1250019, -639.212097,
        0.987680018, 0, 0.156487122,
        0, 1, 0,
        -0.156487122, 0, 0.987680018
    ),

    ["Sysphus State"] = CFrame.new(-3656.59058, -134.150406, -959.743469,
        -0.287091494, 0, 0.957903147,
        0, 1, 0,
        -0.957903147, 0, -0.287091494
    ),

    ["Temple Guardian"] = CFrame.new(1486.06165, 127.624977, -590.121094,
        0.998732686, 0, 0.0503287315,
        0, 1, 0,
        -0.0503287315, 0, 0.998732686
    ),

    ["Treasure Room"] = CFrame.new(-3598.04102, -275.723602, -1640.93933,
        -0.203907222, 0, 0.978990197,
        0, 1, 0,
        -0.978990197, 0, -0.203907222
    ),

    ["Tropical Grove"] = CFrame.new(-2016.4812, 9.03753567, 3752.35327,
        -0.995569646, 0, 0.0940273255,
        0, 1, 0,
        -0.0940273255, 0, -0.995569646
    ),

    ["Underground Cellar"] = CFrame.new(2125.30005, -91.1976624, -750.400024,
        -0.661489964, 0, -0.749954045,
        0, 1, 0,
        0.749954045, 0, -0.661489964
    ),

    ["Weather Machine"] = CFrame.new(-1476.29089, 3.49999928, 1909.09583,
        -0.429490566, 0, -0.903071344,
        0, 1, 0,
        0.903071344, 0, -0.429490566
    ),
}

----------------------------------------------------------------
-- SECTION "TELEPORT ISLAND" DI HALAMAN TELEPORT
----------------------------------------------------------------

local TeleportPage = Pages and Pages["Teleport"]
if not TeleportPage then
    warn("TeleportPage not found")
    return
end

local TeleportIslandSection = CreateSectionDropdown(TeleportPage, "Teleport Island")

local tpLayout = Instance.new("UIListLayout")
tpLayout.Parent    = TeleportIslandSection
tpLayout.SortOrder = Enum.SortOrder.LayoutOrder
tpLayout.Padding   = UDim.new(0, 6)

local function makeTpIslandRow(title, height)
    local row = Instance.new("Frame")
    row.Parent                  = TeleportIslandSection
    row.Size                    = UDim2.new(1,0,0,height or 36)
    row.BackgroundTransparency  = 1

    local label = Instance.new("TextLabel")
    label.Parent                 = row
    label.Size                   = UDim2.new(1,-110,1,0)
    label.Position               = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font                   = Enum.Font.Gotham
    label.TextSize               = 13
    label.TextXAlignment         = Enum.TextXAlignment.Left
    label.TextColor3             = TEXT or THEME_TEXT
    label.Text                   = title

    return row
end

local function makeTpIslandButton(row, text)
    local btn = Instance.new("TextButton")
    btn.Parent                   = row
    btn.Size                     = UDim2.new(0,110,0,24)
    btn.Position                 = UDim2.new(1,-126,0.5,-12)
    btn.BackgroundColor3         = CARD or Color3.fromRGB(40,40,60)
    btn.BackgroundTransparency   = 0.1
    btn.Text                     = text
    btn.TextColor3               = THEME_TEXT
    btn.Font                     = Enum.Font.GothamBold
    btn.TextSize                 = 12
    btn.AutoButtonColor          = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    return btn
end

----------------------------------------------------------------
-- PANEL KANAN: TELEPORT ISLAND RIGHT PANEL
----------------------------------------------------------------

local IslandRightPanel = Instance.new("Frame")
IslandRightPanel.Name                   = "TeleportIslandRightPanel"
IslandRightPanel.Size                   = UDim2.new(0, 220, 1, -46)
IslandRightPanel.AnchorPoint            = Vector2.new(1, 0)
IslandRightPanel.Position               = UDim2.new(1, -10, 0, 40)
IslandRightPanel.BackgroundColor3       = CARD or Color3.fromRGB(15, 15, 25)
IslandRightPanel.BackgroundTransparency = 0.25
IslandRightPanel.BorderSizePixel        = 0
IslandRightPanel.Visible                = false
IslandRightPanel.ZIndex                 = 10
IslandRightPanel.Parent                 = Main

Instance.new("UICorner", IslandRightPanel).CornerRadius = UDim.new(0, 10)
local iStroke = Instance.new("UIStroke", IslandRightPanel)
iStroke.Color        = THEME_MAIN
iStroke.Transparency = 0.5

local iTitle = Instance.new("TextLabel")
iTitle.Parent                  = IslandRightPanel
iTitle.Size                    = UDim2.new(1, -10, 0, 24)
iTitle.Position                = UDim2.new(0, 5, 0, 6)
iTitle.BackgroundTransparency  = 1
iTitle.Font                    = Enum.Font.GothamBold
iTitle.TextSize                = 16
iTitle.TextXAlignment          = Enum.TextXAlignment.Left
iTitle.TextColor3              = THEME_TEXT
iTitle.ZIndex                  = 11
iTitle.Text                    = "Teleport Island"

local iInfo = Instance.new("TextLabel")
iInfo.Parent                   = IslandRightPanel
iInfo.Size                     = UDim2.new(1, -10, 0, 18)
iInfo.Position                 = UDim2.new(0, 5, 0, 30)
iInfo.BackgroundTransparency   = 1
iInfo.Font                     = Enum.Font.Gotham
iInfo.TextSize                 = 12
iInfo.TextXAlignment           = Enum.TextXAlignment.Left
iInfo.TextColor3               = Color3.fromRGB(200,200,200)
iInfo.ZIndex                   = 11
iInfo.Text                     = "Pilih lokasi island untuk teleport."

local iScroll = Instance.new("ScrollingFrame")
iScroll.Parent                 = IslandRightPanel
iScroll.Size                   = UDim2.new(1, -10, 1, -70)
iScroll.Position               = UDim2.new(0, 5, 0, 54)
iScroll.BackgroundTransparency = 1
iScroll.BorderSizePixel        = 0
iScroll.ScrollBarThickness     = 3
iScroll.AutomaticCanvasSize    = Enum.AutomaticSize.Y
iScroll.CanvasSize             = UDim2.new(0,0,0,0)
iScroll.ScrollBarImageColor3   = THEME_MAIN
iScroll.ZIndex                 = 10

local iList = Instance.new("UIListLayout", iScroll)
iList.SortOrder = Enum.SortOrder.LayoutOrder
iList.Padding   = UDim.new(0,4)

----------------------------------------------------------------
-- LOGIC TELEPORT & ENTRY LIST
----------------------------------------------------------------

local function TpToIsland(cf, label)
    local chr = Player.Character or Player.CharacterAdded:Wait()
    local hrp = chr:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    hrp.CFrame = cf
    if NotifyFeature and label then
        NotifyFeature("Teleport: "..label, true)
    end
end

local function CreateIslandEntry(islandName, cf)
    local row = Instance.new("Frame")
    row.Parent                 = iScroll
    row.Size                   = UDim2.new(1, -4, 0, 24)
    row.BackgroundTransparency = 1
    row.BorderSizePixel        = 0
    row.ZIndex                 = 11

    local line = Instance.new("Frame")
    line.Name              = "Highlight"
    line.Parent            = row
    line.Size              = UDim2.new(0, 3, 1, 0)
    line.Position          = UDim2.new(0, 0, 0, 0)
    line.BackgroundColor3  = THEME_MAIN or Color3.fromRGB(170, 90, 255)
    line.BorderSizePixel   = 0
    line.Visible           = false
    line.ZIndex            = 12

    local btn = Instance.new("TextButton")
    btn.Parent                 = row
    btn.Size                   = UDim2.new(1, -6, 1, 0)
    btn.Position               = UDim2.new(0, 4, 0, 0)
    btn.BackgroundColor3       = Color3.fromRGB(30,30,50)
    btn.BorderSizePixel        = 0
    btn.TextColor3             = THEME_TEXT
    btn.Font                   = Enum.Font.Gotham
    btn.TextSize               = 12
    btn.TextXAlignment         = Enum.TextXAlignment.Left
    btn.Text                   = "  "..islandName
    btn.AutoButtonColor        = true
    btn.ZIndex                 = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    btn.MouseButton1Click:Connect(function()
        TpToIsland(cf, islandName)

        for _, child in ipairs(iScroll:GetChildren()) do
            if child:IsA("Frame") and child:FindFirstChild("Highlight") then
                child.Highlight.Visible = (child == row)
            end
        end
    end)
end

local islandNames = {}
for name in pairs(IslandTeleportCF) do
    table.insert(islandNames, name)
end
table.sort(islandNames)

for _, name in ipairs(islandNames) do
    CreateIslandEntry(name, IslandTeleportCF[name])
end

----------------------------------------------------------------
-- ROW DI SECTION TELEPORT UNTUK BUKA PANEL
----------------------------------------------------------------

do
    local row = makeTpIslandRow("Teleport Island Panel")
    local btn = makeTpIslandButton(row, "Open")
    btn.MouseButton1Click:Connect(function()
        IslandRightPanel.Visible = not IslandRightPanel.Visible
    end)
end

----------------------------------------------------------------
-- CLOSE PANEL DARI KLIK DI LUAR
----------------------------------------------------------------

UIS.InputBegan:Connect(function(input)
    if not IslandRightPanel.Visible then return end

    if input.UserInputType ~= Enum.UserInputType.MouseButton1
    and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local pos    = input.Position
    local absPos = IslandRightPanel.AbsolutePosition
    local absSize= IslandRightPanel.AbsoluteSize

    local inside =
        pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
        pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y

    if not inside then
        IslandRightPanel.Visible = false
    end
end)

----------------------------------------------------------------
-- SECTION "TELEPORT PLAYER" DI HALAMAN TELEPORT
----------------------------------------------------------------

local TeleportPage = Pages and Pages["Teleport"]
if not TeleportPage then
    warn("TeleportPage not found (Teleport Player)")
    return
end

-- section yang benar: TeleportPlayerSection
local TeleportPlayerSection = CreateSectionDropdown(TeleportPage, "Teleport Player")

local tpPlayerLayout = Instance.new("UIListLayout")
tpPlayerLayout.Parent    = TeleportPlayerSection
tpPlayerLayout.SortOrder = Enum.SortOrder.LayoutOrder
tpPlayerLayout.Padding   = UDim.new(0, 6)

local function makeTpPlayerRow(title, height)
    local row = Instance.new("Frame")
    row.Parent                 = TeleportPlayerSection
    row.Size                   = UDim2.new(1,0,0,height or 36)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel")
    label.Parent                 = row
    label.Size                   = UDim2.new(1,-110,1,0)
    label.Position               = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font                   = Enum.Font.Gotham
    label.TextSize               = 13
    label.TextXAlignment         = Enum.TextXAlignment.Left
    label.TextColor3             = THEME_TEXT
    label.Text                   = title

    return row
end

local function makeTpPlayerButton(row, text)
    local btn = Instance.new("TextButton")
    btn.Parent                   = row
    btn.Size                     = UDim2.new(0,110,0,24)
    btn.Position                 = UDim2.new(1,-126,0.5,-12)
    btn.BackgroundColor3         = CARD
    btn.BackgroundTransparency   = 0.1
    btn.Text                     = text
    btn.TextColor3               = THEME_TEXT
    btn.Font                     = Enum.Font.GothamBold
    btn.TextSize                 = 12
    btn.AutoButtonColor          = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    return btn
end

----------------------------------------------------------------
-- PANEL KANAN: TELEPORT PLAYER (SEARCH + LIST)
----------------------------------------------------------------

local PlayerRightPanel = Instance.new("Frame")
PlayerRightPanel.Name                   = "TeleportPlayerRightPanel"
PlayerRightPanel.Size                   = UDim2.new(0, 260, 1, -46)
PlayerRightPanel.AnchorPoint            = Vector2.new(1, 0)
PlayerRightPanel.Position               = UDim2.new(1, -10, 0, 40)
PlayerRightPanel.BackgroundColor3       = CARD
PlayerRightPanel.BackgroundTransparency = 0.25
PlayerRightPanel.BorderSizePixel        = 0
PlayerRightPanel.Visible                = false
PlayerRightPanel.ZIndex                 = 10
PlayerRightPanel.Parent                 = Main

Instance.new("UICorner", PlayerRightPanel).CornerRadius = UDim.new(0, 10)
local pStroke = Instance.new("UIStroke", PlayerRightPanel)
pStroke.Color       = THEME_MAIN
pStroke.Transparency= 0.5

local pTitle = Instance.new("TextLabel")
pTitle.Parent                 = PlayerRightPanel
pTitle.Size                   = UDim2.new(1, -10, 0, 24)
pTitle.Position               = UDim2.new(0, 5, 0, 6)
pTitle.BackgroundTransparency = 1
pTitle.Font                   = Enum.Font.GothamBold
pTitle.TextSize               = 16
pTitle.TextXAlignment         = Enum.TextXAlignment.Left
pTitle.TextColor3             = THEME_TEXT
pTitle.ZIndex                 = 11
pTitle.Text                   = "Teleport Player"

local pInfo = Instance.new("TextLabel")
pInfo.Parent                 = PlayerRightPanel
pInfo.Size                   = UDim2.new(1, -10, 0, 18)
pInfo.Position               = UDim2.new(0, 5, 0, 30)
pInfo.BackgroundTransparency = 1
pInfo.Font                   = Enum.Font.Gotham
pInfo.TextSize               = 12
pInfo.TextXAlignment         = Enum.TextXAlignment.Left
pInfo.TextColor3             = Color3.fromRGB(200,200,200)
pInfo.ZIndex                 = 11
pInfo.Text                   = "Search & pilih player, lalu teleport."

-- search box
local searchBox = Instance.new("TextBox")
searchBox.Parent                 = PlayerRightPanel
searchBox.Size                   = UDim2.new(1, -20, 0, 22)
searchBox.Position               = UDim2.new(0, 10, 0, 52)
searchBox.PlaceholderText        = "Search player..."
searchBox.Font                   = Enum.Font.Gotham
searchBox.TextSize               = 12
searchBox.TextXAlignment         = Enum.TextXAlignment.Left
searchBox.TextColor3             = THEME_TEXT
searchBox.ClearTextOnFocus       = false
searchBox.BackgroundColor3       = Color3.fromRGB(18,20,28)
searchBox.BackgroundTransparency = 0.1
searchBox.Text                   = ""
searchBox.ZIndex                 = 11
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,6)

-- tombol teleport & refresh di bawah search
local tpBtn = Instance.new("TextButton")
tpBtn.Parent                   = PlayerRightPanel
tpBtn.Size                     = UDim2.new(0.5, -15, 0, 24)
tpBtn.Position                 = UDim2.new(0, 10, 0, 80)
tpBtn.BackgroundColor3         = ACCENT
tpBtn.BackgroundTransparency   = 0.08
tpBtn.AutoButtonColor          = false
tpBtn.Font                     = Enum.Font.Gotham
tpBtn.TextSize                 = 12
tpBtn.TextColor3               = THEME_TEXT
tpBtn.Text                     = "Teleport ke player"
tpBtn.ZIndex                   = 11
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,8)

local refreshBtn = Instance.new("TextButton")
refreshBtn.Parent                 = PlayerRightPanel
refreshBtn.Size                   = UDim2.new(0.5, -15, 0, 24)
refreshBtn.Position               = UDim2.new(0.5, 5, 0, 80)
refreshBtn.BackgroundColor3       = CARD
refreshBtn.BackgroundTransparency = 0.18
refreshBtn.AutoButtonColor        = false
refreshBtn.Font                   = Enum.Font.Gotham
refreshBtn.TextSize               = 12
refreshBtn.TextColor3             = THEME_TEXT
refreshBtn.Text                   = "Refresh list"
refreshBtn.ZIndex                 = 11
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0,8)

-- list player
local pScroll = Instance.new("ScrollingFrame")
pScroll.Parent                 = PlayerRightPanel
pScroll.Size                   = UDim2.new(1, -20, 1, -112)
pScroll.Position               = UDim2.new(0, 10, 0, 110)
pScroll.BackgroundTransparency = 1
pScroll.BorderSizePixel        = 0
pScroll.ScrollBarThickness     = 3
pScroll.AutomaticCanvasSize    = Enum.AutomaticSize.Y
pScroll.CanvasSize             = UDim2.new(0,0,0,0)
pScroll.ScrollBarImageColor3   = THEME_MAIN
pScroll.ZIndex                 = 10

local pList = Instance.new("UIListLayout", pScroll)
pList.SortOrder = Enum.SortOrder.LayoutOrder
pList.Padding   = UDim.new(0,2)

----------------------------------------------------------------
-- LOGIC TELEPORT PLAYER
----------------------------------------------------------------

local selectedPlayerName = nil

local function passFilter(name, q)
    if q == "" then return true end
    name = string.lower(name)
    q    = string.lower(q)
    return string.find(name, q, 1, true) ~= nil
end

local function TpToPlayer(targetPlr)
    if not targetPlr or targetPlr == Player then return end

    local targetChar = targetPlr.Character or targetPlr.CharacterAdded:Wait()
    local targetHRP  = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return end

    local char = Player.Character or Player.CharacterAdded:Wait()
    local hrp  = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    hrp.AssemblyLinearVelocity  = Vector3.new(0,0,0)
    hrp.AssemblyAngularVelocity = Vector3.new(0,0,0)
    hrp.CFrame                  = targetHRP.CFrame + Vector3.new(0,0,3)

    if NotifyFeature then
        NotifyFeature("Teleport ke "..targetPlr.Name, true)
    end
end

local function ClearPlayerList()
    for _, c in ipairs(pScroll:GetChildren()) do
        if c:IsA("Frame") or c:IsA("TextButton") then
            c:Destroy()
        end
    end
end

local function RebuildPlayerList()
    ClearPlayerList()

    local query = searchBox.Text or ""
    local all   = Players:GetPlayers()
    table.sort(all, function(a, b)
        return a.Name < b.Name
    end)

    for _, plr in ipairs(all) do
        if plr ~= Player and passFilter(plr.Name, query) then
            local row = Instance.new("TextButton")
            row.Parent                   = pScroll
            row.Size                     = UDim2.new(1, 0, 0, 22)
            row.BackgroundColor3         = CARD
            row.BackgroundTransparency   = 0.2
            row.Font                     = Enum.Font.Gotham
            row.TextSize                 = 11
            row.TextXAlignment           = Enum.TextXAlignment.Left
            row.TextColor3               = THEME_TEXT
            row.Text                     = "  "..plr.Name
            row.AutoButtonColor          = false
            row.ZIndex                   = 11
            Instance.new("UICorner", row).CornerRadius = UDim.new(0,4)

            row.MouseButton1Click:Connect(function()
                selectedPlayerName = plr.Name
                tpBtn.Text         = "Teleport ke "..plr.Name
            end)
        end
    end

    if not selectedPlayerName then
        tpBtn.Text = "Teleport ke player"
    end
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    if PlayerRightPanel.Visible then
        RebuildPlayerList()
    end
end)

Players.PlayerAdded:Connect(function()
    if PlayerRightPanel.Visible then
        RebuildPlayerList()
    end
end)

Players.PlayerRemoving:Connect(function()
    if PlayerRightPanel.Visible then
        RebuildPlayerList()
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    if not selectedPlayerName then return end

    local target = Players:FindFirstChild(selectedPlayerName)
    if not target then return end

    TpToPlayer(target)
end)

refreshBtn.MouseButton1Click:Connect(function()
    selectedPlayerName = nil
    searchBox.Text     = ""
    RebuildPlayerList()
    if NotifyFeature then
        NotifyFeature("Refresh player list", false)
    end
end)

----------------------------------------------------------------
-- ROW DI SECTION TELEPORT PLAYER UNTUK BUKA PANEL
----------------------------------------------------------------

do
    local row = makeTpPlayerRow("Teleport Player Panel")
    local btn = makeTpPlayerButton(row, "Open")
    btn.MouseButton1Click:Connect(function()
        PlayerRightPanel.Visible = not PlayerRightPanel.Visible
        if PlayerRightPanel.Visible then
            selectedPlayerName = nil
            searchBox.Text     = ""
            RebuildPlayerList()
        end
    end)
end

----------------------------------------------------------------
-- CLOSE PANEL DARI KLIK DI LUAR
----------------------------------------------------------------

UIS.InputBegan:Connect(function(input)
    if not PlayerRightPanel.Visible then return end

    if input.UserInputType ~= Enum.UserInputType.MouseButton1
    and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local pos    = input.Position
    local absPos = PlayerRightPanel.AbsolutePosition
    local absSize= PlayerRightPanel.AbsoluteSize

    local inside =
        pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
        pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y

    if not inside then
        PlayerRightPanel.Visible = false
    end
end)
