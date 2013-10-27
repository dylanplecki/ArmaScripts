private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_getVar", "_allow", "_menus", "_enabled", "_soundsEnabled", "_isDriver", "_soundsInfo"];

// Macros
#include "x-macros.hpp"

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

_allow = false;

if (_target in CRACK_sf_vehicleArray) then {
	if ((alive _target) AND (player in (crew _target))) then {
		_allow = true;
		CRACK_sf_interactTarget = _target;
		_getVar = _target getVariable ["CRACK_sf_boomStatus", CRACK_sf_defaultVehVar];
		_enabled = _getVar select 0;
		_soundsEnabled = _getVar select 1;
		_soundsInfo = _getVar select 2;
		_isDriver = if ((driver _target) == player) then {true} else {false};
	};
};

_menus = [
	[
		["main", "Main Menu", _menuRsc],
		[
			["Vehicle Boomerang >", "", "", "", // "<t color='#ffc600'>Boomerang ></t>"
				["_this call CRACK_sf_fnc_interact", "boomerangmenu", 1],
				-1, 1, (_allow)]	
		]
	]
];

if(_menuName == "boomerangmenu") then {
	
	_menus set [count _menus,
		[
			["boomerangmenu", "Boomerang Menu", "popup", ""],
			[
				[
				"Turn Boomerang System Off",
					{ [0, false] call CRACK_sf_fnc_setBoomerangStatus; },
					"", "", "", -1, 1,
					(_allow AND _enabled AND _isDriver), (true)
				],
				[
				"Turn Boomerang System On",
					{ [0, true] call CRACK_sf_fnc_setBoomerangStatus; },
					"", "", "", -1, 1,
					(_allow AND !_enabled AND _isDriver), (true)
				],
				[
				"Turn Boomerang Sounds Off",
					{ [1, false] call CRACK_sf_fnc_setBoomerangStatus; },
					"", "", "", -1, 1,
					(_allow AND _enabled AND _soundsEnabled), (true)
				],
				[
				"Turn Boomerang Sounds On",
					{ [1, true] call CRACK_sf_fnc_setBoomerangStatus; },
					"", "", "", -1, 1,
					(_allow AND _enabled AND !_soundsEnabled), (true)
				]/*,
				[
				"Turn Informative Sounds Off",
					{ [2, false] call CRACK_sf_fnc_setBoomerangStatus; },
					"", "", "", -1, 1,
					(_allow AND _enabled AND _soundsEnabled AND _soundsInfo), (true)
				],
				[
				"Turn Informative Sounds On",
					{ [2, true] call CRACK_sf_fnc_setBoomerangStatus; },
					"", "", "", -1, 1,
					(_allow AND _enabled AND _soundsEnabled AND !_soundsInfo), (true)
				]*/
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
