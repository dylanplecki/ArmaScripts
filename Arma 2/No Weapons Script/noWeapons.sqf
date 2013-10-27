// scripts\noWeapons.sqf
//		Used to disable carrying any weapons/magazines for all Civilian
//
// nul = [] execVM "scripts\noWeapons.sqf"; // In your init.sqf
//
//	Set CRACK_var_noWeaponLoop to FALSE to allow weapons again
//
//-------------------------------------------------------------

if (!isdedicated) then {
	
	waituntil {!isnull player};
	
	//---------------------------------------------------------
	
	// Parameters
	if (isNil "CRACK_var_allowedWeaponsOrMags") then {CRACK_var_allowedWeaponsOrMags = [];}; // Strings of weapons/mags that player is allowed to have, ie. ["m16", "30Rnd_556x45_Stanag"]
	if (isNil "CRACK_var_noWeaponSides") then {CRACK_var_noWeaponSides = [CIVILIAN];}; // Sides that this script will activate for
	if (isNil "CRACK_var_noWeaponSleepTime") then {CRACK_var_noWeaponSleepTime = 1;}; // Time that the loop will sleep for - Higher times, higher performance, but more chance for exploiting
	
	//---------------------------------------------------------
	
	if ((side player) in CRACK_var_noWeaponSides) then {
	
		if (isnil "CRACK_fnc_removeWeaponsAndMagsToCache") then {
			CRACK_fnc_removeWeaponsAndMagsToCache = {
				private ["_target", "_cache", "_weapons", "_mags", "_ace"];
				
				_target = _this select 0;
				_cache = _this select 1;
				_weapons = _this select 2;
				_mags = _this select 3;
				_ace = _this select 4;
				
				if (!_ace) then {
					{ // foreach
						_target removeWeapon _x;
						_cache addWeaponCargoGlobal [_x, 1];
					} forEach _weapons;
					{ // foreach
						_target removeMagazine _x;
						_cache addMagazineCargoGlobal [_x, 1];
					} forEach _mags;
				};
				if (_ace) then {
					{_cache addMagazineCargoGlobal [_x select 0, _x select 1]} forEach _mags;
					{_cache addWeaponCargoGlobal _x} forEach _weapons;
				};
			};
		};
		
		if (isnil "CRACK_fnc_checkWeaponsMags") then {
			CRACK_fnc_checkWeaponsMags = {
				private ["_type", "_returnArray", "_unit", "_item", "_notReturned", "_countLastIndex", "_returnArrayScratch"];
				
				_unit = _this select 0;
				_type = _this select 1;
				_notReturned = if ((count _this) > 2) then {_this select 2} else {[]};
				
				_returnArray = [];
				
				switch (_type) do {
					case 0: { // WEAPONS
						_returnArray = weapons _unit;
					};
					case 1: { // MAGAZINES
						_returnArray = magazines _unit;
					};
				};
				
				if (((count _returnArray) > 0) AND ((count _notReturned) > 0)) then {	
					_returnArrayScratch = _returnArray;
					for "_i" from 0 to ((count _returnArray) - 1) do {
						_item = _returnArray select _i;
						if (_item in _notReturned) then {
							_returnArrayScratch = _returnArrayScratch - [(_returnArray select _i)];
						};
					};
					_returnArray = _returnArrayScratch;
				};
				
				_returnArray
			};
		};
		
		if (isnil "CRACK_fnc_disableWeapons") then {
			CRACK_fnc_disableWeapons = {
				private ["_unit", "_nearAmmoPoints", "_nearestAmmoPoint", "_weapons", "_mags", "_ruckWeapons", "_ruckMags", "_hasRuck", "_WOB"];
				
				_unit = _this select 0;
				
				while {CRACK_var_noWeaponLoop} do {
					
					waituntil { // Idk about the performance here, but oh well :)
						sleep CRACK_var_noWeaponSleepTime;
						_weapons = [_unit, 0, CRACK_var_allowedWeaponsOrMags] call CRACK_fnc_checkWeaponsMags;
						_mags = [_unit, 1, CRACK_var_allowedWeaponsOrMags] call CRACK_fnc_checkWeaponsMags;
						_hasRuck = [_unit] call ACE_fnc_HasRuck;
						_WOB = [_unit] call ACE_fnc_WeaponOnBackName;
						((count _weapons > 0) OR (count _mags > 0) OR (_hasRuck));
					};
					
					_nearAmmoPoints = nearestObjects [_unit, ["ReammoBox", "LandVehicle", "Air"], 10];
					
					if (count _nearAmmoPoints > 0) then {
						_nearestAmmoPoint = _nearAmmoPoints select 0;
					} else {
						_nearestAmmoPoint = "WeaponHolder" createVehicle (getpos _unit);
						_nearestAmmoPoint setposATL [(getpos _unit select 0), (getpos _unit select 1), 0];
					};
					
					if (_hasRuck) then {
						_ruckWeapons = [_unit] call ACE_fnc_RuckWeaponsList;
						_ruckMags = [_unit] call ACE_fnc_RuckMagazinesList;
						[_unit, "BTH"] call ACE_fnc_RemoveGear;
						
						if ((count _ruckWeapons > 0) OR (count _ruckMags > 0)) then {
							[_unit, _nearestAmmoPoint, _ruckWeapons, _ruckMags, true] call CRACK_fnc_removeWeaponsAndMagsToCache;
						};
					};
					
					if (_WOB != "") then {
						[_unit, "WOB"] call ACE_fnc_RemoveGear;
						[_unit, _nearestAmmoPoint, [_WOB], [], true] call CRACK_fnc_removeWeaponsAndMagsToCache;
					};
					
					if ((count _weapons > 0) OR (count _mags > 0)) then {
						[_unit, _nearestAmmoPoint, _weapons, _mags, false] call CRACK_fnc_removeWeaponsAndMagsToCache;
					};
				};
			};
		};
		
		CRACK_var_noWeaponLoop = true;
		
		[player] call CRACK_fnc_disableWeapons;
		
	}; // END IS SIDEPLAYER CIVILIAN
}; // END !ISDEDICATED