RegisterServerEvent('esx_accessories:pay')
AddEventHandler('esx_accessories:pay', function(accessory)
	local xPlayer = ESX.GetPlayerFromId(source)
	if accessory == "Ears" then
		xPlayer.removeMoney(Config.Zones.Ears.Price)
		
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Ears.Price)))
	elseif accessory == "Mask" then
		xPlayer.removeMoney(Config.Zones.Mask.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Mask.Price)))
		
	elseif accessory == "Helmet" then
		xPlayer.removeMoney(Config.Zones.Helmet.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Helmet.Price)))
		
	elseif accessory == "Glasses" then
		xPlayer.removeMoney(Config.Zones.Glasses.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Glasses.Price)))
		
	elseif accessory == "Torso" then
		xPlayer.removeMoney(Config.Zones.Torso.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Torso.Price)))
		
	elseif accessory == "Tshirt" then
		xPlayer.removeMoney(Config.Zones.Tshirt.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Tshirt.Price)))
		
	elseif accessory == "Shoes" then
		xPlayer.removeMoney(Config.Zones.Shoes.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Shoes.Price)))
		
	elseif accessory == "Pants" then
		xPlayer.removeMoney(Config.Zones.Pants.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Pants.Price)))
		
	elseif accessory == "Arms" then
		xPlayer.removeMoney(Config.Zones.Arms.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Arms.Price)))
		
	elseif accessory == "Bags" then
		xPlayer.removeMoney(Config.Zones.Bags.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Bags.Price)))
		
	elseif accessory == "Bracelets" then
		xPlayer.removeMoney(Config.Zones.Bracelets.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Bracelets.Price)))
		
	elseif accessory == "Watches" then
		xPlayer.removeMoney(Config.Zones.Watches.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Watches.Price)))
		
	elseif accessory == "Chain" then
		xPlayer.removeMoney(Config.Zones.Chain.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Chain.Price)))
		
	elseif accessory == "Hair" then
		xPlayer.removeMoney(Config.Zones.Hair.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Zones.Hair.Price)))
		
	end
	

	
end)

RegisterServerEvent('esx_accessories:save')
AddEventHandler('esx_accessories:save', function(skin, accessory)
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
			
		elseif accessory == "Hair" then
			xPlayer.addInventoryItem('hair', 1, {accessories = itemSkin[item1], accessories2 = itemSkin[item2], description = 'This is a Bracelets '.. itemSkin[item1]..' '..itemSkin[item2]  })
			
		end
		
	end)
end)




ESX.RegisterServerCallback('esx_accessories:checkMoney', function(source, cb, accessory)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if accessory == "Ears" then
		cb(xPlayer.getMoney() >= Config.Zones.Ears.Price)
	elseif accessory == "Mask" then
		cb(xPlayer.getMoney() >= Config.Zones.Mask.Price)
	elseif accessory == "Helmet" then
		cb(xPlayer.getMoney() >= Config.Zones.Helmet.Price)
	elseif accessory == "Glasses" then
		cb(xPlayer.getMoney() >= Config.Zones.Glasses.Price)
	elseif accessory == "Torso" then
		cb(xPlayer.getMoney() >= Config.Zones.Torso.Price)
	elseif accessory == "Tshirt" then
		cb(xPlayer.getMoney() >= Config.Zones.Tshirt.Price)
	elseif accessory == "Arms" then
		cb(xPlayer.getMoney() >= Config.Zones.Arms.Price)
	elseif accessory == "Shoes" then
		cb(xPlayer.getMoney() >= Config.Zones.Shoes.Price)
	elseif accessory == "Pants" then
		cb(xPlayer.getMoney() >= Config.Zones.Pants.Price)
	elseif accessory == "Bags" then
		cb(xPlayer.getMoney() >= Config.Zones.Bags.Price)
	elseif accessory == "Watches" then
		cb(xPlayer.getMoney() >= Config.Zones.Watches.Price)
	elseif accessory == "Chain" then
		cb(xPlayer.getMoney() >= Config.Zones.Chain.Price)
	elseif accessory == "Bracelets" then
		cb(xPlayer.getMoney() >= Config.Zones.Bracelets.Price)
	elseif accessory == "Hair" then
		cb(xPlayer.getMoney() >= Config.Zones.Hair.Price)
	end
	
end)
