```lua
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
title.Parent = frame -- Scrolling list
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
selected.Parent = frame -- External dependency: RemoteEvent/RemoteFunction named "SpawnFruit"
local SpawnFruitRemote
do local candidate = ReplicatedStorage:FindFirstChild(SPAWN_REMOTE_NAME) if not candidate then -- Wait for it if it doesn't exist yet
 candidate = ReplicatedStorage:WaitForChild(SPAWN_REMOTE_NAME) end SpawnFruitRemote = candidate
end if not SpawnFruitRemote then
	warn(("Missing dependency: ReplicatedStorage.%s"):format(SPAWN_REMOTE_NAME)) return
end -- Selection handling / Button creation
for _, fruitName in ipairs(fruits) do local button = Instance.new("TextButton") button.Name = fruitName button.Size = UDim2.new(1, 0, 0, 32) button.Text = fruitName
	button.TextColor3 = Color3.new(1, 1, 1)
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 70) button.BorderSizePixel = 0 button.AutoButtonColor = true button.Parent = listBox 	button.Activated:Connect(function()
 -- Update UI selected.Text = "Selected: " .. fruitName print("Selected fruit:", fruitName)  -- External dependency behavior: -- If SpawnFruitRemote is a RemoteEvent, FireServer(fruitName). 	-- If it's a RemoteFunction, InvokeServer(fruitName).
		if SpawnFruitRemote:IsA("RemoteEvent") then 	SpawnFruitRemote:FireServer(fruitName) elseif SpawnFruitRemote:IsA("RemoteFunction") then 	SpawnFruitRemote:InvokeServer(fruitName) 	else  warn(("SpawnFruit dependency exists but is not RemoteEvent/RemoteFunction. Class=%s"):format(SpawnFruitRemote.ClassName)) end end)
end
```
--==================================================
-- ADDITIONAL FRUIT SELECTOR UI
-- Existing script above remains unchanged.
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local fruits = {
    "Rocket", "Spin", "Blade", "Spring", "Bomb", "Smoke", "Spike",
    "Flame", "Ice", "Sand", "Dark", "Eagle", "Diamond", "Light",
    "Rubber", "Ghost", "Magma", "Quake", "Buddha", "Love",
    "Creation", "Spider", "Sound", "Phoenix", "Portal", "Lightning",
    "Pain", "Blizzard", "Gravity", "Mammoth", "T-Rex", "Dough",
    "Shadow", "Venom", "Gas", "Spirit", "Tiger", "Yeti",
    "Kitsune", "Control", "Dragon"
}

local oldUI = playerGui:FindFirstChild("FruitSelectorUI")
if oldUI then
    oldUI:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "FruitSelectorUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(620, 460)
main.Position = UDim2.new(0.5, -310, 0.5, -230)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 50)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "🍎 Fruit Selector"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(40, 35)
close.Position = UDim2.new(1, -50, 0, 8)
close.Text = "×"
close.TextSize = 24
close.TextColor3 = Color3.new(1, 1, 1)
close.BackgroundColor3 = Color3.fromRGB(180, 55, 55)
close.Parent = main

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 7)

close.Activated:Connect(function()
    gui:Destroy()
end)

local search = Instance.new("TextBox")
search.Size = UDim2.fromOffset(280, 35)
search.Position = UDim2.fromOffset(15, 55)
search.PlaceholderText = "Search fruit..."
search.Text = ""
search.ClearTextOnFocus = false
search.TextColor3 = Color3.new(1, 1, 1)
search.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
search.BorderSizePixel = 0
search.Parent = main

Instance.new("UICorner", search).CornerRadius = UDim.new(0, 7)

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.fromOffset(280, 350)
list.Position = UDim2.fromOffset(15, 100)
list.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
list.BorderSizePixel = 0
list.ScrollBarThickness = 5
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.CanvasSize = UDim2.new()
list.Parent = main

Instance.new("UICorner", list).CornerRadius = UDim.new(0, 8)

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.Parent = list

local selected = Instance.new("TextLabel")
selected.Size = UDim2.fromOffset(280, 45)
selected.Position = UDim2.fromOffset(320, 100)
selected.BackgroundTransparency = 1
selected.Text = "Selected: None"
selected.TextColor3 = Color3.new(1, 1, 1)
selected.TextSize = 20
selected.Font = Enum.Font.GothamBold
selected.TextWrapped = true
selected.Parent = main

local preview = Instance.new("ImageLabel")
preview.Size = UDim2.fromOffset(220, 220)
preview.Position = UDim2.fromOffset(350, 155)
preview.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
preview.BorderSizePixel = 0
preview.ScaleType = Enum.ScaleType.Fit
preview.Image = ""
preview.Parent = main

Instance.new("UICorner", preview).CornerRadius = UDim.new(0, 10)

local function createButton(fruitName)
    local button = Instance.new("TextButton")

    button.Name = fruitName
    button.Size = UDim2.new(1, -10, 0, 32)
    button.Text = fruitName
    button.TextSize = 13
    button.Font = Enum.Font.GothamMedium
    button.TextColor3 = Color3.new(1, 1, 1)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    button.BorderSizePixel = 0
    button.Parent = list

    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

    button.Activated:Connect(function()
        selected.Text = "Selected: " .. fruitName

        -- Put an authorized image asset ID here if you have one.
        -- preview.Image = "rbxassetid://IMAGE_ID"
        
        print("Selected:", fruitName)
    end)
end

local function refresh(filter)
    for _, child in ipairs(list:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    filter = string.lower(filter or "")

    for _, fruitName in ipairs(fruits) do
        if filter == ""
            or string.find(string.lower(fruitName), filter, 1, true) then
            createButton(fruitName)
        end
    end
end

refresh("")

search:GetPropertyChangedSignal("Text"):Connect(function()
    refresh(search.Text)
end)

print("Additional Fruit Selector UI loaded.")
