----------------------------------------------------------------
-- SHOP & TRADE : TRAVELING MERCHANT (DROPDOWN + PANEL KANAN)
----------------------------------------------------------------
local function BuildShopMerchant()
    local shopPage = pages["Shop & Trade"]

    ----------------------------------------------------------------
    -- DATA / LOGIC
    ----------------------------------------------------------------
    local Replion        = require(ReplicatedStorage.Packages.Replion)
    local MarketItemData = require(ReplicatedStorage.Shared.MarketItemData)
    local merchant       = Replion.Client:WaitReplion("Merchant")

    local AutoMerchantOn = false
    local selectedIds    = {}   -- id -> true
    local Quantity       = 1

    local function GetCurrentMerchantStock()
        local ids  = merchant:GetExpect("Items") or {}
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

    local function BuyMerchantIdOnce(id)
        pcall(function()
            local rf = ReplicatedStorage
                :WaitForChild("Packages")
                :WaitForChild("_Index")
                :WaitForChild("sleitnick_net@0.2.0")
                :WaitForChild("net")
                :WaitForChild("RF/PurchaseMarketItem")

            rf:InvokeServer(id)
        end)
    end

    ----------------------------------------------------------------
    -- POSISI CARD MERCHANT DI BAWAH BAIT
    ----------------------------------------------------------------
    local baitCard = shopPage:WaitForChild("BaitSelectorCard", 5)
    local baseY = baitCard
        and (baitCard.Position.Y.Offset + baitCard.Size.Y.Offset + 12)
        or 120

    ----------------------------------------------------------------
    -- CARD MERCHANT (DROPDOWN)
    ----------------------------------------------------------------
    local card = Instance.new("Frame")
    card.Name = "MerchantCard"
    card.Parent = shopPage
    card.Size = UDim2.new(1, -32, 0, 48)
    card.Position = UDim2.new(0, 16, 0, baseY)
    card.BackgroundColor3 = CARD
    card.BackgroundTransparency = ALPHA_CARD
    card.ClipsDescendants = true
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)

    local pad = Instance.new("UIPadding", card)
    pad.PaddingTop    = UDim.new(0, 8)
    pad.PaddingLeft   = UDim.new(0, 16)
    pad.PaddingRight  = UDim.new(0, 16)
    pad.PaddingBottom = UDim.new(0, 8)

    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1, -40, 0, 22)
    title.Position = UDim2.new(0, 16, 0, 4)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamSemibold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextColor3 = TEXT
    title.Text = "🛒 Traveling Merchant"

    local arrow = Instance.new("TextLabel", card)
    arrow.Size = UDim2.new(0, 24, 0, 24)
    arrow.Position = UDim2.new(1, -28, 0, 10)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.Gotham
    arrow.TextSize = 18
    arrow.TextColor3 = TEXT
    arrow.Text = "▼"

    local cardBtn = Instance.new("TextButton", card)
    cardBtn.BackgroundTransparency = 1
    cardBtn.Size = UDim2.new(1, 0, 1, 0)
    cardBtn.Text = ""
    cardBtn.AutoButtonColor = false

    -- container isi dropdown
    local subMerchant = Instance.new("Frame", card)
    subMerchant.Name = "MerchantContents"
    subMerchant.Position = UDim2.new(0, 0, 0, 48)
    subMerchant.Size = UDim2.new(1, 0, 0, 0)
    subMerchant.BackgroundTransparency = 1
    subMerchant.ClipsDescendants = true

    local merchantLayout = Instance.new("UIListLayout", subMerchant)
    merchantLayout.Padding = UDim.new(0, 6)
    merchantLayout.FillDirection = Enum.FillDirection.Vertical
    merchantLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    merchantLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local merchantOpen = false
    local function recalcMerchant()
        local h = merchantLayout.AbsoluteContentSize.Y
        if merchantOpen then
            subMerchant.Size = UDim2.new(1, 0, 0, h + 8)
            card.Size = UDim2.new(1, -32, 0, 48 + h + 8)
            arrow.Text = "▲"
        else
            subMerchant.Size = UDim2.new(1, 0, 0, 0)
            card.Size = UDim2.new(1, -32, 0, 48)
            arrow.Text = "▼"
        end
    end

    cardBtn.MouseButton1Click:Connect(function()
        merchantOpen = not merchantOpen
        recalcMerchant()
    end)

    ----------------------------------------------------------------
    -- ISI DROPDOWN: STOCK, REFRESH, SELECT, QUANTITY
    ----------------------------------------------------------------
    -- ROW: CURRENT STOCK
    local rowStock = Instance.new("Frame", subMerchant)
    rowStock.Size = UDim2.new(1, 0, 0, 36)
    rowStock.BackgroundTransparency = 1

    local stockLabel = Instance.new("TextLabel", rowStock)
    stockLabel.Size = UDim2.new(1, 0, 0, 18)
    stockLabel.Position = UDim2.new(0, 0, 0, 0)
    stockLabel.BackgroundTransparency = 1
    stockLabel.Font = Enum.Font.GothamBold
    stockLabel.TextSize = 14
    stockLabel.TextXAlignment = Enum.TextXAlignment.Left
    stockLabel.TextColor3 = TEXT
    stockLabel.Text = "Current Merchant Stock"

    local stockLine = Instance.new("TextLabel", rowStock)
    stockLine.Size = UDim2.new(1, 0, 0, 16)
    stockLine.Position = UDim2.new(0, 0, 0, 18)
    stockLine.BackgroundTransparency = 1
    stockLine.Font = Enum.Font.Gotham
    stockLine.TextSize = 12
    stockLine.TextXAlignment = Enum.TextXAlignment.Left
    stockLine.TextColor3 = MUTED
    stockLine.Text = "None"

    -- ROW: REFRESH STOCK
    local rowRefresh = Instance.new("Frame", subMerchant)
    rowRefresh.Size = UDim2.new(1, 0, 0, 32)
    rowRefresh.BackgroundColor3 = CARD
    rowRefresh.BackgroundTransparency = 0.1
    Instance.new("UICorner", rowRefresh).CornerRadius = UDim.new(0, 8)

    local refreshBtn = Instance.new("TextButton", rowRefresh)
    refreshBtn.Size = UDim2.new(1, 0, 1, 0)
    refreshBtn.BackgroundTransparency = 1
    refreshBtn.Font = Enum.Font.GothamSemibold
    refreshBtn.TextSize = 13
    refreshBtn.TextColor3 = TEXT
    refreshBtn.Text = "Refresh Stock"
    refreshBtn.AutoButtonColor = false

    -- ROW: SELECT ITEMS TO BUY
    local rowSelect = Instance.new("Frame", subMerchant)
    rowSelect.Size = UDim2.new(1, 0, 0, 36)
    rowSelect.BackgroundColor3 = CARD
    rowSelect.BackgroundTransparency = 0.1
    Instance.new("UICorner", rowSelect).CornerRadius = UDim.new(0, 8)

    local lblSelect = Instance.new("TextLabel", rowSelect)
    lblSelect.Size = UDim2.new(0.5, 0, 1, 0)
    lblSelect.Position = UDim2.new(0, 12, 0, 0)
    lblSelect.BackgroundTransparency = 1
    lblSelect.Font = Enum.Font.Gotham
    lblSelect.TextSize = 13
    lblSelect.TextXAlignment = Enum.TextXAlignment.Left
    lblSelect.TextColor3 = TEXT
    lblSelect.Text = "Select Items to Buy"

    local selectedHint = Instance.new("TextLabel", rowSelect)
    selectedHint.Size = UDim2.new(0.5, -32, 1, 0)
    selectedHint.Position = UDim2.new(0.5, 0, 0, 0)
    selectedHint.BackgroundTransparency = 1
    selectedHint.Font = Enum.Font.Gotham
    selectedHint.TextSize = 12
    selectedHint.TextXAlignment = Enum.TextXAlignment.Right
    selectedHint.TextColor3 = MUTED
    selectedHint.Text = "Select Options"

    local chevron = Instance.new("TextLabel", rowSelect)
    chevron.Size = UDim2.new(0, 20, 1, 0)
    chevron.Position = UDim2.new(1, -20, 0, 0)
    chevron.BackgroundTransparency = 1
    chevron.Font = Enum.Font.Gotham
    chevron.TextSize = 16
    chevron.TextColor3 = TEXT
    chevron.Text = "▾"

    local selectBtn = Instance.new("TextButton", rowSelect)
    selectBtn.BackgroundTransparency = 1
    selectBtn.Size = UDim2.new(1, 0, 1, 0)
    selectBtn.Text = ""
    selectBtn.AutoButtonColor = false

    -- ROW: QUANTITY + AUTO BUY
    local rowBottom = Instance.new("Frame", subMerchant)
    rowBottom.Size = UDim2.new(1, 0, 0, 36)
    rowBottom.BackgroundTransparency = 1

    local qtyBox = Instance.new("TextBox", rowBottom)
    qtyBox.Size = UDim2.new(0, 60, 0, 28)
    qtyBox.Position = UDim2.new(0, 0, 0, 4)
    qtyBox.BackgroundColor3 = CARD
    qtyBox.TextColor3 = TEXT
    qtyBox.Font = Enum.Font.GothamSemibold
    qtyBox.TextSize = 14
    qtyBox.Text = "1"
    qtyBox.ClearTextOnFocus = false
    qtyBox.TextXAlignment = Enum.TextXAlignment.Center
    Instance.new("UICorner", qtyBox).CornerRadius = UDim.new(0, 8)

    local qtySub = Instance.new("TextLabel", rowBottom)
    qtySub.Size = UDim2.new(0, 140, 1, 0)
    qtySub.Position = UDim2.new(0, 70, 0, 0)
    qtySub.BackgroundTransparency = 1
    qtySub.Font = Enum.Font.Gotham
    qtySub.TextSize = 11
    qtySub.TextXAlignment = Enum.TextXAlignment.Left
    qtySub.TextColor3 = MUTED
    qtySub.Text = "Items Quantity"

    local autoLabel = Instance.new("TextLabel", rowBottom)
    autoLabel.Size = UDim2.new(0.4, 0, 1, 0)
    autoLabel.Position = UDim2.new(0.4, 0, 0, 0)
    autoLabel.BackgroundTransparency = 1
    autoLabel.Font = Enum.Font.Gotham
    autoLabel.TextSize = 13
    autoLabel.TextXAlignment = Enum.TextXAlignment.Left
    autoLabel.TextColor3 = TEXT
    autoLabel.Text = "Auto Buy Merchant"

    local autoPill = Instance.new("TextButton", rowBottom)
    autoPill.Size = UDim2.new(0, 50, 0, 24)
    autoPill.Position = UDim2.new(1, -60, 0.5, -12)
    autoPill.BackgroundColor3 = MUTED
    autoPill.Text = ""
    autoPill.AutoButtonColor = false
    Instance.new("UICorner", autoPill).CornerRadius = UDim.new(0, 999)

    local autoKnob = Instance.new("Frame", autoPill)
    autoKnob.Size = UDim2.new(0, 18, 0, 18)
    autoKnob.Position = UDim2.new(0, 3, 0.5, -9)
    autoKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", autoKnob).CornerRadius = UDim.new(0, 999)

    ----------------------------------------------------------------
    -- QUANTITY INPUT
    ----------------------------------------------------------------
    qtyBox:GetPropertyChangedSignal("Text"):Connect(function()
        local n = tonumber(qtyBox.Text)
        if not n then
            qtyBox.Text = tostring(Quantity)
            return
        end
        n = math.clamp(math.floor(n), 1, 99)
        Quantity = n
        qtyBox.Text = tostring(n)
    end)

    ----------------------------------------------------------------
    -- STOCK TEXT + SELECTED IDS
    ----------------------------------------------------------------
    local function RefreshStockTextAndSelected()
        local stock = GetCurrentMerchantStock()
        stockLabel.Text = "Current Merchant Stock"

        if #stock == 0 then
            stockLine.Text = "No items."
            selectedIds = {}
            selectedHint.Text = "Select Options"
        else
            local names = {}
            selectedIds = {}

            for _, def in ipairs(stock) do
                table.insert(names, def.Identifier)
                selectedIds[def.Id] = true
            end

            stockLine.Text = table.concat(names, ", ")
            selectedHint.Text = "All current items"
        end
    end

    RefreshStockTextAndSelected()
    merchant:OnChange("Items", RefreshStockTextAndSelected)

    ----------------------------------------------------------------
    -- PANEL KANAN PILIH ITEM
    ----------------------------------------------------------------
    local overlay = Instance.new("TextButton")
    overlay.Name = "MerchantOverlay"
    overlay.Parent = shopPage
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.Text = ""
    overlay.Visible = false
    overlay.ZIndex = 4
    overlay.AutoButtonColor = false

    local panel = Instance.new("Frame")
    panel.Name = "MerchantItemPanel"
    panel.Parent = overlay
    panel.Size = UDim2.new(0, 220, 0, 230)
    panel.AnchorPoint = Vector2.new(1, 0.5)
    panel.Position = UDim2.new(1, -24, 0.52, 0)
    panel.BackgroundColor3 = CARD
    panel.BackgroundTransparency = 0.04
    panel.Visible = false
    panel.ZIndex = 5
    panel.Active = true
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)

    local pPad = Instance.new("UIPadding", panel)
    pPad.PaddingTop    = UDim.new(0, 8)
    pPad.PaddingLeft   = UDim.new(0, 8)
    pPad.PaddingRight  = UDim.new(0, 8)
    pPad.PaddingBottom = UDim.new(0, 8)

    local pTitle = Instance.new("TextLabel", panel)
    pTitle.Size = UDim2.new(1, 0, 0, 20)
    pTitle.BackgroundTransparency = 1
    pTitle.Font = Enum.Font.GothamBold
    pTitle.TextSize = 13
    pTitle.TextXAlignment = Enum.TextXAlignment.Left
    pTitle.TextColor3 = TEXT
    pTitle.Text = "Select Items"

    local scroller = Instance.new("ScrollingFrame", panel)
    scroller.Position = UDim2.new(0, 0, 0, 24)
    scroller.Size = UDim2.new(1, 0, 1, -24)
    scroller.ScrollBarThickness = 6
    scroller.ScrollingDirection = Enum.ScrollingDirection.Y
    scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroller.BackgroundTransparency = 1
    scroller.ZIndex = 6
    scroller.Active = true

    local scLayout = Instance.new("UIListLayout", scroller)
    scLayout.Padding = UDim.new(0, 4)
    scLayout.SortOrder = Enum.SortOrder.LayoutOrder
    scLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroller.CanvasSize = UDim2.new(0, 0, 0, scLayout.AbsoluteContentSize.Y + 8)
    end)

    local function updateSelectedHint()
        local names = {}
        local stock = GetCurrentMerchantStock()
        for _, def in ipairs(stock) do
            if selectedIds[def.Id] then
                table.insert(names, def.Identifier or tostring(def.Id))
            end
        end
        if #names == 0 then
            selectedHint.Text = "Select Options"
        else
            selectedHint.Text = table.concat(names, ", ")
        end
    end

    local function rebuildItemPanel()
        for _, c in ipairs(scroller:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end

        local stock = GetCurrentMerchantStock()
        if #stock == 0 then
            local empty = Instance.new("TextLabel", scroller)
            empty.Size = UDim2.new(1, 0, 0, 20)
            empty.BackgroundTransparency = 1
            empty.Font = Enum.Font.Gotham
            empty.TextSize = 12
            empty.TextColor3 = MUTED
            empty.TextXAlignment = Enum.TextXAlignment.Left
            empty.Text = "No items."
        else
            for _, def in ipairs(stock) do
                local id   = def.Id
                local name = def.Identifier or ("Item "..tostring(id))

                local b = Instance.new("TextButton", scroller)
                b.Size = UDim2.new(1, 0, 0, 26)
                b.BackgroundColor3 = CARD
                b.BackgroundTransparency = selectedIds[id] and 0.08 or 0.18
                b.Font = Enum.Font.Gotham
                b.TextSize = 12
                b.TextXAlignment = Enum.TextXAlignment.Left
                b.TextColor3 = TEXT
                b.Text = "  "..name
                b.AutoButtonColor = false
                b.ZIndex = 6
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

                local highlight = Instance.new("Frame")
                highlight.Name = "Highlight"
                highlight.Parent = b
                highlight.AnchorPoint = Vector2.new(0, 0.5)
                highlight.Position = UDim2.new(0, 0, 0.5, 0)
                highlight.Size = UDim2.new(0, 3, 1, -6)
                highlight.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
                highlight.BackgroundTransparency = selectedIds[id] and 0 or 1
                highlight.ZIndex = 7

                b.MouseButton1Click:Connect(function()
                    selectedIds[id] = not selectedIds[id]
                    b.BackgroundTransparency = selectedIds[id] and 0.08 or 0.18
                    highlight.BackgroundTransparency = selectedIds[id] and 0 or 1
                    updateSelectedHint()
                end)
            end
        end
    end

    rebuildItemPanel()
    merchant:OnChange("Items", function()
        RefreshStockTextAndSelected()
        rebuildItemPanel()
        updateSelectedHint()
    end)

    ----------------------------------------------------------------
    -- OPEN/CLOSE PANEL PILIH ITEM
    ----------------------------------------------------------------
    local panelOpen = false
    local function setPanelOpen(state)
        panelOpen = state
        overlay.Visible = panelOpen
        panel.Visible   = panelOpen
    end

    selectBtn.MouseButton1Click:Connect(function()
        rebuildItemPanel()
        updateSelectedHint()
        setPanelOpen(not panelOpen)
    end)

    overlay.MouseButton1Click:Connect(function()
        setPanelOpen(false)
    end)

    ----------------------------------------------------------------
    -- TOGGLE AUTO BUY + LOOP (PAKAI Quantity)
    ----------------------------------------------------------------
    local function refreshAutoToggle()
        autoPill.BackgroundColor3 = AutoMerchantOn and ACCENT or MUTED
        autoKnob.Position = AutoMerchantOn
            and UDim2.new(1, -21, 0.5, -9)
            or  UDim2.new(0, 3, 0.5, -9)
    end

    autoPill.MouseButton1Click:Connect(function()
        AutoMerchantOn = not AutoMerchantOn
        refreshAutoToggle()
    end)

    refreshAutoToggle()
    recalcMerchant()

    task.spawn(function()
        while true do
            if AutoMerchantOn then
                local stock = GetCurrentMerchantStock()
                for _, def in ipairs(stock) do
                    if selectedIds[def.Id] then
                        for i = 1, Quantity do
                            BuyMerchantIdOnce(def.Id)
                            task.wait(0.35)
                        end
                    end
                end
            end
            task.wait(0.5)
        end
    end)

    ----------------------------------------------------------------
    -- LISTEN BAIT CHANGES & REPOSITION MERCHANT
    ----------------------------------------------------------------
    local function updateMerchantPosition()
        local bait = shopPage:FindFirstChild("BaitSelectorCard")
        if bait then
            local newY = bait.Position.Y.Offset + bait.Size.Y.Offset + 12
            card.Position = UDim2.new(0, 16, 0, newY)
        end
    end

    local baitConn
    if baitCard then
        baitConn = baitCard:GetPropertyChangedSignal("Size"):Connect(updateMerchantPosition)
        baitCard:GetPropertyChangedSignal("Position"):Connect(updateMerchantPosition)
    end
    updateMerchantPosition()

    -- CLEANUP
    card.AncestryChanged:Connect(function()
        if not card.Parent then
            if baitConn then baitConn:Disconnect() end
            overlay:Destroy()
        end
    end)
end

BuildShopMerchant()
