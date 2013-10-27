#include "defines.hpp"

private ["_result", "_target"];

_target = _this select 0;

if (_target == player) then {
	// Reversing all the variables
	_result = _target getvariable QUOTE(GVAR(surrenderedStatus));
	for "_i" from 0 to (count _result - 1) do {
		_result set [_i, false];
	};
	_target setvariable [QUOTE(GVAR(surrenderedStatus)), _result, true];
	_target setCaptive false;
	
	// Ending the "No Weapon" script
	terminate GVAR(scriptHandle_noWeaponScript);
	GVAR(scriptHandle_noWeaponScript) = nil;
};