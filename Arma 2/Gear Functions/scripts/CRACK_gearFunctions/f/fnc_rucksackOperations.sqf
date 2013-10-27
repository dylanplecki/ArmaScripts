_man = _this select 0;
_wlist = _this select 1;
_alist = _this select 2;

_result = [_man] call ACE_fnc_HasRuck;
if (_result) then {
	
	waitUntil {!isNil "ACE_Sys_Ruck_fnc_AddMagToRuck" && !isNil "ACE_Sys_Ruck_fnc_AddWepToRuck" && !isNil "ACE_fnc_PutWeaponOnBack"};
	
	// Adding Rucksack Weapons + Items
	if ((count _wlist) > 0) then {
		_result = [_man, _wlist] call CRACK_fnc_addRuckWepArray;
	};

	// Adding Rucksack Primary + Secondary Magazines
	if ((count _alist) > 0) then {
		_result = [_man, _alist] call CRACK_fnc_addRuckMagArray;
	};
	
};