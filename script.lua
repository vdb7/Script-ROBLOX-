-- الخدمات المطلوبة
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- المتغيرات الأساسية
local LocalPlayer = Players.LocalPlayer
local espEnabled = false
local espBoxes = {}
local menuOpen = false
local isDragging = false

-- إنشاء واجهة المستخدم الرئيسية
local function createMainGUI()
    local DeltaGUI = Instance.new("ScreenGui")
    DeltaGUI.Name = "EnhancedHackGUI"
    DeltaGUI.Parent = game.CoreGui
    DeltaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    DeltaGUI.ResetOnSpawn = false
    
    return DeltaGUI
end

-- إنشاء الزر العائم مع تحسينات
local function createFloatingButton(parent)
    local FloatingButton = Instance.new("ImageButton")
    FloatingButton.Name = "FloatingButton"
    FloatingButton.Size = UDim2.new(0, 70, 0, 70)
    FloatingButton.Position = UDim2.new(0, 20, 0.5, -35)
    FloatingButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    FloatingButton.BackgroundTransparency = 0.2
    FloatingButton.BorderSizePixel = 0
    FloatingButton.Image = "rbxassetid://3926305904"
    FloatingButton.ImageColor3 = Color3.fromRGB(0, 200, 255)
    FloatingButton.Parent = parent
    
    -- إضافة تأثيرات بصرية
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 35)
    Corner.Parent = FloatingButton
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 200, 255)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.5
    Stroke.Parent = FloatingButton
    
    -- تأثير الضوء
    local Glow = Instance.new("ImageLabel")
    Glow.Name = "Glow"
    Glow.Size = UDim2.new(1.5, 0, 1.5, 0)
    Glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    Glow.BackgroundTransparency = 1
    Glow.Image = "rbxassetid://241650934"
    Glow.ImageColor3 = Color3.fromRGB(0, 200, 255)
    Glow.ImageTransparency = 0.8
    Glow.Parent = FloatingButton
    
    return FloatingButton
end

-- إنشاء القائمة الرئيسية مع تحسينات
local function createMainMenu(parent)
    local MenuFrame = Instance.new("Frame")
    MenuFrame.Name = "MenuFrame"
    MenuFrame.Size = UDim2.new(0, 350, 0, 400)
    MenuFrame.Position = UDim2.new(0, 100, 0.5, -200)
    MenuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MenuFrame.BackgroundTransparency = 0.05
    MenuFrame.BorderSizePixel = 0
    MenuFrame.Visible = false
    MenuFrame.Parent = parent
    
    -- إضافة تأثيرات بصرية للقائمة
    local MenuCorner = Instance.new("UICorner")
    MenuCorner.CornerRadius = UDim.new(0, 15)
    MenuCorner.Parent = MenuFrame
    
    local MenuStroke = Instance.new("UIStroke")
    MenuStroke.Color = Color3.fromRGB(0, 150, 255)
    MenuStroke.Thickness = 2
    MenuStroke.Transparency = 0.3
    MenuStroke.Parent = MenuFrame
    
    -- إضافة ظل
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.8
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.Parent = MenuFrame
    
    return MenuFrame
end

-- إنشاء شريط العنوان المحسن
local function createTitleBar(parent)
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    TitleBar.BackgroundTransparency = 0.1
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = parent
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 15)
    TitleCorner.Parent = TitleBar
    
    -- إضافة تدرج لوني
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 200))
    }
    Gradient.Rotation = 45
    Gradient.Parent = TitleBar
    
    -- عنوان محسن
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "🚀 ENHANCED HACK GUI"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar
    
    -- زر الإغلاق المحسن
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 35, 0, 35)
    CloseButton.Position = UDim2.new(1, -45, 0, 7.5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    CloseButton.BackgroundTransparency = 0.2
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 16
    CloseButton.Parent = TitleBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 17.5)
    CloseCorner.Parent = CloseButton
    
    return TitleBar, CloseButton
end

-- إنشاء إطار التمرير المحسن
local function createScrollingFrame(parent)
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, -20, 1, -70)
    ScrollingFrame.Position = UDim2.new(0, 10, 0, 60)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
    ScrollingFrame.ScrollBarThickness = 8
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    ScrollingFrame.Parent = parent
    
    -- تخطيط الأزرار
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = ScrollingFrame
    
    return ScrollingFrame
