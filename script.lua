-- RedZ Hub Improved GUI Script
-- تطوير محسن لواجهة المستخدم بنمط RedZ Hub

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- متغيرات الحالة
local menuOpen = false
local currentTab = "General"

-- متغيرات المميزات
local features = {
    speedEnabled = false,
    currentSpeed = 16,
    flyEnabled = false,
    noClipEnabled = false,
    godModeEnabled = false,
    clickTPEnabled = false,
    wallHackEnabled = false,
    aimBotEnabled = false,
    spinBotEnabled = false,
    antiAfkEnabled = false,
    xRayEnabled = false,
    superJumpEnabled = false,
    gravityEnabled = false,
    fovEnabled = false,
    ctrlClickTPEnabled = false,
    teleportToPlayerEnabled = false,
    increasedDamageEnabled = false,
    noRecoilEnabled = false,
    aimbotEnabled = false,
    teleportToCheckpointEnabled = false,
    speedBoostEnabled = false,
    autoFarmEnabled = false,
    autoQuestEnabled = false,
    autoNewWorldEnabled = false,
    gardenAutoFarmEnabled = false,
    autoPlantEnabled = false,
    autoHarvestEnabled = false,
    autoFarmLevelEnabled = false,
    autoFarmNearestPlayerEnabled = false,
    autoCollectChestsEnabled = false,
    espFruitsEnabled = false,
    espPlayersEnabled = false,
    autoWaterEnabled = false,
    autoSellEnabled = false,
    instantGrowEnabled = false,
    bhopEnabled = false,
    autoParkourEnabled = false,
    noFallDamageEnabled = false
}

-- اتصالات الأحداث
local connections = {}

-- إنشاء الواجهة الرئيسية
local RedZHubGUI = Instance.new("ScreenGui")
RedZHubGUI.Name = "RedZHubGUI"
RedZHubGUI.Parent = game.CoreGui
RedZHubGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
RedZHubGUI.ResetOnSpawn = false

-- الزر العائم
local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 70, 0, 70)
FloatingButton.Position = UDim2.new(0, 20, 0.5, -35)
FloatingButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
FloatingButton.BackgroundTransparency = 0.1
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://84734916929333"
FloatingButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
FloatingButton.Parent = RedZHubGUI

-- تأثيرات الزر العائم
local FloatingCorner = Instance.new("UICorner")
FloatingCorner.CornerRadius = UDim.new(0, 35)
FloatingCorner.Parent = FloatingButton

local FloatingStroke = Instance.new("UIStroke")
FloatingStroke.Color = Color3.fromRGB(255, 50, 50)
FloatingStroke.Thickness = 2
FloatingStroke.Transparency = 0.3
FloatingStroke.Parent = FloatingButton

local FloatingGradient = Instance.new("UIGradient")
FloatingGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 30, 30))
}
FloatingGradient.Rotation = 45
FloatingGradient.Parent = FloatingButton

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 800, 0, 600)
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = RedZHubGUI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 50, 50)
MainStroke.Thickness = 1
MainStroke.Transparency = 0.5
MainStroke.Parent = MainFrame

-- شريط العنوان
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BackgroundTransparency = 0.1
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
}
TitleGradient.Rotation = 90
TitleGradient.Parent = TitleBar

-- شعار RedZ Hub
local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 40, 0, 40)
Logo.Position = UDim2.new(0, 10, 0, 5)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://84734916929333"
Logo.ImageColor3 = Color3.fromRGB(255, 50, 50)
Logo.Parent = TitleBar

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 20)
LogoCorner.Parent = Logo

-- عنوان التطبيق
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -120, 1, 0)
TitleLabel.Position = UDim2.new(0, 60, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "RedZ Hub - Enhanced Edition"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- زر الإغلاق
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BackgroundTransparency = 0.2
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 20)
CloseCorner.Parent = CloseButton

-- الشريط الجانبي
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 200, 1, -50)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Sidebar.BackgroundTransparency = 0.1
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 0)
SidebarCorner.Parent = Sidebar

-- منطقة المحتوى
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -200, 1, -50)
ContentArea.Position = UDim2.new(0, 200, 0, 50)
ContentArea.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
ContentArea.BackgroundTransparency = 0.1
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 0)
ContentCorner.Parent = ContentArea

