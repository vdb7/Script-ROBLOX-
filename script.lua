local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "DeltaGUI"
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
MenuFrame.Size = UDim2.new(0, 250, 0, 300)
MenuFrame.Position = UDim2.new(0, 90, 0.5, -150)
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
TitleLabel.Text = "DELTA HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MenuFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleLabel

local function createButton(name, position, text)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -20, 0, 35)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.Parent = MenuFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    return button
end

local AimbotButton = createButton("AimbotButton", UDim2.new(0, 10, 0, 50), "AIMBOT: OFF")
local ESPButton = createButton("ESPButton", UDim2.new(0, 10, 0, 95), "ESP: OFF")
local BulletTrackButton = createButton("BulletTrackButton", UDim2.new(0, 10, 0, 140), "BULLET TRACK: OFF")
local HeadshotButton = createButton("HeadshotButton", UDim2.new(0, 10, 0, 185), "HEADSHOT: ON")
local SmoothButton = createButton("SmoothButton", UDim2.new(0, 10, 0, 230), "SMOOTH AIM: ON")

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
        MenuFrame.Position = UDim2.new(0, FloatingButton.Position.X.Offset + 70, FloatingButton.Position.Y.Scale, FloatingButton.Position.Y.Offset - 120)
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
local espBoxes = {}

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
    box.Size = Vector3.new(3, 5, 3)
    box.Color3 = player.Team == Players.LocalPlayer.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    box.Transparency = 0.5
    box.Parent = game.CoreGui
    
    espBoxes[player] = box
    
    player.CharacterAdded:Connect(function(newChar)
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
end

local function bulletTrack()
    if not bulletTrackEnabled then return end
    
    local localPlayer = Players.LocalPlayer
    if not localPlayer.Character then return end
    
    local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
    if not tool then return end
    
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local targetPart = player.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local distance = (localPlayer.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude
                if distance < closestDistance and distance < 500 then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    
    if closestPlayer and closestPlayer.Character then
        local targetPart = closestPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetPart then
            local remoteEvents = ReplicatedStorage:GetDescendants()
            for _, remote in ipairs(remoteEvents) do
                if remote:IsA("RemoteEvent") and (remote.Name:lower():find("shoot") or remote.Name:lower():find("fire") or remote.Name:lower():find("bullet")) then
                    remote:FireServer(targetPart.Position, targetPart)
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

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local closestPlayer = nil
        local closestDistance = math.huge
        local localPlayer = Players.LocalPlayer
        local camera = workspace.CurrentCamera
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local targetPart = headshotEnabled and player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
                if targetPart then
                    local screenPoint = camera:WorldToViewportPoint(targetPart.Position)
                    if screenPoint.Z > 0 then
                        local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
        
        if closestPlayer and closestPlayer.Character then
            local targetPart = headshotEnabled and closestPlayer.Character:FindFirstChild("Head") or closestPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                if smoothAimEnabled then
                    local currentCFrame = camera.CFrame
                    local targetCFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
                    camera.CFrame = currentCFrame:Lerp(targetCFrame, 0.3)
                else
                    camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
                end
            end
        end
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

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightControl and not gameProcessed then
        menuOpen = not menuOpen
        MenuFrame.Visible = menuOpen
    end
end)
