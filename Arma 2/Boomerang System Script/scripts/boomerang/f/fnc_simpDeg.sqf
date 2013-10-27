//
// Simplifies a Degree Measurement to Under 360
//		By Crackman
//
//---------------------------------------------

private ["_deg"];

// Variables
_deg = _this select 0;

// Script
_deg = ((_deg % 360) + 360) % 360;

_deg