-- إطار التمرير للمحتوى
local ContentScrollFrame = Instance.new("ScrollingFrame")
ContentScrollFrame.Name = "ContentScrollFrame"
ContentScrollFrame.Size = UDim2.new(1, -20, 1, -20)
ContentScrollFrame.Position = UDim2.new(0, 10, 0, 10)
ContentScrollFrame.BackgroundTransparency = 1
ContentScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScrollFrame.ScrollBarThickness = 8
ContentScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
ContentScrollFrame.BorderSizePixel = 0
ContentScrollFrame.Parent = ContentArea

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.Parent = ContentScrollFrame

-- تخطيط الشريط الجانبي
local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 5)
SidebarLayout.Parent = Sidebar

-- تبويبات الشريط الجانبي
local tabs = {
    {name = "General", icon = "🏠", features = {"Speed", "Fly", "NoClip", "GodMode", "ClickTP"}},
    {name = "Combat", icon = "⚔️", features = {"AimBot", "SpinBot", "NoRecoil", "IncreasedDamage"}},
    {name = "Farm", icon = "🌾", features = {"AutoFarm", "AutoQuest", "AutoCollectChests", "AutoSell"}},
    {name = "Visual", icon = "👁️", features = {"ESP", "WallHack", "XRay", "FOV"}},
    {name = "Teleport", icon = "🚀", features = {"TeleportToPlayer", "TeleportToCheckpoint", "CtrlClickTP"}},
    {name = "Misc", icon = "⚙️", features = {"AntiAFK", "SuperJump", "BHop", "NoFallDamage"}}
}

-- دالة إنشاء زر التبويب
local function createTabButton(tabData, index)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabData.name .. "Tab"
    tabButton.Size = UDim2.new(1, -10, 0, 45)
    tabButton.Position = UDim2.new(0, 5, 0, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabButton.BackgroundTransparency = 0.2
    tabButton.BorderSizePixel = 0
    tabButton.Text = tabData.icon .. "  " .. tabData.name
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.TextSize = 16
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.TextXAlignment = Enum.TextXAlignment.Left
    tabButton.LayoutOrder = index
    tabButton.Parent = Sidebar
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabButton
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingLeft = UDim.new(0, 15)
    tabPadding.Parent = tabButton
    
    -- تأثيرات التفاعل
    tabButton.MouseEnter:Connect(function()
        if currentTab ~= tabData.name then
            TweenService:Create(tabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if currentTab ~= tabData.name then
            TweenService:Create(tabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                TextColor3 = Color3.fromRGB(200, 200, 200)
            }):Play()
        end
    end)
    
    tabButton.MouseButton1Click:Connect(function()
        switchTab(tabData.name)
    end)
    
    return tabButton
end

-- دالة إنشاء زر الميزة
local function createFeatureButton(featureName, featureText, icon)
    local button = Instance.new("TextButton")
    button.Name = featureName .. "Button"
    button.Size = UDim2.new(1, 0, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.BackgroundTransparency = 0.1
    button.BorderSizePixel = 0
    button.Text = icon .. "  " .. featureText .. ": OFF"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16
    button.Font = Enum.Font.GothamSemibold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = ContentScrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button
    
    local buttonPadding = Instance.new("UIPadding")
    buttonPadding.PaddingLeft = UDim.new(0, 20)
    buttonPadding.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(50, 50, 50)
    buttonStroke.Thickness = 1
    buttonStroke.Transparency = 0.5
    buttonStroke.Parent = button
    
    -- تأثيرات التفاعل
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(45, 45, 45),
            TextSize = 17
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.15), {
            Transparency = 0.2
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            TextSize = 16
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.15), {
            Transparency = 0.5
        }):Play()
    end)
    
    return button
end

-- دالة إنشاء عنوان القسم
local function createSectionHeader(text)
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundTransparency = 1
    header.Text = text
    header.TextColor3 = Color3.fromRGB(255, 50, 50)
    header.TextSize = 20
    header.Font = Enum.Font.GothamBold
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = ContentScrollFrame
    
    local headerPadding = Instance.new("UIPadding")
    headerPadding.PaddingLeft = UDim.new(0, 10)
    headerPadding.Parent = header
    
    return header
