--// THREEBLOX V3 | AUTO OPTION FIX FINAL
--// ADD: DROPDOWN + MINIMIZE + CLOSE + LOGO FLOAT
--// SAFE | TRANSPARENT | XENO PC + ANDROID

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- CLEAN
pcall(function()
    for _,v in ipairs(CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == "ThreebloxV3" then
            v:Destroy()
        end
    end
end)

-- CONFIG
local LOGO_ID = "rbxassetid://121625492591707"

local BG     = Color3.fromRGB(18,20,28)
local SIDE   = Color3.fromRGB(22,24,34)
local CARD   = Color3.fromRGB(28,30,42)
local TEXT   = Color3.fromRGB(235,235,235)
local MUTED  = Color3.fromRGB(160,160,160)
local ACCENT = Color3.fromRGB(170,80,255)

local ALPHA_MAIN = 0.08
local ALPHA_SIDE = 0.05
local ALPHA_CARD = 0.06

local PAGE_ICONS = {
    {"Information","📘"},
    {"Auto Option","⚙️"},
    {"Teleport","🧭"},
    {"Quest","⭐"},
    {"Shop & Trade","💰"},
    {"Misc","⚡"},
}

local AUTO_OPTIONS = {
    {"Auto Fishing",""},
    {"Blatant Fishing",""},
    {"Auto Farm Island",""},
    {"Auto Favorite",""},
    {"Auto Sell",""},
    {"Auto Totem",""},
    {"Auto Potion",""},
}

local ISLAND_SPOTS = {
    ["Iron Cafe"]       = CFrame.new(-8794.9541, -585.00018, 225.19032),
    ["Cafe Besi"]       = CFrame.new(-8642.2588, -547.50031, 161.28636),
    ["Christmas Spot"]  = CFrame.new(1138.9039, 23.43064, 1560.8541),
    ["Kedalaman Excortic"] = CFrame.new(3232.9036, -1302.8549, 1401.0824),
    ["Pulau Kawah"]     = CFrame.new(1000.1009, 18.02404, 5093.1221),
    ["Hutan Kuno"]      = CFrame.new(1470.9269, 4.5879965, -323.6044),
    ["Temple Guardian"] = CFrame.new(1486.0616, 127.62498, -590.1211),
    ["Kuil Suci"]       = CFrame.new(1496.1331, -22.125002, -639.2121),
    ["Ancient Ruin"]    = CFrame.new(6081.9009, -585.92419, 4634.6240),
    ["Kohana"]          = CFrame.new(-603.82385, 17.250059, 514.24432),
    ["Kohana Volcano"]  = CFrame.new(-617.46448, 48.560577, 189.16815),
    ["Fisherman Spawn"] = CFrame.new(90.31225, 17.033522, 2839.8655),
    ["Sysphus State"]   = CFrame.new(-3698.2456, -135.07391, -1007.7955),
    ["Harta Karun"]     = CFrame.new(-3595.2686, -275.74152, -1639.2794),
    ["Weater Machine"]  = CFrame.new(-1489.2069, 3.5, 1917.9594),
    ["Coral Reefs"]     = CFrame.new(-2755.0881, 4.0107765, 2163.7251),
    ["Hutan Tropis"]    = CFrame.new(-2016.4812, 9.037539, 3752.3533),
}

local DEFAULT_SPOT_ORDER = {
    "Fisherman Spawn",
    "Kohana",
    "Kohana Volcano",
    "Pulau Kawah",
    "Ancient Ruin",
    "Hutan Kuno",
    "Kuil Suci",
    "Temple Guardian",
    "Iron Cafe",
    "Cafe Besi",
    "Sysphus State",
    "Harta Karun",
    "Weater Machine",
    "Coral Reefs",
    "Hutan Tropis",
    "Christmas Spot",
    "Kedalaman Excortic",
}


-- ROOT
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true

-- MAIN
local main = Instance.new("Frame", gui)
local mainPad = Instance.new("UIPadding", main)
mainPad.PaddingBottom = UDim.new(0, 12)
main.Size = UDim2.new(0,880,0,500)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
main.BackgroundTransparency = ALPHA_MAIN
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,48)
header.BackgroundTransparency = 1
header.Active = true

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-160,1,0)
title.Position = UDim2.new(0,16,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = TEXT
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "Threeblox V3 | Auto Option"

-- BUTTONS
local btnMin = Instance.new("TextButton", header)
btnMin.Size = UDim2.new(0,36,0,36)
btnMin.Position = UDim2.new(1,-88,0.5,-18)
btnMin.Text = "-"
btnMin.Font = Enum.Font.GothamBold
btnMin.TextSize = 22
btnMin.TextColor3 = TEXT
btnMin.BackgroundColor3 = CARD
btnMin.BackgroundTransparency = ALPHA_CARD
Instance.new("UICorner", btnMin).CornerRadius = UDim.new(1,0)

local btnClose = Instance.new("TextButton", header)
btnClose.Size = UDim2.new(0,36,0,36)
btnClose.Position = UDim2.new(1,-44,0.5,-18)
btnClose.Text = "X"
btnClose.Font = Enum.Font.GothamBold
btnClose.TextSize = 18
btnClose.TextColor3 = TEXT
btnClose.BackgroundColor3 = CARD
btnClose.BackgroundTransparency = ALPHA_CARD
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(1,0)

-- DRAG
do
    local dragging, startPos, startMain
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = i.Position
            startMain = main.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging then
            local delta = i.Position - startPos
            main.Position = UDim2.new(startMain.X.Scale,startMain.X.Offset + delta.X,startMain.Y.Scale,startMain.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function()
        dragging = false
    end)
end

-- LOGO FLOAT
local miniLogo = Instance.new("ImageButton", gui)
miniLogo.Size = UDim2.new(0,56,0,56)
miniLogo.Position = UDim2.new(0,20,0.5,-28)
miniLogo.Image = LOGO_ID
miniLogo.Visible = false
miniLogo.BackgroundColor3 = CARD
miniLogo.BackgroundTransparency = ALPHA_CARD
Instance.new("UICorner", miniLogo).CornerRadius = UDim.new(1,0)

btnMin.MouseButton1Click:Connect(function()
    main.Visible = false
    miniLogo.Visible = true
end)

miniLogo.MouseButton1Click:Connect(function()
    main.Visible = true
    miniLogo.Visible = false
end)

btnClose.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,48)
sidebar.Size = UDim2.new(0,200,1,-48)
sidebar.BackgroundColor3 = SIDE
sidebar.BackgroundTransparency = ALPHA_SIDE

