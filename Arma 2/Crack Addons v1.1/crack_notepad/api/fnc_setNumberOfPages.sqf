#include "\x\crack\addons\notepad\script_component.hpp"

private ["_pages", "_oldPages", "_result", "_strings"];

_result = false;

if (!isdedicated) then {

	_pages = _this select 0;

	_oldPages = count GVAR(notepadContents);

	GVAR(notepadContents) resize _pages;

	if (GVAR(notepadPages) < _pages) then { // Add Pages
		
		hint "done"; // DEBUGGING CODE
		
		_strings = call FUNC(createEmptyStrings);
		
		for "_i" from _oldPages to (_pages - 1) do {
			GVAR(notepadContents) set [_i, [(format["Page %1", (_i + 1)]), _strings]];
		};
		
	};

	GVAR(notepadPages) = _pages;
	
	_result = true;
	
};

_result