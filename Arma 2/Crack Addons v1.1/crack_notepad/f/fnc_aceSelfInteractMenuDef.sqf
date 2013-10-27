#include "\x\crack\addons\notepad\script_component.hpp"

private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus", "_visible", "_notepadVisible", "_reminderVisible", "_calcVisible"];

// _this==[_target, _menuNameOrParams]
_target = _this select 0;
_params = _this select 1;

_menuName = "";
_menuRsc = "popup";

if (typeName _params == typeName []) then {
	if (count _params < 1) exitWith {diag_log format["Error: Invalid params: %1, %2", _this, __FILE__];};
	_menuName = _params select 0;
	_menuRsc = if (count _params > 1) then {_params select 1} else {_menuRsc};
} else {
	_menuName = _params;
};

//-----------------------------------------------------------------------------

_visible = [] call FUNC(canPlayerUseNotepad);

_menus = [
	[
		["main", "Main Menu", _menuRsc],
		[
			["Notepad >", "", "", "", // "<t color='#ffc600'>Notepad ></t>"
				[GVAR(codeStringAceSelfInteractMenuDef), "notepadmenu", 1],
				-1, 1, (_visible)]	
		]
	]
];

if(_menuName == "notepadmenu") then {
	
	_notepadVisible = false;
	_reminderVisible = false;
	_calcVisible = false;
	
	if (GVAR(notepadEnabled) AND _visible) then {_notepadVisible = true;};
	
	if (GVAR(remindersEnabled) AND _visible) then {_reminderVisible = true;};
	
	if (GVAR(calculatorEnabled) AND _visible) then {_calcVisible = true;};
	
	_menus set [count _menus,
		[
			["notepadmenu", "Notepad Menu", "popup", ""],
			[
				[
				"Open Notepad",
					{ [0] call FUNC(notepadGUI); },
					"", "", "", -1, 1,
					(_notepadVisible), (true)
				],
				[
				"Reminders",
					{ [0] call FUNC(reminderGUI); },
					"", "", "", -1, 1,
					(_reminderVisible), (true)
				],
				[
				"Disable Reminders",
					{ GVAR(remindersShown) = false; },
					"", "", "", -1, 1,
					(_reminderVisible AND GVAR(remindersShown)), (true)
				],
				[
				"Enable Reminders",
					{ GVAR(remindersShown) = true; },
					"", "", "", -1, 1,
					(_reminderVisible AND !GVAR(remindersShown)), (true)
				],
				[
				"Allow External Access",
					{ player setvariable [QUOTE(GVAR(externalAccessEnabled)), true, true]; },
					"", "", "", -1, 1,
					(_notepadVisible AND !(player getvariable [QUOTE(GVAR(externalAccessEnabled)), true])), (true)
				],
				[
				"Block External Access",
					{ player setvariable [QUOTE(GVAR(externalAccessEnabled)), false, true]; },
					"", "", "", -1, 1,
					(_notepadVisible AND (player getvariable [QUOTE(GVAR(externalAccessEnabled)), true])), (true)
				],
				[
				"Calculator",
					{ ["open"] call FUNC(calculatorGUI); },
					"", "", "", -1, 1,
					(_calcVisible), (true)
				]
			]
		]
	];
};

//-----------------------------------------------------------------------------

_menuDef = [];
{
	if (_x select 0 select 0 == _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if (count _menuDef == 0) then {
	hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName == "") then {_this}else{""}, __FILE__];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};

_menuDef // return value