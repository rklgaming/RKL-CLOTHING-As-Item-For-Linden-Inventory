local HasAlreadyEnteredMarker, isDead = false, false
local LastZone, CurrentAction, CurrentActionMsg
local CurrentActionData	= {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)



function OpenShopMenu(accessory)
	local _accessory = string.lower(accessory)
	local restrict = {}

	restrict = { _accessory .. '_1', _accessory .. '_2' }

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('valid_purchase'),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label ='Yes', value = 'yes'}
			}}, function(data, menu)
			menu.close()
			if data.current.value == 'yes' then
				ESX.TriggerServerCallback('esx_accessories:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerServerEvent('esx_accessories:pay', accessory)
						TriggerEvent('skinchanger:getSkin', function(skin)
						
							TriggerServerEvent('esx_accessories:save', skin, accessory)
							TriggerServerEvent('esx_skin:save', skin)
						end)
						
					
					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end, accessory)
			else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)	
			end

			
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}
		end)
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end, restrict)
end

AddEventHandler('esx:onPlayerSpawn', function() isDead = false end)
AddEventHandler('esx:onPlayerDeath', function() isDead = true end)

AddEventHandler('esx_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('esx_accessories:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create Blips --
Citizen.CreateThread(function()
	for k,v in pairs(Config.ShopsBlips) do
		if v.Pos ~= nil then
			for i=1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i])

				SetBlipSprite (blip, v.Blip.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.0)
				SetBlipColour (blip, v.Blip.color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('shop', _U(string.lower(k))))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)


local nearMarker = false
-- Display markers
Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local coords = GetEntityCoords(ESX.PlayerData.ped)
		local isInMarker = false
		local currentZone = nil
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(Config.Type ~= -1 and #(coords - v.Pos[i]) < Config.DrawDistance) then
				--	DrawMarker(Config.Type, v.Pos[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
					if v.Name == 'Tshirt' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '🎽\n Press [E] To T-Shirt Shop')
					elseif v.Name == 'Torso' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '👕\n Press [E] To Torso Shop')
					elseif v.Name == 'Arms' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '🥊\n Press [E] To Gloves Shop')
					elseif v.Name == 'Pants' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '👖\n Press [E] To Jeans Shop')
					elseif v.Name == 'Shoes' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '👟\n Press [E] To Shoe Shop')
					elseif v.Name == 'Ears' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '👂\n Press [E] To Ears Shop')
					elseif v.Name == 'Mask' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '🙈\n Press [E] To Mask Shop')
					elseif v.Name == 'Glasses' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '👓\n\n Press [E] To Glasses Shop')
					elseif v.Name == 'Helmet' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '👒\n\n Press [E] To Helmet Shop')
					elseif v.Name == 'Bags' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '👜\n\n Press [E] To Bags Shop')
					elseif v.Name == 'Chain' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '⛓️\n\n Press [E] To Chain Shop')
					elseif v.Name == 'Bracelets' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '📿\n\n Press [E] To Bracelets Shop')
					elseif v.Name == 'Watches' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '⌚\n\n Press [E] To Watches Shop')
					elseif v.Name == 'Hair' then
						DrawText3Ds(v.Pos[i]+0.5, 0.0, 0.0,  '⌚\n\n Press [E] To Barber Shop')
					end

					sleep = 0
					isInMarker  = true
						currentZone = k
					break
					
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('esx_accessories:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_accessories:hasExitedMarker', LastZone)
		end
		if sleep == 0 then nearMarker = true else nearMarker = false end
		Citizen.Wait(sleep)
	end
end)


-- Key controls



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
		

			if IsControlJustReleased(0, 38) and CurrentActionData.accessory then
				OpenShopMenu(CurrentActionData.accessory)
				

				currentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)


function DrawText3Ds(x, y, z, text)
	SetTextScale(0.55, 0.55)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
  --  DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end