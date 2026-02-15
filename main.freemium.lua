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

--==================================================
-- SCREEN GUI + MAIN UI (LOADING, MAIN FRAME, TITLE, SIDEBAR, CONTENT, MINIMIZE, NOTIFY)
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

-- minimize logo
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

local THEME_MAIN = Color3.fromRGB(116, 84, 255)
local THEME_TEXT = Color3.fromRGB(230, 230, 235)
local MUTED      = Color3.fromRGB(70, 70, 80)
local CARD       = Color3.fromRGB(25, 25, 35)
local ACCENT     = Color3.fromRGB(140, 101, 255)


----------------------------------------------------------------
-- REMOTES
----------------------------------------------------------------
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")

local Events = {
    -- Complete / catch pakai RemoteFunction baru
    catch   = Net:WaitForChild("RF/CatchFishCompleted"),

    -- jual / sistem lain
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
-- X1 TOTEM BACKEND (SHARED DENGAN AUTO TOTEM)
----------------------------------------------------------------
local Replion = require(ReplicatedStorage.Packages.Replion)

local SpawnTotemRemote = Net:WaitForChild("RE/SpawnTotem")

local TotemTypeId = {
    Mutasi = 2,
    Shiny  = 3,
    Lucky  = 1,
}

local TOTEM_DURATION = 3600

_G.RAYAutoTotemOn       = _G.RAYAutoTotemOn or false
_G.RAYSelectedTotemType = _G.RAYSelectedTotemType or "Lucky"

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

    local inv = data.Inventory
    local totems = inv and inv.Totems
    if typeof(totems) ~= "table" then return nil end

    for _, entry in pairs(totems) do
        if entry.Id == targetId then
            return entry.UUID
        end
    end
    return nil
end

function SpawnTotemUUID(uuid)
    if not uuid then return end
    pcall(function()
        SpawnTotemRemote:FireServer(uuid)
        -- SpawnTotemRemote:FireServer({UUID = uuid}) -- kalau butuh table
    end)
end


----------------------------------------------------------------
-- MEGALODON HUNT TELEPORT
----------------------------------------------------------------
function TeleportToMegalodon()
    local anchor
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "Megalodon Hunt" then
            anchor = obj
            break
        end
    end
    if not anchor then return end

    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    root.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
    root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

    local basePos = anchor.Position + Vector3.new(0, 5, 0)
    local lookDir = anchor.CFrame.LookVector
    local cf = CFrame.new(basePos, basePos + lookDir)
    char:PivotTo(cf)
end

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

----------------------------------------------------------------
--- ALL LOGIC
----------------------------------------------------------------
local VFXHidden = {}
local VFXCacheFolder = Instance.new("Folder")
VFXCacheFolder.Name = "VFX_HIDDEN_CACHE"
VFXCacheFolder.Parent = ReplicatedStorage

local function HideAllVFX()
    local vfxRoot = ReplicatedStorage:FindFirstChild("VFX")
    if not vfxRoot then return end

    -- simpan dan sembunyikan
    for _, obj in ipairs(vfxRoot:GetChildren()) do
        if not VFXHidden[obj] then
            VFXHidden[obj] = obj.Parent
            obj.Parent = VFXCacheFolder
        end
    end
end

local function RestoreAllVFX()
    -- balikin semua yang pernah kita pindahin
    for obj, oldParent in pairs(VFXHidden) do
        if obj and obj.Parent == VFXCacheFolder then
            obj.Parent = oldParent
        end
    end
    table.clear(VFXHidden)
end


local Players           = game:GetService("Players")
local UIS               = game:GetService("UserInputService")
local CoreGui           = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RunService        = game:GetService("RunService")
local Stats             = game:GetService("Stats")

local lp                = Players.LocalPlayer

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

    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    createWaterSurface(root)

    waterHb = RunService.Heartbeat:Connect(function()
        if #Surfaces == 0 then return end
        if not root or not root.Parent or not lastCenter then return end

        local pos = root.Position
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
lp.CharacterAdded:Connect(function()
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
-- SETUP GLOBAL
----------------------------------------------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local lp = Players.LocalPlayer
local GuiControl = require(ReplicatedStorage.Modules.GuiControl)

-- cache fungsi asli (hanya sekali di seluruh script)
_G.__RAY_OldGuiControlClose = _G.__RAY_OldGuiControlClose or GuiControl.Close
_G.__RAY_OldGuiControlLock  = _G.__RAY_OldGuiControlLock  or GuiControl.Lock
_G.__RAY_OldGuiControlHUD   = _G.__RAY_OldGuiControlHUD   or GuiControl.SetHUDVisibility

-- guard kamera supaya cutscene nggak bisa ambil alih
local camConn
local function ForcePlayerCamera()
    local cam = Workspace.CurrentCamera
    if not cam or not lp.Character then return end

    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    cam.CameraType = Enum.CameraType.Custom
    cam.CameraSubject = hum
end

local function StartCameraGuard()
    ForcePlayerCamera()
    if camConn then camConn:Disconnect() end
    camConn = Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(ForcePlayerCamera)

    -- kalau karakter respawn, segera balikin lagi ke kamera player
    lp.CharacterAdded:Connect(function()
        task.delay(0.2, ForcePlayerCamera)
    end)
end

local function StopCameraGuard()
    if camConn then
        camConn:Disconnect()
        camConn = nil
    end
end

-- manager patch biar 2 toggle (Disable Cutscene / No Cutscene Pause) nggak tabrakan
local function ReapplyGuiPatches()
    local disableAll = _G.RAY_DisableCutscene
    local noPause   = _G.RAY_NoCutscenePause

    -- restore default dulu
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
        -- full skip: HUD nggak pernah di-hide, lock nggak jalan, close nggak jalan
        function GuiControl.Close(skipHud)
            return
        end
        function GuiControl.Lock()
            return
        end
        function GuiControl.SetHUDVisibility(flag)
            return
        end

        -- guard kamera: cutscene nggak bisa ubah kamera
        StartCameraGuard()

    elseif noPause then
        -- versi "No Cutscene Pause": HUD boleh, cutscene boleh, tapi lock mati
        function GuiControl.Lock()
            return
        end
        -- kamera tidak dijaga, jadi cutscene masih kelihatan
    end
end

----------------------------------------------------------------
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

        -- kalau ini ON, matikan flag NoCutscenePause biar nggak bingung
        if enabled then
            _G.RAY_NoCutscenePause = false
        end

        ReapplyGuiPatches()
        refresh()

        if NotifyFeature then
            NotifyFeature("Disable Cutscene", enabled)
        end
    end)

    -- init kalau sebelum reload sudah ON
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

        -- kalau ini ON, matikan DisableCutscene supaya mode-nya jelas
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
-- DISABLE FISH IMAGE (FISHING SUPPORT)
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
    local gui = Players.LocalPlayer:WaitForChild("PlayerGui")

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
-- DISABLE ROD SKIN (FISHING SUPPORT)
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

    lp.CharacterAdded:Connect(function()
        if enabled then
            task.delay(0.5, HideAllVFX)
        end
    end)

    apply()
    refresh()
end


----------------------------------------------------------------
-- ROD FREEZE (ROD + BADAN DIEM, MANCING TETAP JALAN)
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

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players          = game:GetService("Players")
    local RunService       = game:GetService("RunService")

    local lp = Players.LocalPlayer

    -- AnimController dari Controllers (path ini sudah pasti dari log-mu)
    local AnimController = require(ReplicatedStorage.Controllers.AnimationController)
    print("[RodFreeze] AnimController =", AnimController)

    _G.__RAY_OldPlayAnimation = _G.__RAY_OldPlayAnimation or AnimController.PlayAnimation
    local OldPlay = _G.__RAY_OldPlayAnimation

    -- anim rod dasar (all rod no-skin ikut)
    local ROD_ANIMS = {
        ["RodThrow"]         = true,
        ["ReelStart"]        = true,
        ["ReelingIdle"]      = true,
        ["ReelIntermission"] = true,
        ["FishCaught"]       = true,
    }

    -- koneksi heartbeat buat hard-freeze semua anim di humanoid
    local hardFreezeConn

    local function startHardFreeze()
        if hardFreezeConn then hardFreezeConn:Disconnect() end

        hardFreezeConn = RunService.Heartbeat:Connect(function()
            local char = lp.Character
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

        -- optional: balikin speed ke normal (1) buat semua anim yang masih jalan
        local char = lp.Character
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
            pill.BackgroundColor3 = Color3.fromRGB(0,200,100)   -- hijau ON
        else
            pill.BackgroundColor3 = Color3.fromRGB(120,120,120) -- abu OFF
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

    -- init sesuai state global
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

----------------------------------------------------------------
-- AUTO SELL SECTION (BACKPACK PAGE) - DUA TOGGLE: TIME & INVENTORY
----------------------------------------------------------------

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local Items   = require(RS.Items)
local Replion = require(RS.Packages.Replion)

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
    _G.RAY_SellByTime             = (_G.RAY_SellByTime ~= false)      -- default ON
    _G.RAY_SellByInventory        = _G.RAY_SellByInventory or false   -- default OFF

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
-- HELPER: HITUNG JUMLAH IKAN DI INVENTORY (REPLION + ITEMS)
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
    local inv = root and root.Inventory
    local items = inv and inv.Items
    if typeof(items) ~= "table" then
        return 0
    end

    local count = 0
    for _, entry in pairs(items) do
        local id = entry.Id
        local data = id and ItemDataById[id]
        if data and data.Type == "Fish" then
            count += 1
        end
    end
    return count
end

----------------------------------------------------------------
-- AUTO SELL ENGINE (PAKAI TOGGLE SellByTime & SellByInventory)
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

        -- Sell by Inventory (jumlah ikan di tas)
        if _G.RAY_SellByInventory then
            local count = getFishCountInInventory()
            local limit = tonumber(_G.RAY_SellInventoryThreshold) or 30
            -- debug kalau perlu:
            -- print("[AUTO SELL] fish count =", count, "limit =", limit)

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
-- AUTO FAVORITE FISH (BACKPACK PAGE)
----------------------------------------------------------------

local lp = Players.LocalPlayer

local Net = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")

local FavoriteRemote = Net:WaitForChild("RE/FavoriteItem")

----------------------------------------------------------------
-- DATA MODULES (Items / Tiers / Variants / Replion)
----------------------------------------------------------------
local ItemsModule    = require(ReplicatedStorage.Items)
local TiersModule    = require(ReplicatedStorage.Tiers)
local VariantsModule = require(ReplicatedStorage.Variants)
local Replion        = require(ReplicatedStorage.Packages.Replion)

local ItemDataById = {}
for _, v in ItemsModule do
    if v.Data and v.Data.Id then
        ItemDataById[v.Data.Id] = v.Data
    end
end

local TierByIndex = {}
for _, t in TiersModule do
    TierByIndex[t.Tier] = t
end

local VariantDataById = {}
local VariantNameById = {}
for _, v in VariantsModule do
    local d = v.Data
    if d and d.Type == "Variant" and d.Id and d.Name then
        VariantDataById[d.Id] = d
        VariantNameById[d.Id] = d.Name
    end
end

----------------------------------------------------------------
-- GLOBAL STATE AUTO FAVORITE
----------------------------------------------------------------
_G.RAYFavOn            = _G.RAYFavOn or false
_G.RAYFavLegendOn      = _G.RAYFavLegendOn or false
_G.RAYFavMythicOn      = _G.RAYFavMythicOn or false
_G.RAYFavSecretOn      = _G.RAYFavSecretOn or false
_G.RAYFavVariantFilter = _G.RAYFavVariantFilter or "Any"
_G.RAYFavSelectedNames = _G.RAYFavSelectedNames or {}

local AUTO_FAV_INTERVAL = 10

----------------------------------------------------------------
-- HELPER: AMBIL INVENTORY CLIENT
----------------------------------------------------------------
local function getInvItems()
    local ok, repl = pcall(function()
        return Replion.Client:WaitReplion("Data")
    end)
    if not ok or not repl or not repl.Data then
        return {}
    end
    local root  = repl.Data
    local inv   = root and root.Inventory
    local items = inv and inv.Items
    if typeof(items) ~= "table" then
        return {}
    end
    return items
end

local function getTierFromItem(data)
    if data.Tier then
        return TierByIndex[data.Tier] or TierByIndex[1]
    end
    return TierByIndex[1]
end

----------------------------------------------------------------
-- FILTER: RARITY / NAMA / VARIANT (VERSI SEDERHANA & BERGUNA)
----------------------------------------------------------------

-- rarity: kalau tidak ada yang dicentang, artinya semua rarity boleh
local function passesRarityFilterFav(data)
    local tierInfo = getTierFromItem(data)
    local rName = tierInfo and tierInfo.Name
    if not rName then return false end

    local L = _G.RAYFavLegendOn
    local M = _G.RAYFavMythicOn
    local S = _G.RAYFavSecretOn

    -- semua false => tidak pakai filter rarity (semua lolos)
    if not L and not M and not S then
        return true
    end

    if rName == "Legendary" and L then return true end
    if rName == "Mythic"    and M then return true end
    if rName == "SECRET"    and S then return true end
    return false
end

-- nama: kalau list kosong, artinya tanpa filter nama (semua lolos nama)
local function passesNameFilterFav(data)
    local sel = _G.RAYFavSelectedNames
    if not sel or next(sel) == nil then
        return true
    end
    return data.Name and sel[data.Name] == true
end

local function getVariantNameFromEntry(entry)
    local vid = entry.VariantId or entry.VariantID or entry.Variant
    if not vid then return nil end
    return VariantNameById[vid]
end

-- variant: kalau "Any" atau nil, artinya tanpa filter variant (semua lolos variant)
local function passesVariantFilterFav(entry)
    if not _G.RAYFavVariantFilter or _G.RAYFavVariantFilter == "Any" then
        return true
    end
    local vName = getVariantNameFromEntry(entry)
    if not vName then return false end
    return vName == _G.RAYFavVariantFilter
end

----------------------------------------------------------------
-- LOGIC: RARITY = FILTER UTAMA, NAMA & VARIANT OPSIONAL
----------------------------------------------------------------

local function shouldFavorite(data, entry)
    if data.Type ~= "Fish" then
        return false
    end

    if not passesRarityFilterFav(data) then
        return false
    end

    if not passesNameFilterFav(data) then
        return false
    end

    if not passesVariantFilterFav(entry) then
        return false
    end

    return true
end

----------------------------------------------------------------
-- ENGINE: AUTO FAVORITE LOOP
----------------------------------------------------------------
local autoFavConn

local function StopAutoFavorite()
    if autoFavConn then
        autoFavConn:Disconnect()
        autoFavConn = nil
    end
end

local function StartAutoFavorite()
    StopAutoFavorite()

    autoFavConn = RunService.Heartbeat:Connect(function(dt)
        autoFavConn._acc = (autoFavConn._acc or 0) + dt
        if autoFavConn._acc < AUTO_FAV_INTERVAL then
            return
        end
        autoFavConn._acc = 0

        local items = getInvItems()
        local count = 0

        for _, entry in pairs(items) do
            local id   = entry.Id
            local uuid = entry.UUID
            local data = id and ItemDataById[id]

            if data and uuid and shouldFavorite(data, entry) then
                FavoriteRemote:FireServer(uuid)
                count += 1
            end
        end

        if count > 0 and NotifyFeature then
            NotifyFeature("Auto Favorite: +"..tostring(count), true)
        end
    end)
end

task.delay(1, function()
    if _G.RAYFavOn then
        StartAutoFavorite()
    end
end)

----------------------------------------------------------------
-- PANEL KANAN: RARITY / FISH / VARIANT (PARENT = Main)
----------------------------------------------------------------

-- RARITY PANEL
local FavRarityRightPanel = Instance.new("Frame")
FavRarityRightPanel.Name = "FavRarityRightPanel"
FavRarityRightPanel.Size = UDim2.new(0, 220, 1, -46)
FavRarityRightPanel.AnchorPoint = Vector2.new(1, 0)
FavRarityRightPanel.Position = UDim2.new(1, -10, 0, 40)
FavRarityRightPanel.BackgroundColor3 = CARD or Color3.fromRGB(15, 15, 25)
FavRarityRightPanel.BackgroundTransparency = 0.25
FavRarityRightPanel.BorderSizePixel = 0
FavRarityRightPanel.Visible = false
FavRarityRightPanel.ZIndex = 10
FavRarityRightPanel.Parent = Main

Instance.new("UICorner", FavRarityRightPanel).CornerRadius = UDim.new(0, 10)
local frStroke = Instance.new("UIStroke", FavRarityRightPanel)
frStroke.Color = THEME_MAIN
frStroke.Transparency = 0.5

local frTitle = Instance.new("TextLabel")
frTitle.Parent = FavRarityRightPanel
frTitle.Size = UDim2.new(1, -10, 0, 24)
frTitle.Position = UDim2.new(0, 5, 0, 6)
frTitle.BackgroundTransparency = 1
frTitle.Font = Enum.Font.GothamBold
frTitle.TextSize = 16
frTitle.TextXAlignment = Enum.TextXAlignment.Left
frTitle.TextColor3 = THEME_TEXT
frTitle.ZIndex = 11
frTitle.Text = "Favorite by Rarity"

local frInfo = Instance.new("TextLabel")
frInfo.Parent = FavRarityRightPanel
frInfo.Size = UDim2.new(1, -10, 0, 18)
frInfo.Position = UDim2.new(0, 5, 0, 30)
frInfo.BackgroundTransparency = 1
frInfo.Font = Enum.Font.Gotham
frInfo.TextSize = 12
frInfo.TextXAlignment = Enum.TextXAlignment.Left
frInfo.TextColor3 = Color3.fromRGB(200,200,200)
frInfo.ZIndex = 11
frInfo.Text = "Centang rarity global auto favorite."

local frScroll = Instance.new("ScrollingFrame")
frScroll.Parent = FavRarityRightPanel
frScroll.Size = UDim2.new(1, -10, 1, -70)
frScroll.Position = UDim2.new(0, 5, 0, 54)
frScroll.BackgroundTransparency = 1
frScroll.BorderSizePixel = 0
frScroll.ScrollBarThickness = 3
frScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
frScroll.CanvasSize = UDim2.new(0,0,0,0)
frScroll.ScrollBarImageColor3 = THEME_MAIN
frScroll.ZIndex = 10

local frList = Instance.new("UIListLayout", frScroll)
frList.SortOrder = Enum.SortOrder.LayoutOrder
frList.Padding = UDim.new(0,4)

local function makeRarityEntry(text, flagKey)
    local row = Instance.new("Frame")
    row.Parent = frScroll
    row.Size = UDim2.new(1, -4, 0, 24)
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    row.ZIndex = 11

    local line = Instance.new("Frame")
    line.Name = "Highlight"
    line.Parent = row
    line.Size = UDim2.new(0, 3, 1, 0)
    line.Position = UDim2.new(0, 0, 0, 0)
    line.BackgroundColor3 = THEME_MAIN
    line.BorderSizePixel = 0
    line.Visible = _G[flagKey]
    line.ZIndex = 12

    local btn = Instance.new("TextButton")
    btn.Parent = row
    btn.Size = UDim2.new(1, -6, 1, 0)
    btn.Position = UDim2.new(0, 4, 0, 0)
    btn.BackgroundColor3 = _G[flagKey] and Color3.fromRGB(40,40,70) or Color3.fromRGB(30,30,50)
    btn.BorderSizePixel = 0
    btn.TextColor3 = THEME_TEXT
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "  "..text
    btn.AutoButtonColor = true
    btn.ZIndex = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    btn.MouseButton1Click:Connect(function()
        _G[flagKey] = not _G[flagKey]
        line.Visible = _G[flagKey]
        btn.BackgroundColor3 = _G[flagKey] and Color3.fromRGB(40,40,70) or Color3.fromRGB(30,30,50)
        if NotifyFeature then
            NotifyFeature("Rarity: "..text, _G[flagKey])
        end
    end)
end

makeRarityEntry("Legendary", "RAYFavLegendOn")
makeRarityEntry("Mythic",    "RAYFavMythicOn")
makeRarityEntry("Secret",    "RAYFavSecretOn")

-- FISH NAME PANEL
local FavFishRightPanel = Instance.new("Frame")
FavFishRightPanel.Name = "FavFishRightPanel"
FavFishRightPanel.Size = UDim2.new(0, 220, 1, -46)
FavFishRightPanel.AnchorPoint = Vector2.new(1, 0)
FavFishRightPanel.Position = UDim2.new(1, -10, 0, 40)
FavFishRightPanel.BackgroundColor3 = CARD or Color3.fromRGB(15, 15, 25)
FavFishRightPanel.BackgroundTransparency = 0.25
FavFishRightPanel.BorderSizePixel = 0
FavFishRightPanel.Visible = false
FavFishRightPanel.ZIndex = 10
FavFishRightPanel.Parent = Main

Instance.new("UICorner", FavFishRightPanel).CornerRadius = UDim.new(0, 10)
local ffStroke = Instance.new("UIStroke", FavFishRightPanel)
ffStroke.Color = THEME_MAIN
ffStroke.Transparency = 0.5

local ffTitle = Instance.new("TextLabel")
ffTitle.Parent = FavFishRightPanel
ffTitle.Size = UDim2.new(1, -10, 0, 24)
ffTitle.Position = UDim2.new(0, 5, 0, 6)
ffTitle.BackgroundTransparency = 1
ffTitle.Font = Enum.Font.GothamBold
ffTitle.TextSize = 16
ffTitle.TextXAlignment = Enum.TextXAlignment.Left
ffTitle.TextColor3 = THEME_TEXT
ffTitle.ZIndex = 11
ffTitle.Text = "Fish Name Filter"

local ffInfo = Instance.new("TextLabel")
ffInfo.Parent = FavFishRightPanel
ffInfo.Size = UDim2.new(1, -10, 0, 18)
ffInfo.Position = UDim2.new(0, 5, 0, 30)
ffInfo.BackgroundTransparency = 1
ffInfo.Font = Enum.Font.Gotham
ffInfo.TextSize = 12
ffInfo.TextXAlignment = Enum.TextXAlignment.Left
ffInfo.TextColor3 = Color3.fromRGB(200,200,200)
ffInfo.ZIndex = 11
ffInfo.Text = "Set list nama buat kombinasi spesifik."

local ffScroll = Instance.new("ScrollingFrame")
ffScroll.Parent = FavFishRightPanel
ffScroll.Size = UDim2.new(1, -10, 1, -70)
ffScroll.Position = UDim2.new(0, 5, 0, 54)
ffScroll.BackgroundTransparency = 1
ffScroll.BorderSizePixel = 0
ffScroll.ScrollBarThickness = 3
ffScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ffScroll.CanvasSize = UDim2.new(0,0,0,0)
ffScroll.ScrollBarImageColor3 = THEME_MAIN
ffScroll.ZIndex = 10

local ffList = Instance.new("UIListLayout", ffScroll)
ffList.SortOrder = Enum.SortOrder.LayoutOrder
ffList.Padding = UDim.new(0,4)

local allFishNames = {}
for _, data in pairs(ItemDataById) do
    if data.Type == "Fish" and data.Name then
        allFishNames[data.Name] = true
    end
end

local sortedFishNames = {}
for name in pairs(allFishNames) do
    table.insert(sortedFishNames, name)
end
table.sort(sortedFishNames)

local function CreateFishEntry(name)
    local selected = _G.RAYFavSelectedNames[name] == true

    local row = Instance.new("Frame")
    row.Parent = ffScroll
    row.Size = UDim2.new(1, -4, 0, 24)
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    row.ZIndex = 11

    local line = Instance.new("Frame")
    line.Name = "Highlight"
    line.Parent = row
    line.Size = UDim2.new(0, 3, 1, 0)
    line.Position = UDim2.new(0, 0, 0, 0)
    line.BackgroundColor3 = THEME_MAIN
    line.BorderSizePixel = 0
    line.Visible = selected
    line.ZIndex = 12

    local btn = Instance.new("TextButton")
    btn.Parent = row
    btn.Size = UDim2.new(1, -6, 1, 0)
    btn.Position = UDim2.new(0, 4, 0, 0)
    btn.BackgroundColor3 = selected and Color3.fromRGB(40,40,70) or Color3.fromRGB(30,30,50)
    btn.BorderSizePixel = 0
    btn.TextColor3 = THEME_TEXT
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "  "..name
    btn.AutoButtonColor = true
    btn.ZIndex = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    btn.MouseButton1Click:Connect(function()
        local sel = _G.RAYFavSelectedNames
        if sel[name] then
            sel[name] = nil
            line.Visible = false
            btn.BackgroundColor3 = Color3.fromRGB(30,30,50)
        else
            sel[name] = true
            line.Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(40,40,70)
        end
    end)
end

for _, name in ipairs(sortedFishNames) do
    CreateFishEntry(name)
end

-- VARIANT PANEL
local FavVariantRightPanel = Instance.new("Frame")
FavVariantRightPanel.Name = "FavVariantRightPanel"
FavVariantRightPanel.Size = UDim2.new(0, 220, 1, -46)
FavVariantRightPanel.AnchorPoint = Vector2.new(1, 0)
FavVariantRightPanel.Position = UDim2.new(1, -10, 0, 40)
FavVariantRightPanel.BackgroundColor3 = CARD or Color3.fromRGB(15, 15, 25)
FavVariantRightPanel.BackgroundTransparency = 0.25
FavVariantRightPanel.BorderSizePixel = 0
FavVariantRightPanel.Visible = false
FavVariantRightPanel.ZIndex = 10
FavVariantRightPanel.Parent = Main

Instance.new("UICorner", FavVariantRightPanel).CornerRadius = UDim.new(0, 10)
local fvStroke = Instance.new("UIStroke", FavVariantRightPanel)
fvStroke.Color = THEME_MAIN
fvStroke.Transparency = 0.5

local fvTitle = Instance.new("TextLabel")
fvTitle.Parent = FavVariantRightPanel
fvTitle.Size = UDim2.new(1, -10, 0, 24)
fvTitle.Position = UDim2.new(0, 5, 0, 6)
fvTitle.BackgroundTransparency = 1
fvTitle.Font = Enum.Font.GothamBold
fvTitle.TextSize = 16
fvTitle.TextXAlignment = Enum.TextXAlignment.Left
fvTitle.TextColor3 = THEME_TEXT
fvTitle.ZIndex = 11
fvTitle.Text = "Variant Filter"

local fvInfo = Instance.new("TextLabel")
fvInfo.Parent = FavVariantRightPanel
fvInfo.Size = UDim2.new(1, -10, 0, 18)
fvInfo.Position = UDim2.new(0, 5, 0, 30)
fvInfo.BackgroundTransparency = 1
fvInfo.Font = Enum.Font.Gotham
fvInfo.TextSize = 12
fvInfo.TextXAlignment = Enum.TextXAlignment.Left
fvInfo.TextColor3 = Color3.fromRGB(200,200,200)
fvInfo.ZIndex = 11
fvInfo.Text = "Pilih variant untuk kombinasi spesifik."

local fvScroll = Instance.new("ScrollingFrame")
fvScroll.Parent = FavVariantRightPanel
fvScroll.Size = UDim2.new(1, -10, 1, -70)
fvScroll.Position = UDim2.new(0, 5, 0, 54)
fvScroll.BackgroundTransparency = 1
fvScroll.BorderSizePixel = 0
fvScroll.ScrollBarThickness = 3
fvScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
fvScroll.CanvasSize = UDim2.new(0,0,0,0)
fvScroll.ScrollBarImageColor3 = THEME_MAIN
fvScroll.ZIndex = 10

local fvList = Instance.new("UIListLayout", fvScroll)
fvList.SortOrder = Enum.SortOrder.LayoutOrder
fvList.Padding = UDim.new(0,4)

local variantNames = {}
for _, d in pairs(VariantDataById) do
    table.insert(variantNames, d.Name)
end
table.sort(variantNames)

local function CreateVariantEntry(name)
    local selected = (_G.RAYFavVariantFilter == name) or (_G.RAYFavVariantFilter == "Any" and name == "Any")

    local row = Instance.new("Frame")
    row.Parent = fvScroll
    row.Size = UDim2.new(1, -4, 0, 24)
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    row.ZIndex = 11

    local line = Instance.new("Frame")
    line.Name = "Highlight"
    line.Parent = row
    line.Size = UDim2.new(0, 3, 1, 0)
    line.Position = UDim2.new(0, 0, 0, 0)
    line.BackgroundColor3 = THEME_MAIN
    line.BorderSizePixel = 0
    line.Visible = selected
    line.ZIndex = 12

    local btn = Instance.new("TextButton")
    btn.Parent = row
    btn.Size = UDim2.new(1, -6, 1, 0)
    btn.Position = UDim2.new(0, 4, 0, 0)
    btn.BackgroundColor3 = selected and Color3.fromRGB(40,40,70) or Color3.fromRGB(30,30,50)
    btn.BorderSizePixel = 0
    btn.TextColor3 = THEME_TEXT
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "  "..name
    btn.AutoButtonColor = true
    btn.ZIndex = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    btn.MouseButton1Click:Connect(function()
        if name == "Any" then
            _G.RAYFavVariantFilter = "Any"
        else
            if _G.RAYFavVariantFilter == name then
                _G.RAYFavVariantFilter = "Any"
            else
                _G.RAYFavVariantFilter = name
            end
        end

        for _, child in ipairs(fvScroll:GetChildren()) do
            if child:IsA("Frame") then
                local h = child:FindFirstChild("Highlight")
                local b = child:FindFirstChildOfClass("TextButton")
                if h and b then
                    local label = b.Text:sub(3)
                    local isThis = (_G.RAYFavVariantFilter == "Any" and label == "Any") or (_G.RAYFavVariantFilter == label)
                    h.Visible = isThis
                    b.BackgroundColor3 = isThis and Color3.fromRGB(40,40,70) or Color3.fromRGB(30,30,50)
                end
            end
        end

        if NotifyFeature then
            NotifyFeature("Variant: ".._G.RAYFavVariantFilter, true)
        end
    end)
end

CreateVariantEntry("Any")
for _, name in ipairs(variantNames) do
    CreateVariantEntry(name)
end

----------------------------------------------------------------
-- SECTION UI DI BACKPACK (TOGGLE ENGINE + OPEN PANEL)
----------------------------------------------------------------
local BackpackPage = Pages and Pages["Backpack"]

if BackpackPage then
    local AutoFavSection = CreateSectionDropdown(BackpackPage, "Auto Favorite")

    local sectionLayout = Instance.new("UIListLayout")
    sectionLayout.Parent    = AutoFavSection
    sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sectionLayout.Padding   = UDim.new(0, 6)

    local function makeRow(title, height)
        local row = Instance.new("Frame")
        row.Parent                  = AutoFavSection
        row.Size                    = UDim2.new(1,0,0,height or 36)
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

    local function makeSmallButton(row, text)
        local btn = Instance.new("TextButton")
        btn.Parent                  = row
        btn.Size                    = UDim2.new(0,120,0,24)
        btn.Position                = UDim2.new(1,-136,0.5,-12)
        btn.BackgroundColor3        = CARD or Color3.fromRGB(40,40,60)
        btn.BackgroundTransparency  = 0.1
        btn.Text                    = text
        btn.TextColor3              = THEME_TEXT
        btn.Font                    = Enum.Font.GothamBold
        btn.TextSize                = 12
        btn.AutoButtonColor         = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
        return btn
    end

    -- toggle engine (loop)
    do
        local row = makeRow("Enable Auto Favorite (Loop)")
        local pill = Instance.new("TextButton")
        pill.Parent                  = row
        pill.Size                    = UDim2.new(0,50,0,24)
        pill.Position                = UDim2.new(1,-80,0.5,-12)
        pill.BackgroundColor3        = MUTED or Color3.fromRGB(70,70,90)
        pill.BackgroundTransparency  = 0.1
        pill.Text                    = ""
        pill.AutoButtonColor         = false
        Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

        local knob = Instance.new("Frame")
        knob.Parent                  = pill
        knob.Size                    = UDim2.new(0,18,0,18)
        knob.Position                = UDim2.new(0,3,0.5,-9)
        knob.BackgroundColor3        = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

        local function refresh()
            pill.BackgroundColor3 = _G.RAYFavOn
                and (ACCENT or Color3.fromRGB(0,200,100))
                or  (MUTED or Color3.fromRGB(70,70,90))
            knob.Position = _G.RAYFavOn
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        pill.MouseButton1Click:Connect(function()
            _G.RAYFavOn = not _G.RAYFavOn
            if _G.RAYFavOn then
                StartAutoFavorite()
            else
                StopAutoFavorite()
            end
            refresh()
            if NotifyFeature then
                NotifyFeature("Auto Favorite Engine", _G.RAYFavOn)
            end
        end)

        if _G.RAYFavOn then
            StartAutoFavorite()
        end
        refresh()
    end

    -- tombol panel rarity
    do
        local row = makeRow("Rarity Filter Panel")
        local btn = makeSmallButton(row, "Open")
        btn.MouseButton1Click:Connect(function()
            FavRarityRightPanel.Visible  = not FavRarityRightPanel.Visible
            FavFishRightPanel.Visible    = false
            FavVariantRightPanel.Visible = false
        end)
    end

    -- tombol panel fish
    do
        local row = makeRow("Fish Name Filter Panel")
        local btn = makeSmallButton(row, "Open")
        btn.MouseButton1Click:Connect(function()
            FavFishRightPanel.Visible    = not FavFishRightPanel.Visible
            FavRarityRightPanel.Visible  = false
            FavVariantRightPanel.Visible = false
        end)
    end

    -- tombol panel variant
    do
        local row = makeRow("Variant Filter Panel")
        local btn = makeSmallButton(row, "Open")
        btn.MouseButton1Click:Connect(function()
            FavVariantRightPanel.Visible = not FavVariantRightPanel.Visible
            FavRarityRightPanel.Visible  = false
            FavFishRightPanel.Visible    = false
        end)
    end
end

----------------------------------------------------------------
-- CLOSE PANEL KALAU KLIK DI LUAR
----------------------------------------------------------------
UIS.InputBegan:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
    and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local pos = input.Position

    local function insidePanel(panel)
        if not panel.Visible then return false end
        local ap = panel.AbsolutePosition
        local as = panel.AbsoluteSize
        return pos.X >= ap.X and pos.X <= ap.X + as.X
            and pos.Y >= ap.Y and pos.Y <= ap.Y + as.Y
    end

    if not insidePanel(FavRarityRightPanel)
    and not insidePanel(FavFishRightPanel)
    and not insidePanel(FavVariantRightPanel) then
        FavRarityRightPanel.Visible  = false
        FavFishRightPanel.Visible    = false
        FavVariantRightPanel.Visible = false
    end
end)

----------------------------------------------------------------
-- AUTO TOTEM MIX (BETA) 🗿 - FLOAT TWEEN, RADIUS 100, DELAY 1s
-- Numpang di backend & UI yang SUDAH ADA
----------------------------------------------------------------

_G.RAYAutoTotemMixOn = _G.RAYAutoTotemMixOn or false

local TweenService = game:GetService("TweenService")
local MIX_TYPES = { "Lucky", "Mutasi", "Shiny" }

-- GERAK MELAYANG (pakai Player dari header kamu)
local function floatTweenTo(targetPos, duration)
    duration = duration or 1.5

    if not Player.Character then return false end
    local hrp = Player.Character:FindFirstChild("HumanoidRootPart")
    local hum = Player.Character:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return false end

    hum:ChangeState(Enum.HumanoidStateType.Physics)
    hrp.Anchored = true

    local finishCFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0), targetPos + Vector3.new(0,3,-10))

    local tweenInfo = TweenInfo.new(
        duration,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.InOut
    )

    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = finishCFrame})
    tween:Play()
    tween.Completed:Wait()

    hrp.Anchored = false
    hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)

    return true
