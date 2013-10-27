// [_call, [_args]] spawn crack_notepad_fnc_reminderGUI;

#include "\x\crack\addons\notepad\script_component.hpp"

private ["_call", "_index", "_args", "_title", "_timerMinutes", "_text", "_result"];

_call = _this select 0;
_args = if (count _this > 1) then {_this select 1} else {[]};

// Reminder GUI Operations
switch (_call) do {

	//-----------------------------------------------------------------------------------
	// 0 - Opening Main Reminders Dialog - [0] call FUNC(reminderGUI);
	
	case 0: {
		
		// Just create yes/no dialog
		createDialog "CRACK_reminders_diag_main";
	};
	
	//-----------------------------------------------------------------------------------
	// 1 - Opening Create Reminder Dialog - [1] call crack_notepad_fnc_reminderGUI;
	
	case 1: {
		
		closeDialog 80529;
		
		createDialog "CRACK_reminders_diag_new_reminder";
		
		_index = (count GVAR(reminderCache)) + 1;
		
		_text = format ["Reminder %1", _index];
		
		ctrlSetText [3, _text];
	};
	
	//-----------------------------------------------------------------------------------
	// 2 - Opening Delete Reminder Dialog - [2] call crack_notepad_fnc_reminderGUI;
	
	case 2: {
		
		closeDialog 80529;
		
		createDialog "CRACK_reminders_diag_delete_reminder";
		
		[6] call FUNC(reminderGUI); // Populate LB
	};
	
	//-----------------------------------------------------------------------------------
	// 3 - Create New Reminder - [3] call crack_notepad_fnc_reminderGUI;
	
	case 3: {
		
		_title = ctrlText 3;
		_timerMinutes = parseNumber (ctrlText 6);
		_text = ctrlText 7;
		
		if (_title == "") exitwith {hint "Reminder Title field is empty!"};
		if ((typeName (_timerMinutes) != typeName (2)) OR (_timerMinutes <= 0)) exitwith {hint "The timer field only accepts positive non-zero numbers!"};
		if (_text == "") exitwith {hint "Reminder Text field is empty!"};
		
		_result = false;
		for "_i" from 0 to (count GVAR(reminderCache) - 1) do {
			if (((GVAR(reminderCache) select _i) select 0) == _title) exitwith {_result = true;};
		};
		if (_result) exitwith {hint "Reminder Title has already been used!"};
		
		[_title, (_timerMinutes * 60), _text] call FUNC(createNewReminder);
		
		hintsilent "Reminder Created";
	};
	
	//-----------------------------------------------------------------------------------
	// 4 - Clear Reminder Dialog - [4] call crack_notepad_fnc_reminderGUI;
	
	case 4: {
		
		ctrlSetText [3, ""];
		ctrlSetText [6, ""];
		ctrlSetText [7, ""];
	};
	
	//-----------------------------------------------------------------------------------
	// 5 - Delete Reminder - [5] call crack_notepad_fnc_reminderGUI;
	
	case 5: {
		_title = lbText [1, (lbCurSel 1)];
		
		if (_title != "") then {
			
			_result = [_title] call FUNC(deleteReminder);
			
			lbClear 1;
			
			[6] call FUNC(reminderGUI); // Re-populate LB

			hintsilent "Reminder has been deleted";
		};
	};
	
	//-----------------------------------------------------------------------------------
	// 6 - Populate Delete Reminder LB - [6] call FUNC(reminderGUI);
	
	case 6: {
		
		{
			_index = lbAdd [1, (_x select 0)];
		} foreach GVAR(reminderCache);
	};
	
	//-----------------------------------------------------------------------------------
};