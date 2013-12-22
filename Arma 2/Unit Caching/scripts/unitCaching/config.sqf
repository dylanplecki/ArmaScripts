/*
	Title: Script Configuration
	Author: Dylan Plecki (Naught)
	
	License:
		Copyright © 2013 Dylan Plecki. All rights reserved.
		Except where otherwise noted, this work is licensed under CC BY-NC-ND 4.0,
		available for reference at <http://creativecommons.org/licenses/by-nc-nd/4.0/>.
*/

#define GLOBAL_SPAWN_DISTANCE (viewDistance + 250) // Meters
#define CACHE_DISTRIBUTE_AI true // Distribute to HC machines, may break scripts such as UPSMON
#define CACHE_MONITOR_DELAY 15 // Seconds
#define CACHE_VEH_TIMEOUT 30 // Seconds

UCD_cacheList = [ // List is read top-down, stops at first matching type
	// ["typeName", 	cache,	spawnPos,	{spawnDistCode}],
	/* Vehicle Caching is currently experimental, it may not work */
	["LandVehicle",		false,	true,		{GLOBAL_SPAWN_DISTANCE}],
	["Air",				false,	true,		{GLOBAL_SPAWN_DISTANCE}],
	["Ship",			false,	true,		{GLOBAL_SPAWN_DISTANCE}],
	["Man",				true,	false,		{GLOBAL_SPAWN_DISTANCE}],
	/* Special classes for "Man" type units with(in|out) vehicles */
	["Commander",		true,	false,		{GLOBAL_SPAWN_DISTANCE}],
	["Gunner",			true,	false,		{GLOBAL_SPAWN_DISTANCE}],
	["Driver",			false,	false,		{GLOBAL_SPAWN_DISTANCE}], // Recommended not to cache unless also caching vehicle
	["Turret",			true,	false,		{GLOBAL_SPAWN_DISTANCE}],
	["Cargo",			true,	false,		{GLOBAL_SPAWN_DISTANCE}],
	["None",			true,	false,		{GLOBAL_SPAWN_DISTANCE}], // A.K.A units not in vehicles
	["All",				false,	true,		0] // All other objects don't cache
];