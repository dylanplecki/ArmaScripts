#include "defines.hpp"

private ["_unit", "_nearAmmoPoints", "_nearestAmmoPoint"];

_unit = _this select 0;

while {true} do {
	
	waituntil { // Idk about the performance here, but oh well :)
		((count (weapons _unit) > 0) OR (count (magazines _unit) > 0));
	};
	
	_nearAmmoPoints = nearestObjects [_unit, ["ReammoBox", "LandVehicle", "Air"], 10];
	
	if (count _nearAmmoPoints > 0) then {
		_nearestAmmoPoint = _nearAmmoPoints select 0;
	} else {
		_nearestAmmoPoint = "WeaponHolder" createVehicle (getpos _unit);
		_nearestAmmoPoint setposATL [(getpos _unit select 0), (getpos _unit select 1), 0];
	};
	
	[_unit, _nearestAmmoPoint, (weapons _unit), (magazines _unit), false] call FUNC(removeWeaponsAndMagsToCache);
};