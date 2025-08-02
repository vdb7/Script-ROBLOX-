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
local aimbotEnabled = false
local currentSpeed = 16
local aimbotCircle = nil

local function createMainGUI()
    local DeltaGUI = Instance.new("ScreenGui")
    DeltaGUI.Name = "EnhancedHackGUI"
    DeltaGUI.Parent = game.CoreGui
    DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    DeltaGUI.ResetOnSpawn = false
    
    return DeltaGUI
end

local function createFloatingButton(parent)
    local FloatingButton = Instance.new("ImageButton")
    FloatingButton.Name = "FloatingButton"
    FloatingButton.Size = UDim2.new(0, 80, 0, 80)
    FloatingButton.Position = UDim2.new(0, 25, 0.5, -40)
    FloatingButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    FloatingButton.BackgroundTransparency = 0.1
    FloatingButton.BorderSizePixel = 0
    FloatingButton.Image = "rbxassetid://3926305904"
    FloatingButton.ImageColor3 = Color3.fromRGB(0, 220, 255)
    FloatingButton.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 40)
    Corner.Parent = FloatingButton
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 220, 255)
    Stroke.Thickness = 3
    Stroke.Transparency = 0.3
    Stroke.Parent = FloatingButton
    
    local Glow = Instance.new("ImageLabel")
    Glow.Name = "Glow"
    Glow.Size = UDim2.new(1.6, 0, 1.6, 0)
    Glow.Position = UDim2.new(-0.3, 0, -0.3, 0)
    Glow.BackgroundTransparency = 1
    Glow.Image = "rbxassetid://241650934"
    Glow.ImageColor3 = Color3.fromRGB(0, 220, 255)
    Glow.ImageTransparency = 0.7
    Glow.Parent = FloatingButton
    
    return FloatingButton
end

local function createMainMenu(parent)
    local MenuFrame = Instance.new("Frame")
    MenuFrame.Name = "MenuFrame"
    MenuFrame.Size = UDim2.new(0, 420, 0, 520)
    MenuFrame.Position = UDim2.new(0, 120, 0.5, -260)
    MenuFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MenuFrame.BackgroundTransparency = 0.02
    MenuFrame.BorderSizePixel = 0
    MenuFrame.Visible = false
    MenuFrame.Parent = parent
    
    local MenuCorner = Instance.new("UICorner")
    MenuCorner.CornerRadius = UDim.new(0, 18)
    MenuCorner.Parent = MenuFrame
    
    local MenuStroke = Instance.new("UIStroke")
    MenuStroke.Color = Color3.fromRGB(0, 180, 255)
    MenuStroke.Thickness = 2.5
    MenuStroke.Transparency = 0.2
    MenuStroke.Parent = MenuFrame
    
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.7
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.Parent = MenuFrame
    
    return MenuFrame
end

local function createTitleBar(parent)
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 55)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
    TitleBar.BackgroundTransparency = 0.05
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = parent
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 18)
    TitleCorner.Parent = TitleBar
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 180, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 220))
    }
    Gradient.Rotation = 50
    Gradient.Parent = TitleBar
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -110, 1, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "🚀 ENHANCED HACK GUI V3"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Position = UDim2.new(1, -50, 0, 7.5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    CloseButton.BackgroundTransparency = 0.15
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 18
    CloseButton.Parent = TitleBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 20)
    CloseCorner.Parent = CloseButton
    
    return TitleBar, CloseButton
end

local function createScrollingFrame(parent)
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, -25, 1, -75)
    ScrollingFrame.Position = UDim2.new(0, 12.5, 0, 65)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 700)
    ScrollingFrame.ScrollBarThickness = 10
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
    ScrollingFrame.Parent = parent
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 18)
    UIListLayout.Parent = ScrollingFrame
    
    return ScrollingFrame
end

local function createEnhancedButton(parent, name, text, color, icon)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -25, 0, 50)
    button.BackgroundColor3 = color or Color3.fromRGB(45, 45, 65)
    button.BackgroundTransparency = 0.15
    button.BorderSizePixel = 0
    button.Text = (icon or "🔧") .. " " .. text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16
    button.Font = Enum.Font.GothamSemibold
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(120, 120, 140)
    buttonStroke.Thickness = 1.5
    buttonStroke.Transparency = 0.4
    buttonStroke.Parent = button
    
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.25), {
            BackgroundTransparency = 0.05,
            TextSize = 17
        })
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.25), {
            BackgroundTransparency = 0.15,
            TextSize = 16
        })
        tween:Play()
    end)
    
    return button
end

