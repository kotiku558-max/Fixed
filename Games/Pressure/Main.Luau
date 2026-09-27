-- Fixed Hub — Menu для Solara (Pressure)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")

local old = CoreGui:FindFirstChild("FixedHub")
if old then old:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FixedHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- ==========================================
-- УВЕДОМЛЕНИЯ
-- ==========================================
local function showNotification(text, subtext, duration, withSound)
    duration = duration or 4

    if withSound then
        local bellSound = Instance.new("Sound")
        bellSound.SoundId = "rbxassetid://8784885431"
        bellSound.Volume = 3
        bellSound.Parent = SoundService
        bellSound.PlayOnRemove = true
        bellSound:Play()
        bellSound:Destroy()
    end

    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 240, 0, subtext and 58 or 46)
    notif.Position = UDim2.new(1, 260, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    notif.BorderSizePixel = 0
    notif.Parent = ScreenGui

    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8)
    notifCorner.Parent = notif

    local notifStroke = Instance.new("UIStroke")
    notifStroke.Color = Color3.fromRGB(100, 200, 100)
    notifStroke.Thickness = 2
    notifStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    notifStroke.Parent = notif

    local checkIcon = Instance.new("ImageLabel")
    checkIcon.Size = UDim2.new(0, 20, 0, 20)
    checkIcon.Position = UDim2.new(0, 10, 0, subtext and 12 or 8)
    checkIcon.BackgroundTransparency = 1
    checkIcon.Image = "rbxasset://textures/ui/GuiImagePicker/Selected.png"
    checkIcon.ImageColor3 = Color3.fromRGB(100, 200, 100)
    checkIcon.Parent = notif

    local notifLabel = Instance.new("TextLabel")
    notifLabel.Size = UDim2.new(1, -40, 0, 20)
    notifLabel.Position = UDim2.new(0, 38, 0, 5)
    notifLabel.BackgroundTransparency = 1
    notifLabel.Text = text
    notifLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifLabel.Font = Enum.Font.GothamBold
    notifLabel.TextSize = 12
    notifLabel.TextWrapped = true
    notifLabel.Parent = notif

    if subtext then
        local subLabel = Instance.new("TextLabel")
        subLabel.Size = UDim2.new(1, -40, 0, 16)
        subLabel.Position = UDim2.new(0, 38, 0, 27)
        subLabel.BackgroundTransparency = 1
        subLabel.Text = subtext
        subLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
        subLabel.Font = Enum.Font.Gotham
        subLabel.TextSize = 10
        subLabel.TextWrapped = true
        subLabel.Parent = notif
    end

    local tweenIn = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(notif, tweenIn, { Position = UDim2.new(1, -260, 0, 20) }):Play()

    task.delay(duration, function()
        local tweenOut = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local outTween = TweenService:Create(notif, tweenOut, { Position = UDim2.new(1, 260, 0, 20) })
        outTween:Play()
        outTween.Completed:Connect(function()
            notif:Destroy()
        end)
    end)
end

-- ==========================================
-- ИНТРО
-- ==========================================
local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(0, 0, 0, 0)
IntroFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
IntroFrame.AnchorPoint = Vector2.new(0.5, 0.5)
IntroFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
IntroFrame.BorderSizePixel = 0
IntroFrame.Parent = ScreenGui

local introCorner = Instance.new("UICorner")
introCorner.CornerRadius = UDim.new(0, 10)
introCorner.Parent = IntroFrame

local IntroStroke = Instance.new("UIStroke")
IntroStroke.Color = Color3.fromRGB(100, 150, 255)
IntroStroke.Thickness = 2
IntroStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
IntroStroke.Parent = IntroFrame

local IntroLabel = Instance.new("TextLabel")
IntroLabel.Size = UDim2.new(1, 0, 1, -18)
IntroLabel.Position = UDim2.new(0, 0, 0, 0)
IntroLabel.BackgroundTransparency = 1
IntroLabel.Text = "Fixed Hub"
IntroLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroLabel.Font = Enum.Font.GothamBold
IntroLabel.TextSize = 24
IntroLabel.Parent = IntroFrame

local IntroSubtitle = Instance.new("TextLabel")
IntroSubtitle.Size = UDim2.new(1, 0, 0, 16)
IntroSubtitle.Position = UDim2.new(0, 0, 1, -16)
IntroSubtitle.BackgroundTransparency = 1
IntroSubtitle.Text = "loading..."
IntroSubtitle.TextColor3 = Color3.fromRGB(150, 150, 160)
IntroSubtitle.Font = Enum.Font.Gotham
IntroSubtitle.TextSize = 11
IntroSubtitle.Parent = IntroFrame

-- ==========================================
-- ГЛАВНОЕ ОКНО
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = MainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 60, 70)
mainStroke.Thickness = 2
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 34)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 8)
topCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -16, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Fixed Hub | Pressure"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 30)
TabBar.Position = UDim2.new(0, 0, 0, 34)
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -8, 1, 0)
TabContainer.Position = UDim2.new(0, 4, 0, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = TabBar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 4)
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Parent = TabContainer

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -16, 1, -72)
ContentArea.Position = UDim2.new(0, 8, 0, 68)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- ==========================================
-- ВКЛАДКИ
-- ==========================================
local tabs = {}
local currentTab = nil

local function createTab(name)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0, 78, 1, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.TextSize = 11
    tabBtn.AutoButtonColor = false
    tabBtn.Parent = TabContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = tabBtn

    local tabStroke = Instance.new("UIStroke")
    tabStroke.Color = Color3.fromRGB(60, 60, 70)
    tabStroke.Thickness = 2
    tabStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    tabStroke.Parent = tabBtn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = ContentArea

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 6)
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    pageLayout.Parent = page

    local function selectTab()
        for _, tab in ipairs(tabs) do
            tab.button.TextColor3 = Color3.fromRGB(180, 180, 190)
            tab.stroke.Color = Color3.fromRGB(60, 60, 70)
            tab.stroke.Thickness = 2
            tab.page.Visible = false
        end
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabStroke.Color = Color3.fromRGB(100, 150, 255)
        tabStroke.Thickness = 3
        page.Visible = true
        currentTab = name
    end

    tabBtn.MouseButton1Click:Connect(selectTab)
    tabBtn.MouseEnter:Connect(function()
        if currentTab ~= name then tabStroke.Color = Color3.fromRGB(90, 90, 100) end
    end)
    tabBtn.MouseLeave:Connect(function()
        if currentTab ~= name then tabStroke.Color = Color3.fromRGB(60, 60, 70) end
    end)

    table.insert(tabs, { name = name, button = tabBtn, stroke = tabStroke, page = page, select = selectTab })
    return page
end

