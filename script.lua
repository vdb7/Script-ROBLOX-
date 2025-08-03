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
local gravityEnabled = false
local fovEnabled = false
local ctrlClickTPEnabled = false

local noClipConnection = nil
local godModeConnection = nil
local antiAfkConnection = nil
local spinBotConnection = nil

-- Main GUI
local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "RedZHUB"
DeltaGUI.Parent = game.CoreGui
DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Floating Button
local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 50, 0, 50)
FloatingButton.Position = UDim2.new(0, 20, 0.5, -25)
FloatingButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
FloatingButton.BackgroundTransparency = 0.3
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://7072718362"
FloatingButton.Parent = DeltaGUI

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = FloatingButton

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 50, 50)
Stroke.Thickness = 2
Stroke.Parent = FloatingButton

-- Main Menu Frame
local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.Size = UDim2.new(0, 350, 0, 450)
MenuFrame.Position = UDim2.new(0, 80, 0.5, -225)
MenuFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MenuFrame.BackgroundTransparency = 0.1
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = false
MenuFrame.Parent = DeltaGUI

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 10)
MenuCorner.Parent = MenuFrame

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(255, 50, 50)
MenuStroke.Thickness = 2
MenuStroke.Parent = MenuFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MenuFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "REDZ HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Scrolling Frame
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -50)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 45)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
ScrollingFrame.Parent = MenuFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ScrollingFrame

-- Function to create toggle buttons
local function createToggle(name, text, icon)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    button.BorderSizePixel = 0
    button.Text = icon .. " " .. text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.GothamSemibold
    button.Parent = ScrollingFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        }):Play()
    end)
    
    return button
end

-- Speed Toggle
local SpeedToggle = createToggle("SpeedToggle", "Speed", "⚡")
SpeedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        SpeedToggle.Text = "⚡ Speed: ON"
        SpeedToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        
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
        
        setSpeed()
        LocalPlayer.CharacterAdded:Connect(setSpeed)
    else
        SpeedToggle.Text = "⚡ Speed: OFF"
        SpeedToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        
        pcall(function()
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 16
                end
            end
        end)
    end
end)

-- Fly Toggle (formerly Infinite Jump)
local FlyToggle = createToggle("FlyToggle", "Fly", "🦅")
FlyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    if flyEnabled then
        FlyToggle.Text = "🦅 Fly: ON"
        FlyToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        
        UserInputService.JumpRequest:Connect(function()
            if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 100, 0)
            end
        end)
    else
        FlyToggle.Text = "🦅 Fly: OFF"
        FlyToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)

-- Noclip Toggle
local NoclipToggle = createToggle("NoclipToggle", "Noclip", "👻")
NoclipToggle.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    if noClipEnabled then
        NoclipToggle.Text = "👻 Noclip: ON"
        NoclipToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        
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
    else
        NoclipToggle.Text = "👻 Noclip: OFF"
        NoclipToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        
        if noClipConnection then
            noClipConnection:Disconnect()
            noClipConnection = nil
        end
    end
end)

-- God Mode Toggle
local GodModeToggle = createToggle("GodModeToggle", "God Mode", "🛡️")
GodModeToggle.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    if godModeEnabled then
        GodModeToggle.Text = "🛡️ God Mode: ON"
        GodModeToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        
        if godModeConnection then
            godModeConnection:Disconnect()
        end
        
        godModeConnection = RunService.Heartbeat:Connect(function()
            if godModeEnabled and LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                    
                    local forceField = LocalPlayer.Character:FindFirstChild("ForceField")
                    if not forceField then
                        forceField = Instance.new("ForceField")
                        forceField.Parent = LocalPlayer.Character
                    end
                end
            end
        end)
    else
        GodModeToggle.Text = "🛡️ God Mode: OFF"
        GodModeToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        
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

