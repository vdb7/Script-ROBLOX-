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
local teleportToPlayerEnabled = false
local increasedDamageEnabled = false
local noRecoilEnabled = false
local aimbotEnabled = false
local teleportToCheckpointEnabled = false
local speedBoostEnabled = false
local autoFarmEnabled = false
local autoQuestEnabled = false
local autoNewWorldEnabled = false
local gardenAutoFarmEnabled = false
local autoPlantEnabled = false
local autoHarvestEnabled = false
local autoFarmLevelEnabled = false
local autoFarmNearestPlayerEnabled = false
local autoCollectChestsEnabled = false
local espFruitsEnabled = false
local espPlayersEnabled = false
local autoWaterEnabled = false
local autoSellEnabled = false
local instantGrowEnabled = false
local bhopEnabled = false
local autoParkourEnabled = false
local noFallDamageEnabled = false

local noClipConnection = nil
local godModeConnection = nil
local antiAfkConnection = nil
local spinBotConnection = nil
local infiniteJumpConnection = nil
local aimbotConnection = nil

local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "RedZHubGUI"
DeltaGUI.Parent = game.CoreGui
DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = UDim2.new(0, 20, 0.5, -30)
FloatingButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
FloatingButton.BackgroundTransparency = 0.05
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://84734916929333"
FloatingButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
FloatingButton.Parent = DeltaGUI

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 30)
Corner.Parent = FloatingButton

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 60, 60)
Stroke.Thickness = 3
Stroke.Transparency = 0.2
Stroke.Parent = FloatingButton

local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.Size = UDim2.new(0, 350, 0, 650)
MenuFrame.Position = UDim2.new(0, 80, 0.5, -325)
MenuFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MenuFrame.BackgroundTransparency = 0.03
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = false
MenuFrame.Parent = DeltaGUI

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 10)
MenuCorner.Parent = MenuFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BackgroundTransparency = 0.05
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MenuFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "REDZ HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BackgroundTransparency = 0.1
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -30, 1, -60)
ScrollingFrame.Position = UDim2.new(0, 15, 0, 50)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 1500)
ScrollingFrame.ScrollBarThickness = 10
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 60)
ScrollingFrame.Parent = MenuFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 15)
UIListLayout.Parent = ScrollingFrame

local function createButton(name, text, color, icon)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, 0, 0, 45)
    button.BackgroundColor3 = color or Color3.fromRGB(45, 45, 45)
    button.BackgroundTransparency = 0.1
    button.BorderSizePixel = 0
    button.Text = (icon or "🔧") .. " " .. text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 15
    button.Font = Enum.Font.GothamSemibold
    button.Parent = ScrollingFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.05,
            TextSize = 16
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.1,
            TextSize = 15
        }):Play()
    end)
    
    return button
end

local function createSectionLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 60, 60)
    label.TextSize = 18
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = ScrollingFrame
    return label
end

createSectionLabel("GENERAL")

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
    SpeedToggleButton.BackgroundColor3 = speedEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    
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

local function setupInfiniteJump()
    if infiniteJumpConnection then
        infiniteJumpConnection:Disconnect()
    end
    infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
        if flyEnabled then
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end)
end

local FlyButton = createButton("FlyButton", "FLY: OFF", nil, "✈️")
FlyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyButton.Text = flyEnabled and "✈️ FLY: ON" or "✈️ FLY: OFF"
    FlyButton.BackgroundColor3 = flyEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    
    if flyEnabled then
        setupInfiniteJump()
    else
        if infiniteJumpConnection then
            infiniteJumpConnection:Disconnect()
            infiniteJumpConnection = nil
        end
    end
end)

local function setupNoClip()
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
    NoClipButton.BackgroundColor3 = noClipEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    
    if noClipEnabled then
        setupNoClip()
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

local function setupGodMode()
    if godModeConnection then
        godModeConnection:Disconnect()
    end
    godModeConnection = LocalPlayer.Character.Humanoid.HealthChanged:Connect(function(health)
        if godModeEnabled and health < LocalPlayer.Character.Humanoid.MaxHealth then
            LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
        end
    end)
