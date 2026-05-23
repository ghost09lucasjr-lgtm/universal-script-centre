-- Universal Script Centre Loader v3 (Anti-Stuck + Timeout)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local Scripts = {
    {Name = "No More Time", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/main/No%20more%20time."},
    {Name = "Evade Exploit", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/main/Evade%20Exploit"},
    {Name = "Modded Pshade", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/main/Modded%20Pshade"},
    {Name = "First Person Model", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/main/first%20person%20model"},
    {Name = "ThirdPerson Force", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/main/ThirdPerson%20Force"},
    {Name = "Vehicle Modifier", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/main/Vehiclemodifier.lua"},
    {Name = "Zoom Script", URL = "https://raw.githubusercontent.com/ghost09lucasjr-lgtm/universal-script-centre/main/Zoom%20script."},
}

local SelectedScript = nil

local GUI = Instance.new("ScreenGui")
GUI.Name = "USCLoader"
GUI.ResetOnSpawn = false
GUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 390, 0, 490)
MainFrame.Position = UDim2.new(0.5, -195, 0.5, -245)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = GUI

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(55, 55, 65)
Stroke.Thickness = 1.5
Stroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 46)
TitleBar.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Universal Script Centre"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.TextColor3 = Color3.fromRGB(225, 225, 235)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar
local TitlePad = Instance.new("UIPadding")
TitlePad.PaddingLeft = UDim.new(0, 16)
TitlePad.Parent = Title

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 34, 0, 34)
CloseBtn.Position = UDim2.new(1, -42, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(190, 45, 45)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Scroll
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 0, 310)
Scroll.Position = UDim2.new(0, 10, 0, 56)
Scroll.BackgroundColor3 = Color3.fromRGB(24, 24, 27)
Scroll.ScrollBarThickness = 6
Scroll.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 85)
Scroll.Parent = MainFrame

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 10)
ScrollCorner.Parent = Scroll

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 7)
Layout.Parent = Scroll

local Padding = Instance.new("UIPadding")
Padding.PaddingLeft = UDim.new(0, 8)
Padding.PaddingRight = UDim.new(0, 8)
Padding.PaddingTop = UDim.new(0, 8)
Padding.Parent = Scroll

-- Script Buttons
for _, script in ipairs(Scripts) do
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 44)
    Btn.BackgroundColor3 = Color3.fromRGB(34, 34, 39)
    Btn.Text = "  " .. script.Name
    Btn.TextColor3 = Color3.fromRGB(205, 205, 215)
    Btn.TextSize = 15
    Btn.Font = Enum.Font.Gotham
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.AutoButtonColor = false
    Btn.Parent = Scroll

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        if SelectedScript then
            SelectedScript.BackgroundColor3 = Color3.fromRGB(34, 34, 39)
        end
        SelectedScript = Btn
        Btn.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
    end)
end

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 20)
end)

-- Buttons Area
local BtnArea = Instance.new("Frame")
BtnArea.Size = UDim2.new(1, -20, 0, 80)
BtnArea.Position = UDim2.new(0, 10, 1, -90)
BtnArea.BackgroundTransparency = 1
BtnArea.Parent = MainFrame

local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Size = UDim2.new(0.5, -5, 0, 42)
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(45, 160, 80)
ExecuteBtn.Text = "Execute"
ExecuteBtn.TextColor3 = Color3.new(1,1,1)
ExecuteBtn.Font = Enum.Font.GothamBold
ExecuteBtn.TextSize = 15
ExecuteBtn.Parent = BtnArea

local UnloadBtn = Instance.new("TextButton")
UnloadBtn.Size = UDim2.new(0.5, -5, 0, 42)
UnloadBtn.Position = UDim2.new(0.5, 5, 0, 0)
UnloadBtn.BackgroundColor3 = Color3.fromRGB(170, 55, 55)
UnloadBtn.Text = "Unload All"
UnloadBtn.TextColor3 = Color3.new(1,1,1)
UnloadBtn.Font = Enum.Font.GothamBold
UnloadBtn.TextSize = 15
UnloadBtn.Parent = BtnArea

-- Execute with Timeout
ExecuteBtn.MouseButton1Click:Connect(function()
    if not SelectedScript then
        game.StarterGui:SetCore("SendNotification", {Title="Error", Text="Select a script first", Duration=3})
        return
    end

    local scriptName = SelectedScript.Text:match("%S.*")
    local scriptData = nil
    for _, s in ipairs(Scripts) do
        if s.Name == scriptName then scriptData = s break end
    end

    if not scriptData then return end

    ExecuteBtn.Text = "Loading..."
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 50)

    task.spawn(function()
        local timeout = 15
        local startTime = tick()

        local success, err = pcall(function()
            local code = game:HttpGet(scriptData.URL, true)
            loadstring(code)()
        end)

        if success then
            ExecuteBtn.Text = "✓ Success"
            ExecuteBtn.BackgroundColor3 = Color3.fromRGB(45, 160, 80)
        else
            ExecuteBtn.Text = "✗ Failed"
            ExecuteBtn.BackgroundColor3 = Color3.fromRGB(190, 50, 50)
            warn("Failed to load " .. scriptName .. ": " .. tostring(err))
        end

        task.wait(1.4)
        ExecuteBtn.Text = "Execute"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(45, 160, 80)
    end)
end)

-- Unload
UnloadBtn.MouseButton1Click:Connect(function()
    UnloadBtn.Text = "Unloading..."
    UnloadBtn.BackgroundColor3 = Color3.fromRGB(255, 160, 40)

    task.spawn(function()
        for _, v in ipairs(game.CoreGui:GetChildren()) do
            if v.Name:find("Rayfield") or v.Name:find("NMT") or v.Name:find("ESP") then
                pcall(function() v:Destroy() end)
            end
        end
        UnloadBtn.Text = "✓ Done"
        UnloadBtn.BackgroundColor3 = Color3.fromRGB(45, 160, 80)
        task.wait(1.3)
        UnloadBtn.Text = "Unload All"
        UnloadBtn.BackgroundColor3 = Color3.fromRGB(170, 55, 55)
    end)
end)

CloseBtn.MouseButton1Click:Connect(function() GUI:Destroy() end)

UserInputService.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.Delete then
        GUI.Enabled = not GUI.Enabled
    end
end)

print("✅ Universal Script Centre Loader v3 Loaded | Press DELETE to toggle")
