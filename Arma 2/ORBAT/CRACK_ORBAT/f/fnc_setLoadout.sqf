#include "script_macros.hpp"

_man = _this select 0;

if (local _man) then {
	
	_primaryWeapon = _this select 1;
	_secondaryWeapon = _this select 2;
	_weaponOnBack = _this select 3;
	_weaponOnBackACE = _this select 4;
	_items = _this select 5;
	_optics = _this select 6;
	_pMags = _this select 7;
	_sMags = _this select 8;
	_rWeapons = _this select 9;
	_rItems = _this select 10;
	_rpMags = _this select 11;
	_rsMags = _this select 12;
	_IFAK = _this select 13;
	_earPlugs = _this select 14;

	// Removing Current Weapons + Ammunition
	removeAllWeapons _man;
	removeAllItems _man;
	removeBackpack _man;

	// ACE Weapon-On-Back
	[_man, "WOB"] call ACE_fnc_RemoveGear;
	ifStringIsSet(_weaponOnBackACE) then {
		_man addWeapon _weaponOnBackACE;
		[_man, _weaponOnBackACE] call ACE_fnc_PutWeaponOnBack;
	};

	// Adding Weapons + Items + Optics
	_list = _items + _optics + [_primaryWeapon, _secondaryWeapon, _weaponOnBack];
	if ((count _list) > 0) then {
		{
			ifStringIsSet(_x) then {_man addWeapon _x;};
		} foreach _list;
	};

	// Adding Primary + Secondary Magazines
	_list = _pMags + _sMags;
	if ((count _list) > 0) then {
		[_man, _list] call CRACK_fnc_addMagArray;
	};

	// Rucksack Weapons + Items + Ammunition
	_wlist = _rWeapons + _rItems;
	_alist = _rpMags + _rsMags;
	if (((count _wlist) > 0) OR ((count _alist) > 0)) then {
		[_man, _wlist, _alist] call CRACK_fnc_rucksackOperations;
	};

	// Select Primary Weapon
	[_man] call CRACK_fnc_selectPrimaryWep;

	// Client only stuff
	if (!isdedicated) then {
		
		// Adding IFAK Contents
		if ((_IFAK == 1) AND (_man == player)) then {
			[_man, 1, 1, 1] call ACE_fnc_PackIFAK;
		};

		// Adding in earplugs if needed
		if ((_earPlugs == 1) AND (_man == player)) then {
			[] call CRACK_fnc_addEarProtection;
		};
	};
};