end

local GodModeButton = createButton("GodModeButton", "GOD MODE: OFF", nil, "🛡️")
GodModeButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    GodModeButton.Text = godModeEnabled and "🛡️ GOD MODE: ON" or "🛡️ GOD MODE: OFF"
    GodModeButton.BackgroundColor3 = godModeEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    
    if godModeEnabled then
        setupGodMode()
    else
        if godModeConnection then
            godModeConnection:Disconnect()
            godModeConnection = nil
        end
    end
end)

local function setupClickTP()
    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if clickTPEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessedEvent then
            local mouse = LocalPlayer:GetMouse()
            local target = mouse.Target
            local hitPos = mouse.Hit.p
            
            if target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hitPos + Vector3.new(0, 5, 0))
            end
        end
    end)
end

local ClickTPButton = createButton("ClickTPButton", "CLICK TP: OFF", nil, "🖱️")
ClickTPButton.MouseButton1Click:Connect(function()
    clickTPEnabled = not clickTPEnabled
    ClickTPButton.Text = clickTPEnabled and "🖱️ CLICK TP: ON" or "🖱️ CLICK TP: OFF"
    ClickTPButton.BackgroundColor3 = clickTPEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    
    if clickTPEnabled then
        setupClickTP()
    end
end)

local function setupSpinBot()
    if spinBotConnection then
        spinBotConnection:Disconnect()
    end
    spinBotConnection = RunService.RenderStepped:Connect(function()
        if spinBotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = LocalPlayer.Character.HumanoidRootPart
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(15), 0)
        end
    end)
end

local SpinBotButton = createButton("SpinBotButton", "SPIN BOT: OFF", nil, "🔄")
SpinBotButton.MouseButton1Click:Connect(function()
    spinBotEnabled = not spinBotEnabled
    SpinBotButton.Text = spinBotEnabled and "🔄 SPIN BOT: ON" or "🔄 SPIN BOT: OFF"
    SpinBotButton.BackgroundColor3 = spinBotEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    
    if spinBotEnabled then
        setupSpinBot()
    else
        if spinBotConnection then
            spinBotConnection:Disconnect()
            spinBotConnection = nil
        end
    end
end)

local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Name = "PlayerListFrame"
PlayerListFrame.Size = UDim2.new(1, 0, 0, 150)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PlayerListFrame.BackgroundTransparency = 0.1
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.Parent = ScrollingFrame
PlayerListFrame.Visible = false

local PlayerListCorner = Instance.new("UICorner")
PlayerListCorner.CornerRadius = UDim.new(0, 8)
PlayerListCorner.Parent = PlayerListFrame

local PlayerListLabel = Instance.new("TextLabel")
PlayerListLabel.Size = UDim2.new(1, 0, 0, 25)
PlayerListLabel.Position = UDim2.new(0, 0, 0, 5)
PlayerListLabel.BackgroundTransparency = 1
PlayerListLabel.Text = "TELEPORT TO PLAYER"
PlayerListLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerListLabel.TextSize = 14
PlayerListLabel.Font = Enum.Font.GothamSemibold
PlayerListLabel.Parent = PlayerListFrame

local PlayerScrollingFrame = Instance.new("ScrollingFrame")
PlayerScrollingFrame.Size = UDim2.new(1, -10, 1, -35)
PlayerScrollingFrame.Position = UDim2.new(0, 5, 0, 30)
PlayerScrollingFrame.BackgroundTransparency = 1
PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScrollingFrame.ScrollBarThickness = 8
PlayerScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 60)
PlayerScrollingFrame.Parent = PlayerListFrame

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlayerListLayout.Padding = UDim.new(0, 8)
PlayerListLayout.Parent = PlayerScrollingFrame

