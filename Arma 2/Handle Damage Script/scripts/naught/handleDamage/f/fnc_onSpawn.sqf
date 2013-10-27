
private ["_unit"];

_unit = _this select 0;

{
	private ["_var", "_val"];
	
	_var = _x select 0;
	_val = _x select 1;
	
	_unit setVariable [_var, _val, true];
	
} forEach cm_handleDamage_defaults;

_unit setVariable ["ace_w_allow_dam", (if ([_unit] call cm_handleDamage_hds_hintOnHit_checkEnabled) then {false} else {nil}), true];