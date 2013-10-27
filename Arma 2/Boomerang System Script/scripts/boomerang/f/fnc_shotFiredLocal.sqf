private ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_affVeh", "_dirP", "_dirV", "_handle"];

// Macros
#include "x-macros.hpp"

debugChat("Detectable Shot Fired Local",4);

// Variables
_unit =		_this select 0;
_weapon =	_this select 1;
_muzzle =	_this select 2;
_mode =		_this select 3;
_ammo =		_this select 4;
_affVeh =	[];

// Script
{
	private ["_distance"];
	
	_distance = abs(_x distance _unit);
	
	if ((CRACK_sf_minDetectionRad <= _distance) AND (_distance <= CRACK_sf_maxDetectionRad)) then {
		
		_dirP = [(getDir _unit)] call CRACK_sf_fnc_simpDeg;
		_dirV = [_unit, _x] call CRACK_sf_fnc_dirTo;
		
		ifDebug(6) then {
			private ["_infoText"];
			_infoText = format["Vehicle %1: DirP=%2, DirV=%3, Dist=%4", _x, _dirP, _dirV, _distance];
			debugChat(_infoText,6);
		};
		
		if (((_dirV - CRACK_sf_dirConeSize) <= _dirP) AND (_dirP <= (_dirV + CRACK_sf_dirConeSize))) then {
			
			_affVeh = _affVeh + [_x];
			
			ifDebug(5) then {
				private ["_infoText"];
				_infoText = format["Vehicle %1 can detect %2", _x, _unit, _distance];
				debugChat(_infoText,5);
			};
		};
	};
} forEach CRACK_sf_vehicleArray;

debugChat("Sending Shot Fired Variable",5);

CRACK_sf_shotFired = [_unit, (getpos _unit), (getdir _unit), _ammo, _affVeh];
publicVariable "CRACK_sf_shotFired";

debugChat("Shot Fired Variable Sent",5);

// Just in case the local unit is near
if (!isDedicated) then {
	_handle = CRACK_sf_shotFired spawn CRACK_sf_fnc_shotFiredRemote;
};