-- ESP Toggle
local ESPToggle = createToggle("ESPToggle", "ESP", "👁️")
ESPToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        ESPToggle.Text = "👁️ ESP: ON"
        ESPToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        
        local function createESP(player)
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = player.Name .. "_ESP"
                highlight.OutlineColor = Color3.fromRGB(255, 50, 50)
                highlight.FillColor = Color3.fromRGB(255, 50, 50)
                highlight.FillTransparency = 0.7
                highlight.OutlineTransparency = 0
                highlight.Parent = player.Character
                highlight.Adornee = player.Character
                espBoxes[player] = highlight
            end
        end
        
        local function removeESP(player)
            if espBoxes[player] then
                espBoxes[player]:Destroy()
                espBoxes[player] = nil
            end
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            createESP(player)
        end
        
        Players.PlayerAdded:Connect(createESP)
        Players.PlayerRemoving:Connect(removeESP)
    else
        ESPToggle.Text = "👁️ ESP: OFF"
        ESPToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        
        for player, _ in pairs(espBoxes) do
            if espBoxes[player] then
                espBoxes[player]:Destroy()
            end
        end
        espBoxes = {}
    end
end)

-- Click TP Toggle
local ClickTPToggle = createToggle("ClickTPToggle", "Click TP", "🖱️")
ClickTPToggle.MouseButton1Click:Connect(function()
    clickTPEnabled = not clickTPEnabled
    if clickTPEnabled then
        ClickTPToggle.Text = "🖱️ Click TP: ON"
        ClickTPToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
    else
        ClickTPToggle.Text = "🖱️ Click TP: OFF"
        ClickTPToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)

-- Ctrl+Click TP Toggle
local CtrlClickTPToggle = createToggle("CtrlClickTPToggle", "Ctrl+Click TP", "⌨️")
CtrlClickTPToggle.MouseButton1Click:Connect(function()
    ctrlClickTPEnabled = not ctrlClickTPEnabled
    if ctrlClickTPEnabled then
        CtrlClickTPToggle.Text = "⌨️ Ctrl+Click TP: ON"
        CtrlClickTPToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
    else
        CtrlClickTPToggle.Text = "⌨️ Ctrl+Click TP: OFF"
        CtrlClickTPToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)

-- Teleport to Player
local TeleportButton = createToggle("TeleportButton", "Teleport to Player", "📍")

-- Create player selection frame when teleport button is clicked
TeleportButton.MouseButton1Click:Connect(function()
    local PlayerSelection = Instance.new("Frame")
    PlayerSelection.Name = "PlayerSelection"
    PlayerSelection.Size = UDim2.new(0, 300, 0, 300)
    PlayerSelection.Position = UDim2.new(0.5, -150, 0.5, -150)
    PlayerSelection.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    PlayerSelection.BorderSizePixel = 0
    PlayerSelection.Parent = DeltaGUI
    
    local PlayerSelectionCorner = Instance.new("UICorner")
    PlayerSelectionCorner.CornerRadius = UDim.new(0, 10)
    PlayerSelectionCorner.Parent = PlayerSelection
    
    local PlayerSelectionStroke = Instance.new("UIStroke")
    PlayerSelectionStroke.Color = Color3.fromRGB(255, 50, 50)
    PlayerSelectionStroke.Thickness = 2
    PlayerSelectionStroke.Parent = PlayerSelection
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Title.Text = "SELECT PLAYER"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = PlayerSelection
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 10)
    TitleCorner.Parent = Title
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 14
    CloseButton.Parent = Title
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton
    
    local PlayerList = Instance.new("ScrollingFrame")
    PlayerList.Size = UDim2.new(1, -20, 1, -50)
    PlayerList.Position = UDim2.new(0, 10, 0, 45)
    PlayerList.BackgroundTransparency = 1
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
    PlayerList.ScrollBarThickness = 5
    PlayerList.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
    PlayerList.Parent = PlayerSelection
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 5)
    ListLayout.Parent = PlayerList
    
    CloseButton.MouseButton1Click:Connect(function()
        PlayerSelection:Destroy()
    end)
    
    -- Add players to list
    local function addPlayer(player)
        if player ~= LocalPlayer then
            local PlayerButton = Instance.new("TextButton")
            PlayerButton.Size = UDim2.new(1, 0, 0, 40)
            PlayerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            PlayerButton.Text = player.Name
            PlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            PlayerButton.TextSize = 14
            PlayerButton.Font = Enum.Font.GothamSemibold
            PlayerButton.Parent = PlayerList
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = PlayerButton
            
            PlayerButton.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                   player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                    PlayerSelection:Destroy()
                end
            end)
            
            PlayerList.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        addPlayer(player)
    end
    
    Players.PlayerAdded:Connect(addPlayer)