end

-- دالة تبديل التبويبات
function switchTab(tabName)
    currentTab = tabName
    
    -- تحديث مظهر أزرار التبويبات
    for _, child in pairs(Sidebar:GetChildren()) do
        if child:IsA("TextButton") then
            if child.Name == tabName .. "Tab" then
                child.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                child.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                child.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                child.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
    end
    
    -- مسح المحتوى الحالي
    for _, child in pairs(ContentScrollFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end
    
    -- إضافة المحتوى الجديد
    createSectionHeader(tabName .. " Features")
    
    -- العثور على التبويب وإضافة مميزاته
    for _, tab in pairs(tabs) do
        if tab.name == tabName then
            for _, feature in pairs(tab.features) do
                local featureButton = createFeatureButton(feature, feature, "🔧")
                -- إضافة وظائف الميزات هنا
            end
            break
        end
    end
    
    -- تحديث حجم التمرير
    ContentScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
end

-- إنشاء أزرار التبويبات
for index, tab in pairs(tabs) do
    createTabButton(tab, index)
end

-- تفعيل التبويب الأول افتراضياً
switchTab("General")

-- وظائف التحكم في الواجهة
local function toggleMenu()
    menuOpen = not menuOpen
    MainFrame.Visible = menuOpen
    
    if menuOpen then
        -- تأثير الظهور
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 800, 0, 600),
            Position = UDim2.new(0.5, -400, 0.5, -300)
        }):Play()
    end
end

-- ربط الأحداث
FloatingButton.MouseButton1Click:Connect(toggleMenu)
CloseButton.MouseButton1Click:Connect(toggleMenu)

-- تأثيرات الزر العائم
FloatingButton.MouseEnter:Connect(function()
    TweenService:Create(FloatingButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 75, 0, 75),
        BackgroundTransparency = 0.05
    }):Play()
    TweenService:Create(FloatingStroke, TweenInfo.new(0.2), {
        Thickness = 3,
        Transparency = 0.1
    }):Play()
end)

FloatingButton.MouseLeave:Connect(function()
    TweenService:Create(FloatingButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 70, 0, 70),
        BackgroundTransparency = 0.1
    }):Play()
    TweenService:Create(FloatingStroke, TweenInfo.new(0.2), {
        Thickness = 2,
        Transparency = 0.3
    }):Play()
end)

-- تأثير دوران الزر العائم
spawn(function()
    while true do
        TweenService:Create(FloatingGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            Rotation = FloatingGradient.Rotation + 360
        }):Play()
        wait(2)
    end
end)

print("RedZ Hub Enhanced Edition loaded successfully!")



-- ===== إضافة المميزات المطلوبة =====

-- دالة تفعيل السرعة
local function toggleSpeed()
    features.speedEnabled = not features.speedEnabled
    
    if features.speedEnabled then
        spawn(function()
            while features.speedEnabled do
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        LocalPlayer.Character.Humanoid.WalkSpeed = features.currentSpeed
                    end
                end)
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
end

-- دالة تفعيل الطيران
local function toggleFly()
    features.flyEnabled = not features.flyEnabled
    
    if features.flyEnabled then
        if connections.infiniteJump then
            connections.infiniteJump:Disconnect()
        end
        connections.infiniteJump = UserInputService.JumpRequest:Connect(function()
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end)
    else
        if connections.infiniteJump then
            connections.infiniteJump:Disconnect()
            connections.infiniteJump = nil
        end
    end
end

-- دالة تفعيل NoClip
local function toggleNoClip()
    features.noClipEnabled = not features.noClipEnabled
    
    if features.noClipEnabled then
        if connections.noClip then
            connections.noClip:Disconnect()
        end
        connections.noClip = RunService.Stepped:Connect(function()
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
        if connections.noClip then
            connections.noClip:Disconnect()
            connections.noClip = nil
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
end

-- دالة تفعيل God Mode
local function toggleGodMode()
    features.godModeEnabled = not features.godModeEnabled
    
    if features.godModeEnabled then
        if connections.godMode then
            connections.godMode:Disconnect()
        end
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                connections.godMode = LocalPlayer.Character.Humanoid.HealthChanged:Connect(function(health)
                    if features.godModeEnabled and health < LocalPlayer.Character.Humanoid.MaxHealth then
                        LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
                    end
                end)
            end
        end)
    else
        if connections.godMode then
            connections.godMode:Disconnect()
            connections.godMode = nil
        end
    end
