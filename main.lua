-- THREEBLOX V3 | FISH IT
-- FIXED GUI (DRAG + MINIMIZE, NO CRASH)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

-- ROOT GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxV3_FIXED"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = pg

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 360)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(22,26,36)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- HEADER (DRAG AREA)
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,40)
header.BackgroundTransparency = 1
header.Active = true -- WAJIB

local title = Instance.new("TextLabel", header)
title.Position = UDim2.new(0,12,0,0)
title.Size = UDim2.new(1,-100,1,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1,1,1)
title.Text = "Threeblox V3 | Fish It"

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,28,0,28)
closeBtn.Position = UDim2.new(1,-32,6,0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(180,60,60)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- MINIMIZE
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0,28,0,28)
minBtn.Position = UDim2.new(1,-64,6,0)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.TextColor3 = Color3.new(0,0,0)
minBtn.BackgroundColor3 = Color3.fromRGB(255,191,0)
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

-- TAB BAR
local tabBar = Instance.new("Frame", main)
tabBar.Position = UDim2.new(0,0,0,40)
tabBar.Size = UDim2.new(0,140,1,-40)
tabBar.BackgroundColor3 = Color3.fromRGB(18,22,30)
tabBar.BorderSizePixel = 0

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,140,0,40)
content.Size = UDim2.new(1,-140,1,-40)
content.BackgroundTransparency = 1

local contentText = Instance.new("TextLabel", content)
contentText.Position = UDim2.new(0,12,0,12)
contentText.Size = UDim2.new(1,-24,1,-24)
contentText.BackgroundTransparency = 1
contentText.Font = Enum.Font.GothamBold
contentText.TextSize = 18
contentText.TextWrapped = true
contentText.TextYAlignment = Enum.TextYAlignment.Top
contentText.TextColor3 = Color3.fromRGB(230,230,230)
contentText.Text = "Information\n\nWelcome to Threeblox V3 | Fish It"

-- MENU
local menus = {
    Information = "Information\n\nHub ready & stable.",
    ["Auto Fish"] = "Auto Fish\n\nFeature placeholder.",
    Teleport = "Teleport\n\nLocation list.",
    Quest = "Quest\n\nDaily quest.",
    Shop = "Shop\n\nRod & bait."
}

local y = 10
for name,text in pairs(menus) do
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(1,-12,0,30)
    btn.Position = UDim2.new(0,6,0,y)
    btn.BackgroundColor3 = Color3.fromRGB(30,34,46)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(230,230,230)
    btn.Text = name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    btn.MouseButton1Click:Connect(function()
        contentText.Text = text
    end)

    y += 34
end

-- MINIMIZED LOGO
local logoBtn = Instance.new("TextButton", gui)
logoBtn.Size = UDim2.new(0,48,0,48)
logoBtn.Position = UDim2.new(0,12,0.5,-24)
logoBtn.BackgroundColor3 = Color3.fromRGB(255,191,0)
logoBtn.Text = "TB"
logoBtn.Font = Enum.Font.GothamBlack
logoBtn.TextSize = 18
logoBtn.TextColor3 = Color3.new(0,0,0)
logoBtn.Visible = false
logoBtn.BorderSizePixel = 0
Instance.new("UICorner", logoBtn).CornerRadius = UDim.new(1,0)

-- MINIMIZE LOGIC (SAFE)
minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    logoBtn.Visible = true
end)

logoBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    logoBtn.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- DRAG LOGIC (SAFE, NO GLOBAL INPUT)
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
    end
end)
