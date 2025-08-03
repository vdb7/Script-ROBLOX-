local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local espEnabled = false
local espBoxes = {}
local menuOpen = false
local isDragging = false
local speedEnabled = false
local currentSpeed = 16
local flyEnabled = false
local bodyVelocity = nil
local bodyPosition = nil

local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "EnhancedHackGUI"
DeltaGUI.Parent = game.CoreGui
DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 50, 0, 50)
FloatingButton.Position = UDim2.new(0, 25, 0.5, -25)
FloatingButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
FloatingButton.BackgroundTransparency = 0.1
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://3926305904"
FloatingButton.ImageColor3 = Color3.fromRGB(0, 220, 255)
FloatingButton.Parent = DeltaGUI

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 25)
Corner.Parent = FloatingButton

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 220, 255)
Stroke.Thickness = 2
Stroke.Transparency = 0.3
Stroke.Parent = FloatingButton

local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.Size = UDim2.new(0, 300, 0, 400)
MenuFrame.Position = UDim2.new(0, 90, 0.5, -200)
MenuFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MenuFrame.BackgroundTransparency = 0.02
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = false
MenuFrame.Parent = DeltaGUI

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 15)
MenuCorner.Parent = MenuFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
TitleBar.BackgroundTransparency = 0.05
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MenuFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "CONSOLE GUI"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.BackgroundTransparency = 0.15
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 15)
CloseCorner.Parent = CloseButton

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -55)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 45)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
ScrollingFrame.Parent = MenuFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.Parent = ScrollingFrame

local function createButton(name, text, color, icon)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -20, 0, 40)
    button.BackgroundColor3 = color or Color3.fromRGB(45, 45, 65)
    button.BackgroundTransparency = 0.15
    button.BorderSizePixel = 0
    button.Text = (icon or "🔧") .. " " .. text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.GothamSemibold
    button.Parent = ScrollingFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.05,
            TextSize = 15
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.15,
            TextSize = 14
        }):Play()
    end)
    
    return button
end

local SpeedFrame = Instance.new("Frame")
SpeedFrame.Name = "SpeedFrame"
SpeedFrame.Size = UDim2.new(1, -20, 0, 65)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
SpeedFrame.BackgroundTransparency = 0.25
SpeedFrame.BorderSizePixel = 0
SpeedFrame.Parent = ScrollingFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 10)
SpeedCorner.Parent = SpeedFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 5)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "SPEED: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.GothamSemibold
SpeedLabel.Parent = SpeedFrame

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0.5, -5, 0, 25)
SpeedBox.Position = UDim2.new(0, 5, 0, 30)
SpeedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.Text = "16"
SpeedBox.Font = Enum.Font.GothamSemibold
SpeedBox.TextSize = 12
SpeedBox.Parent = SpeedFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = SpeedBox

local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0.4, -5, 0, 25)
SpeedButton.Position = UDim2.new(0.5, 5, 0, 30)
SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
SpeedButton.Text = "APPLY"
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.Font = Enum.Font.GothamBold
SpeedButton.TextSize = 12
SpeedButton.Parent = SpeedFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = SpeedButton

local function setSpeed()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
    end
end

local SpeedToggleButton = createButton("SpeedToggleButton", "SPEED: OFF", nil, "🏃")
SpeedToggleButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    SpeedToggleButton.Text = speedEnabled and "🏃 SPEED: ON" or "🏃 SPEED: OFF"
    SpeedToggleButton.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if speedEnabled then
        setSpeed()
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

SpeedButton.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(SpeedBox.Text)
    if newSpeed and newSpeed >= 16 and newSpeed <= 500 then
        currentSpeed = newSpeed
        SpeedLabel.Text = "SPEED: " .. currentSpeed
        
        if speedEnabled then
            setSpeed()
        end
    else
        SpeedBox.Text = tostring(currentSpeed)
    end
end)

local function createESP(player)
    if espBoxes[player] or not player.Character then return end
    
    local espBox = Instance.new("Highlight")
    espBox.Name = player.Name.."_ESP"
    espBox.OutlineColor = Color3.fromRGB(255, 120, 120)
    espBox.FillColor = Color3.fromRGB(255, 120, 120)
    espBox.FillTransparency = 0.65
    espBox.OutlineTransparency = 0.25
    espBox.Parent = player.Character
    espBox.Adornee = player.Character
    
    espBoxes[player] = espBox
end

local function removeESP(player)
    if espBoxes[player] then
        espBoxes[player]:Destroy()
        espBoxes[player] = nil
    end
end

local ESPButton = createButton("ESPButton", "ESP: OFF", nil, "👁️")
ESPButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPButton.Text = espEnabled and "👁️ ESP: ON" or "👁️ ESP: OFF"
    ESPButton.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                createESP(player)
            end
        end
    else
        for player, _ in pairs(espBoxes) do
            removeESP(player)
        end
    end
end)

local BrightButton = createButton("BrightButton", "FULLBRIGHT: OFF", nil, "💡")
BrightButton.MouseButton1Click:Connect(function()
    if Lighting.Brightness == 1 then
        Lighting.Brightness = 5
        Lighting.GlobalShadows = false
        BrightButton.Text = "💡 FULLBRIGHT: ON"
        BrightButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        BrightButton.Text = "💡 FULLBRIGHT: OFF"
        BrightButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    end
end)

local function setupFly()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart
        
        bodyPosition = Instance.new("BodyPosition")
        bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyPosition.Position = rootPart.Position
        bodyPosition.D = 500
        bodyPosition.P = 3000
        bodyPosition.Parent = rootPart
    end
end

local function removeFly()
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyPosition then
        bodyPosition:Destroy()
        bodyPosition = nil
    end
end

local FlyButton = createButton("FlyButton", "FLY: OFF", nil, "✈️")
FlyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyButton.Text = flyEnabled and "✈️ FLY: ON" or "✈️ FLY: OFF"
    FlyButton.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if flyEnabled then
        setupFly()
    else
        removeFly()
    end
end)

UserInputService.JumpRequest:Connect(function()
    if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and bodyPosition then
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        bodyPosition.Position = bodyPosition.Position + Vector3.new(0, 16, 0)
    end
end)

RunService.Heartbeat:Connect(function()
    if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and bodyPosition then
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        local camera = workspace.CurrentCamera
        
        if humanoid then
            local moveVector = humanoid.MoveDirection
            local cameraDirection = camera.CFrame.LookVector
            local rightVector = camera.CFrame.RightVector
            
            local direction = (cameraDirection * moveVector.Z) + (rightVector * moveVector.X)
            
            if direction.Magnitude > 0 then
                bodyPosition.Position = bodyPosition.Position + (direction * 0.5)
            end
        end
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(MenuFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0, 225, 0.5, 0)
    })
    tween:Play()
    tween.Completed:Connect(function()
        MenuFrame.Visible = false
        menuOpen = false
    end)
end)

FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if menuOpen then
        MenuFrame.Size = UDim2.new(0, 0, 0, 0)
        MenuFrame.Position = UDim2.new(0, 225, 0.5, 0)
        MenuFrame.Visible = true
        TweenService:Create(MenuFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 300, 0, 400),
            Position = UDim2.new(0, 90, 0.5, -200)
        }):Play()
    else
        TweenService:Create(MenuFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, 225, 0.5, 0)
        }):Play()
    end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    if speedEnabled then
        setSpeed()
    end
    if flyEnabled then
        wait(1)
        setupFly()
    end
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
end)

if espEnabled then
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createESP(player)
        end
    end
end
