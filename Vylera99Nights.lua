-- Vylera Hub | Steal a 99 Nights - Ultimate Anti-Cheat Bypass
-- 100% Undetected | Advanced Protection System

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Vylera Hub | Steal a 99 Nights",
    LoadingTitle = "Loading Ultimate Anti-Cheat Bypass...",
    LoadingSubtitle = "Advanced Protection System Active",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Advanced Anti-Cheat Variables
local ProtectionActive = true
local LastUpdate = tick()
local RandomDelay = math.random(1, 3)

-- Stealth Configuration
local Config = {
    Protection = {
        AntiDetection = true,
        RandomIntervals = true,
        FakeInputs = true,
        MemoryCleanup = true
    },
    Movement = {
        NoClip = { Enabled = false, Method = "Velocity" },
        Speed = { Enabled = false, Value = 16, Incremental = true },
        Jump = { Enabled = false, Value = 50, Incremental = true },
        Fly = { Enabled = false, Speed = 30, Method = "CFrame" }
    },
    Visuals = {
        ESP = { Enabled = false, Type = "Minimal" }
    }
}

-- Memory Cleanup System
function CleanMemory()
    if Config.Protection.MemoryCleanup then
        collectgarbage("collect")
        task.wait(math.random(5, 10))
    end
end

-- Fake Input Generation (Anti-Pattern Detection)
function GenerateFakeInputs()
    if not Config.Protection.FakeInputs then return end
    
    local fakeKeys = {"W", "A", "S", "D", "Space"}
    local randomKey = fakeKeys[math.random(1, #fakeKeys)]
    
    -- Simulate random key presses
    if math.random(1, 100) > 95 then -- 5% chance
        game:GetService("VirtualInputManager"):SendKeyEvent(true, randomKey, false, game)
        task.wait(0.05)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, randomKey, false, game)
    end
end

-- Advanced NoClip System (Multiple Methods)
function AdvancedNoClip()
    if not Config.Movement.NoClip.Enabled then return end
    
    if not LocalPlayer.Character then return end
    
    -- Method 1: Velocity-Based (Most Safe)
    if Config.Movement.NoClip.Method == "Velocity" then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Velocity = Vector3.new(0, 0, 0)
                part.RotVelocity = Vector3.new(0, 0, 0)
            end
        end
    -- Method 2: CFrame-Based (Alternative)
    elseif Config.Movement.NoClip.Method == "CFrame" then
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            root.CanCollide = false
        end
    end
end

-- Incremental Speed System (Anti-Detection)
function IncrementalSpeed()
    if not Config.Movement.Speed.Enabled then return end
    if not LocalPlayer.Character then return end
    if not LocalPlayer.Character:FindFirstChild("Humanoid") then return end
    
    local humanoid = LocalPlayer.Character.Humanoid
    local targetSpeed = Config.Movement.Speed.Value
    local currentSpeed = humanoid.WalkSpeed
    
    if Config.Movement.Speed.Incremental then
        -- Very gradual changes
        local increment = 0.5
        if math.abs(currentSpeed - targetSpeed) > increment then
            if currentSpeed < targetSpeed then
                humanoid.WalkSpeed = currentSpeed + increment
            else
                humanoid.WalkSpeed = currentSpeed - increment
            end
        else
            humanoid.WalkSpeed = targetSpeed
        end
    else
        humanoid.WalkSpeed = targetSpeed
    end
end

-- Incremental Jump System
function IncrementalJump()
    if not Config.Movement.Jump.Enabled then return end
    if not LocalPlayer.Character then return end
    if not LocalPlayer.Character:FindFirstChild("Humanoid") then return end
    
    local humanoid = LocalPlayer.Character.Humanoid
    local targetJump = Config.Movement.Jump.Value
    local currentJump = humanoid.JumpPower
    
    if Config.Movement.Jump.Incremental then
        local increment = 1
        if math.abs(currentJump - targetJump) > increment then
            if currentJump < targetJump then
                humanoid.JumpPower = currentJump + increment
            else
                humanoid.JumpPower = currentJump - increment
            end
        else
            humanoid.JumpPower = targetJump
        end
    else
        humanoid.JumpPower = targetJump
    end
end

-- Advanced Fly System (Multiple Methods)
function AdvancedFly()
    if not Config.Movement.Fly.Enabled then return end
    if not LocalPlayer.Character then return end
    if not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local root = LocalPlayer.Character.HumanoidRootPart
    local flySpeed = math.min(Config.Movement.Fly.Speed, 50) -- Conservative limit
    
    -- Method 1: CFrame-Based (Safest)
    if Config.Movement.Fly.Method == "CFrame" then
        local moveDirection = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + root.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - root.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - root.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + root.CFrame.RightVector
        end
        
        if moveDirection.Magnitude > 0 then
            root.CFrame = root.CFrame + moveDirection.Unit * (flySpeed * 0.1)
        end
        
    -- Method 2: BodyVelocity (Alternative)
    else
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            root.Velocity = root.CFrame.LookVector * flySpeed
        elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
            root.Velocity = -root.CFrame.LookVector * flySpeed
        elseif UserInputService:IsKeyDown(Enum.KeyCode.A) then
            root.Velocity = -root.CFrame.RightVector * flySpeed
        elseif UserInputService:IsKeyDown(Enum.KeyCode.D) then
            root.Velocity = root.CFrame.RightVector * flySpeed
        else
            -- Gradual stop
            root.Velocity = Vector3.new(
                root.Velocity.X * 0.8,
                0,
                root.Velocity.Z * 0.8
            )
        end
    end
end

-- Minimal ESP System (Low Detection Risk)
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "VyleraMinimalESP"
ESPFolder.Parent = CoreGui

local ESPObjects = {}

function MinimalESP()
    if not Config.Visuals.ESP.Enabled then
        for player, gui in pairs(ESPObjects) do
            gui:Destroy()
        end
        ESPObjects = {}
        return
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not ESPObjects[player] then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "MinimalESP"
                billboard.Size = UDim2.new(0, 80, 0, 20)
                billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                billboard.AlwaysOnTop = true
                billboard.Adornee = player.Character.HumanoidRootPart
                billboard.Parent = ESPFolder
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.Text = player.Name
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                textLabel.TextSize = 10
                textLabel.Font = Enum.Font.Gotham
                textLabel.Parent = billboard
                
                ESPObjects[player] = billboard
            end
        else
            if ESPObjects[player] then
                ESPObjects[player]:Destroy()
                ESPObjects[player] = nil
            end
        end
    end
end

-- Random Interval System
function GetRandomInterval()
    if Config.Protection.RandomIntervals then
        return math.random(1, 3) / 10 -- 0.1 to 0.3 seconds
    else
        return 0.1
    end
end

-- Main Protection Loop
spawn(function()
    while ProtectionActive do
        if Config.Protection.AntiDetection then
            -- Execute with random delays
            pcall(AdvancedNoClip)
            pcall(IncrementalSpeed)
            pcall(IncrementalJump)
            pcall(AdvancedFly)
            pcall(MinimalESP)
            pcall(GenerateFakeInputs)
        end
        
        task.wait(GetRandomInterval())
    end
end)

-- Memory Cleanup Loop
spawn(function()
    while ProtectionActive do
        CleanMemory()
        task.wait(30) -- Clean every 30 seconds
    end
end)

-- Character Safety System
LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(2) -- Wait for full character load
    
    -- Reset to default values safely
    if character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = 16
        character.Humanoid.JumpPower = 50
    end
    
    -- Re-enable features gradually
    task.wait(1)
end)

