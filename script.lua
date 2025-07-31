local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local DeltaGUI = Instance.new("ScreenGui")
DeltaGUI.Name = "DeltaGUI"
DeltaGUI.Parent = game.CoreGui
DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = DeltaGUI

local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "BackgroundImage"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://75797852451386"
BackgroundImage.ImageColor3 = Color3.fromRGB(0, 150, 255)
BackgroundImage.ImageTransparency = 0.9
BackgroundImage.ScaleType = Enum.ScaleType.Tile
BackgroundImage.TileSize = UDim2.new(0, 200, 0, 200)
BackgroundImage.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
TitleBar.BackgroundTransparency = 0.3
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Position = UDim2.new(0, 10, 0, 5)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://75797852451386"
Logo.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0, 50, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "DELTA HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.BackgroundTransparency = 0.5
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

CloseButton.MouseButton1Click:Connect(function()
    DeltaGUI:Destroy()
end)

local function ButtonEffect(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundTransparency = 0.3}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
    end)
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundTransparency = 0.2}):Play()
    end)
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundTransparency = 0.3}):Play()
    end)
end

local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Name = "TabButtonsFrame"
TabButtonsFrame.Size = UDim2.new(1, -20, 0, 40)
TabButtonsFrame.Position = UDim2.new(0, 10, 0, 50)
TabButtonsFrame.BackgroundTransparency = 1
TabButtonsFrame.Parent = MainFrame

local Tabs = {"Aimbot", "ESP", "Visuals", "Misc"}
local TabButtons = {}

for i, tabName in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName.."Tab"
    TabButton.Size = UDim2.new(0.2, -5, 1, 0)
    TabButton.Position = UDim2.new(0.2 * (i-1), 0, 0, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    TabButton.BackgroundTransparency = i == 1 and 0.5 or 0.8
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextSize = 14
    TabButton.Parent = TabButtonsFrame
    ButtonEffect(TabButton)
    table.insert(TabButtons, TabButton)
end

local TabContentFrame = Instance.new("Frame")
TabContentFrame.Name = "TabContentFrame"
TabContentFrame.Size = UDim2.new(1, -20, 1, -100)
TabContentFrame.Position = UDim2.new(0, 10, 0, 100)
TabContentFrame.BackgroundTransparency = 1
TabContentFrame.Parent = MainFrame

local AimbotTab = Instance.new("Frame")
AimbotTab.Name = "AimbotTab"
AimbotTab.Size = UDim2.new(1, 0, 1, 0)
AimbotTab.BackgroundTransparency = 1
AimbotTab.Visible = true
AimbotTab.Parent = TabContentFrame

local AimbotToggle = Instance.new("TextButton")
AimbotToggle.Name = "AimbotToggle"
AimbotToggle.Size = UDim2.new(1, 0, 0, 40)
AimbotToggle.Position = UDim2.new(0, 0, 0, 10)
AimbotToggle.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
AimbotToggle.BackgroundTransparency = 0.5
AimbotToggle.Text = "AIMBOT: OFF"
AimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotToggle.Font = Enum.Font.Gotham
AimbotToggle.TextSize = 16
AimbotToggle.Parent = AimbotTab
ButtonEffect(AimbotToggle)

local HeadshotToggle = Instance.new("TextButton")
HeadshotToggle.Name = "HeadshotToggle"
HeadshotToggle.Size = UDim2.new(1, 0, 0, 40)
HeadshotToggle.Position = UDim2.new(0, 0, 0, 60)
HeadshotToggle.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
HeadshotToggle.BackgroundTransparency = 0.5
HeadshotToggle.Text = "HEADSHOT: ON"
HeadshotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
HeadshotToggle.Font = Enum.Font.Gotham
HeadshotToggle.TextSize = 16
HeadshotToggle.Parent = AimbotTab
ButtonEffect(HeadshotToggle)

local SmoothToggle = Instance.new("TextButton")
SmoothToggle.Name = "SmoothToggle"
SmoothToggle.Size = UDim2.new(1, 0, 0, 40)
SmoothToggle.Position = UDim2.new(0, 0, 0, 110)
SmoothToggle.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
SmoothToggle.BackgroundTransparency = 0.5
SmoothToggle.Text = "SMOOTH AIM: ON"
SmoothToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SmoothToggle.Font = Enum.Font.Gotham
SmoothToggle.TextSize = 16
SmoothToggle.Parent = AimbotTab
ButtonEffect(SmoothToggle)

local ESPTab = Instance.new("Frame")
ESPTab.Name = "ESPTab"
ESPTab.Size = UDim2.new(1, 0, 1, 0)
ESPTab.BackgroundTransparency = 1
ESPTab.Visible = false
ESPTab.Parent = TabContentFrame

local ESPToggle = Instance.new("TextButton")
ESPToggle.Name = "ESPToggle"
ESPToggle.Size = UDim2.new(1, 0, 0, 40)
ESPToggle.Position = UDim2.new(0, 0, 0, 10)
ESPToggle.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
ESPToggle.BackgroundTransparency = 0.5
ESPToggle.Text = "ESP: OFF"
ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggle.Font = Enum.Font.Gotham
ESPToggle.TextSize = 16
ESPToggle.Parent = ESPTab
ButtonEffect(ESPToggle)

local VisualsTab = Instance.new("Frame")
VisualsTab.Name = "VisualsTab"
VisualsTab.Size = UDim2.new(1, 0, 1, 0)
VisualsTab.BackgroundTransparency = 1
VisualsTab.Visible = false
VisualsTab.Parent = TabContentFrame

local MiscTab = Instance.new("Frame")
MiscTab.Name = "MiscTab"
MiscTab.Size = UDim2.new(1, 0, 1, 0)
MiscTab.BackgroundTransparency = 1
MiscTab.Visible = false
MiscTab.Parent = TabContentFrame

for i, tabButton in ipairs(TabButtons) do
    tabButton.MouseButton1Click:Connect(function()
        for _, content in ipairs(TabContentFrame:GetChildren()) do
            content.Visible = false
        end
        for _, button in ipairs(TabButtons) do
            button.BackgroundTransparency = 0.8
        end
        tabButton.BackgroundTransparency = 0.5
        TabContentFrame:FindFirstChild(Tabs[i].."Tab").Visible = true
    end)
end

MainFrame.ClipsDescendants = true
MainFrame.BackgroundTransparency = 1
TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0.2}):Play()

