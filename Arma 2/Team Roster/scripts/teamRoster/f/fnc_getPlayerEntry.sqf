#include "defines.hpp"

//----------------------

private ["_player", "_string", "_playerDesc"];
_player = _this select 0;
_string = GETPARAM(5);

if ((leader (group _player)) == _player) then {
	if (GETPARAM(0)) then {
		_string = "<br/>" + _string + (format["%1%2", (group _player), GETPARAM(7)]);
	};
} else {
	_string = _string + (GETPARAM(1));
};

_playerDesc = [str player, GETPARAM(8)] call CBA_fnc_split;
if ((count _playerDesc) > 0) then {
	_playerDesc = [_playerDesc, GETPARAM(6), " "] call CBA_fnc_replace;
} else {_playerDesc = "";};

if (_playerDesc == "") then {
	_playerDesc = "Player";
};

_string = _string + ([_player] call FUNC(abbreviateRank)) + (name _player) + " (" + _playerDesc + ")"; // "Alpha Squad - Sgt. Crackman (Squad Leader)" or "    Pvt. Crackman (Machinegunner)"

// FireTeam Coloring Code
if (((GETPARAM(12) == "1") || (GETPARAM(12) == "2")) && !{(GETPARAM(12) == "1") AND !(_player in (units (group player)))}) then {
	private ["_team"];
	_team = if (isMultiplayer) then {
		_player getVariable ["ST_FTHud_assignedTeam", "MAIN"]; // NEEDS ST FT HUD TO WORK ACCURATELY ON MP
	} else {
		assignedTeam _player; // SINGLEPLAYER ONLY
	};
	
	private ["_color"];
	switch (_team) do {
		case "MAIN": {_color = "#ffffff"};
		case "RED": {_color = "#ff0000"};
		case "BLUE": {_color = "#0000ff"};
		case "GREEN": {_color = "#00ff00"};
		case "YELLOW": {_color = "#ffff00"};
	};
	
	_string = (format ["<font color='%1'>", _color]) + _string + "</font>";
};

_string = _string + "<br/>";

//----------------------

// Return Value
_string