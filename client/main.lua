local HasAlreadyEnteredMarker, isDead = false, false
local LastZone, CurrentAction, CurrentActionMsg
local CurrentActionData	= {}

ESX          = nil

torso = false
tshirt = false
arms = false
ears = false
pants = false
shoes = false
hat = false
bag = false
bracelet = false
watches = false
mask = false
glasses = false
chain = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
        while true do
            TriggerEvent('clothes:cheecking')
             Citizen.Wait(5000)
        end
end)


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
				ESX.TriggerServerCallback('rkl_clothing:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerServerEvent('rkl_clothing:pay', accessory)
						TriggerEvent('skinchanger:getSkin', function(skin)
						
							TriggerServerEvent('rkl_clothing:save', skin, accessory)
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

AddEventHandler('rkl_clothing:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('rkl_clothing:hasExitedMarker', function(zone)
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
			TriggerEvent('rkl_clothing:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('rkl_clothing:hasExitedMarker', LastZone)
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


-- clothes to be used


RegisterNetEvent('clothes:cheecking')
AddEventHandler('clothes:cheecking', function()
    local player = PlayerPedId()
    local inventory = exports['linden_inventory']:SearchItems({'helmet','torso','tshirt','arms','ears','jeans','shoes','helmet','bag','bracelet','watches','chain','mask','glasses'})
    if inventory then
      for name, data in pairs(inventory) do
          local count = 0
          for _, v in pairs(data) do
              if v.slot then
                 -- print(v.slot..' contains '..v.count..' '..name..' '..json.encode(v.metadata))
                  count = count + v.count
              end
          end
         
           if count <= 0 and name == 'helmet' then
                ClearPedProp(player, 0)
            elseif count <= 0 and name == 'torso' then
                SetPedComponentVariation(player, 11, 15, 0, 3)
            elseif count <= 0 and name == 'tshirt' then
                SetPedComponentVariation(player, 8, -1, 0, 2)
            elseif count <= 0 and name == 'arms' then
                SetPedComponentVariation(player, 3, 15, 0, 0)
            elseif count <= 0 and name == 'ears' then
                ClearPedProp(player, 2)
            elseif count <= 0 and name == 'jeans' then
                SetPedComponentVariation(player, 4, 14, 1, 2)
            elseif count <= 0 and name == 'shoes' then
                SetPedComponentVariation(player, 6, 45, 0, 2)
            elseif count <= 0 and name == 'bracelet' then
                ClearPedProp(player,7)
            elseif count <= 0 and name == 'bag' then
                SetPedComponentVariation(player, 5, 0, 0, 2)
            elseif count <= 0 and name == 'watches' then
                ClearPedProp(player,6)
            elseif count <= 0 and name == 'chain' then
                SetPedComponentVariation(player, 7, 0, 0, 2)
            elseif count <= 0 and name == 'mask' then
                SetPedComponentVariation(PlayerPedId(), 1, -1, 0, 2)
            elseif count <= 0 and name == 'glasses' then
                ClearPedProp(player, 1)
         end
      end
    end
end)



function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

RegisterNetEvent('clothes:newbie')
AddEventHandler('clothes:newbie', function(item, wait, cb)
   TriggerServerEvent('getmynewbiepack')
end)

RegisterNetEvent('clothes:policenuniform')
AddEventHandler('clothes:policenuniform', function(item, wait, cb)
   TriggerServerEvent('policenuniform')
end)

RegisterNetEvent('clothes:mask')
AddEventHandler('clothes:mask', function(item, wait, cb)
   local player = PlayerPedId()
   local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
   local skin1 = metadata.accessories
   local skin2 = metadata.accessories2

	if not mask then
	maskonoff()
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	mask = true
	SetPedComponentVariation(PlayerPedId(), 1, skin1, skin2, 0)
	elseif mask then
	maskonoff()
	mask = false
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	SetPedComponentVariation(PlayerPedId(), 1, -1, 0, 2)
	end
end)

RegisterNetEvent('clothes:ears')
AddEventHandler('clothes:ears', function(item, wait, cb)
   local player = PlayerPedId()
   local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
   local skin1 = metadata.accessories
	local skin2 = metadata.accessories2

	
	
	if not ears then
	earsonoff()
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ears = true
	SetPedPropIndex(PlayerPedId(), 2, skin1, skin2, 2)
	elseif ears then
	earsonoff()
	ears = false
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(player, 2)
	end
end)



RegisterNetEvent('clothes:glasses')
AddEventHandler('clothes:glasses', function(item, wait, cb)
   local player = PlayerPedId()
   local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
   local skin1 = metadata.accessories
	local skin2 = metadata.accessories2

	
	
	if not glasses then
	glassesonoff()
	Wait(600)
	ClearPedSecondaryTask(player)
	glasses = true
	SetPedPropIndex(player, 1, skin1, skin2, 2) 
	elseif glasses then
	glassesonoff()
	glasses = false
	Wait(600)
	ClearPedSecondaryTask(player)
	ClearPedProp(player, 1)
	end
end)


RegisterNetEvent('clothes:helmet')
AddEventHandler('clothes:helmet', function(item, wait, cb)
   local player = PlayerPedId()
   local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
   local skin1 = metadata.accessories
   local skin2 = metadata.accessories2

	
	if not hat then
	hatofon()
	Wait (600)
	ClearPedSecondaryTask(player)
	hat = true
	
	SetPedPropIndex(player, 0, skin1, skin2, true)
	elseif hat then
	hatofon()
	hat = false
	Wait (600)
	ClearPedSecondaryTask(player)
	ClearPedProp(player, 0)
	end
	
	
end)


RegisterNetEvent('clothes:tshirt')
AddEventHandler('clothes:tshirt', function(item, wait, cb)
	local player = PlayerPedId()
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local skin1 = metadata.accessories
	 local skin2 = metadata.accessories2

	 
	 
	if not tshirt then
	tshirtonoff()
	Wait (600)
	ClearPedSecondaryTask(player)
	tshirt = true
	SetPedComponentVariation(player, 8, skin1, skin2, 0)
--	SetPedComponentVariation(PlayerPedId(), 3, 12, 0, 0) -- If you want to add a t-shirt, don’t touch this because it’s for the arms
	elseif tshirt then
	tshirtonoff()
	tshirt = false
	Wait (600)
	ClearPedSecondaryTask(player)
	SetPedComponentVariation(player, 8, -1, 0, 2)
	--SetPedComponentVariation(player, 3, 15, 0, 0)
	end
end)

RegisterNetEvent('clothes:arms')
AddEventHandler('clothes:arms', function(item, wait, cb)
	local player = PlayerPedId()
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local skin1 = metadata.accessories
	 local skin2 = metadata.accessories2

	 
	 
	if not arms then
	armsonoff()
	Wait (600)
	ClearPedSecondaryTask(player)
	arms = true
	SetPedComponentVariation(PlayerPedId(), 3, skin1, skin2, 0) 
	elseif arms then
	armsonoff()
	arms = false
	Wait (600)
	ClearPedSecondaryTask(player)

	SetPedComponentVariation(player, 3, 15, 0, 0)
	end
end)


RegisterNetEvent('clothes:torso')
AddEventHandler('clothes:torso', function(item, wait, cb)
   local player = PlayerPedId()
   local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
   local skin1 = metadata.accessories
   local skin2 = metadata.accessories2
	if not torso then
	torsoonoff()
	Wait(600)
	ClearPedSecondaryTask(player)
	torso = true
	SetPedComponentVariation(player, 11, skin1, skin2, 3) 
	--SetPedComponentVariation(player, 3, 12, 0, 0)
	elseif torso then
	torso = false
	torsoonoff()
	Wait(600)
	ClearPedSecondaryTask(player)
	SetPedComponentVariation(player, 11, 15, 0, 3)
	--SetPedComponentVariation(player, 3, 15, 0, 0)
	end
end)




RegisterNetEvent('clothes:jeans')
AddEventHandler('clothes:jeans', function(item, wait, cb)
    local player = PlayerPedId()
   local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
   local skin1 = metadata.accessories
	local skin2 = metadata.accessories2

	
	
	if not pants then
	jeansonoff()
	Wait(600)
	ClearPedSecondaryTask(player)
	pants = true
	SetPedComponentVariation(player, 4, skin1, skin2, 0) 
	elseif pants then
	jeansonoff()
	pants = false
	Wait(600)
	ClearPedSecondaryTask(player)
	SetPedComponentVariation(player, 4, 14, 1, 2)
	end


end)

RegisterNetEvent('clothes:shoes')
AddEventHandler('clothes:shoes', function(item, wait, cb)
	local player = PlayerPedId()
	local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
	local skin1 = metadata.accessories
	local skin2 = metadata.accessories2
 
	 
	 
	 if not shoes then
	 shoesonoff()
	 Wait(600)
	 ClearPedSecondaryTask(player)
	 shoes = true
	 SetPedComponentVariation(player, 6, skin1, skin2, 2) 
	 elseif shoes then
	 shoesonoff()
	 shoes = false
	 Wait(600)
	 ClearPedSecondaryTask(player)
	 SetPedComponentVariation(player, 6, 45, 0, 2)
	 end


end)
RegisterNetEvent('clothes:bag')
AddEventHandler('clothes:bag', function(item, wait, cb)
   local player = PlayerPedId()
   local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
   local skin1 = metadata.accessories
   local skin2 = metadata.accessories2

	if not bag then
	bagonoff()
	Wait (600)
	ClearPedSecondaryTask(player)
	bag = true
	SetPedComponentVariation(player, 5, skin1, skin2, 0)
	elseif bag then
	bagonoff()
	bag = false
	Wait (600)
	ClearPedSecondaryTask(player)
	SetPedComponentVariation(player, 5, 0, 0, 2)
	end
end)


RegisterNetEvent('clothes:watches')
AddEventHandler('clothes:watches', function(item, wait, cb)
   local player = PlayerPedId()
   local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
   local skin1 = metadata.accessories
   local skin2 = metadata.accessories2

	if not watches then
	watchesonoff()
	Wait (600)
	ClearPedSecondaryTask(player)
	watches = true
	SetPedPropIndex(player, 6, skin1, skin2, 0)
	elseif watches then
	watches = false
	Wait (600)
	ClearPedSecondaryTask(player)
	ClearPedProp(player,6)
	end
end)


RegisterNetEvent('clothes:chain')
AddEventHandler('clothes:chain', function(item, wait, cb)
   local player = PlayerPedId()
   local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
   local skin1 = metadata.accessories
   local skin2 = metadata.accessories2

	if not chain then
	chainonoff()
	Wait (600)
	ClearPedSecondaryTask(player)
	chain = true
	SetPedComponentVariation(player, 7, skin1, skin2, 0)
	elseif chain then
	chainonoff()
	chain = false
	Wait (600)
	SetPedComponentVariation(player, 7, 0, 0, 2)
	ClearPedProp(player,6)
	end
end)


RegisterNetEvent('clothes:bracelet')
AddEventHandler('clothes:bracelet', function(item, wait, cb)
   local player = PlayerPedId()
   local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
   local skin1 = metadata.accessories
   local skin2 = metadata.accessories2

	if not bracelet then
	braceletonoff()
	Wait (600)
	ClearPedSecondaryTask(player)
	bracelet = true
	SetPedPropIndex(player, 7, skin1, skin2, 0)
	elseif bracelet then
	braceletonoff()
	bracelet = false
	Wait (600)
	ClearPedSecondaryTask(player)
	ClearPedProp(player,7)
	end
end)




		function torsoonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
                    Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "clothingtie", -- https://alexguirre.github.io/animations-list/
                            animationName = "try_tie_negative_a",
                        },
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
			function hatofon()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "missheist_agency2ahelmet", -- https://alexguirre.github.io/animations-list/
                            animationName = "take_off_helmet_stand",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
				function maskonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "mp_masks@standard_car@ds@", -- https://alexguirre.github.io/animations-list/
                            animationName = "put_on_mask",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
			function earsonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "mp_cp_stolen_tut", -- https://alexguirre.github.io/animations-list/
                            animationName = "b_think",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
			function tshirtonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "clothingtie", -- https://alexguirre.github.io/animations-list/
                            animationName = "try_tie_negative_a",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
			function armsonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "nmt_3_rcm-10", -- https://alexguirre.github.io/animations-list/
                            animationName = "cs_nigel_dual-10",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
				function jeansonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "re@construction", -- https://alexguirre.github.io/animations-list/
                            animationName = "out_of_breath",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
				function shoesonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "random@domestic", -- https://alexguirre.github.io/animations-list/
                            animationName = "pickup_low",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
				function bagonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "anim@heists@ornate_bank@grab_cash", -- https://alexguirre.github.io/animations-list/
                            animationName = "intro",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
			function watchesonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "nmt_3_rcm-10", -- https://alexguirre.github.io/animations-list/
                            animationName = "cs_nigel_dual-10",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
			function chainonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "clothingtie", -- https://alexguirre.github.io/animations-list/
                            animationName = "try_tie_positive_a",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
			function braceletonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "nmt_3_rcm-10", -- https://alexguirre.github.io/animations-list/
                            animationName = "cs_nigel_dual-10",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
			function glassesonoff()
			exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,
                    y = 0.5,
                    From = 0,
                    To = 100,
                    Duration = 1000,
                    Radius = 60,
                    Stroke = 10,
                    MaxAngle = 360,
                    Rotation = 0,
                    Easing = "easeLinear",
                    Label = "",
                    LabelPosition = "right",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
					
                      
						Animation = {
                            --scenario = "WORLD_HUMAN_AA_SMOKE", -- https://pastebin.com/6mrYTdQv
                            animationDictionary = "clothingspecs", -- https://alexguirre.github.io/animations-list/
                            animationName = "take_off",
                        },
						
                    DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = false
                    }                                
                })
                 
			end
			
			