end

-- POSISI SEGITIGA
local function getTotemPositions(origin, radius)
    radius = radius or 100
    local positions = {}

    for i = 0, 2 do
        local angle = (math.pi * 2 / 3) * i
        local offset = Vector3.new(math.cos(angle), 0, math.sin(angle)) * radius
        table.insert(positions, origin + offset)
    end

    return positions
end

local function PlaceMixedTotems()
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
        if NotifyFeature then
            NotifyFeature("Character belum siap", false)
        end
        return
    end

    local hrp = Player.Character.HumanoidRootPart
    local origin = hrp.Position
    local positions = getTotemPositions(origin, 100)

    for i, jenis in ipairs(MIX_TYPES) do
        local uuid = findTotemUuidByType(jenis)
        if uuid then
            local targetPos = positions[i]

            local ok = floatTweenTo(targetPos, 1.2)
            if not ok then
                if NotifyFeature then
                    NotifyFeature("Gagal melayang ke posisi untuk "..jenis, false)
                end
            else
                local dist = (targetPos - origin).Magnitude

                task.wait(1) -- delay fix 1 detik

                SpawnTotemUUID(uuid)
                if NotifyFeature then
                    NotifyFeature(string.format("Spawn %s Totem (Mix, jarak %.1f)", jenis, dist), true)
                end
                task.wait(0.2)
            end
        else
            if NotifyFeature then
                NotifyFeature("Totem "..jenis.." tidak ditemukan", false)
            end
        end
    end

    floatTweenTo(origin, 1.2)
    if NotifyFeature then
        NotifyFeature("Auto Totem Mix selesai", true)
    end
