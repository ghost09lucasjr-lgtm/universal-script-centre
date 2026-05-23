--[[
    Universal Script Centre – Premium Glass Theme
    Grey/Black with glassmorphic overlay, draggable, toggleable, auto-execute.
    Uses your reliable loading method.
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- =========================== SCRIPT DATABASE ===========================
local Scripts = {
    {Name = "Infinite Yield", URL = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
    {Name = "Evade Exploit", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/refs/heads/main/Evade%20Exploit"},
    {Name = "No More Time", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/refs/heads/main/No%20more%20time."},
    {Name = "Modded Pshade", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/refs/heads/main/Modded%20Pshade"},
    {Name = "First Person Model", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/refs/heads/main/first%20person%20model"},
    {Name = "ThirdPerson Force", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/refs/heads/main/ThirdPerson%20Force"},
    {Name = "Vehicle Modifier", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/refs/heads/main/Vehiclemodifier.lua"},
    {Name = "Zoom Script", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/refs/heads/main/Zoom%20script."},
    {Name = "Script Loader", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/refs/heads/main/Script_Loader.lua"},
}

-- =========================== UI CREATION ===========================
local GUI = Instance.new("ScreenGui")
GUI.Name = "UniversalScriptCentre"
GUI.ResetOnSpawn = false
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame (glassmorphic grey/black)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 550)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BackgroundTransparency = 0.08
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = GUI

-- Corner rounding
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 14)
Corner.Parent = MainFrame

-- Subtle stroke
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(70, 70, 90)
Stroke.Thickness = 1.5
Stroke.Transparency = 0.4
Stroke.Parent = MainFrame

-- Glass overlay (the nice effect you liked)
local GlassOverlay = Instance.new("Frame")
GlassOverlay.Size = UDim2.fromScale(1, 1)
GlassOverlay.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
GlassOverlay.BackgroundTransparency = 0.25
GlassOverlay.BorderSizePixel = 0
GlassOverlay.Parent = MainFrame
local GlassCorner = Instance.new("UICorner")
GlassCorner.CornerRadius = UDim.new(0, 14)
GlassCorner.Parent = GlassOverlay

-- Title Bar (draggable)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 46)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TitleBar.BackgroundTransparency = 0.2
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 14)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -70, 1, 0)
TitleLabel.Position = UDim2.new(0, 18, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Universal Script Centre"
TitleLabel.Font = Enum.Font.GothamSemibold
TitleLabel.TextSize = 17
TitleLabel.TextColor3 = Color3.fromRGB(230, 230, 250)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 34, 0, 34)
MinimizeBtn.Position = UDim2.new(1, -44, 0, 6)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
MinimizeBtn.TextSize = 30
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TitleBar

-- Drag logic
local dragging = false
local dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Minimize toggle
local isMinimized = false
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, 0, 1, -46)
ContentContainer.Position = UDim2.new(0, 0, 0, 46)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetSize = isMinimized and UDim2.new(0, 450, 0, 54) or UDim2.new(0, 450, 0, 550)
    TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
    ContentContainer.Visible = not isMinimized
    MinimizeBtn.Text = isMinimized and "+" or "−"
end)

-- Script List Panel (semi-transparent)
local ScriptListFrame = Instance.new("Frame")
ScriptListFrame.Size = UDim2.new(1, -20, 0, 370)
ScriptListFrame.Position = UDim2.new(0, 10, 0, 10)
ScriptListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ScriptListFrame.BackgroundTransparency = 0.35
ScriptListFrame.BorderSizePixel = 0
ScriptListFrame.Parent = ContentContainer

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 10)
ListCorner.Parent = ScriptListFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -12, 1, -12)
ScrollingFrame.Position = UDim2.new(0, 6, 0, 6)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.Parent = ScriptListFrame

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.Padding = UDim.new(0, 8)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Parent = ScrollingFrame

local ScrollPadding = Instance.new("UIPadding")
ScrollPadding.PaddingLeft = UDim.new(0, 6)
ScrollPadding.PaddingRight = UDim.new(0, 6)
ScrollPadding.PaddingTop = UDim.new(0, 6)
ScrollPadding.PaddingBottom = UDim.new(0, 6)
ScrollPadding.Parent = ScrollingFrame

-- Create script buttons (glassy look)
local SelectedScript = nil
local LoadedScripts = {}

for _, script in ipairs(Scripts) do
    local Button = Instance.new("TextButton")
    Button.Name = script.Name
    Button.Size = UDim2.new(1, 0, 0, 46)
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Button.BackgroundTransparency = 0.3
    Button.TextColor3 = Color3.fromRGB(220, 220, 240)
    Button.Font = Enum.Font.GothamMedium
    Button.TextSize = 14
    Button.Text = script.Name
    Button.AutoButtonColor = false
    Button.Parent = ScrollingFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        if SelectedScript then
            SelectedScript.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            SelectedScript.BackgroundTransparency = 0.3
        end
        SelectedScript = Button
        Button.BackgroundColor3 = Color3.fromRGB(80, 100, 150)
        Button.BackgroundTransparency = 0.2
    end)

    Button.MouseEnter:Connect(function()
        if SelectedScript ~= Button then
            Button.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
            Button.BackgroundTransparency = 0.2
        end
    end)

    Button.MouseLeave:Connect(function()
        if SelectedScript ~= Button then
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            Button.BackgroundTransparency = 0.3
        end
    end)
end

-- Update canvas size
local function updateCanvas()
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollLayout.AbsoluteContentSize.Y + 12)
end
ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
updateCanvas()

