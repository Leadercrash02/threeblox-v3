--// THREEBLOX HUB - FISH IT
--// FIX FINAL FULL GUI (CONTENT LEFT, TAB RIGHT, NO DOUBLE TITLE)

--================ SERVICES ================--
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ CLEAN OLD ================--
pcall(function()
    if pg:FindFirstChild("ThreebloxHub") then
        pg.ThreebloxHub:Destroy()
    end
end)

--================ ROOT ================--
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxHub"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

--================ MAIN PANEL ================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 720, 0, 400)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20, 24, 34)
main.BorderSizePixel = 0

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)
local stroke = Instance.new("UIStroke", main)
stroke.Transparency = 0.6

--================ HEADER (DRAG) ================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, -150, 0, 44)
header.Position = UDim2.new(0, 20, 0, 14)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "Information"

--================ HEADER BUTTONS ================--
local btnMin = Instance.new("TextButton", header)
btnMin.Size = UDim2.new(0, 30, 0, 30)
btnMin.Position = UDim2.new(1, -70, 0.5, -15)
btnMin.Text = "-"
btnMin.Font = Enum.Font.GothamBold
btnMin.TextSize = 20
btnMin.BackgroundColor3 = Color3.fromRGB(255,191,0)
btnMin.TextColor3 = Color3.fromRGB(0,0,0)
btnMin.BorderSizePixel = 0
Instance.new("UICorner", btnMin).CornerRadius = UDim.new(1,0)

local btnClose = Instance.new("TextButton", header)
btnClose.Size = UDim2.new(0, 30, 0, 30)
btnClose.Position = UDim2.new(1, -30, 0.5, -15)
btnClose.Text = "X"
btnClose.Font = Enum.Font.GothamBold
btnClose.TextSize = 14
btnClose.BackgroundColor3 = Color3.fromRGB(200,60,60)
btnClose.TextColor3 = Color3.fromRGB(255,255,255)
btnClose.BorderSizePixel = 0
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(1,0)

--================ MINIMIZED ICON ================--
local mini = Instance.new("TextButton", gui)
mini.Visible = false
mini.Size = UDim2.new(0, 160, 0, 36)
mini.Position = UDim2.new(0, 20, 1, -50)
mini.AnchorPoint = Vector2.new(0,1)
mini.BackgroundColor3 = Color3.fromRGB(20,24,34)
mini.Text = "Threeblox Hub"
mini.Font = Enum.Font.Gotham
mini.TextSize = 14
mini.TextColor3 = Color3.fromRGB(255,255,255)
mini.BorderSizePixel = 0
Instance.new("UICorner", mini).CornerRadius = UDim.new(0,14)

btnMin.MouseButton1Click:Connect(function()
    main.Visible = false
    mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
    main.Visible = true
    mini.Visible = false
end)

btnClose.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

--================ CONTENT AREA (LEFT) ================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 20, 0, 70)
content.Size = UDim2.new(1, -170, 1, -90)
content.BackgroundTransparency = 1

local contentPad = Instance.new("UIPadding", content)
contentPad.PaddingLeft = UDim.new(0, 10)
contentPad.PaddingTop  = UDim.new(0, 6)

--================ PAGE SYSTEM ================--
local pages = {}

local function createPage(name)
    local page = Instance.new("Frame", content)
    page.Size = UDim2.new(1,0,1,0)
    page.Visible = false
    page.BackgroundTransparency = 1
    pages[name] = page
    return page
end

--================ INFORMATION PAGE ================--
local infoPage = createPage("Information")

local infoCard = Instance.new("Frame", infoPage)
infoCard.Size = UDim2.new(1, -10, 0, 260)
infoCard.Position = UDim2.new(0, 0, 0, 10)
infoCard.BackgroundColor3 = Color3.fromRGB(30, 36, 52)
infoCard.BorderSizePixel = 0
Instance.new("UICorner", infoCard).CornerRadius = UDim.new(0,16)
Instance.new("UIStroke", infoCard).Transparency = 0.6

local cardTitle = Instance.new("TextLabel", infoCard)
cardTitle.Position = UDim2.new(0, 18, 0, 14)
cardTitle.Size = UDim2.new(1, -36, 0, 28)
cardTitle.BackgroundTransparency = 1
cardTitle.Font = Enum.Font.GothamBold
cardTitle.TextSize = 20
cardTitle.TextXAlignment = Enum.TextXAlignment.Left
cardTitle.TextColor3 = Color3.fromRGB(255,255,255)
cardTitle.Text = "Update v2.0"

local updates = {
    "• Added Auto Option System",
    "• Added Teleport Menu",
    "• Added Quest Helper",
    "• Added Shop & Trade UI",
    "• Improved Premium GUI Layout"
}

for i,text in ipairs(updates) do
    local lbl = Instance.new("TextLabel", infoCard)
    lbl.Position = UDim2.new(0, 18, 0, 50 + ((i-1) * 24))
    lbl.Size = UDim2.new(1, -36, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.fromRGB(220,220,220)
    lbl.Text = text
end

--================ OTHER PAGES (CARD STYLE, NO DOUBLE TITLE) ================--
local function dummyPage(name)
    local p = createPage(name)

    local card = Instance.new("Frame", p)
    card.Position = UDim2.new(0, 0, 0, 10)
    card.Size = UDim2.new(1, -10, 0, 140)
    card.BackgroundColor3 = Color3.fromRGB(30,36,52)
    card.BorderSizePixel = 0
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,14)

    local lbl = Instance.new("TextLabel", card)
    lbl.Position = UDim2.new(0, 18, 0, 16)
    lbl.Size = UDim2.new(1, -36, 0, 26)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 20
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.Text = name.." Page"
end

dummyPage("Auto Option")
dummyPage("Teleport")
dummyPage("Misc")
dummyPage("Event")
dummyPage("Quest")
dummyPage("Shop & Trade")

--================ RIGHT TAB BAR ================--
local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.new(0, 100, 1, -40)
tabBar.Position = UDim2.new(1, -120, 0, 20)
tabBar.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", tabBar)
layout.Padding = UDim.new(0, 6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local tabs = {
    "Auto Option",
    "Teleport",
    "Misc",
    "Event",
    "Quest",
    "Shop & Trade",
    "Information"
}

local buttons = {}

local function switchTab(name)
    for n,p in pairs(pages) do
        p.Visible = (n == name)
    end
    title.Text = name
    for n,b in pairs(buttons) do
        TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundColor3 = n==name
                and Color3.fromRGB(255,191,0)
                or Color3.fromRGB(32,38,52)
        }):Play()
    end
end

for _,name in ipairs(tabs) do
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(1,0,0,36)
    btn.BackgroundColor3 = Color3.fromRGB(32,38,52)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(230,230,230)
    btn.Text = name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)
    btn.MouseButton1Click:Connect(function()
        switchTab(name)
    end)
    buttons[name] = btn
end

--================ DEFAULT TAB ================--
switchTab("Information")

--================ DRAG LOGIC ================--
local dragging, dragStart, startPos
header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = main.Position
        i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