local sidePad = Instance.new("UIPadding", sidebar)
sidePad.PaddingTop = UDim.new(0,12)
sidePad.PaddingLeft = UDim.new(0,12)
sidePad.PaddingRight = UDim.new(0,12)

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,8)
sideLayout.FillDirection = Enum.FillDirection.Vertical
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- CONTENT
local content = Instance.new("ScrollingFrame", main)
content.ScrollingEnabled = false
content.ScrollBarThickness = 0
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Position = UDim2.new(0,200,0,48)
content.Size = UDim2.new(1,-200,1,-48)
content.CanvasSize = UDim2.new(0,0,0,0)
content.BackgroundTransparency = 1

local contentLayout = Instance.new("UIListLayout", content)
contentLayout.Padding = UDim.new(0,0)

-- PAGE SYSTEM
local pages = {}
local function newPage(name)
    local p = Instance.new("Frame", content)
    p.Size = UDim2.new(1,0,0,0)
    p.AutomaticSize = Enum.AutomaticSize.Y
    p.Visible = false
    p.BackgroundTransparency = 1
    pages[name] = p
    return p
end

local autoPage = newPage("Auto Option")
autoPage.Size = UDim2.new(1,0,1,0)
autoPage.ClipsDescendants = false
newPage("Information")
newPage("Teleport")
newPage("Quest")
newPage("Shop & Trade")
newPage("Misc")

-- BUTTON SIDEBAR
local function sideBtn(name, emoji, order)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.new(1,0,0,38)
    b.LayoutOrder = order
    b.Text = emoji.." "..name
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = TEXT
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.BackgroundColor3 = CARD
    b.BackgroundTransparency = ALPHA_CARD
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    b.AutoButtonColor = false
    b.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible = false end
        pages[name].Visible = true
        title.Text = "Threeblox V3 | "..name
    end)
end

-- BUAT TOMBOL SIDEBAR
for i, info in ipairs(PAGE_ICONS) do
    local name, emoji = info[1], info[2]
    sideBtn(name, emoji, i)
end

-- DEFAULT PAGE
for _, p in pairs(pages) do
    p.Visible = false
end
pages["Auto Option"].Visible = true

----------------------------------------------------------------
-- TELEPORT PAGE (ROW + DROPDOWN TELEPORT TO PLAYER, COMPACT)
----------------------------------------------------------------
local teleportPage = pages["Teleport"]

-- TITLE ATAS TELEPORT
local tpTitleMain = Instance.new("TextLabel", teleportPage)
tpTitleMain.Size = UDim2.new(1,-32,0,32)
tpTitleMain.Position = UDim2.new(0,16,0,16)
tpTitleMain.BackgroundTransparency = 1
tpTitleMain.Font = Enum.Font.GothamBold
tpTitleMain.TextSize = 18
tpTitleMain.TextColor3 = TEXT
tpTitleMain.TextXAlignment = Enum.TextXAlignment.Left
tpTitleMain.Text = "Teleport"  -- [file:3]

-- ROW: TELEPORT TO PLAYER
local rowPlayer = Instance.new("TextButton", teleportPage)
rowPlayer.Size = UDim2.new(1,-32,0,34)
rowPlayer.Position = UDim2.new(0,16,0,52)
rowPlayer.BackgroundColor3 = CARD
rowPlayer.BackgroundTransparency = ALPHA_CARD
rowPlayer.AutoButtonColor = false
rowPlayer.Font = Enum.Font.Gotham
rowPlayer.TextSize = 13
rowPlayer.TextXAlignment = Enum.TextXAlignment.Left
rowPlayer.TextColor3 = TEXT
rowPlayer.Text = "  Teleport to Player  >"
Instance.new("UICorner", rowPlayer).CornerRadius = UDim.new(0,8)

-- FRAME ISI (KELUAR PAS ROW DIKLIK)
local tpPlayerFrame = Instance.new("Frame", teleportPage)
tpPlayerFrame.Size = UDim2.new(1,-40,0,120)      -- lebih pendek & sedikit masuk
tpPlayerFrame.Position = UDim2.new(0,20,0,92)
tpPlayerFrame.BackgroundTransparency = 1
tpPlayerFrame.Visible = false

local tpCard = Instance.new("Frame", tpPlayerFrame)
tpCard.Size = UDim2.new(1,0,1,0)
tpCard.BackgroundColor3 = CARD
tpCard.BackgroundTransparency = 0.12             -- agak transparan
Instance.new("UICorner", tpCard).CornerRadius = UDim.new(0,10)

local tpPad = Instance.new("UIPadding", tpCard)
tpPad.PaddingTop = UDim.new(0,10)
tpPad.PaddingLeft = UDim.new(0,14)
tpPad.PaddingRight = UDim.new(0,14)
tpPad.PaddingBottom = UDim.new(0,10)

local tpTitle = Instance.new("TextLabel", tpCard)
tpTitle.Size = UDim2.new(1,0,0,22)
tpTitle.BackgroundTransparency = 1
tpTitle.Font = Enum.Font.GothamBold
tpTitle.TextSize = 15
tpTitle.TextColor3 = TEXT
tpTitle.TextXAlignment = Enum.TextXAlignment.Left
tpTitle.Text = "Teleport to Player"

-- SELECT PLAYER BUTTON (lebih tipis)
local selectBtn = Instance.new("TextButton", tpCard)
selectBtn.Size = UDim2.new(1,0,0,26)
selectBtn.Position = UDim2.new(0,0,0,26)
selectBtn.BackgroundColor3 = CARD
selectBtn.BackgroundTransparency = 0.16
selectBtn.AutoButtonColor = false
selectBtn.Font = Enum.Font.Gotham
selectBtn.TextSize = 12
selectBtn.TextColor3 = MUTED
selectBtn.TextXAlignment = Enum.TextXAlignment.Left
selectBtn.Text = "  Select Player"
Instance.new("UICorner", selectBtn).CornerRadius = UDim.new(0,8)

-- TELEPORT BUTTON (lebih tipis)
local tpBtn = Instance.new("TextButton", tpCard)
tpBtn.Size = UDim2.new(1,0,0,28)
tpBtn.Position = UDim2.new(0,0,0,56)
tpBtn.BackgroundColor3 = ACCENT
tpBtn.BackgroundTransparency = 0.08
tpBtn.AutoButtonColor = false
tpBtn.Font = Enum.Font.Gotham
tpBtn.TextSize = 12
tpBtn.TextColor3 = TEXT
tpBtn.Text = "Teleport To Player"
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,8)

