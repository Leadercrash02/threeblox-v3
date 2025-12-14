--// THREEBLOX HUB - FISH IT
--// FIX 2 FULL GUI (RIGHT TAB + DRAG + MINIMIZE + CLOSE)

--================ SERVICES ================--
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ CLEAN OLD GUI ================--
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
main.Size = UDim2.new(0, 700, 0, 380)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)
Instance.new("UIStroke", main).Transparency = 0.6

--================ HEADER (DRAG AREA) ================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, -140, 0, 40)
header.Position = UDim2.new(0, 20, 0, 14)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -60, 1, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "Information"

--================ HEADER BUTTONS ================--
local btnClose = Instance.new("TextButton", header)
btnClose.Size = UDim2.new(0, 28, 0, 28)
btnClose.Position = UDim2.new(1, -28, 0.5, -14)
btnClose.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
btnClose.Text = "X"
btnClose.Font = Enum.Font.GothamBold
btnClose.TextSize = 14
btnClose.TextColor3 = Color3.new(1,1,1)
btnClose.BorderSizePixel = 0
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(1,0)

local btnMin = Instance.new("TextButton", header)
btnMin.Size = UDim2.new(0, 28, 0, 28)
btnMin.Position = UDim2.new(1, -62, 0.5, -14)
btnMin.BackgroundColor3 = Color3.fromRGB(255, 191, 0)
btnMin.Text = "-"
btnMin.Font = Enum.Font.GothamBold
btnMin.TextSize = 18
btnMin.TextColor3 = Color3.new(0,0,0)
btnMin.BorderSizePixel = 0
Instance.new("UICorner", btnMin).CornerRadius = UDim.new(1,0)

--================ MINIMIZED ICON ================--
local mini = Instance.new("TextButton", gui)
mini.Visible = false
mini.Size = UDim2.new(0, 140, 0, 34)
mini.Position = UDim2.new(0, 20, 1, -50)
mini.AnchorPoint = Vector2.new(0,1)
mini.BackgroundColor3 = Color3.fromRGB(18,22,32)
mini.Text = "Threeblox Hub"
mini.Font = Enum.Font.Gotham
mini.TextSize = 14
mini.TextColor3 = Color3.new(1,1,1)
mini.BorderSizePixel = 0
Instance.new("UICorner", mini).CornerRadius = UDim.new(0,12)

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

--================ CONTENT AREA ================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 20, 0, 70)
content.Size = UDim2.new(1, -160, 1, -90)
content.BackgroundTransparency = 1

--================ PAGE SYSTEM ================--
local pages = {}

local function createPage(name)
    local page = Instance.new("Frame", content)
    page.Size = UDim2.new(1,0,1,0)
    page.Visible = false
    page.BackgroundTransparency = 1

    local lbl = Instance.new("TextLabel", page)
    lbl.Size = UDim2.new(1,0,0,28)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 22
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.Text = name

    pages[name] = page
    return page
end

--================ INFORMATION PAGE ================--
local infoPage = createPage("Information")

local scroll = Instance.new("ScrollingFrame", infoPage)
scroll.Position = UDim2.new(0,0,0,36)
scroll.Size = UDim2.new(1,0,1,-36)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarImageTransparency = 0.8
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)

local function infoLine(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,-10,0,24)
    lbl.BackgroundTransparency = 1
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 15
    lbl.TextColor3 = Color3.fromRGB(220,220,220)
    lbl.Text = text
    lbl.Parent = scroll
end

infoLine("⭐ Update v2.0")
infoLine("• Added Auto Option System")
infoLine("• Added Teleport Menu")
infoLine("• Added Quest Helper")
infoLine("• Added Shop & Trade UI")
infoLine("• Added Premium GUI Layout")

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end)

--================ OTHER PAGES (DUMMY) ================--
local function dummy(pageName)
    local p = createPage(pageName)
    local lbl = Instance.new("TextLabel", p)
    lbl.Position = UDim2.new(0,0,0,40)
    lbl.Size = UDim2.new(1,0,0,24)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 16
    lbl.TextColor3 = Color3.fromRGB(200,200,200)
    lbl.Text = pageName.." UI will be here"
end

dummy("Auto Option")
dummy("Teleport")
dummy("Misc")
dummy("Event")
dummy("Quest")
dummy("Shop & Trade")

--================ RIGHT TAB BAR ================--
local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.new(0, 90, 1, -40)
tabBar.Position = UDim2.new(1, -110, 0, 20)
tabBar.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.Padding = UDim.new(0, 6)
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

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
            BackgroundColor3 = n==name and Color3.fromRGB(255,191,0)
                or Color3.fromRGB(28,32,44)
        }):Play()
    end
end

for _,name in ipairs(tabs) do
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(1,0,0,34)
    btn.BackgroundColor3 = Color3.fromRGB(28,32,44)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(220,220,220)
    btn.Text = name

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

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