-- ==========================================
-- СЛАЙДЕР
-- ==========================================
local function createSlider(page, text, minVal, maxVal, default, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.92, 0, 0, 38)
    container.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    container.Parent = page

    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 6)
    containerCorner.Parent = container

    local containerStroke = Instance.new("UIStroke")
    containerStroke.Color = Color3.fromRGB(70, 70, 80)
    containerStroke.Thickness = 2
    containerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    containerStroke.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -8, 0, 16)
    label.Position = UDim2.new(0, 8, 0, 3)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. string.format("%.1f", default)
    label.TextColor3 = Color3.fromRGB(220, 220, 230)
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -16, 0, 5)
    track.Position = UDim2.new(0, 8, 0, 23)
    track.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    track.BorderSizePixel = 0
    track.Parent = container

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 3)
    trackCorner.Parent = track

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - minVal) / (maxVal - minVal), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    fill.BorderSizePixel = 0
    fill.Parent = track

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = fill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = UDim2.new(1, -6, 0.5, -6)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = fill

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 6)
    knobCorner.Parent = knob

    local dragging = false
    local function update(inputX)
        local relX = (inputX - track.AbsolutePosition.X) / track.AbsoluteSize.X
        relX = math.clamp(relX, 0, 1)
        local value = minVal + (maxVal - minVal) * relX
        value = math.floor(value * 10 + 0.5) / 10
        value = math.clamp(value, minVal, maxVal)
        fill.Size = UDim2.new((value - minVal) / (maxVal - minVal), 0, 1, 0)
        knob.Position = UDim2.new(1, -6, 0.5, -6)
        label.Text = text .. ": " .. string.format("%.1f", value)
        callback(value)
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input.Position.X)
        end
    end)
    return container, label
end

-- ==========================================
-- ПЕРЕКЛЮЧАТЕЛЬ
-- ==========================================
local function createSwitch(page, name, color, callback, showColorBox)
    local container = Instance.new("TextButton")
    container.Size = UDim2.new(0.92, 0, 0, 32)
    container.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
    container.AutoButtonColor = false
    container.Text = ""
    container.Parent = page

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = container

    local labelPosX = 12
    if showColorBox then
        local colorBox = Instance.new("Frame")
        colorBox.Size = UDim2.new(0, 16, 0, 16)
        colorBox.Position = UDim2.new(0, 8, 0, 8)
        colorBox.BackgroundColor3 = color
        colorBox.BorderSizePixel = 0
        colorBox.Parent = container

        local cbCorner = Instance.new("UICorner")
        cbCorner.CornerRadius = UDim.new(0, 4)
        cbCorner.Parent = colorBox
        labelPosX = 32
    end

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, -labelPosX - 8, 1, 0)
    label.Position = UDim2.new(0, labelPosX, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(200, 200, 210)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local switchBg = Instance.new("Frame")
    switchBg.Size = UDim2.new(0, 40, 0, 18)
    switchBg.Position = UDim2.new(1, -50, 0, 7)
    switchBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    switchBg.BorderSizePixel = 0
    switchBg.Parent = container

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 9)
    sCorner.Parent = switchBg

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 2, 0, 2)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = switchBg

    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(0, 7)
    kCorner.Parent = knob

    local isOn = false
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

    local function setOn(state)
        isOn = state
        if isOn then
            TweenService:Create(switchBg, tweenInfo, { BackgroundColor3 = color }):Play()
            TweenService:Create(knob, tweenInfo, { Position = UDim2.new(1, -16, 0, 2) }):Play()
        else
            TweenService:Create(switchBg, tweenInfo, { BackgroundColor3 = Color3.fromRGB(40, 40, 45) }):Play()
            TweenService:Create(knob, tweenInfo, { Position = UDim2.new(0, 2, 0, 2) }):Play()
        end
        callback(isOn)
    end

    container.MouseButton1Click:Connect(function()
        setOn(not isOn)
    end)
    return container, setOn
end

-- ==========================================
-- ПЕРЕТАСКИВАНИЕ
-- ==========================================
local dragging = false
local dragStart, startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
TopBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================
-- БЛОКИРОВКА / РАЗБЛОКИРОВКА МЫШИ
-- ==========================================
local menuOpen = false
local mouseConn = nil

local function unlockMouse()
    if mouseConn then mouseConn:Disconnect() mouseConn = nil end
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    UserInputService.MouseIconEnabled = true
    mouseConn = RunService.RenderStepped:Connect(function()
        if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
        if not UserInputService.MouseIconEnabled then
            UserInputService.MouseIconEnabled = true
        end
    end)
end

local function lockMouse()
    if mouseConn then mouseConn:Disconnect() mouseConn = nil end
    mouseConn = RunService.RenderStepped:Connect(function()
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        UserInputService.MouseIconEnabled = false
    end)
end

-- ==========================================
-- СЖАТИЕ / РАСКРЫТИЕ МЕНЮ
-- ==========================================
local animating = false

local function toggleMenu(open)
    if animating then return end
    animating = true
    menuOpen = open
    local targetSize = open and UDim2.new(0, 440, 0, 360) or UDim2.new(0, 0, 0, 0)
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    TweenService:Create(MainFrame, tweenInfo, { Size = targetSize }):Play()
    if open then unlockMouse() else lockMouse() end
    task.wait(0.3)
    animating = false
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightShift and not gameProcessed then
        toggleMenu(not menuOpen)
    end
end)

-- ==========================================
-- ИНТРО АНИМАЦИЯ
-- ==========================================
task.spawn(function()
    local tweenGrow = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tweenShrink = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    TweenService:Create(IntroFrame, tweenGrow, { Size = UDim2.new(0, 280, 0, 70) }):Play()
    task.wait(3.0)
    TweenService:Create(IntroFrame, tweenShrink, { Size = UDim2.new(0, 0, 0, 0) }):Play()
    task.wait(0.4)
    IntroFrame:Destroy()
    toggleMenu(true)
    showNotification("Fixed Hub запущен!", "Нажми RightShift для меню", 5, true)
end)

-- ==========================================
-- СОЗДАНИЕ ВКЛАДОК
-- ==========================================
local pageGeneral = createTab("General")
local pageExploits = createTab("Exploits")
local pageVisual = createTab("Visual")
local pageSetting = createTab("Setting")

tabs[1].select()

-- ==========================================
-- KEYBINDS PANEL
-- ==========================================
local keybindsPanelVisible = false

local keybindsFrame = Instance.new("Frame")
keybindsFrame.Size = UDim2.new(0, 180, 0, 76)
keybindsFrame.Position = UDim2.new(0, 10, 1, -86)
keybindsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
keybindsFrame.BorderSizePixel = 0
keybindsFrame.Visible = false
keybindsFrame.Parent = ScreenGui

