#include "defines.hpp"

private ["_target", "_array", "_indexes", "_selection"];

_target = _this select 0;
_indexes = [];

// Remove actions having to do with certain unit
_array = GVAR(surrenderActionIndexes);
for "_i" from 0 to ((count _array) - 1) do {
	_selection = _array select _i;
	
	if ((_selection select 0) == _target) then {
		_target removeaction (_selection select 1);
		_indexes = _indexes + [_i];
	};
};
{ // foreach
	_array set [_x, (_array select ((count _array) - 1))];
	_array resize ((count _array) - 1);
} foreach _indexes;
GVAR(surrenderActionIndexes) = _array;
_array