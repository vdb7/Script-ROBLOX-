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
MenuFrame.Size = UDim2.new(0, 280, 0, 420)
MenuFrame.Position = UDim2.new(0, 90, 0.5, -210)
MenuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MenuFrame.BackgroundTransparency = 0.1
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = false
MenuFrame.Parent = DeltaGUI

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 10)
MenuCorner.Parent = MenuFrame

local ResizeHandle = Instance.new("Frame")
ResizeHandle.Name = "ResizeHandle"
ResizeHandle.Size = UDim2.new(0, 20, 0, 20)
ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
ResizeHandle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ResizeHandle.BorderSizePixel = 0
ResizeHandle.Parent = MenuFrame

local ResizeCorner = Instance.new("UICorner")
ResizeCorner.CornerRadius = UDim.new(0, 10)
ResizeCorner.Parent = ResizeHandle

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

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
MinimizeButton.BackgroundTransparency = 0.3
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TitleBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 15)
MinimizeCorner.Parent = MinimizeButton

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
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 550)
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

local AimbotButton = createButton("AimbotButton", UDim2.new(0, 10, 0, 10), "AIMBOT: OFF")
local ESPButton = createButton("ESPButton", UDim2.new(0, 10, 0, 55), "ESP: OFF")
local BulletTrackButton = createButton("BulletTrackButton", UDim2.new(0, 10, 0, 100), "BULLET TRACK: OFF")
local HeadshotButton = createButton("HeadshotButton", UDim2.new(0, 10, 0, 145), "HEADSHOT: ON", Color3.fromRGB(0, 150, 0))
local SmoothButton = createButton("SmoothButton", UDim2.new(0, 10, 0, 190), "SMOOTH AIM: ON", Color3.fromRGB(0, 150, 0))
local FlyButton = createButton("FlyButton", UDim2.new(0, 10, 0, 235), "FLY: OFF")
local SpeedButton = createButton("SpeedButton", UDim2.new(0, 10, 0, 280), "SPEED: OFF")
local JumpButton = createButton("JumpButton", UDim2.new(0, 10, 0, 415), "INFINITE JUMP: OFF")
local DeveloperButton = createButton("DeveloperButton", UDim2.new(0, 10, 0, 460), "DEVELOPER", Color3.fromRGB(100, 0, 200))

local dragging = false
local resizing = false
local minimized = false
local dragInput, dragStart, startPos
local currentSpeed = 50

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MenuFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        dragStart = input.Position
        startPos = MenuFrame.Size
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                resizing = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MenuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    elseif resizing then
        local delta = input.Position - dragStart
        local newWidth = math.max(200, startPos.X.Offset + delta.X)
        local newHeight = math.max(300, startPos.Y.Offset + delta.Y)
        MenuFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        ScrollingFrame.Size = UDim2.new(1, -10, 1, -50)
    end
end)

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MenuFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 280, 0, 40)}):Play()
        MinimizeButton.Text = "+"
        ScrollingFrame.Visible = false
    else
        TweenService:Create(MenuFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 280, 0, 420)}):Play()
        MinimizeButton.Text = "-"
        ScrollingFrame.Visible = true
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MenuFrame.Visible = false
    menuOpen = false
end)

local menuOpen = false
FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MenuFrame.Visible = menuOpen
    if menuOpen then
        TweenService:Create(MenuFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
    end
end)

local aimbotEnabled = false
local espEnabled = false
local bulletTrackEnabled = false
local headshotEnabled = true
local smoothAimEnabled = true
local flyEnabled = false
local speedEnabled = false
local jumpEnabled = false
local espBoxes = {}

local AdvancedAimbot = {
    TeamCheck = true,
    FOV = 100,
    Prediction = 0.15,
    HitChance = 90,
    AutoShoot = false,
    SilentAim = false,
    TargetPart = "Head",
    Smoothness = 0.15
}

