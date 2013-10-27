// [_player, _array, _byteLimit] call FUNC(limitTextSize);

#include "\x\crack\addons\notepad\script_component.hpp"

private ["_player", "_text", "_byteLimit", "_isTruncated", "_characterCount", "_errorText"];

_player = _this select 0;
_text = _this select 1;
_byteLimit = _this select 2;
_isTruncated = false;

if (typename(_text) == typename([])) then {
	_text = [_text, true] call FUNCMAIN(arrayToString);
};

if (typename(_text) == typename("Text")) then {

	_characterCount = [_text] call CBA_fnc_strLen;

	if (_characterCount > _byteLimit) then {
				
		_errorText = format["%1's NotePad contains over %2 Bytes of data - Too large to send", (name _player), _characterCount];
		[_errorText, "CRACK_NotePad", [false, true, true] ] call CBA_fnc_debug;
		
		_isTruncated = true;
		
	};
	
};

_isTruncated