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
local noClipEnabled = false
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

local noClipConnection = nil
local godModeConnection = nil
local antiAfkConnection = nil
local spinBotConnection = nil

local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "RedZHubGUI"
DeltaGUI.Parent = game.CoreGui
DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = DeltaGUI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 60, 80)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local TitleFrame = Instance.new("Frame")
TitleFrame.Name = "TitleFrame"
TitleFrame.Size = UDim2.new(1, 0, 0, 50)
TitleFrame.Position = UDim2.new(0, 0, 0, 0)
TitleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "RedZ Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -45, 0, 7.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

local TabFrame = Instance.new("Frame")
TabFrame.Name = "TabFrame"
TabFrame.Size = UDim2.new(0, 150, 1, -60)
TabFrame.Position = UDim2.new(0, 10, 0, 60)
TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 8)
TabCorner.Parent = TabFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)
TabLayout.Parent = TabFrame

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingRight = UDim.new(0, 10)
UIPadding.Parent = TabFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -170, 1, -60)
ContentFrame.Position = UDim2.new(0, 160, 0, 60)
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentFrame

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -20)
ScrollFrame.Position = UDim2.new(0, 10, 0, 10)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 80)
ScrollFrame.Parent = ContentFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.Parent = ScrollFrame

local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 55, 0, 55)
FloatingButton.Position = UDim2.new(0, 25, 0.5, -27.5)
FloatingButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://18665684494"
FloatingButton.ImageColor3 = Color3.fromRGB(255, 100, 100)
FloatingButton.Parent = DeltaGUI

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(0, 27.5)
FloatCorner.Parent = FloatingButton

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(255, 100, 100)
FloatStroke.Thickness = 2
FloatStroke.Parent = FloatingButton

local function createTab(name, icon)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name.."Tab"
    tabButton.Size = UDim2.new(1, 0, 0, 40)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    tabButton.Text = icon.." "..name
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.TextSize = 14
    tabButton.TextXAlignment = Enum.TextXAlignment.Left
    tabButton.Parent = TabFrame
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabButton
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingLeft = UDim.new(0, 10)
    tabPadding.Parent = tabButton
    
    return tabButton
end

local function createToggleButton(name, text, icon)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, 0, 0, 45)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    button.Text = icon.." "..text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = ScrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local buttonPadding = Instance.new("UIPadding")
    buttonPadding.PaddingLeft = UDim.new(0, 15)
    buttonPadding.Parent = button
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 60, 1, 0)
    statusLabel.Position = UDim2.new(1, -70, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "OFF"
    statusLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextSize = 12
    statusLabel.Parent = button
    
    return button, statusLabel
end

local function createSlider(name, text, min, max, default)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = name.."Frame"
    sliderFrame.Size = UDim2.new(1, 0, 0, 70)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    sliderFrame.Parent = ScrollFrame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = sliderFrame
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, -20, 0, 25)
    sliderLabel.Position = UDim2.new(0, 10, 0, 5)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = text..": "..default
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.Font = Enum.Font.GothamSemibold
    sliderLabel.TextSize = 14
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = sliderFrame
    
    local sliderBG = Instance.new("Frame")
    sliderBG.Size = UDim2.new(1, -20, 0, 25)
    sliderBG.Position = UDim2.new(0, 10, 0, 35)
    sliderBG.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    sliderBG.Parent = sliderFrame
    
    local sliderBGCorner = Instance.new("UICorner")
    sliderBGCorner.CornerRadius = UDim.new(0, 12)
    sliderBGCorner.Parent = sliderBG
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    sliderFill.Parent = sliderBG
    
    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(0, 12)
    sliderFillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(1, 0, 1, 0)
    sliderButton.Position = UDim2.new(0, 0, 0, 0)
    sliderButton.BackgroundTransparency = 1
    sliderButton.Text = ""
    sliderButton.Parent = sliderBG
    
    return sliderFrame, sliderLabel, sliderFill, sliderButton
