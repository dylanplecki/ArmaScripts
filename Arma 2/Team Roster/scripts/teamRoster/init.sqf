//		 _______                        _____              _              
//		|__   __|                      |  __ \            | |             
// 		  | |  ___   __ _  _ __ ___   | |__) | ___   ___ | |_  ___  _ __ 
// 		  | | / _ \ / _` || '_ ` _ \  |  _  / / _ \ / __|| __|/ _ \| '__|
// 		  | ||  __/| (_| || | | | | | | | \ \| (_) |\__ \| |_|  __/| |   
// 		  |_| \___| \__,_||_| |_| |_| |_|  \_\\___/ |___/ \__|\___||_|   
//
//                    					v2 - By Crackman
//			 								 	dylanplecki@gmail.com
//			 								 	UnitedOperations.net
//
//***********************************************************************************************************************************************
//
// 	Script Description:
// 			This script will make an entry in the map screen that will show all players and their unit's description, so Leaders can now who
//			their subordinates are, vis versa, and so on.
//
//***********************************************************************************************************************************************
//
//	Notes:
//
//----------------------------------------------------------------------
//
// 		Usage:
//
//			- EVERY PLAYABLE UNIT REQUIRES A NAME. Read Below.
//
//			- The text BEFORE THE UNDERSCORE ("_", can be changed in the parameters file) of a unit's name will act as its description, so a
//			  unit with the name "Grenadier_1_4" will have a description of "Grenadier"
//
//			- If "69" appears before the first underscore, it will be turned into a space. So 69 = Space
//					Example - "Squad69Leader_1_4" = "Squad Leader"
//					Note: The "Space" character can be changed in the parameters file
//
//			- Arma Group Names can be changed by putting this into the leaders INIT field: '(group this) setGroupId ["1'4 Delta","GroupColor0"];'
//			  (without beginning and ending apostrophes, 1'4 Delta Squad can be changed)
//
// 			- Add this next line of code to your init.sqf:
//					nul = [] execVM "scripts\teamRoster\init.sqf"; //Add this line into init.sqf
//
//----------------------------------------------------------------------
//
//		Known Issues:
// 			Until BI comes out with a way to delete Diary Entries, this script may take up a little memory (About 60KB Total for 50 players on an hour long mission with standard 300 sec cycle)
// 			Formula for calculating Total Roster Size: Size(In KB) = (Number of players * .1) * (Mission Time / Cycle Time)
//
//***********************************************************************************************************************************************
// Clients only for now, may change later

if (isDedicated) exitWith {};

//***********************************************************************************************************************************************
// Loading Some Macros and Definitions

#include "f\defines.hpp"

//***********************************************************************************************************************************************
// Privatizing Some Variables

private ["_result", "_handle", "_index"];

//***********************************************************************************************************************************************
// Getting Parameters

call compile preProcessFileLineNumbers GETSCRIPTPATHQ(parameters.sqf);
	
//***********************************************************************************************************************************************
// Prepping Functions

PREPFUNC(abbreviateRank);
PREPFUNC(getPlayerEntry);

//***********************************************************************************************************************************************
// Script

if (!isDedicated) then {
	
	waitUntil {!isNull player};
	
	// Add Diary Subject
	if (!(player diarySubjectExists "roster")) then
	{
		_index = player createDiarySubject ["roster", GETPARAM(3)];
	};
	
	_handle = [] execVM GETSCRIPTPATHQ(loop.sqf);
	
};

//***********************************************************************************************************************************************