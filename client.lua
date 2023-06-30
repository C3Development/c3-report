ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	SetNuiFocus(false, false)
end)


Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/report', 'Report',{{name="What help do you need", help="Ask for your help!"}})
end)