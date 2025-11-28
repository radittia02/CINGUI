-- GUI Utama
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- SCREENGUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CingUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui") -- Aman untuk Delta

-- PANEL UTAMA
local panel = Instance.new("Frame")
panel.Name = "CingPanel"
panel.Size = UDim2.new(0, 400, 0, 300)
panel.Position = UDim2.new(0.3, 0, 0.25, 0)
panel.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
panel.BackgroundTransparency = 0.35
panel.BorderSizePixel = 0
panel.Active = true
panel.Draggable = true
panel.Visible = true
panel.Parent = screenGui

-- TITLE
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1,0,0,35)
titleFrame.BackgroundTransparency = 1
titleFrame.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 40, 0, 0)
title.Text = "CING"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,32,0,32)
closeBtn.Position = UDim2.new(1,-40,0,0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
closeBtn.Parent = panel

local miniIcon = Instance.new("TextButton")
miniIcon.Size = UDim2.new(0,50,0,50)
miniIcon.Position = UDim2.new(0,20,0.8,0)
miniIcon.BackgroundColor3 = Color3.fromRGB(0,150,255)
miniIcon.BackgroundTransparency = 0.2
miniIcon.Text = "🔵"
miniIcon.TextScaled = true
miniIcon.Visible = false
miniIcon.Parent = screenGui

closeBtn.MouseButton1Click:Connect(function()
	panel.Visible = false
	miniIcon.Visible = true
end)

miniIcon.MouseButton1Click:Connect(function()
	panel.Visible = true
	miniIcon.Visible = false
end)

-- SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0,100,1,0)
sidebar.Position = UDim2.new(0,0,0,35)
sidebar.BackgroundColor3 = Color3.fromRGB(10,30,50)
sidebar.BackgroundTransparency = 0.25
sidebar.BorderSizePixel = 0
sidebar.Parent = panel

local function createSidebarButton(name, order)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,-10,0,35)
	btn.Position = UDim2.new(0,5,0,order*40)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(255,0,0)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Parent = sidebar
	return btn
end

local infoBtn = createSidebarButton("INFO",0)
local playerBtn = createSidebarButton("PLAYER",1)
local teleportBtn = createSidebarButton("TELEPORT",2)

-- CONTENT AREA
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1,-110,1,-35)
content.Position = UDim2.new(0,100,0,35)
content.BackgroundColor3 = Color3.fromRGB(0,0,0)
content.BackgroundTransparency = 0.55
content.BorderSizePixel = 0
content.ScrollBarThickness = 6
content.Parent = panel

local contentTitle = Instance.new("TextLabel")
contentTitle.Size = UDim2.new(1,0,0,30)
contentTitle.Text = "Pilih Menu di Kiri"
contentTitle.TextColor3 = Color3.fromRGB(255,255,255)
contentTitle.Font = Enum.Font.GothamSemibold
contentTitle.TextSize = 18
contentTitle.BackgroundTransparency = 1
contentTitle.Parent = content

local function clearContent()
	for _,v in pairs(content:GetChildren()) do
		if v.Name ~= "ContentTitle" then v:Destroy() end
	end
end

-- INFO MENU
local AdminList = {"Radittianovafel","CingMaster"}
local function openInfoMenu()
	clearContent()
	contentTitle.Text = "INFO SERVER"

	local adminLabel = Instance.new("TextLabel")
	adminLabel.Size = UDim2.new(1,-20,0,50)
	adminLabel.Position = UDim2.new(0,10,0,40)
	adminLabel.BackgroundTransparency = 1
	adminLabel.TextColor3 = Color3.fromRGB(255,255,255)
	adminLabel.TextXAlignment = Enum.TextXAlignment.Left
	adminLabel.Font = Enum.Font.Gotham
	adminLabel.TextSize = 14
	adminLabel.TextWrapped = true
	adminLabel.Parent = content

	local function updateInfo()
		local text = "Admin Online:\n"
		for _,a in pairs(AdminList) do
			if Players:FindFirstChild(a) then text = text.."• "..a.."\n" end
		end
		text = text.."Player Online:\n"
		for _,p in pairs(Players:GetPlayers()) do
			text = text.."• "..p.Name.."\n"
		end
		adminLabel.Text = text
	end

	updateInfo()
	Players.PlayerAdded:Connect(updateInfo)
	Players.PlayerRemoving:Connect(updateInfo)
end

infoBtn.MouseButton1Click:Connect(openInfoMenu)

