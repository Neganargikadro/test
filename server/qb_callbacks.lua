function setupQBCallbacks()
    -- [[ Jobs stuff ]]
    QBCore.Functions.CreateCallback("esx_job_creator:getJobsData", function(source, cb, data)
        if(isAllowed(source)) then
            retrieveJobsData(cb)
        end
    end)

    QBCore.Functions.CreateCallback("esx_job_creator:createNewJob", function(source, cb, jobName, jobLabel)
        if(isAllowed(source)) then
            createJob(jobName, jobLabel, cb)
        end
    end)

    QBCore.Functions.CreateCallback("esx_job_creator:deleteJob", function(source, cb, jobName)
        if(isAllowed(source)) then
            deleteJob(jobName, cb)
        end
    end)

    QBCore.Functions.CreateCallback("esx_job_creator:getJobInfo", function(source, cb)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        cb(xPlayer.PlayerData.job.name, xPlayer.PlayerData.job.label)
    end)

    -- [[ Ranks stuff ]]
    QBCore.Functions.CreateCallback("esx_job_creator:newRank", function(source, cb, jobName)
        if(isAllowed(source)) then
            newRank(jobName, cb)
        end
    end)    

    QBCore.Functions.CreateCallback("esx_job_creator:checkAllowedActions", function(source, cb)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        
        while not xPlayer do
            Citizen.Wait(2000)
            xPlayer = QBCore.Functions.GetPlayer(source)
        end

        local jobName = xPlayer.PlayerData.job.name

        checkAllowedActions(jobName, cb)
    end)
    -- [[ Markers stuff ]]

    -- Return all player's job markers
    QBCore.Functions.CreateCallback("esx_job_creator:getMarkers", function(source, cb)
        local xPlayer = QBCore.Functions.GetPlayer(source)

        while xPlayer == nil do
            xPlayer = QBCore.Functions.GetPlayer(source)
            Citizen.Wait(500)
        end

        local jobName = xPlayer.PlayerData.job.name
        local jobGrade = xPlayer.PlayerData.job.grade.level

        getMarkersMinGrade(jobName, jobGrade, cb)
    end)

    QBCore.Functions.CreateCallback("esx_job_creator:createMarker", function(source, cb, jobName, label, type, coords, minGrade)
        if(isAllowed(source)) then
            createNewMarker(jobName, label, type, coords, minGrade, cb)
        end
    end)

    -- Return all markers related to a job
    QBCore.Functions.CreateCallback("esx_job_creator:getMarkersFromJobName", function(source, cb, jobName)
        if(isAllowed(source)) then
            local jobMarkers = getMarkersFromJobName(jobName)

            cb(jobMarkers)
        end
    end)

    QBCore.Functions.CreateCallback("esx_job_creator:deleteMarker", function(source, cb, markerId)
        if(isAllowed(source)) then
            deleteMarker(markerId, cb)
        end
    end)

    QBCore.Functions.CreateCallback("esx_job_creator:updateMarker", updateMarker)

    QBCore.Functions.CreateCallback("esx_job_creator:updateMarkerData", function(source, cb, markerId, data)
        if(isAllowed(source)) then
            updateMarkerData(markerId, data, cb)
        end
    end)

    -- [[ Stash stuff ]]
    QBCore.Functions.CreateCallback("esx_job_creator:retrieveStash", function(source, cb, markerId)
        if(not canUseMarkerWithLog(source, markerId)) then return end

        local xPlayer = QBCore.Functions.GetPlayer(source)

        local stashItems = fullMarkerData[markerId].data
        local elements = {}

        for itemName, itemQuantity in pairs(stashItems) do
            local item = QBCore.Shared.Items[itemName]
            local label = format("%s - x%d", item.label, itemQuantity)
            table.insert(elements, {label = label, value = itemName, quantity = itemQuantity})
        end

        cb(elements)
    end)

    QBCore.Functions.CreateCallback("esx_job_creator:getPlayerInventory", function(source, cb)
        local xPlayer = QBCore.Functions.GetPlayer(source)

        local elements = {}

        for _, item in pairs(xPlayer.PlayerData.items) do
            if(item.amount > 0) then
                local label = format("%s - x%d", item.label, item.amount)
                table.insert(elements, {label = label, value = item.name, quantity = item.amount})
            end
        end

        cb(elements)
    end)

    QBCore.Functions.CreateCallback("esx_job_creator:stash:depositItem", depositItem)

    QBCore.Functions.CreateCallback("esx_job_creator:stash:takeItem", takeItem)
    
    QBCore.Functions.CreateCallback("esx_job_creator:deleteStashInventory", function(source, cb, markerId)
        if(isAllowed(source)) then
            deleteStashInventory(markerId, cb)
        else
            cb(false)
        end
    end)

    -- [[ Armory Stuff ]]
    QBCore.Functions.CreateCallback('esx_job_creator:getPlayerWeapons', getPlayerWeapons)

    QBCore.Functions.CreateCallback('esx_job_creator:retrieveArmoryWeapons', retrieveArmoryWeapons)

    QBCore.Functions.CreateCallback('esx_job_creator:depositWeaponInArmory', depositWeaponInArmory)

    QBCore.Functions.CreateCallback('esx_job_creator:takeWeaponFromArmory', takeWeaponFromArmory)

    QBCore.Functions.CreateCallback('esx_job_creator:deleteArmoryInventory', deleteArmoryInventory)

    -- [[ Garage stuff ]]
    QBCore.Functions.CreateCallback("esx_job_creator:retrieveVehicles", retrieveVehicles)

    -- [[ Boss stuff ]]
    QBCore.Functions.CreateCallback("esx_job_creator:getBossData", getBossData)
    QBCore.Functions.CreateCallback('esx_job_creator:boss:getJobGrades', getJobGradesSalaries)
    QBCore.Functions.CreateCallback('esx_job_creator:boss:getEmployeesList', getEmployeesList)
    QBCore.Functions.CreateCallback('esx_job_creator:boss:getClosePlayersNames', getClosePlayersNames)
    
    -- [[ Wardrobe stuff ]]
    QBCore.Functions.CreateCallback('esx_job_creator:getPlayerWardrobe', getPlayerWardrobe)

    QBCore.Functions.CreateCallback('esx_job_creator:getPlayerOutfit', getPlayerOutfit)
    
    -- [[ Shop stuff ]]
    QBCore.Functions.CreateCallback('esx_job_creator:getShopData', getShopData)

    -- [[ Garage Buyable stuff ]]
    QBCore.Functions.CreateCallback('esx_job_creator:getGarageBuyableData', getGarageBuyableData)
    QBCore.Functions.CreateCallback('esx_job_creator:getGarageOwnedVehicles', getGarageOwnedVehicles)
    QBCore.Functions.CreateCallback('esx_job_creator:permanent_garage:updateVehicleProps', updateVehicleProps)

    -- [[ Garage owned stuff ]]
    QBCore.Functions.CreateCallback("esx_job_creator:garage_owned:getVehicles", getPlayerOwnedVehicles)
    QBCore.Functions.CreateCallback("esx_job_creator:garage_owned:updateVehicleProps", garageOwnedUpdateVehicleProps)

    -- [[ Crafting table stuff ]]
    QBCore.Functions.CreateCallback('esx_job_creator:getCraftingTableData', getCraftingTableData)

    -- [[ Job outfit stuff ]]
    QBCore.Functions.CreateCallback('esx_job_creator:getJobOutfits', getJobOutfits)

    --[[ Ranks Stuff ]] 
    QBCore.Functions.CreateCallback("esx_job_creator:createRank", createRank)
    QBCore.Functions.CreateCallback("esx_job_creator:updateRank", updateRank)
    QBCore.Functions.CreateCallback("esx_job_creator:deleteRank", deleteRank)
    QBCore.Functions.CreateCallback("esx_job_creator:retrieveJobRanks", function(source, cb, jobName)
        if(jobName) then
            retrieveJobRanks(jobName, cb)
        else
            cb(false)
        end
    end)

    --[[ Jobs Stuff ]] 
    QBCore.Functions.CreateCallback("esx_job_creator:updateJob", function(source, cb, oldJobName, newJobName, newLabel, whitelisted, actions)
        if(isAllowed(source)) then
            updateJob(oldJobName, newJobName, newLabel, whitelisted, actions, cb)
        end
    end)

    -- [[ Actions Menu ]]
    QBCore.Functions.CreateCallback("esx_job_creator:getTargetPlayerInventory", getTargetPlayerInventory)

    QBCore.Functions.CreateCallback("esx_job_creator:stealFromPlayer", stealFromPlayer)

    QBCore.Functions.CreateCallback('esx_job_creator:canLockpickVehicle', canLockpickVehicle)
    QBCore.Functions.CreateCallback('esx_job_creator:canRepairVehicle', canRepairVehicle)
    QBCore.Functions.CreateCallback('esx_job_creator:canWashVehicle', canWashVehicle)

    -- [[ Teleport ]]
    QBCore.Functions.CreateCallback("esx_job_creator:getTeleportCoords", getTeleportCoords)
    QBCore.Functions.CreateCallback("esx_job_creator:getMarkerLabel", getMarkerLabel)

    -- [[ Safe ]]
    QBCore.Functions.CreateCallback('esx_job_creator:getPlayerAccounts', getPlayerSafeAccounts)
    QBCore.Functions.CreateCallback('esx_job_creator:depositIntoSafe', depositIntoSafe)
    QBCore.Functions.CreateCallback('esx_job_creator:withdrawFromSafe', withdrawFromSafe)
    QBCore.Functions.CreateCallback('esx_job_creator:retrieveReadableSafeData', retrieveReadableSafeData)

    -- [[ Market ]]
    QBCore.Functions.CreateCallback('esx_job_creator:getMarketItems', getMarketItems)

    -- [[ Weapon Upgrader ]]
    QBCore.Functions.CreateCallback('esx_job_creator:openComponents', openComponents)
    QBCore.Functions.CreateCallback('esx_job_creator:openTints', openTints)
    QBCore.Functions.CreateCallback('esx_job_creator:getOwnedWeapons', getOwnedWeapons)

    -- [[ Job Shop ]]
    QBCore.Functions.CreateCallback('esx_job_creator:getSellableStuff', getSellableStuff)
    
    QBCore.Functions.CreateCallback('esx_job_creator:canSellInThisShop', function(source, cb, markerId)
        cb(canPlayerSellInShop(source, markerId))
    end)

    QBCore.Functions.CreateCallback('esx_job_creator:getJobShop', getJobShop)
end
