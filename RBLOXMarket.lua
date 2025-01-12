-- RBLOXMarket.lua
local RBLOXMarket = {}

RBLOXMarket.apps = {
    {
        name = "Калькулятор",
        description = "Простой калькулятор для RobloxOS.",
        url = "https://raw.githubusercontent.com/ваш-username/RBLOX-Market/main/Apps/Calculator.lua"
    },
    {
        name = "Блокнот",
        description = "Текстовый редактор для RobloxOS.",
        url = "https://raw.githubusercontent.com/ваш-username/RBLOX-Market/main/Apps/Notepad.lua"
    }
}

function RBLOXMarket.downloadApp(url)
    local success, code = pcall(game.HttpGet, game, url)
    if success then
        return code
    else
        return nil, "Ошибка загрузки приложения."
    end
end

function RBLOXMarket.installApp(code)
    local success, result = pcall(loadstring(code))
    if success then
        return true
    else
        return false, "Ошибка установки приложения: " .. result
    end
end

return RBLOXMarket