-- REFRESH BUTTON (lebih kecil)
local refreshBtn = Instance.new("TextButton", tpCard)
refreshBtn.Size = UDim2.new(1,0,0,24)
refreshBtn.Position = UDim2.new(0,0,0,88)
refreshBtn.BackgroundColor3 = CARD
refreshBtn.BackgroundTransparency = 0.18
refreshBtn.AutoButtonColor = false
refreshBtn.Font = Enum.Font.Gotham
refreshBtn.TextSize = 12
refreshBtn.TextColor3 = TEXT
refreshBtn.TextXAlignment = Enum.TextXAlignment.Center
refreshBtn.Text = "Refresh Player"
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0,8)

-- PANEL DROPDOWN SAMPING (SEARCH + LIST PLAYER)
local dropFrame = Instance.new("Frame", teleportPage)
dropFrame.Size = UDim2.new(0,240,0,200)
dropFrame.Position = UDim2.new(0,20+260,0,52)
dropFrame.BackgroundColor3 = CARD
dropFrame.BackgroundTransparency = 0.06
dropFrame.Visible = false
Instance.new("UICorner", dropFrame).CornerRadius = UDim.new(0,10)

local dropPad = Instance.new("UIPadding", dropFrame)
dropPad.PaddingTop = UDim.new(0,8)
dropPad.PaddingLeft = UDim.new(0,8)
dropPad.PaddingRight = UDim.new(0,8)
dropPad.PaddingBottom = UDim.new(0,8)

local searchBox = Instance.new("TextBox", dropFrame)
searchBox.Size = UDim2.new(1,0,0,24)
searchBox.PlaceholderText = "Search"
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 12
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.TextColor3 = TEXT
searchBox.ClearTextOnFocus = false
searchBox.BackgroundColor3 = Color3.fromRGB(18,20,28)
searchBox.BackgroundTransparency = 0.1
searchBox.Text = ""
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,8)

local listFrame = Instance.new("ScrollingFrame", dropFrame)
listFrame.Position = UDim2.new(0,0,0,30)
listFrame.Size = UDim2.new(1,0,1,-30)
listFrame.ScrollBarThickness = 4
listFrame.BackgroundTransparency = 1
listFrame.CanvasSize = UDim2.new(0,0,0,0)
listFrame.ClipsDescendants = true

local listLayout = Instance.new("UIListLayout", listFrame)
listLayout.Padding = UDim.new(0,3)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    listFrame.CanvasSize = UDim2.new(0,0,0,listLayout.AbsoluteContentSize.Y + 6)
end)

-- LOGIC TELEPORT PLAYER
local selectedPlayerName = nil

local function passFilter(name, q)
    if q == "" then return true end
    name = string.lower(name)
    q = string.lower(q)
    return string.find(name, q, 1, true) ~= nil
end

local function rebuildDropdown()
    local q = searchBox.Text or ""

    for _,c in ipairs(listFrame:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer and passFilter(plr.Name, q) then
            local b = Instance.new("TextButton", listFrame)
            b.Size = UDim2.new(1,0,0,22)
            b.BackgroundColor3 = CARD
            b.BackgroundTransparency = 0.2
            b.Font = Enum.Font.Gotham
            b.TextSize = 12
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.TextColor3 = TEXT
            b.Text = "  "..plr.Name
            b.AutoButtonColor = false
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

            b.MouseButton1Click:Connect(function()
                selectedPlayerName = plr.Name
                selectBtn.Text = "  "..plr.Name
                selectBtn.TextColor3 = TEXT
                dropFrame.Visible = false
            end)
        end
    end

    if not selectedPlayerName then
        selectBtn.Text = "  Select Player"
        selectBtn.TextColor3 = MUTED
    end
end

searchBox:GetPropertyChangedSignal("Text"):Connect(rebuildDropdown)

-- TOGGLE ISI (ROW > / v)
local playerOpen = false
rowPlayer.MouseButton1Click:Connect(function()
    playerOpen = not playerOpen
    tpPlayerFrame.Visible = playerOpen
    rowPlayer.Text = playerOpen and "  Teleport to Player  v"
        or "  Teleport to Player  >"
end)

-- TOGGLE DROPDOWN PANEL
local dropdownOpen = false
selectBtn.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    dropFrame.Visible = dropdownOpen
    if dropdownOpen then
        searchBox.Text = ""
        rebuildDropdown()
    end
end)

-- ACTION TELEPORT
tpBtn.MouseButton1Click:Connect(function()
    if not selectedPlayerName then return end

    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then return end
    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local lp = Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local myHrp = char:WaitForChild("HumanoidRootPart")

    myHrp.Velocity = Vector3.new(0,0,0)
    myHrp.CFrame   = hrp.CFrame + Vector3.new(0,0,3)
end)

-- REFRESH LIST
refreshBtn.MouseButton1Click:Connect(function()
    selectedPlayerName = nil
    searchBox.Text = ""
    rebuildDropdown()
end)

rebuildDropdown()

-- AUTO CLOSE DROPDOWN KALAU KLIK DI LUAR
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if not dropFrame.Visible then return end

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        local pos = UIS:GetMouseLocation()
        local guiPos = dropFrame.AbsolutePosition
        local guiSize = dropFrame.AbsoluteSize

        local inside =
            pos.X >= guiPos.X and pos.X <= guiPos.X + guiSize.X and
            pos.Y >= guiPos.Y and pos.Y <= guiPos.Y + guiSize.Y

        if not inside then
            dropFrame.Visible = false
            dropdownOpen = false
        end
    end
end)


-- AUTO OPTION PAGE

local scroll = Instance.new("ScrollingFrame", autoPage)
local scrollPad = Instance.new("UIPadding", scroll)
scrollPad.PaddingBottom = UDim.new(0,24)
scroll.Position = UDim2.new(0,16,0,16)
scroll.Size = UDim2.new(1,-32,1,-32)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,10)

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 20)
end)

-- REMOTES
local Net = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")

local Events = {
    fishing  = Net:WaitForChild("RE/FishingCompleted"),
    sell     = Net:WaitForChild("RF/SellAllItems"),
    charge   = Net:WaitForChild("RF/ChargeFishingRod"),
    minigame = Net:WaitForChild("RF/RequestFishingMinigameStarted"),
    cancel   = Net:WaitForChild("RF/CancelFishingInputs"),
    equip    = Net:WaitForChild("RE/EquipToolFromHotbar"),
    unequip  = Net:WaitForChild("RE/UnequipToolFromHotbar"),
}  -- TUTUP TABEL DI SINI

-- ====== TOTEM REMOTE TEST (sementara) ======
local TryNames = {
    "RF/UseTotem",
    "RE/UseTotem",
    "RF/ActivateTotem",
    "RE/ActivateTotem",
    "RF/PlaceTotem",
    "RE/PlaceTotem",
}

