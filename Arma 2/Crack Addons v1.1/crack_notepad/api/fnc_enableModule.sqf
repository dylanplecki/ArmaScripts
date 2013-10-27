#include "\x\crack\addons\notepad\script_component.hpp"

private ["_result", "_enable", "_module"];

_module = _this select 0;
_enable = _this select 1;
_result = false;

if (!isdedicated) then {
	
	{ // FOREACH
		if (_module == (_x select 0)) exitwith {
			call compile format["%1 = %2;", (_x select 1), _enable];
			_result = true;
		};
	} foreach GVAR(modules);
	
};

_result