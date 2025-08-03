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
local currentSpeed = 16

-- Main GUI Creation
local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "EnhancedHackGUI"
DeltaGUI.Parent = game.CoreGui
DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Floating Button
local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 80, 0, 80)
FloatingButton.Position = UDim2.new(0, 25, 0.5, -40)
FloatingButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
FloatingButton.BackgroundTransparency = 0.1
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://3926305904"
FloatingButton.ImageColor3 = Color3.fromRGB(0, 220, 255)
FloatingButton.Parent = DeltaGUI

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 40)
Corner.Parent = FloatingButton

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 220, 255)
Stroke.Thickness = 3
Stroke.Transparency = 0.3
Stroke.Parent = FloatingButton

-- Main Menu Frame
local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.Size = UDim2.new(0, 420, 0, 520)
MenuFrame.Position = UDim2.new(0, 120, 0.5, -260)
MenuFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MenuFrame.BackgroundTransparency = 0.02
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = false
MenuFrame.Parent = DeltaGUI

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 18)
MenuCorner.Parent = MenuFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 55)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
TitleBar.BackgroundTransparency = 0.05
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MenuFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 18)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -110, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🚀 ENHANCED HACK GUI"
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

-- Scrolling Frame for buttons
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -25, 1, -75)
ScrollingFrame.Position = UDim2.new(0, 12.5, 0, 65)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 700)
ScrollingFrame.ScrollBarThickness = 10
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
ScrollingFrame.Parent = MenuFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 18)
UIListLayout.Parent = ScrollingFrame

-- Function to create buttons
local function createButton(name, text, color, icon)
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
    button.Parent = ScrollingFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.25), {
            BackgroundTransparency = 0.05,
            TextSize = 17
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.25), {
            BackgroundTransparency = 0.15,
            TextSize = 16
        }):Play()
    end)
    
    return button
end

-- Speed Control Frame
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Name = "SpeedFrame"
SpeedFrame.Size = UDim2.new(1, -25, 0, 80)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
SpeedFrame.BackgroundTransparency = 0.25
SpeedFrame.BorderSizePixel = 0
SpeedFrame.Parent = ScrollingFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 12)
SpeedCorner.Parent = SpeedFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 25)
SpeedLabel.Position = UDim2.new(0, 0, 0, 8)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "🏃 SPEED: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.GothamSemibold
SpeedLabel.Parent = SpeedFrame

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0.5, -10, 0, 30)
SpeedBox.Position = UDim2.new(0.25, 5, 0, 35)
SpeedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.Text = "16"
SpeedBox.Font = Enum.Font.GothamSemibold
SpeedBox.TextSize = 14
SpeedBox.Parent = SpeedFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = SpeedBox

local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0.4, -10, 0, 30)
SpeedButton.Position = UDim2.new(0.3, 5, 0, 35)
SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
SpeedButton.Text = "APPLY"
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.Font = Enum.Font.GothamBold
SpeedButton.TextSize = 14
SpeedButton.Parent = SpeedFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = SpeedButton

-- ESP Functionality
local function createESP(player)
    if espBoxes[player] or not player.Character then return end
    
    local espBox = Instance.new("Highlight")
    espBox.Name = player.Name.."_ESP"
    espBox.OutlineColor = Color3.fromRGB(255, 120, 120)
    espBox.FillColor = Color3.fromRGB(255, 120, 120)
    espBox.FillTransparency = 0.65
    espBox.OutlineTransparency = 0.25
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

local function toggleESP(button)
    espEnabled = not espEnabled
    button.Text = (espEnabled and "👁️ ESP: ON" or "👁️ ESP: OFF")
    button.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 65)
    
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
end

-- Speed Functionality
SpeedButton.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(SpeedBox.Text)
    if newSpeed and newSpeed >= 16 and newSpeed <= 500 then
        currentSpeed = newSpeed
        SpeedLabel.Text = "🏃 SPEED: " .. currentSpeed
        
        if speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
        end
    else
        SpeedBox.Text = tostring(currentSpeed)
    end
end)

local function toggleSpeed()
    speedEnabled = not speedEnabled
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speedEnabled and currentSpeed or 16
    end
end

-- Developer Button
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
local DeveloperButton = createButton("DeveloperButton", "DEVELOPER", Color3.fromRGB(140, 0, 220), "👨‍💻")

DeveloperButton.MouseButton1Click:Connect(function()
    colorIndex = colorIndex % #colors + 1
    TweenService:Create(DeveloperButton, TweenInfo.new(0.35), {
        BackgroundColor3 = colors[colorIndex]
    }):Play()
    
    if setclipboard then
        setclipboard("https://t.me/XVSJQ")
    end
end)

-- ESP Button
local ESPButton = createButton("ESPButton", "ESP: OFF", nil, "👁️")
ESPButton.MouseButton1Click:Connect(function() toggleESP(ESPButton) end)

-- GUI Controls
CloseButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(MenuFrame, TweenInfo.new(0.35), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0, 270, 0.5, 0)
    })
    tween:Play()
    tween.Completed:Connect(function()
        MenuFrame.Visible = false
        menuOpen = false
    end)
end)

FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if menuOpen then
        MenuFrame.Size = UDim2.new(0, 0, 0, 0)
        MenuFrame.Position = UDim2.new(0, 270, 0.5, 0)
        MenuFrame.Visible = true
        TweenService:Create(MenuFrame, TweenInfo.new(0.35), {
            Size = UDim2.new(0, 420, 0, 520),
            Position = UDim2.new(0, 120, 0.5, -260)
        }):Play()
    else
        TweenService:Create(MenuFrame, TweenInfo.new(0.35), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, 270, 0.5, 0)
        }):Play()
    end
end)

-- Character Handling
LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    if speedEnabled then
        character.Humanoid.WalkSpeed = currentSpeed
    end
end)

-- Player Handling
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
end)

-- Initialize ESP for existing players if enabled
if espEnabled then
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createESP(player)
        end
    end
end
