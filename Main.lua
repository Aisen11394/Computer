local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Включаем HttpService
HttpService.HttpEnabled = true

-- 1. Инициализация GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RobloxOS"
screenGui.Parent = PlayerGui

local desktop = Instance.new("Frame")
desktop.Size = UDim2.new(1, 0, 1, 0)
desktop.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
desktop.Parent = screenGui

-- 2. Консоль
local consoleFrame = Instance.new("Frame")
consoleFrame.Size = UDim2.new(1, 0, 0, 150)
consoleFrame.Position = UDim2.new(0, 0, 1, -150)
consoleFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
consoleFrame.Parent = desktop

local consoleScroll = Instance.new("ScrollingFrame")
consoleScroll.Size = UDim2.new(1, 0, 1, 0)
consoleScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
consoleScroll.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
consoleScroll.Parent = consoleFrame

local consoleText = Instance.new("TextLabel")
consoleText.Size = UDim2.new(1, 0, 0, 0)
consoleText.Text = ""
consoleText.TextColor3 = Color3.new(1, 1, 1)
consoleText.BackgroundTransparency = 1
consoleText.TextXAlignment = Enum.TextXAlignment.Left
consoleText.TextYAlignment = Enum.TextYAlignment.Top
consoleText.TextWrapped = true
consoleText.Font = Enum.Font.SourceSans
consoleText.TextSize = 14
consoleText.Parent = consoleScroll

-- Функция для добавления сообщений в консоль
local function logToConsole(message, color)
    local timestamp = os.date("%H:%M:%S")
    local formattedMessage = string.format("[%s] %s\n", timestamp, tostring(message))
    consoleText.Text = consoleText.Text .. formattedMessage
    consoleText.TextColor3 = color or Color3.new(1, 1, 1)
    consoleScroll.CanvasSize = UDim2.new(0, 0, 0, consoleText.TextBounds.Y)
    consoleScroll.CanvasPosition = Vector2.new(0, consoleText.TextBounds.Y)
end

-- Переопределяем функции print и warn
local originalPrint = print
local originalWarn = warn

print = function(...)
    local message = table.concat({...}, " ")
    logToConsole(message, Color3.new(1, 1, 1))  -- Белый цвет для print
    originalPrint(...)
end

warn = function(...)
    local message = table.concat({...}, " ")
    logToConsole(message, Color3.new(1, 0, 0))  -- Красный цвет для warn
    originalWarn(...)
end

-- 3. Функция создания окон
local function createWindow(title, content)
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 400, 0, 300)
    window.Position = UDim2.new(0.5, -200, 0.5, -150)
    window.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    window.Active = true
    window.Draggable = true
    window.Parent = desktop

    local titleBar = Instance.new("TextLabel")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.Text = title
    titleBar.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    titleBar.TextColor3 = Color3.new(1, 1, 1)
    titleBar.Font = Enum.Font.SourceSansBold
    titleBar.TextSize = 18
    titleBar.Parent = window

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    contentFrame.Parent = window

    if content then
        content.Parent = contentFrame
    end

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.Text = "X"
    closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 18
    closeButton.Parent = titleBar

    closeButton.MouseButton1Click:Connect(function()
        window:Destroy()
    end)
end

-- 4. Загрузка приложения с GitHub
local function loadAppFromGitHub(url)
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)
    if success then
        return response
    else
        warn("Ошибка загрузки приложения: " .. response)
        return nil
    end
end

-- 5. Установка приложения
local function installApp(code)
    local success, result = pcall(function()
        loadstring(code)()
    end)
    if success then
        print("Приложение успешно установлено!")
        return true
    else
        warn("Ошибка установки приложения: " .. result)
        return false
    end
end

