
//	Execute In-Mission To Load Functions:
//		nul = [] execVM '\!GM\init.sqf';

#define COMPILE_FILE(file)		(compile preProcessFileLineNumbers file)
#define CALL_FILE(file)			(call COMPILE_FILE(file))
#define CACHE_FILE(file)		(file call GM_fnc_cacheFile)
#define CALL_CACHE_FILE(file)	(call CACHE_FILE(file))

GM_init = true;

if (isNil "GM_initRuns") then {
	GM_initRuns = 0;
};

GM_initRuns = GM_initRuns + 1;

CALL_FILE("\!GM\settings.sqf");

[] spawn {
	
	/********************************************
	*	Loading Functions
	********************************************/
	CALL_FILE("\!GM\functions\fnc_cacheFile.sqf");				// GM_fnc_execScratchpad
	CALL_CACHE_FILE("\!GM\functions\fnc_execOnPlayer.sqf");		// GM_fnc_execOnPlayer
	CALL_CACHE_FILE("\!GM\functions\fnc_execScratchpad.sqf");	// GM_fnc_execScratchpad
	CALL_CACHE_FILE("\!GM\functions\fnc_fixEarplugs.sqf");		// GM_fnc_fixEarplugs
	CALL_CACHE_FILE("\!GM\functions\fnc_givePlayer.sqf");		// Multiple Functions
	CALL_CACHE_FILE("\!GM\functions\fnc_loadACEDebug.sqf");		// GM_fnc_loadACEDebug
	CALL_CACHE_FILE("\!GM\functions\fnc_loadSixMenu.sqf");		// GM_fnc_loadSixMenu
	CALL_CACHE_FILE("\!GM\functions\fnc_loadUODebug.sqf");		// GM_fnc_loadUODebug
	CALL_CACHE_FILE("\!GM\functions\fnc_log.sqf");				// GM_fnc_log
	CALL_CACHE_FILE("\!GM\functions\fnc_medical.sqf");			// Multiple Functions
	CALL_CACHE_FILE("\!GM\functions\fnc_selfInteractMenu.sqf");	// GM_fnc_selfInteractMenu
	CALL_CACHE_FILE("\!GM\functions\fnc_spawnCrate.sqf");		// GM_fnc_spawnCrate
	
	/********************************************
	*	Initializing
	********************************************/
	[] spawn GM_fnc_initSixMenu;
	//[] spawn GM_fnc_initUODebug;	// For broken GM console
	
	/********************************************
	*	Finalizing Run
	********************************************/
	waitUntil {!isNil "CBA_ui_fnc_add"};
	["player", [ace_sys_interaction_key_self], -999999, ["_this call GM_fnc_selfInteractMenu", "main"]] call CBA_ui_fnc_add;
	
};