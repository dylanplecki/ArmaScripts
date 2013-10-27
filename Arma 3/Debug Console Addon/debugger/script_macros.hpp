#include "\x\cba\addons\main\script_macros_common.hpp"

// Some Functions for Functions
#define PATHTO_FUNC(var1,var2,var3) COMPONENTPATH\functions\##var3.sqf
#define COMPILE_FILE_FUNC(var1,var2,var3) compile preProcessFileLineNumbers 'PATHTO_FUNC(var1,var2,var3)'
#define PREP_FUNC2(var1,var2,var3,var4) ##var1##_##var2##_fnc_##var4 = COMPILE_FILE_FUNC(var1,var3,DOUBLES(fnc,var4))
#define PREPFUNC(var1) PREP_FUNC2(PREFIX,COMPONENT,COMPONENT_F,var1)

// Some Functions for Support
#define PATHTO_SUPT(var1) COMPONENTPATH\support\##var1.sqf
#define COMPILE_FILE_SUPT(var1) compile preProcessFileLineNumbers 'PATHTO_SUPT(var1)'