_return = [

	[
		(localize "STR_HINTONHIT_CHECKDAM"),
		{ [(player getVariable ["cm_handleDamage_localDamArray", cm_handleDamage_dft_localDamArray]), ((localize "STR_HINTONHIT_CHECK") + ":")] call cm_handleDamage_hds_hintOnHit_hint; },
		"", "", "", -1,
		1, (_hintOnHit AND (_status select 0))
	],
	
	[
		(localize "STR_HINTONHIT_SETDAM"),
		{ ["create", ["local", player]] call cm_handleDamage_hds_hintOnHit_diag_setDamage; },
		"", "", "", -1,
		1, (_hintOnHit AND (_status select 1))
	],
	
	[
		(if (!_hintOnHit) then {localize "STR_ENABLE"} else {localize "STR_DISABLE"}) + " " + (localize "STR_HINTONHIT_NAME"),
		{ ["cm_hd_hintOnHit_toggle", [player]] call CBA_fnc_localEvent; },
		"", "", "", -1,
		1, (_status select 2)
	]
	
];