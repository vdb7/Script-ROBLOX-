local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local espEnabled = false
local espBoxes = {}
local menuOpen = false
local speedEnabled = false
local currentSpeed = 16
local flyEnabled = false
local flySpeed = 50
local bodyVelocity = nil
local bodyPosition = nil
local bodyAngularVelocity = nil
local noClipEnabled = false
local infiniteJumpEnabled = false
local godModeEnabled = false
local clickTPEnabled = false
local wallHackEnabled = false
local aimBotEnabled = false
local spinBotEnabled = false
local antiAfkEnabled = false
local xRayEnabled = false
local superJumpEnabled = false
local gravityEnabled = false
local fovEnabled = false
local ctrlClickTPEnabled = false

local flyConnection = nil
local noClipConnection = nil
local godModeConnection = nil
local antiAfkConnection = nil
local spinBotConnection = nil
local superJumpConnection = nil

local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "EnhancedHackGUI"
DeltaGUI.Parent = game.CoreGui
DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 50, 0, 50)
FloatingButton.Position = UDim2.new(0, 25, 0.5, -25)
FloatingButton.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
FloatingButton.BackgroundTransparency = 0.1
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://18665684494"
FloatingButton.ImageColor3 = Color3.fromRGB(255, 100, 100)
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
MenuFrame.Size = UDim2.new(0, 320, 0, 600)
MenuFrame.Position = UDim2.new(0, 90, 0.5, -300)
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
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 1200)
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
    pcall(function()
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = currentSpeed
                humanoid.Running:Connect(function()
                    if speedEnabled then
                        humanoid.WalkSpeed = currentSpeed
                    end
                end)
            end
        end
    end)
end

local SpeedToggleButton = createButton("SpeedToggleButton", "SPEED: OFF", nil, "🏃")
SpeedToggleButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    SpeedToggleButton.Text = speedEnabled and "🏃 SPEED: ON" or "🏃 SPEED: OFF"
    SpeedToggleButton.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if speedEnabled then
        setSpeed()
        spawn(function()
            while speedEnabled do
                wait(0.1)
                setSpeed()
            end
        end)
    else
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end)
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

local function setupAdvancedFly()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = LocalPlayer.Character.HumanoidRootPart
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyPosition then bodyPosition:Destroy() end
            if bodyAngularVelocity then bodyAngularVelocity:Destroy() end
            
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = rootPart
            
            bodyPosition = Instance.new("BodyPosition")
            bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyPosition.Position = rootPart.Position
            bodyPosition.D = 700
            bodyPosition.P = 3000
            bodyPosition.Parent = rootPart
            
            bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
            bodyAngularVelocity.Parent = rootPart
            
            if humanoid then
                humanoid.PlatformStand = true
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            end
            
            flyConnection = RunService.Heartbeat:Connect(function()
                if flyEnabled and LocalPlayer.Character and bodyPosition and bodyVelocity then
                    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                    local camera = workspace.CurrentCamera
                    local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    
                    if humanoid and rootPart then
                        local moveVector = humanoid.MoveDirection
                        local lookDirection = camera.CFrame.LookVector
                        local rightDirection = camera.CFrame.RightVector
                        
                        local currentPos = bodyPosition.Position
                        local targetVelocity = Vector3.new(0, 0, 0)
                        
                        if moveVector.Magnitude > 0 then
                            local direction = (lookDirection * -moveVector.Z) + (rightDirection * moveVector.X)
                            direction = Vector3.new(direction.X, 0, direction.Z).Unit
                            targetVelocity = direction * flySpeed
                            bodyPosition.Position = currentPos + (direction * 0.5)
                        end
                        
                        bodyVelocity.Velocity = targetVelocity
                        
                        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                            if part:IsA("BasePart") and part ~= rootPart then
                                part.Velocity = Vector3.new(0, 0, 0)
                            end
                        end
                    end
                end
            end)
        end
    end)
end

local function removeFly()
    pcall(function()
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
                humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
        end
        
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        if bodyPosition then bodyPosition:Destroy() bodyPosition = nil end
        if bodyAngularVelocity then bodyAngularVelocity:Destroy() bodyAngularVelocity = nil end
    end)
end