end)

-- Spin Bot Toggle
local SpinBotToggle = createToggle("SpinBotToggle", "Spin Bot", "🌀")
SpinBotToggle.MouseButton1Click:Connect(function()
    spinBotEnabled = not spinBotEnabled
    if spinBotEnabled then
        SpinBotToggle.Text = "🌀 Spin Bot: ON"
        SpinBotToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        
        if spinBotConnection then
            spinBotConnection:Disconnect()
        end
        
        spinBotConnection = RunService.Heartbeat:Connect(function()
            if spinBotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(30), 0)
            end
        end)
    else
        SpinBotToggle.Text = "🌀 Spin Bot: OFF"
        SpinBotToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        
        if spinBotConnection then
            spinBotConnection:Disconnect()
            spinBotConnection = nil
        end
    end
end)

-- X-Ray Toggle
local XRayToggle = createToggle("XRayToggle", "X-Ray", "🔍")
XRayToggle.MouseButton1Click:Connect(function()
    xRayEnabled = not xRayEnabled
    if xRayEnabled then
        XRayToggle.Text = "🔍 X-Ray: ON"
        XRayToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part:IsA("MeshPart") and part.Transparency < 0.5 then
                part.LocalTransparencyModifier = 0.7
            end
        end
    else
        XRayToggle.Text = "🔍 X-Ray: OFF"
        XRayToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    end
end)

-- Full Bright Toggle
local FullBrightToggle = createToggle("FullBrightToggle", "Full Bright", "💡")
FullBrightToggle.MouseButton1Click:Connect(function()
    if Lighting.Brightness ~= 5 then
        FullBrightToggle.Text = "💡 Full Bright: ON"
        FullBrightToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        Lighting.Brightness = 5
        Lighting.GlobalShadows = false
    else
        FullBrightToggle.Text = "💡 Full Bright: OFF"
        FullBrightToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
    end
end)

-- Anti AFK Toggle
local AntiAFKToggle = createToggle("AntiAFKToggle", "Anti AFK", "⏰")
AntiAFKToggle.MouseButton1Click:Connect(function()
    antiAfkEnabled = not antiAfkEnabled
    if antiAfkEnabled then
        AntiAFKToggle.Text = "⏰ Anti AFK: ON"
        AntiAFKToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        
        if antiAfkConnection then
            antiAfkConnection:Disconnect()
        end
        
        antiAfkConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    else
        AntiAFKToggle.Text = "⏰ Anti AFK: OFF"
        AntiAFKToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        
        if antiAfkConnection then
            antiAfkConnection:Disconnect()
            antiAfkConnection = nil
        end
    end
end)

-- Reset Character Button
local ResetButton = createToggle("ResetButton", "Reset Character", "💀")
ResetButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ResetButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character then
        LocalPlayer.Character:BreakJoints()
    end
end)

-- Click TP functionality
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouse = LocalPlayer:GetMouse()
            
            if clickTPEnabled then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
                end
            elseif ctrlClickTPEnabled and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
                end
            end
        end
    end
end)

-- GUI Toggle
CloseButton.MouseButton1Click:Connect(function()
    MenuFrame.Visible = false
    menuOpen = false
end)

FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MenuFrame.Visible = menuOpen
end)

-- Character added events
LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1)
    
    if speedEnabled then
        pcall(function()
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = currentSpeed
            end
        end)
    end
    
    if noClipEnabled then
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
    
    if godModeEnabled then
        if godModeConnection then
            godModeConnection:Disconnect()
        end
        
        godModeConnection = RunService.Heartbeat:Connect(function()
            if godModeEnabled and LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                    
                    local forceField = LocalPlayer.Character:FindFirstChild("ForceField")
                    if not forceField then
                        forceField = Instance.new("ForceField")
                        forceField.Parent = LocalPlayer.Character
                    end
                end
            end
        end)
    end
end)

-- Initial setup
if espEnabled then
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createESP(player)
        end
    end
end
