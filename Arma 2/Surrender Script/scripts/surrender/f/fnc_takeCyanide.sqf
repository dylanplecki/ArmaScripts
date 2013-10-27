#include "defines.hpp"

private ["_index"];

if (!isdedicated) then {
	
	_index = player addaction ["<t color='#ff00ff'>ABORT CYANIDE</t>", QUOTE(GETSCRIPTPATH(action.sqf)), {GVAR(canceledCyanide) = true;}, 99999, false, true, "", ""];
	GVAR(surrenderActionIndexes) = GVAR(surrenderActionIndexes) + [[player, _index]];
	GVAR(playerIsTakingCyanide) = true;
	
	[_index] spawn {
		private ["_index", "_willDie", "_timer"];
		
		_index = _this select 0;
		_willDie = true;
		_timer = 11;

		for "_i" from 1 to _timer do {
			hint format ["You are taking Cyanide\nThis will kill you\n\nTo abort, use the scroll wheel\n\nDeath in:\n%1 seconds", (_timer - _i)];
			sleep 1;
			if (!isnil QUOTE(GVAR(canceledCyanide))) exitwith {
				_willDie = false;
				GVAR(canceledCyanide) = nil;
				hint "Cyanide dosage cancelled!";
			};
		};
		
		player removeaction _index;
		
		if (_willDie) then {
			hintsilent "";
			sleep .2;
			[player, "ACE_Scream237"] call CBA_fnc_globalSay3d;
			sleep (1 + random(1));
		};
		
		GVAR(playerIsTakingCyanide) = false;
		
		if (_willDie) then {
			player setdamage 1;
		};
	};
};