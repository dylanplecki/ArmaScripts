//     ____   ____       _       ____   _  __        _   _    ___    _____   _____   ____       _      ____  
//    / ___| |  _ \     / \     / ___| | |/ /       | \ | |  / _ \  |_   _| | ____| |  _ \     / \    |  _ \ 
//   | |     | |_) |   / _ \   | |     | ' /        |  \| | | | | |   | |   |  _|   | |_) |   / _ \   | | | |
//   | |___  |  _ <   / ___ \  | |___  | . \        | |\  | | |_| |   | |   | |___  |  __/   / ___ \  | |_| |
//    \____| |_| \_\ /_/   \_\  \____| |_|\_\       |_| \_|  \___/    |_|   |_____| |_|     /_/   \_\ |____/ 
//                                                                                                          
//*********************************************************************************************************************
//
// XEH GLOBAL POST-INITIALIZATION
//
//*********************************************************************************************************************
#include "script_component.hpp"

private ["_handle", "_defaultSides"];

//**********************************************************************************

//------------------------------------ API CODE ------------------------------------

// Prepping Specific API Variables
ISNILS(GVAR(addonEnabled),true);
ISNILS(GVAR(notepadEnabled),true);
ISNILS(GVAR(remindersEnabled),true);
ISNILS(GVAR(calculatorEnabled),true);
ISNILS(GVAR(notepadMPEnabled),true);
ISNILS(GVAR(notepadPages),10);
ISNILS(GVAR(reminderCheckFrequency),10);
ISNILS(GVAR(checkForByteLimit),true);
ISNILS(GVAR(byteLimit),20000);

// ISNILS Macro doesn't work with arrays? Huh.
_defaultSides = [WEST,EAST,RESISTANCE,CIVILIAN,SIDEENEMY];
ISNILS(GVAR(enabledSides),_defaultSides);

//---------------------------------- END API CODE ----------------------------------

//**********************************************************************************

// Include to preserve Macros
#include "XEH_postClientInit.sqf"
#include "XEH_postServerInit.sqf"

// Event Handler Init
_handle = [] execVM "x\crack\addons\notepad\eventHandlerInit.sqf";