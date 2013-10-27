// createdialog "CRACK_calculator_diag";

// GVAR(calcInput) = [_degRad(0|1), _inputData, _outputData, _answer];

// [_call, [_args]] spawn crack_notepad_fnc_calculatorGUI;

#include "\x\crack\addons\notepad\script_component.hpp"

private ["_call", "_index", "_args", "_simpleOperations", "_color", "_text", "_codeToExecute", "_complexOperators", "_char", "_resizeSize"];

_call = _this select 0;
_args = if (count _this > 1) then {_this select 1} else {[]};

// Operator Type List
_complexOperators = ["open", "degrad", "del", "clear", "="];
_semiSimpleOperators = ["^(", "/", "*", "-", "+", "."];
_simpleOperators = ["(", ")", "pi", "ANS", "rad(", "sqrt(", "sin(", "cos(", "tan(", "asin(", "acos(", "atan(", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

// Calculator GUI Operations
if (_call in _complexOperators) then {
	
	// Complex Operator Handling ------------------------------------------------------------
	switch (_call) do {
		
		//-----------------------------------------------------------------------------------
		// ["open"] call FUNC(calculatorGUI);
		case "open": {
			
			if (isnil QUOTE(GVAR(calcInput))) then {GVAR(calcInput) = ["DEG", "", "", 0];};
			
			createdialog "CRACK_calculator_diag";
			
			ctrlSetText [34, (GVAR(calcInput) select 0)]; // DEG|RAD
			ctrlSetText [1, (GVAR(calcInput) select 1)]; // INPUT
			ctrlSetText [2, (GVAR(calcInput) select 2)]; // OUTPUT
			
			// Maybe one day we will be able to set Dialog Control Colors...
			/*
				// Set special colors based on player's side
				_color = [(179 / 256), (158 / 256), (113 / 256), 1];
				switch (side player) do {
					case WEST: {_color = [(54 / 256), (96 / 256), (146 / 256), 1];};
					case EAST: {_color = [(150 / 256), (54 / 256), (52 / 256), 1];};
					case RESISTANCE: {_color = [(118 / 256), (147 / 256), (60 / 256), 1];};
					case CIVILIAN: {_color = [(166 / 256), (166 / 256), (166 / 256), 1];};
				};
				{ // FOREACH
					_x ctrlSetTextColor _color;
				} foreach [14, 18, 22, 26, 30]; // SPECIAL DIALOG CONTROLS IDC's
			*/
			
		};
		//-----------------------------------------------------------------------------------
		// Might need this later.. Who knows :)
		/*
		case "degrad": {
			
			_text = if (ctrlText 34 == "DEG") then {"RAD"} else {"DEG"};
			
			GVAR(calcInput) set [0, _text];
			
			ctrlSetText [34, _text]; // DEG|RAD
			
		};
		*/
		//-----------------------------------------------------------------------------------
		case "del": {
			
			_text = ctrlText 1;
			
			if ((ctrlText 2) != "") then {
				ctrlSetText [2, ""]; // OUTPUT
				GVAR(calcInput) set [2, ""];
			};
			
			if (_text != "") then {
				
				_textArray = toArray(_text);
				
				_resizeSize = _textArray call FUNC(searchForFunc);
				
				_textArray resize _resizeSize;
				
				_text = toString(_textArray);
				
				ctrlSetText [1, _text]; // INPUT
				
				GVAR(calcInput) set [1, _text];
			};
			
		};
		//-----------------------------------------------------------------------------------
		case "clear": {
			
			ctrlSetText [1, ""]; // INPUT
			ctrlSetText [2, ""]; // OUTPUT
			
			GVAR(calcInput) set [1, ""];
			GVAR(calcInput) set [2, ""];
			
		};
		//-----------------------------------------------------------------------------------
		case "=": {
			
			_text = ctrlText 1;
			_textArray = toArray(_text);
			_injections = [];
			
			if ((count _textArray) > 0) then {
				
				// I might need to use this recursive search later :)
				/*
					// Begin Calculations
					for "_i" from 0 to ((count _textArray) - 1) do {
						
						_searchText = ["A", "N", "S"] call FUNCMAIN(toUnicodeDecimal);
						
						// Begin search for the ANS(wer), if there is one
						if ((_textArray select _i) == (_searchText select 0)) then {
							if ((_textArray select (_i + 1)) == (_searchText select 1)) then {
								if ((_textArray select (_i + 2)) == (_searchText select 2)) then {
									// Then Finally we found the ANS(wer) lol
									DOSOMETHINGLIKEINJECTIONHERE
								};
							};
						};
						// End the search ---
					};
				*/
				
				_codeToExecute = toString(_textArray);
				
				ANS = GVAR(calcInput) select 3; // HA! Easiest way :) but sadly it can be used by idiots :/
				
				_result = call compile _codeToExecute;
				
				if ((format["X%1X", str(_result)]) == "XX") then { // ERROR, ugly coding since I cannot check for <null> element types.
					_text = "ERROR";
				} else {
					_text = str(_result);
				};
				
				ctrlSetText [2, _text]; // OUTPUT
				GVAR(calcInput) set [2, _text];
				GVAR(calcInput) set [3, _result];
				
			};
			
		};
		//-----------------------------------------------------------------------------------
		
	};
	
} else {
	
	// Simple Operator Handling -------------------------------------------------------------

	if ((_call in _simpleOperators) OR (_call in _semiSimpleOperators)) then {
		
		_text = ctrlText 1;
		
		if ((ctrlText 2) != "") then {
			["clear"] call FUNC(calculatorGUI);
		};
		
		if (_text == "") then {
			if (_call in _semiSimpleOperators) then {
				if (_call == ".") then {
					_text = "0";
				} else {
					_text = "ANS";
				};
			};
		};
		
		_text = _text + _call;
		
		ctrlSetText [1, _text]; // INPUT
		
		GVAR(calcInput) set [1, _text];
		
	};
};