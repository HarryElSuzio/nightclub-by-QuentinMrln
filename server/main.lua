ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local flyers = 1
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'nightclub', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'nightclub', _U('nightclub_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'nightclub', 'Nightclub', 'society_nightclub', 'society_nightclub', 'society_nightclub', {type = 'private'})

local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "AbsintheFarm" then
			local itemQuantity = xPlayer.getInventoryItem('papier').count
			if itemQuantity >= 25 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(1800, function()
					xPlayer.addInventoryItem('papier', 1)
					Harvest(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_nightclub:startHarvest')
AddEventHandler('esx_nightclub:startHarvest', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, '~g~Récupération de papier en cours')
		Harvest(_source,zone)
	end
end)


RegisterServerEvent('esx_nightclub:stopHarvest')
AddEventHandler('esx_nightclub:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récolter')
		PlayersHarvesting[_source]=true
	end
end)


local function Transform(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
			if zone == "TraitementMdlm" then
			local itemQuantitya = xPlayer.getInventoryItem('papier').count
			local itemQuantityb = xPlayer.getInventoryItem('flyers').count
			if itemQuantitya <= 0 or itemQuantityb >= 25 then
				TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de place sur vous')
				return
			else
				SetTimeout(1800, function()
					xPlayer.removeInventoryItem('papier', 1)
					xPlayer.addInventoryItem('flyers', 1)
		  
					Transform(source, zone)	  
				end)
			end
		end
	end	
end

RegisterServerEvent('esx_nightclub:startTransform')
AddEventHandler('esx_nightclub:startTransform', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform(_source,zone)
	end
end)

RegisterServerEvent('esx_nightclub:stopTransform')
AddEventHandler('esx_nightclub:stopTransform', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer')
		PlayersTransforming[_source]=true
		
	end
end)

local function Sell(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
		if zone == 'SellFarm' then
			if xPlayer.getInventoryItem('flyers').count <= 0 then
				flyers = 0
			else
				flyers = 1
			end
		
			if flyers == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('flyers').count <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				flyers = 0
				return
			else
				if (flyers == 1) then
					SetTimeout(1100, function()
						local xPlayer = ESX.GetPlayerFromId(source)
						local total = Config.PrixFlyers
						xPlayer.removeInventoryItem('flyers', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then

							local societyMoney = math.floor(total / 100 * 100)
					
							societyAccount.addMoney(societyMoney)
					
							--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned', societyMoney))

						else
							xPlayer.addMoney(total)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned', total))
						end
						Sell(source,zone)
					end)
				end
			end
		end
	end
end

RegisterServerEvent('esx_nightclub:startSell')
AddEventHandler('esx_nightclub:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)
	end

end)

RegisterServerEvent('esx_nightclub:stopSell')
AddEventHandler('esx_nightclub:stopSell', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('esx_nightclub:buyItem')
AddEventHandler('esx_nightclub:buyItem', function(itemName, price, itemLabel)

    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local limit = xPlayer.getInventoryItem(itemName).limit
    local qtty = xPlayer.getInventoryItem(itemName).count
	local societyAccount = nil
	local societyAccount2 = nil

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
        societyAccount = account
      end)
	
	  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_maire', function(account)
        societyAccount2 = account
      end)

	  price2 = price * 10 / 100

    if societyAccount ~= nil and societyAccount.money >= price then
        if qtty < limit then
			societyAccount.removeMoney(price)
			societyAccount2.addMoney(price2)
            xPlayer.addInventoryItem(itemName, 1)
            TriggerClientEvent('esx:showNotification', _source, _U('bought') .. itemLabel)
        else
            TriggerClientEvent('esx:showNotification', _source, _U('max_item'))
        end
    else
        TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
    end

end)

RegisterServerEvent('esx_nightclub:getStockItem')
AddEventHandler('esx_nightclub:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_nightclub', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_nightclub:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_nightclub', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_nightclub:putStockItems')
AddEventHandler('esx_nightclub:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_nightclub', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('esx_nightclub:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)

--[[===========================================

        UTILISATION ET EFFET BOISSONS

=============================================]]

ESX.RegisterUsableItem('adiosmotherfucker', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('adiosmotherfucker', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 780000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('adiosmotherfucker'))

end)

ESX.RegisterUsableItem('bacardicocktail', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('bacardicocktail', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 450000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('bacardicocktail'))

end)

ESX.RegisterUsableItem('cajuamigo', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('cajuamigo', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 440000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('cajuamigo'))

end)

ESX.RegisterUsableItem('douxbaisers', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('douxbaisers', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 780000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('douxbaisers'))

end)

ESX.RegisterUsableItem('episcopale', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('episcopale', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 550000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('episcopale'))

end)

ESX.RegisterUsableItem('flamingdrpepper', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('flamingdrpepper', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 460000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('flamingdrpepper'))

end)

ESX.RegisterUsableItem('grasshopper', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('grasshopper', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 620000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('grasshopper'))

end)

ESX.RegisterUsableItem('harveywallbanger', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('harveywallbanger', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 400000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('harveywallbanger'))

end)

ESX.RegisterUsableItem('irishcoffee', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('irishcoffee', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 490000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('irishcoffee'))

end)

ESX.RegisterUsableItem('jacqueline', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('jacqueline', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 800000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('jacqueline'))

end)

ESX.RegisterUsableItem('kirroyal', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('kirroyal', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 500000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('kirroyal'))

end)

ESX.RegisterUsableItem('longislandicedtea', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('longislandicedtea', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 560000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('longislandicedtea'))

end)

ESX.RegisterUsableItem('manhattan', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('manhattan', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 520000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('manhattan'))

end)

ESX.RegisterUsableItem('negroni', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('negroni', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 710000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('negroni'))

end)

ESX.RegisterUsableItem('oldfashioned', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('oldfashioned', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 600000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('oldfashioned'))

end)

ESX.RegisterUsableItem('pinklady', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('pinklady', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 530000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('pinklady'))

end)

ESX.RegisterUsableItem('quentao', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('quentao', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 540000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('quentao'))

end)

ESX.RegisterUsableItem('rabodegalo', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('rabodegalo', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 670000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('rabodegalo'))

end)

ESX.RegisterUsableItem('sangria', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('sangria', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 560000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('sangria'))

end)

ESX.RegisterUsableItem('tequilasunrise', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('tequilasunrise', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 700000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('tequilasunrise'))

end)

ESX.RegisterUsableItem('vesper', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('vesper', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 620000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('vesper'))

end)

ESX.RegisterUsableItem('whiskyhighball', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('whiskyhighball', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 490000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('whiskyhighball'))

end)

ESX.RegisterUsableItem('zombie', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('zombie', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 1000000)
	TriggerClientEvent('esx_status:add', source, 'pee', -50000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('zombie'))

end)