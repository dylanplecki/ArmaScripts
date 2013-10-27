#include "\x\crack\addons\notepad\script_component.hpp"

private ["_result"];

_result = false;

if (!isdedicated) then {
	
	_result = GVAR(notepadInUse);
};

_result