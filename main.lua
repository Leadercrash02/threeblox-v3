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

local lp = Players.LocalPlayer
local HIDE_DEFAULT_OVERHEAD = true
local COSTUME_NAME  = "ray"
local COSTUME_LEVEL = 772

----------------------------------------------------------------
-- STREAMER CUSTOM NAME (GLOBAL)
----------------------------------------------------------------
_G.RAY_StreamerOn  = _G.RAY_StreamerOn  or false
_G.RAY_CustomName  = _G.RAY_CustomName  or "discord.gg/Threeblox"

local originalHeaderText

local function getHeader()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local overhead = hrp:FindFirstChild("Overhead")
    if not overhead then return end

    local content = overhead:FindFirstChild("Content")
    if not content then return end

    local header = content:FindFirstChild("Header")
    return header
end

function applyStreamerState()
    local header = getHeader()
    if not header then return end

    if _G.RAY_StreamerOn then
        -- simpan nama asli sekali
        if not originalHeaderText then
            originalHeaderText = header.Text
        end

        header.RichText = true
        header.Text = '<font color="#3b82f6">'.._G.RAY_CustomName..' ✓</font>'
    else
        -- balikin ke nama asli
        if originalHeaderText then
            header.RichText = false
            header.Text = originalHeaderText
        end
    end
end

lp.CharacterAdded:Connect(function()
    task.wait(0.2)
    originalHeaderText = nil
    applyStreamerState()
end)

if lp.Character then
    task.spawn(function()
        task.wait(0.2)
        applyStreamerState()
    end)
end





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
    {"Coming soon",""},
    {"Auto Favorite",""},
    {"Auto Sell",""},
    {"Auto Megalodon",""},
    {"Auto Potion",""},
}

local ISLAND_SPOTS = {
    ["Christmas Cave"]      = CFrame.new(538.810181, -580.58136, 8900.9873),
    ["Cafe Besi"]           = CFrame.new(-8642.2588, -547.50031, 161.28636),
    ["Christmas Spot"]      = CFrame.new(1138.9039, 23.43064, 1560.8541),
    ["Esoteric Depths"]  = CFrame.new(3232.9036, -1302.8549, 1401.0824),
    ["Creater Island"]         = CFrame.new(1000.1009, 18.02404, 5093.1221),
    ["Hutan Kuno"]          = CFrame.new(1470.9269, 4.5879965, -323.6044),
    ["Temple Guardian"]     = CFrame.new(1486.0616, 127.62498, -590.1211),
    ["Secred Temple"]       = CFrame.new(1496.1331, -22.125002, -639.2121),
    ["Ancient Ruin"]        = CFrame.new(6081.9009, -585.92419, 4634.6240),
    ["Kohana"]              = CFrame.new(-603.82385, 17.250059, 514.24432),
    ["Kohana Volcano"]      = CFrame.new(-617.46448, 48.560577, 189.16815),
    ["Fisherman Spawn"]     = CFrame.new(90.31225, 17.033522, 2839.8655),
    ["Sysphus State"]       = CFrame.new(-3698.2456, -135.07391, -1007.7955),
    ["Treasure Room"]         = CFrame.new(-3595.2686, -275.74152, -1639.2794),
    ["Weater Machine"]      = CFrame.new(-1489.2069, 3.5, 1917.9594),
    ["Coral Reefs"]         = CFrame.new(-2755.0881, 4.0107765, 2163.7251),
    ["Hutan Tropis"]        = CFrame.new(-2016.4812, 9.037539, 3752.3533),
}


local DEFAULT_SPOT_ORDER = {
    "Fisherman Spawn",
    "Kohana",
    "Kohana Volcano",
    "Creater Island",
    "Ancient Ruin",
    "Hutan Kuno",
    "Secred Temple",
    "Temple Guardian",
    "Christmas Cave",
    "Cafe Besi",
    "Sysphus State",
    "Treasure Room",
    "Weater Machine",
    "Coral Reefs",
    "Hutan Tropis",
    "Christmas Spot",
    "Esoteric Depths",
}



-- ROOT
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true

-- MAIN
local main = Instance.new("Frame", gui)
local mainPad = Instance.new("UIPadding", main)
mainPad.PaddingBottom = UDim.new(0, 12)
main.Size = UDim2.new(0.6, 0, 0.7, 0)   -- 60% lebar layar
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
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

-- FIX CLOSE: matiin semua auto + destroy GUI
btnClose.MouseButton1Click:Connect(function()
    if typeof(AutoFishAFK) == "boolean" then
        AutoFishAFK = false
    end
    if typeof(BlatantOn) == "boolean" then
        BlatantOn = false
    end
    if _G then
        _G.RAY_AutoSellOn = false
    end

    if gui and gui.Parent then
        gui:Destroy()
    end
end)

-- DRAG MAIN WINDOW
do
    local dragging, startPos, startMain
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = i.Position
            startMain = main.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging then
            local delta = i.Position - startPos
            main.Position = UDim2.new(
                startMain.X.Scale,
                startMain.X.Offset + delta.X,
                startMain.Y.Scale,
                startMain.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- LOGO FLOAT (MINIMIZE ICON)
local miniLogo = Instance.new("ImageButton", gui)
miniLogo.Size = UDim2.new(0,56,0,56)
miniLogo.Position = UDim2.new(0,20,0.5,-28)
miniLogo.Image = LOGO_ID
miniLogo.Visible = false
miniLogo.BackgroundColor3 = CARD
miniLogo.BackgroundTransparency = ALPHA_CARD
Instance.new("UICorner", miniLogo).CornerRadius = UDim.new(1,0)

-- minimize: sembunyikan main, munculkan logo
btnMin.MouseButton1Click:Connect(function()
    main.Visible = false
    miniLogo.Visible = true
end)

-- DRAG + CLICK MINI LOGO
do
    local dragging = false
    local moved = false
    local startPos, startLogo

    miniLogo.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            moved = false
            startPos = i.Position
            startLogo = miniLogo.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - startPos
            if math.abs(delta.X) > 2 or math.abs(delta.Y) > 2 then
                moved = true
            end
            miniLogo.Position = UDim2.new(
                startLogo.X.Scale,
                startLogo.X.Offset + delta.X,
                startLogo.Y.Scale,
                startLogo.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            if dragging and not moved then
                -- tap = buka lagi menu
                main.Visible = true
                miniLogo.Visible = false
            end
            dragging = false
        end
    end)
end

-- SIDEBAR (AMAN DI HP)
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,48)
sidebar.Size     = UDim2.new(0.28, 0, 1, -48)
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

-- CONTENT (KANAN)
local content = Instance.new("ScrollingFrame", main)
content.ScrollingEnabled = true
content.ScrollBarThickness = 6
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Position = UDim2.new(0.28, 0, 0, 48)
content.Size = UDim2.new(0.72, 0, 1, -48)
content.CanvasSize = UDim2.new(0,0,0,0)
content.BackgroundTransparency = 1
content.ClipsDescendants = true

local contentLayout = Instance.new("UIListLayout", content)
contentLayout.Padding = UDim.new(0,0)

----------------------------------------------------------------
-- WEATHER DATA
----------------------------------------------------------------
local WEATHER_OPTIONS = {
    "Cloudy",
    "Radiant",
    "Shark Hunt",
    "Snow",
    "Storm",
    "Wind",
}

local selectedWeather = {}

local function toggleWeather(name)
    if selectedWeather[name] then
        selectedWeather[name] = nil
    else
        local c = 0
        for _, on in pairs(selectedWeather) do
            if on then c += 1 end
        end
        if c >= 4 then return end
        selectedWeather[name] = true
    end
end

----------------------------------------------------------------
-- PAGE SYSTEM
----------------------------------------------------------------
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

-- layout untuk halaman Quest (biar card tidak nabrak)
local questLayout = Instance.new("UIListLayout", pages["Quest"])
questLayout.Padding = UDim.new(0,8)
questLayout.SortOrder = Enum.SortOrder.LayoutOrder

----------------------------------------------------------------
-- QUEST : DEEPSEA (GHOSTFINN)
----------------------------------------------------------------
local function BuildQuestDeepsea()
    local questPage = pages["Quest"]

    -- CARD UTAMA
    local card = Instance.new("Frame")
    card.Name = "QuestDeepseaCard"
    card.Parent = questPage
    card.Size = UDim2.new(1,-32,0,48)
    card.Position = UDim2.new(0,16,0,16)
    card.BackgroundColor3 = CARD
    card.BackgroundTransparency = ALPHA_CARD
    card.ClipsDescendants = true
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

    local cardTitle = Instance.new("TextLabel", card)
    cardTitle.Size = UDim2.new(1,-40,0,22)
    cardTitle.Position = UDim2.new(0,16,0,4)
    cardTitle.BackgroundTransparency = 1
    cardTitle.Font = Enum.Font.GothamSemibold
    cardTitle.TextSize = 14
    cardTitle.TextXAlignment = Enum.TextXAlignment.Left
    cardTitle.TextColor3 = TEXT
    cardTitle.Text = "🌊 Quest Deepsea (Ghostfinn)"

    local arrow = Instance.new("TextLabel", card)
    arrow.Size = UDim2.new(0,24,0,24)
    arrow.Position = UDim2.new(1,-28,0,10)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.Gotham
    arrow.TextSize = 18
    arrow.TextColor3 = TEXT
    arrow.Text = "▼"

    local cardBtn = Instance.new("TextButton", card)
    cardBtn.BackgroundTransparency = 1
    cardBtn.Size = UDim2.new(1,0,1,0)
    cardBtn.Text = ""
    cardBtn.AutoButtonColor = false

    ----------------------------------------------------------------
    -- ISI DROPDOWN (TEXT PROGRESS + TELEPORT)
    ----------------------------------------------------------------
    local subDeep = Instance.new("Frame", card)
    subDeep.Name = "DeepseaContents"
    subDeep.Position = UDim2.new(0,0,0,48)
    subDeep.Size = UDim2.new(1,0,0,0)
    subDeep.BackgroundTransparency = 1
    subDeep.ClipsDescendants = true

    local deepLayout = Instance.new("UIListLayout", subDeep)
    deepLayout.Padding = UDim.new(0,6)
    deepLayout.FillDirection = Enum.FillDirection.Vertical
    deepLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    deepLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- ROW 1: TEXT PROGRESS (TINGGI DINAMIS / MODE SINGKAT)
    local deepRow = Instance.new("Frame", subDeep)
    deepRow.Size = UDim2.new(1,0,0,0)
    deepRow.BackgroundTransparency = 1

    local deepText = Instance.new("TextLabel", deepRow)
    deepText.Name = "DeepseaText"
    deepText.Size = UDim2.new(1,-8,1,-8)
    deepText.Position = UDim2.new(0,4,0,4)
    deepText.BackgroundTransparency = 1
    deepText.Font = Enum.Font.Code
    deepText.TextSize = 13
    deepText.TextXAlignment = Enum.TextXAlignment.Left
    deepText.TextYAlignment = Enum.TextYAlignment.Top
    deepText.TextWrapped = false
    deepText.TextColor3 = TEXT
    deepText.Text = "Loading Deepsea quest..."

    -- ROW 2: TELEPORT SYSphus / TREASURE ROOM
    local tpRow = Instance.new("Frame", subDeep)
    tpRow.Size = UDim2.new(1,0,0,36)
    tpRow.BackgroundTransparency = 1

    local tpSys = Instance.new("TextButton", tpRow)
    tpSys.Size = UDim2.new(0.5,-10,1,0)
    tpSys.Position = UDim2.new(0,0,0,0)
    tpSys.BackgroundColor3 = CARD
    tpSys.BackgroundTransparency = 0.4
    tpSys.BorderSizePixel = 0
    tpSys.Font = Enum.Font.Gotham
    tpSys.TextSize = 13
    tpSys.TextColor3 = TEXT
    tpSys.Text = "⛰ Sysphus State"
    tpSys.AutoButtonColor = false
    Instance.new("UICorner", tpSys).CornerRadius = UDim.new(0,8)

    local tpTreasure = Instance.new("TextButton", tpRow)
    tpTreasure.Size = UDim2.new(0.5,-10,1,0)
    tpTreasure.Position = UDim2.new(0.5,10,0,0)
    tpTreasure.BackgroundColor3 = CARD
    tpTreasure.BackgroundTransparency = 0.4
    tpTreasure.BorderSizePixel = 0
    tpTreasure.Font = Enum.Font.Gotham
    tpTreasure.TextSize = 13
    tpTreasure.TextColor3 = TEXT
    tpTreasure.Text = "💎 Treasure Room"
    tpTreasure.AutoButtonColor = false
    Instance.new("UICorner", tpTreasure).CornerRadius = UDim.new(0,8)

    ----------------------------------------------------------------
    -- DROPDOWN BEHAVIOUR
    ----------------------------------------------------------------
    local deepOpen = false
    local function recalcDeep()
        local h = deepLayout.AbsoluteContentSize.Y
        if deepOpen then
            subDeep.Size = UDim2.new(1,0,0,h + 8)
            card.Size   = UDim2.new(1,-32,0,48 + h + 8)
            arrow.Text  = "▲"
        else
            subDeep.Size = UDim2.new(1,0,0,0)
            card.Size   = UDim2.new(1,-32,0,48)
            arrow.Text  = "▼"
        end
    end

    deepLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(recalcDeep)

    cardBtn.MouseButton1Click:Connect(function()
        deepOpen = not deepOpen
        recalcDeep()
    end)

    ----------------------------------------------------------------
    -- TELEPORT HANDLER (PAKAI ISLAND_SPOTS)
    ----------------------------------------------------------------
    local function tpTo(name)
        local cf = ISLAND_SPOTS[name]
        if not cf then return end
        local char = lp.Character or lp.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        hrp.AssemblyLinearVelocity  = Vector3.new(0,0,0)
        hrp.AssemblyAngularVelocity = Vector3.new(0,0,0)
        hrp.CFrame = cf
    end

    tpSys.MouseButton1Click:Connect(function()
        tpTo("Sysphus State")
    end)

    tpTreasure.MouseButton1Click:Connect(function()
        tpTo("Treasure Room")
    end)

    ----------------------------------------------------------------
    -- LOGIC QUEST (VERSI GUI TEST + FLAG COMPLETED)
    ----------------------------------------------------------------
    -- PENTING: sesuaikan path require jika di game beda
    local Replion = require(ReplicatedStorage.Packages.Replion)
    local Quests  = require(ReplicatedStorage.Modules.Quests)
    local MainlineQuestController = require(ReplicatedStorage.Controllers.MainlineQuestController)

    local DataReplion = Replion.Client:WaitReplion("Data")

    local function getQuestType(name)
        local ok, qType = pcall(MainlineQuestController.GetQuestTypeFromName, name)
        return ok and qType or nil
    end

    local function calcTotalPercent(questDef, questState)
        if not questDef or not questDef.Objectives then return 0 end
        local acc = 0
        for i,obj in ipairs(questDef.Objectives) do
            local st = questState and questState.Objectives and questState.Objectives[i]
            local cur = (st and st.Progress) or 0
            local goal = obj.Goal or 1
            if cur >= goal then
                acc += 1
            else
                acc += math.clamp(cur/goal,0,1)
            end
        end
        return acc/#questDef.Objectives*100
    end

    local function isCompleted(name)
        local completed = DataReplion:GetExpect("CompletedQuests") or {}
        for _,q in ipairs(completed) do
            if q == name then return true end
        end
        return false
    end

    -- return: text, isDone
    local function dumpDeepsea()
        local name = "Deep Sea Quest"

        local completedFlag = isCompleted(name)
        local qType = getQuestType(name)
        local def = qType and Quests[qType] and Quests[qType][name] or nil

        local all = DataReplion:GetExpect("Quests")
        local state = qType and all[qType] and all[qType][name] or nil

        if completedFlag and not state then
            return string.format("%s (%s) – 100%% (COMPLETED)", name, qType or "Mainline"), true
        end

        if not qType or not def then
            return name.." – data not found", false
        end

        if not state then
            return name.." – not active", false
        end

        local total = calcTotalPercent(def,state)
        local doneFlag = MainlineQuestController.DidCompleteAll(qType,name,state) or completedFlag
        if doneFlag then total = 100 end
        local totalRounded = math.floor(total+0.5)

        local lines = {}
        table.insert(lines, string.format("%s (%s) – %d%%%s",
            name, qType, totalRounded, doneFlag and " (COMPLETED)" or ""))

        for i,obj in ipairs(def.Objectives) do
            local st = state.Objectives and state.Objectives[i]
            local cur = (st and st.Progress) or 0
            local goal = obj.Goal or 1
            local pct = math.floor(math.clamp(cur/goal,0,1)*100+0.5)
            table.insert(lines, string.format("  [%d] %s", i, obj.Name))
            table.insert(lines, string.format("      %d/%d (%d%%)", cur, goal, pct))
        end

        return table.concat(lines,"\n"), doneFlag
    end

    local function refreshDeep()
        local text, done = dumpDeepsea()
        deepText.Text = text

        if done then
            -- MODE SINGKAT: quest selesai → teks pendek
            deepRow.Size = UDim2.new(1,0,0,32)
        else
            -- MODE NORMAL: tinggi ikut jumlah baris
            local lines = 0
            for _ in string.gmatch(text, "\n") do
                lines += 1
            end
            lines = lines + 1

            local lineHeight = 16
            local basePadding = 12
            local h = basePadding + lines * lineHeight
            h = math.clamp(h, 48, 160)

            deepRow.Size = UDim2.new(1,0,0,h)
        end

        recalcDeep()
    end

    DataReplion:OnChange({"Quests","Mainline"}, refreshDeep)
    DataReplion:OnChange({"CompletedQuests"}, refreshDeep)
    refreshDeep()
