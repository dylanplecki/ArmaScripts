class CfgPatches {
	class uo_debugger {
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"cba_main"};
		version = 1.0;
		author[] = {"Crackman"};
	};
};

class Extended_PreInit_EventHandlers {
	uo_debugger_preInit = "call compile preprocessFileLineNumbers 'x\uo\addons\debugger\XEH\XEH_preInit.sqf'";
};

class Extended_PostInit_EventHandlers {
	uo_debugger_postInit = "call compile preprocessFileLineNumbers 'x\uo\addons\debugger\XEH\XEH_postInit.sqf'";
};

#include "resources\RscDisplayDebugUO.dialog"