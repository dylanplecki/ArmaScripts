
GM Functions v1.0
	By Naught
	UnitedOperations.Net

/***********************************************/

Install:
	
	1. Put '!GM' folder in Arma main directory (ie. 'C:\Program Files (x86)\Steam\SteamApps\Common\Arma 2 Operation Arrowhead\!GM')

/***********************************************/

Execute In-Mission To Load Functions:

	nul = [] execVM '\!GM\init.sqf';

/***********************************************/

Functions:
	
	["PATH"] call GM_fnc_cacheFile;														// Caches a file statically for the duration of the Arma process
	
	["PlayerName", CODE (, [PARAMS])] call GM_fnc_execOnPlayer;							// Executes code on specified player's machine (params are local)
	["PlayerName", CODE (, [PARAMS])] call GM_fnc_execOnPlayerLocal;					// Executes code on local machine with specified player's object passed via (_this select 0)
	
	[] call GM_fnc_execScratchPad;														// Executes code in the scratchpad.sqf file
	
	["PlayerName", "WeaponName" (, RuckBool)] call GM_fnc_givePlayerWeapon;				// Gives player a specified weapon (optionally in his ruck)
	["PlayerName", "MagName" (, MagCountInt, RuckBool)] call GM_fnc_givePlayerMagazine;	// Gives player (a) specified magazine(s) (optionally in his ruck)
	["PlayerName", "WeaponName"] call GM_fnc_givePlayerWOB;								// Gives player a specified weapon on his back
	
	[] call GM_fnc_spawnCrate;															// Spawns a crate with specified cargo, check function file for specific params
	
	["PlayerName"] call GM_fnc_giveBandage;												// Gives specified player a bandage (instantaneous, no simulation)
	["PlayerName"] call GM_fnc_giveLargeBandage;										// Gives specified player a large bandage (instantaneous, no simulation)
	["PlayerName"] call GM_fnc_giveTourniquet;											// Gives specified player a tourniquet (instantaneous, no simulation)
	["PlayerName"] call GM_fnc_removeTourniquet;										// Removes a tourniquet from the specified player (instantaneous, no simulation)
	["PlayerName"] call GM_fnc_giveMorphine;											// Gives specified player morphine (instantaneous, no simulation)
	["PlayerName"] call GM_fnc_giveEpi;													// Gives specified player epinephrine (instantaneous, no simulation)
	
	[] call GM_fnc_fixEarplugs;															// Fixes Rocko's idiotic coding (putting in earplugs decreases game volume by 60%)
	
/***********************************************/