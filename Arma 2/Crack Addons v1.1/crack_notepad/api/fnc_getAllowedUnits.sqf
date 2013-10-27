#include "\x\crack\addons\notepad\script_component.hpp"

private ["_result"];

_result = if (!isnil QUOTE(GVAR(enabledUnits))) then {GVAR(enabledUnits)} else {call CBA_fnc_players};

_result