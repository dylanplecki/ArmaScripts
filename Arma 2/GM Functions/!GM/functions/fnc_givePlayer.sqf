
GM_fnc_givePlayerWeapon = {
	
	[ // Local Call
		(_this select 0),
		{
			private ["_player", "_params", "_weapon", "_playerName", "_ruck", "_success"];
			_player = _this select 0;
			_params = _this select 1;
			_playerName	= _params select 0;
			_weapon = _params select 1;
			_ruck = if ((count _params) > 2) then {_params select 2} else {false};
			_success = false;
			
			if (_ruck) then {
				if !([_player] call ACE_fnc_HasRuck) exitWith {[(format["%1 has no ruck!", _playerName]), __FILE__, __LINE__] call GM_fnc_log;};
				_success = [_player, _weapon, 1] call ACE_fnc_PackWeapon;
			} else {
				_player addWeapon _weapon;
				_success = true;
			};
			
			if (_success) then {
				[(format["Gave %1 1x '%2' (WEP)", _playerName, _weapon]), __FILE__, __LINE__] call GM_fnc_log;
			} else {
				[(format["Failed to give %1 1x '%2' (WEP)", _playerName, _weapon]), __FILE__, __LINE__] call GM_fnc_log;
			};
		},
		_this
	] call GM_fnc_execOnPlayerLocal;
	
};

GM_fnc_givePlayerMagazine = {
	
	[ // Local Call
		(_this select 0),
		{
			private ["_player", "_params", "_magazine", "_magCount", "_playerName", "_ruck", "_success"];
			_player = _this select 0;
			_params = _this select 1;
			_playerName	= _params select 0;
			_magazine = _params select 1;
			_magCount = if ((count _params) > 2) then {_params select 2} else {1};
			_ruck = if ((count _params) > 3) then {_params select 3} else {false};
			_success = false;
			
			if (_ruck) then {
				if !([_player] call ACE_fnc_HasRuck) exitWith {[(format["%1 has no ruck!", _playerName]), __FILE__, __LINE__] call GM_fnc_log;};
				_success = [_player, _magazine, _magCount] call ACE_fnc_PackMagazine;
			} else {
				_player addMagazine [_magazine, _magCount];
				_success = true;
			};
			
			if (_success) then {
				[(format["Gave %1 %2x '%3' (MAG)", _playerName, _magCount, _magazine]), __FILE__, __LINE__] call GM_fnc_log;
			} else {
				[(format["Failed to give %1 %2x '%3' (MAG)", _playerName, _magCount, _magazine]), __FILE__, __LINE__] call GM_fnc_log;
			};
		},
		_this
	] call GM_fnc_execOnPlayerLocal;
	
};

GM_fnc_givePlayerWOB = {
	
	[ // Local Call
		(_this select 0),
		{
			private ["_player", "_params", "_weapon", "_playerName"];
			_player = _this select 0;
			_params = _this select 1;
			_playerName	= _params select 0;
			_weapon = _params select 1;
			
			if (([_player] call ACE_fnc_WeaponOnBackName) == "") then {
				if ([_player, _weapon] call ACE_fnc_AddWeaponOnBack) then {
					[(format["Gave %1 1x '%2' (WOB)", _playerName, _weapon]), __FILE__, __LINE__] call GM_fnc_log;
				} else {
					[(format["Cannot give %1 1x '%2' (WOB)", _playerName, _weapon]), __FILE__, __LINE__] call GM_fnc_log;
				};
			};
		},
		_this
	] call GM_fnc_execOnPlayerLocal;
	
};