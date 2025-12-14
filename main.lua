--// THREEBLOX HUB | FISH IT
--// FINAL FIX (TOP-RIGHT BUTTONS, STABLE)

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

-- ROOT GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxHub_FinalFix"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = pg

-- ================= MINI LOGO (DRAGGABLE) =================
local miniLogo = Instance.new("TextButton", gui)
miniLogo.Size = UDim2.new(0, 48, 0, 48)
miniLogo.Position = UDim2.new(0, 20, 0.5, -24)
miniLogo.BackgroundColor3 = Color3.fromRGB(255,200,0)
miniLogo.Text = "TB"
miniLogo.Font = Enum.Font.GothamBold
miniLogo.TextSize = 18
miniLogo.TextColor3 = Color3.fromRGB(30,30,30)
miniLogo.BorderSizePixel = 0
miniLogo.Visible = false
miniLogo.ZIndex = 100
miniLogo.Active = true
Instance.new("UICorner", miniLogo).CornerRadius = UDim.new(1,0)

-- ================= MAIN WINDOW =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 720, 0, 420)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20,25,35)
main.BorderSizePixel = 0
main.ZIndex = 10
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- ================= HEADER =================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 42)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(26,30,44)
header.BorderSizePixel = 0
header.Active = true
header.ZIndex = 20
header.ClipsDescendants = false
Instance.new("UICorner", header).CornerRadius = UDim.new(0,16)

-- TITLE
local title = Instance.new("TextLabel", header)
title.Position = UDim2.new(0, 14, 0, 0)
title.Size = UDim2.new(1, -120, 1, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "Threeblox | Fish It"
title.ZIndex = 25

-- MINIMIZE (TOP RIGHT - FIXED)
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -66, 0, 8) -- ✅ FIX
minBtn.BackgroundColor3 = Color3.fromRGB(255,200,0)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.TextColor3 = Color3.fromRGB(30,30,30)
minBtn.BorderSizePixel = 0
minBtn.ZIndex = 30
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

-- CLOSE (TOP RIGHT - FIXED)
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -34, 0, 8) -- ✅ FIX
closeBtn.BackgroundColor3 = Color3.fromRGB(200,70,70)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 30
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- ================= SIDEBAR =================
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0, 0, 0, 42)
sidebar.Size = UDim2.new(0, 170, 1, -42)
sidebar.BackgroundColor3 = Color3.fromRGB(18,22,32)
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 15

local sidePad = Instance.new("UIPadding", sidebar)
sidePad.PaddingTop = UDim.new(0, 10)

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0, 6)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ================= CONTENT =================
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 170, 0, 42)
content.Size = UDim2.new(1, -170, 1, -42)
content.BackgroundColor3 = Color3.fromRGB(24,28,40)
content.BorderSizePixel = 0
content.ZIndex = 15

local pageTitle = Instance.new("TextLabel", content)
pageTitle.Position = UDim2.new(0, 16, 0, 10)
pageTitle.Size = UDim2.new(1, -32, 0, 26)
pageTitle.BackgroundTransparency = 1
pageTitle.Font = Enum.Font.GothamBold
pageTitle.TextSize = 22
pageTitle.TextXAlignment = Enum.TextXAlignment.Left
pageTitle.TextColor3 = Color3.fromRGB(255,255,255)
pageTitle.Text = "Information"

local box = Instance.new("Frame", content)
box.Position = UDim2.new(0, 16, 0, 44)
box.Size = UDim2.new(1, -32, 1, -60)
box.BackgroundColor3 = Color3.fromRGB(30,36,52)
box.BorderSizePixel = 0
Instance.new("UICorner", box).CornerRadius = UDim.new(0,14)

local boxText = Instance.new("TextLabel", box)
boxText.Position = UDim2.new(0, 14, 0, 14)
boxText.Size = UDim2.new(1, -28, 1, -28)
boxText.BackgroundTransparency = 1
boxText.Font = Enum.Font.Gotham
boxText.TextSize = 15
boxText.TextWrapped = true
boxText.TextXAlignment = Enum.TextXAlignment.Left
boxText.TextYAlignment = Enum.TextYAlignment.Top
boxText.TextColor3 = Color3.fromRGB(220,220,220)
boxText.Text = "Information page content."

-- ================= MENU =================
local menus = {
    "Information",
    "Auto Option",
    "Teleport",
    "Misc",
    "Event",
    "Quest",
    "Shop & Trade"
}

local activeBtn
for _,name in ipairs(menus) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -20, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(28,34,48)
    btn.Text = "  "..name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 15
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BorderSizePixel = 0
    btn.ZIndex = 20
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    btn.MouseButton1Click:Connect(function()
        if activeBtn then
            activeBtn.BackgroundColor3 = Color3.fromRGB(28,34,48)
            activeBtn.TextColor3 = Color3.fromRGB(255,255,255)
        end
        btn.BackgroundColor3 = Color3.fromRGB(255,200,0)
        btn.TextColor3 = Color3.fromRGB(30,30,30)
        activeBtn = btn
        pageTitle.Text = name
        boxText.Text = name.." page content."
    end)

    if name == "Information" then
        btn.BackgroundColor3 = Color3.fromRGB(255,200,0)
        btn.TextColor3 = Color3.fromRGB(30,30,30)
        activeBtn = btn
    end
end

-- ================= DRAG MAIN =================
local dragging, dragStart, startPos
header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = main.Position
    end
end)
header.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
header.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- ================= DRAG MINI LOGO =================
local logoDrag, logoStart, logoPos
miniLogo.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        logoDrag = true
        logoStart = i.Position
        logoPos = miniLogo.Position
    end
end)
miniLogo.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        logoDrag = false
    end
end)
miniLogo.InputChanged:Connect(function(i)
    if logoDrag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - logoStart
        miniLogo.Position = UDim2.new(
            logoPos.X.Scale, logoPos.X.Offset + delta.X,
            logoPos.Y.Scale, logoPos.Y.Offset + delta.Y
        )
    end
end)

-- ================= MINIMIZE / CLOSE =================
minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    miniLogo.Visible = true
end)

miniLogo.MouseButton1Click:Connect(function()
    main.Visible = true
    miniLogo.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
