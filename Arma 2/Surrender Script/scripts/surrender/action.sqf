private ["_code", "_target", "_id"];

_target = _this select 0; // Usually local player

_caller = if (count _this > 1) then {(_this select 1)} else {"nil"};
_id = if (count _this > 2) then {(_this select 2)} else {"nil"};
_code = if (count _this > 3) then {(_this select 3)} else {"false"};

if (typename(_code) == typename("String")) then {
	_code = compile _code;
};

[_target, _caller, _id] spawn _code;