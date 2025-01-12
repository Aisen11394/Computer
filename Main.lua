-- Main.lua
local Processor = require(script.Processor)
local OS = require(script.OS)
local AppCreator = require(script.AppCreator)

-- Инициализация GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RobloxOS"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local desktop = Instance.new("Frame")
desktop.Size = UDim2.new(1, 0, 1, 0)
desktop.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
desktop.Parent = screenGui

OS.desktop = desktop

-- Пример создания приложения
local appCode = [[
    print("Привет, это моё первое приложение на RBLOX!")
]]
local myApp = AppCreator.createApp("MyApp", appCode)
myApp.run()
