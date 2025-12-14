--// THREEBLOX V3 | UI FIX FINAL
--// UI ONLY - SAFE TO MERGE FEATURE LOGIC

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

pcall(function()
    for _,v in ipairs(pg:GetChildren()) do
        if v.Name:find("Threeblox") then v:Destroy() end
    end
end)

-- CONFIG
local LOGO_ID = "rbxassetid://121625492591707"
local BG = Color3.fromRGB(18,18,24)
local SIDE = Color3.fromRGB(22,22,30)
local CARD = Color3.fromRGB(30,30,40)
local TEXT = Color3.fromRGB(230,230,230)
local ACCENT = Color3.fromRGB(160,90,255)

-- GUI
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 820, 0, 460)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,46)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Text = "Threeblox V3 | Auto Option"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = TEXT
title.BackgroundTransparency = 1
title.Position = UDim2.new(0,16,0,0)
title.Size = UDim2.new(1,-120,1,0)
title.TextXAlignment = Left

-- CLOSE
local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0,28,0,28)
close.Position = UDim2.new(1,-36,0.5,-14)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(200,60,60)
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

-- MINIMIZE
local min = Instance.new("TextButton", header)
min.Size = UDim2.new(0,28,0,28)
min.Position = UDim2.new(1,-72,0.5,-14)
min.Text = "-"
min.Font = Enum.Font.GothamBold
min.TextSize = 20
min.TextColor3 = Color3.new(0,0,0)
min.BackgroundColor3 = ACCENT
Instance.new("UICorner", min).CornerRadius = UDim.new(1,0)

-- SIDEBAR
local side = Instance.new("Frame", main)
side.Position = UDim2.new(0,0,0,46)
side.Size = UDim2.new(0,200,1,-46)
side.BackgroundColor3 = SIDE
side.BorderSizePixel = 0

local sideLayout = Instance.new("UIListLayout", side)
sideLayout.Padding = UDim.new(0,8)
sideLayout.HorizontalAlignment = Center
Instance.new("UIPadding", side).PaddingTop = UDim.new(0,12)

local function sideBtn(txt)
    local b = Instance.new("TextButton", side)
    b.Size = UDim2.new(1,-20,0,38)
    b.Text = txt
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = TEXT
    b.BackgroundColor3 = CARD
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    return b
end

sideBtn("Information")
sideBtn("Auto Option")
sideBtn("Teleport")
sideBtn("Quest")
sideBtn("Shop & Trade")
sideBtn("Misc")

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,200,0,46)
content.Size = UDim2.new(1,-200,1,-46)
content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0,10)
Instance.new("UIPadding", content).PaddingTop = UDim.new(0,12)
Instance.new("UIPadding", content).PaddingLeft = UDim.new(0,16)

-- ITEM BUILDER
local function item(icon, text)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.new(1,-32,0,44)
    f.BackgroundColor3 = CARD
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,12)

    local ic = Instance.new("TextLabel", f)
    ic.Text = icon
    ic.Font = Enum.Font.GothamBold
    ic.TextSize = 18
    ic.TextColor3 = ACCENT
    ic.Size = UDim2.new(0,40,1,0)
    ic.BackgroundTransparency = 1

    local t = Instance.new("TextLabel", f)
    t.Text = text
    t.Font = Enum.Font.Gotham
    t.TextSize = 15
    t.TextColor3 = TEXT
    t.Position = UDim2.new(0,44,0,0)
    t.Size = UDim2.new(1,-80,1,0)
    t.BackgroundTransparency = 1
    t.TextXAlignment = Left

    local arrow = Instance.new("TextLabel", f)
    arrow.Text = ">"
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 18
    arrow.TextColor3 = TEXT
    arrow.Size = UDim2.new(0,30,1,0)
    arrow.Position = UDim2.new(1,-30,0,0)
    arrow.BackgroundTransparency = 1

    return f
end

-- AUTO OPTION ITEMS (ICON FIXED)
item("⚙", "Auto Fishing")
item("⭕", "Legit Perfect")
item("🔥", "Blatant Fishing")
item("✏", "Auto Farm Island")
item("🛒", "Auto Favorite")
item("💰", "Auto Sell")
item("➕", "Auto Totem")
item("🧪", "Auto Potion")

-- MINIMIZE LOGO
local mini = Instance.new("ImageButton", gui)
mini.Size = UDim2.new(0,64,0,64)
mini.Position = UDim2.new(0,20,0.5,-32)
mini.Image = LOGO_ID
mini.Visible = false
mini.BackgroundTransparency = 1

-- DRAG FUNCTION
local function makeDrag(obj)
    local drag, start, pos
    obj.InputBegan:Connect(function(i)
        if i.UserInputType == MouseButton1 or i.UserInputType == Touch then
            drag = true
            start = i.Position
            pos = obj.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == MouseMovement or i.UserInputType == Touch) then
            local d = i.Position - start
            obj.Position = UDim2.new(pos.X.Scale,pos.X.Offset+d.X,pos.Y.Scale,pos.Y.Offset+d.Y)
        end
    end)
    UIS.InputEnded:Connect(function()
        drag = false
    end)
end

makeDrag(header)
makeDrag(mini)

-- BUTTON ACTION
min.MouseButton1Click:Connect(function()
    main.Visible = false
    mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
    main.Visible = true
    mini.Visible = false
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