end

BuildQuestDeepsea()

----------------------------------------------------------------
-- QUEST : ELEMENT ROD
----------------------------------------------------------------
local function BuildQuestElement()
    local questPage = pages["Quest"]
    local ELEMENT_QUEST_NAME = "Element Quest" -- ganti ke nama quest aslinya

    -- CARD UTAMA
    local card = Instance.new("Frame")
    card.Name = "QuestElementCard"
    card.Parent = questPage
    card.Size = UDim2.new(1,-32,0,48)
    card.Position = UDim2.new(0,16,0,0)      -- Y diatur UIListLayout
    card.BackgroundColor3 = CARD
    card.BackgroundTransparency = ALPHA_CARD
    card.ClipsDescendants = true
    card.LayoutOrder = 2                     -- Element di bawah Deepsea
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

    local cardTitle = Instance.new("TextLabel", card)
    cardTitle.Size = UDim2.new(1,-40,0,22)
    cardTitle.Position = UDim2.new(0,16,0,4)
    cardTitle.BackgroundTransparency = 1
    cardTitle.Font = Enum.Font.GothamSemibold
    cardTitle.TextSize = 14
    cardTitle.TextXAlignment = Enum.TextXAlignment.Left
    cardTitle.TextColor3 = TEXT
    cardTitle.Text = "⚡ Quest Element Rod"

    local arrow = Instance.new("TextLabel", card)
    arrow.Size = UDim2.new(0,24,0,24)
    arrow.Position = UDim2.new(1,-28,0,10)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.Gotham
    arrow.TextSize = 18
    arrow.TextColor3 = TEXT
    arrow.Text = "▼"

    local cardBtn = Instance.new("TextButton", card)
    cardBtn.BackgroundTransparency = 1
    cardBtn.Size = UDim2.new(1,0,1,0)
    cardBtn.Text = ""
    cardBtn.AutoButtonColor = false

    ----------------------------------------------------------------
    -- ISI DROPDOWN (TEXT PROGRESS + TELEPORT)
    ----------------------------------------------------------------
    local subElem = Instance.new("Frame", card)
    subElem.Name = "ElementContents"
    subElem.Position = UDim2.new(0,0,0,48)
    subElem.Size = UDim2.new(1,0,0,0)
    subElem.BackgroundTransparency = 1
    subElem.ClipsDescendants = true

    local elemLayout = Instance.new("UIListLayout", subElem)
    elemLayout.Padding = UDim.new(0,6)
    elemLayout.FillDirection = Enum.FillDirection.Vertical
    elemLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    elemLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- ROW 1: TEXT PROGRESS (DINAMIS / MODE SINGKAT)
    local elemRow = Instance.new("Frame", subElem)
    elemRow.Size = UDim2.new(1,0,0,0)
    elemRow.BackgroundTransparency = 1

    local elemText = Instance.new("TextLabel", elemRow)
    elemText.Name = "ElementText"
    elemText.Size = UDim2.new(1,-8,1,-8)
    elemText.Position = UDim2.new(0,4,0,4)
    elemText.BackgroundTransparency = 1
    elemText.Font = Enum.Font.Code
    elemText.TextSize = 13
    elemText.TextXAlignment = Enum.TextXAlignment.Left
    elemText.TextYAlignment = Enum.TextYAlignment.Top
    elemText.TextWrapped = false
    elemText.TextColor3 = TEXT
    elemText.Text = "Loading Element quest..."

    -- ROW 2: TELEPORT ANCIENT JUNGLE / SEcred TEMPLE
    local tpRow = Instance.new("Frame", subElem)
    tpRow.Size = UDim2.new(1,0,0,36)
    tpRow.BackgroundTransparency = 1

    local tpAncient = Instance.new("TextButton", tpRow)
    tpAncient.Size = UDim2.new(0.5,-10,1,0)
    tpAncient.Position = UDim2.new(0,0,0,0)
    tpAncient.BackgroundColor3 = CARD
    tpAncient.BackgroundTransparency = 0.4
    tpAncient.BorderSizePixel = 0
    tpAncient.Font = Enum.Font.Gotham
    tpAncient.TextSize = 13
    tpAncient.TextColor3 = TEXT
    tpAncient.Text = "🌿 Ancient Jungle"
    tpAncient.AutoButtonColor = false
    Instance.new("UICorner", tpAncient).CornerRadius = UDim.new(0,8)

    local tpSecred = Instance.new("TextButton", tpRow)
    tpSecred.Size = UDim2.new(0.5,-10,1,0)
    tpSecred.Position = UDim2.new(0.5,10,0,0)
    tpSecred.BackgroundColor3 = CARD
    tpSecred.BackgroundTransparency = 0.4
    tpSecred.BorderSizePixel = 0
    tpSecred.Font = Enum.Font.Gotham
    tpSecred.TextSize = 13
    tpSecred.TextColor3 = TEXT
    tpSecred.Text = "🏛 Secred Temple"
    tpSecred.AutoButtonColor = false
    Instance.new("UICorner", tpSecred).CornerRadius = UDim.new(0,8)

    ----------------------------------------------------------------
    -- DROPDOWN BEHAVIOUR
    ----------------------------------------------------------------
    local elemOpen = false
    local function recalcElem()
        local h = elemLayout.AbsoluteContentSize.Y
        if elemOpen then
            subElem.Size = UDim2.new(1,0,0,h + 8)
            card.Size   = UDim2.new(1,-32,0,48 + h + 8)
            arrow.Text  = "▲"
        else
            subElem.Size = UDim2.new(1,0,0,0)
            card.Size   = UDim2.new(1,-32,0,48)
            arrow.Text  = "▼"
        end
    end

    elemLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(recalcElem)

    cardBtn.MouseButton1Click:Connect(function()
        elemOpen = not elemOpen
        recalcElem()
    end)

    ----------------------------------------------------------------
    -- TELEPORT HANDLER
    ----------------------------------------------------------------
    local function tpTo(name)
        local cf = ISLAND_SPOTS[name]
        if not cf then return end
        local char = lp.Character or lp.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        hrp.AssemblyLinearVelocity  = Vector3.new(0,0,0)
        hrp.AssemblyAngularVelocity = Vector3.new(0,0,0)
        hrp.CFrame = cf
    end

    tpAncient.MouseButton1Click:Connect(function()
        -- Ancient Jungle -> Hutan Kuno (sama area)
        tpTo("Hutan Kuno")
    end)

    tpSecred.MouseButton1Click:Connect(function()
        tpTo("Secred Temple")
    end)


    ----------------------------------------------------------------
    -- LOGIC QUEST (SAMA POLA DENGAN DEEPSEA)
    ----------------------------------------------------------------
    local Replion = require(ReplicatedStorage.Packages.Replion)
    local Quests  = require(ReplicatedStorage.Modules.Quests)
    local MainlineQuestController = require(ReplicatedStorage.Controllers.MainlineQuestController)

    local DataReplion = Replion.Client:WaitReplion("Data")

    local function getQuestType(name)
        local ok, qType = pcall(MainlineQuestController.GetQuestTypeFromName, name)
        return ok and qType or nil
    end

    local function calcTotalPercent(questDef, questState)
        if not questDef or not questDef.Objectives then return 0 end
        local acc = 0
        for i,obj in ipairs(questDef.Objectives) do
            local st = questState and questState.Objectives and questState.Objectives[i]
            local cur = (st and st.Progress) or 0
            local goal = obj.Goal or 1
            if cur >= goal then
                acc += 1
            else
                acc += math.clamp(cur/goal,0,1)
            end
        end
        return acc/#questDef.Objectives*100
    end

    local function isCompleted(name)
        local completed = DataReplion:GetExpect("CompletedQuests") or {}
        for _,q in ipairs(completed) do
            if q == name then return true end
        end
        return false
    end

    local function dumpElement()
        local name = ELEMENT_QUEST_NAME

        local completedFlag = isCompleted(name)
        local qType = getQuestType(name)
        local def = qType and Quests[qType] and Quests[qType][name] or nil

        local all = DataReplion:GetExpect("Quests")
        local state = qType and all[qType] and all[qType][name] or nil

        if completedFlag and not state then
            return string.format("%s (%s) – 100%% (COMPLETED)", name, qType or "Mainline"), true
        end

        if not qType or not def then
            return name.." – data not found", false
        end

        if not state then
            return name.." – not active", false
        end

        local total = calcTotalPercent(def,state)
        local doneFlag = MainlineQuestController.DidCompleteAll(qType,name,state) or completedFlag
        if doneFlag then total = 100 end
        local totalRounded = math.floor(total+0.5)

        local lines = {}
        table.insert(lines, string.format("%s (%s) – %d%%%s",
            name, qType, totalRounded, doneFlag and " (COMPLETED)" or ""))

        for i,obj in ipairs(def.Objectives) do
            local st = state.Objectives and state.Objectives[i]
            local cur = (st and st.Progress) or 0
            local goal = obj.Goal or 1
            local pct = math.floor(math.clamp(cur/goal,0,1)*100+0.5)
            table.insert(lines, string.format("  [%d] %s", i, obj.Name))
            table.insert(lines, string.format("      %d/%d (%d%%)", cur, goal, pct))
        end

        return table.concat(lines,"\n"), doneFlag
    end

    local function refreshElem()
        local text, done = dumpElement()
        elemText.Text = text

        if done then
            elemRow.Size = UDim2.new(1,0,0,32)
        else
            local lines = 0
            for _ in string.gmatch(text, "\n") do
                lines += 1
            end
            lines = lines + 1

            local lineHeight = 16
            local basePadding = 12
            local h = basePadding + lines * lineHeight
            h = math.clamp(h, 48, 160)

            elemRow.Size = UDim2.new(1,0,0,h)
        end

        recalcElem()
    end

    DataReplion:OnChange({"Quests","Mainline"}, refreshElem)
    DataReplion:OnChange({"CompletedQuests"}, refreshElem)
    refreshElem()
end


BuildQuestElement()