local aimbotEnabled = false
local headshotEnabled = true
local smoothAimEnabled = true
local espEnabled = false
local espBoxes = {}

AimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotToggle.Text = "AIMBOT: "..(aimbotEnabled and "ON" or "OFF")
end)

HeadshotToggle.MouseButton1Click:Connect(function()
    headshotEnabled = not headshotEnabled
    HeadshotToggle.Text = "HEADSHOT: "..(headshotEnabled and "ON" or "OFF")
end)

SmoothToggle.MouseButton1Click:Connect(function()
    smoothAimEnabled = not smoothAimEnabled
    SmoothToggle.Text = "SMOOTH AIM: "..(smoothAimEnabled and "ON" or "OFF")
end)

ESPToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPToggle.Text = "ESP: "..(espEnabled and "ON" or "OFF")
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer and player.Character then
                createESP(player)
            end
        end
    else
        for _, box in pairs(espBoxes) do
            if box then box:Destroy() end
        end
        espBoxes = {}
    end
end)

function createESP(player)
    if espBoxes[player] then espBoxes[player]:Destroy() end
    
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESP_"..player.Name
    box.Adornee = humanoidRootPart
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Size = Vector3.new(3, 5, 3)
    box.Color3 = player.Team == Players.LocalPlayer.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    box.Transparency = 0.5
    box.Parent = game.CoreGui
    
    espBoxes[player] = box
    
    player.CharacterAdded:Connect(function(newChar)
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local closestPlayer = nil
        local closestDistance = math.huge
        local localPlayer = Players.LocalPlayer
        local camera = workspace.CurrentCamera
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local targetPart = headshotEnabled and player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
                if targetPart then
                    local screenPoint = camera:WorldToViewportPoint(targetPart.Position)
                    if screenPoint.Z > 0 then
                        local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
        
        if closestPlayer and closestPlayer.Character then
            local targetPart = headshotEnabled and closestPlayer.Character:FindFirstChild("Head") or closestPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                if smoothAimEnabled then
                    local currentCFrame = camera.CFrame
                    local targetCFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
                    camera.CFrame = currentCFrame:Lerp(targetCFrame, 0.3)
                else
                    camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
                end
            end
        end
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then
        player.CharacterAdded:Connect(function(char)
            if espEnabled then
                wait(1)
                createESP(player)
            end
        end)
        if player.Character and espEnabled then
            createESP(player)
        end
    end
end