local function updatePlayerList()
    for _, child in pairs(PlayerScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    local yOffset = 0
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local playerButton = Instance.new("TextButton")
            playerButton.Name = player.Name
            playerButton.Size = UDim2.new(1, 0, 0, 30)
            playerButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            playerButton.BackgroundTransparency = 0.1
            playerButton.BorderSizePixel = 0
            playerButton.Text = player.Name
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.TextSize = 13
            playerButton.Font = Enum.Font.GothamSemibold
            playerButton.Parent = PlayerScrollingFrame
            
            local playerButtonCorner = Instance.new("UICorner")
            playerButtonCorner.CornerRadius = UDim.new(0, 6)
            playerButtonCorner.Parent = playerButton
            
            playerButton.MouseButton1Click:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                end
            end)
            yOffset = yOffset + 30 + PlayerListLayout.Padding.Offset
        end
    end
    PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

local TeleportToPlayerButton = createButton("TeleportToPlayerButton", "TELEPORT TO PLAYER", nil, "➡️")
TeleportToPlayerButton.MouseButton1Click:Connect(function()
    teleportToPlayerEnabled = not teleportToPlayerEnabled
    PlayerListFrame.Visible = teleportToPlayerEnabled
    TeleportToPlayerButton.BackgroundColor3 = teleportToPlayerEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    if teleportToPlayerEnabled then
        updatePlayerList()
    end
end)

createSectionLabel("SHOOTER")

local function setupIncreasedDamage()
    if increasedDamageEnabled then
        print("Increased Damage Enabled!")
    else
        print("Increased Damage Disabled!")
    end
end

local IncreasedDamageButton = createButton("IncreasedDamageButton", "INCREASED DAMAGE: OFF", nil, "💥")
IncreasedDamageButton.MouseButton1Click:Connect(function()
    increasedDamageEnabled = not increasedDamageEnabled
    IncreasedDamageButton.Text = increasedDamageEnabled and "💥 INCREASED DAMAGE: ON" or "💥 INCREASED DAMAGE: OFF"
    IncreasedDamageButton.BackgroundColor3 = increasedDamageEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupIncreasedDamage()
end)

local function setupNoRecoil()
    if noRecoilEnabled then
        print("No Recoil Enabled!")
    else
        print("No Recoil Disabled!")
    end
end

local NoRecoilButton = createButton("NoRecoilButton", "NO RECOIL: OFF", nil, "🎯")
NoRecoilButton.MouseButton1Click:Connect(function()
    noRecoilEnabled = not noRecoilEnabled
    NoRecoilButton.Text = noRecoilEnabled and "🎯 NO RECOIL: ON" or "🎯 NO RECOIL: OFF"
    NoRecoilButton.BackgroundColor3 = noRecoilEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupNoRecoil()
end)

local function setupAimbot()
    if aimbotEnabled then
        print("Aimbot Enabled!")
    else
        print("Aimbot Disabled!")
    end
end

local AimbotButton = createButton("AimbotButton", "AIMBOT: OFF", nil, "🤖")
AimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotButton.Text = aimbotEnabled and "🤖 AIMBOT: ON" or "🤖 AIMBOT: OFF"
    AimbotButton.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAimbot()
end)

createSectionLabel("PARKOUR")

local function setupTeleportToCheckpoint()
    if teleportToCheckpointEnabled then
        print("Teleport to Checkpoint Enabled!")
    else
        print("Teleport to Checkpoint Disabled!")
    end
end

local TeleportToCheckpointButton = createButton("TeleportToCheckpointButton", "TELEPORT TO CHECKPOINT: OFF", nil, "🏁")
TeleportToCheckpointButton.MouseButton1Click:Connect(function()
    teleportToCheckpointEnabled = not teleportToCheckpointEnabled
    TeleportToCheckpointButton.Text = teleportToCheckpointEnabled and "🏁 TELEPORT TO CHECKPOINT: ON" or "🏁 TELEPORT TO CHECKPOINT: OFF"
    TeleportToCheckpointButton.BackgroundColor3 = teleportToCheckpointEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupTeleportToCheckpoint()
end)

local function setupSpeedBoost()
    if speedBoostEnabled then
        print("Speed Boost Enabled!")
    else
        print("Speed Boost Disabled!")
    end
end

