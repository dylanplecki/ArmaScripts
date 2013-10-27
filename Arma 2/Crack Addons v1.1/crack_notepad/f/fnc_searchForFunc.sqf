#include "\x\crack\addons\notepad\script_component.hpp"

private ["_textArray", "_searchText", "_char", "_searchText2", "_func", "_resizeSize"];

_textArray = _this;
_resizeSize = 1;

_func = { // Differentiates between normal and inverse Trig Functions
	private ["_textArray", "_resizeSize", "_char"];
	_textArray = _this;
	_resizeSize = 1;
	if ((count _textArray) <= 4) then {
		_resizeSize = count _textArray;
	} else {
		_char = _textArray select ((count _textArray) - 5);
		if (_char == (toArray("a") select 0)) then {
			_resizeSize = 5;
		} else {
			_resizeSize = 4;
		};
	};
	_resizeSize
};

_searchText = ["(", "i", "S"] call FUNCMAIN(toUnicodeDecimal);

_char = _textArray select ((count _textArray) - 1);

if (_char in _searchText) then {
	
	if ((count _textArray) <= _resizeSize) exitwith {};
	
	//-----------------------------------------
	
	if (_char == (_searchText select 0)) exitwith { // function
		
		_char = _textArray select ((count _textArray) - 2);
		
		_searchText2 = ["t", "n", "s", "d"] call FUNCMAIN(toUnicodeDecimal);
		
		//-------------------------------------
		if (_char == (_searchText2 select 0)) then { // sqrt
			_resizeSize = 5;
		} else {
			//---------------------------------
			if (_char == (_searchText2 select 1)) then { // sin|tan|asin|atan
				
				_char = _textArray select ((count _textArray) - 3);
				
				if (_char == (toArray("i") select 0)) then { // sin|asin
					_resizeSize = _textArray call _func;
				} else {
					//-------------------------
					if (_char == (toArray("a") select 0)) then { // tan|atan
						_resizeSize = _textArray call _func;
					};
				};
			} else {
				//-----------------------------
				if (_char == (_searchText2 select 2)) then { // cos|acos
					_resizeSize = _textArray call _func;
				} else {
					//-------------------------
					if (_char == (_searchText2 select 3)) then { // rad
						_resizeSize = 4;
					};
				};
			};
		};
	};

	//-----------------------------------------

	if (_char == (_searchText select 1)) exitwith { // pi
		
		_char = _textArray select ((count _textArray) - 2);
		
		if (_char == (toArray("p") select 0)) then {
			_resizeSize = 2;
		};
		
	};

	//-----------------------------------------

	if (_char == (_searchText select 2)) exitwith { // ANS
		
		_char = _textArray select ((count _textArray) - 2);
		
		if (_char == (toArray("N") select 0)) then {
		
			_char = _textArray select ((count _textArray) - 3);
			
			if (_char == (toArray("S") select 0)) then {
				_resizeSize = 3;
			};
		};
		
	};

	//-----------------------------------------
	
};

_resizeSize = ((count _textArray) - _resizeSize);

_resizeSize