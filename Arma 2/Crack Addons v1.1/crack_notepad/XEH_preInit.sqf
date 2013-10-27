//     ____   ____       _       ____   _  __        _   _    ___    _____   _____   ____       _      ____  
//    / ___| |  _ \     / \     / ___| | |/ /       | \ | |  / _ \  |_   _| | ____| |  _ \     / \    |  _ \ 
//   | |     | |_) |   / _ \   | |     | ' /        |  \| | | | | |   | |   |  _|   | |_) |   / _ \   | | | |
//   | |___  |  _ <   / ___ \  | |___  | . \        | |\  | | |_| |   | |   | |___  |  __/   / ___ \  | |_| |
//    \____| |_| \_\ /_/   \_\  \____| |_|\_\       |_| \_|  \___/    |_|   |_____| |_|     /_/   \_\ |____/ 
//                                                                                                          
//*********************************************************************************************************************
//
// XEH GLOBAL PRE-INITIALIZATION
//
//*********************************************************************************************************************
#include "script_component.hpp"

//**********************************************************************************

//------------------------------------ BASE CODE -----------------------------------

// Base Global Functions
PREPFUNC(sendLocalVariable);
PREPFUNC(recieveRemoteVariable);
PREPFUNC(createEmptyStrings);
PREPFUNC(filterDataByType);
PREPFUNC(limitTextSize);

// Base Global Variables
GVAR(notepadContents) = [];
GVAR(notepadStartLine) = 6;
GVAR(notepadEndLine) = 26;
GVAR(notepadLB) = [];
GVAR(notepadInUse) = false;
GVAR(remindersShown) = true;
GVAR(currentPageIndex) = 0;
GVAR(reminderCache) = [];
GVAR(currentCopyTarget) = objnull;

//---------------------------------- END BASE CODE ---------------------------------

//**********************************************************************************

//------------------------------------ API CODE ------------------------------------

// API Modules List
GVAR(modules) = [
	["Addon", QUOTE(GVAR(addonEnabled))],
	["Notepad", QUOTE(GVAR(notepadEnabled))],
	["NotepadMP", QUOTE(GVAR(notepadMPEnabled))],
	["Reminders", QUOTE(GVAR(remindersEnabled))],
	["Calculator", QUOTE(GVAR(calculatorEnabled))]
];

// Prepping API Functions
PREPAPI(canPlayerUseNotepad);
PREPAPI(createNewReminder);
PREPAPI(deleteReminder);
PREPAPI(clearEntireLocalNotepad);
PREPAPI(clearNotepadPage);
PREPAPI(enableModule);
PREPAPI(setAllowedSides);
PREPAPI(setAllowedUnits);
PREPAPI(setNumberOfPages);
PREPAPI(setNotepadPageContent);
PREPAPI(setReminderCheckFrequency);
PREPAPI(getNotepadContents);
PREPAPI(getNotepadPageContents);
PREPAPI(getAllowedSides);
PREPAPI(getAllowedUnits);
PREPAPI(getAllReminders);
PREPAPI(getReminderHandle);
PREPAPI(dialogsInUse);
PREPAPI(notepadExternalAccessEnabled);
PREPAPI(moduleEnabled);
PREPAPI(reminderHintsEnabled);
PREPAPI(getByteLimit);
PREPAPI(setByteLimit);
PREPAPI(setCheckForByteLimit);
PREPAPI(checkForByteLimit);

/*
API: Functions
	
	// Set Commands -------------------
	_success = [_module, _enable] call crack_notepad_fnc_enableModule; // LOCAL, SET COMMAND
	
	_success = [_byteLimit] call crack_notepad_fnc_setByteLimit; // LOCAL, SET COMMAND
	_success = [_boolean] call crack_notepad_fnc_setCheckForByteLimit; // LOCAL, SET COMMAND
	
	_success = [EAST, WEST, ...] call crack_notepad_fnc_setAllowedSides; // GLOBAL, SET COMMAND
	_success = [Player1, Player2, ...] call crack_notepad_fnc_setAllowedUnits; // GLOBAL, SET COMMAND
	_success = [_numberOfPages] call crack_notepad_fnc_setNumberOfPages; // LOCAL, SET COMMAND
	_pageIndex = [_pageIndex, "Title", ["Line 1", "Line 2", ...]] call crack_notepad_fnc_setNotepadPageContent; // LOCAL, SET COMMAND
	_success = [] call crack_notepad_fnc_clearEntireLocalNotepad; // LOCAL, SET COMMAND
	_success = [_pageIndex] call crack_notepad_fnc_clearNotepadPage; // LOCAL, SET COMMAND
	
	_success = [_freqInSec] call crack_notepad_fnc_setReminderCheckFrequency; // LOCAL, SET COMMAND
	_reminderTitle = ["Title", "HintText", _timerInSec] call crack_notepad_fnc_createNewReminder; // LOCAL, SET COMMAND
	_success = [_reminderIndex] call crack_notepad_fnc_deleteReminder; // LOCAL, SET COMMAND
	
	// Get Commands -------------------
	_array = [] call crack_notepad_fnc_getNotepadContents; // LOCAL, GET COMMAND
	_array = [_pageIndex OR "Page Title"] call crack_notepad_fnc_getNotepadPageContents; // LOCAL, GET COMMAND
	
	_array = [] call crack_notepad_fnc_getAllowedSides; // LOCAL, GET COMMAND
	_array = [] call crack_notepad_fnc_getAllowedUnits; // LOCAL, GET COMMAND
	
	_array = [] call crack_notepad_fnc_getAllReminders; // LOCAL, GET COMMAND
	_array = [_reminderTitle] call crack_notepad_fnc_getReminderHandle; // LOCAL, GET COMMAND
	
	_byteLimit = [] call crack_notepad_fnc_getByteLimit; // LOCAL, GET COMMAND
	
	// Checks -------------------------
	_boolean = [_module] call crack_notepad_fnc_moduleEnabled; // LOCAL, CHECK
	
	_boolean = [] call crack_notepad_fnc_dialogsInUse; // LOCAL, CHECK
	_boolean = [] call crack_notepad_fnc_checkForByteLimit; // LOCAL, CHECK
	
	_boolean = [] call crack_notepad_fnc_canPlayerUseNotepad; // LOCAL, CHECK
	_boolean = [] call crack_notepad_fnc_notepadExternalAccessEnabled; // LOCAL, CHECK
	
	_boolean = [] call crack_notepad_fnc_reminderHintsEnabled; // LOCAL, CHECK
	
*/

//---------------------------------- END API CODE ----------------------------------

//**********************************************************************************

//---------------------------------- SERVER CODE -----------------------------------

if (isserver) then {
	
	// Nothing yet
	
};

//-------------------------------- END SERVER CODE ---------------------------------

//**********************************************************************************

//---------------------------------- CLIENT CODE -----------------------------------

if (!isdedicated) then {
	
	// Functions
	PREPFUNC(aceInteractMenuDef);
	PREPFUNC(aceSelfInteractMenuDef);
	PREPFUNC(calculatorGUI);
	PREPFUNC(notepadGUI);
	PREPFUNC(onPlayerDeath);
	PREPFUNC(reminderGUI);
	PREPFUNC(requestRemoteVariable);
	PREPFUNC(searchForFunc);
	
};

//-------------------------------- END CLIENT CODE ---------------------------------

//**********************************************************************************

//----------------------------------- TEST CODE ------------------------------------

PREPTEST(transferTest);

//--------------------------------- END TEST CODE ----------------------------------

//**********************************************************************************