local kbCorner = Instance.new("UICorner")
kbCorner.CornerRadius = UDim.new(0, 8)
kbCorner.Parent = keybindsFrame

local kbStroke = Instance.new("UIStroke")
kbStroke.Color = Color3.fromRGB(60, 60, 70)
kbStroke.Thickness = 2
kbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
kbStroke.Parent = keybindsFrame

local kbTitle = Instance.new("TextLabel")
kbTitle.Size = UDim2.new(1, 0, 0, 20)
kbTitle.Position = UDim2.new(0, 0, 0, 0)
kbTitle.BackgroundTransparency = 1
kbTitle.Text = "Keybinds"
kbTitle.TextColor3 = Color3.fromRGB(100, 150, 255)
kbTitle.Font = Enum.Font.GothamBold
kbTitle.TextSize = 12
kbTitle.Parent = keybindsFrame

local kbNoclipLine = Instance.new("TextLabel")
kbNoclipLine.Size = UDim2.new(1, -12, 0, 18)
kbNoclipLine.Position = UDim2.new(0, 6, 0, 22)
kbNoclipLine.BackgroundTransparency = 1
kbNoclipLine.Text = "  [N] Noclip  —  OFF"
kbNoclipLine.TextColor3 = Color3.fromRGB(200, 200, 210)
kbNoclipLine.Font = Enum.Font.Gotham
kbNoclipLine.TextSize = 11
kbNoclipLine.TextXAlignment = Enum.TextXAlignment.Left
kbNoclipLine.Parent = keybindsFrame

local kbFlyLine = Instance.new("TextLabel")
kbFlyLine.Size = UDim2.new(1, -12, 0, 18)
kbFlyLine.Position = UDim2.new(0, 6, 0, 42)
kbFlyLine.BackgroundTransparency = 1
kbFlyLine.Text = "  [F] Fly  —  OFF"
kbFlyLine.TextColor3 = Color3.fromRGB(200, 200, 210)
kbFlyLine.Font = Enum.Font.Gotham
kbFlyLine.TextSize = 11
kbFlyLine.TextXAlignment = Enum.TextXAlignment.Left
kbFlyLine.Parent = keybindsFrame

local kbShiftLine = Instance.new("TextLabel")
kbShiftLine.Size = UDim2.new(1, -12, 0, 18)
kbShiftLine.Position = UDim2.new(0, 6, 0, 60)
kbShiftLine.BackgroundTransparency = 1
kbShiftLine.Text = "  [RShift] Menu  —  OFF"
kbShiftLine.TextColor3 = Color3.fromRGB(200, 200, 210)
kbShiftLine.Font = Enum.Font.Gotham
kbShiftLine.TextSize = 11
kbShiftLine.TextXAlignment = Enum.TextXAlignment.Left
kbShiftLine.Parent = keybindsFrame

local function updateKeybindsPanel()
    kbNoclipLine.Text = "  [N] Noclip  —  " .. (noclipEnabled and "ON" or "OFF")
    kbNoclipLine.TextColor3 = noclipEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(200, 200, 210)

    kbFlyLine.Text = "  [F] Fly  —  " .. (flyEnabled and "ON" or "OFF")
    kbFlyLine.TextColor3 = flyEnabled and Color3.fromRGB(100, 200, 255) or Color3.fromRGB(200, 200, 210)

    kbShiftLine.Text = "  [RShift] Menu  —  " .. (menuOpen and "ON" or "OFF")
    kbShiftLine.TextColor3 = menuOpen and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(200, 200, 210)
end

-- ==========================================
-- TPWALK
-- ==========================================
local tpWalkEnabled = false
local tpWalkSpeed = 1

local function getMoveDirection()
    local camera = workspace.CurrentCamera
    if not camera then return Vector3.zero end
    local fwd = camera.CFrame.LookVector
    local right = camera.CFrame.RightVector
    fwd = Vector3.new(fwd.X, 0, fwd.Z).Unit
    right = Vector3.new(right.X, 0, right.Z).Unit
    local move = Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + fwd end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - fwd end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - right end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + right end
    if move.Magnitude > 0 then return move.Unit end
    return Vector3.zero
end

local tpWalkConn = nil

local function startTpWalk()
    if tpWalkConn then tpWalkConn:Disconnect() end
    tpWalkConn = RunService.Heartbeat:Connect(function()
        if not tpWalkEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end
        local dir = getMoveDirection()
        if dir == Vector3.zero then return end
        local moveOffset = dir * tpWalkSpeed * 0.1
        local newPos = hrp.Position + moveOffset
        newPos = Vector3.new(newPos.X, hrp.Position.Y, newPos.Z)
        hrp.CFrame = CFrame.new(newPos, newPos + dir)
        hrp.AssemblyLinearVelocity = Vector3.new(dir.X * tpWalkSpeed * 3, hrp.AssemblyLinearVelocity.Y, dir.Z * tpWalkSpeed * 3)
    end)
end

local function stopTpWalk()
    tpWalkEnabled = false
    if tpWalkConn then tpWalkConn:Disconnect() tpWalkConn = nil end
end

-- ==========================================
-- NOCLIP
-- ==========================================
local noclipEnabled = false
local noclipConn = nil

local function startNoclip()
    if noclipConn then noclipConn:Disconnect() end
    noclipConn = RunService.Stepped:Connect(function()
        if not noclipEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end)
end

local function stopNoclip()
    noclipEnabled = false
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
end

-- ==========================================
-- ENABLE JUMP
-- ==========================================
local jumpEnabled = false
local jumpPower = 50
local jumpConn = nil

local function startJump()
    if jumpConn then jumpConn:Disconnect() end
    jumpConn = RunService.Heartbeat:Connect(function()
        if not jumpEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        if not hum then return end
        if hum:GetState() == Enum.HumanoidStateType.Dead then return end

        local state = hum:GetState()
        if state == Enum.HumanoidStateType.Climbing
        or state == Enum.HumanoidStateType.Seated
        or state == Enum.HumanoidStateType.PlatformStanding then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end

        if hum.UseJumpPower == false then
            hum.UseJumpPower = true
        end
        hum.JumpPower = jumpPower

        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            hum.Jump = true
            task.wait(0.1)
            if hum:GetState() == Enum.HumanoidStateType.Seated
            or hum:GetState() == Enum.HumanoidStateType.PlatformStanding then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
    end)
end

local function stopJump()
    jumpEnabled = false
    if jumpConn then jumpConn:Disconnect() jumpConn = nil end
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.JumpPower = 50
        end
    end
end

-- ==========================================
-- SWIM BOOST (точно как Fly, только в воде)
-- ==========================================
local swimBoostEnabled = false
local swimSpeed = 80
local swimConn = nil

