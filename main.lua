--// THREEBLOX HUB - FISH IT
--// GUI UPDATE FULL (FOCUS GUI ONLY, NO GAME LOGIC)

--================ SERVICES ================--
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ CLEAN DUPLICATE ================--
pcall(function()
    if pg:FindFirstChild("ThreebloxHub") then
        pg.ThreebloxHub:Destroy()
    end
end)

--================ ROOT GUI ================--
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = pg

--================ MAIN WINDOW ================--
local main = Instance.new("Frame")
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.45, 0)
main.Size = UDim2.new(0, 620, 0, 360)
main.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", main).Transparency = 0.4

TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
    Position = UDim2.new(0.5, 0, 0.5, 0)
}):Play()

--================ HEADER ================--
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(255, 191, 0)
header.BorderSizePixel = 0
header.Parent = main
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local grad = Instance.new("UIGradient", header)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,191,0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,140,0))
}

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(0,0,0)
title.Text = "Threeblox Hub"
title.Position = UDim2.new(0, 16, 0, 4)
title.Size = UDim2.new(0.5, 0, 0.5, 0)
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 13
subtitle.TextColor3 = Color3.fromRGB(40,40,40)
subtitle.Text = "Fish It | Premium GUI"
subtitle.Position = UDim2.new(0, 16, 0, 20)
subtitle.Size = UDim2.new(0.6, 0, 0.5, 0)
subtitle.Parent = header

-- Close
local closeBtn = Instance.new("TextButton")
closeBtn.AnchorPoint = Vector2.new(1, 0.5)
closeBtn.Position = UDim2.new(1, -10, 0.5, 0)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(0,0,0)
closeBtn.Parent = header

-- Minimize
local miniBtn = Instance.new("TextButton")
miniBtn.AnchorPoint = Vector2.new(1, 0.5)
miniBtn.Position = UDim2.new(1, -36, 0.5, 0)
miniBtn.Size = UDim2.new(0, 24, 0, 24)
miniBtn.BackgroundTransparency = 1
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 18
miniBtn.Text = "-"
miniBtn.TextColor3 = Color3.new(0,0,0)
miniBtn.Parent = header

--================ MINI ICON ================--
local miniIcon = Instance.new("TextButton")
miniIcon.Visible = false
miniIcon.Size = UDim2.new(0, 140, 0, 30)
miniIcon.Position = UDim2.new(0, 10, 1, -40)
miniIcon.AnchorPoint = Vector2.new(0,1)
miniIcon.BackgroundColor3 = Color3.fromRGB(15,20,30)
miniIcon.Text = "Threeblox Hub"
miniIcon.Font = Enum.Font.Gotham
miniIcon.TextSize = 14
miniIcon.TextColor3 = Color3.new(1,1,1)
miniIcon.Parent = gui
Instance.new("UICorner", miniIcon).CornerRadius = UDim.new(0,6)

miniBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    miniIcon.Visible = true
end)

miniIcon.MouseButton1Click:Connect(function()
    main.Visible = true
    miniIcon.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

--================ DRAG ================--
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

--================ SIDEBAR ================--
local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.Size = UDim2.new(0, 160, 1, -40)
sidebar.BackgroundColor3 = Color3.fromRGB(10, 15, 22)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0, 6)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,10)

--================ CONTENT ================--
local content = Instance.new("Frame")
content.Position = UDim2.new(0,160,0,40)
content.Size = UDim2.new(1,-160,1,-40)
content.BackgroundColor3 = Color3.fromRGB(12,18,28)
content.BorderSizePixel = 0
content.Parent = main

Instance.new("UIPadding", content).PaddingTop = UDim.new(0,10)
Instance.new("UIPadding", content).PaddingLeft = UDim.new(0,12)

--================ TAB CREATOR ================--
local function createTabButton(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(18,26,38)
    btn.Text = "   "..name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = sidebar

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(28,38,55)
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(35,49,70) then
            TweenService:Create(btn, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(18,26,38)
            }):Play()
        end
    end)

    return btn
end

--================ TABS & PAGES ================--
local tabNames = {
    "Auto Fish",
    "Backpack",
    "Teleport",
    "Quest",
    "Shop & Trade",
    "Misc",
    "Info"
}

local pages = {}
local buttons = {}

for _,name in ipairs(tabNames) do
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1,0,1,0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content
    pages[name] = page

    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextColor3 = Color3.new(1,1,1)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = name
    title.Position = UDim2.new(0,0,0,0)
    title.Size = UDim2.new(1,0,0,26)
    title.Parent = page

    local btn = createTabButton(name)
    buttons[name] = btn
end

local function setTab(active)
    for name,page in pairs(pages) do
        page.Visible = (name == active)
    end
    for name,btn in pairs(buttons) do
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = name == active
                and Color3.fromRGB(35,49,70)
                or Color3.fromRGB(18,26,38)
        }):Play()
    end
end

for name,btn in pairs(buttons) do
    btn.MouseButton1Click:Connect(function()
        setTab(name)
    end)
end

--================ DEFAULT TAB ================--
setTab("Auto Fish")