end

----------------------------------------------------------------
-- PANEL KANAN AUTO TOTEM MIX (TEXTBOX NAMA TOTEM)
----------------------------------------------------------------

local TotemMixRightPanel = Instance.new("Frame")
TotemMixRightPanel.Name = "AutoTotemMixRightPanel"
TotemMixRightPanel.Size = UDim2.new(0, 220, 1, -46)
TotemMixRightPanel.AnchorPoint = Vector2.new(1, 0)
TotemMixRightPanel.Position = UDim2.new(1, -10, 0, 40)
TotemMixRightPanel.BackgroundColor3 = CARD or Color3.fromRGB(15, 15, 25)
TotemMixRightPanel.BackgroundTransparency = 0.25
TotemMixRightPanel.BorderSizePixel = 0
TotemMixRightPanel.Visible = false
TotemMixRightPanel.ZIndex = 10
TotemMixRightPanel.Parent = Main

Instance.new("UICorner", TotemMixRightPanel).CornerRadius = UDim.new(0, 10)
local tmStroke = Instance.new("UIStroke", TotemMixRightPanel)
tmStroke.Color = THEME_MAIN
tmStroke.Transparency = 0.5

local tmTitle = Instance.new("TextLabel")
tmTitle.Parent = TotemMixRightPanel
tmTitle.Size = UDim2.new(1, -10, 0, 24)
tmTitle.Position = UDim2.new(0, 5, 0, 6)
tmTitle.BackgroundTransparency = 1
tmTitle.Font = Enum.Font.GothamBold
tmTitle.TextSize = 16
tmTitle.TextXAlignment = Enum.TextXAlignment.Left
tmTitle.TextColor3 = THEME_TEXT
tmTitle.ZIndex = 11
tmTitle.Text = "Auto Totem Mix (BETA)"

