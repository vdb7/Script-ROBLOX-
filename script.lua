local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

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
MenuFrame.Size = UDim2.new(0, 280, 0, 350)
MenuFrame.Position = UDim2.new(0, 90, 0.5, -175)
MenuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MenuFrame.BackgroundTransparency = 0.1
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = false
MenuFrame.Parent = DeltaGUI

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 10)
MenuCorner.Parent = MenuFrame

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
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 350)
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

local ESPButton = createButton("ESPButton", UDim2.new(0, 10, 0, 10), "ESP: OFF")
local JumpButton = createButton("JumpButton", UDim2.new(0, 10, 0, 55), "INFINITE JUMP: OFF")
local SpeedButton = createButton("SpeedButton", UDim2.new(0, 10, 0, 100), "SPEED: OFF")
local HealthButton = createButton("HealthButton", UDim2.new(0, 10, 0, 145), "HEALTH 9999: OFF")
local AmmoButton = createButton("AmmoButton", UDim2.new(0, 10, 0, 190), "INFINITE AMMO: OFF")
local DeveloperButton = createButton("DeveloperButton", UDim2.new(0, 10, 0, 235), "DEVELOPER", Color3.fromRGB(100, 0, 200))

local menuOpen = false
local espEnabled = false
local jumpEnabled = false
local speedEnabled = false
local healthEnabled = false
local ammoEnabled = false
local originalHealth = nil
local espBoxes = {}

local colors = {
    Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 0, 255), Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 128, 0), Color3.fromRGB(128, 0, 255)
}
local colorIndex = 1

local function createESP(player)
    if espBoxes[player] then return end
    
    local espBox = Instance.new("Highlight")
    espBox.Name = player.Name.."_ESP"
    espBox.OutlineColor = Color3.fromRGB(255, 0, 0)
    espBox.FillColor = Color3.fromRGB(255, 0, 0)
    espBox.FillTransparency = 0.8
    espBox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    espBox.Parent = player.Character
    espBox.Adornee = player.Character
    
    espBoxes[player] = espBox
    
    player.CharacterAdded:Connect(function(character)
        if espEnabled then
            wait(1)
            espBox.Adornee = character
            espBox.Parent = character
        end
    end)
end

local function removeESP(player)
    if espBoxes[player] then
        espBoxes[player]:Destroy()
        espBoxes[player] = nil
    end
end

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
        for player, _ in pairs(espBoxes) do
            removeESP(player)
        end
    end
end)

JumpButton.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    JumpButton.Text = "INFINITE JUMP: "..(jumpEnabled and "ON" or "OFF")
    JumpButton.BackgroundColor3 = jumpEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
end)

SpeedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    SpeedButton.Text = "SPEED: "..(speedEnabled and "ON" or "OFF")
    SpeedButton.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
end)

HealthButton.MouseButton1Click:Connect(function()
    healthEnabled = not healthEnabled
    HealthButton.Text = "HEALTH 9999: "..(healthEnabled and "ON" or "OFF")
    HealthButton.BackgroundColor3 = healthEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
    
    local localPlayer = Players.LocalPlayer
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        if healthEnabled then
            originalHealth = localPlayer.Character.Humanoid.MaxHealth
            local humanoid = localPlayer.Character.Humanoid
            
            humanoid.MaxHealth = 9999
            wait(0.1)
            humanoid.Health = 9999
            
            local connection
            connection = humanoid.HealthChanged:Connect(function(health)
                if healthEnabled and health < 9999 then
                    humanoid.Health = 9999
                end
            end)
            
            humanoid.AncestryChanged:Connect(function()
                if connection then
                    connection:Disconnect()
                end
            end)
        else
            if originalHealth then
                localPlayer.Character.Humanoid.MaxHealth = originalHealth
                localPlayer.Character.Humanoid.Health = originalHealth
            end
        end
    end
end)

AmmoButton.MouseButton1Click:Connect(function()
    ammoEnabled = not ammoEnabled
    AmmoButton.Text = "INFINITE AMMO: "..(ammoEnabled and "ON" or "OFF")
    AmmoButton.BackgroundColor3 = ammoEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
end)

DeveloperButton.MouseButton1Click:Connect(function()
    colorIndex = colorIndex % #colors + 1
    DeveloperButton.BackgroundColor3 = colors[colorIndex]
    
    if setclipboard then 
        setclipboard("https://t.me/XVSJQ")
        StarterGui:SetCore("SendNotification", {
            Title = "Copied!";
            Text = "Telegram link copied to clipboard";
            Duration = 3;
        })
    end
end)

UserInputService.JumpRequest:Connect(function()
    if jumpEnabled and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Heartbeat:Connect(function()
    local localPlayer = Players.LocalPlayer
    
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        -- Speed functionality
        if speedEnabled then
            localPlayer.Character.Humanoid.WalkSpeed = 160
        else
            localPlayer.Character.Humanoid.WalkSpeed = 16
        end
        
        -- Health functionality
        if healthEnabled then
            local humanoid = localPlayer.Character.Humanoid
            if humanoid.Health < 9999 then
                humanoid.Health = 9999
            end
            if humanoid.MaxHealth < 9999 then
                humanoid.MaxHealth = 9999
            end
        end
        
        -- Infinite Ammo functionality
        if ammoEnabled then
            for _, tool in pairs(localPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    -- Check for common ammo properties
                    for _, child in pairs(tool:GetDescendants()) do
                        if child:IsA("IntValue") or child:IsA("NumberValue") then
                            local name = child.Name:lower()
                            if name:find("ammo") or name:find("bullet") or name:find("shot") or name:find("round") then
                                if child.Value < 999 then
                                    child.Value = 999
                                end
                            end
                        elseif child:IsA("StringValue") and child.Name:lower():find("ammo") then
                            child.Value = "999"
                        end
                    end
                    
                    -- Also check for ammo in tool itself
                    for _, value in pairs(tool:GetChildren()) do
                        if value:IsA("IntValue") or value:IsA("NumberValue") then
                            local name = value.Name:lower()
                            if name:find("ammo") or name:find("bullet") or name:find("shot") or name:find("round") then
                                if value.Value < 999 then
                                    value.Value = 999
                                end
                            end
                        end
                    end
                end
            end
            
            -- Check backpack tools
            for _, tool in pairs(localPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, child in pairs(tool:GetDescendants()) do
                        if child:IsA("IntValue") or child:IsA("NumberValue") then
                            local name = child.Name:lower()
                            if name:find("ammo") or name:find("bullet") or name:find("shot") or name:find("round") then
                                if child.Value < 999 then
                                    child.Value = 999
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

local dragConnection

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local dragStart = input.Position
        local startPos = MenuFrame.Position
        local dragging = true
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                if dragConnection then
                    dragConnection:Disconnect()
                end
            end
        end)
        
        dragConnection = UserInputService.InputChanged:Connect(function(moveInput)
            if dragging and moveInput.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = moveInput.Position - dragStart
                MenuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MenuFrame.Visible = false
    menuOpen = false
end)

FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MenuFrame.Visible = menuOpen
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        menuOpen = not menuOpen
        MenuFrame.Visible = menuOpen
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
    if espBoxes[player] then
        removeESP(player)
    end
end)