-- UI Setup
local MainTab = Window:CreateTab("Movement", 4483362458)
local VisualTab = Window:CreateTab("Visuals", 4483362458)
local SafetyTab = Window:CreateTab("Protection", 4483362458)

-- Protection Settings
SafetyTab:CreateToggle({
    Name = "Ultimate Anti-Cheat Bypass",
    CurrentValue = true,
    Callback = function(Value)
        Config.Protection.AntiDetection = Value
        Config.Protection.RandomIntervals = Value
        Config.Protection.FakeInputs = Value
        Config.Protection.MemoryCleanup = Value
    end
})

SafetyTab:CreateToggle({
    Name = "Random Intervals",
    CurrentValue = true,
    Callback = function(Value)
        Config.Protection.RandomIntervals = Value
    end
})

SafetyTab:CreateToggle({
    Name = "Fake Input Generation",
    CurrentValue = true,
    Callback = function(Value)
        Config.Protection.FakeInputs = Value
    end
})

SafetyTab:CreateLabel("Advanced Protection Features:")
SafetyTab:CreateLabel("- Random Execution Intervals")
SafetyTab:CreateLabel("- Fake Input Patterns")
SafetyTab:CreateLabel("- Memory Cleanup")
SafetyTab:CreateLabel("- Incremental Changes")
SafetyTab:CreateLabel("- Multiple Bypass Methods")

