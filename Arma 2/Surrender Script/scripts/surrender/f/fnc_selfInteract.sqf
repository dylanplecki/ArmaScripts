#include "defines.hpp"

private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus", "_surrendered", "_captured"];

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

_menus = [
	[
		["main", "Main Menu", _menuRsc],
		[
			["Surrender >", "", "", "",
				[GVAR(codeStringAceSelfInteract), "surrendermenu", 1],
				-1, 1, (true)]	
		]
	]
];

if(_menuName == "surrendermenu") then {
	
	_surrendered = (player getvariable QUOTE(GVAR(surrenderedStatus))) select 0;
	_captured = (player getvariable QUOTE(GVAR(surrenderedStatus))) select 1;
	
	_menus set [count _menus,
		[
			["surrendermenu", "Surrender Menu", "popup", ""],
			[
				[
				"Surrender",
					{ [] call FUNC(surrender); },
					"", "", "", -1, 1,
					(!(_surrendered) AND !(_captured)), (true)
				],
				[
				"Run Away",
					{ [] call FUNC(runAway); },
					"", "", "", -1, 1,
					(_surrendered AND !_captured), (true)
				],
				[
				"<t color='#ffc600'>Take Cyanide</t>",
					{ [] call FUNC(takeCyanide); },
					"", "", "", -1, 1,
					(GVAR(cyanide) AND !GVAR(playerIsTakingCyanide)), (true)
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