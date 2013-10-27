//     ____   ____       _       ____   _  __        _   _    ___    _____   _____   ____       _      ____  
//    / ___| |  _ \     / \     / ___| | |/ /       | \ | |  / _ \  |_   _| | ____| |  _ \     / \    |  _ \ 
//   | |     | |_) |   / _ \   | |     | ' /        |  \| | | | | |   | |   |  _|   | |_) |   / _ \   | | | |
//   | |___  |  _ <   / ___ \  | |___  | . \        | |\  | | |_| |   | |   | |___  |  __/   / ___ \  | |_| |
//    \____| |_| \_\ /_/   \_\  \____| |_|\_\       |_| \_|  \___/    |_|   |_____| |_|     /_/   \_\ |____/ 
//                                                                                                          
//*********************************************************************************************************************
//
// EVENT-HANDLER INIT
//
//*********************************************************************************************************************
#include "script_component.hpp"

if (ismultiplayer) then {
	
	//-------------------------------------------
	
	if (!isdedicated) then {
		
		waituntil {!isnull player};
		GVAR(playerMPEHKilledIndex) = player addMPEventHandler ["mpkilled", {_this spawn FUNC(onPlayerDeath);}];
		
		waituntil {!isnil QUOTE(GVAR(synDataVar));};
		waituntil {!isnil QUOTE(GVAR(ackDataVar));};
		
	};
	
	//-------------------------------------------
	
	QUOTE(GVAR(synDataVar)) addPublicVariableEventHandler {(_this select 1) spawn FUNC(sendLocalVariable);};
	
	QUOTE(GVAR(ackDataVar)) addPublicVariableEventHandler {(_this select 1) spawn FUNC(recieveRemoteVariable);};
	
};