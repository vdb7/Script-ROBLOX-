local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

local BloxFruitsGUI = Instance.new("ScreenGui")
BloxFruitsGUI.Name = "RedZStyleGUI"
BloxFruitsGUI.Parent = game.CoreGui
BloxFruitsGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 70, 0, 70)
FloatingButton.Position = UDim2.new(0, 20, 0.5, -35)
FloatingButton.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
FloatingButton.BackgroundTransparency = 0.1
FloatingButton.BorderSizePixel = 0
FloatingButton.Image = "rbxassetid://3926305904"
FloatingButton.ImageColor3 = Color3.fromRGB(255, 140, 0)
FloatingButton.Parent = BloxFruitsGUI

local FloatingCorner = Instance.new("UICorner")
FloatingCorner.CornerRadius = UDim.new(0, 35)
FloatingCorner.Parent = FloatingButton

local FloatingGlow = Instance.new("ImageLabel")
FloatingGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
FloatingGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
FloatingGlow.BackgroundTransparency = 1
FloatingGlow.Image = "rbxassetid://3570695787"
FloatingGlow.ImageColor3 = Color3.fromRGB(255, 140, 0)
FloatingGlow.ImageTransparency = 0.5
FloatingGlow.Parent = FloatingButton

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 600)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.02
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = BloxFruitsGUI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 140, 0)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
TitleBar.BackgroundTransparency = 0.05
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -120, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🍇 BLOX FRUITS - RedZ Style �"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(1, -90, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
MinimizeButton.BackgroundTransparency = 0.2
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.BackgroundTransparency = 0.2
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleBar

local function addCorners(parent)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = parent
end

addCorners(MinimizeButton)
addCorners(CloseButton)

local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, -10, 0, 45)
TabFrame.Position = UDim2.new(0, 5, 0, 55)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

local function createTab(name, position, text, icon)
    local tab = Instance.new("TextButton")
    tab.Name = name
    tab.Size = UDim2.new(0.2, -4, 1, 0)
    tab.Position = position
    tab.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    tab.BackgroundTransparency = 0.2
    tab.BorderSizePixel = 0
    tab.Text = icon.." "..text
    tab.TextColor3 = Color3.fromRGB(200, 200, 200)
    tab.TextSize = 12
    tab.Font = Enum.Font.Gotham
    tab.Parent = TabFrame
    addCorners(tab)
    return tab
end

local MainTab = createTab("MainTab", UDim2.new(0, 0, 0, 0), "MAIN", "🏠")
local FarmTab = createTab("FarmTab", UDim2.new(0.2, 0, 0, 0), "FARM", "⚔️")
local PlayerTab = createTab("PlayerTab", UDim2.new(0.4, 0, 0, 0), "PLAYER", "🏃")
local TeleportTab = createTab("TeleportTab", UDim2.new(0.6, 0, 0, 0), "TELEPORT", "🌊")
local MiscTab = createTab("MiscTab", UDim2.new(0.8, 0, 0, 0), "MISC", "⚙️")

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -10, 1, -110)
ContentFrame.Position = UDim2.new(0, 5, 0, 105)
ContentFrame.BackgroundTransparency = 1
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 1200)
ContentFrame.ScrollBarThickness = 8
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
ContentFrame.Parent = MainFrame

local TeleportMenu = Instance.new("Frame")
TeleportMenu.Name = "TeleportMenu"
TeleportMenu.Size = UDim2.new(0, 300, 0, 400)
TeleportMenu.Position = UDim2.new(0.5, -150, 0.5, -200)
TeleportMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TeleportMenu.BackgroundTransparency = 0.05
TeleportMenu.BorderSizePixel = 0
TeleportMenu.Visible = false
TeleportMenu.Parent = BloxFruitsGUI

addCorners(TeleportMenu)

local TeleportTitle = Instance.new("TextLabel")
TeleportTitle.Size = UDim2.new(1, 0, 0, 40)
TeleportTitle.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
TeleportTitle.BackgroundTransparency = 0.1
TeleportTitle.Text = "🌊 TELEPORT LOCATIONS 🌊"
TeleportTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportTitle.TextSize = 16
TeleportTitle.Font = Enum.Font.GothamBold
TeleportTitle.Parent = TeleportMenu

addCorners(TeleportTitle)

local TeleportClose = Instance.new("TextButton")
TeleportClose.Size = UDim2.new(0, 30, 0, 30)
TeleportClose.Position = UDim2.new(1, -35, 0, 5)
TeleportClose.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
TeleportClose.Text = "X"
TeleportClose.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportClose.Font = Enum.Font.GothamBold
TeleportClose.TextSize = 14
TeleportClose.Parent = TeleportTitle