----------------------------------------------------------------
-- QUEST : DIAMOND ROD (DIAMOND RESEARCHER)
----------------------------------------------------------------
local function BuildQuestDiamond()
    local questPage = pages["Quest"]
    local DIAMOND_QUEST_NAME = "Diamond Researcher" -- sama seperti GUI test

    -- CARD UTAMA
    local card = Instance.new("Frame")
    card.Name = "QuestDiamondCard"
    card.Parent = questPage
    card.Size = UDim2.new(1,-32,0,48)
    card.Position = UDim2.new(0,16,0,0)
    card.BackgroundColor3 = CARD
    card.BackgroundTransparency = ALPHA_CARD
    card.ClipsDescendants = true
    card.LayoutOrder = 3 -- di bawah Element
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

    local cardTitle = Instance.new("TextLabel", card)
    cardTitle.Size = UDim2.new(1,-40,0,22)
    cardTitle.Position = UDim2.new(0,16,0,4)
    cardTitle.BackgroundTransparency = 1
    cardTitle.Font = Enum.Font.GothamSemibold
    cardTitle.TextSize = 14
    cardTitle.TextXAlignment = Enum.TextXAlignment.Left
    cardTitle.TextColor3 = TEXT
    cardTitle.Text = "💎 Quest Diamond Rod"

    local arrow = Instance.new("TextLabel", card)
    arrow.Size = UDim2.new(0,24,0,24)
    arrow.Position = UDim2.new(1,-28,0,10)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.Gotham
    arrow.TextSize = 18
    arrow.TextColor3 = TEXT
    arrow.Text = "▼"

    local cardBtn = Instance.new("TextButton", card)
    cardBtn.BackgroundTransparency = 1
    cardBtn.Size = UDim2.new(1,0,1,0)
    cardBtn.Text = ""
    cardBtn.AutoButtonColor = false

    ----------------------------------------------------------------
    -- ISI DROPDOWN (TEXT PROGRESS + 3 TELEPORT)
    ----------------------------------------------------------------
    local subDia = Instance.new("Frame", card)
    subDia.Name = "DiamondContents"
    subDia.Position = UDim2.new(0,0,0,48)
    subDia.Size = UDim2.new(1,0,0,0)
    subDia.BackgroundTransparency = 1
    subDia.ClipsDescendants = true

    local diaLayout = Instance.new("UIListLayout", subDia)
    diaLayout.Padding = UDim.new(0,6)
    diaLayout.FillDirection = Enum.FillDirection.Vertical
    diaLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    diaLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- ROW 1: TEXT PROGRESS (DINAMIS / MODE SINGKAT)
    local diaRow = Instance.new("Frame", subDia)
    diaRow.Size = UDim2.new(1,0,0,0)
    diaRow.BackgroundTransparency = 1

    local diaText = Instance.new("TextLabel", diaRow)
    diaText.Name = "DiamondText"
    diaText.Size = UDim2.new(1,-8,1,-8)
    diaText.Position = UDim2.new(0,4,0,4)
    diaText.BackgroundTransparency = 1
    diaText.Font = Enum.Font.Code
    diaText.TextSize = 13
    diaText.TextXAlignment = Enum.TextXAlignment.Left
    diaText.TextYAlignment = Enum.TextYAlignment.Top
    diaText.TextWrapped = false
    diaText.TextColor3 = TEXT
    diaText.Text = "Loading Diamond quest..."

    -- ROW 2: TELEPORT CORAL / TROPIS / ANCIENT
    local tpRow = Instance.new("Frame", subDia)
    tpRow.Size = UDim2.new(1,0,0,36)
    tpRow.BackgroundTransparency = 1

    local tpCoral = Instance.new("TextButton", tpRow)
    tpCoral.Size = UDim2.new(1/3,-8,1,0)
    tpCoral.Position = UDim2.new(0,0,0,0)
    tpCoral.BackgroundColor3 = CARD
    tpCoral.BackgroundTransparency = 0.4
    tpCoral.BorderSizePixel = 0
    tpCoral.Font = Enum.Font.Gotham
    tpCoral.TextSize = 13
    tpCoral.TextColor3 = TEXT
    tpCoral.Text = "🐠 Coral Reefs"
    tpCoral.AutoButtonColor = false
    Instance.new("UICorner", tpCoral).CornerRadius = UDim.new(0,8)

    local tpTropis = Instance.new("TextButton", tpRow)
    tpTropis.Size = UDim2.new(1/3,-8,1,0)
    tpTropis.Position = UDim2.new(1/3+0.012,4,0,0)
    tpTropis.BackgroundColor3 = CARD
    tpTropis.BackgroundTransparency = 0.4
    tpTropis.BorderSizePixel = 0
    tpTropis.Font = Enum.Font.Gotham
    tpTropis.TextSize = 13
    tpTropis.TextColor3 = TEXT
    tpTropis.Text = "🌴 Hutan Tropis"
    tpTropis.AutoButtonColor = false
    Instance.new("UICorner", tpTropis).CornerRadius = UDim.new(0,8)

    local tpAncient = Instance.new("TextButton", tpRow)
    tpAncient.Size = UDim2.new(1/3,-8,1,0)
    tpAncient.Position = UDim2.new(2/3+0.024,8,0,0)
    tpAncient.BackgroundColor3 = CARD
    tpAncient.BackgroundTransparency = 0.4
    tpAncient.BorderSizePixel = 0
    tpAncient.Font = Enum.Font.Gotham
    tpAncient.TextSize = 13
    tpAncient.TextColor3 = TEXT
    tpAncient.Text = "🏛 Ancient Ruin"
    tpAncient.AutoButtonColor = false
    Instance.new("UICorner", tpAncient).CornerRadius = UDim.new(0,8)

    ----------------------------------------------------------------
    -- DROPDOWN BEHAVIOUR
    ----------------------------------------------------------------
    local diaOpen = false
    local function recalcDia()
        local h = diaLayout.AbsoluteContentSize.Y
        if diaOpen then
            subDia.Size = UDim2.new(1,0,0,h + 8)
            card.Size   = UDim2.new(1,-32,0,48 + h + 8)
            arrow.Text  = "▲"
        else
            subDia.Size = UDim2.new(1,0,0,0)
            card.Size   = UDim2.new(1,-32,0,48)
            arrow.Text  = "▼"
        end
    end

    diaLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(recalcDia)

    cardBtn.MouseButton1Click:Connect(function()
        diaOpen = not diaOpen
        recalcDia()
    end)

    ----------------------------------------------------------------
    -- TELEPORT HANDLER (CORAL / TROPIS / ANCIENT)
    ----------------------------------------------------------------
    local function tpTo(name)
        local cf = ISLAND_SPOTS[name]
        if not cf then return end
        local char = lp.Character or lp.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        hrp.AssemblyLinearVelocity  = Vector3.new(0,0,0)
        hrp.AssemblyAngularVelocity = Vector3.new(0,0,0)
        hrp.CFrame = cf
    end

    tpCoral.MouseButton1Click:Connect(function()
        tpTo("Coral Reefs")
    end)

    tpTropis.MouseButton1Click:Connect(function()
        tpTo("Hutan Tropis")
    end)

    tpAncient.MouseButton1Click:Connect(function()
        tpTo("Ancient Ruin")
    end)

    ----------------------------------------------------------------
    -- LOGIC QUEST (MIRROR SCRIPT TESTER)
    ----------------------------------------------------------------
    local Replion = require(ReplicatedStorage.Packages.Replion)
    local Quests  = require(ReplicatedStorage.Modules.Quests)
    local MainlineQuestController = require(ReplicatedStorage.Controllers.MainlineQuestController)

    local DataReplion = Replion.Client:WaitReplion("Data")

    local function getQuestType(name)
        local ok, qType = pcall(MainlineQuestController.GetQuestTypeFromName, name)
        if ok then
            return qType
        end
    end

    local function calcTotalPercent(questDef, questState)
        if not questDef or not questDef.Objectives then
            return 0
        end

        local acc = 0
        for i, objDef in ipairs(questDef.Objectives) do
            local objState = questState and questState.Objectives and questState.Objectives[i]
            local progress = (objState and objState.Progress) or 0
            local goal = objDef.Goal or 1

            if progress >= goal then
                acc += 1
            else
                acc += math.clamp(progress / goal, 0, 1)
            end
        end

        return acc / #questDef.Objectives * 100
    end

    local function isCompleted(name)
        local completed = DataReplion:GetExpect("CompletedQuests") or {}
        for _, qName in ipairs(completed) do
            if qName == name then
                return true
            end
        end
        return false
    end

    -- return: text, doneFlag
    local function dumpDiamond()
        local name = DIAMOND_QUEST_NAME

        local completedFlag = isCompleted(name)
        local questType = getQuestType(name)
        local questDef = questType and Quests[questType] and Quests[questType][name] or nil

        local allQuests = DataReplion:GetExpect("Quests")
        local questState = questType and allQuests[questType] and allQuests[questType][name] or nil

        if completedFlag and not questState then
            return string.format("%s (%s) – 100%% (COMPLETED)",
                name,
                questType or "Mainline"
            ), true
        end

        if not questType or not questDef then
            return name.." – data not found", false
        end

        if not questState then
            return name.." – not active", false
        end

        local totalPct = calcTotalPercent(questDef, questState)
        local doneFlag = MainlineQuestController.DidCompleteAll(questType, name, questState) or completedFlag
        if doneFlag then
            totalPct = 100
        end
        local totalRounded = math.floor(totalPct + 0.5)

        local lines = {}
        for i, objDef in ipairs(questDef.Objectives) do
            local objState = questState.Objectives and questState.Objectives[i]
            local cur = (objState and objState.Progress) or 0
            local goal = objDef.Goal or 1
            local pct = math.floor(math.clamp(cur / goal, 0, 1) * 100 + 0.5)

            table.insert(lines, string.format(
                "  [%d] %s",
                i,
                objDef.Name
            ))
            table.insert(lines, string.format(
                "      %d/%d (%d%%)",
                cur,
                goal,
                pct
            ))
        end

        local header = string.format("%s (%s) – %d%%%s",
            name,
            questType,
            totalRounded,
            doneFlag and " (COMPLETED)" or ""
        )

        return header.."\n"..table.concat(lines, "\n"), doneFlag
    end

    local function refreshDia()
        local text, done = dumpDiamond()
        diaText.Text = text

        if done then
            diaRow.Size = UDim2.new(1,0,0,32)
        else
            local lines = 0
            for _ in string.gmatch(text, "\n") do
                lines += 1
            end
            lines = lines + 1

            local lineHeight = 16
            local basePadding = 12
            local h = basePadding + lines * lineHeight
            h = math.clamp(h, 48, 160)

            diaRow.Size = UDim2.new(1,0,0,h)
        end

        recalcDia()
    end

    DataReplion:OnChange({"Quests","Mainline"}, refreshDia)
    DataReplion:OnChange({"CompletedQuests"}, refreshDia)
    refreshDia()
end



BuildQuestDiamond()


----------------------------------------------------------------
-- SHOP & TRADE : WEATHER PRESET
----------------------------------------------------------------
local function BuildShopWeather()
    local shopPage = pages["Shop & Trade"]

    ------------------------------------------------------------
    -- 1) CARD "WEATHER PRESET" (DROPDOWN LEVEL 1)
    ------------------------------------------------------------
    local card = Instance.new("Frame")
    card.Name = "WeatherPresetCard"
    card.Parent = shopPage
    card.Size = UDim2.new(1,-32,0,48)
    card.Position = UDim2.new(0,16,0,16)
    card.BackgroundColor3 = CARD
    card.BackgroundTransparency = ALPHA_CARD
    card.ClipsDescendants = true

    Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)

    local cardTitle = Instance.new("TextLabel", card)
    cardTitle.Size = UDim2.new(1,-40,0,22)
    cardTitle.Position = UDim2.new(0,16,0,4)
    cardTitle.BackgroundTransparency = 1
    cardTitle.Font = Enum.Font.GothamSemibold
    cardTitle.TextSize = 14
    cardTitle.TextXAlignment = Enum.TextXAlignment.Left
    cardTitle.TextColor3 = TEXT
    cardTitle.Text = "🌦 Weather Preset"

    local arrow = Instance.new("TextLabel", card)
    arrow.Size = UDim2.new(0,24,0,24)
    arrow.Position = UDim2.new(1,-28,0,10)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.Gotham
    arrow.TextSize = 18
    arrow.TextColor3 = TEXT
    arrow.Text = "▼"

    -- area clickable buat buka/tutup dropdown
    local cardBtn = Instance.new("TextButton", card)
    cardBtn.BackgroundTransparency = 1
    cardBtn.Size = UDim2.new(1,0,1,0)
    cardBtn.Text = ""
    cardBtn.AutoButtonColor = false

    -- container isi dropdown (Select Weather, Auto Buy, dsb)
    local subPreset = Instance.new("Frame", card)
    subPreset.Name = "PresetContents"
    subPreset.Position = UDim2.new(0,0,0,48)
    subPreset.Size = UDim2.new(1,0,0,0)
    subPreset.BackgroundTransparency = 1
    subPreset.ClipsDescendants = true

    local presetLayout = Instance.new("UIListLayout", subPreset)
    presetLayout.Padding = UDim.new(0,6)
    presetLayout.FillDirection = Enum.FillDirection.Vertical
    presetLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    presetLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local presetOpen = false
    local function recalcPreset()
        local h = presetLayout.AbsoluteContentSize.Y
        if presetOpen then
            subPreset.Size = UDim2.new(1,0,0,h + 8)
            card.Size = UDim2.new(1,-32,0,48 + h + 8)
            arrow.Text = "▲"
        else
            subPreset.Size = UDim2.new(1,0,0,0)
            card.Size = UDim2.new(1,-32,0,48)
            arrow.Text = "▼"
        end
    end

    cardBtn.MouseButton1Click:Connect(function()
        presetOpen = not presetOpen
        recalcPreset()
    end)

    ------------------------------------------------------------
    -- 2) ROW "SELECT WEATHER" DI DALAM CARD
    ------------------------------------------------------------
    local rowSelect = Instance.new("Frame", subPreset)
    rowSelect.Size = UDim2.new(1,0,0,36)
    rowSelect.BackgroundTransparency = 1

    local lblSelect = Instance.new("TextLabel", rowSelect)
    lblSelect.Size = UDim2.new(0.5,0,1,0)
    lblSelect.Position = UDim2.new(0,16,0,0)
    lblSelect.BackgroundTransparency = 1
    lblSelect.Font = Enum.Font.Gotham
    lblSelect.TextSize = 13
    lblSelect.TextXAlignment = Enum.TextXAlignment.Left
    lblSelect.TextColor3 = TEXT
    lblSelect.Text = "Select Weather"

    local hint = Instance.new("TextLabel", rowSelect)
    hint.Size = UDim2.new(0.5,-32,1,0)
    hint.Position = UDim2.new(0.5,0,0,0)
    hint.BackgroundTransparency = 1
    hint.Font = Enum.Font.Gotham
    hint.TextSize = 11
    hint.TextXAlignment = Enum.TextXAlignment.Right
    hint.TextColor3 = Color3.fromRGB(170,170,170)
    hint.Text = "Auto buy • MAX 4."

    local chevron = Instance.new("TextLabel", rowSelect)
    chevron.Size = UDim2.new(0,20,1,0)
    chevron.Position = UDim2.new(1,-20,0,0)
    chevron.BackgroundTransparency = 1
    chevron.Font = Enum.Font.Gotham
    chevron.TextSize = 16
    chevron.TextColor3 = TEXT
    chevron.Text = "▾"

    local selectBtn = Instance.new("TextButton", rowSelect)
    selectBtn.BackgroundTransparency = 1
    selectBtn.Size = UDim2.new(1,0,1,0)
    selectBtn.Text = ""
    selectBtn.AutoButtonColor = false

    ------------------------------------------------------------
    -- 3) ROW AUTO BUY WEATHER (MASIH DI DALAM CARD)
    ------------------------------------------------------------
    local rowAuto = Instance.new("Frame", subPreset)
    rowAuto.Size = UDim2.new(1,0,0,36)
    rowAuto.BackgroundTransparency = 1

    local lblAuto = Instance.new("TextLabel", rowAuto)
    lblAuto.Size = UDim2.new(1,-120,1,0)
    lblAuto.Position = UDim2.new(0,16,0,0)
    lblAuto.BackgroundTransparency = 1
    lblAuto.Font = Enum.Font.Gotham
    lblAuto.TextSize = 13
    lblAuto.TextXAlignment = Enum.TextXAlignment.Left
    lblAuto.TextColor3 = TEXT
    lblAuto.Text = "Auto Buy Weather"

    local pill = Instance.new("TextButton", rowAuto)
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
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local AutoWeatherOn = false
    local function refreshAuto()
        pill.BackgroundColor3 = AutoWeatherOn and ACCENT or MUTED
        knob.Position = AutoWeatherOn and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        AutoWeatherOn = not AutoWeatherOn
        refreshAuto()
    end)

    refreshAuto()
    recalcPreset()

    ------------------------------------------------------------
    -- 4) OVERLAY + PANEL KANAN (LEVEL 2)
    ------------------------------------------------------------
    local overlay = Instance.new("TextButton")
    overlay.Name = "WeatherOverlay"
    overlay.Parent = shopPage
    overlay.Size = UDim2.new(1,0,1,0)
    overlay.Position = UDim2.new(0,0,0,0)
    overlay.BackgroundTransparency = 1
    overlay.Text = ""
    overlay.Visible = false
    overlay.ZIndex = 4
    overlay.AutoButtonColor = false

    local weatherPanel = Instance.new("Frame")
    weatherPanel.Name = "WeatherPanel"
    weatherPanel.Parent = overlay
    weatherPanel.Size = UDim2.new(0, 220, 0, 220)
    weatherPanel.AnchorPoint = Vector2.new(1, 0)
    weatherPanel.Position = UDim2.new(1, -24, 0.18, 0)
    weatherPanel.BackgroundColor3 = CARD
    weatherPanel.BackgroundTransparency = 0.04
    weatherPanel.Visible = false
    weatherPanel.ZIndex = 5
    weatherPanel.Active = true
    Instance.new("UICorner", weatherPanel).CornerRadius = UDim.new(0, 12)

    local wPad = Instance.new("UIPadding", weatherPanel)
    wPad.PaddingTop    = UDim.new(0, 8)
    wPad.PaddingLeft   = UDim.new(0, 8)
    wPad.PaddingRight  = UDim.new(0, 8)
    wPad.PaddingBottom = UDim.new(0, 8)

    local weatherList = Instance.new("ScrollingFrame", weatherPanel)
    weatherList.Position = UDim2.new(0, 0, 0, 0)
    weatherList.Size = UDim2.new(1, 0, 1, 0)
    weatherList.ScrollBarThickness = 4
    weatherList.ScrollingDirection = Enum.ScrollingDirection.Y
    weatherList.CanvasSize = UDim2.new(0, 0, 0, 0)
    weatherList.BackgroundTransparency = 1
    weatherList.ClipsDescendants = true
    weatherList.ZIndex = 6
    weatherList.Active = true

    local wlLayout = Instance.new("UIListLayout", weatherList)
    wlLayout.Padding = UDim.new(0, 4)
    wlLayout.SortOrder = Enum.SortOrder.LayoutOrder
    wlLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        weatherList.CanvasSize = UDim2.new(0, 0, 0, wlLayout.AbsoluteContentSize.Y + 8)
    end)

    local function rebuildWeatherPanel()
        for _, c in ipairs(weatherList:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end

        for _, name in ipairs(WEATHER_OPTIONS) do
            local b = Instance.new("TextButton", weatherList)
            b.Size = UDim2.new(1, 0, 0, 26)
            b.BackgroundColor3 = CARD
            b.BackgroundTransparency = selectedWeather[name] and 0.08 or 0.18
            b.Font = Enum.Font.Gotham
            b.TextSize = 13
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.TextColor3 = TEXT
            b.Text = "  " .. name
            b.ZIndex = 6
            b.AutoButtonColor = false
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

            local highlight = Instance.new("Frame")
            highlight.Name = "Highlight"
            highlight.Parent = b
            highlight.AnchorPoint = Vector2.new(0,0.5)
            highlight.Position = UDim2.new(0,0,0.5,0)
            highlight.Size = UDim2.new(0,3,1,-6)
            highlight.BackgroundColor3 = Color3.fromRGB(255, 220, 0)
            highlight.BackgroundTransparency = selectedWeather[name] and 0 or 1
            highlight.ZIndex = 7

            b.MouseButton1Click:Connect(function()
                local before = selectedWeather[name]
                toggleWeather(name)
                if not before and not selectedWeather[name] then
                    return
                end
                rebuildWeatherPanel()
            end)
        end
    end

    rebuildWeatherPanel()

    local panelOpen = false
    local function setPanelOpen(state)
        panelOpen = state
        overlay.Visible = panelOpen
        weatherPanel.Visible = panelOpen
    end

    -- klik "Select Weather" -> buka/tutup panel
    selectBtn.MouseButton1Click:Connect(function()
        setPanelOpen(not panelOpen)
    end)

    -- klik overlay kosong -> close panel
    overlay.MouseButton1Click:Connect(function()
        setPanelOpen(false)
    end)

    ------------------------------------------------------------
    -- 5) ENGINE AUTO BUY (REMOTE RF/PurchaseWeatherEvent)
    ------------------------------------------------------------
    task.spawn(function()
        task.wait(5)
        while true do
            if AutoWeatherOn then
                for name, on in pairs(selectedWeather) do
                    if on then
                        pcall(function()
                            local RS = game:GetService("ReplicatedStorage")
                            local rf = RS
                                :WaitForChild("Packages")
                                :WaitForChild("_Index")
                                :WaitForChild("sleitnick_net@0.2.0")
                                :WaitForChild("net")
                                :WaitForChild("RF/PurchaseWeatherEvent")

                            rf:InvokeServer(name)
                        end)
                        task.wait(1.5)
                    end
                end
            end
            task.wait(5)
        end
    end)
