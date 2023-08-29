-- Initialise QBCore

QBCore = exports['qb-core']:GetCoreObject()
local IsEquipped = false

-- Vest Item

QBCore.Functions.AddItem('explosive_vest', {
    name = 'explosive_vest',
    label = 'Explosive Vest',
    weight = 1000,
    type = 'item',
    image = 'explosive_vest.png',
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = 'Bulletproof vest equipped with active C4 and a trigger.'
})

QBCore.Functions.AddItem('explosive_vest_remote', {
    name = 'explosive_vest_remote',
    label = 'Explosive Vest Remote',
    weight = 200,
    type = 'item',
    image = 'explosive_vest_remote.png',
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = 'Remote Trigger for explosive vest..'
})

-- Item Functionalities

QBCore.Functions.CreateUseableItem('explosive_vest', function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    IsEquipped = true
    TriggerClientEvent("dotsoft-c4vest:equip", src)
    Player.Functions.RemoveItem("explosive_vest", 1)
    Player.Functions.AddItem("explosive_vest_remote", 1, false)
end)

QBCore.Functions.CreateUseableItem('explosive_vest_remote', function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if IsEquipped then
        TriggerClientEvent("dotsoft-c4vest:explode", src)
        IsEquipped = false
        Player.Functions.RemoveItem("explosive_vest_remote", 1)
    else
        QBCore.Functions.Notify(src, 'You are not wearing an explosive vest.', 'error')
    end
end)