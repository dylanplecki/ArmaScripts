#include "\x\crack\addons\notepad\script_component.hpp"

private ["_pageIndex", "_strings", "_result"];

_pageIndex = _this select 0;
_result = false;

if (!isdedicated) then {
	_strings = call FUNC(createEmptyStrings);
	
	if (_pageIndex > (count GVAR(notepadContents) - 1)) exitwith {
		_text = format["Page index (%1) is greater than the total number of pages available (%2)", _pageIndex, (count GVAR(notepadContents) - 1)];
		ERROR(_text);
	};
	
	GVAR(notepadContents) set [_pageIndex, [(format["Page %1", (_i + 1)]), _strings]];
	
	_result = true;
};

_result