end

----------------------------------------------------------------
-- PAGE SWITCH
----------------------------------------------------------------
local function ShowPage(name)
    for _, page in pairs(pages) do
        page.Visible = false
    end

    if name == "Auto Option" then
        pages["Auto Option"].Visible = true

    elseif name == "Shop & Trade" then
        local shopPage = pages["Shop & Trade"]
        shopPage.Visible = true

        if not shopPage:FindFirstChild("WeatherPresetCard") then
            BuildShopWeather()
        end

    elseif name == "Misc" then
        pages["Misc"].Visible = true

    elseif name == "Information" then
        pages["Information"].Visible = true

    elseif name == "Teleport" then
        pages["Teleport"].Visible = true

    elseif name == "Quest" then
        local questPage = pages["Quest"]
        questPage.Visible = true

        if not questPage:FindFirstChild("QuestDeepseaCard") then
            BuildQuestDeepsea()
        end
        if not questPage:FindFirstChild("QuestElementCard") then
            BuildQuestElement()
        end
        if not questPage:FindFirstChild("QuestDiamondCard") then
            BuildQuestDiamond()
        end
    end
end

BuildShopWeather()
----------------------------------------------------------------
-- MISC PAGE : BUILD FUNCTION
----------------------------------------------------------------
local function BuildMisc()
    local miscPage = pages["Misc"]

    local Players = game:GetService("Players")
    local lp = Players.LocalPlayer
    local Lighting = game:GetService("Lighting")
    local Terrain = workspace.Terrain
    local RenderSettings = settings().Rendering

    -- CONTAINER + LAYOUT MISC
    local miscContainer = Instance.new("Frame", miscPage)
    miscContainer.Size = UDim2.new(1,0,1,0)
    miscContainer.BackgroundTransparency = 1

    local miscLayout = Instance.new("UIListLayout", miscContainer)
    miscLayout.Padding = UDim.new(0,8)
    miscLayout.SortOrder = Enum.SortOrder.LayoutOrder

----------------------------------------------------------------
-- DROPDOWN : 🎥 STREAMER HIDE NAME
----------------------------------------------------------------
local holderSHN = Instance.new("Frame", miscContainer)
holderSHN.Size = UDim2.new(1,0,0,42)
holderSHN.BackgroundTransparency = 1
holderSHN.LayoutOrder = 1

local mainBtnSHN = Instance.new("TextButton", holderSHN)
mainBtnSHN.Size = UDim2.new(1,0,0,42)
mainBtnSHN.Text = "🎥 Streamer Hide Name ▼"
mainBtnSHN.Font = Enum.Font.Gotham
mainBtnSHN.TextSize = 15
mainBtnSHN.TextXAlignment = Enum.TextXAlignment.Left
mainBtnSHN.TextColor3 = TEXT
mainBtnSHN.BackgroundColor3 = CARD
mainBtnSHN.BackgroundTransparency = ALPHA_CARD
mainBtnSHN.AutoButtonColor = false
Instance.new("UICorner", mainBtnSHN).CornerRadius = UDim.new(0,10)

local subSHN = Instance.new("Frame", holderSHN)
subSHN.Position = UDim2.new(0,0,0,42)
subSHN.Size = UDim2.new(1,0,0,0)
subSHN.ClipsDescendants = true
subSHN.BackgroundTransparency = 1

local layoutSHN = Instance.new("UIListLayout", subSHN)
layoutSHN.Padding = UDim.new(0,6)

local openSHN = false
local function recalcSHN()
    task.wait()
    local h = layoutSHN.AbsoluteContentSize.Y
    if openSHN then
        subSHN.Size = UDim2.new(1,0,0,h)
        holderSHN.Size = UDim2.new(1,0,0,42 + h)
        mainBtnSHN.Text = "🎥 Streamer Hide Name ▲"
    else
        subSHN.Size = UDim2.new(1,0,0,0)
        holderSHN.Size = UDim2.new(1,0,0,42)
        mainBtnSHN.Text = "🎥 Streamer Hide Name ▼"
    end
end

mainBtnSHN.MouseButton1Click:Connect(function()
    openSHN = not openSHN
    recalcSHN()
end)

----------------------------------------------------------------
-- PREDECLARE TEXTBOX (buat dipakai di toggle)
----------------------------------------------------------------
local nameBox

----------------------------------------------------------------
-- ROW 1: TOGGLE ON/OFF
----------------------------------------------------------------
do
    local rowToggle = Instance.new("Frame", subSHN)
    rowToggle.Size = UDim2.new(1,0,0,36)
    rowToggle.BackgroundTransparency = 1

    local labelT = Instance.new("TextLabel", rowToggle)
    labelT.Size = UDim2.new(1,-100,1,0)
    labelT.Position = UDim2.new(0,16,0,0)
    labelT.BackgroundTransparency = 1
    labelT.Font = Enum.Font.Gotham
    labelT.TextSize = 13
    labelT.TextXAlignment = Enum.TextXAlignment.Left
    labelT.TextColor3 = TEXT
    labelT.Text = "Enable Custom Name"

    local pill = Instance.new("TextButton", rowToggle)
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
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local function refreshToggle()
        local on = _G.RAY_StreamerOn
        pill.BackgroundColor3 = on and ACCENT or MUTED
        knob.Position = on and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        _G.RAY_StreamerOn = not _G.RAY_StreamerOn

        -- kalau di-ON-kan, sinkron sama isi textbox
        if _G.RAY_StreamerOn and nameBox then
            _G.RAY_CustomName = nameBox.Text ~= "" and nameBox.Text or "discord.gg/Threeblox"
            nameBox.Text = _G.RAY_CustomName
        end

        applyStreamerState()
        refreshToggle()
    end)

    refreshToggle()
end

----------------------------------------------------------------
-- ROW 2: CUSTOM NAME
----------------------------------------------------------------
do
    local rowName = Instance.new("Frame", subSHN)
    rowName.Size = UDim2.new(1,0,0,36)
    rowName.BackgroundTransparency = 1

    local labelName = Instance.new("TextLabel", rowName)
    labelName.Size = UDim2.new(1,-140,1,0)
    labelName.Position = UDim2.new(0,16,0,0)
    labelName.BackgroundTransparency = 1
    labelName.Font = Enum.Font.Gotham
    labelName.TextSize = 13
    labelName.TextXAlignment = Enum.TextXAlignment.Left
    labelName.TextColor3 = TEXT
    labelName.Text = "Custom Name"

    nameBox = Instance.new("TextBox", rowName)
    nameBox.Size = UDim2.new(0,220,0,28)
    nameBox.Position = UDim2.new(1,-236,0.5,-14)
    nameBox.Text = _G.RAY_CustomName
    nameBox.Font = Enum.Font.Gotham
    nameBox.TextSize = 13
    nameBox.TextXAlignment = Enum.TextXAlignment.Center
    nameBox.TextColor3 = TEXT
    nameBox.ClearTextOnFocus = false
    nameBox.BackgroundColor3 = CARD
    nameBox.BackgroundTransparency = 0.12
    Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0,8)

    nameBox.FocusLost:Connect(function(enter)
        if not enter then return end
        if nameBox.Text == "" then
            _G.RAY_CustomName = "discord.gg/Threeblox"
            nameBox.Text = _G.RAY_CustomName
        else
            _G.RAY_CustomName = nameBox.Text
        end
        if _G.RAY_StreamerOn then
            applyStreamerState()
        end
    end)
end

recalcSHN()



----------------------------------------------------------------
-- CORE UNTUK PLAYER UTILITY
----------------------------------------------------------------
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

_G.RAY_AntiAFK_On        = false
_G.RAY_DisableRodSkin    = _G.RAY_DisableRodSkin    or false
_G.RAY_DisableRodEffect  = _G.RAY_DisableRodEffect  or false

local AntiAFKConn

-- Anti AFK (VirtualUser + Idled). [web:449]
function StartAntiAFK()
    if AntiAFKConn then
        AntiAFKConn:Disconnect()
    end
    AntiAFKConn = lp.Idled:Connect(function()
        pcall(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end)
end

function StopAntiAFK()
    if AntiAFKConn then
        AntiAFKConn:Disconnect()
        AntiAFKConn = nil
    end
end

local ROD_VFX_NAMES = {
    "1x1x1x1 Ban Hammer Dive",
    "Abyssal Chroma Dive",
    "Abyssfire Dive",
    "Amber Dive",
    "Amethyst Dive",
    "BanHammerThrow",
    "Xmas Tree Rod Dive",
    "The Vanquisher Dive",
    "Ornament Axe Dive",
    "Frozen Krampus Scythe Dive",
    "Electric Guitar Dive",
    "Eclipse Katana Dive",
    "Divine Blade Dive",
}

function KillAllRodSkins()
    local vfxRoot = ReplicatedStorage:FindFirstChild("VFX")
    if not vfxRoot then return end

    for _, name in ipairs(ROD_VFX_NAMES) do
        local obj = vfxRoot:FindFirstChild(name, true)
        if obj then
            pcall(function()
                obj:Destroy()
            end)
        end
    end
end

    ----------------------------------------------------------------
    -- DROPDOWN : 👤 PLAYER UTILITY
    ----------------------------------------------------------------
    local holderPU = Instance.new("Frame", miscContainer)
    holderPU.Size = UDim2.new(1,0,0,42)
    holderPU.BackgroundTransparency = 1
    holderPU.LayoutOrder = 1

    local mainBtnPU = Instance.new("TextButton", holderPU)
    mainBtnPU.Size = UDim2.new(1,0,0,42)
    mainBtnPU.Text = "👤 Player Utility ▼"
    mainBtnPU.Font = Enum.Font.Gotham
    mainBtnPU.TextSize = 15
    mainBtnPU.TextXAlignment = Enum.TextXAlignment.Left
    mainBtnPU.TextColor3 = TEXT
    mainBtnPU.BackgroundColor3 = CARD
    mainBtnPU.BackgroundTransparency = ALPHA_CARD
    mainBtnPU.AutoButtonColor = false
    Instance.new("UICorner", mainBtnPU).CornerRadius = UDim.new(0,10)

    local subPU = Instance.new("Frame", holderPU)
    subPU.Position = UDim2.new(0,0,0,42)
    subPU.Size = UDim2.new(1,0,0,0)
    subPU.ClipsDescendants = true
    subPU.BackgroundTransparency = 1

    local layoutPU = Instance.new("UIListLayout", subPU)
    layoutPU.Padding = UDim.new(0,6)

    local openPU = false
    local function recalcPU()
        task.wait()
        local h = layoutPU.AbsoluteContentSize.Y
        if openPU then
            subPU.Size = UDim2.new(1,0,0,h)
            holderPU.Size = UDim2.new(1,0,0,42 + h)
            mainBtnPU.Text = "👤 Player Utility ▲"
        else
            subPU.Size = UDim2.new(1,0,0,0)
            holderPU.Size = UDim2.new(1,0,0,42)
            mainBtnPU.Text = "👤 Player Utility ▼"
        end
    end

    mainBtnPU.MouseButton1Click:Connect(function()
        openPU = not openPU
        recalcPU()
    end)

----------------------------------------------------------------
-- 🔍 MAX ZOOM (150)
----------------------------------------------------------------
do
    local rowZoom = Instance.new("Frame", subPU)
    rowZoom.Size = UDim2.new(1,0,0,36)
    rowZoom.BackgroundTransparency = 1

    local labelZoom = Instance.new("TextLabel", rowZoom)
    labelZoom.Size = UDim2.new(1,-100,1,0)
    labelZoom.Position = UDim2.new(0,16,0,0)
    labelZoom.BackgroundTransparency = 1
    labelZoom.Font = Enum.Font.Gotham
    labelZoom.TextSize = 13
    labelZoom.TextXAlignment = Enum.TextXAlignment.Left
    labelZoom.TextColor3 = TEXT
    labelZoom.Text = "🔍 Max Zoom (150)"

    local pillZoom = Instance.new("TextButton", rowZoom)
    pillZoom.Size = UDim2.new(0,50,0,24)
    pillZoom.Position = UDim2.new(1,-80,0.5,-12)
    pillZoom.BackgroundColor3 = MUTED
    pillZoom.BackgroundTransparency = 0.1
    pillZoom.Text = ""
    pillZoom.AutoButtonColor = false
    Instance.new("UICorner", pillZoom).CornerRadius = UDim.new(0,999)

    local knobZoom = Instance.new("Frame", pillZoom)
    knobZoom.Size = UDim2.new(0,18,0,18)
    knobZoom.Position = UDim2.new(0,3,0.5,-9)
    knobZoom.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", knobZoom).CornerRadius = UDim.new(0,999)

    local enabled = false
    local DEFAULT_MAX = lp.CameraMaxZoomDistance
    local DEFAULT_MIN = lp.CameraMinZoomDistance
    local MAX_ZOOM = 150
    local MIN_ZOOM = 0.8

    local function refresh()
        pillZoom.BackgroundColor3 = enabled and ACCENT or MUTED
        knobZoom.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    local function applyZoom()
        pcall(function()
            lp.CameraMaxZoomDistance = MAX_ZOOM
            lp.CameraMinZoomDistance = MIN_ZOOM
        end)
    end

    local function resetZoom()
        pcall(function()
            lp.CameraMaxZoomDistance = DEFAULT_MAX
            lp.CameraMinZoomDistance = DEFAULT_MIN
        end)
    end

    pillZoom.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            applyZoom()
        else
            resetZoom()
        end
        refresh()
    end)

    lp:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
        if enabled then
            applyZoom()
        end
    end)

    lp.CharacterAdded:Connect(function()
        task.wait(0.2)
        if enabled then
            applyZoom()
        end
    end)

    refresh()
end

----------------------------------------------------------------
-- ⏱️ ANTI AFK
----------------------------------------------------------------
do
    local rowAFK = Instance.new("Frame", subPU)
    rowAFK.Size = UDim2.new(1,0,0,36)
    rowAFK.BackgroundTransparency = 1

    local labelAFK = Instance.new("TextLabel", rowAFK)
    labelAFK.Size = UDim2.new(1,-100,1,0)
    labelAFK.Position = UDim2.new(0,16,0,0)
    labelAFK.BackgroundTransparency = 1
    labelAFK.Font = Enum.Font.Gotham
    labelAFK.TextSize = 13
    labelAFK.TextXAlignment = Enum.TextXAlignment.Left
    labelAFK.TextColor3 = TEXT
    labelAFK.Text = "⏱️ Anti AFK"

    local pillAFK = Instance.new("TextButton", rowAFK)
    pillAFK.Size = UDim2.new(0,50,0,24)
    pillAFK.Position = UDim2.new(1,-80,0.5,-12)
    pillAFK.BackgroundColor3 = MUTED
    pillAFK.BackgroundTransparency = 0.1
    pillAFK.Text = ""
    pillAFK.AutoButtonColor = false
    Instance.new("UICorner", pillAFK).CornerRadius = UDim.new(0,999)

    local knobAFK = Instance.new("Frame", pillAFK)
    knobAFK.Size = UDim2.new(0,18,0,18)
    knobAFK.Position = UDim2.new(0,3,0.5,-9)
    knobAFK.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", knobAFK).CornerRadius = UDim.new(0,999)

    _G.RAY_AntiAFK_On = _G.RAY_AntiAFK_On or false

    local function refresh()
        pillAFK.BackgroundColor3 = _G.RAY_AntiAFK_On and ACCENT or MUTED
        knobAFK.Position = _G.RAY_AntiAFK_On
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    pillAFK.MouseButton1Click:Connect(function()
        _G.RAY_AntiAFK_On = not _G.RAY_AntiAFK_On
        if _G.RAY_AntiAFK_On then
            StartAntiAFK()
        else
            StopAntiAFK()
        end
        refresh()
    end)

    lp.CharacterAdded:Connect(function()
        if _G.RAY_AntiAFK_On then
            StartAntiAFK()
        end
    end)

    refresh()
