#include "\x\crack\addons\notepad\script_component.hpp"

private ["_strings", "_result"];

_result = false;

if (!isdedicated) then {

	_strings = call FUNC(createEmptyStrings);
	
	for "_i" from 0 to (GVAR(notepadPages) - 1) do {
		GVAR(notepadContents) set [_i, [(format["Page %1", (_i + 1)]), _strings]];
	};
	
	_result = true;
};

_result