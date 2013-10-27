// [_textArray, _recursive(true|false)] call FUNCMAIN(arrayToString);

#include "\x\crack\addons\main\script_component.hpp"

private ["_text", "_textArray", "_newText"];

_textArray = _this select 0;
_recursive = _this select 1;
_text = "";
	
if (typename(_text) == typename([])) then {
	
	{ // FOREACH
		_newText = "";
		
		if (typename(_x) == typename("Text")) then {
			_newText = _x;
		} else {
			if ((typename(_x) == typename([])) AND _recursive) then {
				_newText = [_textArray, _recursive] call FUNCMAIN(arrayToString);
			}
		};
		
		if (_newText != "") then {
			_text = _text + _newText;
		};
	} foreach _textArray;
	
};

_text