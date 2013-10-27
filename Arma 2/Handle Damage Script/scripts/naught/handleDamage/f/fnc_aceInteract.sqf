#include "\ca\editor\Data\Scripts\dikCodes.h"

private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus", "_type"];

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

cm_siTarget = _target;

_menus = [
	[
		["main", "Main Menu", _menuRsc],
		[
			["<t color='#ffc600'>" + (localize "STR_CM_HD_INTERACT") + " ></t>", "", "", "",
				["_this call cm_handleDamage_fnc_aceInteract", "medicaloptions", 1],
				-1, 1, (cm_handleDamage)]	
		]
	]
];

if(_menuName == "medicaloptions") then {
	
	private ["_popupArray", "_menuShown", "_playerName"];
	
	_popupArray = [];
	_menuShown = false;
	
	{
		if (typeName(_x) == typeName("string")) then {_x = compile _x;};
		if (typeName(_x) == typeName([])) exitWith {diag_log (text "CRITICAL: Handle Damage: Array found in interact options!")};
		
		_popupArray = _popupArray + (_this call _x);
		
	} forEach cm_handleDamage_interactMenu;
	
	{
		if (_x select 7) exitwith {
			_menuShown = true;
		};
	} forEach _popupArray;
	
	if (!_menuShown OR (count _popupArray < 1)) then {
		_popupArray = [
			[
				(localize "STR_CM_HD_INTERACT_EMPTY"),
				{},
				"", "", "", -1,
				0, true
			]
		];
	};
	
	_playerName = if (player == _target) then {"Player"} else {name _target};
	
	_menus set [count _menus,
		[
			["medicaloptions", ((localize "STR_CM_HD_INTERACT") + " (" + _playerName + ")"), "popup", ""],
			_popupArray
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