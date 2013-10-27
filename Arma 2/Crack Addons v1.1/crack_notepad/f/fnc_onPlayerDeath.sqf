#include "\x\crack\addons\notepad\script_component.hpp"

private ["_unit", "_killer", "_contents"];

_unit = _this select 0;
_killer = _this select 1;

if (_unit == player) then {
	
	//if (([] call FUNC(canPlayerUseNotepad)) AND GVAR(notepadMPEnabled)) then {
	
	_contents = GVAR(notepadContents);
	
	_isTruncated = [player, _contents, GVAR(byteLimit)] call FUNC(limitTextSize);
	
	if (_isTruncated) exitwith {hint "Your notepad was too large to save - May be considered malicious";};
	
	[_unit] call compile format["(_this select 0) setvariable ['%1', %2, true];", QUOTE(GVAR(oldNotepad)), _contents];
	
	//};
};