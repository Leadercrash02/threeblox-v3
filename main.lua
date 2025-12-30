-- RAY MERCHANT TEST GUI
-- Panel kecil: drag, close, minimize + stock live + auto buy
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

pcall(function()
    local old = CoreGui:FindFirstChild("RayMerchantTest")
    if old then old:Destroy() end
end)

local BG     = Color3.fromRGB(18,20,28)
local CARD   = Color3.fromRGB(28,30,42)
local TEXT   = Color3.fromRGB(235,235,235)
local MUTED  = Color3.fromRGB(160,160,160)
local ACCENT = Color3.fromRGB(170,80,255)

----------------------------------------------------------------
-- DATA / LOGIC
----------------------------------------------------------------
local Replion = require(ReplicatedStorage.Packages.Replion)
local MarketItemData = require(ReplicatedStorage.Shared.MarketItemData)

local merchant = Replion.Client:WaitReplion("Merchant")

local AutoMerchantOn = false
local selectedIds = {}

local function GetCurrentMerchantStock()
    local ids = merchant:GetExpect("Items") or {}
    local list = {}

    for _, id in ipairs(ids) do
        for _, def in ipairs(MarketItemData) do
            if def.Id == id then
                table.insert(list, def)
                break
            end
        end
    end

    return list
end

local function BuyMerchantId(id)
    task.spawn(function()
        pcall(function()
            local rf = ReplicatedStorage
                :WaitForChild("Packages")
                :WaitForChild("_Index")
                :WaitForChild("sleitnick_net@0.2.0")
                :WaitForChild("net")
                :WaitForChild("RF/PurchaseMarketItem")

            rf:InvokeServer(id)
        end)
    end)
end

task.spawn(function()
    while true do
        if AutoMerchantOn then
            local stock = GetCurrentMerchantStock()
            for _, def in ipairs(stock) do
                if selectedIds[def.Id] then
                    BuyMerchantId(def.Id)
                    task.wait(1.5)
                end
            end
        end
        task.wait(0.5)
    end
end)

----------------------------------------------------------------
-- GUI ROOT
----------------------------------------------------------------
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "RayMerchantTest"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 320, 0, 220)
main.Position = UDim2.new(0, 80, 0.5, -110)
main.BackgroundColor3 = BG
main.BackgroundTransparency = 0.08
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local pad = Instance.new("UIPadding", main)
pad.PaddingTop = UDim.new(0, 8)
pad.PaddingBottom = UDim.new(0, 8)
pad.PaddingLeft = UDim.new(0, 8)
pad.PaddingRight = UDim.new(0, 8)

----------------------------------------------------------------
-- HEADER (DRAG + BUTTON)
----------------------------------------------------------------
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 26)
header.BackgroundTransparency = 1
header.Active = true

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = TEXT
title.Text = "Merchant | Test Panel"

local btnClose = Instance.new("TextButton", header)
btnClose.Size = UDim2.new(0, 24, 0, 24)
btnClose.Position = UDim2.new(1, -24, 0, 1)
btnClose.BackgroundColor3 = CARD
btnClose.TextColor3 = TEXT
btnClose.Text = "X"
btnClose.Font = Enum.Font.GothamBold
btnClose.TextSize = 14
btnClose.BackgroundTransparency = 0.1
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(1, 0)

local btnMin = Instance.new("TextButton", header)
btnMin.Size = UDim2.new(0, 24, 0, 24)
btnMin.Position = UDim2.new(1, -52, 0, 1)
btnMin.BackgroundColor3 = CARD
btnMin.TextColor3 = TEXT
btnMin.Text = "-"
btnMin.Font = Enum.Font.GothamBold
btnMin.TextSize = 18
btnMin.BackgroundTransparency = 0.1
Instance.new("UICorner", btnMin).CornerRadius = UDim.new(1, 0)

btnClose.MouseButton1Click:Connect(function()
    if gui and gui.Parent then gui:Destroy() end
end)

-- DRAG MAIN
do
    local dragging, startPos, startMain
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = i.Position
            startMain = main.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - startPos
            main.Position = UDim2.new(
                startMain.X.Scale,
                startMain.X.Offset + delta.X,
                startMain.Y.Scale,
                startMain.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

----------------------------------------------------------------
-- MINI LABEL (MINIMIZE)
----------------------------------------------------------------
local miniBtn = Instance.new("TextButton", gui)
miniBtn.Size = UDim2.new(0, 140, 0, 30)
miniBtn.Position = UDim2.new(0, 20, 0.5, -15)
miniBtn.BackgroundColor3 = CARD
miniBtn.BackgroundTransparency = 0.1
miniBtn.TextColor3 = TEXT
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 12
miniBtn.Text = "Merchant Panel"
miniBtn.Visible = false
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 14)

