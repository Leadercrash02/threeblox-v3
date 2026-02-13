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
-- AUTO FAVORITE FISH BACKEND
----------------------------------------------------------------
local RS = ReplicatedStorage
local lp = Player

local Items = require(RS.Items)
local Tiers = require(RS.Tiers or RS:WaitForChild("Tiers"))
local ReplionFav = require(RS.Packages.Replion)

local FavoriteRemote = Net:WaitForChild("RE/FavoriteItem")

local ItemDataById = {}
for _, v in Items do
    if v.Data and v.Data.Id then
        ItemDataById[v.Data.Id] = v.Data
    end
end

local TierByIndex = {}
for _, info in Tiers do
    TierByIndex[info.Tier] = info
end

_G.RAYFavOn             = _G.RAYFavOn or false
_G.RAYFavCurrentOn      = _G.RAYFavCurrentOn or false
_G.RAYFavSelectedNames  = _G.RAYFavSelectedNames or {}

_G.RAYFavLegendOn = _G.RAYFavLegendOn or false
_G.RAYFavMythicOn = _G.RAYFavMythicOn or false
_G.RAYFavSecretOn = _G.RAYFavSecretOn or false

local function getTierFromItem(data)
    if data.Tier then
        return TierByIndex[data.Tier] or TierByIndex[1]
    end
    return TierByIndex[1]
end

local function passesRarityFilterFav(data)
    local tierInfo = getTierFromItem(data)
    local rName = tierInfo and tierInfo.Name
    if not rName then return false end

    if not _G.RAYFavLegendOn and not _G.RAYFavMythicOn and not _G.RAYFavSecretOn then
        return true
    end

    if rName == "Legendary" and _G.RAYFavLegendOn then return true end
    if rName == "Mythic" and _G.RAYFavMythicOn then return true end
    if rName == "SECRET" and _G.RAYFavSecretOn then return true end
    return false
end

local function passesNameFilterFav(data)
    local sel = _G.RAYFavSelectedNames
    if not sel or next(sel) == nil then
        return true
    end
    return data.Name and sel[data.Name] == true
end

local function shouldFavoriteId(id)
    local data = ItemDataById[id]
    if not data or data.Type ~= "Fish" then return false end
    if not passesRarityFilterFav(data) then return false end
    if not passesNameFilterFav(data) then return false end
    return true
end

local function getInvItems()
    local repl = ReplionFav.Client:WaitReplion("Data")
    local root = repl.Data
    local inv = root and root.Inventory
    return (inv and inv.Items) or {}
end

function AutoFavoriteOnce()
    local items = getInvItems()
    for _, entry in pairs(items) do
        local id = entry.Id
        local uuid = entry.UUID
        if id and uuid and shouldFavoriteId(id) then
            FavoriteRemote:FireServer(uuid)
        end
    end
end

function GetCurrentEquippedFishUUID()
    local ok, data = pcall(function()
        local r = ReplionFav.Client:WaitReplion("Data")
        return r.Data
    end)
    if not ok or not data then return nil end

    local inv = data.Inventory
    local items = inv and inv.Items
    if typeof(items) ~= "table" then return nil end

    local currentUuid = data.CurrentFishUUID
    if not currentUuid then return nil end

    for _, entry in pairs(items) do
        if entry.UUID == currentUuid and shouldFavoriteId(entry.Id) then
            return entry.UUID
        end
    end
    return nil
end

function AutoFavoriteCurrentOnce()
    local uuid = GetCurrentEquippedFishUUID()
    if uuid then
        FavoriteRemote:FireServer(uuid)
    end
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
local AutoFishAFK = AutoFishAFK or false
local isFishing   = false

-- AFK mode
local DelayReel  = DelayReel  or 0.3
local DelayCatch = DelayCatch or 0.3

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

local function Cast_V3()
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

        local power  = basePower
        local factor = baseFactor

        Events.minigame:InvokeServer(power, factor, serverTime)
    end)
end

----------------------------------------------------------------
-- ENGINE: AUTO FISH FEEL V2 (AFK SAJA)
----------------------------------------------------------------
local function Engine_V3_Delayed()
    if isFishing or not AutoFishAFK then return end
    isFishing = true

    Cast_V3()
    task.wait(DelayReel)

    Complete_V3()
    task.wait(DelayCatch)

    isFishing = false
