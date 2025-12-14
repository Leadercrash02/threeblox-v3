--// THREEBLOX HUB - FISH IT
--// UPDATE 1 FINAL (MINIMIZE TO LOGO)

-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

-- CLEAN
pcall(function()
    for _,v in ipairs(pg:GetChildren()) do
        if v:IsA("ScreenGui") then
            v:Destroy()
        end
    end
end)

-- ROOT
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3_GUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

-- MAIN WINDOW
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 760, 0, 420)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20,24,34)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

-- HEADER (DRAG)
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 46)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Position = UDim2.new(0, 16, 0, 2)
title.Size = UDim2.new(1, -120, 0, 26)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "Threeblox V3 | Fish It"

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -36, 8, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- MINIMIZE
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -72, 8, 0)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextColor3 = Color3.fromRGB(0,0,0)
minBtn.BackgroundColor3 = Color3.fromRGB(255,191,0)
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

-- TAB BAR (LEFT)
local tabBar = Instance.new("Frame", main)
tabBar.Position = UDim2.new(0, 0, 0, 46)
tabBar.Size = UDim2.new(0, 150, 1, -46)
tabBar.BackgroundColor3 = Color3.fromRGB(16,20,28)
tabBar.BorderSizePixel = 0

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.Padding = UDim.new(0, 6)
Instance.new("UIPadding", tabBar).PaddingTop = UDim.new(0, 10)

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 150, 0, 46)
content.Size = UDim2.new(1, -150, 1, -46)
content.BackgroundTransparency = 1
Instance.new("UIPadding", content).PaddingLeft = UDim.new(0, 16)

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
    lbl.Position = UDim2.new(0, 16, 0, 14)
    lbl.Size = UDim2.new(1, -32, 0, 26)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 20
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
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

for _,name in ipairs(tabs) do
    createPage(name)

    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(1, -20, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(28,34,48)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(230,230,230)
    btn.Text = name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    btn.MouseButton1Click:Connect(function()
        for n,p in pairs(pages) do
            p.Visible = (n == name)
        end
    end)
end

pages["Information"].Visible = true

-- 🔥 MINIMIZED LOGO (TEXT LOGO)
local logoBtn = Instance.new("TextButton", gui)
logoBtn.Size = UDim2.new(0, 56, 0, 56)
logoBtn.Position = UDim2.new(0, 16, 0.5, -28)
logoBtn.BackgroundColor3 = Color3.fromRGB(255,191,0)
logoBtn.Text = "TB"
logoBtn.Font = Enum.Font.GothamBlack
logoBtn.TextSize = 20
logoBtn.TextColor3 = Color3.fromRGB(0,0,0)
logoBtn.Visible = false
logoBtn.BorderSizePixel = 0
Instance.new("UICorner", logoBtn).CornerRadius = UDim.new(1,0)

-- MINIMIZE ACTION
minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    logoBtn.Visible = true
end)

-- RESTORE FROM LOGO
logoBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    logoBtn.Visible = false
end)

-- CLOSE
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- DRAG WINDOW
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