do
    local dragging, startPos, startMini
    miniBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = i.Position
            startMini = miniBtn.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - startPos
            miniBtn.Position = UDim2.new(
                startMini.X.Scale,
                startMini.X.Offset + delta.X,
                startMini.Y.Scale,
                startMini.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

btnMin.MouseButton1Click:Connect(function()
    main.Visible = false
    miniBtn.Visible = true
end)

miniBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    miniBtn.Visible = false
end)

----------------------------------------------------------------
-- BODY: STOCK + TOGGLE
----------------------------------------------------------------
local body = Instance.new("Frame", main)
body.Position = UDim2.new(0, 0, 0, 30)
body.Size = UDim2.new(1, 0, 1, -30)
body.BackgroundTransparency = 1

local stockTitle = Instance.new("TextLabel", body)
stockTitle.Size = UDim2.new(1, 0, 0, 18)
stockTitle.BackgroundTransparency = 1
stockTitle.Font = Enum.Font.GothamBold
stockTitle.TextSize = 14
stockTitle.TextXAlignment = Enum.TextXAlignment.Left
stockTitle.TextColor3 = TEXT
stockTitle.Text = "Current Merchant Stock"

local stockSub = Instance.new("TextLabel", body)
stockSub.Size = UDim2.new(1, 0, 0, 16)
stockSub.Position = UDim2.new(0, 0, 0, 18)
stockSub.BackgroundTransparency = 1
stockSub.Font = Enum.Font.Gotham
stockSub.TextSize = 12
stockSub.TextXAlignment = Enum.TextXAlignment.Left
stockSub.TextColor3 = MUTED
stockSub.Text = "Available Items (0)"

local list = Instance.new("TextLabel", body)
list.Size = UDim2.new(1, 0, 0, 80)
list.Position = UDim2.new(0, 0, 0, 36)
list.BackgroundColor3 = CARD
list.BackgroundTransparency = 0.15
list.Font = Enum.Font.Code
list.TextSize = 12
list.TextXAlignment = Enum.TextXAlignment.Left
list.TextYAlignment = Enum.TextYAlignment.Top
list.TextColor3 = TEXT
list.TextWrapped = true
list.Text = "-"
Instance.new("UICorner", list).CornerRadius = UDim.new(0, 8)

local autoLabel = Instance.new("TextLabel", body)
autoLabel.Size = UDim2.new(0.6, 0, 0, 18)
autoLabel.Position = UDim2.new(0, 0, 0, 124)
autoLabel.BackgroundTransparency = 1
autoLabel.Font = Enum.Font.Gotham
autoLabel.TextSize = 13
autoLabel.TextXAlignment = Enum.TextXAlignment.Left
autoLabel.TextColor3 = TEXT
autoLabel.Text = "Auto Buy Merchant (ALL current items)"

local pill = Instance.new("TextButton", body)
pill.Size = UDim2.new(0, 70, 0, 24)
pill.Position = UDim2.new(1, -80, 0, 122)
pill.BackgroundColor3 = MUTED
pill.Text = ""
pill.AutoButtonColor = false
pill.BackgroundTransparency = 0
Instance.new("UICorner", pill).CornerRadius = UDim.new(0, 999)

local knob = Instance.new("Frame", pill)
knob.Size = UDim2.new(0, 18, 0, 18)
knob.Position = UDim2.new(0, 3, 0.5, -9)
knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
knob.BackgroundTransparency = 0
Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 999)

local function refreshToggle()
    pill.BackgroundColor3 = AutoMerchantOn and ACCENT or MUTED
    knob.Position = AutoMerchantOn and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
end

pill.MouseButton1Click:Connect(function()
    AutoMerchantOn = not AutoMerchantOn
    refreshToggle()
end)

refreshToggle()

----------------------------------------------------------------
-- REFRESH STOCK TEXT
----------------------------------------------------------------
local function RefreshStockText()
    local stock = GetCurrentMerchantStock()
    stockSub.Text = ("Available Items (%d)"):format(#stock)

    if #stock == 0 then
        list.Text = "No items."
        selectedIds = {}
    else
        local lines = {}
        selectedIds = {}

        for _, def in ipairs(stock) do
            local price = def.Price or 0
            local cur = def.Currency or "Coins"
            table.insert(lines, string.format("- %s (%s %s)", def.Identifier, price, cur))
            selectedIds[def.Id] = true -- test: pilih semua item
        end

        list.Text = table.concat(lines, "\n")
    end
end

RefreshStockText()
merchant:OnChange("Items", RefreshStockText)