local SpeedBoostButton = createButton("SpeedBoostButton", "SPEED BOOST: OFF", nil, "⚡")
SpeedBoostButton.MouseButton1Click:Connect(function()
    speedBoostEnabled = not speedBoostEnabled
    SpeedBoostButton.Text = speedBoostEnabled and "⚡ SPEED BOOST: ON" or "⚡ SPEED BOOST: OFF"
    SpeedBoostButton.BackgroundColor3 = speedBoostEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupSpeedBoost()
end)

local function setupBhop()
    if bhopEnabled then
        print("Bhop Enabled!")
    else
        print("Bhop Disabled!")
    end
end

local BhopButton = createButton("BhopButton", "BHOP: OFF", nil, "🐇")
BhopButton.MouseButton1Click:Connect(function()
    bhopEnabled = not bhopEnabled
    BhopButton.Text = bhopEnabled and "🐇 BHOP: ON" or "🐇 BHOP: OFF"
    BhopButton.BackgroundColor3 = bhopEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupBhop()
end)

local function setupAutoParkour()
    if autoParkourEnabled then
        print("Auto Parkour Enabled!")
    else
        print("Auto Parkour Disabled!")
    end
end

local AutoParkourButton = createButton("AutoParkourButton", "AUTO PARKOUR: OFF", nil, "🤸")
AutoParkourButton.MouseButton1Click:Connect(function()
    autoParkourEnabled = not autoParkourEnabled
    AutoParkourButton.Text = autoParkourEnabled and "🤸 AUTO PARKOUR: ON" or "🤸 AUTO PARKOUR: OFF"
    AutoParkourButton.BackgroundColor3 = autoParkourEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoParkour()
end)

local function setupNoFallDamage()
    if noFallDamageEnabled then
        print("No Fall Damage Enabled!")
    else
        print("No Fall Damage Disabled!")
    end
end

local NoFallDamageButton = createButton("NoFallDamageButton", "NO FALL DAMAGE: OFF", nil, "🪂")
NoFallDamageButton.MouseButton1Click:Connect(function()
    noFallDamageEnabled = not noFallDamageEnabled
    NoFallDamageButton.Text = noFallDamageEnabled and "🪂 NO FALL DAMAGE: ON" or "🪂 NO FALL DAMAGE: OFF"
    NoFallDamageButton.BackgroundColor3 = noFallDamageEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupNoFallDamage()
end)

createSectionLabel("BLOX FRUITS")

local function setupAutoFarm()
    if autoFarmEnabled then
        print("Auto Farm Enabled!")
    else
        print("Auto Farm Disabled!")
    end
end

local AutoFarmButton = createButton("AutoFarmButton", "AUTO FARM: OFF", nil, "⚔️")
AutoFarmButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    AutoFarmButton.Text = autoFarmEnabled and "⚔️ AUTO FARM: ON" or "⚔️ AUTO FARM: OFF"
    AutoFarmButton.BackgroundColor3 = autoFarmEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoFarm()
end)

local function setupAutoQuest()
    if autoQuestEnabled then
        print("Auto Quest Enabled!")
    else
        print("Auto Quest Disabled!")
    end
end

local AutoQuestButton = createButton("AutoQuestButton", "AUTO QUEST: OFF", nil, "📜")
AutoQuestButton.MouseButton1Click:Connect(function()
    autoQuestEnabled = not autoQuestEnabled
    AutoQuestButton.Text = autoQuestEnabled and "📜 AUTO QUEST: ON" or "📜 AUTO QUEST: OFF"
    AutoQuestButton.BackgroundColor3 = autoQuestEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoQuest()
end)

local function setupAutoNewWorld()
    if autoNewWorldEnabled then
        print("Auto New World Enabled!")
    else
        print("Auto New World Disabled!")
    end
end

local AutoNewWorldButton = createButton("AutoNewWorldButton", "AUTO NEW WORLD: OFF", nil, "🗺️")
AutoNewWorldButton.MouseButton1Click:Connect(function()
    autoNewWorldEnabled = not autoNewWorldEnabled
    AutoNewWorldButton.Text = autoNewWorldEnabled and "🗺️ AUTO NEW WORLD: ON" or "🗺️ AUTO NEW WORLD: OFF"
    AutoNewWorldButton.BackgroundColor3 = autoNewWorldEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoNewWorld()
end)

