// =========================================================================================================
//  CTSS - Crackman's Ticket System Script
//  version 1.0.2
//
//  Author: Crackman (dylanplecki@gmail.com) 
//
//	Born on United Operations (unitedoperations.net)
// ---------------------------------------------------------------------------------------------------------
//  v1.0.2
//  	FIXED: Fixed setpos BI bug, now globally executes (Thanks to Kenquinn)
//
//  v1.0.1
//  	NEW: Added ability to change spectator script
//
//  v1.0.0
//  	NEW: Added ability to run user code on respawn
//  	NEW: Allows usage for multiple sides, though not civilian
//  	NEW: Ticket Settings are easier and support Parameters
//  	NEW: Spawn markers are configurable
//  	NEW: Low Usage of Bandwidth by combining variables
//  	NEW: SpecPen marker is configurable
//  	NEW: Uses ace_fnc_startSpectator for compatability and ease-of-use
//  	NEW: Disables usage of script if in singleplayer
//  	NEW: All variables are now global so tickets and other vairables can be changed on-the-fly
// ---------------------------------------------------------------------------------------------------------
//
//	Usage:
//		1. Make a description.ext file in your mission directory if you haven't already
//		2. Add this line to the description.ext file: respawn = "BASE";
//		3. Place down "respawn_west", "respawn_east", "respawn_guerrila", and "respawn_civilian" markers,
//		   preferrably away from the Combat Zone
//		4. Then make markers where you want BLUFOR, OPFOR, and INDEPENDENT to respawn when they have tickets,
//		   the names of each marker can be set below in the parameters
//		5. Now make a marker called "specpen" (can be changed in parameters below) and enclose it somehow
//		   (that's up to you), this is where the spectator's bodies will stay.
//		6. Add the following line to your init.sqf file (If you haven't created one yet do it now):
//		   nul = [] execVM "scripts\CTSS.sqf";
//		7. Set the tickets for each side below in the Parameters section
//		8. Now it's all set up! If you wish to make more advanced tweaks, like adding a loadout script
//		   on respawn or using the description.ext parameters to set ticket counts, look below and
//		   mess with the parameters.
//
// ---------------------------------------------------------------------------------------------------------
//
//	Normal Syntax:
//		nul = [] execVM "scripts\CTSS.sqf";
//		(put in init.sqf, all clients + server have to run it)
//
// ---------------------------------------------------------------------------------------------------------
//
//	NOTE:	RespawnCode uses SPAWN to execute code and passes _unit via (_this select 0).
//			Setting to "nul"; will not run any code. Can be used as multi-line code.
//			Variables such as CRACK_ticketsgone, CRACK_casualties, CRACK_tickets,
//			CRACK_bases, CRACK_specpens, and CRACK_sidenumber can be used,
//			but SHOULD NOT BE CHANGED, as it may break the script.
//			User Code should be kept to a minimum, as it calls
//			via a PublicVariable. Functions should be used.
//			User Code is run local to each player.
//
//			Passed Array: [unit, tickets_left, spawn_point]
//
// ***********************************************************************************************************

// ========================================================
// ====================== Parameters ======================
// ========================================================

_WEST_tickets 				= 20; // Number of tickets for the RESISTANCE side, can be set via parameters using "paramsArray select 0" when value is set in params
_EAST_tickets 				= 20; // Number of tickets for the RESISTANCE side, can be set via parameters using "paramsArray select 1" when value is set in params
_RESISTANCE_tickets 		= 20; // Number of tickets for the RESISTANCE side, can be set via parameters using "paramsArray select 2" when value is set in params

_WEST_base	 				= "blufor_base"; // Name of WEST's Base Marker, where units will be teleported to after normal spawn at RESPAWN_WEST marker
_EAST_base					= "opfor_base"; // Name of EAST's Base Marker, where units will be teleported to after normal spawn at RESPAWN_EAST marker
_RESISTANCE_base 			= "ind_base"; // Name of RESISTANCE's Base Marker, where units will be teleported to after normal spawn at RESPAWN_RESISTANCE marker

_WEST_specpen				= "specpen"; // Name of WEST's SpecPen Marker, should all be set to the same marker for ACRE Direct Chat purposes
_EAST_specpen				= "specpen"; // Name of EAST's SpecPen Marker, should all be set to the same marker for ACRE Direct Chat purposes
_RESISTANCE_specpen			= "specpen"; // Name of RESISTANCE's SpecPen Marker, should all be set to the same marker for ACRE Direct Chat purposes

