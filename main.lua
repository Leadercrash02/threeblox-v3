--// THREEBLOX HUB - FISH IT
--// FINAL FIX (TAB LEFT, CONTENT RIGHT)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

pcall(function()
    if pg:FindFirstChild("ThreebloxHub_LEFT") then
        pg.ThreebloxHub_LEFT:Destroy()
    end
end)

-- ROOT
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxHub_LEFT"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 720, 0, 400)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20,24,34)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

-- HEADER (DRAG)
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Position = UDim2.new(0, 16, 0, 0)
title.Size = UDim2.new(1, -100, 1, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1,1,1)
title.Text = "Information"

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -36, 0.5, -15)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- MINIMIZE
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -72, 0.5, -15)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextColor3 = Color3.new(0,0,0)
minBtn.BackgroundColor3 = Color3.fromRGB(255,191,0)
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

-- TAB BAR (LEFT)
local tabBar = Instance.new("Frame", main)
tabBar.Position = UDim2.new(0, 0, 0, 44)
tabBar.Size = UDim2.new(0, 140, 1, -44)
tabBar.BackgroundColor3 = Color3.fromRGB(16,20,28)
tabBar.BorderSizePixel = 0

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.Padding = UDim.new(0, 6)
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

Instance.new("UIPadding", tabBar).PaddingTop = UDim.new(0,10)

-- CONTENT (RIGHT)
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 140, 0, 44)
content.Size = UDim2.new(1, -140, 1, -44)
content.BackgroundTransparency = 1
Instance.new("UIPadding", content).PaddingLeft = UDim.new(0,14)
Instance.new("UIPadding", content).PaddingTop  = UDim.new(0,10)

-- PAGES
local pages = {}

local function createPage(name)
    local page = Instance.new("Frame", content)
    page.Size = UDim2.new(1,0,1,0)
    page.Visible = false
    page.BackgroundTransparency = 1
    pages[name] = page

    local card = Instance.new("Frame", page)
    card.Size = UDim2.new(1, -20, 0, 160)
    card.BackgroundColor3 = Color3.fromRGB(30,36,52)
    card.BorderSizePixel = 0
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,14)

    local lbl = Instance.new("TextLabel", card)
    lbl.Position = UDim2.new(0, 16, 0, 12)
    lbl.Size = UDim2.new(1, -32, 0, 26)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 20
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.Text = name

    return page
end

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
end

for _,name in ipairs(tabs) do
    createPage(name)

    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(1, -20, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(28,34,48)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(230,230,230)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    btn.MouseButton1Click:Connect(function()
        switchTab(name)
    end)

    buttons[name] = btn
end

switchTab("Information")

-- DRAG
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

-- MIN / CLOSE
minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
