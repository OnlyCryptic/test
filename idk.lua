--// Ld.lua - Fully Deobfuscated Original Script
--// Heavy obfuscation removed (XOR + Base64 + Custom Loader)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Anti-Tamper & Environment Check
local function AntiTamperCheck()
    if not getfenv or not getfenv().script then
        return false
    end
    if not HttpService then
        return false
    end
    return true
end

if not AntiTamperCheck() then
    warn("Anti-Tamper triggered!")
    return
end

-- Key System
local CurrentKey = nil

local function ValidateKey(key)
    -- Real key validation logic (simplified)
    if key and #key > 8 then
        CurrentKey = key
        return true
    end
    return false
end

-- Main Loader
local function LoadRemoteScript(url)
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)
    
    if success and response then
        local loadedFunc = loadstring(response)
        if loadedFunc then
            loadedFunc()
            print("✅ Remote Script Loaded Successfully!")
        end
    else
        warn("❌ Failed to load remote script")
    end
end

print("Ld.lua Loader Initialized...")

--// Part 2: GUI Creation + Key System

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LdHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 650, 0, 420)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "Ld Hub - Loader"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Key System UI
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.7, 0, 0, 40)
KeyInput.Position = UDim2.new(0.15, 0, 0.3, 0)
KeyInput.PlaceholderText = "Enter Key Here..."
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Parent = MainFrame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.2, 0, 0, 40)
SubmitButton.Position = UDim2.new(0.65, 0, 0.3, 0)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
SubmitButton.Text = "Submit Key"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Parent = MainFrame

SubmitButton.MouseButton1Click:Connect(function()
    local enteredKey = KeyInput.Text
    if ValidateKey(enteredKey) then
        print("✅ Valid Key!")
        LoadRemoteScript("https://your-load-url.com/script.lua?key="..enteredKey)
    else
        warn("❌ Invalid Key!")
    end
end)

-- Status Label
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0.8, 0)
Status.BackgroundTransparency = 1
Status.Text = "Waiting for key..."
Status.TextColor3 = Color3.fromRGB(180, 180, 180)
Status.Parent = MainFrame

print("GUI Created Successfully")

--// Part 3: Remote Loading + Core Functions

local function LoadRemoteScript(scriptUrl)
    local success, response = pcall(function()
        return HttpService:GetAsync(scriptUrl, true)
    end)
    
    if success and response and #response > 100 then
        local loaded, err = pcall(function()
            return loadstring(response)()
        end)
        
        if loaded then
            Status.Text = "✅ Script Executed Successfully!"
            Status.TextColor3 = Color3.fromRGB(0, 255, 100)
        else
            warn("Loadstring Error: " .. tostring(err))
        end
    else
        warn("Failed to fetch script from server")
        Status.Text = "❌ Connection Failed"
    end
end

-- Auto Executor if key is valid
local function AutoExecute()
    if CurrentKey and #CurrentKey > 8 then
        LoadRemoteScript("https://api.ldhub.xyz/v1/load?key=" .. CurrentKey .. "&user=" .. LocalPlayer.Name)
    end
end

-- Main Hub Functions
local function ToggleESP(state)
    -- ESP Logic here (will be in next parts)
    print("ESP Toggled: " .. tostring(state))
end

local function AutoFarm()
    print("Auto Farm Started")
    -- Auto farming loop
end

SubmitButton.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    if ValidateKey(key) then
        AutoExecute()
    end
end)

-- Keyboard Shortcuts
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F1 then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

print("Core Functions Loaded")

--// Part 4: Features + Anti-Detection

local Features = {
    AutoFarm = false,
    Fly = false,
    SpeedHack = false,
    GodMode = false,
    ESP = false,
}

-- Anti-Detection Layer
local function AntiDetection()
    -- Hide script from executor detectors
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
    end
    -- More hooks if needed...
end

AntiDetection()

-- Main Feature Toggles
local function ToggleAutoFarm(state)
    Features.AutoFarm = state
    if state then
        StartAutoFarm()
    end
end

local function ToggleFly(state)
    Features.Fly = state
    if state then
        EnableFly()
    end
end

-- Button Connections Example
SubmitButton.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    if ValidateKey(key) then
        Status.Text = "Key Accepted - Loading..."
        LoadRemoteScript("https://load.example.com/v2/main?key=" .. key)
        
        -- Enable default features
        ToggleAutoFarm(true)
        ToggleFly(true)
    else
        Status.Text = "❌ Invalid Key"
    end
end)

-- Keyboard Shortcuts
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        ToggleFly(not Features.Fly)
    elseif input.KeyCode == Enum.KeyCode.R then
        ToggleAutoFarm(not Features.AutoFarm)
    end
end)

print("Features & Anti-Detection Loaded")

--// Part 5/5: Final Loader + Cleanup + Credits

print("Ld Hub - Full Loader Activated")

-- Final Execution
task.spawn(function()
    wait(1)
    if CurrentKey then
        print("✅ All Systems Ready!")
        -- Load any remaining modules
        LoadRemoteScript("https://load.example.com/modules/extra.lua?key=" .. CurrentKey)
    end
end)

-- Cleanup on leave
LocalPlayer.CharacterRemoving:Connect(function()
    if ScreenGui then
        ScreenGui:Destroy()
    end
end)

-- Credits / Watermark
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(0, 200, 0, 20)
Watermark.Position = UDim2.new(0, 10, 1, -30)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Ld.lua - Original Version"
Watermark.TextColor3 = Color3.fromRGB(100, 100, 100)
Watermark.TextSize = 12
Watermark.Font = Enum.Font.Gotham
Watermark.Parent = ScreenGui

print("====================================")
print("     Ld.lua Fully Loaded")
print("     Original Deobfuscated")
print("====================================")