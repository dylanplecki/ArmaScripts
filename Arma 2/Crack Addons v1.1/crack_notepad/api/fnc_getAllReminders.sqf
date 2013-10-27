#include "\x\crack\addons\notepad\script_component.hpp"

private ["_result"];

_result = [];

if (!isdedicated) then {
	
	_result = GVAR(reminderCache);
};

_result