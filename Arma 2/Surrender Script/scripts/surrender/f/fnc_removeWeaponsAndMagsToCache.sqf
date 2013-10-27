private ["_target", "_cache", "_weapons", "_mags", "_ace"];

_target = _this select 0;
_cache = _this select 1;
_weapons = _this select 2;
_mags = _this select 3;
_ace = _this select 4;

if (!_ace) then {
	{ // foreach
		_target removeWeapon _x;
		_cache addWeaponCargoGlobal [_x, 1];
	} forEach _weapons;
	{ // foreach
		_target removeMagazine _x;
		_cache addMagazineCargoGlobal [_x, 1];
	} forEach _mags;
};
if (_ace) then {
	{_cache addMagazineCargoGlobal [_x select 0, _x select 1]} forEach _mags;
	{_cache addWeaponCargoGlobal _x} forEach _weapons;
};