local function setupAutoFarmLevel()
    if autoFarmLevelEnabled then
        print("Auto Farm Level Enabled!")
    else
        print("Auto Farm Level Disabled!")
    end
end

local AutoFarmLevelButton = createButton("AutoFarmLevelButton", "AUTO FARM LEVEL: OFF", nil, "📊")
AutoFarmLevelButton.MouseButton1Click:Connect(function()
    autoFarmLevelEnabled = not autoFarmLevelEnabled
    AutoFarmLevelButton.Text = autoFarmLevelEnabled and "📊 AUTO FARM LEVEL: ON" or "📊 AUTO FARM LEVEL: OFF"
    AutoFarmLevelButton.BackgroundColor3 = autoFarmLevelEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoFarmLevel()
end)

local function setupAutoFarmNearestPlayer()
    if autoFarmNearestPlayerEnabled then
        print("Auto Farm Nearest Player Enabled!")
    else
        print("Auto Farm Nearest Player Disabled!")
    end
end

local AutoFarmNearestPlayerButton = createButton("AutoFarmNearestPlayerButton", "AUTO FARM NEAREST PLAYER: OFF", nil, "🎯")
AutoFarmNearestPlayerButton.MouseButton1Click:Connect(function()
    autoFarmNearestPlayerEnabled = not autoFarmNearestPlayerEnabled
    AutoFarmNearestPlayerButton.Text = autoFarmNearestPlayerEnabled and "🎯 AUTO FARM NEAREST PLAYER: ON" or "🎯 AUTO FARM NEAREST PLAYER: OFF"
    AutoFarmNearestPlayerButton.BackgroundColor3 = autoFarmNearestPlayerEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoFarmNearestPlayer()
end)

local function setupAutoCollectChests()
    if autoCollectChestsEnabled then
        print("Auto Collect Chests Enabled!")
    else
        print("Auto Collect Chests Disabled!")
    end
end

local AutoCollectChestsButton = createButton("AutoCollectChestsButton", "AUTO COLLECT CHESTS: OFF", nil, "💰")
AutoCollectChestsButton.MouseButton1Click:Connect(function()
    autoCollectChestsEnabled = not autoCollectChestsEnabled
    AutoCollectChestsButton.Text = autoCollectChestsEnabled and "💰 AUTO COLLECT CHESTS: ON" or "💰 AUTO COLLECT CHESTS: OFF"
    AutoCollectChestsButton.BackgroundColor3 = autoCollectChestsEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoCollectChests()
end)

local function setupEspFruits()
    if espFruitsEnabled then
        print("ESP Fruits Enabled!")
    else
        print("ESP Fruits Disabled!")
    end
end

local EspFruitsButton = createButton("EspFruitsButton", "ESP FRUITS: OFF", nil, "🍎")
EspFruitsButton.MouseButton1Click:Connect(function()
    espFruitsEnabled = not espFruitsEnabled
    EspFruitsButton.Text = espFruitsEnabled and "🍎 ESP FRUITS: ON" or "🍎 ESP FRUITS: OFF"
    EspFruitsButton.BackgroundColor3 = espFruitsEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupEspFruits()
end)

local function setupEspPlayers()
    if espPlayersEnabled then
        print("ESP Players Enabled!")
    else
        print("ESP Players Disabled!")
    end
end

local EspPlayersButton = createButton("EspPlayersButton", "ESP PLAYERS: OFF", nil, "👀")
EspPlayersButton.MouseButton1Click:Connect(function()
    espPlayersEnabled = not espPlayersEnabled
    EspPlayersButton.Text = espPlayersEnabled and "👀 ESP PLAYERS: ON" or "👀 ESP PLAYERS: OFF"
    EspPlayersButton.BackgroundColor3 = espPlayersEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupEspPlayers()
end)

createSectionLabel("GROW A GARDEN")

local function setupGardenAutoFarm()
    if gardenAutoFarmEnabled then
        print("Garden Auto Farm Enabled!")
    else
        print("Garden Auto Farm Disabled!")
    end
end

