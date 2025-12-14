--// THREEBLOX V3 | PATCH FULL FINAL
--// SAFE UI ONLY | NO ROBLOX UI DELETED
--// PC + ANDROID SAFE (Xeno / Delta)

--================ SERVICES =================--
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local lp = Players.LocalPlayer

--================ CLEAN ONLY THREEBLOX =================--
pcall(function()
    for _,v in ipairs(CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == "ThreebloxV3" then
            v:Destroy()
        end
    end
end)

--================ CONFIG =================--
local LOGO_ID = "rbxassetid://121625492591707"

local BG     = Color3.fromRGB(18,20,28)
local SIDE   = Color3.fromRGB(22,24,34)
local CARD   = Color3.fromRGB(28,30,42)
local TEXT   = Color3.fromRGB(235,235,235)
local MUTED  = Color3.fromRGB(180,180,180)
local ACCENT = Color3.fromRGB(170,80,255)

--================ ROOT GUI =================--
local gui = Instance.new("ScreenGui")
gui.Name = "ThreebloxV3"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = CoreGui

--================ MINI LOGO =================--
local mini = Instance.new("ImageButton", gui)
mini.Size = UDim2.new(0,56,0,56)
mini.Position = UDim2.new(0,20,0.5,-28)
mini.Image = LOGO_ID
mini.BackgroundColor3 = BG
mini.BorderSizePixel = 0
mini.Visible = false
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

--================ MAIN =================--
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,880,0,500)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

--================ HEADER =================--
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,48)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-120,1,0)
title.Position = UDim2.new(0,16,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = TEXT
title.Text = "Threeblox V3 | Auto Option"

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-72,0.5,-15)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.TextColor3 = Color3.new(0,0,0)
minBtn.BackgroundColor3 = ACCENT
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1,0)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-36,0.5,-15)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = TEXT
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

--================ SIDEBAR =================--
local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.new(0,0,0,48)
sidebar.Size = UDim2.new(0,200,1,-48)
sidebar.BackgroundColor3 = SIDE

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0,8)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,12)

local pages = {}
local currentPage

local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,200,0,48)
content.Size = UDim2.new(1,-200,1,-48)
content.BackgroundTransparency = 1

local function createPage(name)
    local p = Instance.new("Frame", content)
    p.Size = UDim2.new(1,0,1,0)
    p.Visible = false
    p.BackgroundTransparency = 1
    pages[name] = p
    return p
end

local function showPage(name)
    for n,p in pairs(pages) do
        p.Visible = (n == name)
    end
    title.Text = "Threeblox V3 | "..name
end

local function sideBtn(text, emoji)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.new(1,-20,0,38)
    b.Text = emoji.."  "..text
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = TEXT
    b.BackgroundColor3 = CARD
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    b.MouseButton1Click:Connect(function()
        showPage(text)
    end)
end

--================ PAGES =================--
local infoPage   = createPage("Information")
local autoPage   = createPage("Auto Option")
createPage("Teleport")
createPage("Quest")
createPage("Shop & Trade")
createPage("Misc")

--================ AUTO OPTION CONTENT =================--
local scroll = Instance.new("UIListLayout", autoPage)
scroll.Padding = UDim.new(0,10)

Instance.new("UIPadding", autoPage).PaddingLeft = UDim.new(0,16)
Instance.new("UIPadding", autoPage).PaddingTop  = UDim.new(0,16)

local function autoItem(txt, emoji)
    local f = Instance.new("Frame", autoPage)
    f.Size = UDim2.new(1,-32,0,42)
    f.BackgroundColor3 = CARD
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1,-20,1,0)
    t.Position = UDim2.new(0,12,0,0)
    t.BackgroundTransparency = 1
    t.Font = Enum.Font.Gotham
    t.TextSize = 15
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.TextColor3 = TEXT
    t.Text = emoji.."  "..txt
end

autoItem("Auto Fishing", "⚙️")
autoItem("Legit Perfect", "⭕")
autoItem("Blatant Fishing", "🔥")
autoItem("Auto Farm Island", "✏️")
autoItem("Auto Favorite", "🛒")
autoItem("Auto Sell", "💰")
autoItem("Auto Totem", "➕")
autoItem("Auto Potion", "🧪")

--================ SIDEBAR BUTTONS =================--
sideBtn("Information","ℹ️")
sideBtn("Auto Option","⚙️")
sideBtn("Teleport","🗺️")
sideBtn("Quest","📜")
sideBtn("Shop & Trade","🛒")
sideBtn("Misc","⚡")

showPage("Auto Option")

--================ DRAG =================--
local function drag(obj)
    local d,s,p
    obj.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            d=true s=i.Position p=obj.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if d then
            local delta=i.Position-s
            obj.Position=UDim2.new(p.X.Scale,p.X.Offset+delta.X,p.Y.Scale,p.Y.Offset+delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function() d=false end)
end

drag(header)
drag(mini)

--================ BUTTON =================--
minBtn.MouseButton1Click:Connect(function()
    main.Visible=false
    mini.Visible=true
end)

mini.MouseButton1Click:Connect(function()
    main.Visible=true
    mini.Visible=false
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
