#include "defines.hpp"

//----------------------

private ["_player", "_string", "_playerName", "_playerDesc", "_playerRank", "_team"];

_player = _this select 0;
_string = GETPARAM(5);

//----------------------

if ((leader (group _player)) == _player) then {
	
	if (GETPARAM(0)) then {
		_string = "<br/>" + _string + (format["%1%2", (group _player), GETPARAM(7)]);
	};
	
} else {
	
	_string = _string + (GETPARAM(1));
	
};

//----------------------

_playerName = name _player;
_playerDesc = str(_player); // Stored as player's name
_playerRank = [_player] call FUNC(abbreviateRank);

//----------------------

if (_playerDesc == "") then {
	
	_playerDesc = "Player";
	
} else {
	
	// Doing some edits to the player's description
	_playerDesc = ([_playerDesc, GETPARAM(8)] call CBA_fnc_split) select 0; // All text before the first char
	_playerDesc = [_playerDesc, GETPARAM(6), " "] call CBA_fnc_replace;
	
};

//----------------------

_string = _string + _playerRank + _playerName + " (" + _playerDesc + ")"; // "Alpha Squad - Sgt. Crackman (Squad Leader)" or "    Pvt. Crackman (Machinegunner)"

//----------------------

// FireTeam Coloring Code
if ((GETPARAM(12) == "1") OR (GETPARAM(12) == "2")) then {
	
	if ((GETPARAM(12) == "1") AND !(_player in (units (group player)))) exitWith {};
	
	private ["_color"];
	
	if (isMultiplayer) then {
		_team = _player getVariable ["ST_FTHud_assignedTeam", "MAIN"]; // NEEDS ST FT HUD TO WORK ACCURATELY ON MP
	} else {
		_team = assignedTeam _player; // SINGLEPLAYER ONLY
	};
	
	switch (_team) do {
		case "MAIN": {_color = "#ffffff"};
		case "RED": {_color = "#ff0000"};
		case "BLUE": {_color = "#0000ff"};
		case "GREEN": {_color = "#00ff00"};
		case "YELLOW": {_color = "#ffff00"};
	};
	
	_stringScratchPad = format ["<font color='%1'>", _color];
	
	_string = _stringScratchPad + _string + "</font>";
};

//----------------------

_string = _string + "<br/>";

//----------------------

// Return Value
_string