local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESPUI"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = mainFrame

local backgroundImage = Instance.new("ImageLabel")
backgroundImage.Size = UDim2.new(1, 0, 1, 0)
backgroundImage.Position = UDim2.new(0, 0, 0, 0)
backgroundImage.Image = "https://www.mediafire.com/convkey/4c5b/l2yy41tfqm4gknm6g.jpg"
backgroundImage.BackgroundTransparency = 1
backgroundImage.ImageTransparency = 0.3
backgroundImage.Parent = mainFrame

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(1, 0)
imageCorner.Parent = backgroundImage

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
}
gradient.Rotation = 45
gradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.5),
    NumberSequenceKeypoint.new(1, 0.8)
}
gradient.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 30)
titleLabel.Text = "نظام الهاك المتقدم"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.85, 0, 0.65, 0)
scrollFrame.Position = UDim2.new(0.075, 0, 0.25, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
scrollFrame.Parent = mainFrame

local buttonLayout = Instance.new("UIListLayout")
buttonLayout.Padding = UDim.new(0, 12)
buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
buttonLayout.FillDirection = Enum.FillDirection.Vertical
buttonLayout.Parent = scrollFrame

local function createButton(text, color, order)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 35)
    button.Text = text
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BorderSizePixel = 0
    button.TextScaled = true
    button.Font = Enum.Font.GothamSemibold
    button.LayoutOrder = order
    button.Parent = scrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.7
    stroke.Thickness = 2
    stroke.Parent = button
    
    button.MouseButton1Down:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0.95, 0, 0, 32)})
        tween:Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 35)})
        tween:Play()
    end)
    
    return button
end

local toggleButton = createButton("تشغيل كاشف الأماكن", Color3.fromRGB(85, 170, 255), 1)
local wallhackButton = createButton("تشغيل اختراق الجدران", Color3.fromRGB(255, 100, 100), 2)
local speedButton = createButton("تسريع الشخصية", Color3.fromRGB(100, 255, 100), 3)
local jumpButton = createButton("قفز عالي", Color3.fromRGB(255, 255, 100), 4)
local flyButton = createButton("تشغيل الطيران", Color3.fromRGB(200, 100, 255), 5)
local teleportButton = createButton("انتقال للاعبين", Color3.fromRGB(255, 150, 50), 6)
local changeAppearanceButton = createButton("تغيير الشكل", Color3.fromRGB(150, 255, 200), 7)
local noClipButton = createButton("تخطي الحواجز", Color3.fromRGB(255, 200, 100), 8)
local infiniteJumpButton = createButton("قفز لا نهائي", Color3.fromRGB(100, 200, 255), 9)
local godModeButton = createButton("وضع الحماية", Color3.fromRGB(255, 50, 150), 10)

local espEnabled = false
local wallhackEnabled = false
local speedEnabled = false
local jumpEnabled = false
local flyEnabled = false
local noClipEnabled = false
local infiniteJumpEnabled = false
local godModeEnabled = false
local espObjects = {}
local connections = {}
local originalWalkSpeed = 16
local originalJumpPower = 50
local flyBodyVelocity = nil
local flyBodyAngularVelocity = nil

local dragging = false
local dragStart = nil
local startPos = nil

local function makeDraggable(frame)
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end)
end

makeDraggable(mainFrame)