end

local mainTab = createTab("Main", "🏠")
local movementTab = createTab("Movement", "🏃")
local visualTab = createTab("Visual", "👁️")
local combatTab = createTab("Combat", "⚔️")

local currentTab = "Main"

local espButton, espStatus = createToggleButton("ESPButton", "ESP", "👁️")
local flyButton, flyStatus = createToggleButton("FlyButton", "Fly", "✈️")
local noClipButton, noClipStatus = createToggleButton("NoClipButton", "NoClip", "👻")
local godModeButton, godStatus = createToggleButton("GodModeButton", "God Mode", "🛡️")
local speedButton, speedStatus = createToggleButton("SpeedButton", "Speed", "🏃")
local clickTPButton, clickTPStatus = createToggleButton("ClickTPButton", "Click TP", "📍")
local brightButton, brightStatus = createToggleButton("BrightButton", "FullBright", "💡")
local aimBotButton, aimStatus = createToggleButton("AimBotButton", "Aimbot", "🎯")
local spinBotButton, spinStatus = createToggleButton("SpinBotButton", "Spinbot", "🌀")
local antiAfkButton, antiAfkStatus = createToggleButton("AntiAfkButton", "Anti-AFK", "⏰")

local speedFrame, speedLabel, speedFill, speedSlider = createSlider("Speed", "Speed", 16, 200, 16)

local function setSpeed()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
    end
end

local function setupFly()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = true
        end
        
        spawn(function()
            while flyEnabled and LocalPlayer.Character do
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local bodyVel = rootPart:FindFirstChild("FlyVelocity")
                    if not bodyVel then
                        bodyVel = Instance.new("BodyVelocity")
                        bodyVel.Name = "FlyVelocity"
                        bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
                        bodyVel.Parent = rootPart
                    end
                    
                    local moveVector = LocalPlayer:GetMoveVector()
                    local camera = workspace.CurrentCamera
                    local direction = (camera.CFrame.LookVector * -moveVector.Z) + (camera.CFrame.RightVector * moveVector.X)
                    
                    bodyVel.Velocity = direction * 50
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        bodyVel.Velocity = bodyVel.Velocity + Vector3.new(0, 50, 0)
                    elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        bodyVel.Velocity = bodyVel.Velocity + Vector3.new(0, -50, 0)
                    end
                end
                wait(0.1)
            end
        end)
    end
end

local function removeFly()
    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local bodyVel = rootPart:FindFirstChild("FlyVelocity")
            if bodyVel then
                bodyVel:Destroy()
            end
        end
        
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

local function setupNoClip()
    if noClipConnection then
        noClipConnection:Disconnect()
    end
    
    noClipConnection = RunService.Stepped:Connect(function()
        if noClipEnabled and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function removeNoClip()
    if noClipConnection then
        noClipConnection:Disconnect()
        noClipConnection = nil
    end
    
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

local function setupGodMode()
    if godModeConnection then
        godModeConnection:Disconnect()
    end
    
    godModeConnection = RunService.Heartbeat:Connect(function()
        if godModeEnabled and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
            end
        end
    end)
end

local function removeGodMode()
    if godModeConnection then
        godModeConnection:Disconnect()
        godModeConnection = nil
    end
    
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.MaxHealth = 100
            humanoid.Health = 100
        end
    end
end

local function createESP(player)
    if espBoxes[player] or not player.Character then return end
    
    local espBox = Instance.new("Highlight")
    espBox.Name = player.Name.."_ESP"
    espBox.OutlineColor = Color3.fromRGB(255, 100, 100)
    espBox.FillColor = Color3.fromRGB(255, 100, 100)
    espBox.FillTransparency = 0.7
    espBox.OutlineTransparency = 0.2
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

espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espStatus.Text = espEnabled and "ON" or "OFF"
    espStatus.TextColor3 = espEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
    
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

flyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    flyStatus.Text = flyEnabled and "ON" or "OFF"
    flyStatus.TextColor3 = flyEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
    
    if flyEnabled then
        setupFly()
    else
        removeFly()
    end
end)

