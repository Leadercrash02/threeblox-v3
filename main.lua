--// THREEBLOX HUB - FISH IT
--// UPDATE 1 FULL GUI (TAB LEFT, CONTENT RIGHT, ASSET INCLUDED)

--================ SERVICES ================--
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

--================ HARD CLEAN ================--
pcall(function()
    for _,v in ipairs(pg:GetChildren()) do
        if v:IsA("ScreenGui") then
            v:Destroy()
        end
    end
end)

--================ ROOT GUI ================--
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxHub_UPDATE1"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = pg

--================ MAIN WINDOW ================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 760, 0, 420)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20, 24, 34)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)
Instance.new("UIStroke", main).Transparency = 0.6

--================ HEADER (DRAG) ================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 46)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Position = UDim2.new(0, 16, 0, 0)
title.Size = UDim2.new(1, -120, 1, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "Information"

-- CLOSE
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -36, 0.5, -15)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- MINIMIZE
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -72, 0.5, -15)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.TextColor3 = Color3.fromRGB(0,0,0)
minBtn.BackgroundColor3 = Color3.fromRGB(255,191,0)
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

--================ TAB BAR (LEFT) ================--
local tabBar = Instance.new("Frame", main)
tabBar.Position = UDim2.new(0, 0, 0, 46)
tabBar.Size = UDim2.new(0, 150, 1, -46)
tabBar.BackgroundColor3 = Color3.fromRGB(16,20,28)
tabBar.BorderSizePixel = 0

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.Padding = UDim.new(0, 6)
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", tabBar).PaddingTop = UDim.new(0, 10)

--================ CONTENT (RIGHT) ================--
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 150, 0, 46)
content.Size = UDim2.new(1, -150, 1, -46)
content.BackgroundTransparency = 1

local pad = Instance.new("UIPadding", content)
pad.PaddingLeft = UDim.new(0, 16)
pad.PaddingTop  = UDim.new(0, 12)

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

--================ INFORMATION PAGE (REAL CONTENT) ================--
local infoPage = createPage("Information")

local card = Instance.new("Frame", infoPage)
card.Size = UDim2.new(1, -20, 0, 300)
card.BackgroundColor3 = Color3.fromRGB(30,36,52)
card.BorderSizePixel = 0
Instance.new("UICorner", card).CornerRadius = UDim.new(0,16)
Instance.new("UIStroke", card).Transparency = 0.6

-- LOGO (PUBLIC ASSET)
local logo = Instance.new("ImageLabel", card)
logo.Size = UDim2.new(0, 64, 0, 64)
logo.Position = UDim2.new(1, -80, 0, 16)
logo.AnchorPoint = Vector2.new(1,0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://14397671101" -- Fish Minimal
logo.ScaleType = Enum.ScaleType.Fit

-- TITLE
local cardTitle = Instance.new("TextLabel", card)
cardTitle.Position = UDim2.new(0, 20, 0, 18)
cardTitle.Size = UDim2.new(1, -120, 0, 28)
cardTitle.BackgroundTransparency = 1
cardTitle.Font = Enum.Font.GothamBold
cardTitle.TextSize = 22
cardTitle.TextXAlignment = Enum.TextXAlignment.Left
cardTitle.TextColor3 = Color3.fromRGB(255,255,255)
cardTitle.Text = "Update v1.0"

-- BANNER (PUBLIC ASSET)
local banner = Instance.new("ImageLabel", card)
banner.Position = UDim2.new(0, 20, 0, 56)
banner.Size = UDim2.new(1, -40, 0, 90)
banner.BackgroundTransparency = 1
banner.Image = "rbxassetid://1084308523" -- Dark Gradient
banner.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", banner).CornerRadius = UDim.new(0,12)

-- UPDATE LIST
local updates = {
    "• Added Auto Option UI",
    "• Added Teleport Menu",
    "• Added Quest Page",
    "• Added Shop & Trade",
    "• Improved Premium Layout"
}

for i,text in ipairs(updates) do
    local lbl = Instance.new("TextLabel", card)
    lbl.Position = UDim2.new(0, 20, 0, 160 + ((i-1) * 24))
    lbl.Size = UDim2.new(1, -40, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.fromRGB(220,220,220)
    lbl.Text = text
end

--================ OTHER PAGES (DUMMY CARD) ================--
local function dummyPage(name)
    local p = createPage(name)

    local c = Instance.new("Frame", p)
    c.Size = UDim2.new(1, -20, 0, 160)
    c.BackgroundColor3 = Color3.fromRGB(30,36,52)
    c.BorderSizePixel = 0
    Instance.new("UICorner", c).CornerRadius = UDim.new(0,16)

    local lbl = Instance.new("TextLabel", c)
    lbl.Position = UDim2.new(0, 20, 0, 20)
    lbl.Size = UDim2.new(1, -40, 0, 26)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 20
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.Text = name.." Page"
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
    if name ~= "Information" then
        dummyPage(name)
    end

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
        title.Text = name
    end)
end

-- DEFAULT
pages["Information"].Visible = true

--================ DRAG WINDOW ================--
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
