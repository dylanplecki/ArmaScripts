#include "\x\crack\addons\notepad\script_component.hpp"

private ["_result"];

_result = false;

if (!isdedicated) then {
	_result = player getvariable [QUOTE(GVAR(externalAccessEnabled)), true];
};

_result