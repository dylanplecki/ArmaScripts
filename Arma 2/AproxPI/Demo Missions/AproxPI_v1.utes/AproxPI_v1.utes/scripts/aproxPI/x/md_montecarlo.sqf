
/************************************************
*		AproxPI (montecarlo)
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

#include "x_defines.sqf"

private ["_i", "_subi", "_ctrl", "_method", "_load", "_ui", "_timePrec", "_piPrec", "_percPrec", "_r", "_results", "_timeAdd"];

IFSETARG( _i, 0, DFT_ITERATIONS );
IFSETARG( _subi, 1, DFT_SUBITERATIONS );
IFSETARG( _ctrl, 2, DFT_OUTPUTCTRL );
IFSETARG( _method, 3, DFT_METHOD );
IFSETARG( _ui, 4, DFT_REPORT );
IFSETARG( _load, 5, DFT_LOAD );
IFSETARG( _timePrec, 6, DFT_TIMEPRECISION );
IFSETARG( _piPrec, 7, DFT_PIPRECISION );

_percPrec	= _piPrec - 2;
_r			= [];
_results	= [];
_timeAdd	= 0;

for "_f" from 1 to _i do {
	
	private ["_startTime", "_endTime", "_radius", "_sArea", "_aproxPI", "_t", "_h", "_dTime"];
	
	// Some constants
	_radius		= 1;
	_sArea		= (_radius)^2;
	_t			= 0;
	_h			= 0;
	
	_startTime	= TIMEMETHOD;
	
	// Main Method ----------------------------------
	
	while {_t < _subi} do {
		
		_x = random(_radius);
		_y = random(_radius);
		
		_ceil = sqrt( (_radius)^2 - (_x)^2 );
		
		if (_y <= _ceil) then {
			_h = _h + 1;
		};
		
		_t = _t + 1;
	};
	
	_aproxPI = (_h / _t) * 4;
	
	// End Main Method ------------------------------
	
	_endTime	= TIMEMETHOD;
	_dTime		= _endTime - _startTime;
	
	_results	= _results + [[_dTime, _aproxPI, _t]];
	_timeAdd	= _timeAdd + _dTime; // Workaround due to serialization
	
	if (_load) then {
		with uiNamespace do {
			progressLoadingScreen (_f / _i);
			(AproxPI_loadingScreenIDD displayctrl 8404) ctrlSetText ("Currently estimating the value of PI (via " + _method + ")\n" +
															  "Iteration: " + str(_f) + " of " + str(_i) +
															  " | Time: " + str(ROUNDRE(_timeAdd,10)) + " Seconds\n" +
															  "Last AproxPI: " + str(_aproxPI));
		};
	};
};

private ["_resultCount", "_avgTime", "_avgPI", "_totalTime", "_totalPI", "_totalSubi", "_timeStandDev", "_piStandDev", "_piDif", "_piPercentError"];

_resultCount	= count _results;
_totalTime		= 0;
_totalPI		= 0;
_totalSubi		= 0;
_timeStandDev	= 0;
_piStandDev		= 0;

{
	_totalTime	= _totalTime + (_x select 0);
	_totalPI	= _totalPI + (_x select 1);
	_totalSubi	= _totalSubi + (_x select 2);
} forEach _results;

_avgTime		= (_totalTime / _resultCount);
_avgPI			= (_totalPI / _resultCount);

{
	_timeStandDev = _timeStandDev + ((_x select 0) - _avgTime)^2;
	_piStandDev = _piStandDev + ((_x select 1) - _avgPI)^2;
} forEach _results;

_timeStandDev = sqrt(_timeStandDev / _resultCount);
_piStandDev = sqrt(_piStandDev / _resultCount);
_piDif = abs(REALPI - _avgPI);
_piPercentError = (_piDif / REALPI) * 100;

_endText	= "\n" + ENDTEXT(_method) + "\n\n" +
			  "Total Time: " + str(ROUNDRE(_totalTime,_timePrec)) + " seconds\n" +
			  "Method Ran: " + _method + " \n" +
			  "Iterations: " + str(_i) + "\n" +
			  "Average Iteration Time: " + str(ROUNDRE(_avgTime,_timePrec)) + " seconds\n" +
			  "Total Exectutions of the Method: " + str(_totalSubi) + "\n\n" +
			  "AproxPI: " + str(ROUNDRE(_avgPI,_piPrec)) + "\n" +
			  "Accepted Value of PI: " + str(ROUNDRE(REALPI,_piPrec)) + "\n\n" +
			  "Raw Error: " + str(ROUNDRE(_piDif,_piPrec)) + "\n" +
			  "Percent Error: " + str(ROUNDRE(_piPercentError,_percPrec)) + "%\n" +
			  "Standard Deviation of Time: " + str(ROUNDRE(_timeStandDev,_timePrec)) + " seconds\n" +
			  "Standard Deviation of AproxPI: " + str(ROUNDRE(_piStandDev,_piPrec));

_r = [_totalTime, _avgPI, _endText];

_r