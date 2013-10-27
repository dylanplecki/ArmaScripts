#include "\x\crack\addons\notepad\script_component.hpp"

// [-2, {[] spawn crack_notepad_fnc_transferTest;}] call CBA_fnc_globalExecute; - Local Execute

private ["_contents", "_strings", "_oldFunc"];

GVAR(transferTesting) = true;
_oldFunc = FUNC(sendLocalVariable);

FUNC(sendLocalVariable) = {
	private ["_dataType", "_unit", "_sender", "_args", "_sentData", "_data", "_isTruncated", "_contents"];

	_dataType = _this select 0; // Titles = 0 || Contents = 1
	_unit = _this select 1;
	_sender = _this select 2;
	_args = _this select 3;
	_data = false;

	if (ismultiplayer) then {
		
		if (isserver) then {
			_data = GVAR(notepadContents);
		};
		
		/*
		if (isserver) then {
			
			_contents = _unit getvariable [QUOTE(GVAR(oldNotepad)), 69];
			
			if (typename(_contents) == typename([])) then {
				
				_data = _contents;
			};
		};
		*/
		
		if (typename(_data) == typename([])) then {
			
			_sentData = [_dataType, _data, _args] call FUNC(filterDataByType);
			
			if ((isserver) AND GVAR(checkForByteLimit)) then {
				_isTruncated = [objnull, _sentData, GVAR(byteLimit)] call FUNC(limitTextSize);
				
				if (_isTruncated) then {
					_sentData = "TRUNCATED";
					hintsilent "Your data is too large to send to the requestor - This may be considered abuse of the system.";
				};
			};
			
			GVAR(ackDataVar) = [_dataType, _unit, _sender, _sentData, _args]; // [_sentDataType, _requestedDataCarrier, _sentDataRequestor, _sentData, _args]
			publicvariable QUOTE(GVAR(ackDataVar));
			
		};
	};
}; // END FUNCTION

if (isserver) then {
	
	_contents = [];
	_strings = [];
	
	for "_j" from GVAR(notepadStartLine) to GVAR(notepadEndLine) do {
		_strings = _strings + [(format["Line %1", (_j - 5)])];
	};
	
	for "_i" from 0 to GVAR(notepadPages) do {
		_contents = _contents + [[(format["Page %1", (_i + 1)]), _strings]];
	};
	
	GVAR(notepadContents) = _contents;
};

if (!isdedicated) then {
	
	hint "10 Seconds till Transfer";
	
	sleep 10;
	
	[0, player, []] call FUNC(requestRemoteVariable);
	
};

//waituntil {sleep 1; !(GVAR(transferTesting));};

//FUNC(sendLocalVariable) = _oldFunc;