local tmInfo = Instance.new("TextLabel")
tmInfo.Parent = TotemMixRightPanel
tmInfo.Size = UDim2.new(1, -10, 0, 18)
tmInfo.Position = UDim2.new(0, 5, 0, 30)
tmInfo.BackgroundTransparency = 1
tmInfo.Font = Enum.Font.Gotham
tmInfo.TextSize = 12
tmInfo.TextXAlignment = Enum.TextXAlignment.Left
tmInfo.TextColor3 = Color3.fromRGB(200,200,200)
tmInfo.ZIndex = 11
tmInfo.Text = "Pattern: Lucky, Mutasi, Shiny (segitiga, radius ~100)."

local tmScroll = Instance.new("ScrollingFrame")
tmScroll.Parent = TotemMixRightPanel
tmScroll.Size = UDim2.new(1, -10, 1, -70)
tmScroll.Position = UDim2.new(0, 5, 0, 54)
tmScroll.BackgroundTransparency = 1
tmScroll.BorderSizePixel = 0
tmScroll.ScrollBarThickness = 3
tmScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
tmScroll.CanvasSize = UDim2.new(0,0,0,0)
tmScroll.ScrollBarImageColor3 = THEME_MAIN
tmScroll.ZIndex = 10

local tmList = Instance.new("UIListLayout", tmScroll)
tmList.SortOrder = Enum.SortOrder.LayoutOrder
tmList.Padding = UDim.new(0,4)

