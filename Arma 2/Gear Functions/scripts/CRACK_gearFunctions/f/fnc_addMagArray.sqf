#include "script_macros.hpp"

_man = _this select 0;
_list = _this select 1;

{
	ifIsString(_x) then {
		ifStringIsSet(_x) then {_man addMagazine _x;};
	};
	
	ifIsArray(_x) then {
		ifArrayIsSet(_x) then {
			for "_i" from 1 to (_x select 1) do {
				_man addMagazine (_x select 0);
			};
		};
	};
} foreach _list;