#include "defines.hpp"

private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus", "_surrendered", "_captured", "_visible"];

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

_visible = if ((alive _target) AND ((count (_target getvariable [QUOTE(GVAR(surrenderedStatus)), []])) > 0)) then {true} else {false};

_menus = [
	[
		["main", "Main Menu", _menuRsc],
		[
			["Prisoner Menu >", "", "", "",
				[GVAR(codeStringAceSelfInteract), "prisonermenu", 1],
				-1, 1, (_visible)]	
		]
	]
];

if((_menuName == "prisonermenu") AND _visible) then {
	
	_surrendered = (_target getvariable QUOTE(GVAR(surrenderedStatus))) select 0;
	_captured = (_target getvariable QUOTE(GVAR(surrenderedStatus))) select 1;
	
	_menus set [count _menus,
		[
			["prisonermenu", "Prisoner Menu", "popup", ""],
			[
				[
				"Capture",
					{ [] call FUNC(capture); },
					"", "", "", -1, 1,
					(_surrendered AND !_captured), (true)
				],
				[
				"Release",
					{ ["CRACK_ceh_releaseUnit", [_target]] call CBA_fnc_globalEvent; },
					"", "", "", -1, 1,
					(_surrendered AND _captured), (true)
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