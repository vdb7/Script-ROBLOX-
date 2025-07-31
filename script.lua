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

local SpeedSliderFrame = Instance.new("Frame")
SpeedSliderFrame.Name = "SpeedSliderFrame"
SpeedSliderFrame.Size = UDim2.new(1, -20, 0, 60)
SpeedSliderFrame.Position = UDim2.new(0, 10, 0, 325)
SpeedSliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SpeedSliderFrame.BackgroundTransparency = 0.3
SpeedSliderFrame.BorderSizePixel = 0
SpeedSliderFrame.Visible = false
SpeedSliderFrame.Parent = ScrollingFrame

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 8)
SliderCorner.Parent = SpeedSliderFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 5)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 50"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Parent = SpeedSliderFrame

local SpeedSlider = Instance.new("Frame")
SpeedSlider.Name = "SpeedSlider"
SpeedSlider.Size = UDim2.new(1, -20, 0, 20)
SpeedSlider.Position = UDim2.new(0, 10, 0, 30)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SpeedSlider.BorderSizePixel = 0
SpeedSlider.Parent = SpeedSliderFrame

local SliderBarCorner = Instance.new("UICorner")
SliderBarCorner.CornerRadius = UDim.new(0, 10)
SliderBarCorner.Parent = SpeedSlider

local SpeedHandle = Instance.new("TextButton")
SpeedHandle.Name = "SpeedHandle"
SpeedHandle.Size = UDim2.new(0, 20, 1, 0)
SpeedHandle.Position = UDim2.new(0, 0, 0, 0)
SpeedHandle.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SpeedHandle.BorderSizePixel = 0
SpeedHandle.Text = ""
SpeedHandle.Parent = SpeedSlider

local HandleCorner = Instance.new("UICorner")
HandleCorner.CornerRadius = UDim.new(0, 10)
HandleCorner.Parent = SpeedHandle

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

local speedDragging = false
SpeedHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        speedDragging = true
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                speedDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if speedDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local sliderPos = SpeedSlider.AbsolutePosition.X
        local sliderSize = SpeedSlider.AbsoluteSize.X
        local mouseX = input.Position.X
        local relativeX = math.max(0, math.min(sliderSize - 20, mouseX - sliderPos))
        
        SpeedHandle.Position = UDim2.new(0, relativeX, 0, 0)
        currentSpeed = math.floor(50 + (relativeX / (sliderSize - 20)) * 450)
        SpeedLabel.Text = "Speed: " .. currentSpeed
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

local function isPlayerVisible(player, camera)
    if not player.Character then return false end
    local targetPart = headshotEnabled and player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
    if not targetPart then return false end
    
    local origin = camera.CFrame.Position
    local direction = (targetPart.Position - origin).Unit * 1000
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {camera, player.Character}
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
            if isPlayerVisible(player, camera) then
                local character = player.Character
                local targetPart = headshotEnabled and character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
                
                if targetPart and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (localPlayer.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude
                    if distance < 1000 and distance < closestDistance then
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
        for _, espData in pairs(espBoxes) do
            if espData and espData.box then espData.box:Destroy() end
            if espData and espData.nameTag then espData.nameTag:Destroy() end
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
    SpeedSliderFrame.Visible = speedEnabled
    
    if speedEnabled then
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    else
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 550)
    end
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
    if espBoxes[player] then 
        if espBoxes[player].box then espBoxes[player].box:Destroy() end
        if espBoxes[player].nameTag then espBoxes[player].nameTag:Destroy() end
    end
    
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
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    if bodyPosition then bodyPosition:Destroy() bodyPosition = nil end
end

local function bulletTrack()
    if not bulletTrackEnabled then return end
    
    local localPlayer = Players.LocalPlayer
    if not localPlayer.Character then return end
    
    local closestPlayer = getClosestPlayer()
    if closestPlayer and closestPlayer.Character then
        local targetPart = headshotEnabled and closestPlayer.Character:FindFirstChild("Head") or closestPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetPart then
            local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                spawn(function()
                    wait(0.1)
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and (obj.Name:lower():find("bullet") or obj.Name:lower():find("projectile")) then
                            if (obj.Position - tool.Handle.Position).Magnitude < 50 then
                                local bodyVel = obj:FindFirstChildOfClass("BodyVelocity") or Instance.new("BodyVelocity")
                                bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                bodyVel.Parent = obj
                                
                                local direction = (targetPart.Position - obj.Position).Unit
                                bodyVel.Velocity = direction * 1000
                                
                                spawn(function()
                                    wait(2)
                                    if bodyVel and bodyVel.Parent then
                                        bodyVel:Destroy()
                                    end
                                end)
                            end
                        end
                    end
                end)
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
    
    player.CharacterRemoving:Connect(function()
        if espBoxes[player] then
            if espBoxes[player].box then espBoxes[player].box:Destroy() end
            if espBoxes[player].nameTag then espBoxes[player].nameTag:Destroy() end
            espBoxes[player] = nil
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    if espBoxes[player] then
        if espBoxes[player].box then espBoxes[player].box:Destroy() end
        if espBoxes[player].nameTag then espBoxes[player].nameTag:Destroy() end
        espBoxes[player] = nil
    end
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
        local closestPlayer = getClosestPlayer()
        local camera = workspace.CurrentCamera
        
        if closestPlayer and closestPlayer.Character then
            local targetPart = headshotEnabled and closestPlayer.Character:FindFirstChild("Head") or closestPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                if smoothAimEnabled then
                    local currentCFrame = camera.CFrame
                    local targetCFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
                    camera.CFrame = currentCFrame:Lerp(targetCFrame, 0.15)
                else
                    camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
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
        localPlayer.Character.Humanoid.WalkSpeed = currentSpeed
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
        
        if player.Character then
            if espEnabled then
                createESP(player)
            end
        end
    end
end

game:GetService("UserInputService").WindowFocused:Connect(function()
    if not MenuFrame.Visible then
        MenuFrame.Visible = true
    end
end)

game:GetService("UserInputService").WindowFocusReleased:Connect(function()
    if MenuFrame.Visible then
        MenuFrame.Visible = false
    end
end)

DeltaGUI.Destroying:Connect(function()
    removeFly()
    for _, espData in pairs(espBoxes) do
        if espData and espData.box then espData.box:Destroy() end
        if espData and espData.nameTag then espData.nameTag:Destroy() end
    end
end)