-- Button container (Execute & Unload)
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, -20, 0, 90)
ButtonContainer.Position = UDim2.new(0, 10, 1, -100)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = ContentContainer

-- Execute Button
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Size = UDim2.new(0, 190, 0, 44)
ExecuteButton.Position = UDim2.new(0, 0, 0, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(65, 85, 125)
ExecuteButton.TextColor3 = Color3.new(1, 1, 1)
ExecuteButton.Font = Enum.Font.GothamBold
ExecuteButton.TextSize = 16
ExecuteButton.Text = "▶ EXECUTE"
ExecuteButton.AutoButtonColor = false
ExecuteButton.Parent = ButtonContainer

local ExecCorner = Instance.new("UICorner")
ExecCorner.CornerRadius = UDim.new(0, 10)
ExecCorner.Parent = ExecuteButton

ExecuteButton.MouseEnter:Connect(function()
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(85, 105, 145)
end)
ExecuteButton.MouseLeave:Connect(function()
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(65, 85, 125)
end)

-- Unload Button
local UnloadButton = Instance.new("TextButton")
UnloadButton.Size = UDim2.new(0, 190, 0, 44)
UnloadButton.Position = UDim2.new(1, -190, 0, 0)
UnloadButton.BackgroundColor3 = Color3.fromRGB(130, 70, 70)
UnloadButton.TextColor3 = Color3.new(1, 1, 1)
UnloadButton.Font = Enum.Font.GothamBold
UnloadButton.TextSize = 16
UnloadButton.Text = "✖ UNLOAD ALL"
UnloadButton.AutoButtonColor = false
UnloadButton.Parent = ButtonContainer

local UnloadCorner = Instance.new("UICorner")
UnloadCorner.CornerRadius = UDim.new(0, 10)
UnloadCorner.Parent = UnloadButton

UnloadButton.MouseEnter:Connect(function()
    UnloadButton.BackgroundColor3 = Color3.fromRGB(150, 85, 85)
end)
UnloadButton.MouseLeave:Connect(function()
    UnloadButton.BackgroundColor3 = Color3.fromRGB(130, 70, 70)
end)

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 24)
StatusLabel.Position = UDim2.new(0, 10, 1, -34)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "📦 Loaded: 0 scripts"
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.TextColor3 = Color3.fromRGB(170, 170, 200)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = ContentContainer

local function updateStatus()
    StatusLabel.Text = "📦 Loaded: " .. #LoadedScripts .. " scripts"
end