local function checkInWater(char)
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return false end
    if hum:GetState() == Enum.HumanoidStateType.Swimming then
        return true
    end
    if hum.FloorMaterial == Enum.Material.Water then
        return true
    end
    -- Запасная проверка через Terrain
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local terrain = workspace:FindFirstChildWhichIsA("Terrain")
        if terrain then
            local pos = hrp.Position
            local region = Region3.new(
                Vector3.new(pos.X - 2, pos.Y - 3, pos.Z - 2),
                Vector3.new(pos.X + 2, pos.Y + 3, pos.Z + 2)
            )
            local voxels = terrain:ReadVoxels(region, 4)
            if voxels and voxels[1] then
                for x = 1, #voxels[1] do
                    for y = 1, #voxels[1][x] do
                        for z = 1, #voxels[1][x][y] do
                            if voxels[1][x][y][z] == Enum.Material.Water then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

local function startSwimBoost()
    if swimConn then swimConn:Disconnect() swimConn = nil end

    swimConn = RunService.RenderStepped:Connect(function()
        if not swimBoostEnabled then return end

        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end

        local camera = workspace.CurrentCamera
        if not camera then return end

        local inWater = checkInWater(char)

        if inWater then
            local lookVec = camera.CFrame.LookVector
            local rightVec = camera.CFrame.RightVector
            local upVec = Vector3.new(0, 1, 0)

            local moveVec = Vector3.new(0, 0, 0)

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + lookVec end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - lookVec end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - rightVec end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + rightVec end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVec = moveVec + upVec end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveVec = moveVec - upVec end

            if moveVec.Magnitude > 0 then
                moveVec = moveVec.Unit
            end

            local dt = 0.016
            local newPos = hrp.Position + moveVec * swimSpeed * dt
            hrp.CFrame = CFrame.new(newPos, newPos + lookVec)
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        end
    end)
end

local function stopSwimBoost()
    swimBoostEnabled = false
    if swimConn then swimConn:Disconnect() swimConn = nil end
end

-- ==========================================
-- INFINITY JUMP
-- ==========================================
local infinityJumpEnabled = false
local infJumpConn = nil

local function startInfinityJump()
    if infJumpConn then infJumpConn:Disconnect() end
    infJumpConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not infinityJumpEnabled then return end
        if input.KeyCode == Enum.KeyCode.Space and not gameProcessed then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                if hum and hum:GetState() ~= Enum.HumanoidStateType.Dead then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end
    end)
end

local function stopInfinityJump()
    infinityJumpEnabled = false
    if infJumpConn then infJumpConn:Disconnect() infJumpConn = nil end
end

-- ==========================================
-- FLY (с anti-clip через raycast)
-- ==========================================
local flyEnabled = false
local flySpeed = 50
local flyConn = nil

local flyRayParams = RaycastParams.new()
flyRayParams.FilterType = Enum.RaycastFilterType.Exclude
flyRayParams.IgnoreWater = true

local function startFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end

    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        hum.PlatformStand = true
    end

    flyConn = RunService.RenderStepped:Connect(function()
        if not flyEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end

        local camera = workspace.CurrentCamera
        if not camera then return end

        local lookVec = camera.CFrame.LookVector
        local rightVec = camera.CFrame.RightVector
        local upVec = Vector3.new(0, 1, 0)

        local moveVec = Vector3.new(0, 0, 0)

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + lookVec end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - lookVec end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - rightVec end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + rightVec end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVec = moveVec + upVec end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveVec = moveVec - upVec end

        if moveVec.Magnitude > 0 then
            moveVec = moveVec.Unit
        end

        local dt = 0.016
        local moveDist = flySpeed * dt
        local currentPos = hrp.Position
        local targetPos = currentPos + moveVec * moveDist

        -- Raycast: проверяем стену на пути
        if moveVec.Magnitude > 0 then
            flyRayParams.FilterDescendantsInstances = {char}
            local rayResult = workspace:Raycast(currentPos, moveVec * (moveDist + 3), flyRayParams)

            if rayResult then
                -- Стена впереди — скользим вдоль неё
                local normal = rayResult.Normal
                moveVec = moveVec - normal * moveVec:Dot(normal)
                if moveVec.Magnitude > 0.01 then
                    moveVec = moveVec.Unit
                    targetPos = currentPos + moveVec * moveDist

                    -- Второй raycast вдоль стены
                    local ray2 = workspace:Raycast(currentPos, moveVec * (moveDist + 3), flyRayParams)
                    if ray2 then
                        targetPos = currentPos
                    end
                else
                    targetPos = currentPos
                end
            end
        end

        hrp.CFrame = CFrame.new(targetPos, targetPos + lookVec)
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end)
end

local function stopFly()
    flyEnabled = false
    if flyConn then flyConn:Disconnect() flyConn = nil end

    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
    end
end

-- ==========================================
-- BYPASS RUSHING
-- ==========================================
local bypassRushingEnabled = false
local bypassConn = nil
local bypassSavedPos = nil
local bypassHiding = false
local lastMonsterName = nil
local bypassHeight = 60

local RUSH_MONSTER_NAMES = {
    "Angler",
    "Blitz",
    "Pinkie",
    "Chainsmoker",
    "Froger",
    "Pipsqueak",
    "Pandemonium",
}

local function checkForMonster()
    for _, name in ipairs(RUSH_MONSTER_NAMES) do
        local obj = workspace:FindFirstChild(name)
        if obj then
            return name
        end
    end
    return nil
end

local function startBypassRushing()
    if bypassConn then task.cancel(bypassConn) end

    bypassConn = task.spawn(function()
        while bypassRushingEnabled do
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then
                if bypassHiding and bypassSavedPos then
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = CFrame.new(bypassSavedPos)
                        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    end
                end
                bypassHiding = false
                bypassSavedPos = nil
                lastMonsterName = nil
                stopBypassRushing()
                break
            end

            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then
                task.wait(0.1)
                continue
            end

            local currentMonster = checkForMonster()

            if currentMonster then
                if not bypassHiding then
                    bypassSavedPos = hrp.Position
                    bypassHiding = true
                    lastMonsterName = currentMonster

                    hrp.CFrame = CFrame.new(bypassSavedPos.X, bypassSavedPos.Y + bypassHeight, bypassSavedPos.Z)
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

                    showNotification("Rush Detected!", "Teleported UP (" .. currentMonster .. ")", 2, true)
                else
                    hrp.CFrame = CFrame.new(bypassSavedPos.X, bypassSavedPos.Y + bypassHeight, bypassSavedPos.Z)
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                end
            else
                if bypassHiding then
                    if bypassSavedPos then
                        hrp.CFrame = CFrame.new(bypassSavedPos)
                        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        bypassSavedPos = nil
                    end
                    bypassHiding = false
                    local wasName = lastMonsterName or "Unknown"
                    lastMonsterName = nil

                    showNotification("Rush Over", wasName .. " gone. Returned.", 2, false)
                end
            end

            task.wait(0.05)
        end
    end)
