----------------------------------------------------------------
-- AUTO TOTEM (MENU)  | PANEL KANAN MIRIP WEATHER
----------------------------------------------------------------
elseif text == "Auto Totem" then
    list.Padding = UDim.new(0,4)

    _G.RAY_AutoTotemOn    = _G.RAY_AutoTotemOn    or false
    _G.RAY_AutoTotemType  = _G.RAY_AutoTotemType  or "Lucky" -- "Lucky","Mutasi","Shiny"
    _G.RAY_AutoTotemMode  = _G.RAY_AutoTotemMode  or "X1"    -- "X1","X9"

    ----------------------------------------------------------------
    -- ROW JUDUL + TOGGLE (KIRI, SAMA KAYAK WEATHER)
    ----------------------------------------------------------------
    local row = Instance.new("Frame", sub)
    row.Size = UDim2.new(1,0,0,32)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(1,-100,1,0)
    label.Position = UDim2.new(0,16,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = TEXT
    label.Text = "Auto Totem"

    local pill = Instance.new("TextButton", row)
    pill.Size = UDim2.new(0,50,0,24)
    pill.Position = UDim2.new(1,-80,0.5,-12)
    pill.BackgroundColor3 = MUTED
    pill.BackgroundTransparency = 0.1
    pill.Text = ""
    pill.AutoButtonColor = false
    Instance.new("UICorner", pill).CornerRadius = UDim.new(0,999)

    local knob = Instance.new("Frame", pill)
    knob.Size = UDim2.new(0,18,0,18)
    knob.Position = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BackgroundTransparency = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,999)

    local function refreshAutoTotem()
        local on = _G.RAY_AutoTotemOn
        pill.BackgroundColor3 = on and ACCENT or MUTED
        knob.Position = on and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
    end

    pill.MouseButton1Click:Connect(function()
        _G.RAY_AutoTotemOn = not _G.RAY_AutoTotemOn
        refreshAutoTotem()
    end)

    refreshAutoTotem()

    ----------------------------------------------------------------
    -- PANEL KANAN (FLOAT) PERSIS WEATHER: LIST JENIS TOTEM
    ----------------------------------------------------------------
    local panel = Instance.new("Frame", sub)
    panel.AnchorPoint = Vector2.new(1,0)
    panel.Position = UDim2.new(1,-12,0,40) -- kanan atas relatif ke sub
    panel.Size = UDim2.new(0,160,0,110)
    panel.BackgroundColor3 = CARD
    panel.BackgroundTransparency = 0.04
    panel.BorderSizePixel = 0
    panel.ZIndex = 5
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0,8)

    local pad = Instance.new("UIPadding", panel)
    pad.PaddingTop = UDim.new(0,6)
    pad.PaddingLeft = UDim.new(0,6)
    pad.PaddingRight = UDim.new(0,6)
    pad.PaddingBottom = UDim.new(0,6)

    local list2 = Instance.new("UIListLayout", panel)
    list2.Padding = UDim2.new(0,4)
    list2.FillDirection = Enum.FillDirection.Vertical
    list2.SortOrder = Enum.SortOrder.LayoutOrder

    local function makeOption(name)
        local btn = Instance.new("TextButton", panel)
        btn.Size = UDim2.new(1,0,0,24)
        btn.BackgroundColor3 = CARD
        btn.BackgroundTransparency = 0.15
        btn.Text = name
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.TextColor3 = TEXT -- putih, biar jelas
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.ZIndex = 6
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

        -- highlight kuning garis luar (ON kalau kepilih, sama kayak weather)
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(255,230,80)
        stroke.Thickness = 2
        stroke.Enabled = false
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = btn

        btn.MouseButton1Click:Connect(function()
            _G.RAY_AutoTotemType = name
            for _,child in ipairs(panel:GetChildren()) do
                if child:IsA("TextButton") then
                    local s = child:FindFirstChildOfClass("UIStroke")
                    if s then
                        s.Enabled = (child == btn)
                    end
                end
            end
        end)

        return btn
    end

    local btnLucky  = makeOption("Lucky")
    local btnMutasi = makeOption("Mutasi")
    local btnShiny  = makeOption("Shiny")

    -- set highlight awal
    for _,child in ipairs(panel:GetChildren()) do
        if child:IsA("TextButton") then
            local s = child:FindFirstChildOfClass("UIStroke")
            if s then
                s.Enabled = (child.Text == _G.RAY_AutoTotemType)
            end
        end
    end

    ----------------------------------------------------------------
    -- MODE X1 / X9 (ROW DI KIRI, MASIH DALAM SUB)
    ----------------------------------------------------------------
    local modeRow = Instance.new("Frame", sub)
    modeRow.Size = UDim2.new(1,0,0,32)
    modeRow.BackgroundTransparency = 1

    local modeLabel = Instance.new("TextLabel", modeRow)
    modeLabel.Size = UDim2.new(1,-100,1,0)
    modeLabel.Position = UDim2.new(0,16,0,0)
    modeLabel.BackgroundTransparency = 1
    modeLabel.Font = Enum.Font.Gotham
    modeLabel.TextSize = 13
    modeLabel.TextXAlignment = Enum.TextXAlignment.Left
    modeLabel.TextColor3 = TEXT
    modeLabel.Text = "Totem Mode"

    local modeBtn = Instance.new("TextButton", modeRow)
    modeBtn.Size = UDim2.new(0,70,0,24)
    modeBtn.Position = UDim2.new(1,-90,0.5,-12)
    modeBtn.BackgroundColor3 = CARD
    modeBtn.BackgroundTransparency = 0.12
    modeBtn.Text = _G.RAY_AutoTotemMode
    modeBtn.Font = Enum.Font.Gotham
    modeBtn.TextSize = 13
    modeBtn.TextColor3 = TEXT
    modeBtn.AutoButtonColor = false
    Instance.new("UICorner", modeBtn).CornerRadius = UDim.new(0,999)

    modeBtn.MouseButton1Click:Connect(function()
        _G.RAY_AutoTotemMode = (_G.RAY_AutoTotemMode == "X1") and "X9" or "X1"
        modeBtn.Text = _G.RAY_AutoTotemMode
    end)
end
