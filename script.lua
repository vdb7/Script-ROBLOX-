-- Script by @XVSJQ, Fixed by Manus
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local menuOpen = false
local currentSpeed = 16

-- General Toggles
local speedEnabled = false
local flyEnabled = false
local noClipEnabled = false
local godModeEnabled = false
local clickTPEnabled = false
local spinBotEnabled = false
local teleportToPlayerEnabled = false

-- Connections
local noClipConnection = nil
local godModeConnection = nil
local infiniteJumpConnection = nil
local spinBotConnection = nil

local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "RedZHubGUI"
DeltaGUI.Parent = game:GetService("CoreGui")
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
        spawn(function()
            while speedEnabled do
                setSpeed()
                wait(0.1)
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
        infiniteJumpConnection = nil
    end
    if flyEnabled then
        infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end)
    end
end

local FlyButton = createButton("FlyButton", "FLY: OFF", nil, "✈️")
FlyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyButton.Text = flyEnabled and "✈️ FLY: ON" or "✈️ FLY: OFF"
    FlyButton.BackgroundColor3 = flyEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupInfiniteJump()
end)

local function setupNoClip()
    if noClipConnection then
        noClipConnection:Disconnect()
        noClipConnection = nil
    end
    if noClipEnabled then
        noClipConnection = RunService.Stepped:Connect(function()
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end)
    else
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
end

local NoClipButton = createButton("NoClipButton", "NOCLIP: OFF", nil, "👻")
NoClipButton.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    NoClipButton.Text = noClipEnabled and "👻 NOCLIP: ON" or "👻 NOCLIP: OFF"
    NoClipButton.BackgroundColor3 = noClipEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupNoClip()
end)

local function setupGodMode()
    if godModeConnection then
        godModeConnection:Disconnect()
        godModeConnection = nil
    end
    if godModeEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        godModeConnection = LocalPlayer.Character.Humanoid.HealthChanged:Connect(function(health)
            if health < LocalPlayer.Character.Humanoid.MaxHealth then
                LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
            end
        end)
    end
end

local GodModeButton = createButton("GodModeButton", "GOD MODE: OFF", nil, "🛡️")
GodModeButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    GodModeButton.Text = godModeEnabled and "🛡️ GOD MODE: ON" or "🛡️ GOD MODE: OFF"
    GodModeButton.BackgroundColor3 = godModeEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupGodMode()
end)

local function setupClickTP()
    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if clickTPEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessedEvent then
            local mouse = LocalPlayer:GetMouse()
            if mouse and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 5, 0))
            end
        end
    end)
end

local ClickTPButton = createButton("ClickTPButton", "CLICK TP: OFF", nil, "🖱️")
ClickTPButton.MouseButton1Click:Connect(function()
    clickTPEnabled = not clickTPEnabled
    ClickTPButton.Text = clickTPEnabled and "🖱️ CLICK TP: ON" or "🖱️ CLICK TP: OFF"
    ClickTPButton.BackgroundColor3 = clickTPEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
end)
setupClickTP() -- Initialize listener

local function setupSpinBot()
    if spinBotConnection then
        spinBotConnection:Disconnect()
        spinBotConnection = nil
    end
    if spinBotEnabled then
        spinBotConnection = RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local rootPart = LocalPlayer.Character.HumanoidRootPart
                rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(15), 0)
            end
        end)
    end
end

local SpinBotButton = createButton("SpinBotButton", "SPIN BOT: OFF", nil, "🔄")
SpinBotButton.MouseButton1Click:Connect(function()
    spinBotEnabled = not spinBotEnabled
    SpinBotButton.Text = spinBotEnabled and "🔄 SPIN BOT: ON" or "🔄 SPIN BOT: OFF"
    SpinBotButton.BackgroundColor3 = spinBotEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(45, 45, 45)
    setupSpinBot()
end)

-- Placeholder for other features
createSectionLabel("SHOOTER")
createButton("IncreasedDamageButton", "INCREASED DAMAGE: OFF", nil, "💥")
createButton("NoRecoilButton", "NO RECOIL: OFF", nil, "🎯")
createButton("AimbotButton", "AIMBOT: OFF", nil, "🤖")

createSectionLabel("PARKOUR")
createButton("TeleportToCheckpointButton", "TELEPORT TO CHECKPOINT: OFF", nil, "🏁")
createButton("SpeedBoostButton", "SPEED BOOST: OFF", nil, "⚡")
createButton("BhopButton", "BHOP: OFF", nil, "🐇")
createButton("AutoParkourButton", "AUTO PARKOUR: OFF", nil, "🤸")
createButton("NoFallDamageButton", "NO FALL DAMAGE: OFF", nil, "🪂")

createSectionLabel("BEDWARS")
createButton("AutoBridgeButton", "AUTO BRIDGE: OFF", nil, "🌉")
createButton("BedwarsESPButton", "ESP: OFF", nil, "👁️")
createButton("KillAuraButton", "KILL AURA: OFF", nil, "⚔️")
createButton("AntiKnockbackButton", "ANTI KNOCKBACK: OFF", nil, "🛡️")
createButton("AutoClickerButton", "AUTO CLICKER: OFF", nil, "🖱️")

createSectionLabel("BLOX FRUITS")
createButton("AutoFarmButton", "AUTO FARM: OFF", nil, "⚔️")
createButton("AutoQuestButton", "AUTO QUEST: OFF", nil, "📜")
createButton("AutoNewWorldButton", "AUTO NEW WORLD: OFF", nil, "🗺️")
createButton("AutoFarmLevelButton", "AUTO FARM LEVEL: OFF", nil, "📊")
createButton("AutoFarmNearestPlayerButton", "AUTO FARM NEAREST PLAYER: OFF", nil, "🎯")
createButton("AutoCollectChestsButton", "AUTO COLLECT CHESTS: OFF", nil, "💰")
createButton("EspFruitsButton", "ESP FRUITS: OFF", nil, "🍎")
createButton("EspPlayersButton", "ESP PLAYERS: OFF", nil, "👀")
createButton("AutoFarmBossButton", "AUTO FARM BOSS: OFF", nil, "👹")
createButton("AutoRaidButton", "AUTO RAID: OFF", nil, "🛡️")
createButton("FastAttackButton", "FAST ATTACK: OFF", nil, "⚡")
createButton("WalkOnWaterButton", "WALK ON WATER: OFF", nil, "🌊")

createSectionLabel("GROW A GARDEN")
createButton("GardenAutoFarmButton", "AUTO FARM: OFF", nil, "🌱")
createButton("AutoPlantButton", "AUTO PLANT: OFF", nil, "🌻")
createButton("AutoHarvestButton", "AUTO HARVEST: OFF", nil, "🧺")
createButton("AutoWaterButton", "AUTO WATER: OFF", nil, "💧")
createButton("AutoSellButton", "AUTO SELL: OFF", nil, "💰")
createButton("InstantGrowButton", "INSTANT GROW: OFF", nil, "⚡")
createButton("AutoFertilizeButton", "AUTO FERTILIZE: OFF", nil, "🧪")
createButton("AutoUpgradeButton", "AUTO UPGRADE: OFF", nil, "⬆️")
createButton("InstantGrowAllButton", "INSTANT GROW ALL: OFF", nil, "🌱⚡")

-- Menu Dragging Logic
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
        if dragging and dragInput and input == dragInput then
            local delta = input.Position - dragStart
            MenuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

-- Menu Toggle
FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MenuFrame.Visible = menuOpen
end)

CloseButton.MouseButton1Click:Connect(function()
    menuOpen = false
    MenuFrame.Visible = false
end)

print("RedZ Hub Loaded!")
