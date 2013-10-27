private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus", "_Allow", "_menu", "_veh"];

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

_Allow = false;
_veh = vehicle player;

if (_veh isKindOf CRACK_heloDS_vehType) then {
	
	if ((CRACK_heloDS_usability == 0) AND ((driver _veh) != player)) exitWith {};
	if ((CRACK_heloDS_usability == 1) AND ((driver _veh) == player)) exitWith {};
	
	_Allow = true;
};

_menus = [
	[
		["main", "Main Menu", _menuRsc],
		[
			["Drop >", "", "", "", // "<t color='#ffc600'>Drop Smoke ></t>"
				["_this call CRACK_fnc_heloDS_selfInteract", "dropsmokemenu", 1],
				-1, 1, (_Allow)]	
		]
	]
];

if(_menuName == "dropsmokemenu") then {
	
	private ["_menuTemp", "_text", "_smokes"];
	
	_menu = [["dropsmokemenu", "Drop Smoke Menu", "popup", ""], []];
	_menuTemp = [];
	
	CRACK_heloDS_currentPlayerVeh = _veh;
	_smokes = CRACK_heloDS_smokes;
	
	//------------------
	
	for "_i" from 0 to (count _smokes - 1) do {
		private ["_arrayIn", "_arrayOut", "_smokesLeft"];
		
		_arrayIn = _smokes select _i;
		_arrayOut = [];
		_arrayVeh = [];
		
		_smokesLeft = [_veh, _i] call CRACK_fnc_heloDS_getSmokesLeft;
		
		//---
		
		// Title
		_arrayOut set [0, (format["<t color='%1'>Drop %2 - %3 Left</t>", (_arrayIn select 2), (_arrayIn select 0), _smokesLeft])];
		
		// Code
		_arrayOut set [1, (compile format["['%1', %2, CRACK_heloDS_currentPlayerVeh] call CRACK_fnc_heloDS_dropSmoke;", (_arrayIn select 1), _i])];
		
		// Misc.
		_arrayOut set [2, ""];
		_arrayOut set [3, ""];
		_arrayOut set [4, ""];
		_arrayOut set [5, -1];
		_arrayOut set [6, 1];
		
		// Enabled
		_arrayOut set [7, (if (_smokesLeft > 0) then {true} else {false})];
		
		// Visible
		_arrayOut set [8, _Allow];
		
		//---
		
		_menuTemp set [_i, _arrayOut];
	};
	
	//------------------
	
	_menu set [1, _menuTemp];
		
	_menus set [count _menus, _menu];
	
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
