
private ["_damArray", "_dead", "_call", "_textArray"];

_damArray	= _this select 0;
_call		= _this select 1;

_dead		= false;

_textArray = [parseText("<t color='#E60017' size='1.2' shadow='1' shadowColor='#000000' align='center'>" + _call + "</t>")];

_textArray = _textArray + [parseText("<br/><br/><t color='#FCD116' align='center'>" + (localize "STR_HINTONHIT_TIME") + ": </t>" + str(date select 3) + ":" + str(date select 4) + ":" + str(round(time % 60)))];

_textArray = _textArray + [parseText("<br/><br/><t color='#00E5EE' align='center'>" + (localize "STR_HINTONHIT_PDAM") + ": </t>")];

for "_i" from 1 to ((count _damArray) - 1) do {
	
	private ["_dam", "_partName", "_vitalOrgs"];
	
	_dam		= _damArray select _i;
	_partName	= cm_handleDamage_dic_bodyPartNames select _i;
	
	_vitalOrgs = [1,2,3];
	
	if ((_i in _vitalOrgs) AND (_dam >= 1)) then {
		_dead = true;
	};
	
	// NN.N% Format, will simplify decimals
	_dam = round (_dam * 1000);
	_dam = _dam / 10;
	
	if (_dam > 100) then {
		_dam = 100;
	};
	
	_textArray = _textArray + [parseText("<br/><t color='#FCD116' align='center'>" + _partName + ": </t>" + str(_dam) + "%")];
};

if (_dead) then {
	_textArray = _textArray + [parseText("<br/><br/><t color='#E60017' size='1.2' shadow='1' shadowColor='#000000' align='center'>" + (localize "STR_HINTONHIT_DEAD") + "</t>")];
};

// Add Extra Spaces Below
_textArray = _textArray + [parseText("<br/><br/>")];

hint composeText(_textArray);