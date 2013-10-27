#include "\x\crack\addons\notepad\script_component.hpp"

private ["_result", "_reminderTitle", "_index"];

_reminderTitle = _this select 0;
_result = [];

if (!isdedicated) then {
	
	for "_i" from 0 to (count GVAR(reminderCache) - 1) do {
		if (((GVAR(reminderCache) select _i) select 0) == _reminderTitle) exitwith {_index = _i;};
	};
	
	_result = (GVAR(reminderCache) select _index) select 1;
};

_result