for _,n in ipairs(TryNames) do
    local ok, obj = pcall(function()
        return Net:WaitForChild(n, 1)
    end)
    if ok and obj then
        warn("[TOTEM TEST] Found candidate:", n, obj.ClassName)
    end
end
-- ===========================================


-- ENGINE STATE
local AutoFishAFK = false
local isFishing   = false

-- delay Auto Fishing (feel V2)
local DelayReel   = 3   -- sama kayak _G.RAY_DelayCast
local DelayCatch  = 2   -- sama kayak _G.RAY_DelayFinish

-- Blatant state
local BlatantOn     = false
local BlatantReel   = 0.8   -- Reel Delay
local BlatantCatch  = 0.75  -- = 1.5 * 0.5 default

_G.RAY_ExtraCatchBlatant = _G.RAY_ExtraCatchBlatant or false

-- FUNGSI DASAR
local function Reel_V3()
    pcall(function()
        Events.fishing:FireServer()
    end)
end

local function Cast_V3()
    pcall(function()
        Events.equip:FireServer(1)
        task.wait(0.05)
        Events.charge:InvokeServer(workspace:GetServerTimeNow())
        task.wait(0.02)
        Events.minigame:InvokeServer(1.2854545116425, 1)
    end)
end

-- AUTO FISH FEEL V2 (1 cast -> tunggu -> 1 reel -> tunggu)
local function Engine_V3_Delayed()
    if isFishing then return end
    isFishing = true

    Cast_V3()
    task.wait(DelayReel)
    Reel_V3()
    task.wait(DelayCatch)

    isFishing = false
end

-- BLATANT FEEL V2 (3x cast -> tunggu -> 5x reel)
local function BlatantCycle_V2()
    if isFishing or not BlatantOn then return end
    isFishing = true

    pcall(function()
        Events.equip:FireServer(1)
        task.wait(0.01)
        for _ = 1,3 do
            task.spawn(function()
                Events.charge:InvokeServer(workspace:GetServerTimeNow())
                task.wait(0.01)
                Events.minigame:InvokeServer(1.2854545116425, 1)
            end)
            task.wait(0.03)
        end
    end)

    task.wait(BlatantReel)

    for _ = 1,5 do
        Reel_V3()
        task.wait(0.01)
    end

    task.wait(BlatantCatch)
    isFishing = false
end

-- EXTRA CATCH (pakai BlatantCatch sebagai delay)
task.spawn(function()
    while true do
        if BlatantOn and _G.RAY_ExtraCatchBlatant and not isFishing then
            Reel_V3()
            task.wait(BlatantCatch)
        end
        task.wait(0.05)
    end
end)

-- ANTI AFK
task.spawn(function()
    local vu = game:GetService("VirtualUser")
    local lp = game:GetService("Players").LocalPlayer

    lp.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end)



-- ====================== AUTO OPTION CONTENT ======================

-- PANEL ISLAND (SAMPING AUTO OPTION)
local islandPanel = Instance.new("Frame", autoPage)
islandPanel.Size = UDim2.new(0,260,0,320)
islandPanel.Position = UDim2.new(1, -270, 0, 60)
islandPanel.BackgroundColor3 = CARD
islandPanel.BackgroundTransparency = 0.04
islandPanel.Visible = false
Instance.new("UICorner", islandPanel).CornerRadius = UDim.new(0,12)

local panelPad = Instance.new("UIPadding", islandPanel)
panelPad.PaddingTop = UDim.new(0,8)
panelPad.PaddingLeft = UDim.new(0,8)
panelPad.PaddingRight = UDim.new(0,8)
panelPad.PaddingBottom = UDim.new(0,8)

local searchBoxIsland = Instance.new("TextBox", islandPanel)
searchBoxIsland.Size = UDim2.new(1,0,0,28)
searchBoxIsland.PlaceholderText = "Search"
searchBoxIsland.Font = Enum.Font.Gotham
searchBoxIsland.TextSize = 13
searchBoxIsland.TextXAlignment = Enum.TextXAlignment.Left
searchBoxIsland.TextColor3 = TEXT
searchBoxIsland.ClearTextOnFocus = false
searchBoxIsland.BackgroundColor3 = Color3.fromRGB(18,20,28)
searchBoxIsland.BackgroundTransparency = 0.1
searchBoxIsland.Text = ""
Instance.new("UICorner", searchBoxIsland).CornerRadius = UDim.new(0,8)

local islandList = Instance.new("ScrollingFrame", islandPanel)
islandList.Position = UDim2.new(0,0,0,36)
islandList.Size = UDim2.new(1,0,1,-36)
islandList.ScrollBarThickness = 4
islandList.ScrollingDirection = Enum.ScrollingDirection.Y
islandList.CanvasSize = UDim2.new(0,0,0,0)
islandList.BackgroundTransparency = 1
islandList.ClipsDescendants = true

local islandListLayout = Instance.new("UIListLayout", islandList)
islandListLayout.Padding = UDim.new(0,4)
islandListLayout.SortOrder = Enum.SortOrder.LayoutOrder

islandListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    islandList.CanvasSize = UDim2.new(0,0,0,islandListLayout.AbsoluteContentSize.Y + 8)
end)

local islandButtons = {}

local function refreshIslandButton(name)
    local b = islandButtons[name]
    if not b then return end
    local on = _G.RAY_SelectedIslands and _G.RAY_SelectedIslands[name]
    b.BackgroundTransparency = on and 0.02 or 0.18
    b.TextColor3 = on and TEXT or MUTED
end

local function islandPassFilter(name, query)
    if query == "" then return true end
    name  = string.lower(name)
    query = string.lower(query)
    return string.find(name, query, 1, true) ~= nil
end

local function rebuildIslandPanel()
    local query = searchBoxIsland.Text or ""

    for _,c in ipairs(islandList:GetChildren()) do
        if c:IsA("TextButton") then
            c:Destroy()
        end
    end

    for _,name in ipairs(DEFAULT_SPOT_ORDER) do
        if ISLAND_SPOTS[name] and islandPassFilter(name, query) then
            local b = Instance.new("TextButton", islandList)
            b.Size = UDim2.new(1,0,0,26)
            b.BackgroundColor3 = CARD
            b.BackgroundTransparency = 0.18
            b.Font = Enum.Font.Gotham
            b.TextSize = 13
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.TextColor3 = TEXT
            b.Text = "  "..name
            b.AutoButtonColor = false
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

            b.MouseButton1Click:Connect(function()
                local lp = Players.LocalPlayer
                local char = lp.Character or lp.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")

                local cf = ISLAND_SPOTS[name]
                if hrp and cf then
                    hrp.CFrame = cf + Vector3.new(0,3,0)
                    islandPanel.Visible = false
                end
            end)
        end
    end
