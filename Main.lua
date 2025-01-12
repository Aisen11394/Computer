-- Main.lua
local OS = {}
local RBLOXMarket = {}

-- 1. Инициализация GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RobloxOS"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local desktop = Instance.new("Frame")
desktop.Size = UDim2.new(1, 0, 1, 0)
desktop.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
desktop.Parent = screenGui

OS.desktop = desktop

-- 2. Функция создания окон
function OS.createWindow(title, content)
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 400, 0, 300)
    window.Position = UDim2.new(0.5, -200, 0.5, -150)
    window.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    window.Active = true
    window.Draggable = true
    window.Parent = desktop

    local titleBar = Instance.new("TextLabel")
    titleBar.Size = UDim2.new(1, 0, 0, 20)
    titleBar.Text = title
    titleBar.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    titleBar.TextColor3 = Color3.new(1, 1, 1)
    titleBar.Parent = window

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -20)
    contentFrame.Position = UDim2.new(0, 0, 0, 20)
    contentFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    contentFrame.Parent = window

    if content then
        content.Parent = contentFrame
    end

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -20, 0, 0)
    closeButton.Text = "X"
    closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Parent = titleBar

    closeButton.MouseButton1Click:Connect(function()
        window:Destroy()
    end)
end

-- 3. RBLOX Market
RBLOXMarket.apps = {
    {
        name = "Калькулятор",
        description = "Простой калькулятор для RobloxOS.",
        code = [[
            local function createCalculator()
                local calculatorFrame = Instance.new("Frame")
                calculatorFrame.Size = UDim2.new(1, 0, 1, 0)
                calculatorFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

                local display = Instance.new("TextLabel")
                display.Size = UDim2.new(1, 0, 0, 30)
                display.Text = "0"
                display.TextColor3 = Color3.new(1, 1, 1)
                display.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                display.Parent = calculatorFrame

                local buttons = {
                    {"7", "8", "9", "+"},
                    {"4", "5", "6", "-"},
                    {"1", "2", "3", "*"},
                    {"C", "0", "=", "/"}
                }

                for row = 1, #buttons do
                    for col = 1, #buttons[row] do
                        local button = Instance.new("TextButton")
                        button.Size = UDim2.new(0.25, 0, 0.2, 0)
                        button.Position = UDim2.new((col - 1) * 0.25, 0, (row - 1) * 0.2 + 0.3, 0)
                        button.Text = buttons[row][col]
                        button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
                        button.TextColor3 = Color3.new(1, 1, 1)
                        button.Parent = calculatorFrame

                        button.MouseButton1Click:Connect(function()
                            if button.Text == "C" then
                                display.Text = "0"
                            elseif button.Text == "=" then
                                display.Text = tostring(loadstring("return " .. display.Text)())
                            else
                                if display.Text == "0" then
                                    display.Text = button.Text
                                else
                                    display.Text = display.Text .. button.Text
                                end
                            end
                        end)
                    end
                end

                OS.createWindow("Калькулятор", calculatorFrame)
            end

            createCalculator()
        ]]
    }
}

function RBLOXMarket.installApp(code)
    local success, result = pcall(loadstring(code))
    if success then
        return true
    else
        return false, "Ошибка установки приложения: " .. result
    end
end

