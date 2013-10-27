
private ["_unit", "_status", "_script"];

_unit		= _this select 0;
_status		= !([_unit] call cm_handleDamage_hds_hintOnHit_checkEnabled);

if (local _unit) then {
	
	_script = if (_status) then {"cm_handleDamage_hds_hintOnHit_hint"} else {""};
	
	_unit setVariable ["cm_hd_script", _script, true];
	
	_unit setVariable ["ace_w_allow_dam", (if (_status) then {false} else {nil}), true];
	
	hint ((localize "STR_HINTONHIT_NAME") + " " + (if (_status) then {localize "STR_ENABLED"} else {localize "STR_DISABLED"}));
};