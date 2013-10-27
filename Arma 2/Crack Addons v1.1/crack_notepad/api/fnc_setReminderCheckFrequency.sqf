#include "\x\crack\addons\notepad\script_component.hpp"

private ["_result", "_freq"];

_freq = _this select 0;

GVAR(reminderCheckFrequency) = _freq;

true