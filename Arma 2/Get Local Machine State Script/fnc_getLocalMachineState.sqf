//
//	Get Local Machine State
//		
//			By Crackman
//				dylanplecki@gmail.com
//				UnitedOperations.net
//
//
//***********************************************
/*
	// VARIABLE SYNTAX --------------------------
	
	currentLocalMachineState = [
		_isClient, // (currentLocalMachineState select 0)
		_isPlayer, // (currentLocalMachineState select 1)
		_isJIP, // (currentLocalMachineState select 2), use _afterMissionStartJIP to detect real JIP's
		_afterMissionStartJIP, // (currentLocalMachineState select 3), doesn't include players who JIP'd in during the briefing
		_isHeadlessClient, // (currentLocalMachineState select 4), uses hasInterface to detect
		_isServer, // (currentLocalMachineState select 5)
		_isDedicated, // (currentLocalMachineState select 6)
		_mainAIHandler, // (currentLocalMachineState select 7), either HC or Server
		_canHandlerAI // (currentLocalMachineState select 8), if HC or Server then = true
	];
	
	// END VARIABLE SYNTAX ----------------------
*/
//***********************************************
// Setup

private ["_state", "_glms_fnc_changeHC"];

// FUNCTIONS ------------------------------------

_glms_fnc_changeHC = {
	currentLocalMachineState set [7, (_this select 1)];
};

// END FUNCTIONS --------------------------------

// VARIABLES ------------------------------------

currentLocalMachineState = nil;

_state = [];
for "_i" from 0 to 8 do {
	_state set [_i, false];
};

// END VARIABLES --------------------------------

//***********************************************
// Script

if (!isdedicated) then { // CLIENT
	
	_state set [0, true];
	
	if (hasInterface) then { // PLAYER
		
		_state set [1, true];
		
		if (isNull player) then { // JIP
			
			_state set [2, true];
			
			if (time > 1) then { // AFTER MISSION START JIP
				_state set [3, true];
			};
		};
	};
	
	if (!hasInterface) then { // HEADLESS CLIENT
		
		_state set [4, true];
		_state set [7, true];
		
		CRACK_glms_hcEnabled = true;
		publicVariable "CRACK_glms_hcEnabled";
	};
};

if (isServer) then { // SERVER
	
	_state set [5, true];
	
	if (!isNil "CRACK_glms_hcEnabled") then {
		_state set [7, (!CRACK_glms_hcEnabled)];
	} else { // MAIN AI HANDLER
		_state set [7, true];
	};
	
	"CRACK_glms_hcEnabled" addPublicVariableEventHandler _glms_fnc_changeHC;
	
	if (isDedicated) then { // DEDICATED SERVER
		_state set [6, true];
	};
	
};

if ((_state select 5) OR (_state select 4)) then { // CAN HANDLE AI
	_state set [8, true];
};

currentLocalMachineState = _state;

currentLocalMachineState