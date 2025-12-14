--// THREEBLOX HUB - FISH IT
--// FULL GUI (DRAG + MINIMIZE + ICON TAB)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--========== ROOT GUI ==========--
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = pg

--========== MAIN WINDOW ==========--
local main = Instance.new("Frame")
main.Name = "MainWindow"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 620, 0, 360)
main.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(0, 0, 0)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.4

--========== HEADER (DRAG HANDLE) ==========--
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(255, 191, 0)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.Text = "Threeblox Hub"
title.Position = UDim2.new(0, 16, 0, 4)
title.Size = UDim2.new(0.5, 0, 0.5, 0)
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 13
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.TextColor3 = Color3.fromRGB(40, 40, 40)
subtitle.Text = "Fish It"
subtitle.Position = UDim2.new(0, 16, 0, 20)
subtitle.Size = UDim2.new(0.5, 0, 0.5, 0)
subtitle.Parent = header

local rightText = Instance.new("TextLabel")
rightText.BackgroundTransparency = 1
rightText.Font = Enum.Font.Gotham
rightText.TextSize = 13
rightText.TextXAlignment = Enum.TextXAlignment.Right
rightText.TextColor3 = Color3.fromRGB(40, 40, 40)
rightText.Text = "Premium | discord.gg/yourcode"
rightText.AnchorPoint = Vector2.new(1, 0)
rightText.Position = UDim2.new(1, -40, 0, 12)
rightText.Size = UDim2.new(0.4, 0, 1, 0)
rightText.Parent = header

-- Minimize button [-]
local miniBtn = Instance.new("TextButton")
miniBtn.Name = "Minimize"
miniBtn.AnchorPoint = Vector2.new(1, 0.5)
miniBtn.Position = UDim2.new(1, -8, 0.5, 0)
miniBtn.Size = UDim2.new(0, 24, 0, 24)
miniBtn.BackgroundTransparency = 1
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 18
miniBtn.Text = "-"
miniBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
miniBtn.Parent = header

--========== MINIMIZED ICON ==========--
local miniIcon = Instance.new("TextButton")
miniIcon.Name = "MiniIcon"
miniIcon.Visible = false
miniIcon.Size = UDim2.new(0, 120, 0, 30)
miniIcon.Position = UDim2.new(0, 10, 1, -40)
miniIcon.AnchorPoint = Vector2.new(0, 1)
miniIcon.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
miniIcon.BorderSizePixel = 0
miniIcon.Text = "Threeblox Hub"
miniIcon.Font = Enum.Font.Gotham
miniIcon.TextSize = 14
miniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
miniIcon.Parent = gui

local miniCorner = Instance.new("UICorner", miniIcon)
miniCorner.CornerRadius = UDim.new(0, 6)

miniBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    miniIcon.Visible = true
end)

miniIcon.MouseButton1Click:Connect(function()
    main.Visible = true
    miniIcon.Visible = false
end)

--========== DRAG LOGIC ==========--
local dragging = false
local dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

--========== SIDEBAR ==========--
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.Size = UDim2.new(0, 150, 1, -40)
sidebar.BackgroundColor3 = Color3.fromRGB(10, 15, 22)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0, 4)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local paddingSide = Instance.new("UIPadding", sidebar)
paddingSide.PaddingTop = UDim.new(0, 8)
paddingSide.PaddingLeft = UDim.new(0, 8)
paddingSide.PaddingRight = UDim.new(0, 8)

--========== CONTENT AREA ==========--
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 150, 0, 40)
content.Size = UDim2.new(1, -150, 1, -40)
content.BackgroundColor3 = Color3.fromRGB(12, 18, 28)
content.BorderSizePixel = 0
content.Parent = main

local paddingContent = Instance.new("UIPadding", content)
paddingContent.PaddingTop = UDim.new(0, 8)
paddingContent.PaddingLeft = UDim.new(0, 12)
paddingContent.PaddingRight = UDim.new(0, 12)
paddingContent.PaddingBottom = UDim.new(0, 8)

--========== TAB BUTTON CREATOR (DENGAN ICON) ==========--
local function createTabButton(text, imageId)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(18, 26, 38)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Text = "   " .. text  -- spasi buat icon kiri

    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 6)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Thickness = 1
    stroke.Transparency = 0.6

    local icon = Instance.new("ImageLabel")
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, 18, 0, 18)
    icon.Position = UDim2.new(0, 8, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0, 0.5)
    -- GANTI ID ICON DI SINI
    if imageId then
        icon.Image = "rbxassetid://" .. tostring(imageId)
    end
    icon.Parent = btn

    btn.Parent = sidebar
    return btn
end

--========== PAGES & TABS ==========--
local tabInfo = {
    Main     = 0,  -- isi ID icon lu
    Auto     = 0,
    Teleport = 0,
    Misc     = 0,
    Info     = 0,
}

local pages = {}
local buttons = {}

for name, imgId in pairs(tabInfo) do
    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content
    pages[name] = page

    local btn = createTabButton(name, imgId)
    buttons[name] = btn
end