local function CreateMixTextBox(jenis, index)
    local id = TotemTypeId[jenis]

    local row = Instance.new("Frame")
    row.Parent = tmScroll
    row.Size = UDim2.new(1, -4, 0, 28)
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    row.ZIndex = 11

    local label = Instance.new("TextLabel")
    label.Parent = row
    label.Size = UDim2.new(0.45, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = THEME_TEXT
    label.Text = string.format("#%d Totem:", index)

    local box = Instance.new("TextBox")
    box.Parent = row
    box.Size = UDim2.new(0.5, 0, 1, 0)
    box.Position = UDim2.new(0.45, 0, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(25,25,40)
    box.BorderSizePixel = 0
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    box.TextColor3 = THEME_TEXT
    box.ClearTextOnFocus = false
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.Text = jenis.." ["..tostring(id).."]"
    box.PlaceholderText = jenis.." ["..tostring(id).."]"
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)

    box.FocusLost:Connect(function()
        box.Text = jenis.." ["..tostring(id).."]"
    end)
end

for i, jenis in ipairs(MIX_TYPES) do
    CreateMixTextBox(jenis, i)
end

UIS.InputBegan:Connect(function(input)
    if not TotemMixRightPanel.Visible then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
    and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local pos = input.Position
    local absPos = TotemMixRightPanel.AbsolutePosition
    local absSize = TotemMixRightPanel.AbsoluteSize

    local inside =
        pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
        pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y

    if not inside then
        TotemMixRightPanel.Visible = false
    end
end)

----------------------------------------------------------------
-- TOGGLE AUTO TOTEM MIX DI SECTION "AUTO TOTEM" YANG SUDAH ADA
----------------------------------------------------------------

do
    -- pakai makeRow & makeSmallButton dari Auto Totem di atas
    local row = (function()
        local r = Instance.new("Frame")
        r.Parent                 = AutoTotemSection
        r.Size                   = UDim2.new(1,0,0,36)
        r.BackgroundTransparency = 1

        local label = Instance.new("TextLabel")
        label.Parent             = r
        label.Size               = UDim2.new(1,-110,1,0)
        label.Position           = UDim2.new(0,16,0,0)
        label.BackgroundTransparency = 1
        label.Font               = Enum.Font.Gotham
        label.TextSize           = 13
        label.TextXAlignment     = Enum.TextXAlignment.Left
        label.TextColor3         = TEXT or THEME_TEXT
        label.Text               = "Enable Auto Totem Mix (3x)"
        return r
    end)()

    local pill = Instance.new("TextButton")
    pill.Parent                  = row
    pill.Size                    = UDim2.new(0,50,0,24)
    pill.Position                = UDim2.new(1,-80,0.5,-12)
    pill.BackgroundColor3        = MUTED or Color3.fromRGB(70,70,90)
    pill.BackgroundTransparency  = 0.1
    pill.Text                    = ""
    pill.AutoButtonColor         = false
    Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

    local knob = Instance.new("Frame")
    knob.Parent                  = pill
    knob.Size                    = UDim2.new(0,18,0,18)
    knob.Position                = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3        = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local function refreshMix()
        pill.BackgroundColor3 = _G.RAYAutoTotemMixOn
            and (ACCENT or Color3.fromRGB(0,200,150))
            or  (MUTED or Color3.fromRGB(70,70,90))
        knob.Position = _G.RAYAutoTotemMixOn
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        _G.RAYAutoTotemMixOn = not _G.RAYAutoTotemMixOn
        refreshMix()

        if _G.RAYAutoTotemMixOn then
            PlaceMixedTotems()
            _G.RAYAutoTotemMixOn = false
            refreshMix()
        end
    end)

    refreshMix()

    -- tombol buka panel mix
    local row2 = Instance.new("Frame")
    row2.Parent                 = AutoTotemSection
    row2.Size                   = UDim2.new(1,0,0,36)
    row2.BackgroundTransparency = 1

    local label2 = Instance.new("TextLabel")
    label2.Parent               = row2
    label2.Size                 = UDim2.new(1,-110,1,0)
    label2.Position             = UDim2.new(0,16,0,0)
    label2.BackgroundTransparency = 1
    label2.Font                 = Enum.Font.Gotham
    label2.TextSize             = 13
    label2.TextXAlignment       = Enum.TextXAlignment.Left
    label2.TextColor3           = TEXT or THEME_TEXT
    label2.Text                 = "Totem Mix Panel"

    local btn = Instance.new("TextButton")
    btn.Parent                  = row2
    btn.Size                    = UDim2.new(0,120,0,24)
    btn.Position                = UDim2.new(1,-136,0.5,-12)
    btn.BackgroundColor3        = CARD or Color3.fromRGB(40,40,60)
    btn.BackgroundTransparency  = 0.1
    btn.Text                    = "Open"
    btn.TextColor3              = THEME_TEXT
    btn.Font                    = Enum.Font.GothamBold
    btn.TextSize                = 12
    btn.AutoButtonColor         = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    btn.MouseButton1Click:Connect(function()
        TotemMixRightPanel.Visible = not TotemMixRightPanel.Visible
    end)
end
