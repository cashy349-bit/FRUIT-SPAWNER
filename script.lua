-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage") -- Configuration
local FRUIT_MENU_GUI_NAME = "FruitMenu"
local SPAWN_REMOTE_NAME = "SpawnFruit"

-- Fruit list
local fruits = { "Rocket", "Spin", "Blade", "Spring", "Bomb", "Smoke", "Spike", "Flame", "Ice", "Sand", "Dark", "Eagle", "Diamond", "Light", "Rubber", "Ghost", "Magma", "Quake", "Buddha", "Love", "Creation", "Spider", "Sound", "Phoenix", "Portal", "Lightning", "Pain", "Blizzard", "Gravity", "Mammoth", "T-Rex", "Dough",
	"Shadow", "Venom", "Gas", "Spirit", "Tiger", "Yeti", "Kitsune", "Control", "Dragon"
} -- GUI creation
local player = Players.LocalPlayer
if not player then return end local playerGui = player:WaitForChild("PlayerGui") -- Remove existing copy
local oldGui = playerGui:FindFirstChild(FRUIT_MENU_GUI_NAME)
if oldGui then
	oldGui:Destroy()
end -- Screen GUI
local fruitMenu = Instance.new("ScreenGui")
fruitMenu.Name = FRUIT_MENU_GUI_NAME
fruitMenu.ResetOnSpawn = false
fruitMenu.Parent = playerGui

-- Main frame
local frame = Instance.new("Frame")
frame.Name = "FruitFrame"
frame.Size = UDim2.fromOffset(360, 500)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.15
frame.Parent = fruitMenu -- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 45)
title.Position = UDim2.fromOffset(10, 10)
title.Text = "Fruit Selector"
title.TextScaled = true
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Parent = frame

-- Minimize button
local minimize = Instance.new("TextButton")
minimize.Name = "MinimizeButton"
minimize.Size = UDim2.fromOffset(40, 35)
minimize.Position = UDim2.new(1, -90, 0, 8)
minimize.Text = "−"
minimize.TextSize = 24
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.BackgroundColor3 = Color3.fromRGB(70, 70, 85)
minimize.BorderSizePixel = 0
minimize.Parent = frame

Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 7)

local minimized = false
local normalSize = frame.Size

minimize.Activated:Connect(function()
    minimized = not minimized

    if minimized then
        frame.Size = UDim2.fromOffset(360, 55)
        listBox.Visible = false
        selected.Visible = false
        minimize.Text = "+"
    else
        frame.Size = normalSize
        listBox.Visible = true
        selected.Visible = true
        minimize.Text = "−"
    end
end)

-- Scrolling list
local listBox = Instance.new("ScrollingFrame")
listBox.Name = "FruitList"
listBox.Size = UDim2.new(1, -20, 1, -70)
listBox.Position = UDim2.fromOffset(10, 55)
listBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
listBox.BackgroundTransparency = 0.1
listBox.BorderSizePixel = 0
listBox.CanvasSize = UDim2.new(0, 0, 0, 0)
listBox.AutomaticCanvasSize = Enum.AutomaticSize.Y
listBox.ScrollBarThickness = 8
listBox.Parent = frame -- Layout
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = listBox -- Selection label
local selected = Instance.new("TextLabel")
selected.Size = UDim2.new(1, -20, 0, 30)
selected.Position = UDim2.fromOffset(10, frame.AbsoluteSize.Y - 40)
selected.Text = "Selected: None"
selected.TextColor3 = Color3.new(1, 1, 1)
selected.BackgroundTransparency = 1
selected.TextScaled = true
selected.Parent = frame -- UI-only selection handling
for _, fruitName in ipairs(fruits) do
    local button = Instance.new("TextButton")
    button.Name = fruitName
    button.Size = UDim2.new(1, 0, 0, 32)
    button.Text = fruitName
    button.TextColor3 = Color3.new(1, 1, 1)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    button.BorderSizePixel = 0
    button.AutoButtonColor = true
    button.Parent = listBox

    button.Activated:Connect(function()
        selected.Text = "Selected: " .. fruitName
        print("Selected fruit:", fruitName)
    end)
end