noClipButton.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    noClipStatus.Text = noClipEnabled and "ON" or "OFF"
    noClipStatus.TextColor3 = noClipEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
    
    if noClipEnabled then
        setupNoClip()
    else
        removeNoClip()
    end
end)

godModeButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    godStatus.Text = godModeEnabled and "ON" or "OFF"
    godStatus.TextColor3 = godModeEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
    
    if godModeEnabled then
        setupGodMode()
    else
        removeGodMode()
    end
end)

speedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    speedStatus.Text = speedEnabled and "ON" or "OFF"
    speedStatus.TextColor3 = speedEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
    
    if speedEnabled then
        spawn(function()
            while speedEnabled do
                setSpeed()
                wait(0.1)
            end
        end)
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

clickTPButton.MouseButton1Click:Connect(function()
    clickTPEnabled = not clickTPEnabled
    clickTPStatus.Text = clickTPEnabled and "ON" or "OFF"
    clickTPStatus.TextColor3 = clickTPEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
end)

brightButton.MouseButton1Click:Connect(function()
    local enabled = Lighting.Brightness == 1
    if enabled then
        Lighting.Brightness = 5
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        brightStatus.Text = "ON"
        brightStatus.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        brightStatus.Text = "OFF"
        brightStatus.TextColor3 = Color3.fromRGB(255, 70, 70)
    end
end)

aimBotButton.MouseButton1Click:Connect(function()
    aimBotEnabled = not aimBotEnabled
    aimStatus.Text = aimBotEnabled and "ON" or "OFF"
    aimStatus.TextColor3 = aimBotEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
    
    if aimBotEnabled then
        spawn(function()
            while aimBotEnabled do
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
                wait(0.1)
            end
        end)
    end
end)

spinBotButton.MouseButton1Click:Connect(function()
    spinBotEnabled = not spinBotEnabled
    spinStatus.Text = spinBotEnabled and "ON" or "OFF"
    spinStatus.TextColor3 = spinBotEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
    
    if spinBotEnabled then
        if spinBotConnection then
            spinBotConnection:Disconnect()
        end
        
        spinBotConnection = RunService.Heartbeat:Connect(function()
            if spinBotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
            end
        end)
    else
        if spinBotConnection then
            spinBotConnection:Disconnect()
            spinBotConnection = nil
        end
    end
end)

antiAfkButton.MouseButton1Click:Connect(function()
    antiAfkEnabled = not antiAfkEnabled
    antiAfkStatus.Text = antiAfkEnabled and "ON" or "OFF"
    antiAfkStatus.TextColor3 = antiAfkEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
    
    if antiAfkEnabled then
        antiAfkConnection = LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    else
        if antiAfkConnection then
            antiAfkConnection:Disconnect()
            antiAfkConnection = nil
        end
    end
end)

local speedDragging = false
speedSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        speedDragging = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        speedDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if speedDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local sliderPos = speedSlider.AbsolutePosition
        local sliderSize = speedSlider.AbsoluteSize
        local relativeX = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
        currentSpeed = math.floor(16 + (relativeX * 184))
        speedLabel.Text = "Speed: "..currentSpeed
        speedFill.Size = UDim2.new(relativeX, 0, 1, 0)
        
        if speedEnabled then
            setSpeed()
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 and clickTPEnabled then
        local mouse = LocalPlayer:GetMouse()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position)
        end
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.3)
    MainFrame.Visible = false
    menuOpen = false
end)

FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if menuOpen then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 400)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        wait(0.3)
        MainFrame.Visible = false
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

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1)
    if speedEnabled then
        setSpeed()
    end
    if flyEnabled then
        setupFly()
    end
    if noClipEnabled then
        setupNoClip()
    end
    if godModeEnabled then
        setupGodMode()
    end
end)
