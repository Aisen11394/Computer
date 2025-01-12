-- OS.lua
local OS = {}

function OS.createWindow(title, content)
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 400, 0, 300)
    window.Position = UDim2.new(0.5, -200, 0.5, -150)
    window.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    window.Active = true
    window.Draggable = true
    window.Parent = OS.desktop

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

return OS
