private ["_index", "_value", "_getVar"];

// Macros
#include "x-macros.hpp"

// Variables
_index = _this select 0;
_value = _this select 1;

// Script
_getVar = CRACK_sf_interactTarget getVariable ["CRACK_sf_boomStatus", CRACK_sf_defaultVehVar];
_getVar set [_index, _value];
CRACK_sf_interactTarget setVariable ["CRACK_sf_boomStatus", _getVar];

true