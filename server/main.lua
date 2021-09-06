

ESX.RegisterServerCallback('rkl_clothing:checkMoney', function(source, cb, accessory)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		cb(xPlayer.getMoney() >= Config.Zones[accessory].Price)
	end
end)

RegisterServerEvent('rkl_clothing:pay')
AddEventHandler('rkl_clothing:pay', function(accessory)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.removeMoney(Config.Zones[accessory].Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones[accessory].Price)))
	end
end)

RegisterServerEvent('rkl_clothing:save')
AddEventHandler('rkl_clothing:save', function(skin, accessory)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		store.set('has' .. accessory, true)

		local itemSkin = {}
	
		local item1 = string.lower(accessory) .. '_1'
		local item2 = string.lower(accessory) .. '_2'
		
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]
		

		store.set('skin', itemSkin)
		
		if accessory == "Tshirt" then
			xPlayer.addInventoryItem('tshirt', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Thirst '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Torso" then
			xPlayer.addInventoryItem('torso', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Torso '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Ears" then
			xPlayer.addInventoryItem('ears', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Ears '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Mask" then
			xPlayer.addInventoryItem('mask', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Mask '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Helmet" then
			xPlayer.addInventoryItem('helmet', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Helmet '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Glasses" then
			xPlayer.addInventoryItem('glasses', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Glasses '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Arms" then
			xPlayer.addInventoryItem('arms', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Arms '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Shoes" then
			xPlayer.addInventoryItem('shoes', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Shoes '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Pants" then
			xPlayer.addInventoryItem('jeans', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Jeans '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Bags" then
			xPlayer.addInventoryItem('bag', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Bag '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Watches" then
			xPlayer.addInventoryItem('watches', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Watches '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Chain" then
			xPlayer.addInventoryItem('chain', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Chain '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		elseif accessory == "Bracelets" then
			xPlayer.addInventoryItem('bracelets', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Bracelets '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		end
		
	end)
end)
