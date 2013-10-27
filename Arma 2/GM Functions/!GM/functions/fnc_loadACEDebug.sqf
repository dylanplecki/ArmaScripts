
GM_fnc_loadACEDebug = {
	
	if (isNil 'ace_main_fnc_dbc_run' OR isNil "GM_ACEDebug_loaded") then {
		
		GM_ACEDebug_loaded = true;
		
		ace_main_fnc_dbc_run = {
			
			if (_this == "load") then {
				ctrlsettext [316011,if (isnil {uiNamespace getVariable "ace_debug_console_var1"}) then {""} else {uiNamespace getVariable "ace_debug_console_var1"}];
				ctrlsettext [316021,if (isnil {uiNamespace getVariable "ace_debug_console_var2"}) then {""} else {uiNamespace getVariable "ace_debug_console_var2"}];
				ctrlsettext [316031,if (isnil {uiNamespace getVariable "ace_debug_console_var3"}) then {""} else {uiNamespace getVariable "ace_debug_console_var3"}];
				ctrlsettext [316041,if (isnil {uiNamespace getVariable "ace_debug_console_var4"}) then {""} else {uiNamespace getVariable "ace_debug_console_var4"}];
				ctrlsettext [316101,if (isnil {uiNamespace getVariable "ace_debug_console_cmd1"}) then {""} else {uiNamespace getVariable "ace_debug_console_cmd1"}];
				ctrlsettext [316102,if (isnil {uiNamespace getVariable "ace_debug_console_cmd2"}) then {""} else {uiNamespace getVariable "ace_debug_console_cmd2"}];
				ctrlsettext [316103,if (isnil {uiNamespace getVariable "ace_debug_console_cmd3"}) then {""} else {uiNamespace getVariable "ace_debug_console_cmd3"}];
				ctrlsettext [316104,if (isnil {uiNamespace getVariable "ace_debug_console_cmd4"}) then {""} else {uiNamespace getVariable "ace_debug_console_cmd4"}];
				ctrlsettext [316105,if (isnil {uiNamespace getVariable "ace_debug_console_cmd5"}) then {""} else {uiNamespace getVariable "ace_debug_console_cmd5"}];
				ctrlsettext [316106,if (isnil {uiNamespace getVariable "ace_debug_console_cmd6"}) then {""} else {uiNamespace getVariable "ace_debug_console_cmd6"}];

				while {ace_debug_console_run} do {
					if (ctrltext 316011 != "") then {ctrlsettext [316012, format ["%1",call compile (ctrltext 316011)]]};
					if (ctrltext 316021 != "") then {ctrlsettext [316022, format ["%1",call compile (ctrltext 316021)]]};
					if (ctrltext 316031 != "") then {ctrlsettext [316032, format ["%1",call compile (ctrltext 316031)]]};
					if (ctrltext 316041 != "") then {ctrlsettext [316042, format ["%1",call compile (ctrltext 316041)]]};
					sleep 0.1;
				};
			};
			if (_this == "unload") then {
				uiNamespace setVariable ["ace_debug_console_var1", ctrlText 316011];
				uiNamespace setVariable ["ace_debug_console_var2", ctrlText 316021];
				uiNamespace setVariable ["ace_debug_console_var3", ctrlText 316031];
				uiNamespace setVariable ["ace_debug_console_var4", ctrlText 316041];
				uiNamespace setVariable ["ace_debug_console_cmd1", ctrlText 316101];
				uiNamespace setVariable ["ace_debug_console_cmd2", ctrlText 316102];
				uiNamespace setVariable ["ace_debug_console_cmd3", ctrlText 316103];
				uiNamespace setVariable ["ace_debug_console_cmd4", ctrlText 316104];
				uiNamespace setVariable ["ace_debug_console_cmd5", ctrlText 316105];
				uiNamespace setVariable ["ace_debug_console_cmd6", ctrlText 316106];
			};
		};
	};
	
	createdialog 'ACE_MP_Debug_Console';
};