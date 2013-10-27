class CfgPatches {
	class crack_main {
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"cba_main"};
		version = 1.0;
		author[] = {"Crackman"};
	};
};

class Extended_PreInit_EventHandlers {
	crack_main_preInit = "call compile preprocessFileLineNumbers 'x\crack\addons\main\XEH_preInit.sqf'";
};