local function createAimbotCircle()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AimbotCircle"
    screenGui.Parent = game.CoreGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local circle = Instance.new("Frame")
    circle.Name = "Circle"
    circle.Size = UDim2.new(0, 450, 0, 450)
    circle.Position = UDim2.new(0.5, -225, 0.5, -225)
    circle.BackgroundTransparency = 1
    circle.Parent = screenGui
    
    local function createCorner(position, rotation)
        local corner = Instance.new("Frame")
        corner.Size = UDim2.new(0, 45, 0, 5)
        corner.Position = position
        corner.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        corner.BorderSizePixel = 0
        corner.Parent = circle
        corner.Rotation = rotation
        
        local cornerCorner = Instance.new("UICorner")
        cornerCorner.CornerRadius = UDim.new(0, 2.5)
        cornerCorner.Parent = corner
        
        return corner
    end
    
    createCorner(UDim2.new(0.5, -22.5, 0, -2.5), 0)
    createCorner(UDim2.new(1, -2.5, 0.5, -22.5), 90)
    createCorner(UDim2.new(0.5, -22.5, 1, -2.5), 0)
    createCorner(UDim2.new(0, -2.5, 0.5, -22.5), 90)
    
    return screenGui
end

local function createSpeedSlider(parent, speedButton)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = "SpeedSliderFrame"
    SliderFrame.Size = UDim2.new(1, -25, 0, 70)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    SliderFrame.BackgroundTransparency = 0.25
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Visible = false
    SliderFrame.Parent = parent
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 12)
    SliderCorner.Parent = SliderFrame
    
    local SpeedLabel = Instance.new("TextLabel")
    SpeedLabel.Size = UDim2.new(1, 0, 0, 25)
    SpeedLabel.Position = UDim2.new(0, 0, 0, 8)
    SpeedLabel.BackgroundTransparency = 1
    SpeedLabel.Text = "🏃 السرعة: 16"
    SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedLabel.TextSize = 14
    SpeedLabel.Font = Enum.Font.GothamSemibold
    SpeedLabel.Parent = SliderFrame
    
    local SliderBG = Instance.new("Frame")
    SliderBG.Name = "SliderBG"
    SliderBG.Size = UDim2.new(1, -25, 0, 10)
    SliderBG.Position = UDim2.new(0, 12.5, 0, 35)
    SliderBG.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    SliderBG.BorderSizePixel = 0
    SliderBG.Parent = SliderFrame
    
    local SliderBGCorner = Instance.new("UICorner")
    SliderBGCorner.CornerRadius = UDim.new(0, 5)
    SliderBGCorner.Parent = SliderBG
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "SliderFill"
    SliderFill.Size = UDim2.new(0, 0, 1, 0)
    SliderFill.Position = UDim2.new(0, 0, 0, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 220, 120)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBG
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(0, 5)
    SliderFillCorner.Parent = SliderFill
    
    local SliderHandle = Instance.new("Frame")
    SliderHandle.Name = "SliderHandle"
    SliderHandle.Size = UDim2.new(0, 20, 0, 20)
    SliderHandle.Position = UDim2.new(0, -10, 0, -5)
    SliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderHandle.BorderSizePixel = 0
    SliderHandle.Parent = SliderBG
    
    local HandleCorner = Instance.new("UICorner")
    HandleCorner.CornerRadius = UDim.new(0, 10)
    HandleCorner.Parent = SliderHandle
    
    local HandleStroke = Instance.new("UIStroke")
    HandleStroke.Color = Color3.fromRGB(0, 220, 120)
    HandleStroke.Thickness = 2.5
    HandleStroke.Parent = SliderHandle
    
    local minSpeed = 16
    local maxSpeed = 200
    local draggingSlider = false
    
    local function updateSlider(value)
        local percentage = (value - minSpeed) / (maxSpeed - minSpeed)
        percentage = math.clamp(percentage, 0, 1)
        
        SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        SliderHandle.Position = UDim2.new(percentage, -10, 0, -5)
        
        currentSpeed = math.floor(minSpeed + (maxSpeed - minSpeed) * percentage)
        SpeedLabel.Text = "🏃 السرعة: " .. currentSpeed
        
        if speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
        end
    end
    
    local function getMousePercentage()
        local mouse = LocalPlayer:GetMouse()
        local relativePos = mouse.X - SliderBG.AbsolutePosition.X
        local percentage = relativePos / SliderBG.AbsoluteSize.X
        return math.clamp(percentage, 0, 1)
    end
    
    SliderBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = true
            local percentage = getMousePercentage()
            local value = minSpeed + (maxSpeed - minSpeed) * percentage
            updateSlider(value)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
            local percentage = getMousePercentage()
            local value = minSpeed + (maxSpeed - minSpeed) * percentage
            updateSlider(value)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = false
        end
    end)
    
    updateSlider(16)
    
    return SliderFrame, SpeedLabel
