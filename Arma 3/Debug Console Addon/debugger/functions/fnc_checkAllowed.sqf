#include "\x\uo\addons\debugger\script_component.hpp"

private ["_allowed"];

_allowed = false;

if (!isMultiplayer) then {
	_allowed = true;
} else {
	
	/*
	// Admin of dedicated server - NOT USED BY UO
	if (isDedicated && serverCommandAvailable "#ban") then {
		_allowed = true;
	};
	*/
	
	// Host of multiplayer server
	if (isServer) then {
		_allowed = true;
	};
	
	// Administrator List Stuff
	if (!_allowed) then {
		
		private ["_waitTime"];
		
		_waitTime = time + 10;
		
		waitUntil {(time >= _waitTime) OR (!isNil QUOTE(GVAR(adminList)))};
		
		if (isNil QUOTE(GVAR(adminList))) then {
			GVAR(adminList) = GVAR(adminListLocal);
		};
		
		// Player UID in Administrator List
		if ((getPlayerUID player) in GVAR(adminList)) then {
			_allowed = true;
		};
	};
};

_allowed