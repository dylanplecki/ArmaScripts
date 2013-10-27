
private ["_call", "_dam"];

_call	= _this select 0;
_dam	= _this select 1;

switch (_call) do {
	
	case "local": {
		
		player setVariable ["cm_handleDamage_localDamArray", (_dam + [diag_tickTime]), true];
		
		hint "Local Player Damage Changed!";
	};
	
	case "remote": {
		
		[-1, {
			if (player == (_this select 0)) then {
				["local", _dam] call cm_handleDamage_fnc_setPlayerDamage;
			};
		}, cm_siTarget] call CBA_fnc_globalExecute;
	};
};