end

local function createAdvancedESP(player)
    if espBoxes[player] or not player.Character then return end
    
    local character = player.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local espBox = Instance.new("Highlight")
    espBox.Name = player.Name.."_ESP"
    espBox.OutlineColor = Color3.fromRGB(255, 120, 120)
    espBox.FillColor = Color3.fromRGB(255, 120, 120)
    espBox.FillTransparency = 0.65
    espBox.OutlineTransparency = 0.25
    espBox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    espBox.Parent = character
    espBox.Adornee = character
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = player.Name.."_DistanceLabel"
    billboardGui.Size = UDim2.new(0, 220, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 4, 0)
    billboardGui.Parent = humanoidRootPart
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 1, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Text = player.Name
    distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distanceLabel.TextSize = 18
    distanceLabel.Font = Enum.Font.GothamBold
    distanceLabel.TextStrokeTransparency = 0.4
    distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distanceLabel.Parent = billboardGui
    
    espBoxes[player] = {highlight = espBox, billboard = billboardGui}
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not player.Character or not LocalPlayer.Character then
            connection:Disconnect()
            return
        end
        
        local localHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local playerHRP = player.Character:FindFirstChild("HumanoidRootPart")
        
        if localHRP and playerHRP then
            local distance = math.floor((localHRP.Position - playerHRP.Position).Magnitude)
            if distance <= 400 then
                distanceLabel.Text = player.Name .. "\n[" .. distance .. "m]"
                espBox.Enabled = true
                billboardGui.Enabled = true
            else
                espBox.Enabled = false
                billboardGui.Enabled = false
            end
        end
    end)
end

local function removeAdvancedESP(player)
    if espBoxes[player] then
        if espBoxes[player].highlight then
            espBoxes[player].highlight:Destroy()
        end
        if espBoxes[player].billboard then
            espBoxes[player].billboard:Destroy()
        end
        espBoxes[player] = nil
    end
end

local function toggleAdvancedESP(button)
    espEnabled = not espEnabled
    button.Text = (espEnabled and "👁️ ESP: ON" or "👁️ ESP: OFF")
    button.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
    if espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                createAdvancedESP(player)
            end
        end
    else
        for player, _ in pairs(espBoxes) do
            removeAdvancedESP(player)
        end
    end
end

local function isPlayerVisible(player)
    if not player.Character or not player.Character:FindFirstChild("Head") then
        return false
    end
    
    local localCharacter = LocalPlayer.Character
    if not localCharacter or not localCharacter:FindFirstChild("Head") then
        return false
    end
    
    local rayOrigin = localCharacter.Head.Position
    local rayDirection = (player.Character.Head.Position - rayOrigin).Unit * 1000
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {localCharacter, player.Character}
    
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    
    return raycastResult == nil
end

local function createAimbot()
    local aimbotConnection
    
    local function getClosestPlayerToMouse()
        local closestPlayer = nil
        local shortestDistance = math.huge
        local mouse = LocalPlayer:GetMouse()
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                if isPlayerVisible(player) then
                    local head = player.Character.Head
                    local screenPoint = Camera:WorldToScreenPoint(head.Position)
                    local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
                    
                    if distance < shortestDistance and distance <= 350 then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
        end
        
        return closestPlayer
    end
    
    local function aimAtPlayer(player)
        if not player.Character or not player.Character:FindFirstChild("Head") then return end
        
        local targetHead = player.Character.Head
        local targetPosition = targetHead.Position + Vector3.new(0, 0.15, 0)
        
        local currentCFrame = Camera.CFrame
        local targetCFrame = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
        
        local tween = TweenService:Create(Camera, 
            TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 
            {CFrame = targetCFrame}
        )
        tween:Play()
    end
    
    local function toggleAimbot(button)
        aimbotEnabled = not aimbotEnabled
        button.Text = (aimbotEnabled and "🎯 AIMBOT: ON" or "🎯 AIMBOT: OFF")
        button.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(220, 60, 60) or Color3.fromRGB(45, 45, 65)
        
        if aimbotEnabled then
            aimbotCircle = createAimbotCircle()
            aimbotConnection = RunService.RenderStepped:Connect(function()
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                    local targetPlayer = getClosestPlayerToMouse()
                    if targetPlayer then
                        aimAtPlayer(targetPlayer)
                    end
                end
            end)
        else
            if aimbotConnection then
                aimbotConnection:Disconnect()
                aimbotConnection = nil
            end
            if aimbotCircle then
                aimbotCircle:Destroy()
                aimbotCircle = nil
            end
        end
    end
    
    return toggleAimbot
end

