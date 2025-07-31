local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "HackFormHyperGUI"
DeltaGUI.Parent = game.CoreGui
DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = UDim2.new(0, 20, 0.5, -30)
FloatingButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FloatingButton.BackgroundTransparency = 0.3
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://3926305904"
FloatingButton.ImageColor3 = Color3.fromRGB(0, 150, 255)
FloatingButton.Parent = DeltaGUI

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 30)
Corner.Parent = FloatingButton

local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.Size = UDim2.new(0, 280, 0, 300)
MenuFrame.Position = UDim2.new(0, 90, 0.5, -150)
MenuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MenuFrame.BackgroundTransparency = 0.1
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = false
MenuFrame.Parent = DeltaGUI

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 10)
MenuCorner.Parent = MenuFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
TitleBar.BackgroundTransparency = 0.2
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MenuFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "HACK FORM HYPER"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.BackgroundTransparency = 0.3
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 15)
CloseCorner.Parent = CloseButton

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -50)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.Parent = MenuFrame

local function createButton(name, position, text, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -20, 0, 35)
    button.Position = position
    button.BackgroundColor3 = color or Color3.fromRGB(30, 30, 40)
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 12
    button.Font = Enum.Font.Gotham
    button.Parent = ScrollingFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    return button
end

local ESPButton = createButton("ESPButton", UDim2.new(0, 10, 0, 10), "ESP: OFF")
local JumpButton = createButton("JumpButton", UDim2.new(0, 10, 0, 55), "INFINITE JUMP: OFF")
local DeveloperButton = createButton("DeveloperButton", UDim2.new(0, 10, 0, 190), "DEVELOPER", Color3.fromRGB(100, 0, 200))

local SpeedFrame = Instance.new("Frame")
SpeedFrame.Name = "SpeedFrame"
SpeedFrame.Size = UDim2.new(1, -20, 0, 50)
SpeedFrame.Position = UDim2.new(0, 10, 0, 100)
SpeedFrame.BackgroundTransparency = 1
SpeedFrame.Parent = ScrollingFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "SPEED: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SpeedFrame

local SpeedSlider = Instance.new("Frame")
SpeedSlider.Size = UDim2.new(1, 0, 0, 20)
SpeedSlider.Position = UDim2.new(0, 0, 0, 25)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SpeedSlider.BackgroundTransparency = 0.3
SpeedSlider.Parent = SpeedFrame

local SpeedSliderCorner = Instance.new("UICorner")
SpeedSliderCorner.CornerRadius = UDim.new(0, 10)
SpeedSliderCorner.Parent = SpeedSlider

local SpeedFill = Instance.new("Frame")
SpeedFill.Size = UDim2.new(0, 0, 1, 0)
SpeedFill.Position = UDim2.new(0, 0, 0, 0)
SpeedFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SpeedFill.BorderSizePixel = 0
SpeedFill.Parent = SpeedSlider

local SpeedFillCorner = Instance.new("UICorner")
SpeedFillCorner.CornerRadius = UDim.new(0, 10)
SpeedFillCorner.Parent = SpeedFill

local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(1, 0, 1, 0)
SpeedButton.Position = UDim2.new(0, 0, 0, 0)
SpeedButton.BackgroundTransparency = 1
SpeedButton.Text = ""
SpeedButton.Parent = SpeedSlider

local dragging = false
local menuOpen = false
local espEnabled = false
local jumpEnabled = false
local speedEnabled = false
local currentSpeed = 16
local espBoxes = {}

local colors = {
    Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 0, 255), Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 128, 0), Color3.fromRGB(128, 0, 255)
}
local colorIndex = 1

local function updateSpeedDisplay()
    SpeedLabel.Text = "SPEED: "..math.floor(currentSpeed)
    SpeedFill.Size = UDim2.new(currentSpeed/100, 0, 1, 0)
end

local function createESP(player)
    if espBoxes[player] then return end
    
    local espBox = Instance.new("Highlight")
    espBox.Name = player.Name.."_ESP"
    espBox.OutlineColor = Color3.fromRGB(255, 0, 0)
    espBox.FillColor = Color3.fromRGB(255, 0, 0)
    espBox.FillTransparency = 0.8
    espBox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    espBox.Parent = player.Character
    espBox.Adornee = player.Character
    
    espBoxes[player] = espBox
    
    player.CharacterAdded:Connect(function(character)
        espBox.Adornee = character
        espBox.Parent = character
    end)
end

local function removeESP(player)
    if espBoxes[player] then
        espBoxes[player]:Destroy()
        espBoxes[player] = nil
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    ESPButton.Text = "ESP: "..(espEnabled and "ON" or "OFF")
    ESPButton.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
    
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer and player.Character then
                createESP(player)
            end
        end
        
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                if espEnabled then
                    createESP(player)
                end
            end)
        end)
    else
        for player, _ in pairs(espBoxes) do
            removeESP(player)
        end
    end
end

ESPButton.MouseButton1Click:Connect(toggleESP)

JumpButton.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    JumpButton.Text = "INFINITE JUMP: "..(jumpEnabled and "ON" or "OFF")
    JumpButton.BackgroundColor3 = jumpEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
end)

DeveloperButton.MouseButton1Click:Connect(function()
    colorIndex = colorIndex % #colors + 1
    DeveloperButton.BackgroundColor3 = colors[colorIndex]
    if setclipboard then setclipboard("https://t.me/XVSJQ") end
end)

SpeedButton.MouseButton1Down:Connect(function()
    dragging = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local sliderPos = SpeedSlider.AbsolutePosition
        local sliderSize = SpeedSlider.AbsoluteSize
        local relativeX = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
        currentSpeed = math.floor(16 + (relativeX * 34))
        updateSpeedDisplay()
    end
end)

UserInputService.JumpRequest:Connect(function()
    if jumpEnabled and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Heartbeat:Connect(function()
    if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        if speedEnabled then
            Players.LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
        else
            Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local dragStart = input.Position
        local startPos = MenuFrame.Position
        local dragging = true
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
        
        while dragging do
            local delta = input.Position - dragStart
            MenuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            game:GetService("RunService").RenderStepped:Wait()
        end
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MenuFrame.Visible = false
    menuOpen = false
end)

FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MenuFrame.Visible = menuOpen
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        menuOpen = not menuOpen
        MenuFrame.Visible = menuOpen
    end
end)

updateSpeedDisplay()
