private ["_array", "_nestedValue", "_nestedValueIndex", "_value", "_index", "_result"];

_index = -1;
_result = false;

_array = _this select 0;
_nestedValue = _this select 1;
_nestedValueIndex =  _this select 2;

_arrayCount = (count _array) - 1;

for "_i" from 0 to _arrayCount do {
	_value = (_array select _i) select _nestedValueIndex;
	if (_value == _nestedValue) exitwith {_index = _i;};
};

if (_index != -1) then {
	_array set [_index, (_array select _arrayCount)];
	_array resize _arrayCount;
	_result = _array;
};

_result