end

----------------------------------------------------------------
-- ENGINE: LEGIT PERFECT V1 (TARGET ~98%)
----------------------------------------------------------------
local LegitPerfectOn = _G.RAY_LegitPerfect or false
_G.RAY_LegitPerfect  = LegitPerfectOn

local function SetAutoFishingState(on)
    LegitPerfectOn      = on and true or false
    _G.RAY_LegitPerfect = LegitPerfectOn

    -- sync ke server (mode auto bawaan game)
    pcall(function()
        if Events.UpdateAutoFishing then
            Events.UpdateAutoFishing:InvokeServer(LegitPerfectOn)
        end
    end)
end

local function Cast_V3_LegitPerfect()
    pcall(function()
        if not Events or not Events.minigame or not Events.charge then
            return
        end

        if Events.equip then
            Events.equip:FireServer(1)
        end

        Events.charge:InvokeServer()

        local serverTime = Workspace:GetServerTimeNow()

        -- base yang sebelumnya kamu pakai buat perfect
        local basePower  = 3.376763343811035
        local baseFactor = 0.623453255714559

        local power, factor

        -- langkah 1: bikin dulu 100% perfect (tanpa jitter)
        power  = basePower
        factor = baseFactor

        Events.minigame:InvokeServer(power, factor, serverTime)
    end)
end

local function Engine_LegitPerfect()
    if isFishing or not LegitPerfectOn then return end
    isFishing = true

    Cast_V3_LegitPerfect()
    task.wait(DelayReel)

    Complete_V3()
    task.wait(DelayCatch)

    isFishing = false
end

