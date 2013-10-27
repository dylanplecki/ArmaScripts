// Team Roster Script v1
//		By Crackman
//
//		You can contact me at dylanplecki@gmail.com
//		Or on the United Operations forums as crackman
//
// Script Description:
// 		This script will make an entry in the map screen that will show all players and their unit's description, so Leaders can now who their subordinates are, vis versa, and so on
// ***********************************************************************************************************************************************
// Notes:
// 		Usage:
//			EVERY PLAYABLE UNIT REQUIRES A NAME. Read Below.
//			The first word BEFORE THE UNDERSCORE ("_") of a Unit's name will act as its description, so a unit with the name "Grenadier_1_4" will have a description of "Grenadier"
//			If "69" appears before the first underscore, it will be turned into a space. So 69 = Space. Ex - "Squad69Leader_1_4" = "Squad Leader"
//			Arma Group Names can be changed by putting this into the leaders INIT field: '(group this) setGroupId ["1'4 Delta","GroupColor0"];' (without beginning and ending apostrophes, 1'4 Delta Squad can be changed)
// 			if (!isdedicated) then {nul = [] execVM "scripts\team_roster.sqf";}; //Add this line into init.sqf
// 
//		Known Issues:
// 			Until BI comes out with a way to delete Diary Entries, this script may take up a little memory (About 300KB Total for 50 players on an hour long mission with standard 61 sec cycle)
// 			Formula for calculating Total Roster Size: Size(In KB) = (Number of players * .1) * (Mission Time / Cycle Time)
// ***********************************************************************************************************************************************