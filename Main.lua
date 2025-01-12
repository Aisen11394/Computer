-- Main.lua
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Включаем HttpService (если он отключён)
HttpService.HttpEnabled = true

-- 1. Инициализация GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RobloxOS"
screenGui.Parent = PlayerGui

local desktop = Instance.new("Frame")
desktop.Size = UDim2.new(1, 0, 1, 0)
desktop.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
desktop.Parent = screenGui

-- 2. Функция создания окон
local function createWindow(title, content)
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

-- 3. Загрузка приложения с GitHub
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

-- 4. Установка приложения
local function installApp(code)
    local success, result = pcall(function()
        loadstring(code)()
    end)
    if success then
        print("Приложение успешно установлено!")
    else
        warn("Ошибка установки приложения: " .. result)
    end
end

-- 5. Приложение RBLOX Market
local function createMarketApp()
    local marketFrame = Instance.new("Frame")
    marketFrame.Size = UDim2.new(1, 0, 1, 0)
    marketFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 100)
    scroll.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    scroll.Parent = marketFrame

    -- Пример приложения
    local appFrame = Instance.new("Frame")
    appFrame.Size = UDim2.new(1, 0, 0, 50)
    appFrame.Position = UDim2.new(0, 0, 0, 0)
    appFrame.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    appFrame.Parent = scroll

    local appName = Instance.new("TextLabel")
    appName.Size = UDim2.new(0.7, 0, 1, 0)
    appName.Text = "Калькулятор"
    appName.TextColor3 = Color3.new(1, 1, 1)
    appName.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
    appName.Parent = appFrame

    local installButton = Instance.new("TextButton")
    installButton.Size = UDim2.new(0.2, 0, 1, 0)
    installButton.Position = UDim2.new(0.8, 0, 0, 0)
    installButton.Text = "Установить"
    installButton.TextColor3 = Color3.new(1, 1, 1)
    installButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
    installButton.Parent = appFrame

    installButton.MouseButton1Click:Connect(function()
        local url = "https://raw.githubusercontent.com/Aisen11394/Computer/main/Apps/Calculator.lua"
        local code = loadAppFromGitHub(url)
        if code then
            installApp(code)
        else
            warn("Не удалось загрузить приложение.")
        end
    end)

    createWindow("RBLOX Market", marketFrame)
end

-- 6. Меню "Пуск"
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
