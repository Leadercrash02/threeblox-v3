--// THREEBLOX HUB - FISH IT
--// FIX 1 FULL GUI (RIGHT TAB, PAGE SYSTEM OK)

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
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxHub"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = pg

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

--================ HEADER ================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, -120, 0, 46)
header.Position = UDim2.new(0, 20, 0, 14)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "Information"

--================ CONTENT AREA ================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 20, 0, 70)
content.Size = UDim2.new(1, -140, 1, -90)
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

--================ INFORMATION PAGE (ISI) ================--
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

--================ OTHER PAGES (DUMMY BUT REAL) ================--
local function dummyContent(page, text)
    local lbl = Instance.new("TextLabel", page)
    lbl.Position = UDim2.new(0,0,0,40)
    lbl.Size = UDim2.new(1,0,0,24)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 16
    lbl.TextColor3 = Color3.fromRGB(200,200,200)
    lbl.Text = text
end

dummyContent(createPage("Auto Option"), "Auto Option UI will be here")
dummyContent(createPage("Teleport"), "Teleport UI will be here")
dummyContent(createPage("Misc"), "Miscellaneous options will be here")
dummyContent(createPage("Event"), "Event menu will be here")
dummyContent(createPage("Quest"), "Quest helper UI will be here")
dummyContent(createPage("Shop & Trade"), "Shop & Trade UI will be here")

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
local activeBtn

local function switchTab(name)
    for n,p in pairs(pages) do
        p.Visible = (n == name)
    end
    title.Text = name

    for n,b in pairs(buttons) do
        TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundColor3 = n==name and Color3.fromRGB(255,191,0) or Color3.fromRGB(28,32,44)
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

--================ DEFAULT PAGE ================--
switchTab("Information")

--================ DRAG WINDOW ================--
local dragging, dragStart, startPos
main.InputBegan:Connect(function(i)
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
