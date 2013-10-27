//   _____   _____                _____   _  __        ____    _____    ____               _______ 
//  / ____| |  __ \      /\      / ____| | |/ /       / __ \  |  __ \  |  _ \      /\     |__   __|
// | |      | |__) |    /  \    | |      | ' /       | |  | | | |__) | | |_) |    /  \       | |   
// | |      |  _  /    / /\ \   | |      |  <        | |  | | |  _  /  |  _ <    / /\ \      | |   
// | |____  | | \ \   / ____ \  | |____  | . \       | |__| | | | \ \  | |_) |  / ____ \     | |   
//  \_____| |_|  \_\ /_/    \_\  \_____| |_|\_\       \____/  |_|  \_\ |____/  /_/    \_\    |_|   
//
//*************************************************************************************************
//
// Settings File
//
//*************************************************************************************************

// ORBATS and Loadouts ----------------------------------------------------------------------------
	
	_ORBATS = [ // ORBATS in use in the current mission, check the ORBAT.sqf for the faction for syntax
		//["CRACK_ORBATS_US_ARMY", [1, 1, 2, 2, 0, 0, 1, 1]], // Default US Army ORBAT
		//["CRACK_ORBATS_USMC", [1, 1, 2, 2, 0, 0, 1, 1]], // Default USMC ORBAT
		//["CRACK_ORBATS_SHACKTAC", [1, 1, 2, 2, 0, 0, 1, 1]] // Default ShackTac ORBAT
	];

// Team Roster Script -----------------------------------------------------------------------------
	
	_teamRosterOn = true; // True to turn the Team Roster on, False to turn it off
	
	_cycle_time = 301; // Time between each update of the list in seconds, shorter values provide more accuracy but may decrease FPS and memory, each loop is "Logged" in diary
	_diary_subject = "Team Roster"; // Text to be shown as the subject in the Map Screen, like Notes and Units.
	_arma_group = true; // Toggles whether to show Arma Group ID (ex. B 1-1-A), true is on and false is off (Most useful to turn off when you have already included group in description)
	_end_condition = true; // Condition to end script, it will stop updating the Roster but will keep units already listed, true for always on
	
//-------------------------------------------------------------------------------------------------

















































// Sends settings to parent script, *** DO NOT MODIFY ***
_results = [_ORBATS, [_teamRosterOn,_cycle_time,_diary_subject,_arma_group,_end_condition]];
_results