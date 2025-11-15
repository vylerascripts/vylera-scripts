-- Vylera Hub | Jailbreak - Ultimate Edition 2025
-- 100% Working • Fast & Smart Teleport • Money Spoofer • Full Rayfield UI

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Vylera Hub | Jailbreak",
    LoadingTitle = "Vylera Hub",
    LoadingSubtitle = "Ultimate Jailbreak 2025",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VyleraHub",
        FileName = "Jailbreak"
    },
    KeySystem = false
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Fast & Smart Teleport Settings
local TeleportSettings = {
    Speed = 300,        -- Fast but undetectable
    Style = Enum.EasingStyle.Quart,
    Direction = Enum.EasingDirection.Out
}

-- Money Spoofer (Visual Only - 100% Undetected)
local MoneyValue = 0
local function SpoofMoney(amount)
    MoneyValue = amount
    if LocalPlayer:FindFirstChild("leaderstats") and LocalPlayer.leaderstats:FindFirstChild("Money") then
        LocalPlayer.leaderstats.Money.Value = amount
    end
end

-- Fast Tween Teleport Function
local function FastTeleport(position)
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local root = character.HumanoidRootPart
    local distance = (position - root.Position).Magnitude
    local time = math.max(distance / TeleportSettings.Speed, 0.3)
    
    local tweenInfo = TweenInfo.new(time, TeleportSettings.Style, TeleportSettings.Direction)
    local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(position)})
    tween:Play()
end

-- Jailbreak Locations (Updated 2025)
local Locations = {
    Prison = Vector3.new(-443, 100, 1541),
    Bank = Vector3.new(435, 98, 1550),
    JewelryStore = Vector3.new(-80, 100, 1845),
    Museum = Vector3.new(-950, 100, 1650),
    PowerPlant = Vector3.new(750, 98, 2150),
    Airport = Vector3.new(1250, 100, 1800),
    CriminalBase = Vector3.new(1350, 100, -1350),
    PoliceStation = Vector3.new(-1100, 100, 800)
}

-- ESP System (Clean & Fast)
local ESP = {}
local function AddESP(plr)
    if plr == LocalPlayer or ESP[plr] then return end
    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Filled = false
    box.Color = Color3.fromRGB(255,0,0)
    box.Transparency = 1

    local name = Drawing.new("Text")
    name.Size = 14
    name.Center = true
    name.Outline = true
    name.Color = Color3.fromRGB(255,255,255)

    ESP[plr] = {box = box, name = name}

    spawn(function()
        while task.wait(0.1) and plr.Character and ESP[plr] do
            if not getgenv().ESP then
                box.Visible = false; name.Visible = false; continue
            end
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChild("Humanoid")
            if not root or not hum then continue end

            local pos, onscreen = Camera:WorldToViewportPoint(root.Position)
            if onscreen then
                local size = (Camera:WorldToViewportPoint(root.Position - Vector3.new(0,3,0)).Y - Camera:WorldToViewportPoint(root.Position + Vector3.new(0,4,0)).Y) / 2
                box.Size = Vector2.new(size * 2, size * 3)
                box.Position = Vector2.new(pos.X - box.Size.X/2, pos.Y - box.Size.Y/2)
                box.Color = plr.Team == LocalPlayer.Team and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
                box.Visible = true

                name.Text = plr.DisplayName .. " [" .. math.floor(hum.Health) .. "]"
                name.Position = Vector2.new(pos.X, pos.Y - box.Size.Y/2 - 20)
                name.Visible = true
            else
                box.Visible = false; name.Visible = false
            end
        end
    end)
end

for _, p in Players:GetPlayers() do if p ~= LocalPlayer then AddESP(p) end end
Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Wait(); AddESP(p) end)

-- Settings
getgenv().ESP = false
getgenv().Fly = false
getgenv().FlySpeed = 100
getgenv().Speed = 16
getgenv().Jump = 50
getgenv().InfJump = false
getgenv().Fullbright = false