addCorners(TeleportClose)

local TeleportScroll = Instance.new("ScrollingFrame")
TeleportScroll.Size = UDim2.new(1, -10, 1, -50)
TeleportScroll.Position = UDim2.new(0, 5, 0, 45)
TeleportScroll.BackgroundTransparency = 1
TeleportScroll.CanvasSize = UDim2.new(0, 0, 0, 800)
TeleportScroll.ScrollBarThickness = 6
TeleportScroll.Parent = TeleportMenu

local TeleportLocations = {
    ["🏝️ First Sea"] = {
        ["Starter Island"] = CFrame.new(1059, 16, 1547),
        ["Marine Base"] = CFrame.new(-2573, 6, 2093),
        ["Jungle"] = CFrame.new(-1249, 51, 341),
        ["Pirate Village"] = CFrame.new(-1181, 4, 3803),
        ["Desert"] = CFrame.new(1094, 6, 4192),
        ["Frozen Village"] = CFrame.new(1198, 104, -1516),
        ["Skylands"] = CFrame.new(-4955, 717, -2656),
        ["Prison"] = CFrame.new(4875, 5, 734),
        ["Colosseum"] = CFrame.new(-1427, 7, -2792),
        ["Magma Village"] = CFrame.new(-5231, 8, -5836)
    },
    ["🌊 Second Sea"] = {
        ["Kingdom of Rose"] = CFrame.new(-179, 15, 1467),
        ["Cafe"] = CFrame.new(-383, 77, 298),
        ["Mansion"] = CFrame.new(-12471, 374, -7551),
        ["Flamingo"] = CFrame.new(2284, 15, 905),
        ["Magma"] = CFrame.new(-5247, 12, -4849),
        ["Dark Area"] = CFrame.new(3780, 22, -3498),
        ["Swan"] = CFrame.new(2284, 15, 905),
        ["Factory"] = CFrame.new(424, 211, -427),
        ["Colossuem"] = CFrame.new(-1503, 219, 1369),
        ["Zombie Island"] = CFrame.new(-5622, 492, -781)
    },
    ["🗡️ Third Sea"] = {
        ["Port Town"] = CFrame.new(-290, 6, 5343),
        ["Hydra Island"] = CFrame.new(5749, 611, -276),
        ["Great Tree"] = CFrame.new(2681, 1682, -7190),
        ["Castle on the Sea"] = CFrame.new(-5085, 316, -3156),
        ["Haunted Castle"] = CFrame.new(-9515, 142, 5618),
        ["Peanut Island"] = CFrame.new(-2062, 50, -10232),
        ["Ice Castle"] = CFrame.new(6062, 15, -6350),
        ["Forgotten Island"] = CFrame.new(-3032, 235, -10075),
        ["Ussop Island"] = CFrame.new(4816, 8, 2863),
        ["Tiki Outpost"] = CFrame.new(-16545, 55, 1044)
    }
}

local function createButton(name, position, text, color, size)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = size or UDim2.new(0.48, 0, 0, 45)
    button.Position = position
    button.BackgroundColor3 = color or Color3.fromRGB(30, 30, 45)
    button.BackgroundTransparency = 0.1
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 12
    button.Font = Enum.Font.Gotham
    button.Parent = ContentFrame
    addCorners(button)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 140, 0)
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    stroke.Parent = button
    return button
end

local function createTeleportButtons()
    local yPos = 5
    for seaName, locations in pairs(TeleportLocations) do
        local seaHeader = Instance.new("TextLabel")
        seaHeader.Size = UDim2.new(1, -10, 0, 30)
        seaHeader.Position = UDim2.new(0, 5, 0, yPos)
        seaHeader.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
        seaHeader.BackgroundTransparency = 0.2
        seaHeader.Text = seaName
        seaHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
        seaHeader.TextSize = 14
        seaHeader.Font = Enum.Font.GothamBold
        seaHeader.Parent = TeleportScroll
        addCorners(seaHeader)
        yPos = yPos + 35
        for locationName, cframe in pairs(locations) do
            local teleBtn = Instance.new("TextButton")
            teleBtn.Size = UDim2.new(1, -20, 0, 35)
            teleBtn.Position = UDim2.new(0, 10, 0, yPos)
            teleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            teleBtn.BackgroundTransparency = 0.2
            teleBtn.Text = "📍 "..locationName
            teleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            teleBtn.TextSize = 12
            teleBtn.Font = Enum.Font.Gotham
            teleBtn.TextXAlignment = Enum.TextXAlignment.Left
            teleBtn.Parent = TeleportScroll
            addCorners(teleBtn)
            teleBtn.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
                    TeleportMenu.Visible = false
                    StarterGui:SetCore("SendNotification", {
                        Title = "🌊 Teleported!";
                        Text = "Moved to "..locationName;
                        Duration = 3;
                    })
                end
            end)
            yPos = yPos + 40
        end
        yPos = yPos + 10
    end
    TeleportScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