end

local function stopBypassRushing()
    bypassRushingEnabled = false
    if bypassConn then
        task.cancel(bypassConn)
        bypassConn = nil
    end
    if bypassHiding and bypassSavedPos then
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(bypassSavedPos)
                hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
        end
    end
    bypassHiding = false
    bypassSavedPos = nil
    lastMonsterName = nil
end

-- ==========================================
-- BYPASS EYEFESTATION (v6 — Active.Value override)
-- ==========================================
local bypassEyefestationEnabled = false
local eyefestationConn = nil
local eyefestationActive = false

local function findEyefestation()
    -- Eyefestation лежит в EyefestationSpawn или EyefestationRoot
    for _, parentName in ipairs({"EyefestationSpawn", "EyefestationRoot"}) do
        local parent = workspace:FindFirstChild(parentName)
        if parent then
            local eye = parent:FindFirstChild("Eyefestation")
            if eye then return eye end
        end
    end
    -- Запасной поиск по имени
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "Eyefestation" and obj:FindFirstChild("Active") then
            return obj
        end
    end
    return nil
end

local function startBypassEyefestation()
    if eyefestationConn then task.cancel(eyefestationConn) end

    eyefestationConn = task.spawn(function()
        while bypassEyefestationEnabled do
            local eye = findEyefestation()

            if eye then
                -- Главное: ставим Active = false каждый кадр
                local active = eye:FindFirstChild("Active")
                if active then
                    if active.Value then
                        active.Value = false
                    end
                end

                if not eyefestationActive then
                    eyefestationActive = true
                    showNotification("Eyefestation Detected!", "Active = false (bypassed)", 3, true)
                end

                -- Подстраховка: хилим
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChild("Humanoid")
                    if hum and hum.Health > 0 and hum.Health < hum.MaxHealth then
                        hum.Health = hum.MaxHealth
                    end
                end
            else
                if eyefestationActive then
                    eyefestationActive = false
                    showNotification("Eyefestation gone", "Safe again", 2, false)
                end
            end

            task.wait(0.05)
        end
    end)
end

local function stopBypassEyefestation()
    bypassEyefestationEnabled = false
    eyefestationActive = false
    if eyefestationConn then task.cancel(eyefestationConn) eyefestationConn = nil end
end

-- ==========================================
-- KEYBINDS: N (Noclip), F (Fly)
-- ==========================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.N then
        noclipEnabled = not noclipEnabled
        if noclipEnabled then
            startNoclip()
        else
            stopNoclip()
        end
    elseif input.KeyCode == Enum.KeyCode.F then
        flyEnabled = not flyEnabled
        if flyEnabled then
            startFly()
        else
            stopFly()
        end
    end
end)

-- ==========================================
-- GENERAL
-- ==========================================
createSwitch(pageGeneral, "Walkspeed", Color3.fromRGB(100, 150, 255), function(state)
    if state then tpWalkEnabled = true startTpWalk() else stopTpWalk() end
end, false)

createSlider(pageGeneral, "Walkspeed", 0.1, 4, 1, function(value)
    tpWalkSpeed = value
end)

local noclipSetOn = nil
local noclipContainer, noclipSetOn = createSwitch(pageGeneral, "Noclip [N]", Color3.fromRGB(255, 100, 100), function(state)
    if state then noclipEnabled = true startNoclip() else stopNoclip() end
end, false)

local flySetOn = nil
local flyContainer, flySetOn = createSwitch(pageGeneral, "Fly [F]", Color3.fromRGB(100, 200, 255), function(state)
    if state then flyEnabled = true startFly() else stopFly() end
end, false)

createSlider(pageGeneral, "Fly Speed", 10, 300, 50, function(value)
    flySpeed = math.floor(value)
end)

createSwitch(pageGeneral, "Enable Jump", Color3.fromRGB(100, 255, 100), function(state)
    if state then jumpEnabled = true startJump() else stopJump() end
end, false)

createSlider(pageGeneral, "Jump Power", 10, 200, 50, function(value)
    jumpPower = math.floor(value)
end)

createSwitch(pageGeneral, "Infinity Jump", Color3.fromRGB(150, 255, 150), function(state)
    if state then infinityJumpEnabled = true startInfinityJump() else stopInfinityJump() end
end, false)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.N then
        if noclipSetOn then noclipSetOn(noclipEnabled) end
    elseif input.KeyCode == Enum.KeyCode.F then
        if flySetOn then flySetOn(flyEnabled) end
    end
end)

-- ==========================================
-- EXPLOITS
-- ==========================================
createSwitch(pageExploits, "Bypass Rushing", Color3.fromRGB(255, 100, 100), function(state)
    if state then
        bypassRushingEnabled = true
        startBypassRushing()
    else
        stopBypassRushing()
    end
end, false)

createSwitch(pageExploits, "Bypass Eyefestation", Color3.fromRGB(255, 200, 50), function(state)
    if state then
        bypassEyefestationEnabled = true
        startBypassEyefestation()
    else
        stopBypassEyefestation()
    end
end, false)

createSwitch(pageExploits, "Exploit 3", Color3.fromRGB(150, 100, 255), function(state) end, false)

-- ==========================================
-- ESP (Doors, Objectives, Documents)
-- ==========================================
local espState = {
    Doors = false,
    Objectives = false,
    Documents = false,
}

local espTracked = {}
local espScanConn = nil
local espUpdateConn = nil
local MAX_ESP_DISTANCE = 200

local COLOR_DOOR = Color3.fromRGB(100, 150, 255)
local COLOR_OBJ = Color3.fromRGB(80, 255, 120)
local COLOR_DOC = Color3.fromRGB(255, 220, 80)
local COLOR_GEN_BROKEN = Color3.fromRGB(80, 255, 80)

local function createESPVisual(obj, color, labelText)
    local root = obj
    if obj:IsA("Model") then
        root = obj:FindFirstChildWhichIsA("BasePart")
        if not root then return nil end
    elseif not obj:IsA("BasePart") then
        return nil
    end

    local hl = Instance.new("Highlight")
    hl.Adornee = obj
    hl.FillColor = color
    hl.FillTransparency = 0.75
    hl.OutlineColor = color
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = obj

    local bb = Instance.new("BillboardGui")
    bb.Adornee = root
    bb.Size = UDim2.new(0, 150, 0, 30)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.Parent = obj

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = labelText
    textLabel.TextColor3 = color
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 14
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Parent = bb

    return { highlight = hl, billboard = bb, label = textLabel, root = root, text = labelText }
