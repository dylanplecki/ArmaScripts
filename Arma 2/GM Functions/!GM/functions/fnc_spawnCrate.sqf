
GM_fnc_spawnCrate = {
	
	private ["_crateCargo", "_crateClass", "_cratePos", "_maxDistance", "_return", "_relCratePos",
			 "_crate", "_createMarker", "_markerName", "_markerType", "_markerGlobal"];
	
	if (isNil "GM_CRATE_COUNT") then {
		GM_CRATE_COUNT = 0;
	};
	
	_crateCargo		= _this select 0;	// [[TypeInt, "ClassName"(, CountInt)] ...] : TypeInt = 0 Weapon, 1 Mag
	_crateClass		= if ((count _this) > 1) then {_this select 1} else {"ACE_MagazineBox_Launchers_BIS_US"};
	_cratePos		= if ((count _this) > 2) then {_this select 2} else {getPos player};
	_maxDistance	= if ((count _this) > 3) then {_this select 3} else {15};
	_createMarker	= if ((count _this) > 4) then {_this select 4} else {true};
	_markerName		= if ((count _this) > 5) then {_this select 5} else {"Crate #%1"};
	_markerType		= if ((count _this) > 6) then {_this select 6} else {"b_support"};
	_markerGlobal	= if ((count _this) > 7) then {_this select 7} else {false};
	_return			= false;
	
	_relCratePos = _cratePos findEmptyPosition [0, _maxDistance, _crateClass];
	
	if ((count _relCratePos) > 0) then {
		
		_crate = _crateClass createVehicle _relCratePos;
		_return = true;
		
		if ((count _crateCargo) > 0) then {
			{
				private ["_class", "_count"];
				_class = _this select 1;
				_count = if ((count _x) > 2) then {_this select 2} else {1};
				
				switch (_x select 0) do {
					case 0: {
						_crate addWeaponCargoGlobal [_class, _count];
					};
					case 1: {
						_crate addMagazineCargoGlobal [_class, _count];
					};
				};
			} forEach _crateCargo;
		};
		
		GM_CRATE_COUNT = GM_CRATE_COUNT + 1;
		
		if (_createMarker) then {
			
			private ["_marker"];
			
			if (_markerGlobal) then {
				_marker = createMarker [(format["crate_marker_%1", GM_CRATE_COUNT]), _relCratePos];
				_marker setMarkerType _markerType;
				_marker setMarkerText (format[_markerName, GM_CRATE_COUNT]);
				_marker setMarkerColor "ColorGreenAlpha";
			} else {
				_marker = createMarkerLocal [(format["crate_marker_%1", GM_CRATE_COUNT]), _relCratePos];
				_marker setMarkerTypeLocal _markerType;
				_marker setMarkerTextLocal (format[_markerName, GM_CRATE_COUNT]);
				_marker setMarkerColorLocal "ColorGreenAlpha";
			};
		};
		
		player sideChat format["Crate #%1 Created @ '%2'", GM_CRATE_COUNT, _relCratePos];
		
	} else {
		player sideChat "Cannot Create Crate: No empty positions within max distance.";
	};
	
	_return
};