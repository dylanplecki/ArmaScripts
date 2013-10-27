
GM_fnc_selfInteractMenu = {
	
	private ["_menuDef", "_target", "_params", "_menuName", "_menuRsc", "_menus"];
	
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
				["<t color='#ffc600'>GM Debug ></t>", "", "", "",
					["_this call GM_fnc_selfInteractMenu", "GM_debugMenu", 1],
					-1, 1, (true)]	
			]
		]
	];
	
	if(_menuName == "GM_debugMenu") then {
			
		_menus set [count _menus,
			[
				["GM_debugMenu", "Debug Menu", "popup", ""],
				[
					[
					"ACE Debug Console",
						{ [] spawn GM_fnc_loadACEDebug; },
						"", "", "", -1, 1,
						(true), (true)
					],
					[
					"UO Debug Console",
						{ [] spawn GM_fnc_loadUODebug; },
						"", "", "", -1, 1,
						(true), (true)
					],
					[
					"SIX Menu",
						{ [] spawn ("x\ace\addons\sys_menu\ActivatePopupMenuViaAction.sqf" call GM_fnc_cacheFile); },
						"", "", "", -1, 1,
						(true), (true)
					],
					[
					"Execute Scratchpad",
						{ [] spawn GM_fnc_execScratchpad; },
						"", "", "", -1, 1,
						(true), (true)
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
};