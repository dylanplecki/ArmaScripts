
GM_fnc_execOnPlayer = {
	
	private ["_playerName", "_code", "_params"];
	
	_playerName	= _this select 0;
	_code		= _this select 1;
	_params		= if ((count _this) > 2) then {_this select 2} else {[]};
	
	[ -1,
		{
			if ((format ["%1", (name player)]) == (_this select 0)) then {	
				[player, (_this select 2)] spawn (_this select 1);
			};
		},
		[_playerName, _code, _params]
	] call CBA_fnc_globalExecute;
	
};

GM_fnc_execOnPlayerLocal = {
	
	private ["_playerName", "_code", "_params"];
	
	_playerName	= _this select 0;
	_code		= _this select 1;
	_params		= if ((count _this) > 2) then {_this select 2} else {[]};
	
	{
		if ((format ["%1", (name _x)]) == _playerName) exitWith {
			[_x, _params] spawn _code;
		};
	} forEach (call CBA_fnc_players);
	
};