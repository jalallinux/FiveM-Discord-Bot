--------------------------------------------------------------------------------
------------------------------------------------- Completed by JalalLinuX ------
--------------------------------------------------------------------------------

Citizen.CreateThread(function()
    local DeathReason, Killer, DeathCauseHash, Weapon

    while true do
        Citizen.Wait(0)
        if IsEntityDead(PlayerPedId()) then
            Citizen.Wait(500)
            local PedKiller = nil
            try(function()
                PedKiller = GetPedSourceOfDeath(PlayerPedId())
            end, function() PedKiller = GetPlayerPed(-1) end)
            DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
            Weapon = WeaponNames[tostring(DeathCauseHash)]

            try(function()
                if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
                    Killer = NetworkGetPlayerIndexFromPed(PedKiller)
                elseif IsEntityAVehicle(PedKiller) and
                    IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and
                    IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
                    Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
                end
            end, function() Killer = nil end)

            if (Killer == PlayerId()) then
                DeathReason = 'Committed Suicide'
            elseif (Killer == nil) then
                DeathReason = OtherReason(DeathCauseHash)
            else
                if IsMelee(DeathCauseHash) then
                    DeathReason = 'Murdered'
                elseif IsTorch(DeathCauseHash) then
                    DeathReason = 'Torched'
                elseif IsKnife(DeathCauseHash) then
                    DeathReason = 'Knifed'
                elseif IsPistol(DeathCauseHash) then
                    DeathReason = 'Pistoled'
                elseif IsSub(DeathCauseHash) then
                    DeathReason = 'Riddled'
                elseif IsRifle(DeathCauseHash) then
                    DeathReason = 'Rifled'
                elseif IsLight(DeathCauseHash) then
                    DeathReason = 'Machine Gunned'
                elseif IsShotgun(DeathCauseHash) then
                    DeathReason = 'Pulverized'
                elseif IsSniper(DeathCauseHash) then
                    DeathReason = 'Sniped'
                elseif IsHeavy(DeathCauseHash) then
                    DeathReason = 'Obliterated'
                elseif IsMinigun(DeathCauseHash) then
                    DeathReason = 'Shredded'
                elseif IsBomb(DeathCauseHash) then
                    DeathReason = 'Bombed'
                elseif IsVeh(DeathCauseHash) then
                    DeathReason = 'Mowed Over'
                elseif IsVK(DeathCauseHash) then
                    DeathReason = 'Flattened'
                else
                    DeathReason = 'Killed'
                end
            end
            TriggerServerEvent('JLDiscord:PlayerDied', DeathReason, DeathCauseHash, Killer, Weapon)
            Killer = nil
            DeathReason = nil
            DeathCauseHash = nil
            Weapon = nil
        end
        while IsEntityDead(PlayerPedId()) do Citizen.Wait(0) end
    end
end)

function OtherReason(ReasonHash)

	local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
	if checkArray(Melee, ReasonHash) then return 'Melee' end

	local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060 }
	if checkArray(Knife, ReasonHash) then return 'Knife' end

	local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
	if checkArray(Bullet, ReasonHash) then return 'Bullet' end

	local Animal = { -100946242, 148160082 }
	if checkArray(Animal, ReasonHash) then return 'Animal' end

	local FallDamage = { -842959696 }
	if checkArray(FallDamage, ReasonHash) then return 'Fall Damage' end

	local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
	if checkArray(Explosion, ReasonHash) then return 'Explosion' end

	local Gas = { -1600701090 }
	if checkArray(Gas, ReasonHash) then return 'Gas' end

	local Burn = { 615608432, 883325847, -544306709 }
	if checkArray(Burn, ReasonHash) then return 'Burn' end

	local Drown = { -10959621, 1936677264 }
	if checkArray(Drown, ReasonHash) then return 'Drown' end

	local Car = { 133987706, -1553120962 }
	if checkArray(Car, ReasonHash) then return 'Car' end

	return 'Unknown'
end

function checkArray(array, val)
    for name, value in ipairs(array) do if value == val then return true end end
    return false
end


function IsMelee(Weapon)
    local Weapons = {
        'WEAPON_UNARMED', 'WEAPON_CROWBAR', 'WEAPON_BAT', 'WEAPON_GOLFCLUB',
        'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK'
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsTorch(Weapon)
    local Weapons = {'WEAPON_MOLOTOV'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsKnife(Weapon)
    local Weapons = {
        'WEAPON_DAGGER', 'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_HATCHET',
        'WEAPON_BOTTLE'
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsPistol(Weapon)
    local Weapons = {
        'WEAPON_SNSPISTOL', 'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL',
        'WEAPON_PISTOL', 'WEAPON_APPISTOL', 'WEAPON_COMBATPISTOL'
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsSub(Weapon)
    local Weapons = {'WEAPON_MICROSMG', 'WEAPON_SMG'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsRifle(Weapon)
    local Weapons = {
        'WEAPON_CARBINERIFLE', 'WEAPON_MUSKET', 'WEAPON_ADVANCEDRIFLE',
        'WEAPON_ASSAULTRIFLE', 'WEAPON_SPECIALCARBINE', 'WEAPON_COMPACTRIFLE',
        'WEAPON_BULLPUPRIFLE'
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsLight(Weapon)
    local Weapons = {'WEAPON_MG', 'WEAPON_COMBATMG'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsShotgun(Weapon)
    local Weapons = {
        'WEAPON_BULLPUPSHOTGUN', 'WEAPON_ASSAULTSHOTGUN', 'WEAPON_DBSHOTGUN',
        'WEAPON_PUMPSHOTGUN', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN'
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsSniper(Weapon)
    local Weapons = {
        'WEAPON_MARKSMANRIFLE', 'WEAPON_SNIPERRIFLE', 'WEAPON_HEAVYSNIPER',
        'WEAPON_ASSAULTSNIPER', 'WEAPON_REMOTESNIPER'
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsHeavy(Weapon)
    local Weapons = {
        'WEAPON_GRENADELAUNCHER', 'WEAPON_RPG', 'WEAPON_FLAREGUN',
        'WEAPON_HOMINGLAUNCHER', 'WEAPON_FIREWORK', 'VEHICLE_WEAPON_TANK'
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsMinigun(Weapon)
    local Weapons = {'WEAPON_MINIGUN'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsBomb(Weapon)
    local Weapons = {
        'WEAPON_GRENADE', 'WEAPON_PROXMINE', 'WEAPON_EXPLOSION',
        'WEAPON_STICKYBOMB'
    }
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsVeh(Weapon)
    local Weapons = {'VEHICLE_WEAPON_ROTORS'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function IsVK(Weapon)
	local Weapons = {'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == Weapon then return true end
    end
    return false
end

function try(f, catch_f)
    local status, exception = pcall(f)
    if not status then catch_f(exception) end
end