end

----------------------------------------------------------------
-- 🎯 FISHING RADAR
----------------------------------------------------------------
do
    local rowRadar = Instance.new("Frame", subPU)
    rowRadar.Size = UDim2.new(1,0,0,36)
    rowRadar.BackgroundTransparency = 1

    local labelRadar = Instance.new("TextLabel", rowRadar)
    labelRadar.Size = UDim2.new(1,-100,1,0)
    labelRadar.Position = UDim2.new(0,16,0,0)
    labelRadar.BackgroundTransparency = 1
    labelRadar.Font = Enum.Font.Gotham
    labelRadar.TextSize = 13
    labelRadar.TextXAlignment = Enum.TextXAlignment.Left
    labelRadar.TextColor3 = TEXT
    labelRadar.Text = "🎯 Fishing Radar"

    local pillRadar = Instance.new("TextButton", rowRadar)
    pillRadar.Size = UDim2.new(0,50,0,24)
    pillRadar.Position = UDim2.new(1,-80,0.5,-12)
    pillRadar.BackgroundColor3 = MUTED
    pillRadar.BackgroundTransparency = 0.1
    pillRadar.Text = ""
    pillRadar.AutoButtonColor = false
    Instance.new("UICorner", pillRadar).CornerRadius = UDim.new(0,999)

    local knobRadar = Instance.new("Frame", pillRadar)
    knobRadar.Size = UDim2.new(0,18,0,18)
    knobRadar.Position = UDim2.new(0,3,0.5,-9)
    knobRadar.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", knobRadar).CornerRadius = UDim.new(0,999)

    _G.RAY_FishingRadarOn = _G.RAY_FishingRadarOn or false
    local radarOn = _G.RAY_FishingRadarOn

    local function refresh()
        pillRadar.BackgroundColor3 = radarOn and ACCENT or MUTED
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
            refresh()
        else
            warn("[Threeblox] Radar toggle failed:", res)
        end
    end)

    lp.CharacterAdded:Connect(function()
        if _G.RAY_FishingRadarOn then
            task.delay(1, function()
                local rf = GetRadarRF()
                if rf then
                    pcall(function()
                        rf:InvokeServer(true)
                    end)
                end
            end)
        end
    end)

    refresh()
end



----------------------------------------------------------------
-- 🏃 WALK SPEED
----------------------------------------------------------------
    do
        local rowWS = Instance.new("Frame", subPU)
        rowWS.Size = UDim2.new(1,0,0,36)
        rowWS.BackgroundTransparency = 1

        local labelWS = Instance.new("TextLabel", rowWS)
        labelWS.Size = UDim2.new(1,-160,1,0)
        labelWS.Position = UDim2.new(0,16,0,0)
        labelWS.BackgroundTransparency = 1
        labelWS.Font = Enum.Font.Gotham
        labelWS.TextSize = 13
        labelWS.TextXAlignment = Enum.TextXAlignment.Left
        labelWS.TextColor3 = TEXT
        labelWS.Text = "🏃 WalkSpeed"

        local inputWS = Instance.new("TextBox", rowWS)
        inputWS.Size = UDim2.new(0,60,0,24)
        inputWS.Position = UDim2.new(1,-140,0.5,-12)
        inputWS.BackgroundColor3 = CARD
        inputWS.BackgroundTransparency = 0.1
        inputWS.Font = Enum.Font.Gotham
        inputWS.TextSize = 12
        inputWS.TextColor3 = TEXT
        inputWS.TextXAlignment = Enum.TextXAlignment.Center
        inputWS.ClearTextOnFocus = false
        inputWS.Text = "32"
        Instance.new("UICorner", inputWS).CornerRadius = UDim.new(0,6)

        local pillWS = Instance.new("TextButton", rowWS)
        pillWS.Size = UDim2.new(0,50,0,24)
        pillWS.Position = UDim2.new(1,-80,0.5,-12)
        pillWS.BackgroundColor3 = MUTED
        pillWS.BackgroundTransparency = 0.1
        pillWS.Text = ""
        pillWS.AutoButtonColor = false
        Instance.new("UICorner", pillWS).CornerRadius = UDim.new(0,999)

        local knobWS = Instance.new("Frame", pillWS)
        knobWS.Size = UDim2.new(0,18,0,18)
        knobWS.Position = UDim2.new(0,3,0.5,-9)
        knobWS.BackgroundColor3 = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", knobWS).CornerRadius = UDim.new(0,999)

        local wsEnabled = false
        local defaultWS = 16

        local function refreshWS()
            pillWS.BackgroundColor3 = wsEnabled and ACCENT or MUTED
            knobWS.Position = wsEnabled
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        local function applyWS()
            local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
            if not hum then return end

            local n = tonumber(inputWS.Text)
            if not n or n <= 0 then
                n = 32
                inputWS.Text = "32"
            end

            hum.WalkSpeed = n
        end

        local function resetWS()
            local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            hum.WalkSpeed = defaultWS
        end

        pillWS.MouseButton1Click:Connect(function()
            wsEnabled = not wsEnabled

            local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                defaultWS = hum.WalkSpeed
            end

            if wsEnabled then
                applyWS()
            else
                resetWS()
            end

            refreshWS()
        end)

        inputWS.FocusLost:Connect(function(enter)
            if wsEnabled and enter then
                applyWS()
            end
        end)

        lp.CharacterAdded:Connect(function(char)
            local hum = char:WaitForChild("Humanoid", 5)
            if hum then
                defaultWS = hum.WalkSpeed
                if wsEnabled then
                    applyWS()
                end
            end
        end)

        refreshWS()
    end

    ----------------------------------------------------------------
    -- ✈ FLY
    ----------------------------------------------------------------
    do
        local rowFly = Instance.new("Frame", subPU)
        rowFly.Size = UDim2.new(1,0,0,36)
        rowFly.BackgroundTransparency = 1

        local labelFly = Instance.new("TextLabel", rowFly)
        labelFly.Size = UDim2.new(1,-160,1,0)
        labelFly.Position = UDim2.new(0,16,0,0)
        labelFly.BackgroundTransparency = 1
        labelFly.Font = Enum.Font.Gotham
        labelFly.TextSize = 13
        labelFly.TextXAlignment = Enum.TextXAlignment.Left
        labelFly.TextColor3 = TEXT
        labelFly.Text = "✈ Fly"

        local inputFly = Instance.new("TextBox", rowFly)
        inputFly.Size = UDim2.new(0,60,0,24)
        inputFly.Position = UDim2.new(1,-140,0.5,-12)
        inputFly.BackgroundColor3 = CARD
        inputFly.BackgroundTransparency = 0.1
        inputFly.Font = Enum.Font.Gotham
        inputFly.TextSize = 12
        inputFly.TextColor3 = TEXT
        inputFly.TextXAlignment = Enum.TextXAlignment.Center
        inputFly.ClearTextOnFocus = false
        inputFly.Text = "60"
        Instance.new("UICorner", inputFly).CornerRadius = UDim.new(0,6)

        local pillFly = Instance.new("TextButton", rowFly)
        pillFly.Size = UDim2.new(0,50,0,24)
        pillFly.Position = UDim2.new(1,-80,0.5,-12)
        pillFly.BackgroundColor3 = MUTED
        pillFly.BackgroundTransparency = 0.1
        pillFly.Text = ""
        pillFly.AutoButtonColor = false
        Instance.new("UICorner", pillFly).CornerRadius = UDim.new(0,999)

        local knobFly = Instance.new("Frame", pillFly)
        knobFly.Size = UDim2.new(0,18,0,18)
        knobFly.Position = UDim2.new(0,3,0.5,-9)
        knobFly.BackgroundColor3 = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", knobFly).CornerRadius = UDim.new(0,999)

        local flyEnabled = false
        local flyConn
        local flyBV

        local function refreshFly()
            pillFly.BackgroundColor3 = flyEnabled and ACCENT or MUTED
            knobFly.Position = flyEnabled
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        local function stopFly()
            flyEnabled = false
            if flyConn then
                flyConn:Disconnect()
                flyConn = nil
            end
            if flyBV then
                flyBV:Destroy()
                flyBV = nil
            end

            local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.PlatformStand = false
            end
            refreshFly()
        end

        local function startFly()
            local char = lp.Character or lp.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then return end

            flyEnabled = true
            hum.PlatformStand = true

            flyBV = Instance.new("BodyVelocity")
            flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
            flyBV.Velocity = Vector3.new(0,0,0)
            flyBV.Parent = hrp

            local UIS = game:GetService("UserInputService")
            local RS = game:GetService("RunService")

            flyConn = RS.RenderStepped:Connect(function()
                if not flyEnabled then return end
                if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then
                    stopFly()
                    return
                end

                local cam = workspace.CurrentCamera
                if not cam then return end

                local speed = tonumber(inputFly.Text) or 60

                local forward = cam.CFrame.LookVector
                local right = cam.CFrame.RightVector

                local dir = Vector3.new()

                if UIS:IsKeyDown(Enum.KeyCode.W) then
                    dir += forward
                end
                if UIS:IsKeyDown(Enum.KeyCode.S) then
                    dir -= forward
                end
                if UIS:IsKeyDown(Enum.KeyCode.A) then
                    dir -= right
                end
                if UIS:IsKeyDown(Enum.KeyCode.D) then
                    dir += right
                end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                    dir += Vector3.new(0,1,0)
                end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                    dir -= Vector3.new(0,1,0)
                end

                if dir.Magnitude > 0 then
                    dir = dir.Unit
                end

                flyBV.Velocity = dir * speed
            end)

            refreshFly()
        end

        pillFly.MouseButton1Click:Connect(function()
            if flyEnabled then
                stopFly()
            else
                startFly()
            end
        end)

        lp.CharacterAdded:Connect(function()
            if flyEnabled then
                stopFly()
            end
        end)

        refreshFly()
    end

    ----------------------------------------------------------------
    -- 🧊 FREEZE POSITION
    ----------------------------------------------------------------
    do
        local rowFreeze = Instance.new("Frame", subPU)
        rowFreeze.Size = UDim2.new(1,0,0,36)
        rowFreeze.BackgroundTransparency = 1

        local labelFreeze = Instance.new("TextLabel", rowFreeze)
        labelFreeze.Size = UDim2.new(1,-100,1,0)
        labelFreeze.Position = UDim2.new(0,16,0,0)
        labelFreeze.BackgroundTransparency = 1
        labelFreeze.Font = Enum.Font.Gotham
        labelFreeze.TextSize = 13
        labelFreeze.TextXAlignment = Enum.TextXAlignment.Left
        labelFreeze.TextColor3 = TEXT
        labelFreeze.Text = "🧊 Freeze Position"

        local pillFreeze = Instance.new("TextButton", rowFreeze)
        pillFreeze.Size = UDim2.new(0,50,0,24)
        pillFreeze.Position = UDim2.new(1,-80,0.5,-12)
        pillFreeze.BackgroundColor3 = MUTED
        pillFreeze.BackgroundTransparency = 0.1
        pillFreeze.Text = ""
        pillFreeze.AutoButtonColor = false
        Instance.new("UICorner", pillFreeze).CornerRadius = UDim.new(0,999)

        local knobFreeze = Instance.new("Frame", pillFreeze)
        knobFreeze.Size = UDim2.new(0,18,0,18)
        knobFreeze.Position = UDim2.new(0,3,0.5,-9)
        knobFreeze.BackgroundColor3 = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", knobFreeze).CornerRadius = UDim.new(0,999)

        local freezeOn = false
        local freezeConn
        local savedCF

        local function refreshFreeze()
            pillFreeze.BackgroundColor3 = freezeOn and ACCENT or MUTED
            knobFreeze.Position = freezeOn
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        local function startFreeze()
            local char = lp.Character or lp.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then return end

            savedCF = hrp.CFrame
            hum.PlatformStand = true
            hum.WalkSpeed = 0
            hum.JumpPower = 0

            freezeConn = game:GetService("RunService").Heartbeat:Connect(function()
                if not freezeOn then return end
                if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
                hrp.CFrame = savedCF
                hrp.AssemblyLinearVelocity = Vector3.new()
            end)
        end

        local function stopFreeze()
            freezeOn = false
            if freezeConn then
                freezeConn:Disconnect()
                freezeConn = nil
            end
            local char = lp.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.PlatformStand = false
                hum.WalkSpeed = 16
                hum.JumpPower = 50
            end
            refreshFreeze()
        end

        pillFreeze.MouseButton1Click:Connect(function()
            if freezeOn then
                stopFreeze()
            else
                freezeOn = true
                startFreeze()
                refreshFreeze()
            end
        end)

        lp.CharacterAdded:Connect(function()
            if freezeOn then
                stopFreeze()
            end
        end)

        refreshFreeze()
    end

    ----------------------------------------------------------------
    -- 🧱 FPS BOOST
    ----------------------------------------------------------------
    do
        local rowLow = Instance.new("Frame", subPU)
        rowLow.Size = UDim2.new(1,0,0,36)
        rowLow.BackgroundTransparency = 1

        local labelLow = Instance.new("TextLabel", rowLow)
        labelLow.Size = UDim2.new(1,-100,1,0)
        labelLow.Position = UDim2.new(0,16,0,0)
        labelLow.BackgroundTransparency = 1
        labelLow.Font = Enum.Font.Gotham
        labelLow.TextSize = 13
        labelLow.TextXAlignment = Enum.TextXAlignment.Left
        labelLow.TextColor3 = TEXT
        labelLow.Text = "🧱 FPS Boost"

        local pillLow = Instance.new("TextButton", rowLow)
        pillLow.Size = UDim2.new(0,50,0,24)
        pillLow.Position = UDim2.new(1,-80,0.5,-12)
        pillLow.BackgroundColor3 = MUTED
        pillLow.BackgroundTransparency = 0.1
        pillLow.Text = ""
        pillLow.AutoButtonColor = false
        Instance.new("UICorner", pillLow).CornerRadius = UDim.new(0,999)

        local knobLow = Instance.new("Frame", pillLow)
        knobLow.Size = UDim2.new(0,18,0,18)
        knobLow.Position = UDim2.new(0,3,0.5,-9)
        knobLow.BackgroundColor3 = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", knobLow).CornerRadius = UDim.new(0,999)

        local lowOn = false

        local oldQuality = RenderSettings.QualityLevel
        local oldBrightness = Lighting.Brightness
        local oldFogEnd = Lighting.FogEnd
        local oldGlobalShadows = Lighting.GlobalShadows
        local oldAmbient = Lighting.Ambient
        local oldOutdoorAmbient = Lighting.OutdoorAmbient
        local oldWaterWaveSize = Terrain.WaterWaveSize
        local oldWaterWaveSpeed = Terrain.WaterWaveSpeed
        local oldWaterTransparency = Terrain.WaterTransparency
        local oldWaterReflectance = Terrain.WaterReflectance

        local function refreshLow()
            pillLow.BackgroundColor3 = lowOn and ACCENT or MUTED
            knobLow.Position = lowOn
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        local function applyFPSBoost()
            oldQuality = RenderSettings.QualityLevel
            pcall(function()
                RenderSettings.QualityLevel = Enum.QualityLevel.Level01
            end)

            oldBrightness = Lighting.Brightness
            oldFogEnd = Lighting.FogEnd
            oldGlobalShadows = Lighting.GlobalShadows
            oldAmbient = Lighting.Ambient
            oldOutdoorAmbient = Lighting.OutdoorAmbient

            Lighting.Brightness = 1
            Lighting.FogEnd = 100
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(128,128,128)
            Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)

            oldWaterWaveSize = Terrain.WaterWaveSize
            oldWaterWaveSpeed = Terrain.WaterWaveSpeed
            oldWaterTransparency = Terrain.WaterTransparency
            oldWaterReflectance = Terrain.WaterReflectance

            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterTransparency = 1
            Terrain.WaterReflectance = 0
        end

        local function resetFPSBoost()
            pcall(function()
                RenderSettings.QualityLevel = oldQuality
            end)

            Lighting.Brightness = oldBrightness
            Lighting.FogEnd = oldFogEnd
            Lighting.GlobalShadows = oldGlobalShadows
            Lighting.Ambient = oldAmbient
            Lighting.OutdoorAmbient = oldOutdoorAmbient

            Terrain.WaterWaveSize = oldWaterWaveSize
            Terrain.WaterWaveSpeed = oldWaterWaveSpeed
            Terrain.WaterTransparency = oldWaterTransparency
            Terrain.WaterReflectance = oldWaterReflectance
        end

        pillLow.MouseButton1Click:Connect(function()
            lowOn = not lowOn
            if lowOn then
                applyFPSBoost()
            else
                resetFPSBoost()
            end
            refreshLow()
        end)

        refreshLow()
    end

    ----------------------------------------------------------------
    -- 🌑 DARK SCREEN (COLORCORRECTION)
    ----------------------------------------------------------------
    do
        local rowDark = Instance.new("Frame", subPU)
        rowDark.Size = UDim2.new(1,0,0,36)
        rowDark.BackgroundTransparency = 1

        local labelDark = Instance.new("TextLabel", rowDark)
        labelDark.Size = UDim2.new(1,-100,1,0)
        labelDark.Position = UDim2.new(0,16,0,0)
        labelDark.BackgroundTransparency = 1
        labelDark.Font = Enum.Font.Gotham
        labelDark.TextSize = 13
        labelDark.TextXAlignment = Enum.TextXAlignment.Left
        labelDark.TextColor3 = TEXT
        labelDark.Text = "🌑 Dark Screen"

        local pillDark = Instance.new("TextButton", rowDark)
        pillDark.Size = UDim2.new(0,50,0,24)
        pillDark.Position = UDim2.new(1,-80,0.5,-12)
        pillDark.BackgroundColor3 = MUTED
        pillDark.BackgroundTransparency = 0.1
        pillDark.Text = ""
        pillDark.AutoButtonColor = false
        Instance.new("UICorner", pillDark).CornerRadius = UDim.new(0,999)

        local knobDark = Instance.new("Frame", pillDark)
        knobDark.Size = UDim2.new(0,18,0,18)
        knobDark.Position = UDim2.new(0,3,0.5,-9)
        knobDark.BackgroundColor3 = Color3.fromRGB(255,255,255)
        Instance.new("UICorner", knobDark).CornerRadius = UDim.new(0,999)

        local darkOn = false
        local DarkEffect = Lighting:FindFirstChild("ThreebloxDark")

        local oldBrightness = 0
        local oldContrast = 0
        local oldSaturation = 0

        local function refreshDark()
            pillDark.BackgroundColor3 = darkOn and ACCENT or MUTED
            knobDark.Position = darkOn
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        end

        local function ensureDarkEffect()
            DarkEffect = Lighting:FindFirstChild("ThreebloxDark")
            if not DarkEffect then
                DarkEffect = Instance.new("ColorCorrectionEffect")
                DarkEffect.Name = "ThreebloxDark"
                DarkEffect.Parent = Lighting
            end
        end

        local function applyDark()
            ensureDarkEffect()
            oldBrightness = DarkEffect.Brightness
            oldContrast   = DarkEffect.Contrast
            oldSaturation = DarkEffect.Saturation

            DarkEffect.Brightness = -0.4
            DarkEffect.Contrast   = 0.2
            DarkEffect.Saturation = -0.5
            DarkEffect.Enabled    = true
        end

        local function resetDark()
            if not DarkEffect then return end
            DarkEffect.Brightness = oldBrightness
            DarkEffect.Contrast   = oldContrast
            DarkEffect.Saturation = oldSaturation
            DarkEffect.Enabled    = false
        end

        pillDark.MouseButton1Click:Connect(function()
            darkOn = not darkOn
            if darkOn then
                applyDark()
            else
                resetDark()
            end
            refreshDark()
        end)

        refreshDark()
    end

    ----------------------------------------------------------------
    -- DROPDOWN : 🔔 NOTIFICATION & VISUAL
    ----------------------------------------------------------------
    local holder = Instance.new("Frame", miscContainer)
    holder.Size = UDim2.new(1,0,0,42)
    holder.BackgroundTransparency = 1
    holder.LayoutOrder = 2

    local mainBtn = Instance.new("TextButton", holder)
    mainBtn.Size = UDim2.new(1,0,0,42)
    mainBtn.Text = "🔔 Notification & Visual ▼"
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

    local subLayout = Instance.new("UIListLayout", sub)
    subLayout.Padding = UDim.new(0,6)

    local open = false
    local function recalc()
        task.wait()
        local h = subLayout.AbsoluteContentSize.Y
        if open then
            sub.Size = UDim2.new(1,0,0,h)
            holder.Size = UDim2.new(1,0,0,42 + h)
            mainBtn.Text = "🔔 Notification & Visual ▲"
        else
            sub.Size = UDim2.new(1,0,0,0)
            holder.Size = UDim2.new(1,0,0,42)
            mainBtn.Text = "🔔 Notification & Visual ▼"
        end
    end

    mainBtn.MouseButton1Click:Connect(function()
        open = not open
        recalc()
    end)

    ----------------------------------------------------------------
    -- TOGGLE : 🐟 DISABLE FISH IMAGE
    ----------------------------------------------------------------
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
    label.Text = "🐟 Disable Fish Image"

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
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local enabled = false
    local conn

    local function refresh()
        pill.BackgroundColor3 = enabled and ACCENT or MUTED
        knob.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        enabled = not enabled

        local gui = Players.LocalPlayer:WaitForChild("PlayerGui")

        if enabled then
            for _,v in ipairs(gui:GetDescendants()) do
                if v.Name == "Small Notification" then
                    v:Destroy()
                end
            end

            conn = gui.DescendantAdded:Connect(function(v)
                if v.Name == "Small Notification" then
                    v:Destroy()
                end
            end)
        else
            if conn then
                conn:Disconnect()
                conn = nil
            end
        end

        refresh()
    end)

    refresh()

    ----------------------------------------------------------------