end




searchBoxIsland:GetPropertyChangedSignal("Text"):Connect(rebuildIslandPanel)
rebuildIslandPanel()

local function autoDropdown(text)
    local holder = Instance.new("Frame", scroll)
    holder.Size = UDim2.new(1,0,0,42)
    holder.BackgroundTransparency = 1

    local icon = Instance.new("TextLabel", holder)
    icon.AnchorPoint = Vector2.new(0,0.5)
    icon.Position = UDim2.new(0,4,0,21)
    icon.Size = UDim2.new(0,20,0,20)
    icon.BackgroundTransparency = 1
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 16
    icon.TextColor3 = ACCENT
    icon.TextXAlignment = Enum.TextXAlignment.Center
    icon.TextYAlignment = Enum.TextYAlignment.Center

    if text == "Auto Fishing" then
        icon.Text = "🎣"
    elseif text == "Blatant Fishing" then
        icon.Text = "⚡"
    elseif text == "Auto Farm Island" then
        icon.Text = "🌴"
    elseif text == "Auto Favorite" then
        icon.Text = "⭐"
    elseif text == "Auto Sell" then
        icon.Text = "💰"
    elseif text == "Auto Totem" then
        icon.Text = "🌀"
    elseif text == "Auto Potion" then
        icon.Text = "🧪"
    else
        icon.Text = "⚙️"
    end

    local card = Instance.new("Frame", holder)
    card.Size = UDim2.new(1,0,1,0)
    card.BackgroundTransparency = 1

    local mainBtn = Instance.new("TextButton", card)
    mainBtn.Size = UDim2.new(1,-8,0,42)
    mainBtn.Position = UDim2.new(0,28,0,0)
    mainBtn.Text = text.."  ▼"
    mainBtn.Font = Enum.Font.Gotham
    mainBtn.TextSize = 15
    mainBtn.TextXAlignment = Enum.TextXAlignment.Left
    mainBtn.TextColor3 = TEXT
    mainBtn.BackgroundColor3 = CARD
    mainBtn.BackgroundTransparency = ALPHA_CARD
    mainBtn.AutoButtonColor = false
    Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0,10)

    local sub = Instance.new("Frame", holder)
    sub.Position = UDim2.new(0,0,0,42)
    sub.Size = UDim2.new(1,0,0,0)
    sub.ClipsDescendants = true
    sub.BackgroundTransparency = 1

    local list = Instance.new("UIListLayout", sub)
    list.Padding = UDim.new(0,6)
    list.SortOrder = Enum.SortOrder.LayoutOrder

    local open = false
    local function recalc()
        task.wait()
        local h = list.AbsoluteContentSize.Y
        if open then
            sub.Size = UDim2.new(1,0,0,h)
            holder.Size = UDim2.new(1,0,0,42 + h)
            mainBtn.Text = text.."  ▲"
        else
            sub.Size = UDim2.new(1,0,0,0)
            holder.Size = UDim2.new(1,0,0,42)
            mainBtn.Text = text.."  ▼"
        end
        scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 20)
    end

    mainBtn.MouseButton1Click:Connect(function()
        open = not open
        recalc()
    end)

    local function toggle(labelText, callback)
        local b = Instance.new("TextButton", sub)
        b.Size = UDim2.new(1,0,0,32)
        b.Text = "   "..labelText.." : OFF"
        b.Font = Enum.Font.Gotham
        b.TextSize = 13
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.TextColor3 = MUTED
        b.BackgroundColor3 = CARD
        b.BackgroundTransparency = 0.12
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

        local on = false
        b.MouseButton1Click:Connect(function()
            on = not on
            b.Text = "   "..labelText.." : "..(on and "ON" or "OFF")
            if callback then callback(on) end
        end)
    end

    local function input(t, placeholder)
        local b = Instance.new("TextBox", sub)
        b.Size = UDim2.new(1,0,0,32)
        b.Text = "   "..t.." ("..placeholder..")"
        b.Font = Enum.Font.Gotham
        b.TextSize = 13
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.TextColor3 = MUTED
        b.ClearTextOnFocus = false
        b.BackgroundColor3 = CARD
        b.BackgroundTransparency = 0.12
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
        return b
    end

    ----------------------------------------------------------------
    -- AUTO FISHING
    ----------------------------------------------------------------
    if text == "Auto Fishing" then
        local row = Instance.new("Frame", sub)
        row.Size = UDim2.new(1,0,0,36)
        row.BackgroundTransparency = 1

        local label = Instance.new("TextLabel", row)
        label.Size = UDim2.new(1,-100,1,0)
        label.Position = UDim2.new(0,16,0,0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextColor3 = TEXT
        label.Text = "Auto Fishing"

        local pill = Instance.new("TextButton", row)
        pill.Size = UDim2.new(0,50,0,24)
        pill.Position = UDim2.new(1,-80,0.5,-12)
        pill.BackgroundColor3 = MUTED
        pill.BackgroundTransparency = 0.1
        pill.Text = ""
        pill.AutoButtonColor = false
        Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

        local knob = Instance.new("Frame", pill)
        knob.Size = UDim2.new(0,18,0,18)
        knob.Position = UDim2.new(0,3,0.5,-9)
        knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
        knob.BackgroundTransparency = 0
        Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

        local on = false
        local function refresh()
            pill.BackgroundColor3 = on and ACCENT or MUTED
            knob.Position = on and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
        end

pill.MouseButton1Click:Connect(function()
    on = not on

    if on then
        AutoFishAFK = true
        BlatantOn = false   -- matiin blatant kalau auto fishing dinyalain
    else
        AutoFishAFK = false
    end

    refresh()
end)


        refresh()

        -- Reel delay
        local reelRow = Instance.new("Frame", sub)
        reelRow.Size = UDim2.new(1,0,0,30)
        reelRow.BackgroundTransparency = 1

        local reelLabel = Instance.new("TextLabel", reelRow)
        reelLabel.Size = UDim2.new(0.6,0,1,0)
        reelLabel.Position = UDim2.new(0,16,0,0)
        reelLabel.BackgroundTransparency = 1
        reelLabel.Font = Enum.Font.Gotham
        reelLabel.TextSize = 13
        reelLabel.TextXAlignment = Enum.TextXAlignment.Left
        reelLabel.TextColor3 = TEXT
        reelLabel.Text = "Reel Delay (sec)"

        local reelBox = Instance.new("TextBox", reelRow)
        reelBox.Size = UDim2.new(0.35,0,1,0)
        reelBox.Position = UDim2.new(0.6,8,0,0)
        reelBox.Text = tostring(DelayReel)
        reelBox.Font = Enum.Font.Gotham
        reelBox.TextSize = 13
        reelBox.TextXAlignment = Enum.TextXAlignment.Center
        reelBox.TextColor3 = TEXT
        reelBox.ClearTextOnFocus = false
        reelBox.BackgroundColor3 = CARD
        reelBox.BackgroundTransparency = 0.12
        Instance.new("UICorner", reelBox).CornerRadius = UDim.new(0,8)

        reelBox.FocusLost:Connect(function()
            local n = tonumber(reelBox.Text:match("[%d%.]+"))
            if n and n > 0 then
                DelayReel = n
                reelBox.Text = tostring(n)
            else
                reelBox.Text = tostring(DelayReel)
            end
        end)

        -- Catch delay
        local catchRow = Instance.new("Frame", sub)
        catchRow.Size = UDim2.new(1,0,0,30)
        catchRow.BackgroundTransparency = 1

        local catchLabel = Instance.new("TextLabel", catchRow)
        catchLabel.Size = UDim2.new(0.6,0,1,0)
        catchLabel.Position = UDim2.new(0,16,0,0)
        catchLabel.BackgroundTransparency = 1
        catchLabel.Font = Enum.Font.Gotham
        catchLabel.TextSize = 13
        catchLabel.TextXAlignment = Enum.TextXAlignment.Left
        catchLabel.TextColor3 = TEXT
        catchLabel.Text = "Catch Delay (sec)"

        local catchBox = Instance.new("TextBox", catchRow)
        catchBox.Size = UDim2.new(0.35,0,1,0)
        catchBox.Position = UDim2.new(0.6,8,0,0)
        catchBox.Text = tostring(DelayCatch)
        catchBox.Font = Enum.Font.Gotham
        catchBox.TextSize = 13
        catchBox.TextXAlignment = Enum.TextXAlignment.Center
        catchBox.TextColor3 = TEXT
        catchBox.ClearTextOnFocus = false
        catchBox.BackgroundColor3 = CARD
        catchBox.BackgroundTransparency = 0.12
        Instance.new("UICorner", catchBox).CornerRadius = UDim.new(0,8)

        catchBox.FocusLost:Connect(function()
            local n = tonumber(catchBox.Text:match("[%d%.]+"))
            if n and n > 0 then
                DelayCatch = n
                catchBox.Text = tostring(n)
            else
                catchBox.Text = tostring(DelayCatch)
            end
        end)

    ----------------------------------------------------------------
    -- BLATANT FISHING
    ----------------------------------------------------------------
    elseif text == "Blatant Fishing" then
        local row = Instance.new("Frame", sub)
        row.Size = UDim2.new(1,0,0,36)
        row.BackgroundTransparency = 1

        local label = Instance.new("TextLabel", row)
        label.Size = UDim2.new(1,-100,1,0)
        label.Position = UDim2.new(0,16,0,0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextColor3 = TEXT
        label.Text = "Auto Fishing Blatant"

        local pill = Instance.new("TextButton", row)
        pill.Size = UDim2.new(0,50,0,24)
        pill.Position = UDim2.new(1,-80,0.5,-12)
        pill.BackgroundColor3 = MUTED
        pill.BackgroundTransparency = 0.1
        pill.Text = ""
        pill.AutoButtonColor = false
        Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

        local knob = Instance.new("Frame", pill)
        knob.Size = UDim2.new(0,18,0,18)
        knob.Position = UDim2.new(0,3,0.5,-9)
        knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
        knob.BackgroundTransparency = 0
        Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

        local function refreshBlatant()
            pill.BackgroundColor3 = BlatantOn and ACCENT or MUTED
            knob.Position = BlatantOn and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
        end

        pill.MouseButton1Click:Connect(function()
            BlatantOn = not BlatantOn
            refreshBlatant()
        end)

        refreshBlatant()

        -- Reel delay blatant
        local reelRow = Instance.new("Frame", sub)
        reelRow.Size = UDim2.new(1,0,0,30)
        reelRow.BackgroundTransparency = 1

        local reelLabel = Instance.new("TextLabel", reelRow)
        reelLabel.Size = UDim2.new(0.6,0,1,0)
        reelLabel.Position = UDim2.new(0,16,0,0)
        reelLabel.BackgroundTransparency = 1
        reelLabel.Font = Enum.Font.Gotham
        reelLabel.TextSize = 13
        reelLabel.TextXAlignment = Enum.TextXAlignment.Left
        reelLabel.TextColor3 = TEXT
        reelLabel.Text = "Reel Delay (sec)"

        local reelBox = Instance.new("TextBox", reelRow)
        reelBox.Size = UDim2.new(0.35,0,1,0)
        reelBox.Position = UDim2.new(0.6,8,0,0)
        reelBox.Text = tostring(BlatantReel)
        reelBox.Font = Enum.Font.Gotham
        reelBox.TextSize = 13
        reelBox.TextXAlignment = Enum.TextXAlignment.Center
        reelBox.TextColor3 = TEXT
        reelBox.ClearTextOnFocus = false
        reelBox.BackgroundColor3 = CARD
        reelBox.BackgroundTransparency = 0.12
        Instance.new("UICorner", reelBox).CornerRadius = UDim.new(0,8)

        reelBox.FocusLost:Connect(function()
            local n = tonumber(reelBox.Text:match("[%d%.]+"))
            if n and n > 0 then
                BlatantReel = n
                reelBox.Text = tostring(n)
            else
                reelBox.Text = tostring(BlatantReel)
            end
        end)

        -- Catch delay blatant
        local catchRow = Instance.new("Frame", sub)
        catchRow.Size = UDim2.new(1,0,0,30)
        catchRow.BackgroundTransparency = 1

        local catchLabel = Instance.new("TextLabel", catchRow)
        catchLabel.Size = UDim2.new(0.6,0,1,0)
        catchLabel.Position = UDim2.new(0,16,0,0)
        catchLabel.BackgroundTransparency = 1
        catchLabel.Font = Enum.Font.Gotham
        catchLabel.TextSize = 13
        catchLabel.TextXAlignment = Enum.TextXAlignment.Left
        catchLabel.TextColor3 = TEXT
        catchLabel.Text = "Catch Delay (sec)"

        local catchBox = Instance.new("TextBox", catchRow)
        catchBox.Size = UDim2.new(0.35,0,1,0)
        catchBox.Position = UDim2.new(0.6,8,0,0)
        catchBox.Text = tostring(BlatantCatch)
        catchBox.Font = Enum.Font.Gotham
        catchBox.TextSize = 13
        catchBox.TextXAlignment = Enum.TextXAlignment.Center
        catchBox.TextColor3 = TEXT
        catchBox.ClearTextOnFocus = false
        catchBox.BackgroundColor3 = CARD
        catchBox.BackgroundTransparency = 0.12
        Instance.new("UICorner", catchBox).CornerRadius = UDim.new(0,8)

        catchBox.FocusLost:Connect(function()
            local n = tonumber(catchBox.Text:match("[%d%.]+"))
            if n and n > 0 then
                BlatantCatch = n
                catchBox.Text = tostring(n)
            else
                catchBox.Text = tostring(BlatantCatch)
            end
        end)

        -- Extra catch blatant
        _G.RAY_ExtraCatchBlatant = _G.RAY_ExtraCatchBlatant or false

        local extraRow = Instance.new("Frame", sub)
        extraRow.Size = UDim2.new(1,0,0,32)
        extraRow.BackgroundTransparency = 1

        local extraLabel = Instance.new("TextLabel", extraRow)
        extraLabel.Size = UDim2.new(1,-100,1,0)
        extraLabel.Position = UDim2.new(0,16,0,0)
        extraLabel.BackgroundTransparency = 1
        extraLabel.Font = Enum.Font.Gotham
        extraLabel.TextSize = 13
        extraLabel.TextXAlignment = Enum.TextXAlignment.Left
        extraLabel.TextColor3 = TEXT
        extraLabel.Text = "Extra Catch"

        local extraPill = Instance.new("TextButton", extraRow)
        extraPill.Size = UDim2.new(0,50,0,24)
        extraPill.Position = UDim2.new(1,-80,0.5,-12)
        extraPill.BackgroundColor3 = MUTED
        extraPill.BackgroundTransparency = 0.1
        extraPill.Text = ""
        extraPill.AutoButtonColor = false
        Instance.new("UICorner", extraPill).CornerRadius = UDim.new(0,999)

        local extraKnob = Instance.new("Frame", extraPill)
        extraKnob.Size = UDim2.new(0,18,0,18)
        extraKnob.Position = UDim2.new(0,3,0.5,-9)
        extraKnob.BackgroundColor3 = Color3.fromRGB(255,255,255)
        extraKnob.BackgroundTransparency = 0
        Instance.new("UICorner", extraKnob).CornerRadius = UDim.new(0,999)

        local function refreshExtra()
            extraPill.BackgroundColor3 = _G.RAY_ExtraCatchBlatant and Color3.fromRGB(80,200,120) or MUTED
            extraKnob.Position = _G.RAY_ExtraCatchBlatant and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
        end

        extraPill.MouseButton1Click:Connect(function()
            _G.RAY_ExtraCatchBlatant = not _G.RAY_ExtraCatchBlatant
            refreshExtra()
        end)

        refreshExtra()

elseif text == "Auto Farm Island" then
    local info = Instance.new("TextLabel", sub)
    info.Size = UDim2.new(1,0,0,32)
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.Gotham
    info.TextSize = 13
    info.TextColor3 = MUTED
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.Text = "Click a spot to instantly teleport."

    local openBtn = Instance.new("TextButton", sub)
    openBtn.Size = UDim2.new(1,0,0,32)
    openBtn.BackgroundColor3 = CARD
    openBtn.BackgroundTransparency = 0.12
    openBtn.Text = "Open Teleport Spot List  ▼"
    openBtn.Font = Enum.Font.Gotham
    openBtn.TextSize = 13
    openBtn.TextColor3 = TEXT
    openBtn.AutoButtonColor = false
    Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0,8)

    openBtn.MouseButton1Click:Connect(function()
        islandPanel.Visible = not islandPanel.Visible
    end)


    elseif text == "Auto Favorite" then
        toggle("Favorite Rare")
        toggle("Favorite Epic")

    ----------------------------------------------------------------
    -- AUTO SELL (RAPIH)
    ----------------------------------------------------------------
    elseif text == "Auto Sell" then
        local AutoSellOn = _G.RAY_AutoSellOn or false
        _G.RAY_SellThreshold = _G.RAY_SellThreshold or "Legendary"
        _G.RAY_SellMode = _G.RAY_SellMode or "time"
        _G.RAY_SellDelay = _G.RAY_SellDelay or 5
        _G.RAY_SellInventoryThreshold = _G.RAY_SellInventoryThreshold or 30

        list.Padding = UDim.new(0,4)

        local function makeRow(title)
            local row = Instance.new("Frame", sub)
            row.Size = UDim2.new(1,0,0,32)
            row.BackgroundTransparency = 1

            local label = Instance.new("TextLabel", row)
            label.Size = UDim2.new(0.55,0,1,0)
            label.Position = UDim2.new(0,16,0,-2)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.Gotham
            label.TextSize = 13
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextColor3 = TEXT
            label.Text = title

            return row
        end

        -- Threshold
        local thRow = makeRow("Sell Threshold")

        local thBtn = Instance.new("TextButton", thRow)
        thBtn.Size = UDim2.new(0.38,0,0,28)
        thBtn.Position = UDim2.new(0.58,0,0.5,-14)
        thBtn.BackgroundColor3 = CARD
        thBtn.BackgroundTransparency = 0.12
        thBtn.Text = _G.RAY_SellThreshold.."  ▼"
        thBtn.Font = Enum.Font.Gotham
        thBtn.TextSize = 13
        thBtn.TextColor3 = MUTED
        thBtn.AutoButtonColor = false
        Instance.new("UICorner", thBtn).CornerRadius = UDim.new(0,8)

        local thDrop = Instance.new("Frame", thRow)
        thDrop.Position = UDim2.new(0.58,0,1,4)
        thDrop.Size = UDim2.new(0.38,0,0,72)
        thDrop.BackgroundColor3 = CARD
        thDrop.BackgroundTransparency = 0.06
        thDrop.Visible = false
        thDrop.ZIndex = 5
        Instance.new("UICorner", thDrop).CornerRadius = UDim.new(0,8)

        local thList = Instance.new("UIListLayout", thDrop)
        thList.Padding = UDim.new(0,4)
        thList.SortOrder = Enum.SortOrder.LayoutOrder

        for _,rar in ipairs({"Legendary","Mythic","Secret"}) do
            local b = Instance.new("TextButton", thDrop)
            b.Size = UDim2.new(1,-8,0,24)
            b.BackgroundColor3 = CARD
            b.BackgroundTransparency = 0.18
            b.Text = rar
            b.Font = Enum.Font.Gotham
            b.TextSize = 12
            b.TextColor3 = MUTED
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.ZIndex = 6
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

            b.MouseButton1Click:Connect(function()
                _G.RAY_SellThreshold = rar
                thBtn.Text = rar.."  ▼"
                thDrop.Visible = false
            end)
        end

        local thOpen = false
        thBtn.MouseButton1Click:Connect(function()
            thOpen = not thOpen
            thDrop.Visible = thOpen
        end)

        -- Mode
        local modeRow = makeRow("Sell Mode")

        local modeBtn = Instance.new("TextButton", modeRow)
        modeBtn.Size = UDim2.new(0.38,0,0,28)
        modeBtn.Position = UDim2.new(0.58,0,0.5,-14)
        modeBtn.BackgroundColor3 = CARD
        modeBtn.BackgroundTransparency = 0.12
        modeBtn.Text = _G.RAY_SellMode.."  ▼"
        modeBtn.Font = Enum.Font.Gotham
        modeBtn.TextSize = 13
        modeBtn.TextColor3 = MUTED
        modeBtn.AutoButtonColor = false
        Instance.new("UICorner", modeBtn).CornerRadius = UDim.new(0,8)

        local modeDrop = Instance.new("Frame", modeRow)
        modeDrop.Position = UDim2.new(0.58,0,1,4)
        modeDrop.Size = UDim2.new(0.38,0,0,48)
        modeDrop.BackgroundColor3 = CARD
        modeDrop.BackgroundTransparency = 0.06
        modeDrop.Visible = false
        modeDrop.ZIndex = 5
        Instance.new("UICorner", modeDrop).CornerRadius = UDim.new(0,8)

        local modeList = Instance.new("UIListLayout", modeDrop)
        modeList.Padding = UDim.new(0,4)
        modeList.SortOrder = Enum.SortOrder.LayoutOrder

        for _,m in ipairs({"time","inventory"}) do
            local b = Instance.new("TextButton", modeDrop)
            b.Size = UDim2.new(1,-8,0,24)
            b.BackgroundColor3 = CARD
            b.BackgroundTransparency = 0.18
            b.Text = m
            b.Font = Enum.Font.Gotham
            b.TextSize = 12
            b.TextColor3 = MUTED
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.ZIndex = 6
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

            b.MouseButton1Click:Connect(function()
                _G.RAY_SellMode = m
                modeBtn.Text = m.."  ▼"
                modeDrop.Visible = false
            end)
        end

        local modeOpen = false
        modeBtn.MouseButton1Click:Connect(function()
            modeOpen = not modeOpen
            modeDrop.Visible = modeOpen
        end)

        -- Delay
        local delayRow = makeRow("Sell Delay (seconds)")

        local delayBox = Instance.new("TextBox", delayRow)
        delayBox.Size = UDim2.new(0.38,0,1,0)
        delayBox.Position = UDim2.new(0.58,0,0,0)
        delayBox.Text = tostring(_G.RAY_SellDelay)
        delayBox.Font = Enum.Font.Gotham
        delayBox.TextSize = 13
        delayBox.TextXAlignment = Enum.TextXAlignment.Center
        delayBox.TextColor3 = TEXT
        delayBox.ClearTextOnFocus = false
        delayBox.BackgroundColor3 = CARD
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
        end)

        -- Inventory threshold
        local invRow = makeRow("Inventory Threshold")

        local invBox = Instance.new("TextBox", invRow)
        invBox.Size = UDim2.new(0.38,0,1,0)
        invBox.Position = UDim2.new(0.58,0,0,0)
        invBox.Text = tostring(_G.RAY_SellInventoryThreshold)
        invBox.Font = Enum.Font.Gotham
        invBox.TextSize = 13
        invBox.TextXAlignment = Enum.TextXAlignment.Center
        invBox.TextColor3 = TEXT
        invBox.ClearTextOnFocus = false
        invBox.BackgroundColor3 = CARD
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
        end)

        -- Toggle
        local row2 = makeRow("Auto Sell")

        local pill2 = Instance.new("TextButton", row2)
        pill2.Size = UDim2.new(0,50,0,24)
        pill2.Position = UDim2.new(1,-80,0.5,-12)
        pill2.BackgroundColor3 = MUTED
        pill2.BackgroundTransparency = 0.1
        pill2.Text = ""
        pill2.AutoButtonColor = false
        Instance.new("UICorner", pill2).CornerRadius = UDim.new(0,999)

        local knob2 = Instance.new("Frame", pill2)
        knob2.Size = UDim2.new(0,18,0,18)
        knob2.Position = UDim2.new(0,3,0.5,-9)
        knob2.BackgroundColor3 = Color3.fromRGB(255,255,255)
        knob2.BackgroundTransparency = 0
        Instance.new("UICorner", knob2).CornerRadius = UDim.new(0,999)

        local function refreshSell()
            pill2.BackgroundColor3 = AutoSellOn and ACCENT or MUTED
            knob2.Position = AutoSellOn and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
        end

        pill2.MouseButton1Click:Connect(function()
            AutoSellOn = not AutoSellOn
            _G.RAY_AutoSellOn = AutoSellOn
            refreshSell()
        end)

        refreshSell()

    elseif text == "Auto Totem" then
        toggle("Auto Totem")
        input("Cooldown","sec")

    elseif text == "Auto Potion" then
        toggle("Auto Potion")
        input("HP Threshold","%")
    end

    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(recalc)
    recalc()