end

local function removeESPVisual(espData)
    if espData.highlight then espData.highlight:Destroy() end
    if espData.billboard then espData.billboard:Destroy() end
end

local function clearAllESP()
    for _, data in pairs(espTracked) do
        removeESPVisual(data)
    end
    espTracked = {}
end

local function isInsideNormalDoor(obj)
    local parent = obj.Parent
    while parent do
        if parent.Name == "NormalDoor" then return true end
        parent = parent.Parent
    end
    return false
end

local function getESPType(obj)
    local name = obj.Name
    local lower = name:lower()
    if name == "NormalDoor" and obj:IsA("Model") then
        return "Doors"
    end
    if lower:find("keycard") and not isInsideNormalDoor(obj) then
        return "Objectives"
    end
    if lower:find("currency") then
        return "Documents"
    end
    return nil
end

local function getObjectPos(obj)
    if obj:IsA("Model") then
        local part = obj:FindFirstChildWhichIsA("BasePart")
        if part then return part.Position end
    elseif obj:IsA("BasePart") then
        return obj.Position
    end
    return nil
end

local function getESPLabel(espType, obj)
    if espType == "Doors" then
        return "Door"
    elseif espType == "Objectives" then
        return "Keycard"
    elseif espType == "Documents" then
        return "Document"
    end
    return "Unknown"
end

