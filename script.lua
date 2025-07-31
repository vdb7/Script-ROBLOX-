local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
FloatingButton.Image = "rbxassetid://75797852451386"
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

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
TitleLabel.BackgroundTransparency = 0.2
TitleLabel.BorderSizePixel = 0
TitleLabel.Text = "HACK FORM HYPER"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MenuFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleLabel

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -50)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
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
local JumpButton = createButton("JumpButton", UDim2.new(0, 10, 0, 325), "INFINITE JUMP: OFF")
local DeveloperButton = createButton("DeveloperButton", UDim2.new(0, 10, 0, 370), "DEVELOPER", Color3.fromRGB(100, 0, 200))

local dragging = false
local dragInput, dragStart, startPos

FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = FloatingButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

FloatingButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        FloatingButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        MenuFrame.Position = UDim2.new(0, FloatingButton.Position.X.Offset + 70, FloatingButton.Position.Y.Scale, FloatingButton.Position.Y.Offset - 180)
    end
end)

local menuOpen = false
FloatingButton.MouseButton1Click:Connect(function()
    if not dragging then
        menuOpen = not menuOpen
        MenuFrame.Visible = menuOpen
        if menuOpen then
            TweenService:Create(MenuFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
        end
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
local currentSpeed = 16

local function getClosestPlayerInFOV()
    local closestPlayer = nil
    local closestDistance = math.huge
    local localPlayer = Players.LocalPlayer
    local camera = workspace.CurrentCamera
    local screenCenter = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local character = player.Character
            local targetPart = headshotEnabled and character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
            
            if targetPart then
                local screenPoint, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                if onScreen and screenPoint.Z > 0 then
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - screenCenter).Magnitude
                    if distance < 200 and distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer
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
    
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer and player.Character then
                createESP(player)
            end
        end
    else
        for _, box in pairs(espBoxes) do
            if box then box:Destroy() end
        end
        espBoxes = {}
    end
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
end)

SmoothButton.MouseButton1Click:Connect(function()
    smoothAimEnabled = not smoothAimEnabled
    SmoothButton.Text = "SMOOTH AIM: "..(smoothAimEnabled and "ON" or "OFF")
    SmoothButton.BackgroundColor3 = smoothAimEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
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
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0), 
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 128, 0),
    Color3.fromRGB(128, 0, 255)
}
local colorIndex = 1

DeveloperButton.MouseButton1Click:Connect(function()
    colorIndex = colorIndex % #colors + 1
    DeveloperButton.BackgroundColor3 = colors[colorIndex]
    
    if setclipboard then
        setclipboard("https://t.me/XVSJQ")
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Developer Contact";
        Text = "Telegram: @XVSJQ copied to clipboard!";
        Duration = 3;
    })
end)

function createESP(player)
    if espBoxes[player] then espBoxes[player]:Destroy() end
    
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESP_"..player.Name
    box.Adornee = humanoidRootPart
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Size = Vector3.new(4, 6, 4)
    box.Color3 = Color3.fromRGB(255, 0, 0)
    box.Transparency = 0.3
    box.Parent = workspace
    
    local nameTag = Instance.new("BillboardGui")
    nameTag.Name = "NameTag"
    nameTag.Parent = humanoidRootPart
    nameTag.Size = UDim2.new(0, 100, 0, 50)
    nameTag.AlwaysOnTop = true
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = nameTag
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    
    espBoxes[player] = {box = box, nameTag = nameTag}
    
    player.CharacterAdded:Connect(function(newChar)
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
end

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
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyPosition then
        bodyPosition:Destroy()
        bodyPosition = nil
    end
end

local function bulletTrack()
    if not bulletTrackEnabled then return end
    
    local localPlayer = Players.LocalPlayer
    if not localPlayer.Character then return end
    
    local closestPlayer = getClosestPlayerInFOV()
    if closestPlayer and closestPlayer.Character then
        local targetPart = headshotEnabled and closestPlayer.Character:FindFirstChild("Head") or closestPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetPart then
            local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then
                local remoteEvents = ReplicatedStorage:GetDescendants()
                for _, remote in ipairs(remoteEvents) do
                    if remote:IsA("RemoteEvent") then
                        local name = remote.Name:lower()
                        if name:find("shoot") or name:find("fire") or name:find("bullet") or name:find("hit") then
                            pcall(function()
                                remote:FireServer(targetPart.Position, targetPart, closestPlayer.Character)
                            end)
                        end
                    end
                end
                
                local workspace_bullets = workspace:GetChildren()
                for _, obj in ipairs(workspace_bullets) do
                    if obj.Name:lower():find("bullet") or obj.Name:lower():find("projectile") then
                        if obj:IsA("BasePart") then
                            local bodyVel = obj:FindFirstChildOfClass("BodyVelocity")
                            if not bodyVel then
                                bodyVel = Instance.new("BodyVelocity")
                                bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                bodyVel.Parent = obj
                            end
                            
                            local direction = (targetPart.Position - obj.Position).Unit
                            bodyVel.Velocity = direction * 500
                        end
                    end
                end
            end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.RightControl then
        menuOpen = not menuOpen
        MenuFrame.Visible = menuOpen
    end
end)

RunService.RenderStepped:Connect(function()
    local localPlayer = Players.LocalPlayer
    
    if aimbotEnabled then
        local closestPlayer = getClosestPlayerInFOV()
        local camera = workspace.CurrentCamera
        
        if closestPlayer and closestPlayer.Character then
            local targetPart = headshotEnabled and closestPlayer.Character:FindFirstChild("Head") or closestPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                if smoothAimEnabled then
                    local currentCFrame = camera.CFrame
                    local targetCFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
                    camera.CFrame = currentCFrame:Lerp(targetCFrame, 0.2)
                else
                    camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
                end
            end
        end
    end
    
    if jumpEnabled and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = localPlayer.Character.Humanoid
        if humanoid.Jump and humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
            local hrp = localPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bodyVel = hrp:FindFirstChild("InfiniteJumpVel")
                
                if not bodyVel then
                    bodyVel = Instance.new("BodyVelocity")
                    bodyVel.Name = "InfiniteJumpVel"
                    bodyVel.MaxForce = Vector3.new(0, math.huge, 0)
                    bodyVel.Parent = hrp
                end
                
                bodyVel.Velocity = Vector3.new(0, 50, 0)
                
                game:GetService("Debris"):AddItem(bodyVel, 0.3)
            end
        end
    end
    
    if flyEnabled then
        setupFly()
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = localPlayer.Character.HumanoidRootPart
            local camera = workspace.CurrentCamera
            local moveVector = localPlayer:GetMoveVector()
            
            if bodyPosition then
                bodyPosition.Position = hrp.Position + (camera.CFrame.LookVector * moveVector.Z + camera.CFrame.RightVector * moveVector.X) * 2
            end
        end
    else
        removeFly()
    end
    
    if speedEnabled and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = 50
    elseif localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = 16
    end
    
    bulletTrack()
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then
        player.CharacterAdded:Connect(function(char)
            if espEnabled then
                wait(1)
                createESP(player)
            end
        end)
        if player.Character and espEnabled then
            createESP(player)
        end
    end
end
