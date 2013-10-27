#include "script_macros.hpp"

_man = _this select 0;

if (count (weapons _man) > 0) then {
	
	_type = ((weapons _man) select 0);
	
	// check for multiple muzzles (eg: GL)
	_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");

	if (count _muzzles > 1) then
	{
		_man selectWeapon (_muzzles select 0);
	}
	else
	{
		_man selectWeapon _type;
	};
} else {
	
	if !(player hasweapon "ace_safe") then {player addweapon "ace_safe"};
	player selectweapon "ace_safe";
	
};