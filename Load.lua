-- Advanced Legit Loading Screen Script (Client-Side)
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hide in-game GUI (inventory, health, leaderboard, etc.)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

-- Create GUI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "LegitLoadingScreen"
screenGui.ResetOnSpawn = false

-- Background
local bg = Instance.new("Frame", screenGui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
bg.BackgroundTransparency = 1
TweenService:Create(bg, TweenInfo.new(1), {BackgroundTransparency = 0}):Play()

-- Username & Fake Server ID Label
local infoLabel = Instance.new("TextLabel", bg)
infoLabel.Size = UDim2.new(1, 0, 0, 30)
infoLabel.Position = UDim2.new(0, 0, 0.05, 0)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
infoLabel.TextScaled = true
infoLabel.Font = Enum.Font.Gotham
infoLabel.Text = "User: " .. player.Name .. " | Server ID: S-" .. math.random(100000,999999) .. "-" .. math.random(1000,9999)

-- Center status message
local label = Instance.new("TextLabel", bg)
label.Size = UDim2.new(1, 0, 0, 60)
label.Position = UDim2.new(0, 0, 0.45, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Text = "Initializing..."

-- Progress % Label
local percentLabel = Instance.new("TextLabel", bg)
percentLabel.Size = UDim2.new(1, 0, 0, 40)
percentLabel.Position = UDim2.new(0, 0, 0.62, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
percentLabel.TextScaled = true
percentLabel.Font = Enum.Font.GothamBold
percentLabel.Text = "0%"

-- Progress bar container
local barFrame = Instance.new("Frame", bg)
barFrame.Size = UDim2.new(0.6, 0, 0.04, 0)
barFrame.Position = UDim2.new(0.2, 0, 0.55, 0)
barFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barFrame.BorderSizePixel = 0
Instance.new("UICorner", barFrame).CornerRadius = UDim.new(0, 6)

-- Progress fill
local fill = Instance.new("Frame", barFrame)
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
fill.BorderSizePixel = 0
fill.ZIndex = 2
Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 6)

-- Loading messages
local messages = {
    "Finding server to hop...",
    "Locating Old server...",
    "Searching legacy server list...",
    "Pinging alternate regions...",
    "Retrying connection...",
    "Scanning deep archive servers...",
    "Still looking for Old Server...",
    "Final attempt in progress..."
}

-- Tween progress bar
TweenService:Create(fill, TweenInfo.new(600, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()

-- Update progress every second (600 = 10 mins)
task.spawn(function()
    for i = 1, 600 do
        local progress = math.floor((i / 600) * 100)
        percentLabel.Text = progress .. "%"
        if i % 10 == 0 then
            label.Text = messages[((i // 10 - 1) % #messages) + 1]
        end
        wait(1)
    end

    -- Restore GUI, then kick
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    player:Kick("Couldn't find another old server with Candy Blossom. Please try rejoining later.")
end)
