private ["_dam", "_params", "_injuredUnit", "_injuredPart", "_partDamage", "_injurer", "_ammoClass", "_return", "_index", "_oldDam", "_script", "_forcePlayer", "_scriptParams"];

_dam			= _this select 0;
_params			= _this select 1;

_injuredUnit	= _dam select 0;
_injuredPart	= _dam select 1;
_partDamage		= _dam select 2;
_injurer		= _dam select 3;
_ammoClass		= _dam select 4;

_script			= _params select 0;
_forcePlayer	= _params select 1;
_scriptParams	= _params select 2;

_return			= 0;
_index			= cm_handleDamage_dic_bodyParts find _injuredPart;

if (_index >= 0) then {
	
	if (_forcePlayer AND (_injuredUnit != player)) exitWith {};
	
	_oldDam = cm_handleDamage_localDamArray select _index;
	cm_handleDamage_localDamArray set [_index, (_partDamage + _oldDam)];
	
	if (_index == ((count cm_handleDamage_dic_bodyParts) - 1)) then { // Last Body Part
		
		cm_handleDamage_localDamArray set [(_index + 1), diag_ticktime];
		player setVariable ["cm_handleDamage_localDamArray", cm_handleDamage_localDamArray, true];
		
		cm_handleDamage_localDamArray call compile (_scriptParams + " call " + _script);
	};
};

_return