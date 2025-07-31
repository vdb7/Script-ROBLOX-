local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local espEnabled = false
local espBoxes = {}

-- إنشاء صندوق ESP لكل لاعب
local function createESP(playerTarget)
    if espBoxes[playerTarget] then espBoxes[playerTarget]:Destroy() end
    
    local character = playerTarget.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESP_" .. playerTarget.Name
    box.Adornee = hrp
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Size = Vector3.new(3, 5, 3)
    box.Color3 = playerTarget.Team == player.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    box.Transparency = 0.5
    box.Parent = game.CoreGui
    
    espBoxes[playerTarget] = box
    
    playerTarget.CharacterAdded:Connect(function()
        if espEnabled then
            wait(1)
            createESP(playerTarget)
        end
    end)
end

-- إزالة كل صناديق ESP
local function clearESP()
    for _, box in pairs(espBoxes) do
        if box then box:Destroy() end
    end
    espBoxes = {}
end

-- تفعيل ESP لجميع اللاعبين
local function enableESP()
    espEnabled = true
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            createESP(p)
        end
    end
end

-- تعطيل ESP
local function disableESP()
    espEnabled = false
    clearESP()
end

-- إنشاء واجهة بسيطة مع زر
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ESPControlGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.Text = "تشغيل ESP"

toggleButton.Parent = ScreenGui

toggleButton.MouseButton1Click:Connect(function()
    if espEnabled then
        disableESP()
        toggleButton.Text = "تشغيل ESP"
        toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    else
        enableESP()
        toggleButton.Text = "إيقاف ESP"
        toggleButton.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
    end
end)

-- أحداث إضافية لمراقبة دخول وخروج اللاعبين
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        if espEnabled and p ~= player then
            wait(1)
            createESP(p)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(p)
    if espBoxes[p] then
        espBoxes[p]:Destroy()
        espBoxes[p] = nil
    end
end)
