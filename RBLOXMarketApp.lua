-- RBLOXMarketApp.lua
local RBLOXMarket = require(script.Parent.RBLOXMarket)
local OS = require(script.Parent.OS)

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
            local code, error = RBLOXMarket.downloadApp(app.url)
            if code then
                local success, err = RBLOXMarket.installApp(code)
                if success then
                    print("Приложение успешно установлено!")
                else
                    print(err)
                end
            else
                print(error)
            end
        end)
    end

    OS.createWindow("RBLOX Market", marketFrame)
end

return createMarketApp
