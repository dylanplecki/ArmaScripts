private ["_returnArray", "_dataType", "_data", "_args", "_title", "_index"];

// [_dataType, _data, _args]

_dataType = _this select 0;
_data = _this select 1;
_args = if ((count _this) > 2) then {_this select 2} else {[]};
_returnArray = [];

switch (_dataType) do {
	
	case 0: { // Titles
		
		{
			_title = _x select 0;
			
			{
				if (_x != "") exitwith {
					_returnArray = _returnArray + [_title];
				};
			} foreach (_x select 1);
			
		} foreach _data;
		
	};
	
	case 1: { // Contents
		
		_title = _args select 0;
		_index = -1;
		
		for "_i" from 0 to ((count _data) - 1) do {
			if (((_data select _i) select 0) == _title) exitwith {_index = _i;};
		};
		
		if (_index != -1) then {
			_returnArray = (_data select _index) select 1;
		} else {
			_returnArray = "ERROR";
		};
		
	};
};

_returnArray