private ["_unit", "_pos", "_dir", "_ammo", "_veh", "_result", "_vehicles", "_nearestVehs", "_dis", "_foo"];

// Macros
#include "x-macros.hpp"

debugChat("Detectable Shot Fired Remote",4);

// Variables
_unit =	_this select 0;
_pos =	_this select 1;
_dir =	_this select 2;
_ammo =	_this select 3;
_vehs =	_this select 4;
_nearestVehs = [];

// Script
if ((count _vehs) > 0) then {
	
	debugChat("A Boomerang Vehicle is in Range",5);
	
	{
		_nearestVehs set [(count _nearestVehs), [_x, (_x distance _pos)]];
	} forEach _vehs;
	
	_nearestVehs = [_nearestVehs, 1] call CBA_fnc_sortNestedArray;
	
	ifDebug(6) then {
		private ["_infoText"];
		_infoText = format["Nearest Boomerang Vehicles: %1", _nearestVehs];
		debugChat(_infoText,6);
	};
	
	for "_i" from 0 to ((count _nearestVehs) - 1) do {
		_veh = _nearestVehs select _i;
		_foo = (_veh + [_pos]) spawn {
			_args = _this call CRACK_sf_fnc_getQuadrant;
			([(_this select 0)] + _args) call CRACK_sf_fnc_shotAlert;
			ifDebug(4) then {
				private ["_infoText"];
				_infoText = format["Vehicle %1 Shot Detected, w/args: %2", (_this select 0), _args];
				debugChat(_infoText,4);
			};
		};
	};
};

_result