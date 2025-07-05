locales = locales or {}

function getLocalizedText(text, ...)
    local message = nil

    if(locales[config.locale][text]) then
        message = locales[config.locale][text]
    else
        message = locales["en"][text]
    end
    
    return string.format(message, ...)
end

QBCore = exports['qb-core']:GetCoreObject()
