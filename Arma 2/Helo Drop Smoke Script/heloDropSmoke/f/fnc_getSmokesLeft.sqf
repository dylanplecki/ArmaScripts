private ["_veh", "_index", "_value", "_return", "_getVar", "_default"];

_veh = _this select 0;
_index = _this select 1;
_return = -1;
_default = [];

_getVar = _veh getVariable ["CRACK_heloDS_smokesLeft", 69];

if ((typeName(_getVar) == typeName([]))) then {
	if ((count _getVar) <= _index) exitWith {};
	if (typeName(_getVar select _index) != typeName(69)) exitWith {};
	_return = _getVar select _index;
};

if (_return < 0) then {
	for "_i" from 0 to (count CRACK_heloDS_smokes - 1) do {
		_value = (CRACK_heloDS_smokes select _i) select 3;
		_default set [_i, _value];
	};
	
	_veh setVariable ["CRACK_heloDS_smokesLeft", _default, true];
	_return = _default select _index;
};

_return