-- 4. Приложение RBLOX Market
local function createMarketApp()
    local marketFrame = Instance.new("Frame")
    marketFrame.Size = UDim2.new(1, 0, 1, 0)
    marketFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, #RBLOXMarket.apps * 60)
    scroll.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    scroll.Parent = marketFrame

    for i, app in ipairs(RBLOXMarket.apps) do
        local appFrame = Instance.new("Frame")
        appFrame.Size = UDim2.new(1, 0, 0, 50)
        appFrame.Position = UDim2.new(0, 0, 0, (i - 1) * 60)
        appFrame.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        appFrame.Parent = scroll

        local appName = Instance.new("TextLabel")
        appName.Size = UDim2.new(0.7, 0, 1, 0)
        appName.Text = app.name
        appName.TextColor3 = Color3.new(1, 1, 1)
        appName.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
        appName.Parent = appFrame

        local appDescription = Instance.new("TextLabel")
        appDescription.Size = UDim2.new(0.7, 0, 0.5, 0)
        appDescription.Position = UDim2.new(0, 0, 0.5, 0)
        appDescription.Text = app.description
        appDescription.TextColor3 = Color3.new(1, 1, 1)
        appDescription.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
        appDescription.Parent = appFrame

        local installButton = Instance.new("TextButton")
        installButton.Size = UDim2.new(0.2, 0, 1, 0)
        installButton.Position = UDim2.new(0.8, 0, 0, 0)
        installButton.Text = "Установить"
        installButton.TextColor3 = Color3.new(1, 1, 1)
        installButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
        installButton.Parent = appFrame

        installButton.MouseButton1Click:Connect(function()
            local success, err = RBLOXMarket.installApp(app.code)
            if success then
                print("Приложение успешно установлено!")
            else
                print(err)
            end
        end)
    end

    -- Кнопка для добавления приложений
    local addAppButton = Instance.new("TextButton")
    addAppButton.Size = UDim2.new(0.2, 0, 0, 30)
    addAppButton.Position = UDim2.new(0.4, 0, 1, -30)
    addAppButton.Text = "Добавить приложение"
    addAppButton.TextColor3 = Color3.new(1, 1, 1)
    addAppButton.BackgroundColor3 = Color3.new(0.2, 0.4, 0.8)
    addAppButton.Parent = marketFrame

    addAppButton.MouseButton1Click:Connect(function()
        local addAppFrame = Instance.new("Frame")
        addAppFrame.Size = UDim2.new(1, 0, 1, 0)
        addAppFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        addAppFrame.Parent = marketFrame

        local nameInput = Instance.new("TextBox")
        nameInput.Size = UDim2.new(0.8, 0, 0, 30)
        nameInput.Position = UDim2.new(0.1, 0, 0.2, 0)
        nameInput.PlaceholderText = "Название приложения"
        nameInput.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        nameInput.TextColor3 = Color3.new(1, 1, 1)
        nameInput.Parent = addAppFrame

        local descriptionInput = Instance.new("TextBox")
        descriptionInput.Size = UDim2.new(0.8, 0, 0, 30)
        descriptionInput.Position = UDim2.new(0.1, 0, 0.4, 0)
        descriptionInput.PlaceholderText = "Описание приложения"
        descriptionInput.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        descriptionInput.TextColor3 = Color3.new(1, 1, 1)
        descriptionInput.Parent = addAppFrame

        local codeInput = Instance.new("TextBox")
        codeInput.Size = UDim2.new(0.8, 0, 0, 100)
        codeInput.Position = UDim2.new(0.1, 0, 0.6, 0)
        codeInput.PlaceholderText = "Код приложения (Lua)"
        codeInput.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        codeInput.TextColor3 = Color3.new(1, 1, 1)
        codeInput.MultiLine = true
        codeInput.Parent = addAppFrame

        local submitButton = Instance.new("TextButton")
        submitButton.Size = UDim2.new(0.3, 0, 0, 30)
        submitButton.Position = UDim2.new(0.35, 0, 0.9, 0)
        submitButton.Text = "Добавить"
        submitButton.TextColor3 = Color3.new(1, 1, 1)
        submitButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
        submitButton.Parent = addAppFrame

        submitButton.MouseButton1Click:Connect(function()
            table.insert(RBLOXMarket.apps, {
                name = nameInput.Text,
                description = descriptionInput.Text,
                code = codeInput.Text
            })
            addAppFrame:Destroy()
            createMarketApp() -- Обновляем интерфейс
        end)
    end)

    OS.createWindow("RBLOX Market", marketFrame)
end

-- 5. Меню "Пуск"
local taskbar = Instance.new("Frame")
taskbar.Size = UDim2.new(1, 0, 0, 40)
taskbar.Position = UDim2.new(0, 0, 1, -40)
taskbar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
taskbar.Parent = screenGui

local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0, 80, 1, 0)
startButton.Text = "Пуск"
startButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.Parent = taskbar

startButton.MouseButton1Click:Connect(function()
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 150, 0, 100)
    menu.Position = UDim2.new(0, 0, 0, -100)
    menu.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    menu.Parent = taskbar

    local marketButton = Instance.new("TextButton")
    marketButton.Size = UDim2.new(1, 0, 0, 30)
    marketButton.Text = "RBLOX Market"
    marketButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    marketButton.TextColor3 = Color3.new(1, 1, 1)
    marketButton.Parent = menu

    marketButton.MouseButton1Click:Connect(function()
        createMarketApp()
        menu:Destroy()
    end)
end)
