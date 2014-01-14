/*
	Title: Unit Caching and Distribution Script
	Author: Dylan Plecki (Naught)
	Version: 1.0.2.4
	
	Description:
		An SQF script designed to dynamically cache and distribute AI units
		across machines for maximum performance.
	
	Usage:
		None, script is fully autonomous.
	
	Requirements:
		Arma 2 OA [1.62]
		Arma 3 [any version]
		CBA [any version]
	
	License:
		Copyright © 2013 Dylan Plecki. All rights reserved.
		Except where otherwise noted, this work is licensed under CC BY-NC-ND 4.0,
		available for reference at <http://creativecommons.org/licenses/by-nc-nd/4.0/>.
*/

#include "h\oop.h"

/*
	Group: Definitons
*/

// Don't change this!
UCD_init = false;

#include "config.sqf"

/*
	Group: Macros
*/

#define CHECK_MOD(mod) isClass(configFile >> "CfgMods" >> mod)

/*
	Group: Libraries
*/

#include "lib\arrays.sqf"
#include "lib\hashmaps.sqf"
#include "lib\objects.sqf"
#include "lib\caching.sqf"
#include "lib\distribution.sqf"

/*
	Group: Initialization Finalization
*/

if (isServer) then {
	UCD_serverInit = true;
	publicVariable "UCD_serverInit";
};

UCD_init = true;
