
#include "x_defines.sqf"

if (dialog) then {
	
	// Add some background blur effects
	'dynamicBlur' ppEffectEnable true;
	'dynamicBlur' ppEffectAdjust [1.6];
	'dynamicBlur' ppEffectCommit 0;
	
	{
		lbAdd [1, _x];
		lbAdd [4, _x];
	} forEach AproxPI_methods;
	
	lbSetCurSel [1, 0];
	lbSetCurSel [4, 0];
	
	ctrlSetText [2, str(DFT_ITERATIONS)];
	ctrlSetText [3, str(DFT_SUBITERATIONS)];
	ctrlSetText [5, str(DFT_TIMEPRECISION)];
	ctrlSetText [6, str(DFT_PIPRECISION)];
};