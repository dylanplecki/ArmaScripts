/*
	Title: Unit Caching and Distribution Script
	Author: Dylan Plecki (Naught)
	
	Description:
		An SQF script designed to dynamically cache and distribute AI units
		across machines for maximum performance.
	
	Usage:
		None, script is fully autonomous.
	
	License:
		Copyright © 2013 Dylan Plecki. All rights reserved.
		Except where otherwise noted, this work is licensed under CC BY-NC-ND 4.0,
		available for reference at <http://creativecommons.org/licenses/by-nc-nd/4.0/>.
*/

#include "h\oop.h"

/*
	Group: Definitons & Settings
*/

// Don't change this!
UCD_init = false;

// These definitions rarely ever change
#define GLOBAL_SPAWN_DISTANCE {viewDistance + 250}
#define CACHE_MONITOR_DELAY 15 // Seconds

// Vehicle Caching is currently experimental
#define CACHE_VEH_TIMEOUT 30 // seconds
#define CACHE_VEH_COMMANDER true
#define CACHE_VEH_GUNNER true
#define CACHE_VEH_DRIVER false // Recommended false unless caching vehicle
#define CACHE_VEH_TURRET true
#define CACHE_VEH_CARGO true
#define CACHE_VEH_NONE true // Cache units not in vehicles

// This definiton is completely user configurable
UCD_cacheList = [ // List is read top-down, stops at first matching type
	// ["typeName", 	cache,	spawnPos,	{spawnDistCode}],
	["LandVehicle",		false,	true,		GLOBAL_SPAWN_DISTANCE],
	["Air",				false,	true,		GLOBAL_SPAWN_DISTANCE],
	["Ship",			false,	true,		GLOBAL_SPAWN_DISTANCE],
	["Man",				true,	false,		GLOBAL_SPAWN_DISTANCE],
	["All",				false,	true,		0] // All other objects don't cache
];

/*
	Group: Macros
*/

#define CHECK_MOD(mod) isClass(configFile >> "CfgMods" >> mod)

/*
	Group: Libraries
*/

#include "lib\arrays.sqf"
#include "lib\caching.sqf"
#include "lib\hashmaps.sqf"
#include "lib\objects.sqf"

// Finalize script load
UCD_init = true;