local function setActiveTab(name)
    for n, pg in pairs(pages) do
        pg.Visible = (n == name)
    end
    for n, btn in pairs(buttons) do
        btn.BackgroundColor3 = (n == name)
            and Color3.fromRGB(35, 49, 70)
            or  Color3.fromRGB(18, 26, 38)
    end
end

for name, btn in pairs(buttons) do
    btn.MouseButton1Click:Connect(function()
        setActiveTab(name)
    end)
end

--========== INFO PAGE (Information / Update) ==========--
local infoPage = pages["Info"]

local infoTitle = Instance.new("TextLabel")
infoTitle.BackgroundTransparency = 1
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 18
infoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
infoTitle.TextXAlignment = Enum.TextXAlignment.Left
infoTitle.Text = "Information"
infoTitle.Position = UDim2.new(0, 4, 0, 2)
infoTitle.Size = UDim2.new(1, -8, 0, 24)
infoTitle.Parent = infoPage

local updateTitle = Instance.new("TextLabel")
updateTitle.BackgroundTransparency = 1
updateTitle.Font = Enum.Font.GothamBold
updateTitle.TextSize = 16
updateTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
updateTitle.TextXAlignment = Enum.TextXAlignment.Left
updateTitle.Text = "Update : v1.0"
updateTitle.Position = UDim2.new(0, 4, 0, 30)
updateTitle.Size = UDim2.new(1, -8, 0, 22)
updateTitle.Parent = infoPage

local function createInfoLine(text, order)
    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(210, 210, 210)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = text
    lbl.Position = UDim2.new(0, 10, 0, 30 + 24 + (order * 20))
    lbl.Size = UDim2.new(1, -20, 0, 20)
    lbl.Parent = infoPage
end

createInfoLine("- Added Auto Fish (edit sendiri)", 0)
createInfoLine("- Added Teleport Menu", 1)
createInfoLine("- Added Custom Settings", 2)

--========== MAIN PAGE ==========--
local mainPage = pages["Main"]

local mainLabel = Instance.new("TextLabel")
mainLabel.BackgroundTransparency = 1
mainLabel.Font = Enum.Font.GothamBold
mainLabel.TextSize = 18
mainLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
mainLabel.TextXAlignment = Enum.TextXAlignment.Left
mainLabel.Text = "Main"
mainLabel.Position = UDim2.new(0, 4, 0, 2)
mainLabel.Size = UDim2.new(1, -8, 0, 24)
mainLabel.Parent = mainPage

--========== AUTO PAGE (DUMMY TOGGLE) ==========--
local autoPage = pages["Auto"]

local autoTitle = Instance.new("TextLabel")
autoTitle.BackgroundTransparency = 1
autoTitle.Font = Enum.Font.GothamBold
autoTitle.TextSize = 18
autoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoTitle.TextXAlignment = Enum.TextXAlignment.Left
autoTitle.Text = "Auto"
autoTitle.Position = UDim2.new(0, 4, 0, 2)
autoTitle.Size = UDim2.new(1, -8, 0, 24)
autoTitle.Parent = autoPage

local autoBtn = Instance.new("TextButton")
autoBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
autoBtn.BorderSizePixel = 0
autoBtn.Font = Enum.Font.Gotham
autoBtn.TextSize = 14
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.Text = "Auto Fish [OFF]"
autoBtn.Position = UDim2.new(0, 4, 0, 34)
autoBtn.Size = UDim2.new(0, 160, 0, 28)
autoBtn.Parent = autoPage

local autoBtnCorner = Instance.new("UICorner", autoBtn)
autoBtnCorner.CornerRadius = UDim.new(0, 6)

local autoState = false
autoBtn.MouseButton1Click:Connect(function()
    autoState = not autoState
    autoBtn.Text = "Auto Fish [" .. (autoState and "ON" or "OFF") .. "]"
    -- TARUH LOGIC AUTO FISH DI SINI
end)

--========== TELEPORT PAGE ==========--
local tpPage = pages["Teleport"]

local tpTitle = Instance.new("TextLabel")
tpTitle.BackgroundTransparency = 1
tpTitle.Font = Enum.Font.GothamBold
tpTitle.TextSize = 18
tpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
tpTitle.TextXAlignment = Enum.TextXAlignment.Left
tpTitle.Text = "Teleport"
tpTitle.Position = UDim2.new(0, 4, 0, 2)
tpTitle.Size = UDim2.new(1, -8, 0, 24)
tpTitle.Parent = tpPage

--========== MISC PAGE ==========--
local miscPage = pages["Misc"]

local miscTitle = Instance.new("TextLabel")
miscTitle.BackgroundTransparency = 1
miscTitle.Font = Enum.Font.GothamBold
miscTitle.TextSize = 18
miscTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
miscTitle.TextXAlignment = Enum.TextXAlignment.Left
miscTitle.Text = "Misc"
miscTitle.Position = UDim2.new(0, 4, 0, 2)
miscTitle.Size = UDim2.new(1, -8, 0, 24)
miscTitle.Parent = miscPage

--========== DEFAULT TAB ==========--
setActiveTab("Main")