end

for _,v in ipairs(AUTO_OPTIONS) do
    autoDropdown(v[1])
end

pages["Auto Option"].Visible = true
task.wait(0.1)

task.spawn(function()
    while true do
        if BlatantOn then
            BlatantCycle_V2()
        elseif AutoFishAFK then
            Engine_V3_Delayed()
        end
        task.wait(0.05)
    end
end)



-- AUTO SELL ENGINE SIMPLE
task.spawn(function()
    local Players = game:GetService("Players")
    local lp = Players.LocalPlayer
    local lastSell = 0

    while true do
        if _G.RAY_AutoSellOn then
            local mode = _G.RAY_SellMode or "time"

            if mode == "time" then
                local delay = _G.RAY_SellDelay or 5
                if tick() - lastSell >= delay then
                    pcall(function()
                        Events.sell:InvokeServer()
                    end)
                    lastSell = tick()
                end

            elseif mode == "inventory" then
                local backpack = lp:FindFirstChild("Backpack")
                if backpack then
                    local count = #backpack:GetChildren()
                    local limit = _G.RAY_SellInventoryThreshold or 30
                    if count >= limit then
                        pcall(function()
                            Events.sell:InvokeServer()
                        end)
                        task.wait(1)
                    end
                end
            end
        end

        task.wait(0.5)
    end
end)