end

-- دالة محسنة لإنشاء الأزرار
local function createEnhancedButton(parent, name, text, color, icon)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -20, 0, 45)
    button.BackgroundColor3 = color or Color3.fromRGB(40, 40, 55)
    button.BackgroundTransparency = 0.2
    button.BorderSizePixel = 0
    button.Text = (icon or "🔧") .. " " .. text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(100, 100, 120)
    buttonStroke.Thickness = 1
    buttonStroke.Transparency = 0.5
    buttonStroke.Parent = button
    
    -- تأثير التمرير
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.1,
            TextSize = 15
        })
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.2,
            TextSize = 14
        })
        tween:Play()
    end)
    
    return button
end

-- نظام ESP محسن
local function createAdvancedESP(player)
    if espBoxes[player] or not player.Character then return end
    
    local character = player.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- إنشاء Highlight
    local espBox = Instance.new("Highlight")
    espBox.Name = player.Name.."_ESP"
    espBox.OutlineColor = Color3.fromRGB(255, 100, 100)
    espBox.FillColor = Color3.fromRGB(255, 100, 100)
    espBox.FillTransparency = 0.7
    espBox.OutlineTransparency = 0.3
    espBox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    espBox.Parent = character
    espBox.Adornee = character
    
    -- إضافة نص المسافة
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = player.Name.."_DistanceLabel"
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = humanoidRootPart
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 1, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Text = player.Name
    distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distanceLabel.TextSize = 16
    distanceLabel.Font = Enum.Font.GothamBold
    distanceLabel.TextStrokeTransparency = 0.5
    distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distanceLabel.Parent = billboardGui
    
    espBoxes[player] = {highlight = espBox, billboard = billboardGui}
    
    -- تحديث المسافة
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not player.Character or not LocalPlayer.Character then
            connection:Disconnect()
            return
        end
        
        local localHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local playerHRP = player.Character:FindFirstChild("HumanoidRootPart")
        
        if localHRP and playerHRP then
            local distance = math.floor((localHRP.Position - playerHRP.Position).Magnitude)
            distanceLabel.Text = player.Name .. "\n[" .. distance .. "m]"
        end
    end)
end

local function removeAdvancedESP(player)
    if espBoxes[player] then
        if espBoxes[player].highlight then
            espBoxes[player].highlight:Destroy()
        end
        if espBoxes[player].billboard then
            espBoxes[player].billboard:Destroy()
        end
        espBoxes[player] = nil
    end
end

-- دالة تبديل ESP محسنة
local function toggleAdvancedESP(button)
    espEnabled = not espEnabled
    button.Text = (espEnabled and "👁️ ESP: ON" or "👁️ ESP: OFF")
    button.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(40, 40, 55)
    
    if espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                createAdvancedESP(player)
            end
        end
    else
        for player, _ in pairs(espBoxes) do
            removeAdvancedESP(player)
        end
    end
end

-- ميزات إضافية جديدة
local function createSpeedHack(button)
    local speedEnabled = false
    local originalWalkSpeed = 16
    
    button.MouseButton1Click:Connect(function()
        speedEnabled = not speedEnabled
        button.Text = speedEnabled and "🏃 SPEED: ON" or "🏃 SPEED: OFF"
        button.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(40, 40, 55)
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speedEnabled and 50 or originalWalkSpeed
        end
    end)
end

local function createJumpHack(button)
    local jumpEnabled = false
    local originalJumpPower = 50
    
    button.MouseButton1Click:Connect(function()
        jumpEnabled = not jumpEnabled
        button.Text = jumpEnabled and "🦘 JUMP: ON" or "🦘 JUMP: OFF"
        button.BackgroundColor3 = jumpEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(40, 40, 55)
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = jumpEnabled and 120 or originalJumpPower
        end
    end)
end

