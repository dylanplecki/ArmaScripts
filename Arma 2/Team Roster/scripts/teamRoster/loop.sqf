#include "f\defines.hpp"

//----------------------

private ["_i"];
_i = 1;
while {([_i] call compile GETPARAM(4))} do {
	private ["_usedGroups", "_groups", "_allUnits", "_side"];
	_usedGroups = [];
	_groups = [];
	_allUnits = call compile GETPARAM(9);
	_side = playerSide;
	
	/*
	// Workaround for when players die/need revive
	if (alive player) then {
		player setVariable [QUOTE(GVAR(lastSavedSide)), _side];
	} else {
		_side = player getVariable [QUOTE(GVAR(lastSavedSide)), _side];
	};
	*/
	
	private ["_j"];
	_j = 0;
	{ // forEach
		private ["_group"];
		_group = group _x;
		
		if !(_group in _usedGroups) then {
			private ["_groupArray"];
			_groupArray = [];
			_usedGroups set [_j, _group];
			
			{ // forEach
				if ((side _x) == _side) then {
					if !(_x in GETPARAM(10)) then {
						private ["_leadership"];
						_leadership = (leader _group) == _x;
						if (((GETPARAM(13) == "0") && _leadership) ||
							((GETPARAM(13) == "1") && (_leadership || (_x in (units (group player))))) ||
							(GETPARAM(13) == "2")
						) then {
							_groupArray set [(([_x] call CBA_fnc_getGroupIndex) - 1), ([_x] call FUNC(getPlayerEntry))];
						};
					};
				};
			} forEach (units _group);
			
			if ((count _groupArray) > 0) then {
				_groups set [_j, _groupArray];
				_j = _j + 1;
			};
		};
		
	} forEach _allUnits;
	
	private ["_text"];
	_text = "<br/>" + ([GETPARAM(11), ":SIDE:", str(_side)] call CBA_fnc_replace) + "<br/>--------------------------------------------------<br/>";
	
	{ // forEach
		if ((typeName _x) == (typeName [])) then {
			{ // forEach
				if ((typeName _x) == (typeName "String")) then {
					_text = _text + _x;
				};
			} forEach _x;
		};
	} forEach _groups;
	
	player createDiaryRecord ["roster", [(format["%1 (%2) - %3", GETPARAM(14), _side, _i]), _text]];
	
	// Waiting for Next Synchronized Iteration
	private ["_time"];
	_time = time + (GETPARAM(2) - (time % GETPARAM(2)));
	waitUntil {uisleep 0.5; time > _time;};
	
	_i = _i + 1;
};