-- 🎬 DISABLE CUTSCENE (KILL REMOTE)
----------------------------------------------------------------
do
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
    label.Text = "🎬 Disable All Cutscenes"

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
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local enabled = _G.RAY_DisableCutscene or false

    local function refresh()
        pill.BackgroundColor3 = enabled and ACCENT or MUTED
        knob.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    local function KillCutsceneRemotes()
        local RS = game:GetService("ReplicatedStorage")
        local pkg = RS:FindFirstChild("Packages")
        if not pkg then return end

        local index = pkg:FindFirstChild("_Index")
        if not index then return end

        local netPkg = index:FindFirstChild("sleitnick_net@0.2.0")
            or index:FindFirstChild("sleitnick_net")
        if not netPkg then return end

        local netScript = netPkg:FindFirstChild("net")
        if not netScript then return end

        for _, name in ipairs({"RE/ReplicateCutscene","RE/StopCutscene"}) do
            local inst = netScript:FindFirstChild(name)
            if inst then
                inst:Destroy()
            end
        end
    end

    pill.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.RAY_DisableCutscene = enabled

        if enabled then
            KillCutsceneRemotes()
        end

        refresh()
    end)

    -- auto kill lagi kalau rejoin / script reload dan toggle masih ON
    task.delay(1, function()
        if enabled then
            KillCutsceneRemotes()
        end
    end)

    refresh()
end


    ----------------------------------------------------------------
-- 🎣 DISABLE ROD EFFECT
----------------------------------------------------------------
do
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
    label.Text = "🎣 Disable Rod Effect"

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
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local enabled = _G.RAY_DisableRodEffect or false
    local killing = false

    local function HardKillAnims()
        if killing then return end
        killing = true

        local char = lp.Character or lp.CharacterAdded:Wait()
        local hum  = char:WaitForChild("Humanoid")
        local animator = hum:WaitForChild("Animator")

        task.spawn(function()
            while enabled do
                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                    track:Stop(0)
                end
                task.wait(0.05)
            end
            killing = false
        end)
    end

    local function refresh()
        pill.BackgroundColor3 = enabled and ACCENT or MUTED
        knob.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.RAY_DisableRodEffect = enabled

        if enabled then
            HardKillAnims()
        end

        refresh()
    end)

    lp.CharacterAdded:Connect(function()
        if enabled then
            task.delay(0.3, HardKillAnims)
        end
    end)

    refresh()
end

----------------------------------------------------------------
-- 🧪 DISABLE ROD SKIN
----------------------------------------------------------------
do
    local rowSkin = Instance.new("Frame", sub)
    rowSkin.Size = UDim2.new(1,0,0,48)
    rowSkin.BackgroundTransparency = 1

    local labelSkin = Instance.new("TextLabel", rowSkin)
    labelSkin.Size = UDim2.new(1,-100,0.5,0)
    labelSkin.Position = UDim2.new(0,16,0,0)
    labelSkin.BackgroundTransparency = 1
    labelSkin.Font = Enum.Font.Gotham
    labelSkin.TextSize = 13
    labelSkin.TextXAlignment = Enum.TextXAlignment.Left
    labelSkin.TextColor3 = TEXT
    labelSkin.Text = "🧪 Disable Rod Skin"

    local infoSkin = Instance.new("TextLabel", rowSkin)
    infoSkin.Size = UDim2.new(1,-16,0.5,0)
    infoSkin.Position = UDim2.new(0,16,0.5,0)
    infoSkin.BackgroundTransparency = 1
    infoSkin.Font = Enum.Font.Gotham
    infoSkin.TextSize = 11
    infoSkin.TextXAlignment = Enum.TextXAlignment.Left
    infoSkin.TextColor3 = MUTED
    infoSkin.TextWrapped = true
    infoSkin.Text = "Kill skin: 1x1x1x1 Ban Hammer, Abyssal Chroma, Abyssfire, Amber, Amethyst, BanHammerThrow, Xmas Tree, Vanquisher, Ornament Axe, Frozen Krampus Scythe, Electric Guitar, Eclipse Katana, Divine Blade."

    local pillSkin = Instance.new("TextButton", rowSkin)
    pillSkin.Size = UDim2.new(0,50,0,24)
    pillSkin.Position = UDim2.new(1,-80,0.25,-12)
    pillSkin.BackgroundColor3 = MUTED
    pillSkin.BackgroundTransparency = 0.1
    pillSkin.Text = ""
    pillSkin.AutoButtonColor = false
    Instance.new("UICorner", pillSkin).CornerRadius = UDim.new(0,999)

    local knobSkin = Instance.new("Frame", pillSkin)
    knobSkin.Size = UDim2.new(0,18,0,18)
    knobSkin.Position = UDim2.new(0,3,0.5,-9)
    knobSkin.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", knobSkin).CornerRadius = UDim.new(0,999)

    local enabled = _G.RAY_DisableRodSkin or false

    local function refreshSkin()
        pillSkin.BackgroundColor3 = enabled and ACCENT or MUTED
        knobSkin.Position = enabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    pillSkin.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.RAY_DisableRodSkin = enabled

        if enabled then
            KillAllRodSkins()
        end

        refreshSkin()
    end)

    lp.CharacterAdded:Connect(function()
        if enabled then
            task.delay(0.5, KillAllRodSkins)
        end
    end)

    refreshSkin()
end


    ----------------------------------------------------------------
    -- TOGGLE : 📝 DISABLE FISH TEXT
    ----------------------------------------------------------------
    local rowText = Instance.new("Frame", sub)
    rowText.Size = UDim2.new(1,0,0,36)
    rowText.BackgroundTransparency = 1

    local labelText = Instance.new("TextLabel", rowText)
    labelText.Size = UDim2.new(1,-100,1,0)
    labelText.Position = UDim2.new(0,16,0,0)
    labelText.BackgroundTransparency = 1
    labelText.Font = Enum.Font.Gotham
    labelText.TextSize = 13
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.TextColor3 = TEXT
    labelText.Text = "📝 Disable Fish Text"

    local pillText = Instance.new("TextButton", rowText)
    pillText.Size = UDim2.new(0,50,0,24)
    pillText.Position = UDim2.new(1,-80,0.5,-12)
    pillText.BackgroundColor3 = MUTED
    pillText.BackgroundTransparency = 0.1
    pillText.Text = ""
    pillText.AutoButtonColor = false
    Instance.new("UICorner", pillText).CornerRadius = UDim.new(0,999)

    local knobText = Instance.new("Frame", pillText)
    knobText.Size = UDim2.new(0,18,0,18)
    knobText.Position = UDim2.new(0,3,0.5,-9)
    knobText.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", knobText).CornerRadius = UDim.new(0,999)

    local textOff = false
    local textConn

    local function refreshText()
        pillText.BackgroundColor3 = textOff and ACCENT or MUTED
        knobText.Position = textOff
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    local function setFishTextVisible(v, state)
        for _, d in ipairs(v:GetDescendants()) do
            if d:IsA("TextLabel") then
                d.Visible = state
            end
        end
    end

    pillText.MouseButton1Click:Connect(function()
        textOff = not textOff
        local gui = Players.LocalPlayer:WaitForChild("PlayerGui")

        if textOff then
            for _,v in ipairs(gui:GetDescendants()) do
                if v.Name == "Small Notification" then
                    setFishTextVisible(v, false)
                end
            end

            textConn = gui.DescendantAdded:Connect(function(v)
                if v.Name == "Small Notification" then
                    setFishTextVisible(v, false)
                end
            end)
        else
            if textConn then
                textConn:Disconnect()
                textConn = nil
            end

            for _,v in ipairs(gui:GetDescendants()) do
                if v.Name == "Small Notification" then
                    setFishTextVisible(v, true)
                end
            end
        end

        refreshText()
    end)

    refreshText()

    ----------------------------------------------------------------
    -- TOGGLE : 🔕 DISABLE ALL NOTIFICATIONS
    ----------------------------------------------------------------
    local rowAll = Instance.new("Frame", sub)
    rowAll.Size = UDim2.new(1,0,0,36)
    rowAll.BackgroundTransparency = 1

    local labelAll = Instance.new("TextLabel", rowAll)
    labelAll.Size = UDim2.new(1,-100,1,0)
    labelAll.Position = UDim2.new(0,16,0,0)
    labelAll.BackgroundTransparency = 1
    labelAll.Font = Enum.Font.Gotham
    labelAll.TextSize = 13
    labelAll.TextXAlignment = Enum.TextXAlignment.Left
    labelAll.TextColor3 = TEXT
    labelAll.Text = "🔕 Disable All Notifications"

    local pillAll = Instance.new("TextButton", rowAll)
    pillAll.Size = UDim2.new(0,50,0,24)
    pillAll.Position = UDim2.new(1,-80,0.5,-12)
    pillAll.BackgroundColor3 = MUTED
    pillAll.BackgroundTransparency = 0.1
    pillAll.Text = ""
    pillAll.AutoButtonColor = false
    Instance.new("UICorner", pillAll).CornerRadius = UDim.new(0,999)

    local knobAll = Instance.new("Frame", pillAll)
    knobAll.Size = UDim2.new(0,18,0,18)
    knobAll.Position = UDim2.new(0,3,0.5,-9)
    knobAll.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", knobAll).CornerRadius = UDim.new(0,999)

    local allEnabled = false
    local allConn

    local function refreshAll()
        pillAll.BackgroundColor3 = allEnabled and ACCENT or MUTED
        knobAll.Position = allEnabled
            and UDim2.new(1,-21,0.5,-9)
            or  UDim2.new(0,3,0.5,-9)
    end

    local function killAllNotifs()
        pcall(function()
            local gui = Players.LocalPlayer:WaitForChild("PlayerGui")

            local function kill(v)
                if v:IsA("ScreenGui") then
                    local n = v.Name:lower()
                    if n:find("notif") or n:find("notification") then
                        v:Destroy()
                    end
                end
            end

            for _,v in ipairs(gui:GetChildren()) do
                kill(v)
            end

            allConn = gui.ChildAdded:Connect(kill)
        end)
    end

    local function stopKillAll()
        if allConn then
            allConn:Disconnect()
            allConn = nil
        end
    end

    pillAll.MouseButton1Click:Connect(function()
        allEnabled = not allEnabled

        if allEnabled then
            killAllNotifs()
        else
            stopKillAll()
        end

        refreshAll()
    end)

    refreshAll()