local function findSearchGenerators()
    local results = {}
    local rooms = workspace:FindFirstChild("Rooms")
    if not rooms then return results end

    for _, roomName in ipairs({"SearchlightsEncounter", "SearchlightsEnding"}) do
        local room = rooms:FindFirstChild(roomName)
        if room then
            for _, obj in ipairs(room:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    local gen = obj.Parent
                    if gen and gen ~= room then
                        local name = gen.Name:lower()
                        local parentName = gen.Parent and gen.Parent.Name:lower() or ""
                        local isDoor = name:find("door") or parentName:find("door")
                        local isLever = name:find("lever") or parentName:find("lever")
                        if not isDoor and not isLever then
                            local alreadyAdded = false
                            for _, existing in ipairs(results) do
                                if existing == gen then
                                    alreadyAdded = true
                                    break
                                end
                            end
                            if not alreadyAdded then
                                table.insert(results, gen)
                            end
                        end
                    end
                end
            end
        end
    end

    return results
end

local function isGeneratorFixed(gen)
    local fixed = gen:FindFirstChild("Fixed")
    if fixed and typeof(fixed) == "Instance" and fixed:IsA("ValueBase") then
        return fixed.Value == true
    end
    if gen:GetAttribute("Fixed") == true then
        return true
    end
    -- ProximityPrompt disabled = fixed
    local pp = gen:FindFirstChildWhichIsA("ProximityPrompt")
    if pp and not pp.Enabled then
        return true
    end
    return false
end

local function isSearchlightGenerator(obj)
    -- Должен иметь RemoteEvent + RemoteFunction + Fixed
    if not obj:FindFirstChild("RemoteEvent") then return false end
    if not obj:FindFirstChild("RemoteFunction") then return false end
    if not obj:FindFirstChild("Fixed") then return false end

    -- Проверяем что предок — SearchlightsEncounter или SearchlightsEnding
    local parent = obj.Parent
    local foundSearchlight = false
    while parent do
        local pname = parent.Name:lower()
        if pname:find("searchlight") then
            foundSearchlight = true
            break
        end
        parent = parent.Parent
    end
    if not foundSearchlight then return false end

    -- Исключаем двери
    local name = obj.Name:lower()
    if name:find("door") then return false end

    return true
end

local function scanESP()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local playerPos = hrp.Position

    -- Обычный ESP (Doors, Keycard, Documents)
    for _, obj in ipairs(workspace:GetDescendants()) do
        local espType = getESPType(obj)
        if espType and espState[espType] and not espTracked[obj] then
            local objPos = getObjectPos(obj)
            if objPos and (objPos - playerPos).Magnitude <= MAX_ESP_DISTANCE then
                local color
                if espType == "Doors" then
                    color = COLOR_DOOR
                elseif espType == "Objectives" then
                    color = COLOR_OBJ
                elseif espType == "Documents" then
                    color = COLOR_DOC
                end
                local text = getESPLabel(espType, obj)
                local visual = createESPVisual(obj, color, text)
                if visual then
                    espTracked[obj] = visual
                end
            end
        end
    end

        -- Searchlights генераторы в Objectives (только сломанные, зелёным)
    if espState.Objectives then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if isSearchlightGenerator(obj) and not espTracked[obj] and not isGeneratorFixed(obj) then
                local objPos = getObjectPos(obj)
                if objPos and (objPos - playerPos).Magnitude <= MAX_ESP_DISTANCE then
                    local visual = createESPVisual(obj, COLOR_GEN_BROKEN, "Generator")
                    if visual then
                        visual.isGenerator = true
                        espTracked[obj] = visual
                    end
                end
            end
        end
    end
end

local function updateESP()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local playerPos = hrp.Position

    for obj, data in pairs(espTracked) do
        if not obj.Parent then
            removeESPVisual(data)
            espTracked[obj] = nil
        else
            local root = data.root
            if root and root.Parent then
                local dist = (playerPos - root.Position).Magnitude
                if dist > MAX_ESP_DISTANCE then
                    removeESPVisual(data)
                    espTracked[obj] = nil
                else
                    -- Если генератор починили — убираем ESP полностью
                    if data.isGenerator then
                        if isGeneratorFixed(obj) then
                            removeESPVisual(data)
                            espTracked[obj] = nil
                        else
                            data.label.Text = data.text .. " [" .. math.floor(dist) .. "m]"
                        end
                    else
                        data.label.Text = data.text .. " [" .. math.floor(dist) .. "m]"
                    end
                end
            else
                removeESPVisual(data)
                espTracked[obj] = nil
            end
        end
    end
end

local function startESP()
    if espScanConn then task.cancel(espScanConn) espScanConn = nil end
    if espUpdateConn then espUpdateConn:Disconnect() espUpdateConn = nil end

    scanESP()

    espScanConn = task.spawn(function()
        while true do
            local anyOn = espState.Doors or espState.Objectives or espState.Documents
            if anyOn then scanESP() end
            task.wait(2)
        end
    end)

    espUpdateConn = RunService.RenderStepped:Connect(updateESP)
end

-- ==========================================
-- ENTITY ESP (Tripwire, Wall Dwellers, Searchlights Generators)
-- ==========================================
local entityEspState = {
    Tripwire = false,
    WallDwellers = false,
}

local entityEspTracked = {}
local entityEspScanConn = nil
local entityEspUpdateConn = nil
local MAX_ENTITY_ESP_DIST = 300

local COLOR_TRIPWIRE = Color3.fromRGB(255, 50, 50)
local COLOR_DWELLER = Color3.fromRGB(180, 80, 255)
local COLOR_GEN_BROKEN = Color3.fromRGB(80, 255, 80)
local COLOR_GEN_FIXED = Color3.fromRGB(80, 255, 80)

local notifiedDwellers = {}

-- Имена Wall Dwellers из вики и кода Null Fire
local DWELLER_NAMES = {
    "WallDweller1", "WallDweller2",
    "RottenWallDweller", "MeatDweller",
    "RiverWallDweller", "WallDweller",
}

local function matchDwellerName(name)
    for _, alias in ipairs(DWELLER_NAMES) do
        if name == alias then return true end
    end
    return false
end

local function getEntityPos(obj)
    if obj:IsA("Model") then
        local ok, pos = pcall(function() return obj:GetPivot().Position end)
        if ok and pos then return pos end
        local part = obj:FindFirstChildWhichIsA("BasePart")
        if part then return part.Position end
    elseif obj:IsA("BasePart") then
        return obj.Position
    end
    return nil
end

local function createEntityESPVisual(obj, color, labelText)
    local root = obj
    if obj:IsA("Model") then
        root = obj:FindFirstChildWhichIsA("BasePart")
        if not root then
            local ok, pivot = pcall(function() return obj:GetPivot() end)
            if ok then return nil end
            return nil
        end
    elseif not obj:IsA("BasePart") then
        return nil
    end

    local hl = Instance.new("Highlight")
    hl.Adornee = obj
    hl.FillColor = color
    hl.FillTransparency = 0.6
    hl.OutlineColor = color
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = obj

    local bb = Instance.new("BillboardGui")
    bb.Adornee = root
    bb.Size = UDim2.new(0, 150, 0, 30)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.Parent = obj

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = labelText
    textLabel.TextColor3 = color
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 14
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Parent = bb

    return { highlight = hl, billboard = bb, label = textLabel, root = root, text = labelText, color = color }
end

local function removeEntityESPVisual(espData)
    if espData.highlight then espData.highlight:Destroy() end
    if espData.billboard then espData.billboard:Destroy() end
end

local function clearAllEntityESP()
    for _, data in pairs(entityEspTracked) do
        removeEntityESPVisual(data)
    end
    entityEspTracked = {}
end

-- Поиск генераторов в SearchlightsEncounter
local function findSearchGenerators()
    local results = {}
    local rooms = workspace:FindFirstChild("Rooms")
    if not rooms then return results end

    -- SearchlightsEncounter (боссфайт 1)
    local encounter = rooms:FindFirstChild("SearchlightsEncounter")
    if encounter then
        for _, obj in ipairs(encounter:GetDescendants()) do
            if obj:FindFirstChild("RemoteEvent") and obj:FindFirstChild("RemoteFunction") and obj:FindFirstChild("Fixed") then
                table.insert(results, obj)
            end
        end
    end

    -- SearchlightsEnding (боссфайт 2 — кабели)
    local ending = rooms:FindFirstChild("SearchlightsEnding")
    if ending then
        for _, obj in ipairs(ending:GetDescendants()) do
            if obj:FindFirstChild("RemoteEvent") and obj:FindFirstChild("RemoteFunction") and obj:FindFirstChild("Fixed") then
                table.insert(results, obj)
            end
        end
    end

    return results
end

local function scanEntityESP()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local playerPos = hrp.Position

    -- Tripwire
    if entityEspState.Tripwire then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Tripwire" and not entityEspTracked[obj] then
                local pos = getEntityPos(obj)
                if pos and (pos - playerPos).Magnitude <= MAX_ENTITY_ESP_DIST then
                    local v = createEntityESPVisual(obj, COLOR_TRIPWIRE, "Tripwire")
                    if v then entityEspTracked[obj] = v end
                end
            end
        end
    end

    -- Wall Dwellers
    if entityEspState.WallDwellers then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if matchDwellerName(obj.Name) and not entityEspTracked[obj] and obj:IsA("Model") then
                local pos = getEntityPos(obj)
                if pos and (pos - playerPos).Magnitude <= MAX_ENTITY_ESP_DIST then
                    -- Уведомление при первом обнаружении
                    if not notifiedDwellers[obj] then
                        notifiedDwellers[obj] = true
                        local displayName = obj.Name:gsub("%d+$", "")
                        showNotification("Wall Dweller Detected!", displayName .. " nearby", 3, true)
                    end
                    local v = createEntityESPVisual(obj, COLOR_DWELLER, "Wall Dweller")
                    if v then entityEspTracked[obj] = v end
                end
            end
        end
    end
end

local function updateEntityESP()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local playerPos = hrp.Position

    for obj, data in pairs(entityEspTracked) do
        if not obj.Parent then
            removeEntityESPVisual(data)
            entityEspTracked[obj] = nil
            notifiedDwellers[obj] = nil
        else
            local root = data.root
            local dist = nil
            if root and root.Parent then
                dist = (playerPos - root.Position).Magnitude
            else
                local pos = getEntityPos(obj)
                if pos then dist = (playerPos - pos).Magnitude end
            end

            if dist and dist > MAX_ENTITY_ESP_DIST then
                removeEntityESPVisual(data)
                entityEspTracked[obj] = nil
            elseif dist then
                -- Обновляем цвет генератора если состояние поменялось
                if data.text and data.text:find("Generator") then
                    local fixed = obj:FindFirstChild("Fixed")
                    if fixed then
                        local isFixed = fixed.Value
                        local newColor = isFixed and COLOR_GEN_FIXED or COLOR_GEN_BROKEN
                        local newLabel = isFixed and "Generator (Fixed)" or "Generator (BROKEN)"
                        if data.color ~= newColor then
                            data.color = newColor
                            data.highlight.FillColor = newColor
                            data.highlight.OutlineColor = newColor
                            data.label.TextColor3 = newColor
                        end
                        data.text = newLabel
                    end
                end
                data.label.Text = data.text .. " [" .. math.floor(dist) .. "m]"
            end
        end
    end
end

local function startEntityESP()
    if entityEspScanConn then task.cancel(entityEspScanConn) entityEspScanConn = nil end
    if entityEspUpdateConn then entityEspUpdateConn:Disconnect() entityEspUpdateConn = nil end

    scanEntityESP()

    entityEspScanConn = task.spawn(function()
        while true do
            local anyOn = entityEspState.Tripwire or entityEspState.WallDwellers or entityEspState.SearchGenerators
            if anyOn then scanEntityESP() end
            task.wait(2)
        end
    end)

    entityEspUpdateConn = RunService.RenderStepped:Connect(updateEntityESP)
end

-- ==========================================
-- VISUAL — ESP КНОПКИ
-- ==========================================
local espHeader = Instance.new("TextLabel")
espHeader.Size = UDim2.new(0.92, 0, 0, 22)
espHeader.BackgroundTransparency = 1
espHeader.Text = "ESP"
espHeader.TextColor3 = Color3.fromRGB(100, 150, 255)
espHeader.Font = Enum.Font.GothamBold
espHeader.TextSize = 13
espHeader.TextXAlignment = Enum.TextXAlignment.Left
espHeader.Parent = pageVisual

createSwitch(pageVisual, "Doors", COLOR_DOOR, function(state)
    espState.Doors = state
    startESP()
end, true)

createSwitch(pageVisual, "Objectives", COLOR_OBJ, function(state)
    espState.Objectives = state
    startESP()
end, true)

createSwitch(pageVisual, "Documents", COLOR_DOC, function(state)
    espState.Documents = state
    startESP()
end, true)

-- ==========================================
-- VISUAL — ENTITY ESP КНОПКИ
-- ==========================================
local entityHeader = Instance.new("TextLabel")
entityHeader.Size = UDim2.new(0.92, 0, 0, 22)
entityHeader.BackgroundTransparency = 1
entityHeader.Text = "Entity ESP"
entityHeader.TextColor3 = Color3.fromRGB(255, 80, 80)
entityHeader.Font = Enum.Font.GothamBold
entityHeader.TextSize = 13
entityHeader.TextXAlignment = Enum.TextXAlignment.Left
entityHeader.Parent = pageVisual

local entitySubHeader = Instance.new("TextLabel")
entitySubHeader.Size = UDim2.new(0.92, 0, 0, 16)
entitySubHeader.BackgroundTransparency = 1
entitySubHeader.Text = "Entity list:"
entitySubHeader.TextColor3 = Color3.fromRGB(150, 150, 160)
entitySubHeader.Font = Enum.Font.Gotham
entitySubHeader.TextSize = 11
entitySubHeader.TextXAlignment = Enum.TextXAlignment.Left
entitySubHeader.Parent = pageVisual

createSwitch(pageVisual, "Tripwire", COLOR_TRIPWIRE, function(state)
    entityEspState.Tripwire = state
    if not state then
        for obj, data in pairs(entityEspTracked) do
            if data.text and data.text:find("Tripwire") then
                removeEntityESPVisual(data)
                entityEspTracked[obj] = nil
            end
        end
    end
    startEntityESP()
end, true)

createSwitch(pageVisual, "Wall Dwellers", COLOR_DWELLER, function(state)
    entityEspState.WallDwellers = state
    if not state then
        for obj, data in pairs(entityEspTracked) do
            if data.text and data.text:find("Wall Dweller") then
                removeEntityESPVisual(data)
                entityEspTracked[obj] = nil
            end
        end
        notifiedDwellers = {}
    end
    startEntityESP()
end, true)

-- ==========================================
-- VISUAL — FULLBRIGHT
-- ==========================================
local fullbrightOn = false
local fbConn = nil
local origBrightness = nil
local origClockTime = nil
local origFogEnd = nil

createSwitch(pageVisual, "Fullbright", Color3.fromRGB(255, 255, 100), function(state)
    fullbrightOn = state
    if state then
        if origBrightness == nil then
            origBrightness = Lighting.Brightness
            origClockTime = Lighting.ClockTime
            origFogEnd = Lighting.FogEnd
        end
        if fbConn then fbConn:Disconnect() end
        fbConn = RunService.RenderStepped:Connect(function()
            Lighting.Brightness = 3
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
        end)
    else
        if fbConn then fbConn:Disconnect() fbConn = nil end
        if origBrightness ~= nil then
            Lighting.Brightness = origBrightness
            Lighting.ClockTime = origClockTime
            Lighting.FogEnd = origFogEnd
        end
    end
end, false)

-- ==========================================
-- SETTING
-- ==========================================
createSwitch(pageSetting, "Anti-AFK", Color3.fromRGB(100, 200, 200), function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end)
    end
end, false)

