private ["_veh", "_radio", "_title", "_result", "_getVar"];

// Macros
#include "x-macros.hpp"

// Variables
_veh = _this select 0;
_sound = _this select 1;
_title = _this select 2;
_result = false;

// Script
if (!isDedicated) then {
	
	_getVar = _veh getVariable ["CRACK_sf_boomStatus", CRACK_sf_defaultVehVar];

	if (_getVar select 0) then {
		
		if (_getVar select 1) then {
			if (_getVar select 2) then {
				_veh vehicleRadio _sound;
			} else {
				_veh vehicleRadio "sfs_beep";
			};
			_result = true;
		};

		if (player in (crew _veh)) then {
			titleRsc [_title, "PLAIN"];
			_result = true;
		};
	};
	
	if (CRACK_sf_logBoomerangActs) then {
		[(format["BOOMERANG: Vehicle %1 heard shot at %2", _veh, _sound])] call jayarma2lib_fnc_writeLog;
	};
};

_result