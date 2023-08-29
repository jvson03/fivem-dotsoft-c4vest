---@diagnostic disable: undefined-global, redefined-local, lowercase-global
-- Initialise QBCore

QBCore = exports['qb-core']:GetCoreObject()

-- Equipping Vest Event

RegisterNetEvent('dotsoft-c4vest:equip')
AddEventHandler('dotsoft-c4vest:equip', function(ped)
    local ped = PlayerPedId()
    SetPedComponentVariation(ped, 9, 15, 0, 0)
    QBCore.Functions.Notify('C4 vest has been equipped.', 'success', 7500)
end)

-- Exploding Vest Event

RegisterNetEvent('dotsoft-c4vest:explode')
AddEventHandler('dotsoft-c4vest:explode', function(ped)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    RequestWeaponAsset(GetHashKey("WEAPON_AIRSTRIKE_ROCKET")) 
    while not HasWeaponAssetLoaded(GetHashKey("WEAPON_AIRSTRIKE_ROCKET")) do
        Wait(0)
    end
    RequestWeaponAsset(GetHashKey("WEAPON_STICKYBOMB")) 
    while not HasWeaponAssetLoaded(GetHashKey("WEAPON_STICKYBOMB")) do
        Wait(0)
    end

    if IsPedInAnyVehicle(ped,false) then
        local vehicle = GetVehiclePedIsIn(ped,false)
        ExplodeVehicleInCutscene(vehicle,true)
    else
        o = 0
        while o < 1 do
        ShootSingleBulletBetweenCoords(coords.x, coords.y, coords.z+0.1, coords.x, coords.y, coords.z, 1000, true,GetHashKey("WEAPON_STICKYBOMB"), ped, true, false, 0)
        if not IsPedFalling(ped) then
            ShootSingleBulletBetweenCoords(coords.x, coords.y, coords.z, coords.x, coords.y, coords.z, 1000, true,GetHashKey("WEAPON_AIRSTRIKE_ROCKET"), ped, true, false, 0)
        end
        if not IsPedInParachuteFreeFall(ped) then
            ShootSingleBulletBetweenCoords(coords.x, coords.y, coords.z, coords.x, coords.y, coords.z, 1000, true,GetHashKey("WEAPON_AIRSTRIKE_ROCKET"), ped, true, false, 0)
        end
        o = o + 0.1
        Citizen.Wait(1)
        end
    end
    SetPedComponentVariation(ped, 9, 0, 0, 0)
end)