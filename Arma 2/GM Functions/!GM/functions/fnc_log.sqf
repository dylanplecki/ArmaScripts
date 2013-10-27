
GM_fnc_log = {
	
	private ["_text", "_line", "_file", "", ""];
	
	_text = _this select 0;
	_file = if ((count _this) > 1) then {_this select 1} else {"NULL"};
	_line = if ((count _this) > 2) then {_this select 2} else {-1};
	
	_text = format["[T: %1 | F: '%2' | L: %3 | M: %4] ", diag_tickTime, _file, _line, (SLX_XEH_MACHINE select 10)] + _text;
	
	player sideChat _text;
	diag_log text _text;
	
};