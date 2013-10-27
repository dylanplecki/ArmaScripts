private ["_args", "_veh", "_xcor", "_ycor", "_rDir", "_sDir", "_vehPos", "_distance", "_fireLoc", "_vDir"];

// Macros
#include "x-macros.hpp"

// Variables
_veh = _this select 0;
_distance = _this select 1;
_fireLoc = _this select 2;

// Script
_sDir = [_veh, _fireLoc] call CRACK_sf_fnc_dirTo;
_vDir = [(getDir _veh)] call CRACK_sf_fnc_simpDeg;
_rDir = ((360 - _vDir) + _sDir) % 360;

ifDebug(6) then {
	private ["_infoText"];
	_infoText = format["Vehicle %1 Quadrant: sDir=%2, vDir=%3, rDir=%4", _veh, _sDir, _vDir, _rDir];
	debugChat(_infoText,6);
};

//----------------------

_args = switch (true) do {
	
	case ((_rDir > 345) || (_rDir <= 15)):
	{["sfs_12oclock", "sf_12oclock"]};
	
	case ((_rDir > 15) && (_rDir <= 45)):
	{["sfs_1oclock", "sf_1oclock"]};
	
	case ((_rDir > 45) && (_rDir <= 75)):
	{["sfs_2oclock", "sf_2oclock"]};
	
	case ((_rDir > 75) && (_rDir <= 105)):
	{["sfs_3oclock", "sf_3oclock"]};
	
	case ((_rDir > 105) && (_rDir <= 135)):
	{["sfs_4oclock", "sf_4oclock"]};
	
	case ((_rDir > 135) && (_rDir <= 165)):
	{["sfs_5oclock", "sf_5oclock"]};
	
	case ((_rDir > 165) && (_rDir <= 195)):
	{["sfs_6oclock", "sf_6oclock"]};
	
	case ((_rDir > 195) && (_rDir <= 225)):
	{["sfs_7oclock", "sf_7oclock"]};
	
	case ((_rDir > 225) && (_rDir <= 255)):
	{["sfs_8oclock", "sf_8oclock"]};
	
	case ((_rDir > 255) && (_rDir <= 285)):
	{["sfs_9oclock", "sf_9oclock"]};
	
	case ((_rDir > 285) && (_rDir <= 315)):
	{["sfs_10oclock", "sf_10oclock"]};
	
	case ((_rDir > 315) && (_rDir <= 345)):
	{["sfs_11oclock", "sf_11oclock"]};
	
	case default
	{["",""]};
};

//----------------------

_args