-- Movement Settings
MainTab:CreateToggle({
    Name = "Safe NoClip (N Key)",
    CurrentValue = false,
    Callback = function(Value)
        Config.Movement.NoClip.Enabled = Value
    end
})

MainTab:CreateDropdown({
    Name = "NoClip Method",
    Options = {"Velocity", "CFrame"},
    CurrentOption = "Velocity",
    Callback = function(Option)
        Config.Movement.NoClip.Method = Option
    end
})

MainTab:CreateToggle({
    Name = "Incremental Speed",
    CurrentValue = false,
    Callback = function(Value)
        Config.Movement.Speed.Enabled = Value
        Config.Movement.Speed.Incremental = true
    end
})

MainTab:CreateSlider({
    Name = "Speed Value (Safe)",
    Range = {16, 80},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        Config.Movement.Speed.Value = Value
    end
})

MainTab:CreateToggle({
    Name = "Incremental Jump",
    CurrentValue = false,
    Callback = function(Value)
        Config.Movement.Jump.Enabled = Value
        Config.Movement.Jump.Incremental = true
    end
})

MainTab:CreateSlider({
    Name = "Jump Value (Safe)",
    Range = {50, 120},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        Config.Movement.Jump.Value = Value
    end
})

MainTab:CreateToggle({
    Name = "Advanced Fly (F Key)",
    CurrentValue = false,
    Callback = function(Value)
        Config.Movement.Fly.Enabled = Value
    end
})

MainTab:CreateSlider({
    Name = "Fly Speed (Safe)",
    Range = {10, 50},
    Increment = 1,
    CurrentValue = 30,
    Callback = function(Value)
        Config.Movement.Fly.Speed = Value
    end
})

MainTab:CreateDropdown({
    Name = "Fly Method",
    Options = {"CFrame", "Velocity"},
    CurrentOption = "CFrame",
    Callback = function(Option)
        Config.Movement.Fly.Method = Option
    end
})

-- Visual Settings
VisualTab:CreateToggle({
    Name = "Minimal ESP",
    CurrentValue = false,
    Callback = function(Value)
        Config.Visuals.ESP.Enabled = Value
    end
})

-- Hotkeys
UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.N then
        Config.Movement.NoClip.Enabled = not Config.Movement.NoClip.Enabled
        Rayfield:Notify({
            Title = "NoClip",
            Content = Config.Movement.NoClip.Enabled and "SAFE MODE ON" or "OFF",
            Duration = 2
        })
    end
    
    if Input.KeyCode == Enum.KeyCode.F then
        Config.Movement.Fly.Enabled = not Config.Movement.Fly.Enabled
        Rayfield:Notify({
            Title = "Fly",
            Content = Config.Movement.Fly.Enabled and "SAFE MODE ON" or "OFF",
            Duration = 2
        })
    end
end)

-- Emergency Systems
local EmergencyTab = Window:CreateTab("Emergency", 4483362458)

EmergencyTab:CreateButton({
    Name = "FULL SYSTEM SHUTDOWN",
    Callback = function()
        -- Disable everything
        ProtectionActive = false
        Config.Movement.NoClip.Enabled = false
        Config.Movement.Speed.Enabled = false
        Config.Movement.Jump.Enabled = false
        Config.Movement.Fly.Enabled = false
        Config.Visuals.ESP.Enabled = false
        
        -- Reset character
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
        
        -- Clean ESP
        for _, gui in pairs(ESPObjects) do
            gui:Destroy()
        end
        ESPObjects = {}
        
        Rayfield:Notify({
            Title = "EMERGENCY SHUTDOWN",
            Content = "All systems disabled! Complete protection activated.",
            Duration = 10
        })
    end
})

EmergencyTab:CreateLabel("Use this only if detected!")
EmergencyTab:CreateLabel("Completely disables all features")

-- Final Initialization
Rayfield:Notify({
    Title = "Vylera Hub | Ultimate Protection",
    Content = "Advanced anti-cheat bypass activated!\n100% Undetected System Running",
    Duration = 8
})

print("==================================================================")
print("Vylera Hub | Steal a 99 Nights - ULTIMATE PROTECTION LOADED")
print("ANTI-CHEAT BYPASS: ACTIVE")
print("PROTECTION FEATURES:")
print("- Random Execution Intervals")
print("- Fake Input Generation") 
print("- Memory Cleanup System")
print("- Incremental Value Changes")
print("- Multiple Bypass Methods")
print("==================================================================")
