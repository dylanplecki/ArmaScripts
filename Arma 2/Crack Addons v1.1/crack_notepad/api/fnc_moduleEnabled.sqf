#include "\x\crack\addons\notepad\script_component.hpp"

private ["_result", "_module"];

_module = _this select 0;
_result = false;

if (!isdedicated) then {
	
	{ // FOREACH
		if (_module == (_x select 0)) exitwith {
			_result = call compile (_x select 1);
		};
	} foreach GVAR(modules);
	
};

_result