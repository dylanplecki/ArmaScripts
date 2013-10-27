#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\ui_helper\script_dikCodes.hpp"

private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus"];

// _this==[_target, _menuNameOrParams]
_target = _this select 0;
_params = _this select 1;

_menuName = "";
_menuRsc = "buttonList";

if (typeName _params == typeName []) then {
	if (count _params < 1) exitWith {diag_log format["Error: Invalid params: %1, %2", _this, __FILE__]};
	_menuName = _params select 0;
	_menuRsc = if (count _params > 1) then {_params select 1} else {_menuRsc};
} else {
	_menuName = _params;
};

//-----------------------------------------------------------------------------

_menus =
[
	[
		["main", "CRACKSelfInteracts", _menuRsc],
		[
			[
			"Get Out",
			"nul = [0] spawn CRACK_fnc_dismountHuey;",
			"","","", -1, 1, (CRACK_var_huey_playeronhuey)
			],
			[
			"Roll Out",
			"nul = [1] spawn CRACK_fnc_dismountHuey;",
			"","","", -1, 1, (CRACK_var_huey_playeronhuey)
			]
		]
	]
];

_menuName = "main";

//-----------------------------------------------------------------------------

_menuDef = [];
{
	if (_x select 0 select 0 == _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if (count _menuDef == 0) then {
	hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName == "") then {_this} else {""}, __FILE__];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};

_menuDef // return value