local function createSpeedHack(button, sliderFrame)
    button.MouseButton1Click:Connect(function()
        speedEnabled = not speedEnabled
        button.Text = speedEnabled and "🏃 SPEED: ON" or "🏃 SPEED: OFF"
        button.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
        
        sliderFrame.Visible = speedEnabled
        
        if speedEnabled then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
            end
        else
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end
    end)
end

local function createFullbright(button)
    local fullbrightEnabled = false
    local originalAmbient = Lighting.Ambient
    local originalBrightness = Lighting.Brightness
    
    button.MouseButton1Click:Connect(function()
        fullbrightEnabled = not fullbrightEnabled
        button.Text = fullbrightEnabled and "💡 FULLBRIGHT: ON" or "💡 FULLBRIGHT: OFF"
        button.BackgroundColor3 = fullbrightEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
        
        if fullbrightEnabled then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2.5
        else
            Lighting.Ambient = originalAmbient
            Lighting.Brightness = originalBrightness
        end
    end)
end

local function initializeGUI()
    local mainGUI = createMainGUI()
    local floatingButton = createFloatingButton(mainGUI)
    local menuFrame = createMainMenu(mainGUI)
    local titleBar, closeButton = createTitleBar(menuFrame)
    local scrollingFrame = createScrollingFrame(menuFrame)
    
    local espButton = createEnhancedButton(scrollingFrame, "ESPButton", "ESP: OFF", nil, "👁️")
    local speedButton = createEnhancedButton(scrollingFrame, "SpeedButton", "SPEED: OFF", nil, "🏃")
    
    local speedSlider, speedLabel = createSpeedSlider(scrollingFrame, speedButton)
    
    local aimbotButton = createEnhancedButton(scrollingFrame, "AimbotButton", "AIMBOT: OFF", Color3.fromRGB(170, 60, 60), "🎯")
    local fullbrightButton = createEnhancedButton(scrollingFrame, "FullbrightButton", "FULLBRIGHT: OFF", nil, "💡")
    local developerButton = createEnhancedButton(scrollingFrame, "DeveloperButton", "DEVELOPER", Color3.fromRGB(140, 0, 220), "👨‍💻")
    
    espButton.MouseButton1Click:Connect(function() toggleAdvancedESP(espButton) end)
    createSpeedHack(speedButton, speedSlider)
    
    local toggleAimbotFunc = createAimbot()
    aimbotButton.MouseButton1Click:Connect(function() toggleAimbotFunc(aimbotButton) end)
    
    createFullbright(fullbrightButton)
    
    local colors = {
        Color3.fromRGB(255, 120, 120),
        Color3.fromRGB(120, 255, 120),
        Color3.fromRGB(120, 120, 255),
        Color3.fromRGB(255, 255, 120),
        Color3.fromRGB(255, 120, 255),
        Color3.fromRGB(120, 255, 255),
        Color3.fromRGB(255, 180, 120),
        Color3.fromRGB(180, 120, 255)
    }
    local colorIndex = 1
    
    developerButton.MouseButton1Click:Connect(function()
        colorIndex = colorIndex % #colors + 1
        local tween = TweenService:Create(developerButton, TweenInfo.new(0.35), {
            BackgroundColor3 = colors[colorIndex]
        })
        tween:Play()
        
        if setclipboard then
            setclipboard("https://t.me/XVSJQ")
        end
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(menuFrame, TweenInfo.new(0.35), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, 270, 0.5, 0)
        })
        tween:Play()
        tween.Completed:Connect(function()
            menuFrame.Visible = false
            menuOpen = false
        end)
    end)
    
    floatingButton.MouseButton1Click:Connect(function()
        menuOpen = not menuOpen
        if menuOpen then
            menuFrame.Size = UDim2.new(0, 0, 0, 0)
            menuFrame.Position = UDim2.new(0, 270, 0.5, 0)
            menuFrame.Visible = true
            local tween = TweenService:Create(menuFrame, TweenInfo.new(0.35), {
                Size = UDim2.new(0, 420, 0, 520),
                Position = UDim2.new(0, 120, 0.5, -260)
            })
            tween:Play()
        else
            local tween = TweenService:Create(menuFrame, TweenInfo.new(0.35), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0, 270, 0.5, 0)
            })
            tween:Play()
            tween.Completed:Connect(function()
                menuFrame.Visible = false
            end)
        end
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightControl then
            floatingButton.MouseButton1Click:Fire()
        end
    end)
    
    local dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStart = input.Position
            startPos = menuFrame.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDragging = false
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            menuFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid")
        if speedEnabled then
            character.Humanoid.WalkSpeed = currentSpeed
        end
    end)
end

initializeGUI()

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if espEnabled then
            wait(1)
            createAdvancedESP(player)
        end
    end)
end)