local AdvancedBulletTrack = {
    CurveAmount = 2.5,
    SpeedMultiplier = 1.2,
    Lifetime = 2,
    AutoTrack = true,
    Visualize = true,
    Color = Color3.fromRGB(255, 0, 0)
}

local function isPlayerVisible(player, origin)
    local targetPart = player.Character and player.Character:FindFirstChild(AdvancedAimbot.TargetPart)
    if not targetPart then return false end
    
    local direction = (targetPart.Position - origin).Unit * 1000
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {workspace.CurrentCamera, player.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
    if raycastResult then
        local hitPart = raycastResult.Instance
        local hitCharacter = hitPart:FindFirstAncestorOfClass("Model")
        if hitCharacter and hitCharacter == player.Character then
            return true
        end
    end
    return false
end

local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    local localPlayer = Players.LocalPlayer
    local camera = workspace.CurrentCamera
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            if not AdvancedAimbot.TeamCheck or player.Team ~= localPlayer.Team then
                if isPlayerVisible(player, camera.CFrame.Position) then
                    local character = player.Character
                    local targetPart = character:FindFirstChild(AdvancedAimbot.TargetPart)
                    
                    if targetPart then
                        local distance = (camera.CFrame.Position - targetPart.Position).Magnitude
                        local screenPoint, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                        local fovCheck = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(0.5, 0.5)).Magnitude < (AdvancedAimbot.FOV / 1000)
                        
                        if onScreen and fovCheck and distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

local function applyBulletTrack(bullet, targetPart)
    if not bullet or not targetPart then return end
    
    local startPos = bullet.Position
    local endPos = targetPart.Position + (targetPart.Velocity * AdvancedBulletTrack.Lifetime * AdvancedBulletTrack.Prediction)
    local direction = (endPos - startPos).Unit
    
    local bodyVel = bullet:FindFirstChildOfClass("BodyVelocity") or Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVel.Velocity = direction * (bullet.Velocity.Magnitude * AdvancedBulletTrack.SpeedMultiplier)
    bodyVel.Parent = bullet
    
    if AdvancedBulletTrack.Visualize then
        local beam = Instance.new("Beam")
        beam.Color = ColorSequence.new(AdvancedBulletTrack.Color)
        beam.Width0 = 0.5
        beam.Width1 = 0.5
        beam.FaceCamera = true
        beam.Attachment0 = Instance.new("Attachment")
        beam.Attachment0.Parent = bullet
        beam.Attachment1 = Instance.new("Attachment")
        beam.Attachment1.Parent = targetPart
        beam.Parent = bullet
    end
    
    game:GetService("Debris"):AddItem(bodyVel, AdvancedBulletTrack.Lifetime)
end

AimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotButton.Text = "AIMBOT: "..(aimbotEnabled and "ON" or "OFF")
    AimbotButton.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
end)

ESPButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPButton.Text = "ESP: "..(espEnabled and "ON" or "OFF")
    ESPButton.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
end)

BulletTrackButton.MouseButton1Click:Connect(function()
    bulletTrackEnabled = not bulletTrackEnabled
    BulletTrackButton.Text = "BULLET TRACK: "..(bulletTrackEnabled and "ON" or "OFF")
    BulletTrackButton.BackgroundColor3 = bulletTrackEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
end)

HeadshotButton.MouseButton1Click:Connect(function()
    headshotEnabled = not headshotEnabled
    HeadshotButton.Text = "HEADSHOT: "..(headshotEnabled and "ON" or "OFF")
    HeadshotButton.BackgroundColor3 = headshotEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
    AdvancedAimbot.TargetPart = headshotEnabled and "Head" or "HumanoidRootPart"
end)

SmoothButton.MouseButton1Click:Connect(function()
    smoothAimEnabled = not smoothAimEnabled
    SmoothButton.Text = "SMOOTH AIM: "..(smoothAimEnabled and "ON" or "OFF")
    SmoothButton.BackgroundColor3 = smoothAimEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
    AdvancedAimbot.Smoothness = smoothAimEnabled and 0.15 or 1
end)

FlyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyButton.Text = "FLY: "..(flyEnabled and "ON" or "OFF")
    FlyButton.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
end)

SpeedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    SpeedButton.Text = "SPEED: "..(speedEnabled and "ON" or "OFF")
    SpeedButton.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
end)

JumpButton.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    JumpButton.Text = "INFINITE JUMP: "..(jumpEnabled and "ON" or "OFF")
    JumpButton.BackgroundColor3 = jumpEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
end)

local colors = {
    Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 0, 255), Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 128, 0), Color3.fromRGB(128, 0, 255)
}
local colorIndex = 1

DeveloperButton.MouseButton1Click:Connect(function()
    colorIndex = colorIndex % #colors + 1
    DeveloperButton.BackgroundColor3 = colors[colorIndex]
    if setclipboard then setclipboard("https://t.me/XVSJQ") end
end)

local bodyVelocity = nil
local bodyPosition = nil

local function setupFly()
    local localPlayer = Players.LocalPlayer
    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = localPlayer.Character.HumanoidRootPart
        
        if not bodyVelocity then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = hrp
        end
        
        if not bodyPosition then
            bodyPosition = Instance.new("BodyPosition")
            bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyPosition.Position = hrp.Position
            bodyPosition.Parent = hrp
        end
    end
end

local function removeFly()
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    if bodyPosition then bodyPosition:Destroy() bodyPosition = nil end
end

RunService.RenderStepped:Connect(function()
    local localPlayer = Players.LocalPlayer
    local camera = workspace.CurrentCamera
    
    if aimbotEnabled then
        local closestPlayer = getClosestPlayer()
        if closestPlayer and closestPlayer.Character then
            local targetPart = closestPlayer.Character:FindFirstChild(AdvancedAimbot.TargetPart)
            if targetPart then
                if smoothAimEnabled then
                    local currentCFrame = camera.CFrame
                    local targetCFrame = CFrame.new(camera.CFrame.Position, targetPart.Position + (targetPart.Velocity * AdvancedAimbot.Prediction))
                    camera.CFrame = currentCFrame:Lerp(targetCFrame, AdvancedAimbot.Smoothness)
                else
                    camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position + (targetPart.Velocity * AdvancedAimbot.Prediction))
                end
            end
        end
    end
    
    if bulletTrackEnabled then
        local closestPlayer = getClosestPlayer()
        if closestPlayer and closestPlayer.Character then
            local targetPart = closestPlayer.Character:FindFirstChild(AdvancedAimbot.TargetPart)
            if targetPart then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name:lower():find("bullet") or obj.Name:lower():find("projectile")) then
                        if localPlayer.Character and (obj.Position - localPlayer.Character:GetPivot().Position).Magnitude < 50 then
                            applyBulletTrack(obj, targetPart)
                        end
                    end
                end
            end
        end
    end
    
    if jumpEnabled and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = localPlayer.Character.Humanoid
        if humanoid.Jump then
            local hrp = localPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bodyVel = Instance.new("BodyVelocity")
                bodyVel.MaxForce = Vector3.new(0, math.huge, 0)
                bodyVel.Velocity = Vector3.new(0, 50, 0)
                bodyVel.Parent = hrp
                game:GetService("Debris"):AddItem(bodyVel, 0.3)
            end
        end
    end
    
    if flyEnabled then
        setupFly()
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = localPlayer.Character.HumanoidRootPart
            local moveVector = localPlayer:GetMoveVector()
            
            if bodyPosition then
                bodyPosition.Position = hrp.Position + (camera.CFrame.LookVector * moveVector.Z + camera.CFrame.RightVector * moveVector.X) * 2
            end
        end
    else
        removeFly()
    end
    
    if speedEnabled and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = currentSpeed
    elseif localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        menuOpen = not menuOpen
        MenuFrame.Visible = menuOpen
    end
end)

DeltaGUI.Destroying:Connect(function()
    removeFly()
end)
