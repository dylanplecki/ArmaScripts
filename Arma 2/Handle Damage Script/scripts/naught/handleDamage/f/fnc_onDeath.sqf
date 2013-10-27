
private ["_unit", "_killer"];

_unit		= _this select 0;
_killer		= _this select 1;

for "_i" from 0 to (count cm_handleDamage_defaults - 1) do {
	
	private ["_var", "_val", "_dft"];
	
	_x = cm_handleDamage_defaults select _i;
	
	_var = _x select 0;
	_dft = _x select 1;
	
	_val = _unit getVariable [_var, _dft];
	
	cm_handleDamage_defaults set [_i, [_var, _val]];
	
	_unit setVariable [_var, nil, true];
	
};

waitUntil {alive player};

[player] call cm_handleDamage_fnc_onSpawn;