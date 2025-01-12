-- AppCreator.lua
local AppCreator = {}

function AppCreator.createApp(name, code)
    local app = {}
    app.name = name
    app.code = code

    function app.run()
        local success, result = pcall(loadstring(code))
        if not success then
            print("Ошибка в приложении:", result)
        end
    end

    return app
end

return AppCreator