createTeleportButtons()

local menuOpen = false
local autoFarmEnabled = false
local fruitFarmEnabled = false
local fastAttackEnabled = false
local noClipEnabled = false
local infJumpEnabled = false
local speedEnabled = false
local espEnabled = false
local autoStatsEnabled = false
local killAuraEnabled = false
local antiAfkEnabled = true

local AutoFarmBtn = createButton("AutoFarm", UDim2.new(0, 5, 0, 10), "⚔️ AUTO FARM: OFF")
local FruitFarmBtn = createButton("FruitFarm", UDim2.new(0.52, 0, 0, 10), "🍇 FRUIT FARM: OFF")
local FastAttackBtn = createButton("FastAttack", UDim2.new(0, 5, 0, 65), "⚡ FAST ATTACK: OFF")
local KillAuraBtn = createButton("KillAura", UDim2.new(0.52, 0, 0, 65), "💀 KILL AURA: OFF")
local NoClipBtn = createButton("NoClip", UDim2.new(0, 5, 0, 120), "👻 NO CLIP: OFF")
local InfJumpBtn = createButton("InfJump", UDim2.new(0.52, 0, 0, 120), "🦘 INF JUMP: OFF")
local SpeedBtn = createButton("Speed", UDim2.new(0, 5, 0, 175), "🏃 SPEED: OFF")
local ESPBtn = createButton("ESP", UDim2.new(0.52, 0, 0, 175), "👁️ ESP: OFF")
local AutoStatsBtn = createButton("AutoStats", UDim2.new(0, 5, 0, 230), "📊 AUTO STATS: OFF")
local TeleportBtn = createButton("TeleportBtn", UDim2.new(0.52, 0, 0, 230), "🌊 TELEPORT MENU", Color3.fromRGB(70, 130, 180))

local function getQuest()
    local level = LocalPlayer.Data.Level.Value
    local questData = {}
    if level >= 1 and level <= 10 then
        questData = {questName = "BanditQuest1", npcName = "Bandit", location = CFrame.new(1059, 16, 1547)}
    elseif level >= 11 and level <= 20 then
        questData = {questName = "JungleQuest", npcName = "Monkey", location = CFrame.new(-1249, 51, 341)}
    elseif level >= 21 and level <= 30 then
        questData = {questName = "BuggyQuest1", npcName = "Pirate", location = CFrame.new(-1181, 4, 3803)}
    elseif level >= 31 and level <= 60 then
        questData = {questName = "DesertQuest", npcName = "Desert Bandit", location = CFrame.new(1094, 6, 4192)}
    else
        questData = {questName = "BanditQuest1", npcName = "Bandit", location = CFrame.new(1059, 16, 1547)}
    end
    return questData
end

local function startAutoFarm()
    spawn(function()
        while autoFarmEnabled do
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local questData = getQuest()
                local questGiver = Workspace.NPCs:FindFirstChild(questData.questName)
                if questGiver then
                    character.HumanoidRootPart.CFrame = questGiver.HumanoidRootPart.CFrame
                    wait(0.5)
                end
                local nearestEnemy = nil
                local shortestDistance = math.huge
                for _, npc in pairs(Workspace.Enemies:GetChildren()) do
                    if npc.Name == questData.npcName and npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                        local distance = (character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            nearestEnemy = npc
                        end
                    end
                end
                if nearestEnemy then
                    character.HumanoidRootPart.CFrame = nearestEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                    for _, tool in pairs(character:GetChildren()) do
                        if tool:IsA("Tool") then
                            tool:Activate()
                        end
                    end
                end
            end
            wait(0.1)
        end
    end)
end

local function startFruitFarm()
    spawn(function()
        while fruitFarmEnabled do
            for _, fruit in pairs(Workspace:GetChildren()) do
                if fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = fruit.Handle.CFrame
                        wait(0.5)
                        if fruit:FindFirstChild("ClickDetector") then
                            fireclickdetector(fruit.ClickDetector)
                        end
                        StarterGui:SetCore("SendNotification", {
                            Title = "🍇 Fruit Found!";
                            Text = "Collected: "..fruit.Name;
                            Duration = 3;
                        })
                    end
                end
            end
            wait(5)
        end
    end)
end

local function killAura()
    spawn(function()
        while killAuraEnabled do
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if distance <= 50 then
                            for _, tool in pairs(character:GetChildren()) do
                                if tool:IsA("Tool") then
                                    tool:Activate()
                                end
                            end
                        end
                    end
                end
            end
            wait(0.1)
        end
    end)
end

AutoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    AutoFarmBtn.Text = "⚔️ AUTO FARM: "..(autoFarmEnabled and "ON" or "OFF")
    AutoFarmBtn.BackgroundColor3 = autoFarmEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 45)
    if autoFarmEnabled then
        startAutoFarm()
    end
