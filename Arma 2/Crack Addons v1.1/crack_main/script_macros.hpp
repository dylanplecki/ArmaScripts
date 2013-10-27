#include "\x\cba\addons\main\script_macros_common.hpp"

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2

// RGB Colors
#define RGB_GREEN 0, 0.5, 0, 1
#define RGB_BLUE 0, 0, 1, 1
#define RGB_ORANGE 0.5, 0.5, 0, 1
#define RGB_RED 1, 0, 0, 1
#define RGB_YELLOW 1, 1, 0, 1
#define RGB_WHITE 1, 1, 1, 1
#define RGB_GRAY 0.5, 0.5, 0.5, 1
#define RGB_BLACK 0, 0, 0, 1
#define RGB_MAROON 0.5, 0, 0, 1
#define RGB_OLIVE 0.5, 0.5, 0, 1
#define RGB_NAVY 0, 0, 0.5, 1
#define RGB_PURPLE 0.5, 0, 0.5, 1
#define RGB_FUCHSIA 1, 0, 1, 1
#define RGB_AQUA 0, 1, 1, 1
#define RGB_TEAL 0, 0.5, 0.5, 1
#define RGB_LIME 0, 1, 0, 1
#define RGB_SILVER 0.75, 0.75, 0.75, 1

// Some Functions for Functions
#define PATHTO_FUNC(var1,var2,var3) \MAINPREFIX\##var1\SUBPREFIX\##var2\f\##var3.sqf
#define COMPILE_FILE_FUNC(var1,var2,var3) COMPILE_FILE2_SYS('PATHTO_FUNC(var1,var2,var3)')
#define PREP_FUNC2(var1,var2,var3,var4) ##var1##_##var2##_fnc_##var4 = COMPILE_FILE_FUNC(var1,var3,DOUBLES(fnc,var4))
#define PREPFUNC(var1) PREP_FUNC2(PREFIX,COMPONENT,COMPONENT_F,var1)

// Some Functions for the API
#define PATHTO_API(var1,var2,var3) \MAINPREFIX\##var1\SUBPREFIX\##var2\api\##var3.sqf
#define COMPILE_FILE_API(var1,var2,var3) COMPILE_FILE2_SYS('PATHTO_API(var1,var2,var3)')
#define PREP_API2(var1,var2,var3,var4) ##var1##_##var2##_fnc_##var4 = COMPILE_FILE_API(var1,var3,DOUBLES(fnc,var4))
#define PREPAPI(var1) PREP_API2(PREFIX,COMPONENT,COMPONENT_F,var1)

// Some Functions for TEST
#define PATHTO_TEST(var1,var2,var3) \MAINPREFIX\##var1\SUBPREFIX\##var2\test\##var3.sqf
#define COMPILE_FILE_TEST(var1,var2,var3) COMPILE_FILE2_SYS('PATHTO_TEST(var1,var2,var3)')
#define PREP_TEST2(var1,var2,var3,var4) ##var1##_##var2##_fnc_##var4 = COMPILE_FILE_TEST(var1,var3,DOUBLES(fnc,var4))
#define PREPTEST(var1) PREP_TEST2(PREFIX,COMPONENT,COMPONENT_F,var1)

// Some functions for MAIN
#define PREP_FUNCMAIN(var1,var2,var3) ##var1##_fnc_##var3 = COMPILE_FILE_FUNC(var1,var2,DOUBLES(fnc,var3))
#define PREPMAINFUNC(var1) PREP_FUNCMAIN(PREFIX,MAINLOGIC,var1)