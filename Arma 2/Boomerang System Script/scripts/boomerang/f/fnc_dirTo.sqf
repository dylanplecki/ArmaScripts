//
// An Actually Working DirectionTo Function!
//		By Crackman
//
//------------------------------------------

private ["_pos1", "_pos2", "_x", "_y", "_theta"];

// Variables
_pos1 = _this select 0;
_pos2 = _this select 1;

// Script
if (typeName(_pos1) == "OBJECT") then {
	_pos1 = getPos _pos1;
};
if (typeName(_pos2) == "OBJECT") then {
	_pos2 = getPos _pos2;
};

_x = (_pos2 select 0) - (_pos1 select 0);
_y = (_pos2 select 1) - (_pos1 select 1);

_theta = (((_x atan2 _y) % 360) + 360) % 360;

_theta