local FlyButton = createButton("FlyButton", "FLY: OFF", nil, "✈️")
FlyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyButton.Text = flyEnabled and "✈️ FLY: ON" or "✈️ FLY: OFF"
    FlyButton.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if flyEnabled then
        setupAdvancedFly()
    else
        removeFly()
    end
end)

UserInputService.JumpRequest:Connect(function()
    if flyEnabled and bodyPosition then
        pcall(function()
            bodyPosition.Position = bodyPosition.Position + Vector3.new(0, 16, 0)
        end)
    elseif infiniteJumpEnabled then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    elseif superJumpEnabled then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local bodyVel = Instance.new("BodyVelocity")
                bodyVel.MaxForce = Vector3.new(0, math.huge, 0)
                bodyVel.Velocity = Vector3.new(0, 100, 0)
                bodyVel.Parent = LocalPlayer.Character.HumanoidRootPart
                
                game:GetService("Debris"):AddItem(bodyVel, 0.5)
            end
        end)
    end
end)

local function setupAdvancedNoClip()
    if noClipConnection then
        noClipConnection:Disconnect()
    end
    
    noClipConnection = RunService.Stepped:Connect(function()
        if noClipEnabled then
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                            part.Velocity = Vector3.new(0, 0, 0)
                            part.RotVelocity = Vector3.new(0, 0, 0)
                        end
                    end
                end
            end)
        end
    end)
end

local NoClipButton = createButton("NoClipButton", "NOCLIP: OFF", nil, "👻")
NoClipButton.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    NoClipButton.Text = noClipEnabled and "👻 NOCLIP: ON" or "👻 NOCLIP: OFF"
    NoClipButton.BackgroundColor3 = noClipEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if noClipEnabled then
        setupAdvancedNoClip()
    else
        if noClipConnection then
            noClipConnection:Disconnect()
            noClipConnection = nil
        end
        
        pcall(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end)
    end
end)

local function setupAdvancedInfiniteJump()
    if superJumpConnection then
        superJumpConnection:Disconnect()
    end
    
    superJumpConnection = UserInputService.JumpRequest:Connect(function()
        if infiniteJumpEnabled then
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    local humanoid = LocalPlayer.Character.Humanoid
                    humanoid.JumpHeight = 50
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    
                    wait(0.1)
                    humanoid.JumpHeight = 7.2
                end
            end)
        end
    end)
end

local InfiniteJumpButton = createButton("InfiniteJumpButton", "INF JUMP: OFF", nil, "🦘")
InfiniteJumpButton.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    InfiniteJumpButton.Text = infiniteJumpEnabled and "🦘 INF JUMP: ON" or "🦘 INF JUMP: OFF"
    InfiniteJumpButton.BackgroundColor3 = infiniteJumpEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    setupAdvancedInfiniteJump()
end)

local function setupAdvancedGodMode()
    if godModeConnection then
        godModeConnection:Disconnect()
    end
    
    godModeConnection = RunService.Heartbeat:Connect(function()
        if godModeEnabled then
            pcall(function()
                if LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.MaxHealth = math.huge
                        humanoid.Health = math.huge
                        humanoid.PlatformStand = false
                        
                        local forceField = LocalPlayer.Character:FindFirstChild("ForceField")
                        if not forceField then
                            forceField = Instance.new("ForceField")
                            forceField.Parent = LocalPlayer.Character
                            forceField.Visible = false
                        end
                    end
                end
            end)
        end
    end)
end

local GodModeButton = createButton("GodModeButton", "GOD MODE: OFF", nil, "🛡️")
GodModeButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    GodModeButton.Text = godModeEnabled and "🛡️ GOD MODE: ON" or "🛡️ GOD MODE: OFF"
    GodModeButton.BackgroundColor3 = godModeEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if godModeEnabled then
        setupAdvancedGodMode()
    else
        if godModeConnection then
            godModeConnection:Disconnect()
            godModeConnection = nil
        end
        
        pcall(function()
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = 100
                    humanoid.Health = 100
                end
                
                local forceField = LocalPlayer.Character:FindFirstChild("ForceField")
                if forceField then
                    forceField:Destroy()
                end
            end
        end)
    end
end)

local function createESP(player)
    pcall(function()
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
    end)
end

