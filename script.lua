local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local MiniGUI = Instance.new("ScreenGui")
MiniGUI.Name = "MiniDeltaGUI"
MiniGUI.Parent = game.CoreGui
MiniGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 50, 0, 50)
MainFrame.Position = UDim2.new(0, 10, 0, 200)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MiniGUI

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(1, 0, 1, 0)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://75797852451386"
Logo.Parent = MainFrame

local ExpandedFrame = Instance.new("Frame")
ExpandedFrame.Name = "ExpandedFrame"
ExpandedFrame.Size = UDim2.new(0, 200, 0, 150)
ExpandedFrame.Position = UDim2.new(1, 5, 0, 0)
ExpandedFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ExpandedFrame.BackgroundTransparency = 0.2
ExpandedFrame.BorderSizePixel = 0
ExpandedFrame.Visible = false
ExpandedFrame.Parent = MainFrame

local AimbotBtn = Instance.new("TextButton")
AimbotBtn.Name = "AimbotBtn"
AimbotBtn.Size = UDim2.new(1, 0, 0, 40)
AimbotBtn.Position = UDim2.new(0, 0, 0, 0)
AimbotBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
AimbotBtn.BackgroundTransparency = 0.5
AimbotBtn.Text = "AIMBOT: OFF"
AimbotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotBtn.Font = Enum.Font.Gotham
AimbotBtn.TextSize = 14
AimbotBtn.Parent = ExpandedFrame

local ESPBtn = Instance.new("TextButton")
ESPBtn.Name = "ESPBtn"
ESPBtn.Size = UDim2.new(1, 0, 0, 40)
ESPBtn.Position = UDim2.new(0, 0, 0, 50)
ESPBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
ESPBtn.BackgroundTransparency = 0.5
ESPBtn.Text = "ESP: OFF"
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.Font = Enum.Font.Gotham
ESPBtn.TextSize = 14
ESPBtn.Parent = ExpandedFrame

local MagicBulletBtn = Instance.new("TextButton")
MagicBulletBtn.Name = "MagicBulletBtn"
MagicBulletBtn.Size = UDim2.new(1, 0, 0, 40)
MagicBulletBtn.Position = UDim2.new(0, 0, 0, 100)
MagicBulletBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
MagicBulletBtn.BackgroundTransparency = 0.5
MagicBulletBtn.Text = "MAGIC BULLET: OFF"
MagicBulletBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MagicBulletBtn.Font = Enum.Font.Gotham
MagicBulletBtn.TextSize = 14
MagicBulletBtn.Parent = ExpandedFrame

local espEnabled = false
local aimbotEnabled = false
local magicBulletEnabled = false
local espBoxes = {}

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        ExpandedFrame.Visible = not ExpandedFrame.Visible
    end
end)

AimbotBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotBtn.Text = "AIMBOT: "..(aimbotEnabled and "ON" or "OFF")
end)

ESPBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPBtn.Text = "ESP: "..(espEnabled and "ON" or "OFF")
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

MagicBulletBtn.MouseButton1Click:Connect(function()
    magicBulletEnabled = not magicBulletEnabled
    MagicBulletBtn.Text = "MAGIC BULLET: "..(magicBulletEnabled and "ON" or "OFF")
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

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local closestPlayer = nil
        local closestDistance = math.huge
        local localPlayer = Players.LocalPlayer
        local camera = workspace.CurrentCamera
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local targetPart = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
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
            local targetPart = closestPlayer.Character:FindFirstChild("Head") or closestPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
            end
        end
    end
    
    if magicBulletEnabled then
        local localPlayer = Players.LocalPlayer
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local targetPart = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
                    if targetPart then
                        local bullets = workspace:FindPartsInRegion3(
                            Region3.new(
                                localPlayer.Character.HumanoidRootPart.Position - Vector3.new(0.5, 0.5, 0.5),
                                localPlayer.Character.HumanoidRootPart.Position + Vector3.new(0.5, 0.5, 0.5)
                            ),
                            nil,
                            100
                        )
                        for _, bullet in ipairs(bullets) do
                            if bullet:IsA("BasePart") and bullet.Velocity.Magnitude > 50 then
                                bullet.Velocity = (targetPart.Position - bullet.Position).Unit * bullet.Velocity.Magnitude
                            end
                        end
                    end
                end
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
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
