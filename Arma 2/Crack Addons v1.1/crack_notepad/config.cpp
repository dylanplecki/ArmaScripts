class CfgPatches {
	class crack_notepad {
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"cba_main"};
		version = 1.0;
		author[] = {"Crackman"};
	};
};

class Extended_PreInit_EventHandlers {
	crack_notepad_preInit = "call compile preprocessFileLineNumbers 'x\crack\addons\notepad\XEH_preInit.sqf'";
};

class Extended_PostInit_EventHandlers {
	crack_notepad_postInit = "call compile preprocessFileLineNumbers 'x\crack\addons\notepad\XEH_postInit.sqf'";
};

#include "rsc\diag.hpp"