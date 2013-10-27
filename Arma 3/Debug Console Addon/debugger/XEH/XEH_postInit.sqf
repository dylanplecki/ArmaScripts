//
//	Arma 3 Debug Console Access
//		
//		By Crackman [dylanplecki@gmail.com]
//			Original by Taosenai (Public Domain)
//			Debug Console by Bohemia Interactive
//
///////////////////////////////////////////////////////////
//
// Post-Initialization
//
///////////////////////////////////////////////////////////
#include "\x\uo\addons\debugger\script_component.hpp"

if (isServer) then {
	GVAR(adminList) = GVAR(adminListLocal);
	publicVariable QUOTE(GVAR(adminList));
};

// Add key handler an other stuff. (Wait required for A3 CBA. Seems to run this before the display is up otherwise. This wasn't true for A2. But I used CBA_fnc_addDisplayHandler then, so I'm not sure).
if (!isDedicated) then {
	[] spawn {
		private ["_allowed", "_diaryRecords", "_countSub"];
		
		waituntil {sleep 0.5; !(isNull (findDisplay 46)) && !(isNull player);};
		
		_allowed = call FUNC(checkAllowed);
		
		if (_allowed) then {
			
			sleep 1; // Init should be done by now
			
			// Diary Stuff Below
			player createDiarySubject ["a3debugconsole", "Debug Console"];
			
			_diaryRecords = [
				["Documentation", GVAR(docDocumentation)],
				["Functions", GVAR(docFunctions)],
				["Changelog", GVAR(docChangelog)],
				["Credits", GVAR(docCredits)]
			];
			
			_countSub = (count _diaryRecords) - 1;
			
			for "_i" from 0 to _countSub do {
				private ["_title", "_text"];
				
				// Have to do it backwards...
				_title = (_diaryRecords select (_countSub - _i)) select 0;
				_text = (_diaryRecords select (_countSub - _i)) select 1;
				
				player createDiaryRecord ["a3debugconsole", [_title, _text]];
			};
			
			// Add Display EH
			GVAR(keyDownEHID) = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call " + QUOTE(FUNC(keyHandler)) + ";"];
			
		};
	};
};

///////////////////////////////////////////////////////////