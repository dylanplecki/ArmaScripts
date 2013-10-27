#include "\x\crack\addons\notepad\script_component.hpp"

private ["_result", "_pageIndex", "_title", "_lines", "_totalLines", "_text"];

_pageIndex = _this select 0;
_title = _this select 1;
_lines = _this select 2;

_result = -1;

if (!isdedicated) then {
	
	if (_pageIndex > (count GVAR(notepadContents) - 1)) exitwith {
		_text = format["Page index (%1) is greater than the total number of pages available (%2)", _pageIndex, (count GVAR(notepadContents) - 1)];
		ERROR(_text);
	};
	
	_totalLines = GVAR(notepadEndLine) - (GVAR(notepadStartLine) - 1);
	
	while {(count _lines) < _totalLines} do {
		_lines = _lines + [""];
	};
	
	GVAR(notepadContents) set [_pageIndex, [_title, _lines]];
	
	_result = _pageIndex;
	
};

_result