-- =========================== EXECUTION LOGIC (YOUR WORKING METHOD) ===========================
ExecuteButton.MouseButton1Click:Connect(function()
    if not SelectedScript then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Universal Script Centre",
            Text = "Select a script first",
            Duration = 2
        })
        return
    end

    local scriptName = SelectedScript.Name
    local script = nil
    for _, s in ipairs(Scripts) do
        if s.Name == scriptName then
            script = s
            break
        end
    end

    if script then
        ExecuteButton.Text = "LOADING..."
        ExecuteButton.BackgroundColor3 = Color3.fromRGB(200, 160, 50)

        local success, err = pcall(function()
            loadstring(game:HttpGet(script.URL))()
        end)

        if success then
            table.insert(LoadedScripts, scriptName)
            updateStatus()
            ExecuteButton.Text = "✓ EXECUTED"
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(70, 130, 90)
            game.StarterGui:SetCore("SendNotification", {
                Title = "Universal Script Centre",
                Text = scriptName .. " loaded successfully!",
                Duration = 3
            })
            task.wait(1.5)
            ExecuteButton.Text = "▶ EXECUTE"
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(65, 85, 125)
        else
            ExecuteButton.Text = "✗ ERROR"
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
            game.StarterGui:SetCore("SendNotification", {
                Title = "Universal Script Centre",
                Text = "Failed to load " .. scriptName,
                Duration = 3
            })
            warn("[USC] Error: " .. tostring(err))
            task.wait(2)
            ExecuteButton.Text = "▶ EXECUTE"
            ExecuteButton.BackgroundColor3 = Color3.fromRGB(65, 85, 125)
        end
    end
end)

-- Unload all scripts (cleans Rayfield, ESP, Zoom, etc.)
UnloadButton.MouseButton1Click:Connect(function()
    UnloadButton.Text = "UNLOADING..."
    UnloadButton.BackgroundColor3 = Color3.fromRGB(200, 160, 50)

    local patterns = {"Rayfield", "ESP", "Zoom", "NMT", "VehicleModifier", "CameraUnlocker", "ExtendedFOV", "UniversalScriptCentre"}
    for _, child in ipairs(game.CoreGui:GetChildren()) do
        for _, pattern in ipairs(patterns) do
            if child.Name:find(pattern) and child.Name ~= "UniversalScriptCentre" then
                pcall(function() child:Destroy() end)
            end
        end
    end
    for _, child in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
        for _, pattern in ipairs(patterns) do
            if child.Name:find(pattern) and child.Name ~= "UniversalScriptCentre" then
                pcall(function() child:Destroy() end)
            end
        end
    end

    LoadedScripts = {}
    SelectedScript = nil
    updateStatus()

    UnloadButton.Text = "✓ UNLOADED"
    UnloadButton.BackgroundColor3 = Color3.fromRGB(70, 130, 90)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Universal Script Centre",
        Text = "All scripts unloaded",
        Duration = 2
    })
    task.wait(1.5)
    UnloadButton.Text = "✖ UNLOAD ALL"
    UnloadButton.BackgroundColor3 = Color3.fromRGB(130, 70, 70)
end)

-- =========================== AUTO-EXECUTE ===========================
task.spawn(function()
    task.wait(1.5)
    print("[USC] Auto-loading Infinite Yield...")
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end)
    if success then
        table.insert(LoadedScripts, "Infinite Yield (Auto)")
        updateStatus()
        print("[USC] ✓ Infinite Yield loaded")
    else
        warn("[USC] Auto-load failed: " .. tostring(err))
    end
end)

-- =========================== TOGGLE WITH 'U' KEY ===========================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.U then
        GUI.Enabled = not GUI.Enabled
    end
end)

-- =========================== STARTUP NOTIFICATION ===========================
game.StarterGui:SetCore("SendNotification", {
    Title = "Universal Script Centre",
    Text = "Press U to toggle. Select a script and click EXECUTE.",
    Duration = 5
})

print("✅ Universal Script Centre (Premium Theme) loaded. Press U to toggle.")
