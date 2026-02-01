
-- LocalScript

--== GUI SETUP ==--
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FishSpyGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 420, 0, 260)
Frame.Position = UDim2.new(0.5, -210, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(18, 20, 28)

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, -40, 0, 24)
Title.Position = UDim2.new(0, 8, 0, 4)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "FishIt Remote Spy"

-- Close button
local CloseBtn = Instance.new("TextButton", Frame)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -28, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Log box
local LogBox = Instance.new("TextBox", Frame)
LogBox.Size = UDim2.new(1, -16, 1, -64)
LogBox.Position = UDim2.new(0, 8, 0, 32)
LogBox.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
LogBox.TextXAlignment = Enum.TextXAlignment.Left
LogBox.TextYAlignment = Enum.TextYAlignment.Top
LogBox.MultiLine = true
LogBox.ClearTextOnFocus = false
LogBox.Font = Enum.Font.Code
LogBox.TextSize = 13
LogBox.TextWrapped = false
LogBox.TextEditable = false
LogBox.TextColor3 = Color3.fromRGB(220, 220, 220)
LogBox.Text = ""

Instance.new("UICorner", LogBox).CornerRadius = UDim.new(0, 6)

-- Copy button
local CopyBtn = Instance.new("TextButton", Frame)
CopyBtn.Size = UDim2.new(0, 120, 0, 26)
CopyBtn.Position = UDim2.new(0, 8, 1, -30)
CopyBtn.BackgroundColor3 = Color3.fromRGB(60, 150, 220)
CopyBtn.Text = "Copy to clipboard"
CopyBtn.Font = Enum.Font.Gotham
CopyBtn.TextSize = 13
CopyBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 6)

CopyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(LogBox.Text)
    end
end)

-- Draggable
local dragging, dragStart, startPos
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
    end
end)

Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

--== SPY LOGIC ==--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NetFolder = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_net@0.2.0")
    :WaitForChild("net")

local function append(text)
    LogBox.Text = LogBox.Text .. text .. "\n"
    LogBox.CursorPosition = #LogBox.Text + 1
end

local function hookRemote(remote)
    if remote:IsA("RemoteEvent") then
        local old = remote.FireServer
        remote.FireServer = function(self, ...)
            append(string.format("[RE] %s  |  args: %s", self.Name, tostring(...)))
            return old(self, ...)
        end
    elseif remote:IsA("RemoteFunction") then
        local old = remote.InvokeServer
        remote.InvokeServer = function(self, ...)
            append(string.format("[RF] %s  |  args: %s", self.Name, tostring(...)))
            return old(self, ...)
        end
    end
end

for _, obj in ipairs(NetFolder:GetChildren()) do
    hookRemote(obj)
end

NetFolder.ChildAdded:Connect(hookRemote)

append("[Spy] Ready. Mancing manual dulu, log muncul di sini.")