local function removeESP(player)
    pcall(function()
        if espBoxes[player] then
            espBoxes[player]:Destroy()
            espBoxes[player] = nil
        end
    end)
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
    pcall(function()
        if Lighting.Brightness == 1 then
            Lighting.Brightness = 5
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
            Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
            BrightButton.Text = "💡 FULLBRIGHT: ON"
            BrightButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        else
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
            Lighting.Ambient = Color3.fromRGB(70, 70, 70)
            Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
            Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
            BrightButton.Text = "💡 FULLBRIGHT: OFF"
            BrightButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        end
    end)
end)

local HealthButton = createButton("HealthButton", "MAX HEALTH: OFF", nil, "❤️")
HealthButton.MouseButton1Click:Connect(function()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            local humanoid = LocalPlayer.Character.Humanoid
            humanoid.MaxHealth = 2500
            humanoid.Health = 2500
            HealthButton.Text = "❤️ HEALTH: 2500"
            HealthButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        end
    end)
end)

local TeleportButton = createButton("TeleportButton", "TELEPORT TO PLAYERS", nil, "📍")
TeleportButton.MouseButton1Click:Connect(function()
    pcall(function()
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
end)

local ClickTPButton = createButton("ClickTPButton", "CLICK TP: OFF", nil, "🖱️")
ClickTPButton.MouseButton1Click:Connect(function()
    clickTPEnabled = not clickTPEnabled
    ClickTPButton.Text = clickTPEnabled and "🖱️ CLICK TP: ON" or "🖱️ CLICK TP: OFF"
    ClickTPButton.BackgroundColor3 = clickTPEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
end)

local CtrlClickTPButton = createButton("CtrlClickTPButton", "CTRL+CLICK TP: OFF", nil, "⌨️")
CtrlClickTPButton.MouseButton1Click:Connect(function()
    ctrlClickTPEnabled = not ctrlClickTPEnabled
    CtrlClickTPButton.Text = ctrlClickTPEnabled and "⌨️ CTRL+CLICK TP: ON" or "⌨️ CTRL+CLICK TP: OFF"
    CtrlClickTPButton.BackgroundColor3 = ctrlClickTPEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
end)

local XRayButton = createButton("XRayButton", "X-RAY: OFF", nil, "🔍")
XRayButton.MouseButton1Click:Connect(function()
    xRayEnabled = not xRayEnabled
    XRayButton.Text = xRayEnabled and "🔍 X-RAY: ON" or "🔍 X-RAY: OFF"
    XRayButton.BackgroundColor3 = xRayEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    pcall(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
                if xRayEnabled then
                    obj.Transparency = 0.7
                else
                    obj.Transparency = 0
                end
            end
        end
    end)
end)

local SuperJumpButton = createButton("SuperJumpButton", "SUPER JUMP: OFF", nil, "🚀")
SuperJumpButton.MouseButton1Click:Connect(function()
    superJumpEnabled = not superJumpEnabled
    SuperJumpButton.Text = superJumpEnabled and "🚀 SUPER JUMP: ON" or "🚀 SUPER JUMP: OFF"
    SuperJumpButton.BackgroundColor3 = superJumpEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
end)

local GravityButton = createButton("GravityButton", "LOW GRAVITY: OFF", nil, "🌙")
GravityButton.MouseButton1Click:Connect(function()
    gravityEnabled = not gravityEnabled
    GravityButton.Text = gravityEnabled and "🌙 LOW GRAVITY: ON" or "🌙 LOW GRAVITY: OFF"
    GravityButton.BackgroundColor3 = gravityEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    pcall(function()
        workspace.Gravity = gravityEnabled and 50 or 196.2
    end)
end)

local FOVButton = createButton("FOVButton", "FOV CHANGER: OFF", nil, "📷")
FOVButton.MouseButton1Click:Connect(function()
    fovEnabled = not fovEnabled
    FOVButton.Text = fovEnabled and "📷 FOV: 120" or "📷 FOV: OFF"
    FOVButton.BackgroundColor3 = fovEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    pcall(function()
        Camera.FieldOfView = fovEnabled and 120 or 70
    end)
end)

local AimBotButton = createButton("AimBotButton", "AIMBOT: OFF", nil, "🎯")
AimBotButton.MouseButton1Click:Connect(function()
    aimBotEnabled = not aimBotEnabled
    AimBotButton.Text = aimBotEnabled and "🎯 AIMBOT: ON" or "🎯 AIMBOT: OFF"
    AimBotButton.BackgroundColor3 = aimBotEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if aimBotEnabled then
        spawn(function()
            while aimBotEnabled do
                pcall(function()
                    local closestPlayer = nil
                    local shortestDistance = math.huge
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.Head.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                closestPlayer = player
                            end
                        end
                    end
                    
                    if closestPlayer then
                        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
                    end
                end)
                wait(0.1)
            end
        end)
    end
end)

local SpinBotButton = createButton("SpinBotButton", "SPINBOT: OFF", nil, "🌀")
SpinBotButton.MouseButton1Click:Connect(function()
    spinBotEnabled = not spinBotEnabled
    SpinBotButton.Text = spinBotEnabled and "🌀 SPINBOT: ON" or "🌀 SPINBOT: OFF"
    SpinBotButton.BackgroundColor3 = spinBotEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if spinBotEnabled then
        if spinBotConnection then
            spinBotConnection:Disconnect()
        end
        
        spinBotConnection = RunService.Heartbeat:Connect(function()
            if spinBotEnabled then
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
                    end
                end)
            end
        end)
    else
        if spinBotConnection then
            spinBotConnection:Disconnect()
            spinBotConnection = nil
        end
    end
end)

