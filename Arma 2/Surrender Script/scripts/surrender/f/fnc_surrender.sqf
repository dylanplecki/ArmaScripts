#include "defines.hpp"

private ["_result", "_nearPlayers", "_weapons", "_cache", "_ruckWeapons", "_ruckMags", "_WOB"];

// Hint the surrounding players that the target is surrendering.
_nearPlayers = [player, GVAR(surrenderHintRadius)] call FUNC(getNearEnemies);
["CRACK_ceh_hintSurrender", [_nearPlayers, player, "%1 is surrendering!!!"]] call CBA_fnc_globalEvent;

// Stuff to do to surrender
player playMove GVAR(surrenderAnimation);
player setCaptive true;
GVAR(scriptHandle_noWeaponScript) = [player] spawn FUNC(disableWeapons);

// Drop weapons/magazines on ground
_weapons = weapons player;
_mags = magazines player;
_cache = "WeaponHolder" createVehicle (getpos player);
_cache setposATL [(getpos player select 0), (getpos player select 1), 0]; // (getpos player)

[player, _cache, _weapons, _mags, false] call FUNC(removeWeaponsAndMagsToCache);

// ACE Weapon Removal
if ([player] call ACE_fnc_HasRuck) then {
	
	_ruckWeapons = [player] call ACE_fnc_RuckWeaponsList;
	_ruckMags = [player] call ACE_fnc_RuckMagazinesList;
	
	[player, _cache, _ruckWeapons, _ruckMags, true] call FUNC(removeWeaponsAndMagsToCache);
	
	[player, "BTH"] call ACE_fnc_RemoveGear;
	
};

_WOB = [player] call ACE_fnc_WeaponOnBackName;

if (_WOB != "") then {
	
	[player, "WOB"] call ACE_fnc_RemoveGear;
	_cache addWeaponCargoGlobal [_WOB, 1];
	
};

// So other units can capture the player
_result = player getvariable QUOTE(GVAR(surrenderedStatus));
_result set [0, true];
player setvariable [QUOTE(GVAR(surrenderedStatus)), _result, true];