--// THREEBLOX HUB - FISH IT
--// UPDATE 2 FULL GUI (READY USE | ANDROID + PC)

--================ SERVICES ================--
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ CLEAN OLD GUI ================--
pcall(function()
    for _,v in ipairs(pg:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:find("Threeblox") then
            v:Destroy()
        end
    end
end)

--================ ROOT GUI ================--
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxHubV2"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

--================ COLORS ================--
local BG      = Color3.fromRGB(20,22,32)
local SIDE    = Color3.fromRGB(16,18,26)
local CARD    = Color3.fromRGB(30,32,44)
local ACCENT  = Color3.fromRGB(160,90,255)
local TEXT    = Color3.fromRGB(235,235,235)

--================ MAIN WINDOW ================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 760, 0, 420)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--================ HEADER ================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,46)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-140,1,0)
title.Position = UDim2.new(0,16,0,0)
title.BackgroundTransparency = 1
title.Text = "Threeblox V3 – Fish It"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = TEXT
title.TextXAlignment = Left

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-36,0.5,-15)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- MINIMIZE
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-72,0.5,-15)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.TextColor3 = Color3.new(0,0,0)
minBtn.BackgroundColor3 = Color3.fromRGB(255,191,0)
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

--================ SIDEBAR LEFT ================--
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,46)
sidebar.Size = UDim2.new(0,170,1,-46)
sidebar.BackgroundColor3 = SIDE
sidebar.BorderSizePixel = 0

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,6)
Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,10)

--================ CONTENT RIGHT ================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,170,0,46)
content.Size = UDim2.new(1,-170,1,-46)
content.BackgroundTransparency = 1
Instance.new("UIPadding", content).PaddingTop = UDim.new(0,14)
Instance.new("UIPadding", content).PaddingLeft = UDim.new(0,14)

--================ PAGE SYSTEM ================--
local pages = {}

local function createPage(name)
    local p = Instance.new("Frame", content)
    p.Size = UDim2.new(1,0,1,0)
    p.Visible = false
    p.BackgroundTransparency = 1
    pages[name] = p
    return p
end

--================ AUTO OPTION PAGE ================--
local autoPage = createPage("Auto Option")

local ICONS = {
    AutoFishing = "rbxassetid://6034509993",
    Legit       = "rbxassetid://6031068433",
    Blatant     = "rbxassetid://6034287525",
    Farm        = "rbxassetid://6034328955",
    Favorite    = "rbxassetid://6031265976",
    Sell        = "rbxassetid://6034509983",
    Totem       = "rbxassetid://6035047377",
    Potion      = "rbxassetid://6034328940",
}

local function createAutoItem(text, iconId, y)
    local item = Instance.new("TextButton", autoPage)
    item.Size = UDim2.new(1,-40,0,44)
    item.Position = UDim2.new(0,20,0,y)
    item.BackgroundColor3 = CARD
    item.BorderSizePixel = 0
    item.Text = ""
    item.AutoButtonColor = false
    Instance.new("UICorner", item).CornerRadius = UDim.new(0,10)

    local icon = Instance.new("ImageLabel", item)
    icon.Size = UDim2.new(0,22,0,22)
    icon.Position = UDim2.new(0,14,0.5,-11)
    icon.BackgroundTransparency = 1
    icon.Image = iconId
    icon.ImageColor3 = TEXT

    local label = Instance.new("TextLabel", item)
    label.Size = UDim2.new(1,-90,1,0)
    label.Position = UDim2.new(0,44,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 15
    label.TextXAlignment = Left
    label.TextColor3 = TEXT

    local arrow = Instance.new("TextLabel", item)
    arrow.Size = UDim2.new(0,40,1,0)
    arrow.Position = UDim2.new(1,-40,0,0)
    arrow.BackgroundTransparency = 1
    arrow.Text = ">"
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 20
    arrow.TextColor3 = TEXT

    local on = false
    item.MouseButton1Click:Connect(function()
        on = not on
        item.BackgroundColor3 = on and ACCENT or CARD
        label.TextColor3 = on and Color3.new(0,0,0) or TEXT
        icon.ImageColor3 = on and Color3.new(0,0,0) or TEXT
    end)
end

createAutoItem("Auto Fishing", ICONS.AutoFishing, 10)
createAutoItem("Legit Perfect", ICONS.Legit, 60)
createAutoItem("Blatant Fishing", ICONS.Blatant, 110)
createAutoItem("Auto Farm Island", ICONS.Farm, 160)
createAutoItem("Auto Favorite", ICONS.Favorite, 210)
createAutoItem("Auto Sell", ICONS.Sell, 260)
createAutoItem("Auto Totem", ICONS.Totem, 310)
createAutoItem("Auto Potion", ICONS.Potion, 360)

--================ SIDEBAR BUTTON ================--
local function sideButton(name)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.new(1,-20,0,36)
    b.Text = "  "..name
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = TEXT
    b.BackgroundColor3 = CARD
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

    b.MouseButton1Click:Connect(function()
        for n,p in pairs(pages) do p.Visible = (n == name) end
        title.Text = name
    end)
end

sideButton("Auto Option")

pages["Auto Option"].Visible = true

--================ DRAG MAIN ================--
do
    local dragging, start, startPos
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            start = i.Position
            startPos = main.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging then
            local delta = i.Position - start
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

--================ MINI LOGO (MINIMIZE) ================--
local mini = Instance.new("ImageButton", gui)
mini.Size = UDim2.new(0,54,0,54)
mini.Position = UDim2.new(0,20,1,-80)
mini.Image = "rbxassetid://135718830702780" -- LOGO LU
mini.BackgroundColor3 = CARD
mini.Visible = false
mini.BorderSizePixel = 0
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

-- DRAG LOGO
do
    local d, s, sp
    mini.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            d = true
            s = i.Position
            sp = mini.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then d = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if d then
            local delta = i.Position - s
            mini.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X,
                                      sp.Y.Scale, sp.Y.Offset + delta.Y)
        end
    end)
end

minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
    main.Visible = true
    mini.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
