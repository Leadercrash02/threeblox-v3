-- THREEBLOX V3 | FISH IT
-- PREMIUM CLEAN GUI (STABLE, DRAG + MINIMIZE)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

-- ROOT GUI
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3_Premium"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

-- MAIN WINDOW
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 680, 0, 400)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(22, 26, 36)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

-- SHADOW (FAKE)
local shadow = Instance.new("Frame", gui)
shadow.Size = main.Size
shadow.Position = main.Position + UDim2.new(0, 4, 0, 6)
shadow.AnchorPoint = main.AnchorPoint
shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
shadow.BackgroundTransparency = 0.6
shadow.ZIndex = 0
Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 16)

main.ZIndex = 1

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 44)
header.BackgroundColor3 = Color3.fromRGB(28, 32, 46)
header.BorderSizePixel = 0
header.Active = true
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16)

-- FIX CORNER HEADER
local fix = Instance.new("Frame", header)
fix.Size = UDim2.new(1,0,0,22)
fix.Position = UDim2.new(0,0,1,-22)
fix.BackgroundColor3 = header.BackgroundColor3
fix.BorderSizePixel = 0

-- TITLE
local title = Instance.new("TextLabel", header)
title.Position = UDim2.new(0, 16, 0, 0)
title.Size = UDim2.new(1, -140, 1, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "Threeblox V3 | Fish It"

-- CLOSE BUTTON (TOP RIGHT)
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 8, 0)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- MINIMIZE BUTTON (LEFT OF CLOSE)
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -72, 8, 0)
minBtn.Text = "—"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.TextColor3 = Color3.fromRGB(20,20,20)
minBtn.BackgroundColor3 = Color3.fromRGB(255, 191, 0)
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

-- SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0, 0, 0, 44)
sidebar.Size = UDim2.new(0, 160, 1, -44)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
sidebar.BorderSizePixel = 0

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 160, 0, 44)
content.Size = UDim2.new(1, -160, 1, -44)
content.BackgroundColor3 = Color3.fromRGB(24, 28, 40)
content.BorderSizePixel = 0

-- CONTENT TEXT
local contentText = Instance.new("TextLabel", content)
contentText.Position = UDim2.new(0, 20, 0, 20)
contentText.Size = UDim2.new(1, -40, 1, -40)
contentText.BackgroundTransparency = 1
contentText.Font = Enum.Font.GothamBold
contentText.TextSize = 18
contentText.TextXAlignment = Enum.TextXAlignment.Left
contentText.TextYAlignment = Enum.TextYAlignment.Top
contentText.TextWrapped = true
contentText.TextColor3 = Color3.fromRGB(230,230,230)
contentText.Text = "Information\n\nWelcome to Threeblox V3 | Fish It"

-- MENU
local menus = {
    Information = "Information\n\n• Stable build\n• Optimized for Xeno & Delta\n• Premium clean UI",
    ["Auto Fish"] = "Auto Fish\n\n• Toggle system\n• Safe placeholder",
    Teleport = "Teleport\n\n• Fishing Spot\n• Market\n• Spawn",
    Quest = "Quest\n\n• Daily quest\n• Progress tracking",
    Shop = "Shop\n\n• Rod\n• Bait\n• Trade"
}

local y = 12
for name,text in pairs(menus) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -20, 0, 36)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(30, 34, 48)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(235,235,235)
    btn.Text = name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(function()
        contentText.Text = text
    end)

    y = y + 44
end

-- MINIMIZED LOGO
local logoBtn = Instance.new("TextButton", gui)
logoBtn.Size = UDim2.new(0, 52, 0, 52)
logoBtn.Position = UDim2.new(0, 14, 0.5, -26)
logoBtn.BackgroundColor3 = Color3.fromRGB(255, 191, 0)
logoBtn.Text = "TB"
logoBtn.Font = Enum.Font.GothamBlack
logoBtn.TextSize = 20
logoBtn.TextColor3 = Color3.fromRGB(20,20,20)
logoBtn.Visible = false
logoBtn.BorderSizePixel = 0
Instance.new("UICorner", logoBtn).CornerRadius = UDim.new(1,0)

-- BUTTON LOGIC
minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    shadow.Visible = false
    logoBtn.Visible = true
end)

logoBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    shadow.Visible = true
    logoBtn.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    shadow:Destroy()
end)

-- DRAG (HEADER ONLY, SAFE)
local dragging = false
local dragStart, startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

header.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
        shadow.Position = main.Position + UDim2.new(0,4,0,6)
    end
end)