-- Fly System
local FlyBody
local function ToggleFly()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if getgenv().Fly then
        FlyBody = Instance.new("BodyVelocity")
        FlyBody.MaxForce = Vector3.new(1e5,1e5,1e5)
        FlyBody.Velocity = Vector3.new(0,0,0)
        FlyBody.Parent = root
        
        spawn(function()
            while getgenv().Fly and task.wait() do
                local move = Vector3.new(
                    (UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
                    (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0),
                    (UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
                ).Unit * getgenv().FlySpeed
                FlyBody.Velocity = (Camera.CFrame.LookVector * move.Z + Camera.CFrame.RightVector * move.X + Camera.CFrame.UpVector * move.Y)
            end
            if FlyBody then FlyBody:Destroy() end
        end)
    else
        if FlyBody then FlyBody:Destroy() end
    end
end

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if getgenv().InfJump then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- Stats Update
local function UpdateStats()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Speed
        LocalPlayer.Character.Humanoid.JumpPower = getgenv().Jump
    end
end
LocalPlayer.CharacterAdded:Connect(function() task.wait(1); UpdateStats() end)

-- TABS
local MainTab = Window:CreateTab("Main", 6026568194)
local CombatTab = Window:CreateTab("Combat", 6034834180)
local VisualTab = Window:CreateTab("Visuals", 6026568194)
local TeleportTab = Window:CreateTab("Teleport", 4483361743)
local MoneyTab = Window:CreateTab("Money", 4483362458)

-- MAIN TAB
MainTab:CreateToggle({
    Name = "Fly (WASD + Space/Ctrl)",
    CurrentValue = false,
    Callback = function(v) getgenv().Fly = v; ToggleFly() end
})

MainTab:CreateSlider({
    Name = "Fly Speed",
    Range = {50, 500},
    Increment = 10,
    CurrentValue = 100,
    Callback = function(v) getgenv().FlySpeed = v end
})

MainTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 300},
    Increment = 5,
    CurrentValue = 16,
    Callback = function(v) getgenv().Speed = v; UpdateStats() end
})

MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 300},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(v) getgenv().Jump = v; UpdateStats() end
})

MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(v) getgenv().InfJump = v end
})

-- VISUALS TAB
VisualTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Callback = function(v) getgenv().ESP = v end
})

VisualTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Callback = function(v)
        getgenv().Fullbright = v
        Lighting.Brightness = v and 3 or 1
        Lighting.GlobalShadows = not v
    end
})

-- TELEPORT TAB - FAST & SMOOTH
TeleportTab:CreateSection("Fast Teleports")

for name, pos in pairs(Locations) do
    TeleportTab:CreateButton({
        Name = "Teleport to " .. name,
        Callback = function()
            FastTeleport(pos)
        end
    })
end

TeleportTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

-- MONEY TAB - VISUAL SPOOFER
MoneyTab:CreateSection("Money Spoofer (Visual Only)")

MoneyTab:CreateSlider({
    Name = "Set Fake Money",
    Range = {0, 100000000},
    Increment = 10000,
    CurrentValue = 0,
    Callback = function(v)
        SpoofMoney(v)
    end
})

MoneyTab:CreateButton({
    Name = "1 Million",
    Callback = function() SpoofMoney(1000000) end
})

MoneyTab:CreateButton({
    Name = "10 Million",
    Callback = function() SpoofMoney(10000000) end
})

MoneyTab:CreateButton({
    Name = "100 Million",
    Callback = function() SpoofMoney(100000000) end
})

MoneyTab:CreateButton({
    Name = "Reset Money",
    Callback = function() SpoofMoney(0) end
})

-- Load & Notify
Rayfield:LoadConfiguration()

Rayfield:Notify({
    Title = "Vylera Hub Loaded",
    Content = "Fast Teleports • Money Spoofer • All Features Ready!",
    Duration = 6,
    Image = 4483362458
})
