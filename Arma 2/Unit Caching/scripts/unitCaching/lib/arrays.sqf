/*
	Title: Array Library
	Author: Dylan Plecki (Naught)
	
	License:
		Copyright © 2013 Dylan Plecki. All rights reserved.
		Except where otherwise noted, this work is licensed under CC BY-NC-ND 4.0,
		available for reference at <http://creativecommons.org/licenses/by-nc-nd/4.0/>.
*/

/*
	Group: Array Manipulation Functions
*/

UCD_fnc_push = {
	CHECK_THIS;
	private ["_obj", "_var", "_val", "_arr"];
	_obj = _this select 0;
	_var = _this select 1;
	_val = _this select 2;
	_arr = _obj getVariable _var;
	if (isNil "_arr" || {typeName(_arr) != "ARRAY"}) then {
		_obj setVariable [_var, []];
		_arr = _obj getVariable _var;
	};
	_arr set [(count _arr), _val];
};

UCD_fnc_uErase = { // Unordered erase function
	CHECK_THIS;
	private ["_arr", "_idx", "_last"];
	_arr = _this select 0;
	_idx = _this select 1;
	_last = (count _arr) - 1;
	_arr set [_idx, (_arr select _last)];
	_arr resize _last;
};

UCD_fnc_heapSort = {
	CHECK_THIS;
	private ["_fnc_swap", "_fnc_siftDown"];
	_fnc_swap = {
		private ["_array", "_pos1", "_pos2", "_temp"];
		_array = _this select 0;
		_pos1 = _this select 1;
		_pos2 = _this select 2;
		_temp = _array select _pos1;
		_array set [_pos1, (_array select _pos2)];
		_array set [_pos2, _temp];
	};
	_fnc_siftDown = {
		private ["_array", "_start", "_end", "_compFunc", "_root"];
		_array = _this select 0;
		_start = _this select 1;
		_end = _this select 2;
		_compFunc = _this select 3;
		_root = _start;
		while {((_root * 2) + 1) <= _end} do {
			private ["_child", "_swap"];
			_child = (_root * 2) + 1;
			_swap = _root;
			if (((_array select _swap) call _compFunc) < ((_array select _child) call _compFunc)) then {
				_swap = _child;
			};
			if (((_child + 1) <= _end) && ((_array select _swap) < (_array select (_child + 1)))) then {
				_swap = _child + 1;
			};
			if (_swap != _root) then {
				[_array, _root, _swap] call _fnc_swap;
				_root = _swap;
			};
		};
	};
	private ["_array", "_compFunc", "_start", "_end"];
	_array = _this select 0;
	_compFunc = DEFAULT_PARAM(1,{_this});
	_start = ((count _array) - 2) / 2;
	_end = (count _array) - 1;
	if ((count _array) > 1) then {
		while {_start >= 0} do {
			[_array, _start, _end, _compFunc] call _fnc_siftDown;
			_start = _start - 1;
		};
		while {_end > 0} do {
			[_array, _end, 0] call _fnc_swap;
			_end = _end - 1;
			[_array, 0, _end, _compFunc] call _fnc_siftDown;
		};
	};
	_array
};

UCD_fnc_shellSort = {
	CHECK_THIS;
	private ["_list", "_selectSortValue", "_n", "_cols", "_j", "_k", "_h", "_t", "_i"];
	_list = +(_this select 0);
	_selectSortValue = { _this };
	if ((count _this) > 1) then
	{
	   if ((typeName (_this select 1)) == "CODE") then
	   {
		  _selectSortValue = _this select 1;
	   } else {
		  _selectSortValue = compile (_this select 1);
	   };
	};
	// shell sort
	_n = count _list;
	// we take the increment sequence (3 * h + 1), which has been shown
	// empirically to do well... 
	_cols = [3501671, 1355339, 543749, 213331, 84801, 27901, 11969, 4711, 1968, 815, 271, 111, 41, 13, 4, 1];
	for "_k" from 0 to ((count _cols) - 1) do
	{
	   _h = _cols select _k;
	   for [{_i = _h}, {_i < _n}, {_i = _i + 1}] do
	   {
		  _t = _list select _i;
		  _j = _i;
		  while {(_j >= _h)} do
		  {
			 if (!(((_list select (_j - _h)) call _selectSortValue) > 
				   (_t call _selectSortValue))) exitWith {};
			 _list set [_j, (_list select (_j - _h))];
			 _j = _j - _h;
		  };
		  _list set [_j, _t];
	   };
	};
	_list
};

UCD_fnc_sortObjectDistance = {
	CHECK_THIS;
	private ["_array", "_object"];
	_array = _this select 0;
	_object = _this select 1; // Can use in compFunc b/c of SQF scoping
	[_array, {_this distance _object}] call UCD_fnc_heapSort;
};