----------------------------------------------------------------
-- LOOP UTAMA: PILIH ANTARA AFK BIASA ATAU LEGIT PERFECT
----------------------------------------------------------------
task.spawn(function()
    while true do
        task.wait(0.05)

        if LegitPerfectOn then
            Engine_LegitPerfect()
        else
            Engine_V3_Delayed() -- engine AFK lama
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
-- DISABLE CUTSCENE (SKIP VISUAL, MANCING LANJUT) - DI DALAM FISHING SUPPORT
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
    label.TextColor3 = TEXT or THEME_TEXT
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

    -- status global biar ke-remember
    local enabled = _G.RAY_DisableCutscene or false

    -- cache fungsi GuiControl asli biar bisa balikin
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local GuiControl = require(ReplicatedStorage.Modules.GuiControl)

    _G.__RAY_OldGuiControlClose = _G.__RAY_OldGuiControlClose or GuiControl.Close
    _G.__RAY_OldGuiControlLock  = _G.__RAY_OldGuiControlLock  or GuiControl.Lock
    _G.__RAY_OldGuiControlHUD   = _G.__RAY_OldGuiControlHUD   or GuiControl.SetHUDVisibility

    local function applyPatch()
        -- Skip efek cutscene: jangan tutup/lock HUD & kontrol
        function GuiControl:Close(skipHud)
            -- no-op: jangan lakukan apa-apa, biar fishing/GUI ga ke-close
            return
        end

        function GuiControl:Lock()
            -- no-op: jangan kunci movement / input
            return
        end

        function GuiControl:SetHUDVisibility(flag)
            -- optional: biarin HUD selalu kelihatan, abaikan permintaan cutscene
            return
        end
    end

    local function restorePatch()
        if _G.__RAY_OldGuiControlClose then
            GuiControl.Close = _G.__RAY_OldGuiControlClose
        end
        if _G.__RAY_OldGuiControlLock then
            GuiControl.Lock = _G.__RAY_OldGuiControlLock
        end
        if _G.__RAY_OldGuiControlHUD then
            GuiControl.SetHUDVisibility = _G.__RAY_OldGuiControlHUD
        end
    end

    local function refresh()
        pill.BackgroundColor3 = enabled and THEME_MAIN or (MUTED or Color3.fromRGB(70,70,90))
        knob.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.RAY_DisableCutscene = enabled

        if enabled then
            applyPatch()   -- cutscene dipanggil, tapi efek HUD/lock di-skip
        else
            restorePatch() -- balikin perilaku normal
        end

        refresh()
        if NotifyFeature then
            NotifyFeature("Disable Cutscene", enabled)
        end
    end)

    -- kalau rejoin / script reload dan toggle masih ON, pasang patch lagi
    task.delay(1, function()
        if enabled then
            applyPatch()
            refresh()
        end
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
    label.TextColor3 = TEXT or THEME_TEXT
    label.Text = "No Cutscene Pause"

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

    -- status global biar ke-remember
    local enabled = _G.RAY_NoCutscenePause or false

    -- patch cuma bagian "lock", biar cutscene tetap kelihatan
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local GuiControl = require(ReplicatedStorage.Modules.GuiControl)

    _G.__RAY_OldGuiControlLock = _G.__RAY_OldGuiControlLock or GuiControl.Lock

    local function applyPatch()
        function GuiControl:Lock()
            -- no-op: jangan kunci movement / input
            return
        end
    end

    local function restorePatch()
        if _G.__RAY_OldGuiControlLock then
            GuiControl.Lock = _G.__RAY_OldGuiControlLock
        end
    end

    local function refresh()
        pill.BackgroundColor3 = enabled and THEME_MAIN or (MUTED or Color3.fromRGB(70,70,90))
        knob.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.RAY_NoCutscenePause = enabled

        if enabled then
            applyPatch()    -- cutscene tetap tayang, tapi nggak nge-lock kontrol
        else
            restorePatch()  -- balikin lock normal
        end

        refresh()
        if NotifyFeature then
            NotifyFeature("No Cutscene Pause", enabled)
        end
    end)

    -- kalau rejoin / script reload dan toggle masih ON, pasang patch lagi
    task.delay(1, function()
        if enabled then
            applyPatch()
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

    -- global state biar nyimpen
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
        -- kill semua yang sudah muncul sekarang
        for _, v in ipairs(gui:GetDescendants()) do
            if v.Name == "Small Notification" then
                v:Destroy()
            end
        end
        -- blokir semua yang baru
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
            attach()   -- ON: kill + blokir
        else
            detach()   -- OFF: lepas blok, notifikasi baru boleh muncul lagi
        end

        refresh()
        if NotifyFeature then
            NotifyFeature("Disable Fish Image", enabled)
        end
    end)

    -- init kalau sebelum reload sudah ON
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

    -- init sesuai state
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
-- LEGIT PERFECT SECTION (FISHING PAGE)
----------------------------------------------------------------
local LegitPerfectSection

if AutoPage then
    LegitPerfectSection = CreateSectionDropdown(AutoPage, "Legit Perfect")

    local layout = Instance.new("UIListLayout")
    layout.Parent = LegitPerfectSection
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)

    local line = Instance.new("Frame")
    line.Parent = LegitPerfectSection
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 0, 2)
    line.BackgroundColor3 = THEME_MAIN
    line.BorderSizePixel = 0

    ----------------------------------------------------------------
    -- TOGGLE: ENABLE LEGIT PERFECT ENGINE
    ----------------------------------------------------------------
    do
        local row = Instance.new("Frame")
        row.Parent = LegitPerfectSection
        row.Size = UDim2.new(1,0,0,32)
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
        label.Text = "Enable Legit Perfect"

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

        local enabled = _G.RAY_LegitPerfect or false

        local function refresh()
            pill.BackgroundColor3 = enabled
                and (ACCENT or THEME_MAIN)
                or  (MUTED or Color3.fromRGB(70,70,90))

            knob.Position = enabled
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        pill.MouseButton1Click:Connect(function()
            enabled = not enabled
            SetAutoFishingState(enabled)  -- sync global + server

            -- opsional: kalau Legit Perfect ON, matikan AFK biasa
            if enabled then
                AutoFishAFK = false
                _G.RAY_LegitPerfect = true
            else
                _G.RAY_LegitPerfect = false
            end

            refresh()
            if NotifyFeature then
                NotifyFeature("Legit Perfect Engine", enabled)
            end
        end)

        refresh()
    end
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
