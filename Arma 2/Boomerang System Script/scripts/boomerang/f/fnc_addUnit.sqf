// Returns: Fired Event Handler Index
private ["_unit", "_eventHandler"];

// Macros
#include "x-macros.hpp"

// Variables
_unit =	_this select 0;
_eventHandler = -1;

// Script
_eventHandler = _unit addEventHandler ["fired", {
	if ((_this select 4) in CRACK_sf_ammoArray) then {
		_unit = _this select 0;
		_this call CRACK_sf_fnc_shotFiredLocal;
	};
}];

_eventHandler