// SetIdentity Script
// By: Crackman
//
// In init.sqf: nul = [] execVM "scripts\set_identity.sqf";
//********************************************************
// Initialization
_numberOfIdentities = 23;
HELL_identities = [];
HELL_enabledSides = [EAST, CIVILIAN];
if (isnil "HELL_finishedIdent") then {HELL_finishedIdent = [];};

for "_i" from 1 to _numberOfIdentities do {
	_newIdentity = format["Identity%1", _i];
	HELL_identities = HELL_identities + [_newIdentity];
};

HELL_setIdentity = {
	{
		_man = _x select 0;
		_index = _x select 1;
		if (!(_man in HELL_finishedIdent)) then {
			_man setIdentity (HELL_identities select _index);
			HELL_finishedIdent = HELL_finishedIdent + [_man];
		};
	} foreach HELL_broadcastedIdentities;
	
};

HELL_playerInit = {
	if ((side player) in HELL_enabledSides) then {
		_playerDone = false;
		{
			if ((_x select 0) == player) exitWith {_playerDone = true;};
		} foreach HELL_broadcastedIdentities;
		if (!_playerDone) then { // Continues if the player isn't in the array, ie. JIP
			_index = (floor(random((count HELL_identities) - 1)));
			HELL_broadcastedIdentities = HELL_broadcastedIdentities + [[player, _index]];
			publicvariable "HELL_broadcastedIdentities";
			player setIdentity (HELL_identities select _index);
		};
	};
};

HELL_onPlayerDeath = {
	if (isServer) then {
		_exit = false;
		_count = (count HELL_broadcastedIdentities) - 1;
		for "_i" from 0 to _count do {
			_array = HELL_broadcastedIdentities select _i;
			if ((_array select 0) == (_this select 0)) then {
				HELL_broadcastedIdentities set [_i, (HELL_broadcastedIdentities select _count)];
				HELL_broadcastedIdentities resize _count;
				publicvariable "HELL_broadcastedIdentities";
				_exit = true;
			};
			if (_exit) exitwith {};
		};
	};
	if (!isDedicated AND ((_this select 0) == player)) then {
		waitUntil {!isNull player};
		[] call HELL_playerInit;
	};
};

// Script

if (isserver) then {
	private ["_index"];
	HELL_broadcastedIdentities = [];
	{
		if ((side _x) in HELL_enabledSides) then {
			_index = (floor(random((count HELL_identities) - 1)));
			HELL_broadcastedIdentities = HELL_broadcastedIdentities + [[_x, _index]];
		};
	} foreach allUnits;
	publicvariable "HELL_broadcastedIdentities";
} else {
	waituntil {!isnil "HELL_broadcastedIdentities"};
	waituntil {!isnull player};
};

[] call HELL_setIdentity;
"HELL_broadcastedIdentities" addPublicVariableEventHandler HELL_setIdentity;

if (!isdedicated) then {
	sleep 1;
	player addMPEventHandler ["mpkilled", {_this call HELL_onPlayerDeath;}];
	[] call HELL_playerInit;
};