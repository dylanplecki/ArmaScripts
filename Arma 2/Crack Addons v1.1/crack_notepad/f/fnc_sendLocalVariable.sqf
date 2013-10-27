#include "\x\crack\addons\notepad\script_component.hpp"

private ["_dataType", "_unit", "_sender", "_args", "_sentData", "_data", "_isTruncated", "_contents"];

_dataType = _this select 0; // Titles = 0 || Contents = 1
_unit = _this select 1;
_sender = _this select 2;
_args = _this select 3;
_data = false;

if (ismultiplayer) then {
	
	if (_unit == player) then {
		_data = GVAR(notepadContents);
	};
	
	if (isserver) then {
		
		_contents = _unit getvariable [QUOTE(GVAR(oldNotepad)), 69];
		
		if (typename(_contents) == typename([])) then {
			
			_data = _contents;
		};
	};
	
	if (typename(_data) == typename([])) then {
		
		_sentData = [_dataType, _data, _args] call FUNC(filterDataByType);
		
		if ((_unit == player) AND GVAR(checkForByteLimit)) then {
			_isTruncated = [player, _sentData, GVAR(byteLimit)] call FUNC(limitTextSize);
			
			if (_isTruncated) then {
				_sentData = "TRUNCATED";
				hintsilent "Your data is too large to send to the requestor - This may be considered abuse of the system.";
			};
		};
		
		GVAR(ackDataVar) = [_dataType, _unit, _sender, _sentData, _args]; // [_sentDataType, _requestedDataCarrier, _sentDataRequestor, _sentData, _args]
		publicvariable QUOTE(GVAR(ackDataVar));
		
	};
};