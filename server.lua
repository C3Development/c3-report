ESX = nil
local open_assists,active_assists = {},{}

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

function isAdmin(xPlayer)
    for k,v in ipairs(Config.staffs) do
        if xPlayer.getGroup()==v then return true end
    end
    return false
end

function execOnAdmins(func)
    local admin_online = 0
    for k,v in ipairs(ESX.GetPlayers()) do
        if isAdmin(ESX.GetPlayerFromId(v)) then
            admin_online = admin_online + 1
            func(v)
        end
    end
    return admin_online
end

RegisterCommand("report", function(source, args, rawCommand)
    local reason = table.concat(args," ")
    if reason=="" or not reason then TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"SERVER","Text a reason"}}); return end
    if not open_assists[source] and not active_assists[source] then
        local admin_online = execOnAdmins(function(admin) TriggerClientEvent("chat:addMessage",admin,{color={0,255,255},args={"SERVER",Config.text:format(GetPlayerName(source),source,reason)}}) end)
        if admin_online > 0 then
            TriggerClientEvent('esx:showNotification', source, '~b~You send report to admins!')
        else
            TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"SERVER","Theres no avaiblle admins here!"}})
        end
    end
end)