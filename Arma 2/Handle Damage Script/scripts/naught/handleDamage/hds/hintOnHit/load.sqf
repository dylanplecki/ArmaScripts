
cm_handleDamage_hds_hintOnHit_checkEnabled		= compile preProcessFileLineNumbers "scripts\naught\handleDamage\hds\hintOnHit\fnc_checkEnabled.sqf";
cm_handleDamage_hds_hintOnHit_enableHDS			= compile preProcessFileLineNumbers "scripts\naught\handleDamage\hds\hintOnHit\fnc_enableHDS.sqf";
cm_handleDamage_hds_hintOnHit_hint				= compile preProcessFileLineNumbers "scripts\naught\handleDamage\hds\hintOnHit\fnc_hint.sqf";
cm_handleDamage_hds_hintOnHit_setPlayerDamage	= compile preProcessFileLineNumbers "scripts\naught\handleDamage\hds\hintOnHit\fnc_setPlayerDamage.sqf";

cm_handleDamage_hds_hintOnHit_diag_setDamage	= compile preProcessFileLineNumbers "scripts\naught\handleDamage\hds\hintOnHit\diag_hintOnHit_setDamage.sqf";

cm_handleDamage_hds_hintOnHit_interact			= compile preProcessFileLineNumbers "scripts\naught\handleDamage\hds\hintOnHit\ace\loadInteract.sqf";
cm_handleDamage_interactMenu					= cm_handleDamage_interactMenu + [cm_handleDamage_hds_hintOnHit_interact];

cm_handleDamage_hds_hintOnHit_toggleEH			= ["cm_hd_hintOnHit_toggle", cm_handleDamage_hds_hintOnHit_enableHDS] call CBA_fnc_addEventHandler;