end

-- دالة تفعيل Click TP
local function toggleClickTP()
    features.clickTPEnabled = not features.clickTPEnabled
    
    if features.clickTPEnabled then
        if not connections.clickTP then
            connections.clickTP = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                if features.clickTPEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessedEvent then
                    local mouse = LocalPlayer:GetMouse()
                    local target = mouse.Target
                    local hitPos = mouse.Hit.p
                    
                    if target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hitPos + Vector3.new(0, 5, 0))
                    end
                end
            end)
        end
    end
end

-- دالة تفعيل AimBot
local function toggleAimBot()
    features.aimBotEnabled = not features.aimBotEnabled
    
    if features.aimBotEnabled then
        if connections.aimBot then
            connections.aimBot:Disconnect()
        end
        connections.aimBot = RunService.RenderStepped:Connect(function()
            if features.aimBotEnabled then
                pcall(function()
                    local nearestPlayer = nil
                    local shortestDistance = math.huge
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestPlayer = player
                            end
                        end
                    end
                    
                    if nearestPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local lookDirection = (nearestPlayer.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Unit
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(LocalPlayer.Character.HumanoidRootPart.Position, LocalPlayer.Character.HumanoidRootPart.Position + lookDirection)
                    end
                end)
            end
        end)
    else
        if connections.aimBot then
            connections.aimBot:Disconnect()
            connections.aimBot = nil
        end
    end
end

-- دالة تفعيل SpinBot
local function toggleSpinBot()
    features.spinBotEnabled = not features.spinBotEnabled
    
    if features.spinBotEnabled then
        if connections.spinBot then
            connections.spinBot:Disconnect()
        end
        connections.spinBot = RunService.RenderStepped:Connect(function()
            if features.spinBotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local rootPart = LocalPlayer.Character.HumanoidRootPart
                rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(15), 0)
            end
        end)
    else
        if connections.spinBot then
            connections.spinBot:Disconnect()
            connections.spinBot = nil
        end
    end
end

-- دالة تفعيل Auto Farm
local function toggleAutoFarm()
    features.autoFarmEnabled = not features.autoFarmEnabled
    
    if features.autoFarmEnabled then
        spawn(function()
            while features.autoFarmEnabled do
                pcall(function()
                    -- منطق Auto Farm هنا
                    -- يمكن تخصيصه حسب اللعبة
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name:find("Chest") or obj.Name:find("Coin") or obj.Name:find("Fruit") then
                            if obj:FindFirstChild("Handle") or obj:IsA("BasePart") then
                                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                                    wait(0.1)
                                end
                            end
                        end
                    end
                end)
                wait(1)
            end
        end)
    end
end

-- دالة تفعيل ESP
local function toggleESP()
    features.espPlayersEnabled = not features.espPlayersEnabled
    
    if features.espPlayersEnabled then
        spawn(function()
            while features.espPlayersEnabled do
                pcall(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            if not player.Character.HumanoidRootPart:FindFirstChild("ESP") then
                                local esp = Instance.new("BillboardGui")
                                esp.Name = "ESP"
                                esp.Size = UDim2.new(0, 100, 0, 50)
                                esp.StudsOffset = Vector3.new(0, 3, 0)
                                esp.Parent = player.Character.HumanoidRootPart
                                
                                local nameLabel = Instance.new("TextLabel")
                                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                                nameLabel.BackgroundTransparency = 1
                                nameLabel.Text = player.Name
                                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                                nameLabel.TextSize = 14
                                nameLabel.Font = Enum.Font.GothamBold
                                nameLabel.TextStrokeTransparency = 0
                                nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                                nameLabel.Parent = esp
                            end
                        end
                    end
                end)
                wait(1)
            end
        end)
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local esp = player.Character.HumanoidRootPart:FindFirstChild("ESP")
                if esp then
                    esp:Destroy()
                end
            end
        end
    end
