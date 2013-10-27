#include "script_macros.hpp"

_man = _this select 0;
_list = _this select 1;

{
	ifIsString(_x) then {
		ifStringIsSet(_x) then {[_man, _x, 1] call ACE_fnc_PackWeapon;};
	};
	
	ifIsArray(_x) then {
		ifArrayIsSet(_x) then {
			[_man, (_x select 0), (_x select 1)] call ACE_fnc_PackWeapon;
		};
	};
} foreach _list;