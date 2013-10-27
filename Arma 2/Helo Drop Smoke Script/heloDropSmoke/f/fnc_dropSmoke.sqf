private ["_ammoName", "_index", "_return", "_smokesLeft", "_veh", "_getVar", "_value", "_smoke"];

_ammoName = _this select 0;
_index = _this select 1;
_veh = _this select 2;
_return = false;

_smokesLeft = [_veh, _index] call CRACK_fnc_heloDS_getSmokesLeft;

if (_smokesLeft > 0) then {	
	
	_smoke = _ammoName createVehicle (_veh modelToWorld CRACK_heloDS_heloDropPos);
	
	_getVar = _veh getVariable "CRACK_heloDS_smokesLeft";
	_value = _getVar select _index;
	_getVar set [_index, (_value - 1)];
	_veh setVariable ["CRACK_heloDS_smokesLeft", _getVar, true];
	
	_return = true;
	
} else {
	hint "Out of Smokes!";
};

_return