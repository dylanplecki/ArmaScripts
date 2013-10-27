// nul = [] execVM "scripts\heloDropSmoke\init.sqf"

#define QUOTE(var1) #var1
#define SCRIPTPATH(var1) QUOTE(scripts\heloDropSmoke\var1)

scriptName SCRIPTPATH(init.sqf);

private ["_return"];

_return = false;

if (!isDedicated) then {
	
	//------------------
	// Some Settings Here
	
	CRACK_heloDS_usability = 2; // 0 - Pilot Only, 1 - CoPilot/Crew Only, 2 - Both Pilot and CoPilot/Crew
	
	CRACK_heloDS_vehType = "AH6_Base_EP1"; // DEFAULT: "AH6_Base_EP1"
	
	CRACK_heloDS_heloDropPos = [0,0,-1.5]; // DEFAULT: [0,0,-1.5]
	
	CRACK_heloDS_smokes = [ // ["SmokeName", "AmmoName", "#RGBCLR", _numberPerAircraft]
		["White Smoke", "SmokeShell", "#ffffff", 50],
		["Yellow Smoke", "SmokeShellYellow", "#ffff00", 50],
		["Orange Smoke", "SmokeShellOrange", "#ffa500", 50],
		["Red Smoke", "SmokeShellRed", "#ff0000", 50],
		["Green Smoke", "SmokeShellGreen", "#00ff00", 50],
		["Blue Smoke", "SmokeShellBlue", "#0000ff", 50],
		["Purple Smoke", "SmokeShellPurple", "#a020f0", 50]
		//["Frag Grenade", "GrenadeHand", "#7b8165", 50]
	];
	
	//------------------
	
	CRACK_fnc_heloDS_dropSmoke = compile preProcessFileLineNumbers SCRIPTPATH(f\fnc_dropSmoke.sqf);
	CRACK_fnc_heloDS_getSmokesLeft = compile preProcessFileLineNumbers SCRIPTPATH(f\fnc_getSmokesLeft.sqf);
	CRACK_fnc_heloDS_selfInteract = compile preProcessFileLineNumbers SCRIPTPATH(f\fnc_selfInteract.sqf);
	
	//------------------
	
	waitUntil {!isNull player};
	
	["player", [ace_sys_interaction_key_self], 99999, ["_this call CRACK_fnc_heloDS_selfInteract;", "main"]] call CBA_ui_fnc_add;
	
};

_return