#define DEBUG_DISPLAY	(finddisplay 316001)

#define DEBUG_VAR1	(DEBUG_DISPLAY displayctrl 316011)
#define DEBUG_VAR2	(DEBUG_DISPLAY displayctrl 316021)
#define DEBUG_VAR3	(DEBUG_DISPLAY displayctrl 316031)
#define DEBUG_VAR4	(DEBUG_DISPLAY displayctrl 316041)

#define DEBUG_OUT1	(DEBUG_DISPLAY displayctrl 316012)
#define DEBUG_OUT2	(DEBUG_DISPLAY displayctrl 316022)
#define DEBUG_OUT3	(DEBUG_DISPLAY displayctrl 316032)
#define DEBUG_OUT4	(DEBUG_DISPLAY displayctrl 316042)

#define DEBUG_CMD1	(DEBUG_DISPLAY displayctrl 316101)
#define DEBUG_CMD2	(DEBUG_DISPLAY displayctrl 316102)
#define DEBUG_CMD3	(DEBUG_DISPLAY displayctrl 316103)
#define DEBUG_CMD4	(DEBUG_DISPLAY displayctrl 316104)
#define DEBUG_CMD5	(DEBUG_DISPLAY displayctrl 316105)
#define DEBUG_CMD6	(DEBUG_DISPLAY displayctrl 316106)

#define DEBUG_EXEC1	(DEBUG_DISPLAY displayctrl 1700)
#define DEBUG_EXEC2	(DEBUG_DISPLAY displayctrl 1701)
#define DEBUG_EXEC3	(DEBUG_DISPLAY displayctrl 1702)
#define DEBUG_EXEC4	(DEBUG_DISPLAY displayctrl 1703)
#define DEBUG_EXEC5	(DEBUG_DISPLAY displayctrl 1704)
#define DEBUG_EXEC6	(DEBUG_DISPLAY displayctrl 1705)

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

disableserialization;
_display = _params select 0;

//if (isnull (finddisplay 26)) exitwith {_display closedisplay 2};

switch _mode do {

	//--- Load
	case "onLoad": {
		BIS_debug_run = true;

		_params spawn {
			disableserialization;
			waituntil {!isnull DEBUG_DISPLAY};

			//--- Disable PP effects button
			//(DEBUG_DISPLAY displayctrl 1711) ctrlenable false;

			//--- Load text fields
			with (profileNameSpace) do {
				if (isnil "BIS_var1") then {BIS_var1 = ""};
				if (isnil "BIS_var2") then {BIS_var2 = ""};
				if (isnil "BIS_var3") then {BIS_var3 = ""};
				if (isnil "BIS_var4") then {BIS_var4 = ""};

				DEBUG_VAR1 ctrlsettext BIS_var1;
				DEBUG_VAR2 ctrlsettext BIS_var2;
				DEBUG_VAR3 ctrlsettext BIS_var3;
				DEBUG_VAR4 ctrlsettext BIS_var4;

				if (isnil "BIS_cmd1") then {BIS_cmd1 = ""};
				if (isnil "BIS_cmd2") then {BIS_cmd2 = ""};
				if (isnil "BIS_cmd3") then {BIS_cmd3 = ""};
				if (isnil "BIS_cmd4") then {BIS_cmd4 = ""};
				if (isnil "BIS_cmd5") then {BIS_cmd5 = ""};
				if (isnil "BIS_cmd5") then {BIS_cmd6 = ""};
				DEBUG_CMD1 ctrlsettext BIS_cmd1;
				DEBUG_CMD2 ctrlsettext BIS_cmd2;
				DEBUG_CMD3 ctrlsettext BIS_cmd3;
				DEBUG_CMD4 ctrlsettext BIS_cmd4;
				DEBUG_CMD5 ctrlsettext BIS_cmd5;
				DEBUG_CMD6 ctrlsettext BIS_cmd6;
			};

			//--- Set event handlers
			DEBUG_DISPLAY displayaddeventhandler ["keydown","
				_key = _this select 1;
				_ctrl = _this select 3;

				if (_ctrl) then {
					switch (_key) do {
						case 2: {call compile (ctrlText 316101);};
						case 3: {call compile (ctrlText 316102);};
						case 4: {call compile (ctrlText 316103);};
						case 5: {call compile (ctrlText 316104);};
						case 6: {call compile (ctrlText 316105);};
						case 7: {call compile (ctrlText 316106);};
					};
				};
				false
			"];

			DEBUG_EXEC1 ctrladdeventhandler ["buttonclick","call compile ctrltext ((ctrlparent (_this select 0)) displayctrl 316101)"];
			DEBUG_EXEC2 ctrladdeventhandler ["buttonclick","call compile ctrltext ((ctrlparent (_this select 0)) displayctrl 316102)"];
			DEBUG_EXEC3 ctrladdeventhandler ["buttonclick","call compile ctrltext ((ctrlparent (_this select 0)) displayctrl 316103)"];
			DEBUG_EXEC4 ctrladdeventhandler ["buttonclick","call compile ctrltext ((ctrlparent (_this select 0)) displayctrl 316104)"];
			DEBUG_EXEC5 ctrladdeventhandler ["buttonclick","call compile ctrltext ((ctrlparent (_this select 0)) displayctrl 316105)"];
			DEBUG_EXEC6 ctrladdeventhandler ["buttonclick","call compile ctrltext ((ctrlparent (_this select 0)) displayctrl 316106)"];


			//--- Variable checking loop
			while {BIS_debug_run} do {
				with missionnamespace do {
					if (ctrltext DEBUG_VAR1 != "") then {DEBUG_OUT1 ctrlsettext format ["%1",call compile (ctrltext DEBUG_VAR1)];};
					if (ctrltext DEBUG_VAR2 != "") then {DEBUG_OUT2 ctrlsettext format ["%1",call compile (ctrltext DEBUG_VAR2)];};
					if (ctrltext DEBUG_VAR3 != "") then {DEBUG_OUT3 ctrlsettext format ["%1",call compile (ctrltext DEBUG_VAR3)];};
					if (ctrltext DEBUG_VAR4 != "") then {DEBUG_OUT4 ctrlsettext format ["%1",call compile (ctrltext DEBUG_VAR4)];};
					uisleep 0.1;
				};
			};
		};
	};

	//--- Unload
	case "onUnload": {
		BIS_debug_run = false;

		profileNameSpace setvariable ["BIS_var1",(ctrlText DEBUG_VAR1)];
		profileNameSpace setvariable ["BIS_var2",(ctrlText DEBUG_VAR2)];
		profileNameSpace setvariable ["BIS_var3",(ctrlText DEBUG_VAR3)];
		profileNameSpace setvariable ["BIS_var4",(ctrlText DEBUG_VAR4)];

		profileNameSpace setvariable ["BIS_cmd1",(ctrlText DEBUG_CMD1)];
		profileNameSpace setvariable ["BIS_cmd2",(ctrlText DEBUG_CMD2)];
		profileNameSpace setvariable ["BIS_cmd3",(ctrlText DEBUG_CMD3)];
		profileNameSpace setvariable ["BIS_cmd4",(ctrlText DEBUG_CMD4)];
		profileNameSpace setvariable ["BIS_cmd5",(ctrlText DEBUG_CMD5)];
		profileNameSpace setvariable ["BIS_cmd6",(ctrlText DEBUG_CMD6)];

		saveProfileNameSpace;

		[] call (uinamespace getvariable "bis_fnc_displayClouds");
	};
};