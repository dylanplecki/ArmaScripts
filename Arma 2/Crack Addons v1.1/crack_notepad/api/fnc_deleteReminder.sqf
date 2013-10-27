#include "\x\crack\addons\notepad\script_component.hpp"

// _result = [_title, false] call FUNC(deleteReminder);

private ["_title", "_terminate", "_index", "_result"];

_title = _this select 0;
_terminate = if (count _this > 1) then {_this select 1} else {true};
_result = false;

for "_i" from 0 to (count GVAR(reminderCache) - 1) do {
	if (((GVAR(reminderCache) select _i) select 0) == _title) exitwith {_index = _i;};
};

if (_index != -1) then {
	
	if (_terminate) then {
		terminate ((GVAR(reminderCache) select _index) select 1)
	};
	
	GVAR(reminderCache) set [_index, (GVAR(reminderCache) select (count GVAR(reminderCache) - 1))];
	GVAR(reminderCache) resize (count GVAR(reminderCache) - 1);
	
	_result = true;
};

_result