local function createESP(part)
    if not part:FindFirstChild("ESP_Detector") then
        local esp = Instance.new("Highlight")
        esp.Name = "ESP_Detector"
        esp.FillColor = Color3.fromRGB(255, 50, 50)
        esp.OutlineColor = Color3.fromRGB(255, 255, 0)
        esp.FillTransparency = 0.6
        esp.OutlineTransparency = 0.2
        esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        esp.Parent = part
        table.insert(espObjects, esp)
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        toggleButton.Text = "إيقاف كاشف الأماكن"
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= player then
                local character = otherPlayer.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        createESP(humanoidRootPart)
                    end
                    
                    for _, part in ipairs(character:GetChildren()) do
                        if part:IsA("BasePart") then
                            createESP(part)
                        end
                    end
                end
            end
        end
        
        connections.playerAdded = Players.PlayerAdded:Connect(function(newPlayer)
            local character = newPlayer.Character
            if character then
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                createESP(humanoidRootPart)
                
                for _, part in ipairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        createESP(part)
                    end
                end
            end
        end)
        
        connections.characterAdded = player.CharacterAdded:Connect(function(character)
            for _, otherPlayer in ipairs(Players:GetPlayers()) do
                if otherPlayer ~= player then
                    local otherCharacter = otherPlayer.Character
                    if otherCharacter then
                        for _, part in ipairs(otherCharacter:GetChildren()) do
                            if part:IsA("BasePart") and part:FindFirstChild("ESP_Detector") then
                                part.ESP_Detector:Destroy()
                            end
                        end
                    end
                end
            end
        end)
        
    else
        toggleButton.Text = "تشغيل كاشف الأماكن"
        toggleButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
        
        for _, esp in ipairs(espObjects) do
            esp:Destroy()
        end
        espObjects = {}
        
        for _, connection in pairs(connections) do
            connection:Disconnect()
        end
        connections = {}
    end
end

local function toggleWallhack()
    wallhackEnabled = not wallhackEnabled
    
    if wallhackEnabled then
        wallhackButton.Text = "إيقاف اختراق الجدران"
        wallhackButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        
        local character = player.Character
        if character then
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    else
        wallhackButton.Text = "تشغيل اختراق الجدران"
        wallhackButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        
        local character = player.Character
        if character then
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end

local function toggleSpeed()
    speedEnabled = not speedEnabled
    
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if speedEnabled then
                speedButton.Text = "إيقاف السرعة"
                speedButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                originalWalkSpeed = humanoid.WalkSpeed
                humanoid.WalkSpeed = 100
            else
                speedButton.Text = "تسريع الشخصية"
                speedButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
                humanoid.WalkSpeed = originalWalkSpeed
            end
        end
    end
end

local function toggleJump()
    jumpEnabled = not jumpEnabled
    
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if jumpEnabled then
                jumpButton.Text = "إيقاف القفز العالي"
                jumpButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                originalJumpPower = humanoid.JumpPower
                humanoid.JumpPower = 200
            else
                jumpButton.Text = "قفز عالي"
                jumpButton.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
                humanoid.JumpPower = originalJumpPower
            end
        end
    end
end

local function toggleFly()
    flyEnabled = not flyEnabled
    
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            if flyEnabled then
                flyButton.Text = "إيقاف الطيران"
                flyButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                
                flyBodyVelocity = Instance.new("BodyVelocity")
                flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                flyBodyVelocity.Parent = humanoidRootPart
                
                flyBodyAngularVelocity = Instance.new("BodyAngularVelocity")
                flyBodyAngularVelocity.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                flyBodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
                flyBodyAngularVelocity.Parent = humanoidRootPart
                
                connections.flyConnection = RunService.Heartbeat:Connect(function()
                    if flyBodyVelocity and humanoidRootPart then
                        local camera = workspace.CurrentCamera
                        local direction = Vector3.new(0, 0, 0)
                        
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                            direction = direction + camera.CFrame.LookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                            direction = direction - camera.CFrame.LookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                            direction = direction - camera.CFrame.RightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                            direction = direction + camera.CFrame.RightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            direction = direction + Vector3.new(0, 1, 0)
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                            direction = direction - Vector3.new(0, 1, 0)
                        end
                        
                        flyBodyVelocity.Velocity = direction * 50
                    end
                end)
            else
                flyButton.Text = "تشغيل الطيران"
                flyButton.BackgroundColor3 = Color3.fromRGB(200, 100, 255)
                
                if flyBodyVelocity then
                    flyBodyVelocity:Destroy()
                    flyBodyVelocity = nil
                end
                if flyBodyAngularVelocity then
                    flyBodyAngularVelocity:Destroy()
                    flyBodyAngularVelocity = nil
                end
                if connections.flyConnection then
                    connections.flyConnection:Disconnect()
                    connections.flyConnection = nil
                end
            end
        end
    end
end