end)

FruitFarmBtn.MouseButton1Click:Connect(function()
    fruitFarmEnabled = not fruitFarmEnabled
    FruitFarmBtn.Text = "🍇 FRUIT FARM: "..(fruitFarmEnabled and "ON" or "OFF")
    FruitFarmBtn.BackgroundColor3 = fruitFarmEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 45)
    if fruitFarmEnabled then
        startFruitFarm()
    end
end)

KillAuraBtn.MouseButton1Click:Connect(function()
    killAuraEnabled = not killAuraEnabled
    KillAuraBtn.Text = "💀 KILL AURA: "..(killAuraEnabled and "ON" or "OFF")
    KillAuraBtn.BackgroundColor3 = killAuraEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 45)
    if killAuraEnabled then
        killAura()
    end
end)

TeleportBtn.MouseButton1Click:Connect(function()
    TeleportMenu.Visible = not TeleportMenu.Visible
end)

TeleportClose.MouseButton1Click:Connect(function()
    TeleportMenu.Visible = false
end)

FastAttackBtn.MouseButton1Click:Connect(function()
    fastAttackEnabled = not fastAttackEnabled
    FastAttackBtn.Text = "⚡ FAST ATTACK: "..(fastAttackEnabled and "ON" or "OFF")
    FastAttackBtn.BackgroundColor3 = fastAttackEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 45)
end)

NoClipBtn.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    NoClipBtn.Text = "👻 NO CLIP: "..(noClipEnabled and "ON" or "OFF")
    NoClipBtn.BackgroundColor3 = noClipEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 45)
end)

InfJumpBtn.MouseButton1Click:Connect(function()
    infJumpEnabled = not infJumpEnabled
    InfJumpBtn.Text = "🦘 INF JUMP: "..(infJumpEnabled and "ON" or "OFF")
    InfJumpBtn.BackgroundColor3 = infJumpEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 45)
end)

SpeedBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    SpeedBtn.Text = "🏃 SPEED: "..(speedEnabled and "ON" or "OFF")
    SpeedBtn.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 45)
end)

ESPBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPBtn.Text = "👁️ ESP: "..(espEnabled and "ON" or "OFF")
    ESPBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 45)
end)

AutoStatsBtn.MouseButton1Click:Connect(function()
    autoStatsEnabled = not autoStatsEnabled
    AutoStatsBtn.Text = "📊 AUTO STATS: "..(autoStatsEnabled and "ON" or "OFF")
    AutoStatsBtn.BackgroundColor3 = autoStatsEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 45)
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    menuOpen = false
end)

FloatingButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MainFrame.Visible = menuOpen
end)

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local dragStart = input.Position
        local startPos = MainFrame.Position
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
                MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end
end)

spawn(function()
    while antiAfkEnabled do
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        wait(300)
    end
end)

StarterGui:SetCore("SendNotification", {
    Title = "🍇 RedZ Style Loaded!";
    Text = "Advanced Blox Fruits script loaded successfully!";
    Duration = 5;
})

RunService.Stepped:Connect(function()
    if noClipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

RunService.Heartbeat:Connect(function()
    if speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 100
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

if fastAttackEnabled then
    local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
    local CombatFrameworkR = getupvalues(CombatFramework)[2]
    local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
    CameraShakerR:Stop()
    coroutine.wrap(function()
        while fastAttackEnabled do
            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                local ac = CombatFrameworkR.activeController
                if ac and ac.equipped then
                    for i = 1, 50 do
                        ac:attack()
                        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", getupvalues(CombatFrameworkR.activeController)[2], i, "")
                        task.wait(0.01)
                    end
                end
            end
            task.wait()
        end
    end)()
end

if espEnabled then
    local function createESP(character)
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.Parent = character
    end

    local function onPlayerAdded(player)
        player.CharacterAdded:Connect(function(character)
            if espEnabled then
                createESP(character)
            end
        end)
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            createESP(player.Character)
        end
        player.CharacterAdded:Connect(function(character)
            if espEnabled then
                createESP(character)
            end
        end)
    end

    Players.PlayerAdded:Connect(onPlayerAdded)
end

if autoStatsEnabled then
    spawn(function()
        while autoStatsEnabled do
            local args = {
                [1] = "AddPoint",
                [2] = "Melee",
                [3] = 1
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            wait(0.5)
        end
    end)
end
