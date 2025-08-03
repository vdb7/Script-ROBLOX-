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
local speedEnabled = false
local currentSpeed = 16
local flyEnabled = false
local flySpeed = 50
local bodyVelocity = nil
local bodyAngularVelocity = nil
local noClipEnabled = false
local infiniteJumpEnabled = false

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
FloatingButton.Image = "rbxassetid://18665684494"
FloatingButton.ImageColor3 = Color3.fromRGB(0, 220, 255)
FloatingButton.Parent = DeltaGUI

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 25)
Corner.Parent = FloatingButton

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 100, 100)
Stroke.Thickness = 2
Stroke.Transparency = 0.3
Stroke.Parent = FloatingButton

local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.Size = UDim2.new(0, 300, 0, 500)
MenuFrame.Position = UDim2.new(0, 90, 0.5, -250)
MenuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MenuFrame.BackgroundTransparency = 0.05
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
TitleBar.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
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
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 100)
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
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart
        
        bodyAngularVelocity = Instance.new("BodyAngularVelocity")
        bodyAngularVelocity.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
        bodyAngularVelocity.Parent = rootPart
    end
end

local function removeFly()
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyAngularVelocity then
        bodyAngularVelocity:Destroy()
        bodyAngularVelocity = nil
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

local NoClipButton = createButton("NoClipButton", "NOCLIP: OFF", nil, "👻")
NoClipButton.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    NoClipButton.Text = noClipEnabled and "👻 NOCLIP: ON" or "👻 NOCLIP: OFF"
    NoClipButton.BackgroundColor3 = noClipEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
end)

local InfiniteJumpButton = createButton("InfiniteJumpButton", "INF JUMP: OFF", nil, "🦘")
InfiniteJumpButton.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    InfiniteJumpButton.Text = infiniteJumpEnabled and "🦘 INF JUMP: ON" or "🦘 INF JUMP: OFF"
    InfiniteJumpButton.BackgroundColor3 = infiniteJumpEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpHeight = infiniteJumpEnabled and math.huge or 7.2
    end
end)

local TeleportButton = createButton("TeleportButton", "TELEPORT TO PLAYERS", nil, "📍")
TeleportButton.MouseButton1Click:Connect(function()
    local players = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(players, player)
        end
    end
    
    if #players > 0 then
        local targetPlayer = players[math.random(1, #players)]
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        end
    end
end)

local HealthButton = createButton("HealthButton", "MAX HEALTH: OFF", nil, "❤️")
HealthButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        humanoid.MaxHealth = 2500
        humanoid.Health = 2500
        HealthButton.Text = "❤️ HEALTH: 2500"
        HealthButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end
end)

local GodModeButton = createButton("GodModeButton", "GOD MODE: OFF", nil, "🛡️")
local godModeEnabled = false
GodModeButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    GodModeButton.Text = godModeEnabled and "🛡️ GOD MODE: ON" or "🛡️ GOD MODE: OFF"
    GodModeButton.BackgroundColor3 = godModeEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if godModeEnabled then
            LocalPlayer.Character.Humanoid.MaxHealth = math.huge
            LocalPlayer.Character.Humanoid.Health = math.huge
        else
            LocalPlayer.Character.Humanoid.MaxHealth = 100
            LocalPlayer.Character.Humanoid.Health = 100
        end
    end
end)

local ResetButton = createButton("ResetButton", "RESET CHARACTER", Color3.fromRGB(255, 70, 70), "💀")
ResetButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end)

local ClickTPButton = createButton("ClickTPButton", "CLICK TP: OFF", nil, "🖱️")
local clickTPEnabled = false
ClickTPButton.MouseButton1Click:Connect(function()
    clickTPEnabled = not clickTPEnabled
    ClickTPButton.Text = clickTPEnabled and "🖱️ CLICK TP: ON" or "🖱️ CLICK TP: OFF"
    ClickTPButton.BackgroundColor3 = clickTPEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
end)

UserInputService.InputBegan:Connect(function(input)
    if clickTPEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local hit = game.Players.LocalPlayer:GetMouse().Hit
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hit.Position)
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if flyEnabled and bodyVelocity then
        local currentVel = bodyVelocity.Velocity
        bodyVelocity.Velocity = Vector3.new(currentVel.X, flySpeed, currentVel.Z)
        wait(0.3)
        if bodyVelocity then
            bodyVelocity.Velocity = Vector3.new(currentVel.X, 0, currentVel.Z)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and bodyVelocity then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        local camera = workspace.CurrentCamera
        
        if humanoid then
            local moveVector = humanoid.MoveDirection
            
            if moveVector.Magnitude > 0 then
                local cameraDirection = (camera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                local rightVector = camera.CFrame.RightVector
                
                local direction = (cameraDirection * -moveVector.Z) + (rightVector * moveVector.X)
                bodyVelocity.Velocity = Vector3.new(direction.X * flySpeed, bodyVelocity.Velocity.Y, direction.Z * flySpeed)
            else
                bodyVelocity.Velocity = Vector3.new(0, bodyVelocity.Velocity.Y, 0)
            end
        end
    end
    
    if godModeEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
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
            Size = UDim2.new(0, 300, 0, 500),
            Position = UDim2.new(0, 90, 0.5, -250)
        }):Play()
    else
        TweenService:Create(MenuFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, 225, 0.5, 0)
        }):Play()
    end
end)

RunService.Stepped:Connect(function()
    if noClipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
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
    if infiniteJumpEnabled then
        character.Humanoid.JumpHeight = math.huge
    end
    if godModeEnabled then
        character.Humanoid.MaxHealth = math.huge
        character.Humanoid.Health = math.huge
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
