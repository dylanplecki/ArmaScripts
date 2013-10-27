#include "defines.hpp"

private ["_target", "_result"];

_target = _this select 0;

if (isserver) then {
	_result = _target getvariable QUOTE(GVAR(surrenderedStatus));
	for "_i" from 0 to (count _result - 1) do {
		_result set [_i, false];
	};
	_target setvariable [QUOTE(GVAR(surrenderedStatus)), _result, true];
};

if (_target == player) then {
	
	if (!isnil QUOTE(GVAR(scriptHandle_noWeaponScript))) then {
		terminate GVAR(scriptHandle_noWeaponScript);
	};
	
	[_target] call FUNC(removeAllActions);
};