end

-- دالة تفعيل Anti AFK
local function toggleAntiAFK()
    features.antiAfkEnabled = not features.antiAfkEnabled
    
    if features.antiAfkEnabled then
        if connections.antiAFK then
            connections.antiAFK:Disconnect()
        end
        connections.antiAFK = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            if features.antiAfkEnabled then
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end
        end)
    else
        if connections.antiAFK then
            connections.antiAFK:Disconnect()
            connections.antiAFK = nil
        end
    end
end

-- دالة تحديث نص الزر
local function updateButtonText(button, featureName, isEnabled)
    local icon = "🔧"
    if featureName == "Speed" then icon = "🏃"
    elseif featureName == "Fly" then icon = "✈️"
    elseif featureName == "NoClip" then icon = "👻"
    elseif featureName == "GodMode" then icon = "🛡️"
    elseif featureName == "ClickTP" then icon = "🖱️"
    elseif featureName == "AimBot" then icon = "🎯"
    elseif featureName == "SpinBot" then icon = "🔄"
    elseif featureName == "AutoFarm" then icon = "🌾"
    elseif featureName == "ESP" then icon = "👁️"
    elseif featureName == "AntiAFK" then icon = "⏰"
    end
    
    local status = isEnabled and "ON" or "OFF"
    button.Text = icon .. "  " .. featureName .. ": " .. status
    button.BackgroundColor3 = isEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(35, 35, 35)
end

-- تحديث دالة إنشاء زر الميزة لتشمل الوظائف
local function createFeatureButtonWithFunction(featureName, featureText, icon, toggleFunction)
    local button = createFeatureButton(featureName, featureText, icon)
    
    button.MouseButton1Click:Connect(function()
        toggleFunction()
        updateButtonText(button, featureText, features[featureName:lower() .. "Enabled"])
    end)
    
    return button
end

-- تحديث دالة تبديل التبويبات لتشمل الوظائف
function switchTab(tabName)
    currentTab = tabName
    
    -- تحديث مظهر أزرار التبويبات
    for _, child in pairs(Sidebar:GetChildren()) do
        if child:IsA("TextButton") then
            if child.Name == tabName .. "Tab" then
                child.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                child.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                child.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                child.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
    end
    
    -- مسح المحتوى الحالي
    for _, child in pairs(ContentScrollFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end
    
    -- إضافة المحتوى الجديد
    createSectionHeader(tabName .. " Features")
    
    -- إضافة المميزات حسب التبويب
    if tabName == "General" then
        createFeatureButtonWithFunction("speed", "Speed", "🏃", toggleSpeed)
        createFeatureButtonWithFunction("fly", "Fly", "✈️", toggleFly)
        createFeatureButtonWithFunction("noClip", "NoClip", "👻", toggleNoClip)
        createFeatureButtonWithFunction("godMode", "GodMode", "🛡️", toggleGodMode)
        createFeatureButtonWithFunction("clickTP", "ClickTP", "🖱️", toggleClickTP)
    elseif tabName == "Combat" then
        createFeatureButtonWithFunction("aimBot", "AimBot", "🎯", toggleAimBot)
        createFeatureButtonWithFunction("spinBot", "SpinBot", "🔄", toggleSpinBot)
    elseif tabName == "Farm" then
        createFeatureButtonWithFunction("autoFarm", "AutoFarm", "🌾", toggleAutoFarm)
    elseif tabName == "Visual" then
        createFeatureButtonWithFunction("esp", "ESP", "👁️", toggleESP)
    elseif tabName == "Misc" then
        createFeatureButtonWithFunction("antiAfk", "AntiAFK", "⏰", toggleAntiAFK)
    end
    
    -- تحديث حجم التمرير
    ContentScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
end

-- دالة تنظيف الاتصالات عند إغلاق الواجهة
local function cleanup()
    for name, connection in pairs(connections) do
        if connection then
            connection:Disconnect()
        end
    end
    connections = {}
end

-- ربط دالة التنظيف بإغلاق اللعبة
game:BindToClose(cleanup)

print("RedZ Hub Enhanced Edition with full features loaded successfully!")

