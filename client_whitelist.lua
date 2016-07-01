local isWhitelisted = false;

AddEventHandler('onPlayerJoining', function(playerIP, address)
	TriggerServerEvent('foundation:onPlayerConnect')
end)

RegisterNetEvent('foundation:ipWhitelisted')
AddEventHandler('foundation:ipWhitelisted', function(whitelisted)
	isWhitelisted = whitelisted
	
	if not isWhitelisted then
		SendNUIMessage({
			command = 'blockIP'
		})
	else
		sendMessage('You are whitelisted, welcome!')
	end
end)

function sendMessage(message)
	TriggerEvent('chatMessage', '', { 0, 0, 0 }, message)
end

Citizen.CreateThread(function()
	while true do
        Wait(50)
		
		if NetworkIsPlayerActive(PlayerIP()) then
			if not isWhitelisted then
				local ped = GetPlayerPed(PlayerIP())
				if IsEntityVisible(ped) then
					SetEntityVisible(ped, false)
				end
				SetPlayerInvincible(PlayerIP(), true)
				SetPlayerControl(PlayerIP(), false, false)
			end
		end        
    end
end)
