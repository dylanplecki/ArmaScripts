#include "f\defines.hpp"

//----------------------

private ["_allUnits", "_time", "_title", "_i", "_usedGroups", "_j", "_groupArray", "_group", "_groups", "_index"];

//----------------------

_i = 1; // Starting Iteration Number

// Setting Arrays
_usedGroups = [];
_groupArray = [];
_groups = [];

//----------------------

while {(call compile GETPARAM(4))} do {
	
	_allUnits = call compile GETPARAM(9);
	_side = side player;
	_title = format["Team Roster (%1) - %2", _side, _i];
	
	_stringScratchPad = [GETPARAM(11), ":SIDE:", str(_side)] call CBA_fnc_replace;
	_text = "<br/>" + _stringScratchPad + "<br/>--------------------------------------------------<br/>";
	
	//------------------
	
	_j = 0;
	{ // FOREACH
		
		_group = group _x;
		
		if !(_group in _usedGroups) then {
			
			_usedGroups set [_j, _group];
			_groupArray = [];
			
			{ // FOREACH
				if ((side _x) == _side) then {
					if !(_x in GETPARAM(10)) then {
						
						private ["_leadership", "_squadMate", "_param13_0", "_param13_1", "_param13_2"];
						
						_leadership = (leader _group) == _x;
						_squadMate = _x in (units (group player));
						
						_param13_0 = (GETPARAM(13) == "0") AND _leadership;
						_param13_1 = (GETPARAM(13) == "1") AND (_leadership OR _squadMate);
						_param13_2 = GETPARAM(13) == "2";
						
						if (_param13_0 OR _param13_1 OR _param13_2) then {
							
							_stringScratchPad = ([_x] call FUNC(getPlayerEntry));
							_index = ([_x] call CBA_fnc_getGroupIndex) - 1;
							
							_groupArray set [_index, _stringScratchPad];
							
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
	
	//------------------
	
	{ // FOREACH
		{
			_text = _text + _x;
		} forEach _x;
	} forEach _groups;
	
	//------------------
	
	player createDiaryRecord ["roster", [_title, _text]];
	
	// Resetting Variables
	_text = "";
	_title = "";
	_groups = [];
	_usedGroups = [];
	_stringScratchPad = "";
	
	// Waiting for Next Synchronized Iteration
	_time = time + (GETPARAM(2) - (time % GETPARAM(2))); // REMEMBER THIS PERFECT ALGORITHM
	waitUntil {sleep 0.5; time > _time;};
	
	_i = _i + 1;
};