-- PLAYER MENU (Jump + Spit)
playerBtn.MouseButton1Click:Connect(function()
	clearContent()
	contentTitle.Text = "PLAYER MENU"

	local plr = LocalPlayer
	if not plr.Character then return end
	local char = plr.Character
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	if not humanoid then return end

	local jumpLabel = Instance.new("TextLabel")
	jumpLabel.Size = UDim2.new(0,180,0,25)
	jumpLabel.Position = UDim2.new(0,10,0,40)
	jumpLabel.Text = "Jump Power (16–100)"
	jumpLabel.BackgroundTransparency = 1
	jumpLabel.TextColor3 = Color3.fromRGB(255,255,255)
	jumpLabel.Parent = content

	local jumpBox = Instance.new("TextBox")
	jumpBox.Size = UDim2.new(0,180,0,25)
	jumpBox.Position = UDim2.new(0,10,0,65)
	jumpBox.Text = "16"
	jumpBox.BackgroundColor3 = Color3.fromRGB(255,0,0)
	jumpBox.TextColor3 = Color3.fromRGB(255,255,255)
	jumpBox.ClearTextOnFocus = false
	jumpBox.Parent = content

	local spitLabel = Instance.new("TextLabel")
	spitLabel.Size = UDim2.new(0,180,0,25)
	spitLabel.Position = UDim2.new(0,10,0,100)
	spitLabel.Text = "Spit Power (16–100)"
	spitLabel.BackgroundTransparency = 1
	spitLabel.TextColor3 = Color3.fromRGB(255,255,255)
	spitLabel.Parent = content

	local spitBox = Instance.new("TextBox")
	spitBox.Size = UDim2.new(0,180,0,25)
	spitBox.Position = UDim2.new(0,10,0,125)
	spitBox.Text = "16"
	spitBox.BackgroundColor3 = Color3.fromRGB(255,0,0)
	spitBox.TextColor3 = Color3.fromRGB(255,255,255)
	spitBox.ClearTextOnFocus = false
	spitBox.Parent = content

	local applyBtn = Instance.new("TextButton")
	applyBtn.Size = UDim2.new(0,180,0,30)
	applyBtn.Position = UDim2.new(0,10,0,160)
	applyBtn.Text = "Apply"
	applyBtn.BackgroundColor3 = Color3.fromRGB(0,150,255)
	applyBtn.TextColor3 = Color3.fromRGB(255,255,255)
	applyBtn.Parent = content

	applyBtn.MouseButton1Click:Connect(function()
		local jumpVal = tonumber(jumpBox.Text)
		local spitVal = tonumber(spitBox.Text)
		if jumpVal and jumpVal>=16 and jumpVal<=100 then humanoid.JumpPower = jumpVal else jumpBox.Text = tostring(humanoid.JumpPower) end
		if spitVal and spitVal>=16 and spitVal<=100 then humanoid.WalkSpeed = spitVal else spitBox.Text = tostring(humanoid.WalkSpeed) end
	end)
end)

-- TELEPORT MENU
teleportBtn.MouseButton1Click:Connect(function()
	clearContent()
	contentTitle.Text = "TELEPORT MENU"

	local scrollPlayers = Instance.new("ScrollingFrame")
	scrollPlayers.Size = UDim2.new(1,-20,1,-60)
	scrollPlayers.Position = UDim2.new(0,10,0,40)
	scrollPlayers.BackgroundTransparency = 0.2
	scrollPlayers.BackgroundColor3 = Color3.fromRGB(20,20,20)
	scrollPlayers.ScrollBarThickness = 6
	scrollPlayers.BorderSizePixel = 0
	scrollPlayers.Parent = content

	local layout = Instance.new("UIListLayout")
	layout.Parent = scrollPlayers
	layout.Padding = UDim.new(0,5)

	local function updateTeleport()
		for _,v in pairs(scrollPlayers:GetChildren()) do
			if v:IsA("TextButton") then v:Destroy() end
		end

		for _,p in pairs(Players:GetPlayers()) do
			if p ~= LocalPlayer then
				local btn = Instance.new("TextButton")
				btn.Size = UDim2.new(1,0,0,25)
				btn.Text = p.Name
				btn.BackgroundColor3 = Color3.fromRGB(255,0,0)
				btn.TextColor3 = Color3.fromRGB(255,255,255)
				btn.Font = Enum.Font.GothamBold
				btn.TextSize = 14
				btn.Parent = scrollPlayers

				btn.MouseButton1Click:Connect(function()
					if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
						LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
					end
				end)
			end
		end
	end

	updateTeleport()
	Players.PlayerAdded:Connect(updateTeleport)
	Players.PlayerRemoving:Connect(updateTeleport)
end)