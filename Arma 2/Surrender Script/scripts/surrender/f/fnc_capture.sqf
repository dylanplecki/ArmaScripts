#include "defines.hpp"

private ["_target", "_result"];

_target = _this select 0;

_result = _target getvariable QUOTE(GVAR(surrenderedStatus));
_result set [1, true];
_target setvariable [QUOTE(GVAR(surrenderedStatus)), _result, true];