local function teleportToPlayer()
    local randomPlayer = Players:GetPlayers()[math.random(1, #Players:GetPlayers())]
    if randomPlayer and randomPlayer ~= player then
        local character = player.Character
        local targetCharacter = randomPlayer.Character
        
        if character and targetCharacter then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
            
            if humanoidRootPart and targetRootPart then
                humanoidRootPart.CFrame = targetRootPart.CFrame + Vector3.new(0, 5, 0)
            end
        end
    end
end

local function changeAppearance()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            local allPlayers = Players:GetPlayers()
            if #allPlayers > 0 then
                local randomPlayer = allPlayers[math.random(1, #allPlayers)]
                local success = pcall(function()
                    humanoid:LoadCharacterAppearance(randomPlayer.UserId)
                end)
                
                if success then
                    for _, part in ipairs(character:GetChildren()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.BrickColor = BrickColor.Random()
                        end
                    end
                end
            end
        end
    end
end

local function toggleNoClip()
    noClipEnabled = not noClipEnabled
    
    if noClipEnabled then
        noClipButton.Text = "إيقاف تخطي الحواجز"
        noClipButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        
        connections.noClipConnection = RunService.Heartbeat:Connect(function()
            local character = player.Character
            if character then
                for _, part in ipairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        noClipButton.Text = "تخطي الحواجز"
        noClipButton.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
        
        if connections.noClipConnection then
            connections.noClipConnection:Disconnect()
            connections.noClipConnection = nil
        end
        
        local character = player.Character
        if character then
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end

local function toggleInfiniteJump()
    infiniteJumpEnabled = not infiniteJumpEnabled
    
    if infiniteJumpEnabled then
        infiniteJumpButton.Text = "إيقاف القفز اللانهائي"
        infiniteJumpButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        
        connections.infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        infiniteJumpButton.Text = "قفز لا نهائي"
        infiniteJumpButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
        
        if connections.infiniteJumpConnection then
            connections.infiniteJumpConnection:Disconnect()
            connections.infiniteJumpConnection = nil
        end
    end
end

local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if godModeEnabled then
                godModeButton.Text = "إيقاف الحماية"
                godModeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                
                connections.godModeConnection = humanoid.HealthChanged:Connect(function()
                    if godModeEnabled then
                        humanoid.Health = humanoid.MaxHealth
                    end
                end)
                
                humanoid.Health = humanoid.MaxHealth
            else
                godModeButton.Text = "وضع الحماية"
                godModeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
                
                if connections.godModeConnection then
                    connections.godModeConnection:Disconnect()
                    connections.godModeConnection = nil
                end
            end
        end
    end
end

toggleButton.MouseButton1Click:Connect(toggleESP)
wallhackButton.MouseButton1Click:Connect(toggleWallhack)
speedButton.MouseButton1Click:Connect(toggleSpeed)
jumpButton.MouseButton1Click:Connect(toggleJump)
flyButton.MouseButton1Click:Connect(toggleFly)
teleportButton.MouseButton1Click:Connect(teleportToPlayer)
changeAppearanceButton.MouseButton1Click:Connect(changeAppearance)
noClipButton.MouseButton1Click:Connect(toggleNoClip)
infiniteJumpButton.MouseButton1Click:Connect(toggleInfiniteJump)
godModeButton.MouseButton1Click:Connect(toggleGodMode)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.H then
            toggleESP()
        elseif input.KeyCode == Enum.KeyCode.G then
            toggleWallhack()
        elseif input.KeyCode == Enum.KeyCode.J then
            toggleSpeed()
        elseif input.KeyCode == Enum.KeyCode.K then
            toggleJump()
        elseif input.KeyCode == Enum.KeyCode.F then
            toggleFly()
        elseif input.KeyCode == Enum.KeyCode.T then
            teleportToPlayer()
        elseif input.KeyCode == Enum.KeyCode.C then
            changeAppearance()
        elseif input.KeyCode == Enum.KeyCode.N then
            toggleNoClip()
        elseif input.KeyCode == Enum.KeyCode.I then
            toggleInfiniteJump()
        elseif input.KeyCode == Enum.KeyCode.P then
            toggleGodMode()
        end
    end
end)