end  -- <<< penutup BuildMisc()

BuildMisc()

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
-- TELEPORT PAGE (RAPI: PLAYER + ISLAND)
----------------------------------------------------------------
local teleportPage = pages["Teleport"]

-- LAYOUT VERTICAL
local tpLayout = Instance.new("UIListLayout", teleportPage)
tpLayout.Padding = UDim.new(0,8)
tpLayout.FillDirection = Enum.FillDirection.Vertical
tpLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- TITLE
local tpTitleMain = Instance.new("TextLabel", teleportPage)
tpTitleMain.Size = UDim2.new(1,-32,0,32)
tpTitleMain.BackgroundTransparency = 1
tpTitleMain.Font = Enum.Font.GothamBold
tpTitleMain.TextSize = 18
tpTitleMain.TextColor3 = TEXT
tpTitleMain.TextXAlignment = Enum.TextXAlignment.Left
tpTitleMain.Text = "Teleport"
tpTitleMain.LayoutOrder = 1

----------------------------------------------------------------
-- 🎄 CHRISTMAS CAVE SCHEDULE (WITH SECONDS)
----------------------------------------------------------------
local function GetChristmasCaveStatus()
    -- Buka setiap 2 jam, 30 menit per sesi. [web:24][web:33]
    local t = os.date("*t")
    local h, m, s = t.hour, t.min, t.sec

    local openHours = {1,3,5,7,9,11,13,15,17,19,21,23}
    local isOpen = false

    for _, oh in ipairs(openHours) do
        if h == oh and m >= 0 and m < 30 then
            isOpen = true
            break
        end
    end

    -- hitung next open (dalam detik dari sekarang)
    local nowSeconds = h * 3600 + m * 60 + s
    local nextDiff = math.huge
    local nextHour

    for _, oh in ipairs(openHours) do
        local candidate = oh * 3600 -- jam:00:00
        if candidate <= nowSeconds then
            candidate = candidate + 24 * 3600 -- geser ke hari berikutnya
        end
        local diff = candidate - nowSeconds
        if diff < nextDiff then
            nextDiff = diff
            nextHour = oh
        end
    end

    local nextInSeconds = nextDiff
    return isOpen, nextHour, nextInSeconds
end

----------------------------------------------------------------
-- 🎄 CHRISTMAS CAVE SCHEDULE (WITH SECONDS + OFFSET)
----------------------------------------------------------------
local openHours = {1,3,5,7,9,11,13,15,17,19,21,23} -- tiap 2 jam. [web:24][web:33]

-- offset detik (positif = mundurin waktu script dibanding device)
local TIME_OFFSET = 60 -- 60 detik = 1 menit

local function GetChristmasCaveState()
    local t = os.date("*t")
    local h, m, s = t.hour or 0, t.min or 0, t.sec or 0

    -- terapkan offset
    local nowSec = h*3600 + m*60 + s - TIME_OFFSET
    if nowSec < 0 then
        nowSec = nowSec + 24*3600
    end

    -- hitung ulang h,m,s setelah offset
    h = math.floor(nowSec / 3600)
    m = math.floor((nowSec % 3600) / 60)
    s = nowSec % 60

    -- cek lagi buka/tutup (00–29 menit)
    local isOpen = false
    local currentOpenHour = nil
    for _, oh in ipairs(openHours) do
        if h == oh and m >= 0 and m < 30 then
            isOpen = true
            currentOpenHour = oh
            break
        end
    end

    -- next open
    local nextOpenDiff = 24*3600
    local nextOpenHour = openHours[1]
    for _, oh in ipairs(openHours) do
        local candidate = oh*3600
        if candidate <= nowSec then
            candidate = candidate + 24*3600
        end
        local diff = candidate - nowSec
        if diff < nextOpenDiff then
            nextOpenDiff = diff
            nextOpenHour = oh
        end
    end

    -- next close (kalau lagi OPEN, durasi 30 menit)
    local nextCloseDiff = nil
    if isOpen and currentOpenHour then
        local openStart = currentOpenHour*3600
        local closeTime = openStart + 30*60
        if closeTime <= nowSec then
            closeTime = closeTime + 24*3600
        end
        nextCloseDiff = closeTime - nowSec
    end

    return isOpen, nextOpenHour, nextOpenDiff, nextCloseDiff
end

----------------------------------------------------------------
-- 🏝️ TELEPORT TO ISLAND
----------------------------------------------------------------
local holderIsland = Instance.new("Frame", teleportPage)
holderIsland.Size = UDim2.new(1,0,0,34)
holderIsland.BackgroundTransparency = 1
holderIsland.LayoutOrder = 3

local rowIsland = Instance.new("TextButton", holderIsland)
rowIsland.Size = UDim2.new(1,-32,0,34)
rowIsland.Position = UDim2.new(0,16,0,0)
rowIsland.BackgroundColor3 = CARD
rowIsland.BackgroundTransparency = ALPHA_CARD
rowIsland.AutoButtonColor = false
rowIsland.Font = Enum.Font.Gotham
rowIsland.TextSize = 13
rowIsland.TextXAlignment = Enum.TextXAlignment.Left
rowIsland.TextColor3 = TEXT
rowIsland.Text = "  🏝️ Teleport to Island  >"
Instance.new("UICorner", rowIsland).CornerRadius = UDim.new(0,8)

local tpIslandFrame = Instance.new("Frame", holderIsland)
tpIslandFrame.Position = UDim2.new(0,0,0,34)
tpIslandFrame.Size = UDim2.new(1,0,0,0)
tpIslandFrame.BackgroundTransparency = 1
tpIslandFrame.Visible = false

local islandCard = Instance.new("Frame", tpIslandFrame)
islandCard.Size = UDim2.new(1,-32,0,190) -- tinggi dinaikkan buat 2 baris status
islandCard.Position = UDim2.new(0,16,0,0)
islandCard.BackgroundColor3 = CARD
islandCard.BackgroundTransparency = 0.12
Instance.new("UICorner", islandCard).CornerRadius = UDim.new(0,10)

local islandPad = Instance.new("UIPadding", islandCard)
islandPad.PaddingTop = UDim.new(0,10)
islandPad.PaddingLeft = UDim.new(0,14)
islandPad.PaddingRight = UDim.new(0,14)
islandPad.PaddingBottom = UDim.new(0,10)

local islandTitle = Instance.new("TextLabel", islandCard)
islandTitle.Size = UDim2.new(1,0,0,22)
islandTitle.BackgroundTransparency = 1
islandTitle.Font = Enum.Font.GothamBold
islandTitle.TextSize = 15
islandTitle.TextColor3 = TEXT
islandTitle.TextXAlignment = Enum.TextXAlignment.Left
islandTitle.Text = "🏝️ Teleport to Island"

-- STATUS TEXT CHRISTMAS CAVE (2 baris, kuning)
local statusLabel = Instance.new("TextLabel", islandCard)
statusLabel.Size = UDim2.new(1,0,0,32)
statusLabel.Position = UDim2.new(0,0,0,22)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextColor3 = Color3.fromRGB(255, 220, 0)
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.TextYAlignment = Enum.TextYAlignment.Top
statusLabel.TextWrapped = true
statusLabel.Text = "Checking Christmas Cave status..."

local selectIslandBtn = Instance.new("TextButton", islandCard)
selectIslandBtn.Size = UDim2.new(0.4,0,0,26)
selectIslandBtn.Position = UDim2.new(0,0,0,56)
selectIslandBtn.BackgroundColor3 = CARD
selectIslandBtn.BackgroundTransparency = 0.16
selectIslandBtn.AutoButtonColor = false
selectIslandBtn.Font = Enum.Font.Gotham
selectIslandBtn.TextSize = 12
selectIslandBtn.TextColor3 = MUTED
selectIslandBtn.TextXAlignment = Enum.TextXAlignment.Left
selectIslandBtn.Text = "  Select Island"
Instance.new("UICorner", selectIslandBtn).CornerRadius = UDim.new(0,8)

local tpIslandBtn = Instance.new("TextButton", islandCard)
tpIslandBtn.Size = UDim2.new(0.4,0,0,28)
tpIslandBtn.Position = UDim2.new(0,0,0,86)
tpIslandBtn.BackgroundColor3 = ACCENT
tpIslandBtn.BackgroundTransparency = 0.08
tpIslandBtn.AutoButtonColor = false
tpIslandBtn.Font = Enum.Font.Gotham
tpIslandBtn.TextSize = 12
tpIslandBtn.TextColor3 = TEXT
tpIslandBtn.Text = "🏝️ Teleport To Island"
Instance.new("UICorner", tpIslandBtn).CornerRadius = UDim.new(0,8)

local refreshIslandBtn = Instance.new("TextButton", islandCard)
refreshIslandBtn.Size = UDim2.new(0.4,0,0,24)
refreshIslandBtn.Position = UDim2.new(0,0,0,120)
refreshIslandBtn.BackgroundColor3 = CARD
refreshIslandBtn.BackgroundTransparency = 0.18
refreshIslandBtn.AutoButtonColor = false
refreshIslandBtn.Font = Enum.Font.Gotham
refreshIslandBtn.TextSize = 12
refreshIslandBtn.TextColor3 = TEXT
refreshIslandBtn.TextXAlignment = Enum.TextXAlignment.Center
refreshIslandBtn.Text = "Refresh Island"
Instance.new("UICorner", refreshIslandBtn).CornerRadius = UDim.new(0,8)

-- PANEL KANAN ISLAND
local islandDropFrame = Instance.new("Frame", islandCard)
islandDropFrame.Size = UDim2.new(0.55,0,0,140)
islandDropFrame.AnchorPoint = Vector2.new(1,0)
islandDropFrame.Position = UDim2.new(1,-8,0,56)
islandDropFrame.BackgroundColor3 = CARD
islandDropFrame.BackgroundTransparency = 0.06
islandDropFrame.Visible = false
islandDropFrame.ZIndex = 5
Instance.new("UICorner", islandDropFrame).CornerRadius = UDim.new(0,8)

local islandDropPad = Instance.new("UIPadding", islandDropFrame)
islandDropPad.PaddingTop = UDim.new(0,6)
islandDropPad.PaddingLeft = UDim.new(0,6)
islandDropPad.PaddingRight = UDim.new(0,6)
islandDropPad.PaddingBottom = UDim.new(0,6)

local islandListFrame = Instance.new("ScrollingFrame", islandDropFrame)
islandListFrame.Position = UDim2.new(0,0,0,24)
islandListFrame.Size = UDim2.new(1,0,1,-24)
islandListFrame.ScrollBarThickness = 3
islandListFrame.BackgroundTransparency = 1
islandListFrame.CanvasSize = UDim2.new(0,0,0,0)
islandListFrame.ClipsDescendants = true
islandListFrame.ZIndex = 6

local islandListLayout = Instance.new("UIListLayout", islandListFrame)
islandListLayout.Padding = UDim.new(0,2)
islandListLayout.SortOrder = Enum.SortOrder.LayoutOrder

islandListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    islandListFrame.CanvasSize = UDim2.new(0,0,0,islandListLayout.AbsoluteContentSize.Y + 4)
end)

local selectedIslandName

local function rebuildIslandDropdown()
    for _,c in ipairs(islandListFrame:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end

    -- pakai DEFAULT_SPOT_ORDER biar urut
    for _,name in ipairs(DEFAULT_SPOT_ORDER) do
        local cf = ISLAND_SPOTS[name]
        if cf then
            local b = Instance.new("TextButton", islandListFrame)
            b.Size = UDim2.new(1,0,0,20)
            b.BackgroundColor3 = CARD
            b.BackgroundTransparency = 0.2
            b.Font = Enum.Font.Gotham
            b.TextSize = 11
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.TextColor3 = TEXT
            b.Text = "  "..name
            b.AutoButtonColor = false
            b.ZIndex = 7
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)

            b.MouseButton1Click:Connect(function()
                selectedIslandName = name
                selectIslandBtn.Text = "  "..name
                selectIslandBtn.TextColor3 = TEXT
                tpIslandBtn.Text = "🏝️ Teleport To Island : "..name
                islandDropFrame.Visible = false
            end)
        end
    end

    if not selectedIslandName then
        selectIslandBtn.Text = "  Select Island"
        selectIslandBtn.TextColor3 = MUTED
        tpIslandBtn.Text = "🏝️ Teleport To Island"
    end
end

local islandOpen = false
local function recalcIsland()
    if islandOpen then
        tpIslandFrame.Visible = true
        tpIslandFrame.Size = UDim2.new(1,0,0,198)
        holderIsland.Size = UDim2.new(1,0,0,34 + 198)
        rowIsland.Text = "  🏝️ Teleport to Island  v"
    else
        tpIslandFrame.Visible = false
        tpIslandFrame.Size = UDim2.new(1,0,0,0)
        holderIsland.Size = UDim2.new(1,0,0,34)
        rowIsland.Text = "  🏝️ Teleport to Island  >"
        islandDropFrame.Visible = false
    end
end

rowIsland.MouseButton1Click:Connect(function()
    islandOpen = not islandOpen
    recalcIsland()
end)

local islandDropdownOpen = false
selectIslandBtn.MouseButton1Click:Connect(function()
    islandDropdownOpen = not islandDropdownOpen
    islandDropFrame.Visible = islandDropdownOpen
    if islandDropdownOpen then
        rebuildIslandDropdown()
    end
end)

tpIslandBtn.MouseButton1Click:Connect(function()
    if not selectedIslandName then return end

    local cf = ISLAND_SPOTS[selectedIslandName]
    if not cf then return end

    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    root.AssemblyLinearVelocity  = Vector3.new(0,0,0)
    root.AssemblyAngularVelocity = Vector3.new(0,0,0)
    root.CFrame = cf
end)

refreshIslandBtn.MouseButton1Click:Connect(function()
    selectedIslandName = nil
    rebuildIslandDropdown()
end)

rebuildIslandDropdown()

-- LOOP UPDATE STATUS CHRISTMAS CAVE (COUNTDOWN OPEN & CLOSE)
task.spawn(function()
    while true do
        local isOpen, nextOpenHour, toOpenSec, toCloseSec = GetChristmasCaveState()

        local hrsO  = math.floor(toOpenSec / 3600)
        local minsO = math.floor((toOpenSec % 3600) / 60)
        local secsO = toOpenSec % 60
        local line2 = string.format("Next OPEN in %02d:%02d:%02d", hrsO, minsO, secsO)

        local line1
        if isOpen and toCloseSec then
            local hrsC  = math.floor(toCloseSec / 3600)
            local minsC = math.floor((toCloseSec % 3600) / 60)
            local secsC = toCloseSec % 60
            line1 = string.format("Christmas Cave: OPEN | Close in %02d:%02d:%02d", hrsC, minsC, secsC)
        else
            line1 = "Christmas Cave: CLOSED"
        end

        statusLabel.Text = line1 .. "\n" .. line2
        task.wait(1)
    end
end)

----------------------------------------------------------------
-- 🧍‍♂️ TELEPORT TO PLAYER
----------------------------------------------------------------
local holderPlayer = Instance.new("Frame", teleportPage)
holderPlayer.Size = UDim2.new(1,0,0,34)
holderPlayer.BackgroundTransparency = 1
holderPlayer.LayoutOrder = 2

