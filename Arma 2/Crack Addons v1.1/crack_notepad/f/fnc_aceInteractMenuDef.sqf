#include "\x\crack\addons\notepad\script_component.hpp"

private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus", "_aliveStatus"];

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

_visible = false;

// Because ARMA doesn't use LAZY evaluations
if (ismultiplayer) then {
	if (GVAR(notepadMPEnabled) AND (call FUNC(canPlayerUseNotepad))) then { // Can use notepad
		if ((_target in (call CBA_fnc_players)) AND (alive _target)) then { // Target is an alive player
			if (_target getvariable [QUOTE(GVAR(externalAccessEnabled)), true]) then { // Hasn't blocked external access
				_visible = true;
			};
		} else {
			if (typename(_target getvariable [QUOTE(GVAR(oldNotepad)), 69]) != typename(69)) then { // Target is a dead player
				_visible = true;
			};
		};
	};
};

if (_visible) then {
	GVAR(currentCopyTarget) = _target;
};

_menus = [
	[
		["main", "Main Menu", _menuRsc],
		[
			["Copy Notepad",
				{ [0, GVAR(currentCopyTarget), []] spawn FUNC(requestRemoteVariable); },
				"", "", "", -1,
				1, (_visible)
			]
		]
	]
];


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
