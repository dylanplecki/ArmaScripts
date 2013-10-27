
/************************************************
*		AproxPI
*
*		Author:			Naught (dylanplecki@gmail.com)
*		Description:	A simple benchmarking tool.
*		Parameters:		0 - Number of Iterations to run. (number)
*						1 - Number of Sub-Iterations to run. (number)
*						2 - Control for output. (number)
*						3 - Method to use. (string)
*						4 - Enable built-in reporting. (boolean)
*						5 - Enable loading screen. (boolean)
*						6 - Output Time Precision. (number)
*						7 - Output PI Precision. (number)
*		Returns:		Completion time in seconds. (number)
*		Notes:			None.
*
************************************************/

#include "x\x_defines.sqf"

private ["_i", "_subi", "_ctrl", "_method", "_load", "_ui", "_timePrec", "_piPrec", "_r"];

IFSETARG( _i, 0, DFT_ITERATIONS );
IFSETARG( _subi, 1, DFT_SUBITERATIONS );
IFSETARG( _ctrl, 2, DFT_OUTPUTCTRL );
IFSETARG( _method, 3, DFT_METHOD );
IFSETARG( _ui, 4, DFT_REPORT );
IFSETARG( _load, 5, DFT_LOAD );
IFSETARG( _timePrec, 6, DFT_TIMEPRECISION );
IFSETARG( _piPrec, 7, DFT_PIPRECISION );

_r			= [];

_script		= preProcessFileLineNumbers (QUOTE(SCRIPTPATH) + "\x\" + "md_" + _method + ".sqf");

if (_script != "") then {
	
	private ["_results"];
	
	REPORT( _ui, _load, _ctrl, STARTTEXT );
	
	_results	= _this call compile _script; // Must Return: [_totalTime, _aproxPI, _endText]
	
	if (_load) then {endLoadingScreen};
	
	_endText	= _results select 2;
	
	REPORT( _ui, false, _ctrl, _endText );
	
} else {
	
	private ["_msg"];
	_msg	= "CRITICAL: AproxPI: An invalid method (" + _method + ") has been provided to the script.";
	
	diag_log text(_msg);
	hint _msg;
};

_r