createSwitch(pageSetting, "Open Keybinds", Color3.fromRGB(100, 150, 255), function(state)
    keybindsPanelVisible = state
    keybindsFrame.Visible = state
end, false)

task.spawn(function()
    while true do
        if keybindsPanelVisible then
            updateKeybindsPanel()
        end
        task.wait(0.2)
    end
end)

-- ==========================================
-- DESTROY MENU
-- ==========================================
local destroyBtn = Instance.new("TextButton")
destroyBtn.Size = UDim2.new(0.92, 0, 0, 28)
destroyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
destroyBtn.Text = "Destroy Menu"
destroyBtn.TextColor3 = Color3.fromRGB(220, 220, 230)
destroyBtn.Font = Enum.Font.Gotham
destroyBtn.TextSize = 12
destroyBtn.AutoButtonColor = false
destroyBtn.Parent = pageSetting

local dbCorner = Instance.new("UICorner")
dbCorner.CornerRadius = UDim.new(0, 6)
dbCorner.Parent = destroyBtn

local dbStroke = Instance.new("UIStroke")
dbStroke.Color = Color3.fromRGB(180, 50, 50)
dbStroke.Thickness = 2
dbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
dbStroke.Parent = destroyBtn

destroyBtn.MouseEnter:Connect(function()
    dbStroke.Color = Color3.fromRGB(220, 80, 80)
end)
destroyBtn.MouseLeave:Connect(function()
    dbStroke.Color = Color3.fromRGB(180, 50, 50)
end)

destroyBtn.MouseButton1Click:Connect(function()
    stopTpWalk()
    stopNoclip()
    stopJump()
    stopFly()
    stopBypassRushing()
    stopBypassEyefestation()
    stopInfinityJump()
    stopSwimBoost()
    if espScanConn then task.cancel(espScanConn) espScanConn = nil end
    if espUpdateConn then espUpdateConn:Disconnect() espUpdateConn = nil end
    if entityEspScanConn then task.cancel(entityEspScanConn) entityEspScanConn = nil end
    if entityEspUpdateConn then entityEspUpdateConn:Disconnect() entityEspUpdateConn = nil end
    if fbConn then fbConn:Disconnect() fbConn = nil end
    if origBrightness ~= nil then
        Lighting.Brightness = origBrightness
        Lighting.ClockTime = origClockTime
        Lighting.FogEnd = origFogEnd
    end
    clearAllESP()
    clearAllEntityESP()
    keybindsFrame:Destroy()
    if mouseConn then mouseConn:Disconnect() mouseConn = nil end
    ScreenGui:Destroy()
end)
