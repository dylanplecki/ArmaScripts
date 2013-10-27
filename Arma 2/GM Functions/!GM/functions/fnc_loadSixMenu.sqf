
GM_fnc_initSixMenu = {
	
	ace_referee = true;
	
	ace_sys_menu = "Logic" createVehicleLocal (getPos player);
	
	ace_sys_menu setVariable ["config_group", true, false];
	ace_sys_menu setVariable ["config_config", true, false];

	ace_sys_menu setVariable ["config_laser", true, false];
	ace_sys_menu setVariable ["config_character", true, false];
	ace_sys_menu setVariable ["config_weapons", true, false];
	ace_sys_menu setVariable ["config_teamstatus", true, false];
	
	// Dr.EyeBall dialog framework init
	[] call compile preProcessFileLineNumbers "x\ace\addons\sys_menu\DebugInit.sqf";

	// init common functions
	[] call compile preProcessFileLineNumbers "x\ace\addons\sys_menu\CommonFunctions.sqf";
	[] call compile preProcessFileLineNumbers "x\ace\addons\sys_menu\CommonDialogFunctions.sqf";

	// Group Callsign module
	[] call compile preProcessFileLineNumbers "x\ace\addons\sys_menu\init_cs.sqf";
};