local GardenAutoFarmButton = createButton("GardenAutoFarmButton", "AUTO FARM: OFF", nil, "🌱")
GardenAutoFarmButton.MouseButton1Click:Connect(function()
    gardenAutoFarmEnabled = not gardenAutoFarmEnabled
    GardenAutoFarmButton.Text = gardenAutoFarmEnabled and "🌱 AUTO FARM: ON" or "🌱 AUTO FARM: OFF"
    GardenAutoFarmButton.BackgroundColor3 = gardenAutoFarmEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupGardenAutoFarm()
end)

local function setupAutoPlant()
    if autoPlantEnabled then
        print("Auto Plant Enabled!")
    else
        print("Auto Plant Disabled!")
    end
end

local AutoPlantButton = createButton("AutoPlantButton", "AUTO PLANT: OFF", nil, "🌻")
AutoPlantButton.MouseButton1Click:Connect(function()
    autoPlantEnabled = not autoPlantEnabled
    AutoPlantButton.Text = autoPlantEnabled and "🌻 AUTO PLANT: ON" or "🌻 AUTO PLANT: OFF"
    AutoPlantButton.BackgroundColor3 = autoPlantEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoPlant()
end)

local function setupAutoHarvest()
    if autoHarvestEnabled then
        print("Auto Harvest Enabled!")
    else
        print("Auto Harvest Disabled!")
    end
end

local AutoHarvestButton = createButton("AutoHarvestButton", "AUTO HARVEST: OFF", nil, "🧺")
AutoHarvestButton.MouseButton1Click:Connect(function()
    autoHarvestEnabled = not autoHarvestEnabled
    AutoHarvestButton.Text = autoHarvestEnabled and "🧺 AUTO HARVEST: ON" or "🧺 AUTO HARVEST: OFF"
    AutoHarvestButton.BackgroundColor3 = autoHarvestEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoHarvest()
end)

local function setupAutoWater()
    if autoWaterEnabled then
        print("Auto Water Enabled!")
    else
        print("Auto Water Disabled!")
    end
end

local AutoWaterButton = createButton("AutoWaterButton", "AUTO WATER: OFF", nil, "💧")
AutoWaterButton.MouseButton1Click:Connect(function()
    autoWaterEnabled = not autoWaterEnabled
    AutoWaterButton.Text = autoWaterEnabled and "💧 AUTO WATER: ON" or "💧 AUTO WATER: OFF"
    AutoWaterButton.BackgroundColor3 = autoWaterEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoWater()
end)

local function setupAutoSell()
    if autoSellEnabled then
        print("Auto Sell Enabled!")
    else
        print("Auto Sell Disabled!")
    end
end

local AutoSellButton = createButton("AutoSellButton", "AUTO SELL: OFF", nil, "💰")
AutoSellButton.MouseButton1Click:Connect(function()
    autoSellEnabled = not autoSellEnabled
    AutoSellButton.Text = autoSellEnabled and "💰 AUTO SELL: ON" or "💰 AUTO SELL: OFF"
    AutoSellButton.BackgroundColor3 = autoSellEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupAutoSell()
end)

local function setupInstantGrow()
    if instantGrowEnabled then
        print("Instant Grow Enabled!")
    else
        print("Instant Grow Disabled!")
    end
end

local InstantGrowButton = createButton("InstantGrowButton", "INSTANT GROW: OFF", nil, "⚡")
InstantGrowButton.MouseButton1Click:Connect(function()
    instantGrowEnabled = not instantGrowEnabled
    InstantGrowButton.Text = instantGrowEnabled and "⚡ INSTANT GROW: ON" or "⚡ INSTANT GROW: OFF"
    InstantGrowButton.BackgroundColor3 = instantGrowEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupInstantGrow()
end)

FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MenuFrame.Visible = menuOpen
end)

CloseButton.MouseButton1Click:Connect(function()
    menuOpen = false
    MenuFrame.Visible = false
end)

local dragging
local dragInput
local dragStart
local startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragInput = input
        dragStart = input.Position
        startPos = MenuFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.Ended then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            MenuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

setupNoClip()
setupGodMode()
setupClickTP()
setupSpinBot()
setupInfiniteJump()


