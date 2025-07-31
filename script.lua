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
MenuFrame.Size = UDim2.new(0, 280, 0, 400)
MenuFrame.Position = UDim2.new(0, 90, 0.5, -200)
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
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
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
local HealthButton = createButton("HealthButton", UDim2.new(0, 10, 0, 155), "HEALTH 9999: OFF")
local FreeItemsButton = createButton("FreeItemsButton", UDim2.new(0, 10, 0, 200), "FREE ITEMS: OFF")
local DeveloperButton = createButton("DeveloperButton", UDim2.new(0, 10, 0, 285), "DEVELOPER", Color3.fromRGB(100, 0, 200))

local SpeedFrame = Instance.new("Frame")
SpeedFrame.Name = "SpeedFrame"
SpeedFrame.Size = UDim2.new(1, -20, 0, 70)
SpeedFrame.Position = UDim2.new(0, 10, 0, 100)
SpeedFrame.BackgroundTransparency = 1
SpeedFrame.Parent = ScrollingFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "SPEED: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SpeedFrame

local SpeedSlider = Instance.new("Frame")
SpeedSlider.Size = UDim2.new(1, 0, 0, 20)
SpeedSlider.Position = UDim2.new(0, 0, 0, 25)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SpeedSlider.BackgroundTransparency = 0.3
SpeedSlider.Parent = SpeedFrame

local SpeedSliderCorner = Instance.new("UICorner")
SpeedSliderCorner.CornerRadius = UDim.new(0, 10)
SpeedSliderCorner.Parent = SpeedSlider

local SpeedFill = Instance.new("Frame")
SpeedFill.Size = UDim2.new(0, 0, 1, 0)
SpeedFill.Position = UDim2.new(0, 0, 0, 0)
SpeedFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SpeedFill.BorderSizePixel = 0
SpeedFill.Parent = SpeedSlider

local SpeedFillCorner = Instance.new("UICorner")
SpeedFillCorner.CornerRadius = UDim.new(0, 10)
SpeedFillCorner.Parent = SpeedFill

local SpeedHandle = Instance.new("Frame")
SpeedHandle.Size = UDim2.new(0, 20, 1, 0)
SpeedHandle.Position = UDim2.new(0, 0, 0, 0)
SpeedHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SpeedHandle.BorderSizePixel = 0
SpeedHandle.Parent = SpeedSlider

local SpeedHandleCorner = Instance.new("UICorner")
SpeedHandleCorner.CornerRadius = UDim.new(0, 10)
SpeedHandleCorner.Parent = SpeedHandle

local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(1, 0, 1, 0)
SpeedButton.Position = UDim2.new(0, 0, 0, 0)
SpeedButton.BackgroundTransparency = 1
SpeedButton.Text = ""
SpeedButton.Parent = SpeedSlider

local SpeedToggle = Instance.new("TextButton")
SpeedToggle.Size = UDim2.new(1, 0, 0, 20)
SpeedToggle.Position = UDim2.new(0, 0, 0, 50)
SpeedToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SpeedToggle.BackgroundTransparency = 0.3
SpeedToggle.Text = "SPEED: OFF"
SpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedToggle.TextSize = 12
SpeedToggle.Font = Enum.Font.Gotham
SpeedToggle.Parent = SpeedFrame

local SpeedToggleCorner = Instance.new("UICorner")
SpeedToggleCorner.CornerRadius = UDim.new(0, 8)
SpeedToggleCorner.Parent = SpeedToggle

local menuOpen = false
local espEnabled = false
local jumpEnabled = false
local speedEnabled = false
local healthEnabled = false
local freeItemsEnabled = false
local currentSpeed = 16
local espBoxes = {}
local speedDragging = false
local originalHealth = nil

local colors = {
    Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 0, 255), Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 128, 0), Color3.fromRGB(128, 0, 255)
}
local colorIndex = 1

local function updateSpeedDisplay()
    SpeedLabel.Text = "SPEED: "..math.floor(currentSpeed)
    local percentage = (currentSpeed - 16) / (100 - 16)
    SpeedFill.Size = UDim2.new(percentage, 0, 1, 0)
    SpeedHandle.Position = UDim2.new(percentage, -10, 0, 0)
end

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

FreeItemsButton.MouseButton1Click:Connect(function()
    freeItemsEnabled = not freeItemsEnabled
    FreeItemsButton.Text = "FREE ITEMS: "..(freeItemsEnabled and "ON" or "OFF")
    FreeItemsButton.BackgroundColor3 = freeItemsEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
    
    if freeItemsEnabled then
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local MarketplaceService = game:GetService("MarketplaceService")
        
        local function interceptRemoteEvents()
            for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
                if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                    local name = remote.Name:lower()
                    if name:find("buy") or name:find("purchase") or name:find("shop") or name:find("store") then
                        local originalFireServer = remote.FireServer
                        local originalInvokeServer = remote.InvokeServer
                        
                        if remote:IsA("RemoteEvent") then
                            remote.FireServer = function(self, ...)
                                local args = {...}
                                for i, arg in pairs(args) do
                                    if type(arg) == "number" and arg > 0 then
                                        args[i] = 0
                                    end
                                end
                                return originalFireServer(self, unpack(args))
                            end
                        elseif remote:IsA("RemoteFunction") then
                            remote.InvokeServer = function(self, ...)
                                local args = {...}
                                for i, arg in pairs(args) do
                                    if type(arg) == "number" and arg > 0 then
                                        args[i] = 0
                                    end
                                end
                                return originalInvokeServer(self, unpack(args))
                            end
                        end
                    end
                end
            end
        end
        
        interceptRemoteEvents()
        
        ReplicatedStorage.DescendantAdded:Connect(function(descendant)
            if freeItemsEnabled then
                interceptRemoteEvents()
            end
        end)
        
        local originalPromptPurchase = MarketplaceService.PromptPurchase
        MarketplaceService.PromptPurchase = function(...)
            return
        end
        
        local originalPromptGamePassPurchase = MarketplaceService.PromptGamePassPurchase
        MarketplaceService.PromptGamePassPurchase = function(...)
            return
        end
        
        local originalPromptProductPurchase = MarketplaceService.PromptProductPurchase
        MarketplaceService.PromptProductPurchase = function(...)
            return
        end
    end
end)

SpeedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    SpeedToggle.Text = "SPEED: "..(speedEnabled and "ON" or "OFF")
    SpeedToggle.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 40)
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

SpeedButton.InputBegan:Connect(function(input)
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
        local sliderPos = SpeedSlider.AbsolutePosition
        local sliderSize = SpeedSlider.AbsoluteSize
        local relativeX = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
        currentSpeed = math.floor(16 + (relativeX * 84))
        updateSpeedDisplay()
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
        if speedEnabled then
            localPlayer.Character.Humanoid.WalkSpeed = currentSpeed
        else
            localPlayer.Character.Humanoid.WalkSpeed = 150
        end
        
        if healthEnabled then
            local humanoid = localPlayer.Character.Humanoid
            if humanoid.Health < 9999 then
                humanoid.Health = 9999
            end
            if humanoid.MaxHealth < 9999 then
                humanoid.MaxHealth = 9999
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

updateSpeedDisplay()
