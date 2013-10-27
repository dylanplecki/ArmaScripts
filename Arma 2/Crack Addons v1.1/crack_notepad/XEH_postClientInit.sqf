//     ____   ____       _       ____   _  __        _   _    ___    _____   _____   ____       _      ____  
//    / ___| |  _ \     / \     / ___| | |/ /       | \ | |  / _ \  |_   _| | ____| |  _ \     / \    |  _ \ 
//   | |     | |_) |   / _ \   | |     | ' /        |  \| | | | | |   | |   |  _|   | |_) |   / _ \   | | | |
//   | |___  |  _ <   / ___ \  | |___  | . \        | |\  | | |_| |   | |   | |___  |  __/   / ___ \  | |_| |
//    \____| |_| \_\ /_/   \_\  \____| |_|\_\       |_| \_|  \___/    |_|   |_____| |_|     /_/   \_\ |____/ 
//                                                                                                          
//*********************************************************************************************************************
//
// XEH CLIENT POST-INITIALIZATION
//
//*********************************************************************************************************************
if (!isdedicated) then {
	
	private ["_selfInteractCode", "_interactCode"];
	
	// Prepping Notepad Variable
	[] call FUNC(clearEntireLocalNotepad);
	
	// Add interact options
	GVAR(codeStringAceSelfInteractMenuDef) = format["_this call %1", QUOTE(FUNC(aceSelfInteractMenuDef))];
	GVAR(codeStringAceInteractMenuDef) = format["_this call crack_notepad_fnc_aceInteractMenuDef", QUOTE(FUNC(aceInteractMenuDef))];
	
	["player", [ace_sys_interaction_key_self], -99999, [GVAR(codeStringAceSelfInteractMenuDef), "main"]] call CBA_ui_fnc_add; // Self-Interact Menu
	
	if (ismultiplayer) then {
		[["Man"], [ace_sys_interaction_key], -99999, [GVAR(codeStringAceInteractMenuDef), "main"]] call CBA_ui_fnc_add; // Interact Menu
	};
	
};