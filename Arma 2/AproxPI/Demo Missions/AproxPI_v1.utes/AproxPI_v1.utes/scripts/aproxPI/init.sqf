
/************************************************
*		AproxPI
*
*		Author:			Naught (dylanplecki@gmail.com)
*		Description:	A simple benchmarking tool.
*		Parameters:		None.
*		Returns:		None.
*		Notes:			The current methods consist of:
*							- "montecarlo"
*
************************************************/

#include "x\x_defines.sqf"

// [Semi] Constants
AproxPI_methods			= ["montecarlo"]; // First is default

// Functions
AproxPI_fnc_loadBench	= compile preProcessFileLineNumbers PATH(x\fnc_loadBench.sqf);
AproxPI_fnc_popDialog	= compile preProcessFileLineNumbers PATH(x\fnc_populateDialog.sqf);

// Main Class
AproxPI_main			= compile preProcessFileLineNumbers PATH(aproxPI.sqf);