local AntiAFKButton = createButton("AntiAFKButton", "ANTI-AFK: OFF", nil, "⏰")
AntiAFKButton.MouseButton1Click:Connect(function()
    antiAfkEnabled = not antiAfkEnabled
    AntiAFKButton.Text = antiAfkEnabled and "⏰ ANTI-AFK: ON" or "⏰ ANTI-AFK: OFF"
    AntiAFKButton.BackgroundColor3 = antiAfkEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if antiAfkEnabled then
        antiAfkConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            pcall(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end)
    else
        if antiAfkConnection then
            antiAfkConnection:Disconnect()
            antiAfkConnection = nil
        end
    end
end)

local WallHackButton = createButton("WallHackButton", "WALLHACK: OFF", nil, "🧱")
WallHackButton.MouseButton1Click:Connect(function()
    wallHackEnabled = not wallHackEnabled
    WallHackButton.Text = wallHackEnabled and "🧱 WALLHACK: ON" or "🧱 WALLHACK: OFF"
    WallHackButton.BackgroundColor3 = wallHackEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    pcall(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:lower():find("wall") then
                obj.Transparency = wallHackEnabled and 0.8 or 0
                obj.CanCollide = not wallHackEnabled
            end
        end
    end)
end)

local ResetButton = createButton("ResetButton", "RESET CHARACTER", Color3.fromRGB(255, 70, 70), "💀")
ResetButton.MouseButton1Click:Connect(function()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Health = 0
        end
    end)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        pcall(function()
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local mouse = LocalPlayer:GetMouse()
                
                if clickTPEnabled then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position)
                    end
                elseif ctrlClickTPEnabled and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position)
                    end
                end
            end
        end)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(MenuFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0, 245, 0.5, 0)
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
        MenuFrame.Position = UDim2.new(0, 245, 0.5, 0)
        MenuFrame.Visible = true
        TweenService:Create(MenuFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 320, 0, 600),
            Position = UDim2.new(0, 90, 0.5, -300)
        }):Play()
    else
        TweenService:Create(MenuFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, 245, 0.5, 0)
        }):Play()
    end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1)
    pcall(function()
        character:WaitForChild("Humanoid")
        
        if speedEnabled then
            setSpeed()
        end
        
        if flyEnabled then
            wait(1)
            setupAdvancedFly()
        end
        
        if infiniteJumpEnabled then
            setupAdvancedInfiniteJump()
        end
        
        if godModeEnabled then
            setupAdvancedGodMode()
        end
        
        if noClipEnabled then
            setupAdvancedNoClip()
        end
        
        if gravityEnabled then
            workspace.Gravity = 50
        end
        
        if fovEnabled then
            Camera.FieldOfView = 120
        end
    end)
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

if espEnabled then
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createESP(player)
        end
    end
end

spawn(function()
    while wait(5) do
        if espEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and not espBoxes[player] then
                    createESP(player)
                end
            end
        end
    end
end)
