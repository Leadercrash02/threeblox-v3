--// THREEBLOX HUB - FISH IT
--// UPDATE 1 - FULL STABLE VERSION (ANTI NIL ERROR)

--================ SERVICES ================--
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ SAFE GUARD ================--
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

TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
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
title.TextColor3 = Color3.new(0,0,0)
title.Text = "Threeblox Hub"
title.Position = UDim2.new(0, 16, 0, 4)
title.Size = UDim2.new(0.5, 0, 0.5, 0)
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 13
subtitle.TextColor3 = Color3.fromRGB(40,40,40)
subtitle.Text = "Fish It"
subtitle.Position = UDim2.new(0, 16, 0, 20)
subtitle.Size = UDim2.new(0.5, 0, 0.5, 0)
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
miniIcon.Size = UDim2.new(0, 130, 0, 30)
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
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--================ SIDEBAR ================--
local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.Size = UDim2.new(0, 150, 1, -40)
sidebar.BackgroundColor3 = Color3.fromRGB(10, 15, 22)
sidebar.Parent = main

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0, 6)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,8)

--================ CONTENT ================--
local content = Instance.new("Frame")
content.Position = UDim2.new(0,150,0,40)
content.Size = UDim2.new(1,-150,1,-40)
content.BackgroundColor3 = Color3.fromRGB(12,18,28)
content.Parent = main

Instance.new("UIPadding", content).PaddingTop = UDim.new(0,8)

--================ TAB CREATOR ================--
local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,32)
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
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(18,26,38)
        }):Play()
    end)

    return btn
end

--================ PAGES ================--
local tabs = {"Main","Auto Fish","Teleport","Misc","Info"}
local pages, buttons = {}, {}

for _,name in ipairs(tabs) do
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1,0,1,0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content
    pages[name] = page

    local btn = createTab(name)
    buttons[name] = btn
end

local function setTab(name)
    for n,p in pairs(pages) do
        p.Visible = (n == name)
    end
    for n,b in pairs(buttons) do
        TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundColor3 = n==name and Color3.fromRGB(35,49,70) or Color3.fromRGB(18,26,38)
        }):Play()
    end
end

for n,b in pairs(buttons) do
    b.MouseButton1Click:Connect(function()
        setTab(n)
    end)
end

--================ AUTO FISH LOGIC (SAFE) ================--
local AutoFish = {Enabled = false}

function AutoFish:Start()
    if self.Enabled then return end
    self.Enabled = true
    task.spawn(function()
        while self.Enabled do
            -- taro logic auto fish di sini
            task.wait(0.25)
        end
    end)
end

function AutoFish:Stop()
    self.Enabled = false
end

-- Auto Fish Page
local autoPage = pages["Auto Fish"]

local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(0,180,0,30)
autoBtn.Position = UDim2.new(0,10,0,10)
autoBtn.BackgroundColor3 = Color3.fromRGB(20,30,45)
autoBtn.Text = "Auto Fish : DISABLED"
autoBtn.Font = Enum.Font.Gotham
autoBtn.TextSize = 14
autoBtn.TextColor3 = Color3.new(1,1,1)
autoBtn.Parent = autoPage
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0,6)

autoBtn.MouseButton1Click:Connect(function()
    if AutoFish.Enabled then
        AutoFish:Stop()
        autoBtn.Text = "Auto Fish : DISABLED"
    else
        AutoFish:Start()
        autoBtn.Text = "Auto Fish : ENABLED"
    end
end)

--================ DEFAULT TAB ================--
setTab("Main")
