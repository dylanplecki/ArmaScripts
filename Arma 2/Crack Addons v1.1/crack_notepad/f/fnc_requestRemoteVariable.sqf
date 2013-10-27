#include "\x\crack\addons\notepad\script_component.hpp"

// TITLE REQUESTS: [0, _unit, []] call FUNC(requestRemoteVariable);
// CONTENT REQUESTS: [1, _unit, [_titleFrom, _titleTo]] call FUNC(requestRemoteVariable);

private ["_dataType", "_unit", "_args", "_data", "_isTruncated", "_contents"];

_dataType = _this select 0; // Titles = 0 || Contents = 1
_unit = _this select 1;
_args = if ((count _this) > 2) then {_this select 2} else {[]};
_isTruncated = false;

if (ismultiplayer) then {
	
	_contents = _unit getvariable [QUOTE(GVAR(oldNotepad)), 69];
	
	if (typename(_contents) == typename([])) exitwith {
		
		_data = [_dataType, _contents, _args] call FUNC(filterDataByType);
		
		[_dataType, _unit, player, _data, _args] spawn FUNC(recieveRemoteVariable); // [_sentDataType, _requestedDataCarrier, _sentDataRequestor, _sentData, _args]
		
	};
	
	if (GVAR(checkForByteLimit)) then {
		_isTruncated = [player, _args, GVAR(byteLimit)] call FUNC(limitTextSize);
	};
	
	if (_isTruncated) exitwith {
		hint "Your data is too large to send.";
	};
	
	GVAR(synDataVar) = [_dataType, _unit, player, _args]; // [_requestedDataType, _requestedDataCarrier, _sender, _args]
	publicvariable QUOTE(GVAR(synDataVar));
	
};