_WEST_respawncode			= "nul"; // Code to run on a WEST player's respawn, such as loadout scripts. Should be a function. Default: "nul"
_EAST_respawncode			= "nul"; // Code to run on an EAST player's respawn, such as loadout scripts. Should be a function. Default: "nul"
_RESISTANCE_respawncode		= "nul"; // Code to run on a RESISTANCE player's respawn, such as loadout scripts. Should be a function. Default: "nul"

_WEST_maxdeaths				= 0; // Maximum amount of deaths that can be sustained before WEST loses the game, set to 0 to not end game after x deaths, default 0
_EAST_maxdeaths				= 0; // Maximum amount of deaths that can be sustained before EAST loses the game, set to 0 to not end game after x deaths, default 0
_RESISTANCE_maxdeaths		= 0; // Maximum amount of deaths that can be sustained before RESISTANCE loses the game, set to 0 to not end game after x deaths, default 0

waituntil {!isnil "ace_fnc_startSpectator"}; // Makes sure that the spectator function is loaded before script continues, MUST BE THE SAME VALUE AS CRACK_spectator BELOW
CRACK_spectator				= ace_fnc_startSpectator; // Spectator script to run on death with no more tickets, should be a function, default ace_fnc_startSpectator

// ***********************************************************************************************************
// Server
if (isserver) then {
    // Setting Variables in form of [WEST,EAST,RESISTANCE]
    CRACK_ticketsgone = [false,false,false];
    CRACK_casualties = [0,0,0];
    CRACK_tickets = [_WEST_tickets,_EAST_tickets,_RESISTANCE_tickets];
    CRACK_bases = [_WEST_base,_EAST_base,_RESISTANCE_base];
    CRACK_specpens = [_WEST_specpen,_EAST_specpen,_RESISTANCE_specpen];
    CRACK_respawncode = [_WEST_respawncode,_EAST_respawncode,_RESISTANCE_respawncode];
	CRACK_maxdeaths = [_WEST_maxdeaths,_EAST_maxdeaths,_RESISTANCE_maxdeaths];
    
    // Setting all to public variables
    publicvariable "CRACK_ticketsgone";
    publicvariable "CRACK_casualties";
    publicvariable "CRACK_tickets";
    publicvariable "CRACK_bases";
    publicvariable "CRACK_specpens";
    publicvariable "CRACK_respawncode";
	publicvariable "CRACK_maxdeaths";
};

