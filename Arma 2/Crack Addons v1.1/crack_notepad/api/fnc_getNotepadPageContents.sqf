#include "\x\crack\addons\notepad\script_component.hpp"

private ["_result", "_page", "_index"];

_page = _this select 0;
_result = [];

if (!isdedicated) then {
	
	_index = -1;
	
	if (typename(_page) == typename("Title")) then { // Page Title
		for "_i" from 0 to (count GVAR(notepadContents) - 1) do {
			if (((GVAR(notepadContents) select _i) select 0) == _page) exitwith {_index = _i;};
		};
	};
	
	if (typename(_page) == typename(2)) then { // Page Index
		_index = _page;	
	};
	
	if (_index > (count GVAR(notepadContents) - 1)) exitwith {
		_text = format["Page index (%1) is greater than the total number of pages available (%2)", _pageIndex, (count GVAR(notepadContents) - 1)];
		ERROR(_text);
	};
	
	if (_index != -1) then {
		_result = GVAR(notepadContents) select _index;
	};
};

_result