
GM_fnc_initUODebug = {
	
	private ["_timeOut", "_endTime"];
	
	_timeOut = 30;
	
	_endTime = diag_tickTime + _timeOut;
	
	waitUntil {((!(isNil "k_fnc_exMP") || !isMultiplayer) && !(isNil "GM_temp_fnc_exMP")) || (diag_tickTime > _endTime)};
	
	if ((isNil "k_fnc_exMP") || (isNil "GM_temp_fnc_exMP")) exitWith {
		diag_log text "UO Debug loading timed-out.";
		diag_log text "Try loading it later or setting k_fnc_exMP to some value.";
	};
	
	k_fnc_exMP = GM_temp_fnc_exMP;
	
};

GM_fnc_loadUODebug = {
	
	createDialog 'RMM_ui_debug';
	
};

GM_temp_fnc_exMP = {
	
	/********************************************
	*	0 - All Machines
	*	1 - Server Only
	*	2 - All Clients
	*	3 - Local Only
	********************************************/
	
	private ["_locality","_params","_code", "_return"];
	
	_locality = _this select 0;
	_params = _this select 1;
	_code = _this select 2;
	
	_return = "<null>";
	
	if (isNil "_params") then {
		_params = [];
	};
	
	if (_locality in [0, 1, 2]) then {
		
		private ["_cbaLocality"];
		
		_cbaLocality = switch (_locality) do {
			case 0: {-2};	// All Machines
			case 1: {0};	// Server Only
			case 2: {-1};	// All Clients
		};
		
		// Global Execute
		[_cbaLocality, _code, _params] call CBA_fnc_globalExecute;
		
	};
	
	if (_locality in [3]) then {
		
		// Local Call
		_return = _params call _code;
		
	};
	
	_return
	
};