local function createFullbright(button)
    local fullbrightEnabled = false
    local originalAmbient = Lighting.Ambient
    local originalBrightness = Lighting.Brightness
    
    button.MouseButton1Click:Connect(function()
        fullbrightEnabled = not fullbrightEnabled
        button.Text = fullbrightEnabled and "💡 FULLBRIGHT: ON" or "💡 FULLBRIGHT: OFF"
        button.BackgroundColor3 = fullbrightEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(40, 40, 55)
        
        if fullbrightEnabled then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2
        else
            Lighting.Ambient = originalAmbient
            Lighting.Brightness = originalBrightness
        end
    end)
end

-- إنشاء الواجهة الكاملة
local function initializeGUI()
    local mainGUI = createMainGUI()
    local floatingButton = createFloatingButton(mainGUI)
    local menuFrame = createMainMenu(mainGUI)
    local titleBar, closeButton = createTitleBar(menuFrame)
    local scrollingFrame = createScrollingFrame(menuFrame)
    
    -- إنشاء الأزرار
    local espButton = createEnhancedButton(scrollingFrame, "ESPButton", "ESP: OFF", nil, "👁️")
    local speedButton = createEnhancedButton(scrollingFrame, "SpeedButton", "SPEED: OFF", nil, "🏃")
    local jumpButton = createEnhancedButton(scrollingFrame, "JumpButton", "JUMP: OFF", nil, "🦘")
    local fullbrightButton = createEnhancedButton(scrollingFrame, "FullbrightButton", "FULLBRIGHT: OFF", nil, "💡")
    local developerButton = createEnhancedButton(scrollingFrame, "DeveloperButton", "DEVELOPER", Color3.fromRGB(120, 0, 200), "👨‍💻")
    
    -- ربط الوظائف
    espButton.MouseButton1Click:Connect(function() toggleAdvancedESP(espButton) end)
    createSpeedHack(speedButton)
    createJumpHack(jumpButton)
    createFullbright(fullbrightButton)
    
    -- زر المطور مع تأثيرات محسنة
    local colors = {
        Color3.fromRGB(255, 100, 100),
        Color3.fromRGB(100, 255, 100),
        Color3.fromRGB(100, 100, 255),
        Color3.fromRGB(255, 255, 100),
        Color3.fromRGB(255, 100, 255),
        Color3.fromRGB(100, 255, 255),
        Color3.fromRGB(255, 150, 100),
        Color3.fromRGB(150, 100, 255)
    }
    local colorIndex = 1
    
    developerButton.MouseButton1Click:Connect(function()
        colorIndex = colorIndex % #colors + 1
        local tween = TweenService:Create(developerButton, TweenInfo.new(0.3), {
            BackgroundColor3 = colors[colorIndex]
        })
        tween:Play()
        
        if setclipboard then
            setclipboard("https://t.me/XVSJQ")
        end
    end)
    
    -- التحكم في فتح/إغلاق القائمة
    closeButton.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(menuFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, 225, 0.5, 0)
        })
        tween:Play()
        tween.Completed:Connect(function()
            menuFrame.Visible = false
            menuOpen = false
        end)
    end)
    
    floatingButton.MouseButton1Click:Connect(function()
        menuOpen = not menuOpen
        if menuOpen then
            menuFrame.Size = UDim2.new(0, 0, 0, 0)
            menuFrame.Position = UDim2.new(0, 225, 0.5, 0)
            menuFrame.Visible = true
            local tween = TweenService:Create(menuFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(0, 350, 0, 400),
                Position = UDim2.new(0, 100, 0.5, -200)
            })
            tween:Play()
        else
            local tween = TweenService:Create(menuFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0, 225, 0.5, 0)
            })
            tween:Play()
            tween.Completed:Connect(function()
                menuFrame.Visible = false
            end)
        end
    end)
    
    -- اختصار لوحة المفاتيح
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightControl then
            floatingButton.MouseButton1Click:Fire()
        end
    end)
    
    -- تمكين السحب المحسن
    local dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStart = input.Position
            startPos = menuFrame.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDragging = false
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            menuFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- تشغيل الواجهة
initializeGUI()

-- إضافة معالج للاعبين الجدد
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if espEnabled then
            wait(1) -- انتظار تحميل الشخصية
            createAdvancedESP(player)
        end
    end)
end)

print("✅ Enhanced Hack GUI تم تحميله بنجاح!")
print("🎮 استخدم Right Control لفتح/إغلاق القائمة")
