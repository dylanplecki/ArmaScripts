_return = [

	[
		(localize "STR_HINTONHIT_CHECKDAM"),
		{ [(cm_siTarget getVariable ["cm_handleDamage_localDamArray", cm_handleDamage_dft_localDamArray]), ((localize "STR_HINTONHIT_CHECK") + " (" + (name cm_siTarget) + "):")] call cm_handleDamage_hds_hintOnHit_hint; },
		"", "", "", -1,
		1, (_hintOnHit AND (_status select 3))
	],
	
	[
		(localize "STR_HINTONHIT_SETDAM"),
		{ ["create", ["remote", cm_siTarget]] call cm_handleDamage_hds_hintOnHit_diag_setDamage; },
		"", "", "", -1,
		1, (_hintOnHit AND (_status select 4))
	],
	
	[
		(if (!_hintOnHit) then {localize "STR_ENABLE"} else {localize "STR_DISABLE"}) + " " + (localize "STR_HINTONHIT_NAME"),
		{ ["cm_hd_hintOnHit_toggle", [cm_siTarget]] call CBA_fnc_globalEvent; },
		"", "", "", -1,
		1, (_status select 5)
	]
	
];