-- 6. Приложение RBLOX Market
local function createMarketApp()
    local marketFrame = Instance.new("Frame")
    marketFrame.Size = UDim2.new(1, 0, 1, 0)
    marketFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, -40)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 100)
    scroll.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    scroll.Parent = marketFrame

    -- Пример приложения: Калькулятор
    local appFrame = Instance.new("Frame")
    appFrame.Size = UDim2.new(1, -20, 0, 50)
    appFrame.Position = UDim2.new(0, 10, 0, 10)
    appFrame.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    appFrame.Parent = scroll

    local appName = Instance.new("TextLabel")
    appName.Size = UDim2.new(0.7, 0, 1, 0)
    appName.Text = "Калькулятор"
    appName.TextColor3 = Color3.new(1, 1, 1)
    appName.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    appName.Font = Enum.Font.SourceSans
    appName.TextSize = 16
    appName.Parent = appFrame

    local installButton = Instance.new("TextButton")
    installButton.Size = UDim2.new(0.2, 0, 1, 0)
    installButton.Position = UDim2.new(0.8, 0, 0, 0)
    installButton.Text = "Установить"
    installButton.TextColor3 = Color3.new(1, 1, 1)
    installButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
    installButton.Font = Enum.Font.SourceSans
    installButton.TextSize = 16
    installButton.Parent = appFrame

    installButton.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/Aisen11394/Computer/main/Apps/Calculator.lua"
        local code = loadAppFromGitHub(url)
        if code then
            local success = installApp(code)
            if success then
                -- Создаём окно калькулятора
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

                createWindow("Калькулятор", calculatorFrame)
            end
        else
            warn("Не удалось загрузить приложение.")
        end
    end)

    -- Пример приложения: Rochome (браузер)
    local rochromeFrame = Instance.new("Frame")
    rochromeFrame.Size = UDim2.new(1, -20, 0, 50)
    rochromeFrame.Position = UDim2.new(0, 10, 0, 70)
    rochromeFrame.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    rochromeFrame.Parent = scroll

    local rochromeName = Instance.new("TextLabel")
    rochromeName.Size = UDim2.new(0.7, 0, 1, 0)
    rochromeName.Text = "Rochome"
    rochromeName.TextColor3 = Color3.new(1, 1, 1)
    rochromeName.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    rochromeName.Font = Enum.Font.SourceSans
    rochromeName.TextSize = 16
    rochromeName.Parent = rochromeFrame

    local installRochomeButton = Instance.new("TextButton")
    installRochomeButton.Size = UDim2.new(0.2, 0, 1, 0)
    installRochomeButton.Position = UDim2.new(0.8, 0, 0, 0)
    installRochomeButton.Text = "Установить"
    installRochomeButton.TextColor3 = Color3.new(1, 1, 1)
    installRochomeButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
    installRochomeButton.Font = Enum.Font.SourceSans
    installRochomeButton.TextSize = 16
    installRochomeButton.Parent = rochromeFrame

    installRochomeButton.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/Aisen11394/Computer/main/Apps/Rochome.lua"
        local code = loadAppFromGitHub(url)
        if code then
            local success = installApp(code)
            if success then
                -- Создаём окно Rochome
                local rochromeWindow = Instance.new("Frame")
                rochromeWindow.Size = UDim2.new(1, 0, 1, 0)
                rochromeWindow.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

                local addressBar = Instance.new("TextBox")
                addressBar.Size = UDim2.new(1, 0, 0, 30)
                addressBar.PlaceholderText = "Введите URL"
                addressBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                addressBar.TextColor3 = Color3.new(1, 1, 1)
                addressBar.Font = Enum.Font.SourceSans
                addressBar.TextSize = 16
                addressBar.Parent = rochromeWindow

                local contentFrame = Instance.new("ScrollingFrame")
                contentFrame.Size = UDim2.new(1, 0, 1, -30)
                contentFrame.Position = UDim2.new(0, 0, 0, 30)
                contentFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
                contentFrame.Parent = rochromeWindow

                local contentText = Instance.new("TextLabel")
                contentText.Size = UDim2.new(1, 0, 0, 0)
                contentText.Text = "Добро пожаловать в Rochome!"
                contentText.TextColor3 = Color3.new(1, 1, 1)
                contentText.BackgroundTransparency = 1
                contentText.TextWrapped = true
                contentText.Font = Enum.Font.SourceSans
                contentText.TextSize = 16
                contentText.Parent = contentFrame

                addressBar.FocusLost:Connect(function()
                    local url = addressBar.Text
                    if url ~= "" then
                        local success, response = pcall(function()
                            return HttpService:GetAsync(url)
                        end)
                        if success then
                            contentText.Text = response
                        else
                            contentText.Text = "Ошибка загрузки страницы: " .. response
                        end
                    end
                end)

                createWindow("Rochome", rochromeWindow)
            end
        else
            warn("Не удалось загрузить приложение.")
        end
    end)

    -- Кнопка для добавления приложений
    local addAppButton = Instance.new("TextButton")
    addAppButton.Size = UDim2.new(0.8, 0, 0, 30)
    addAppButton.Position = UDim2.new(0.1, 0, 1, -35)
    addAppButton.Text = "Добавить приложение"
    addAppButton.TextColor3 = Color3.new(1, 1, 1)
    addAppButton.BackgroundColor3 = Color3.new(0.2, 0.4, 0.8)
    addAppButton.Font = Enum.Font.SourceSans
    addAppButton.TextSize = 16
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
        nameInput.Font = Enum.Font.SourceSans
        nameInput.TextSize = 16
        nameInput.Parent = addAppFrame

        local descriptionInput = Instance.new("TextBox")
        descriptionInput.Size = UDim2.new(0.8, 0, 0, 30)
        descriptionInput.Position = UDim2.new(0.1, 0, 0.4, 0)
        descriptionInput.PlaceholderText = "Описание приложения"
        descriptionInput.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        descriptionInput.TextColor3 = Color3.new(1, 1, 1)
        descriptionInput.Font = Enum.Font.SourceSans
        descriptionInput.TextSize = 16
        descriptionInput.Parent = addAppFrame

        local codeInput = Instance.new("TextBox")
        codeInput.Size = UDim2.new(0.8, 0, 0, 100)
        codeInput.Position = UDim2.new(0.1, 0, 0.6, 0)
        codeInput.PlaceholderText = "Код приложения (Lua)"
        codeInput.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        codeInput.TextColor3 = Color3.new(1, 1, 1)
        codeInput.MultiLine = true
        codeInput.Font = Enum.Font.SourceSans
        codeInput.TextSize = 16
        codeInput.Parent = addAppFrame

        local submitButton = Instance.new("TextButton")
        submitButton.Size = UDim2.new(0.3, 0, 0, 30)
        submitButton.Position = UDim2.new(0.35, 0, 0.9, 0)
        submitButton.Text = "Добавить"
        submitButton.TextColor3 = Color3.new(1, 1, 1)
        submitButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
        submitButton.Font = Enum.Font.SourceSans
        submitButton.TextSize = 16
        submitButton.Parent = addAppFrame

        submitButton.MouseButton1Click:Connect(function()
            local appName = nameInput.Text
            local appDescription = descriptionInput.Text
            local appCode = codeInput.Text

            if appName ~= "" and appCode ~= "" then
                -- Добавляем приложение в список
                local newAppFrame = Instance.new("Frame")
                newAppFrame.Size = UDim2.new(1, -20, 0, 50)
                newAppFrame.Position = UDim2.new(0, 10, 0, #scroll:GetChildren() * 60 + 10)
                newAppFrame.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
                newAppFrame.Parent = scroll

                local newAppName = Instance.new("TextLabel")
                newAppName.Size = UDim2.new(0.7, 0, 1, 0)
                newAppName.Text = appName
                newAppName.TextColor3 = Color3.new(1, 1, 1)
                newAppName.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
                newAppName.Font = Enum.Font.SourceSans
                newAppName.TextSize = 16
                newAppName.Parent = newAppFrame

                local installButton = Instance.new("TextButton")
                installButton.Size = UDim2.new(0.2, 0, 1, 0)
                installButton.Position = UDim2.new(0.8, 0, 0, 0)
                installButton.Text = "Установить"
                installButton.TextColor3 = Color3.new(1, 1, 1)
                installButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
                installButton.Font = Enum.Font.SourceSans
                installButton.TextSize = 16
                installButton.Parent = newAppFrame

                installButton.MouseButton1Click:Connect(function()
                    local success = installApp(appCode)
                    if success then
                        print("Приложение успешно установлено!")
                    else
                        warn("Ошибка установки приложения.")
                    end
                end)

                -- Закрываем окно добавления
                addAppFrame:Destroy()
            else
                warn("Заполните все поля!")
            end
        end)
    end)

    createWindow("RBLOX Market", marketFrame)
end

-- 7. Меню "Пуск"
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
startButton.Font = Enum.Font.SourceSansBold
startButton.TextSize = 18
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
    marketButton.Font = Enum.Font.SourceSans
    marketButton.TextSize = 16
    marketButton.Parent = menu

    marketButton.MouseButton1Click:Connect(function()
        createMarketApp()
        menu:Destroy()
    end)
end)
