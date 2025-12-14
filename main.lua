--// THREEBLOX HUB - FISH IT
--// GUI FINAL - RIGHT VERTICAL TAB (NO ENCHANT, NO SUBTITLE)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

pcall(function()
    if pg:FindFirstChild("ThreebloxHub") then
        pg.ThreebloxHub:Destroy()
    end
end)

-- ROOT
local gui = Instance.new("ScreenGui", pg)
gui.Name = "ThreebloxHub"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

-- MAIN PANEL
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 680, 0, 360)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(20, 24, 34)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)
Instance.new("UIStroke", main).Transparency = 0.7

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, -50, 0, 46)
header.Position = UDim2.new(0, 20, 0, 14)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "Information"
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Left

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 20, 0, 70)
content.Size = UDim2.new(1, -120, 1, -90)
content.BackgroundTransparency = 1

local scroll = Instance.new("ScrollingFrame", content)
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, 360)
scroll.ScrollBarImageTransparency = 0.8
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)

-- INFO CONTENT
local function infoLine(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.TextWrapped = true
    lbl.TextXAlignment = Left
    lbl.TextYAlignment = Center
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 15
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.Text = text
    lbl.Parent = scroll
end

infoLine("⭐ Update : v2.0")
infoLine("• Added Perfection Blatant (Enable Fishing Mode)")
infoLine("• Added Trade By Coin")
infoLine("• Added Fishing Radar")
infoLine("• Added Ignore Favorited Fish (Trade By Rarity)")
infoLine("• Added Auto Favorite (Rarity, Mutation, Fish Name)")
infoLine("• Added Teleport Options")

-- AUTO RESIZE
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

-- RIGHT TAB BAR
local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.new(0, 70, 1, -40)
tabBar.Position = UDim2.new(1, -80, 0, 20)
tabBar.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.Padding = UDim.new(0, 6)
tabLayout.HorizontalAlignment = Center

-- TAB DATA (ENCHANT REMOVED)
local tabs = {
    "Auto Option",
    "Teleport",
    "Misc",
    "Event",
    "Quest",
    "Shop & Trade",
    "Information"
}

local tabButtons = {}
local activeTab

local function createTab(name)
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(26, 30, 42)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(220,220,220)
    btn.AutoButtonColor = false

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(function()
        if activeTab then
            TweenService:Create(activeTab, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(26,30,42)
            }):Play()
        end
        activeTab = btn
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 191, 0)
        }):Play()
        title.Text = name
    end)

    tabButtons[name] = btn
end

for _,name in ipairs(tabs) do
    createTab(name)
end

-- DEFAULT TAB
task.wait()
tabButtons["Information"]:Activate()

-- DRAG
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
