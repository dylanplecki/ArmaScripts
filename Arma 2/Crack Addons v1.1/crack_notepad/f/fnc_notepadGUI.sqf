// [_call, [_args]] spawn crack_notepad_fnc_notepadGUI;

#include "\x\crack\addons\notepad\script_component.hpp"

private ["_call", "_index", "_args", "_contents", "_strings", "_string", "_pagename", "_titleFrom", "_titleTo"];

_call = _this select 0;
_args = if (count _this > 1) then {_this select 1} else {[]};

// Notepad GUI Operations
switch (_call) do {

	//-----------------------------------------------------------------------------------
	// 0 - Opening Notepad - [0] call FUNC(notepadGUI);
	
	case 0: {
		
		createDialog "CRACK_notepad_diag_main";
		
		[1] call FUNC(notepadGUI); // Populate LB
		
		_index = if (GVAR(currentPageIndex) >= GVAR(notepadPages)) then {(GVAR(notepadPages) - 1)} else {GVAR(currentPageIndex)};
		
		lbSetCurSel [1, _index];
		
		[2, [lbCurSel 1]] call FUNC(notepadGUI); // Change Notepad Page
	};
	
	//-----------------------------------------------------------------------------------
	// 1 - Populate Listbox - [1] spawn crack_notepad_fnc_notepadGUI;
	
	case 1: {
		
		for "_i" from 0 to ((count GVAR(notepadContents)) - 1) do {
			_index = lbAdd [1,((GVAR(notepadContents) select _i) select 0)];
		};
	};
	
	//-----------------------------------------------------------------------------------
	// 2 - Changing Notepad Page - [2, [_index]] spawn crack_notepad_fnc_notepadGUI;
	
	case 2: {
		
		_index = _args select 0;
		_contents = GVAR(notepadContents) select _index;
		_strings = _contents select 1;
		ctrlSetText [3, (_contents select 0)];

		for "_i" from GVAR(notepadStartLine) to GVAR(notepadEndLine) do { // Each line of Notepad Page
			ctrlSetText [_i, (_strings select (_i - 6))];
		};

		GVAR(currentPageIndex) = _index;
	};
	
	//-----------------------------------------------------------------------------------
	// 3 - Saving Notepad - [3] spawn crack_notepad_fnc_notepadGUI;
	
	case 3: {
		
		_pagename = ctrlText 3;
		_strings = [];

		for "_i" from GVAR(notepadStartLine) to GVAR(notepadEndLine) do { // Each line of Notepad Page
			_strings = _strings + [ctrlText _i];
		};
		
		lbClear 1;

		GVAR(notepadContents) set [GVAR(currentPageIndex), [_pagename, _strings]];
		
		[1] call FUNC(notepadGUI); // Populate LB
	};
	
	//-----------------------------------------------------------------------------------
	// 4 - Clearing Notepad - [4] spawn crack_notepad_fnc_notepadGUI;
	
	case 4: {
		
		_strings = [];
		
		ctrlSetText [3, (format ["Page %1", (GVAR(currentPageIndex) + 1)])];
		
		for "_i" from GVAR(notepadStartLine) to GVAR(notepadEndLine) do { // Each line of Notepad Page
			ctrlSetText [_i, ""];
		};
	};
	
	//-----------------------------------------------------------------------------------
	// 5 - Copy Notepad to Clipboard - [5] spawn crack_notepad_fnc_notepadGUI;
	
	case 5: {
		
		_contents = GVAR(notepadContents) select GVAR(currentPageIndex);

		_string = (_contents select 0) + "<br /><br />";
		
		{
			if (_x != "") then {
				_string = _string + _x + "<br />";
			};
		} foreach (_contents select 1);
		
		if (!ismultiplayer) then {

			copyToClipboard _string;

			hint "Page Copied to Clipboard\n\nRemember to replace every <br /> with an actual line break.";
			
		} else {
			
			createdialog "CRACK_notepad_diag_copyPageToClipboard";
			
			ctrlSetText [1, _string];
			
			//hint "Remember to find and replace every <br /> with an actual line break.";
			
			while {GVAR(copyPageToCBDiagOpen)} do {
				waituntil {((ctrlText 1) != _string) OR !GVAR(copyPageToCBDiagOpen)};
				if (!GVAR(copyPageToCBDiagOpen)) exitwith {};
				ctrlSetText [1, _string];
			};
		};
	};
	
	//-----------------------------------------------------------------------------------
	// 6 - Copy External Notepad - [6] spawn crack_notepad_fnc_notepadGUI;
	
	case 6: {
		
		_titleFrom = lbText [1, (lbCurSel 1)];
		_titleTo = lbText [2, (lbCurSel 2)];
		
		if (_titleFrom == "") exitwith {
			hint "Please choose a page to copy from!";
		};
		
		if (_titleTo == "") exitwith {
			hint "Please choose a page to copy to!";
		};
		
		closeDialog 80549;
		
		[1, GVAR(currentCopyTarget), [_titleFrom, _titleTo]] spawn FUNC(requestRemoteVariable);
		
	};
	
	//-----------------------------------------------------------------------------------
};