// Players
if (!isserver) then {
	// Waituntil all variables are recieved
	waituntil {!isnil "CRACK_ticketsgone" AND !isnil "CRACK_casualties" AND !isnil "CRACK_tickets" AND !isnil "CRACK_bases" AND !isnil "CRACK_specpens" AND !isnil "CRACK_respawncode" AND !isnil "CRACK_maxdeaths"};
	
	// Add MPRespawn Event Handler to launch ticket system
	player addMPEventHandler ["MPRespawn",{if (player == (_this select 0)) then {_this spawn CRACK_fnc_respawn;};}];
    
    // Getting player side
	CRACK_side = side player;
    
    // Setting Side Index Number
    switch (CRACK_side) do {
        case WEST: {CRACK_sidenumber = 0;};
	    case EAST: {CRACK_sidenumber = 1;};
	    case RESISTANCE: {CRACK_sidenumber = 2;};
    };
	
	CRACK_fnc_respawn = {
	    // Casualty Count
        _value = (CRACK_casualties select CRACK_sidenumber) + 1;
	    CRACK_casualties set [CRACK_sidenumber,_value];
        publicvariable "CRACK_casualties";
		
	    // Checking Ticket Count
        _ticketcount = (CRACK_tickets select CRACK_sidenumber);
		if (_ticketcount > 0) then
		{
	        // Subtracting ticket
			_ticketvalue = _ticketcount - 1;
            CRACK_tickets set [CRACK_sidenumber,_ticketvalue];
			publicVariable "CRACK_tickets";
		    
	        // Move to base
            _spawnpoint = CRACK_bases select CRACK_sidenumber;
			[-2, {(_this select 0) setpos (getmarkerpos (_this select 1));}, [player,_spawnpoint]] call CBA_fnc_globalExecute;
            
            // Execute User Code (If any)
	        _respawncode = CRACK_respawncode select CRACK_sidenumber;
            _nocode = "nul";
            if (_respawncode != _nocode) then {
                [player,_value,_spawnpoint] spawn compile _respawncode;
            };
		    
	        // Make sure eveyone knows ticket count
			[-1, {[_this select 0] spawn CRACK_fnc_ticketcounter;}, [CRACK_side]] call CBA_fnc_globalExecute;
		}
		else
		{
	        // Moving player to Spectator Pen
            _specpen = CRACK_specpens select CRACK_sidenumber;
			player setPos (getmarkerpos _specpen);
			
			// Removing All Weapons and leave group
			removeAllWeapons player;
			removeAllItems player;
			[player] join grpNull;
	        
		    // Starting Spectator
	        [] spawn CRACK_spectator;
	        
	        // Tickets Exhausted Hint
            _ticketsgone = CRACK_ticketsgone select CRACK_sidenumber;
	        if (!_ticketsgone) then {
	            // Make sure eveyone knows tickets are gone
	            [-1, {[_this select 0] spawn CRACK_fnc_ticketsgone;}, [CRACK_side]] call CBA_fnc_globalExecute;
                
                // Setting Tickets Gone Variable
                CRACK_ticketsgone set [CRACK_sidenumber,true];
                publicvariable "CRACK_ticketsgone";
			};
		};
		
		// Checking to see if Max Deaths have occured
		if ((CRACK_maxdeaths select CRACK_sidenumber) != 0 AND (CRACK_casualties select CRACK_sidenumber) > (CRACK_maxdeaths select CRACK_sidenumber)) then {
			// Then Execute End Script
			[-2, {[_this select 0] spawn CRACK_fnc_endgame;}, [CRACK_side]] call CBA_fnc_globalExecute;
		};
	};
	
	CRACK_fnc_ticketcounter = {
	    _side = _this select 0;
	    if (_side == CRACK_side) then {
            _tickets = CRACK_tickets select CRACK_sidenumber;
	        hintsilent format["%1 Tickets Left",_tickets];
	    };
	};
	
	CRACK_fnc_ticketsgone = {
	    _side = _this select 0;
	    if (_side == CRACK_side) then {
	        hint "Tickets Exhausted";
	    };
	};
	
	CRACK_fnc_endgame = {
		if (isserver) then {
			sleep 10;
			endMission "END1";
			forceEnd;
		} else {
			_loser = _this select 0;
			_cam = "CAMERA" CamCreate [0,0,0];
			_cam CameraEffect ["INTERNAL","BACK"];
			_cam CamSetTarget player;
			_ox = GetPos player Select 0;
			_oy = GetPos player Select 1;
			_oz = GetPos player Select 2;
			_cam CamSetPos [_ox,_oy,(_oz + 5)];
			_cam CamCommit 0;
			_mission_time = round(time / 60);
			_people_killed = "";
			if (((CRACK_casualties select 0) + (CRACK_casualties select 1) + (CRACK_casualties select 2)) != 0) then {
				if ((CRACK_casualties select 0) != 0) then {_people_killed = _people_killed + (format["\n\nBlufor Players Killed: %1",(CRACK_casualties select 0)]);};
				if ((CRACK_casualties select 1) != 0) then {_people_killed = _people_killed + (format["\n\nOpfor Players Killed: %1",(CRACK_casualties select 1)]);};
				if ((CRACK_casualties select 2) != 0) then {_people_killed = _people_killed + (format["\n\nIndependent Players Killed: %1",(CRACK_casualties select 2)])};
			} else {
				_people_killed = "\n\nNo players were killed in this mission";
			};
			_text = format["%1 has suffered too many casualties\n\nMission Time: %2 minutes%3",_loser,_mission_time,_people_killed];
			cutText[_text,"BLACK FADED"];
			sleep 2;
			cutText[_text,"BLACK FADED"];
			sleep 2;
			cutText[_text,"BLACK FADED"];
			sleep 2;
			cutText[_text,"BLACK FADED"];
			sleep 2;
			cutText[_text,"BLACK FADED"];
			sleep 2;
			endMission "END1";
			forceEnd;
		};
	};
};