local rowPlayer = Instance.new("TextButton", holderPlayer)
rowPlayer.Size = UDim2.new(1,-32,0,34)
rowPlayer.Position = UDim2.new(0,16,0,0)
rowPlayer.BackgroundColor3 = CARD
rowPlayer.BackgroundTransparency = ALPHA_CARD
rowPlayer.AutoButtonColor = false
rowPlayer.Font = Enum.Font.Gotham
rowPlayer.TextSize = 13
rowPlayer.TextXAlignment = Enum.TextXAlignment.Left
rowPlayer.TextColor3 = TEXT
rowPlayer.Text = "  🧍‍♂️ Teleport to Player  >"
Instance.new("UICorner", rowPlayer).CornerRadius = UDim.new(0,8)

local tpPlayerFrame = Instance.new("Frame", holderPlayer)
tpPlayerFrame.Position = UDim2.new(0,0,0,34)
tpPlayerFrame.Size = UDim2.new(1,0,0,0)
tpPlayerFrame.BackgroundTransparency = 1
tpPlayerFrame.Visible = false

local playerCard = Instance.new("Frame", tpPlayerFrame)
playerCard.Size = UDim2.new(1,-32,0,160) -- cukup tinggi untuk panel
playerCard.Position = UDim2.new(0,16,0,0)
playerCard.BackgroundColor3 = CARD
playerCard.BackgroundTransparency = 0.12
Instance.new("UICorner", playerCard).CornerRadius = UDim.new(0,10)

local playerPad = Instance.new("UIPadding", playerCard)
playerPad.PaddingTop = UDim.new(0,10)
playerPad.PaddingLeft = UDim.new(0,14)
playerPad.PaddingRight = UDim.new(0,14)
playerPad.PaddingBottom = UDim.new(0,10)

local playerTitle = Instance.new("TextLabel", playerCard)
playerTitle.Size = UDim2.new(1,0,0,22)
playerTitle.BackgroundTransparency = 1
playerTitle.Font = Enum.Font.GothamBold
playerTitle.TextSize = 15
playerTitle.TextColor3 = TEXT
playerTitle.TextXAlignment = Enum.TextXAlignment.Left
playerTitle.Text = "🧍‍♂️ Teleport to Player"

local selectBtn = Instance.new("TextButton", playerCard)
selectBtn.Size = UDim2.new(0.4,0,0,26)
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

local tpBtn = Instance.new("TextButton", playerCard)
tpBtn.Size = UDim2.new(0.4,0,0,28)
tpBtn.Position = UDim2.new(0,0,0,56)
tpBtn.BackgroundColor3 = ACCENT
tpBtn.BackgroundTransparency = 0.08
tpBtn.AutoButtonColor = false
tpBtn.Font = Enum.Font.Gotham
tpBtn.TextSize = 12
tpBtn.TextColor3 = TEXT
tpBtn.Text = "🧍‍♂️ Teleport to Player"
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,8)

local refreshBtn = Instance.new("TextButton", playerCard)
refreshBtn.Size = UDim2.new(0.4,0,0,24)
refreshBtn.Position = UDim2.new(0,0,0,90)
refreshBtn.BackgroundColor3 = CARD
refreshBtn.BackgroundTransparency = 0.18
refreshBtn.AutoButtonColor = false
refreshBtn.Font = Enum.Font.Gotham
refreshBtn.TextSize = 12
refreshBtn.TextColor3 = TEXT
refreshBtn.TextXAlignment = Enum.TextXAlignment.Center
refreshBtn.Text = "Refresh Player"
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0,8)

-- PANEL KANAN PLAYER (DALAM CARD, PANJANG)
local dropFrame = Instance.new("Frame", playerCard)
dropFrame.Size = UDim2.new(0.55,0,0,140)
dropFrame.AnchorPoint = Vector2.new(1,0)
dropFrame.Position = UDim2.new(1,-8,0,26)
dropFrame.BackgroundColor3 = CARD
dropFrame.BackgroundTransparency = 0.06
dropFrame.Visible = false
dropFrame.ZIndex = 5
Instance.new("UICorner", dropFrame).CornerRadius = UDim.new(0,8)

local dropPad = Instance.new("UIPadding", dropFrame)
dropPad.PaddingTop = UDim.new(0,6)
dropPad.PaddingLeft = UDim.new(0,6)
dropPad.PaddingRight = UDim.new(0,6)
dropPad.PaddingBottom = UDim.new(0,6)

local searchBox = Instance.new("TextBox", dropFrame)
searchBox.Size = UDim2.new(1,0,0,20)
searchBox.PlaceholderText = "Search Player"
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 12
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.TextColor3 = TEXT
searchBox.ClearTextOnFocus = false
searchBox.BackgroundColor3 = Color3.fromRGB(18,20,28)
searchBox.BackgroundTransparency = 0.1
searchBox.Text = ""
searchBox.ZIndex = 6
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,6)

local listFrame = Instance.new("ScrollingFrame", dropFrame)
listFrame.Position = UDim2.new(0,0,0,24)
listFrame.Size = UDim2.new(1,0,1,-24)
listFrame.ScrollBarThickness = 3
listFrame.BackgroundTransparency = 1
listFrame.CanvasSize = UDim2.new(0,0,0,0)
listFrame.ClipsDescendants = true
listFrame.ZIndex = 6

local listLayout = Instance.new("UIListLayout", listFrame)
listLayout.Padding = UDim.new(0,2)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    listFrame.CanvasSize = UDim2.new(0,0,0,listLayout.AbsoluteContentSize.Y + 4)
end)

local selectedPlayerName

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
            b.Size = UDim2.new(1,0,0,20)
            b.BackgroundColor3 = CARD
            b.BackgroundTransparency = 0.2
            b.Font = Enum.Font.Gotham
            b.TextSize = 11
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.TextColor3 = TEXT
            b.Text = "  "..plr.Name
            b.AutoButtonColor = false
            b.ZIndex = 7
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)

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

local playerOpen = false
local function recalcPlayer()
    if playerOpen then
        tpPlayerFrame.Visible = true
        tpPlayerFrame.Size = UDim2.new(1,0,0,168)
        holderPlayer.Size = UDim2.new(1,0,0,34 + 168)
        rowPlayer.Text = "  🧍‍♂️ Teleport to Player  v"
    else
        tpPlayerFrame.Visible = false
        tpPlayerFrame.Size = UDim2.new(1,0,0,0)
        holderPlayer.Size = UDim2.new(1,0,0,34)
        rowPlayer.Text = "  🧍‍♂️ Teleport to Player  >"
        dropFrame.Visible = false
    end
end

rowPlayer.MouseButton1Click:Connect(function()
    playerOpen = not playerOpen
    recalcPlayer()
end)

local dropdownOpen = false
selectBtn.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    dropFrame.Visible = dropdownOpen
    if dropdownOpen then
        searchBox.Text = ""
        rebuildDropdown()
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    if not selectedPlayerName then return end

    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then return end
    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local char = lp.Character or lp.CharacterAdded:Wait()
    local myHrp = char:WaitForChild("HumanoidRootPart")

    myHrp.AssemblyLinearVelocity  = Vector3.new(0,0,0)
    myHrp.AssemblyAngularVelocity = Vector3.new(0,0,0)
    myHrp.CFrame   = hrp.CFrame + Vector3.new(0,0,3)
end)

refreshBtn.MouseButton1Click:Connect(function()
    selectedPlayerName = nil
    searchBox.Text = ""
    rebuildDropdown()
end)

rebuildDropdown()



----------------------------------------------------------------
-- AUTO CLOSE PANEL KANAN (PLAYER + ISLAND)
----------------------------------------------------------------
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
    and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local mousePos = UIS:GetMouseLocation()

    local function insideFrame(frame)
        if not frame or not frame.Visible then return false end
        local pos = frame.AbsolutePosition
        local size = frame.AbsoluteSize
        return mousePos.X >= pos.X and mousePos.X <= pos.X + size.X
           and mousePos.Y >= pos.Y and mousePos.Y <= pos.Y + size.Y
    end

    -- panel dropdown player
    if dropFrame and dropFrame.Visible and not insideFrame(dropFrame) then
        dropFrame.Visible = false
        dropdownOpen = false
    end

    -- panel dropdown island
    if islandDropFrame and islandDropFrame.Visible and not insideFrame(islandDropFrame) then
        islandDropFrame.Visible = false
        islandDropdownOpen = false
    end
end)

----------------------------------------------------------------
-- REMOTES
----------------------------------------------------------------
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

    -- WEATHER
    purchaseWeather = Net:WaitForChild("RF/PurchaseWeatherEvent"),
}

----------------------------------------------------------------
-- MEGALODON HUNT TELEPORT (ANCHOR PART)
----------------------------------------------------------------
function TeleportToMegalodon()
    -- cari part anchor bernama "Megalodon Hunt" di seluruh workspace
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

    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    -- nolkan gerakan biar nggak kelempar
    root.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
    root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

    -- posisi sedikit di atas anchor
    local basePos = anchor.Position + Vector3.new(0, 5, 0)
    local lookDir = anchor.CFrame.LookVector

    -- teleport character menghadap arah anchor
    local cf = CFrame.new(basePos, basePos + lookDir)
    char:PivotTo(cf)
end

----------------------------------------------------------------
-- ENGINE STATE
----------------------------------------------------------------
local AutoFishAFK = false
local isFishing   = false

-- delay Auto Fishing (feel V2)
local DelayReel   = 3    -- sama kayak _G.RAY_DelayCast
local DelayCatch  = 2    -- sama kayak _G.RAY_DelayFinish

-- Blatant state
local BlatantOn    = false
local BlatantReel  = 0.8     -- Reel Delay (default lama, kalau mau dipakai)
local BlatantCatch = 0.75    -- default awal (nggak wajib dipakai, bisa dioverride)

_G.RAY_ExtraCatchBlatant = _G.RAY_ExtraCatchBlatant or false

----------------------------------------------------------------
-- FUNGSI DASAR
----------------------------------------------------------------
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

----------------------------------------------------------------
-- ENGINE 0: AUTO FISH FEEL V2
-- (1 cast -> tunggu -> 1 reel -> tunggu)
----------------------------------------------------------------
local function Engine_V3_Delayed()
    if isFishing or not AutoFishAFK then return end
    isFishing = true

    Cast_V3()
    task.wait(DelayReel)
    Reel_V3()
    task.wait(DelayCatch)

    isFishing = false
end

----------------------------------------------------------------
-- ENGINE 1: BLATANT (V2 CEPAT)
-- CONFIG (UI) – OVERRIDE NILAI
----------------------------------------------------------------
BlatantReel  = 1.17   -- kalau mau dipakai buat tuning lain
BlatantCatch = 0.25   -- delay catch utama / extra catch

local CastCount        = 3
local DelayBetweenCast = 0.03

local function BlatantCycle_V2()
    if isFishing or not BlatantOn then return end
    isFishing = true

    -- 3x CAST CEPAT
    pcall(function()
        Events.equip:FireServer(1)
        task.wait(0.01)
        for _ = 1, CastCount do
            task.spawn(function()
                Events.charge:InvokeServer(workspace:GetServerTimeNow())
                task.wait(0.01)
                Events.minigame:InvokeServer(1.2854545116425, 1)
            end)
            task.wait(DelayBetweenCast)
        end
    end)

    -- DELAY REEL (SEDIKIT LEBIH CEPAT)
    local RealReelDelay  = 0.52     -- dari 0.55 → 0.52
    local RealInnerDelay = 0.0009   -- sedikit lebih longgar dari 0.0007

    task.wait(RealReelDelay)

    for _ = 1, 5 do
        Reel_V3()
        task.wait(RealInnerDelay)
    end

    task.wait(BlatantCatch)
    isFishing = false
end

---------------------------------------------------------------
-- EXTRA CATCH BLATANT
----------------------------------------------------------------
task.spawn(function()
    while true do
        if BlatantOn and _G.RAY_ExtraCatchBlatant and not isFishing then
            Reel_V3()
            task.wait(BlatantCatch)   -- pake delay yang sama biar feel-nya konsisten
        end
        task.wait(0.05)
    end
end)

-- ====================== AUTO OPTION CONTENT ======================

-- SCROLL CONTAINER AUTO OPTION
local scroll = Instance.new("ScrollingFrame", autoPage)
local scrollPad = Instance.new("UIPadding", scroll)
scrollPad.PaddingBottom = UDim.new(0,24)
scroll.Position = UDim2.new(0,16,0,16)
scroll.Size = UDim2.new(1,-32,1,-32)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.ScrollingEnabled = true
scroll.ClipsDescendants = true

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,10)
layout.SortOrder = Enum.SortOrder.LayoutOrder

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    -- ekstra margin bawah biar mentok scroll-nya halus
    scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 60)
end)

-- PANEL ISLAND (KANAN, AMAN HP)
local islandPanel = Instance.new("Frame", autoPage)
islandPanel.Size = UDim2.new(0,220,0,260)
islandPanel.AnchorPoint = Vector2.new(1,0)
islandPanel.Position = UDim2.new(1, -24, 0.18, 0)  -- kanan, agak di tengah atas
islandPanel.BackgroundColor3 = CARD
islandPanel.BackgroundTransparency = 0.04
islandPanel.Visible = false
islandPanel.ZIndex = 5
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
searchBoxIsland.ZIndex = 6
Instance.new("UICorner", searchBoxIsland).CornerRadius = UDim.new(0,8)

local islandList = Instance.new("ScrollingFrame", islandPanel)
islandList.Position = UDim2.new(0,0,0,36)
islandList.Size = UDim2.new(1,0,1,-36)
islandList.ScrollBarThickness = 4
islandList.ScrollingDirection = Enum.ScrollingDirection.Y
islandList.CanvasSize = UDim2.new(0,0,0,0)
islandList.BackgroundTransparency = 1
islandList.ClipsDescendants = true
islandList.ZIndex = 6

local islandListLayout = Instance.new("UIListLayout", islandList)
islandListLayout.Padding = UDim.new(0,4)
islandListLayout.SortOrder = Enum.SortOrder.LayoutOrder

islandListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    islandList.CanvasSize = UDim2.new(0,0,0,islandListLayout.AbsoluteContentSize.Y + 8)
end)

local islandButtons = {}

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
            b.ZIndex = 6
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
    elseif text == "Comingsoon" then
        icon.Text = "🌴"
    elseif text == "Auto Favorite" then
        icon.Text = "⭐"
    elseif text == "Auto Sell" then
        icon.Text = "💰"
    elseif text == "Auto Megalodon" then
        icon.Text = "🦈"
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

elseif text == "Auto Spot Island" then
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

----------------------------------------------------------------
-- AUTO MEGALODON (MENU)
----------------------------------------------------------------
elseif text == "Auto Megalodon" then
    list.Padding = UDim.new(0,4)

    -- Info
    local info = Instance.new("TextLabel", sub)
    info.Size = UDim2.new(1,0,0,28)
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.Gotham
    info.TextSize = 13
    info.TextColor3 = MUTED
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.Text = "🦈 Klik tombol di bawah untuk teleport ke spot Megalodon."

    -- Row tombol (stylenya sama kayak toggle lain, tapi di sini single click)
    local row = Instance.new("Frame", sub)
    row.Size = UDim2.new(1,0,0,32)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(1,-120,1,0)
    label.Position = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = TEXT
    label.Text = "Teleport Megalodon (once)"

    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(0,90,0,24)
    btn.Position = UDim2.new(1,-110,0.5,-12)
    btn.BackgroundColor3 = ACCENT
    btn.BackgroundTransparency = 0.08
    btn.Text = "TELEPORT"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextColor3 = TEXT
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,999)

    btn.MouseButton1Click:Connect(function()
        TeleportToMegalodon()  -- TELEPORT SEKALI, TIDAK AUTO FARM
    end)

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

task.spawn(function()
    task.wait(5)
    while true do
        if AutoWeatherOn then
            warn("[WEATHER] Auto ON, selected:", selectedWeather) -- debug
            for name, on in pairs(selectedWeather) do
                if on then
                    warn("[WEATHER] Buying:", name)
                    pcall(function()
                        local ok, res = pcall(function()
                            return Events.purchaseWeather:InvokeServer(name)
                        end)
                        warn("[WEATHER] Result:", name, ok, res)
                    end)
                    task.wait(1.5)
                end
            end
        end
        task.wait(5)
    end
end)
