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
local currentSpeed = 50
local flyEnabled = false
local noClipEnabled = false
local godModeEnabled = false
local clickTPEnabled = false
local spinBotEnabled = false
local antiAfkEnabled = false
local brightEnabled = false
local aimBotEnabled = false

local noClipConnection = nil
local godModeConnection = nil
local antiAfkConnection = nil
local spinBotConnection = nil
local aimBotConnection = nil

local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "RedZHubGUI"
DeltaGUI.Parent = game.CoreGui
DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = DeltaGUI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 100, 100)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local TitleFrame = Instance.new("Frame")
TitleFrame.Name = "TitleFrame"
TitleFrame.Size = UDim2.new(1, 0, 0, 60)
TitleFrame.Position = UDim2.new(0, 0, 0, 0)
TitleFrame.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "RedZ Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 24
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(1, -90, 0, 10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = TitleFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(0, 180, 1, -70)
TabFrame.Position = UDim2.new(0, 10, 0, 70)
TabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 10)
TabCorner.Parent = TabFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)
TabLayout.Parent = TabFrame

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingAll = UDim.new(0, 10)
TabPadding.Parent = TabFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -200, 1, -70)
ContentFrame.Position = UDim2.new(0, 190, 0, 70)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentFrame

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -20)
ScrollFrame.Position = UDim2.new(0, 10, 0, 10)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 100)
ScrollFrame.Parent = ContentFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.Parent = ScrollFrame

local FloatingButton = Instance.new("ImageButton")
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = UDim2.new(0, 25, 0.5, -30)
FloatingButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://18665684494"
FloatingButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
FloatingButton.Parent = DeltaGUI

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(0, 30)
FloatCorner.Parent = FloatingButton

local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Size = UDim2.new(0, 200, 0, 300)
PlayerListFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.Visible = false
PlayerListFrame.Parent = DeltaGUI

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 10)
ListCorner.Parent = PlayerListFrame

local ListTitle = Instance.new("TextLabel")
ListTitle.Size = UDim2.new(1, 0, 0, 40)
ListTitle.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
ListTitle.Text = "Select Player"
ListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ListTitle.Font = Enum.Font.GothamBold
ListTitle.TextSize = 16
ListTitle.Parent = PlayerListFrame

local ListTitleCorner = Instance.new("UICorner")
ListTitleCorner.CornerRadius = UDim.new(0, 10)
ListTitleCorner.Parent = ListTitle

local PlayerScroll = Instance.new("ScrollingFrame")
PlayerScroll.Size = UDim2.new(1, -10, 1, -50)
PlayerScroll.Position = UDim2.new(0, 5, 0, 45)
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScroll.ScrollBarThickness = 6
PlayerScroll.Parent = PlayerListFrame

local PlayerLayout = Instance.new("UIListLayout")
PlayerLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlayerLayout.Padding = UDim.new(0, 5)
PlayerLayout.Parent = PlayerScroll

local function createTab(name, icon)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, 0, 0, 45)
    tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    tabButton.Text = icon.." "..name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.TextSize = 14
    tabButton.TextXAlignment = Enum.TextXAlignment.Left
    tabButton.Parent = TabFrame
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabButton
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingLeft = UDim.new(0, 15)
    tabPadding.Parent = tabButton
    
    return tabButton
end

local function createToggleButton(name, text, icon)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    button.Text = icon.." "..text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = ScrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
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

local function updatePlayerList()
    for _, child in pairs(PlayerScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, -10, 0, 35)
            playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            playerButton.Text = player.Name
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.Font = Enum.Font.Gotham
            playerButton.TextSize = 12
            playerButton.Parent = PlayerScroll
            
            local playerCorner = Instance.new("UICorner")
            playerCorner.CornerRadius = UDim.new(0, 6)
            playerCorner.Parent = playerButton
            
            playerButton.MouseButton1Click:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                    end
                end
                PlayerListFrame.Visible = false
            end)
        end
    end
    
    PlayerLayout:ApplyLayout()
    PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, PlayerLayout.AbsoluteContentSize.Y + 10)
end

local mainTab = createTab("Main", "🏠")
local movementTab = createTab("Movement", "🏃")
local visualTab = createTab("Visual", "👁️")
local combatTab = createTab("Combat", "⚔️")

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
local tpToPlayerButton, tpStatus = createToggleButton("TPToPlayerButton", "TP to Player", "🚀")

local function setSpeed()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
    end
end

local function setupFly()
    UserInputService.JumpRequest:Connect(function()
        if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local function removeFly()
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
                    if speedEnabled then
                        part.Velocity = Vector3.new(0, 0, 0)
                    end
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
                humanoid.MaxHealth = 999999
                humanoid.Health = 999999
                
                local forceField = LocalPlayer.Character:FindFirstChild("ForceField")
                if not forceField then
                    forceField = Instance.new("ForceField")
                    forceField.Visible = false
                    forceField.Parent = LocalPlayer.Character
                end
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
        
        local forceField = LocalPlayer.Character:FindFirstChild("ForceField")
        if forceField then
            forceField:Destroy()
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
    brightEnabled = not brightEnabled
    brightStatus.Text = brightEnabled and "ON" or "OFF"
    brightStatus.TextColor3 = brightEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
    
    if brightEnabled then
        Lighting.Brightness = 5
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
    end
end)

aimBotButton.MouseButton1Click:Connect(function()
    aimBotEnabled = not aimBotEnabled
    aimStatus.Text = aimBotEnabled and "ON" or "OFF"
    aimStatus.TextColor3 = aimBotEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 70, 70)
    
    if aimBotEnabled then
        if aimBotConnection then
            aimBotConnection:Disconnect()
        end
        
        aimBotConnection = RunService.Heartbeat:Connect(function()
            if aimBotEnabled then
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
            end
        end)
    else
        if aimBotConnection then
            aimBotConnection:Disconnect()
            aimBotConnection = nil
        end
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

tpToPlayerButton.MouseButton1Click:Connect(function()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
    if PlayerListFrame.Visible then
        updatePlayerList()
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 and clickTPEnabled then
        local mouse = LocalPlayer:GetMouse()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
        end
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.3)
    MainFrame.Visible = false
    menuOpen = false
end)

MinimizeButton.MouseButton1Click:Connect(function()
    if MainFrame.Size == UDim2.new(0, 700, 0, 500) then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 700, 0, 60)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 700, 0, 500)}):Play()
    end
end)

FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if menuOpen then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 700, 0, 500)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        wait(0.3)
        MainFrame.Visible = false
        PlayerListFrame.Visible = false
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        FloatingButton.MouseButton1Click()
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
