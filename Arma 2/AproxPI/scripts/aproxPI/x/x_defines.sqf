
// Constants - Use these to override

#define SCRIPTPATH scripts\aproxPI

#define DFT_ITERATIONS		50
#define DFT_SUBITERATIONS	10000
#define DFT_OUTPUTCTRL		AproxPI_outputCtrlIDC
#define DFT_METHOD			"montecarlo"
#define DFT_LOAD			true
#define DFT_REPORT			true
#define DFT_TIMEPRECISION	4
#define DFT_PIPRECISION		4

#define TIMEMETHOD			diag_tickTime
#define STARTTEXT			("AproxPI Simulation")
#define ENDTEXT(method)		("AproxPI Simulation (" + method + ") has finished.")

/////////////////////////////////////////////////

// QUOTE - Simple Enough
#define QUOTE(var1) #var1

// PATH - Generate a path for a file (var) based on SCRIPTPATH
#define PATH(var) QUOTE(SCRIPTPATH\var)

// REALPI - Gets the accepted value of PI
#define REALPI \
(parseNumber (preProcessFile QUOTE(SCRIPTPATH\x\ref_pi.txt)))

// CTRLNUM - Parse a number from a control (con)
#define CTRLNUM(con) \
(parseNumber(ctrlText con))

// LBCURTXT - Get the currently selected text from an LB control (con)
#define LBCURTXT(con) \
(lbText [con, (lbCurSel con)])

// ROUNDRE - A "real" version of round() which round a value (val) and incorporates decimal precision (prec)
#define ROUNDRE(val,prec) \
((round(val * (10 ^ prec))) / (10 ^ prec))

// IFSETARG - Checks _this for index (ind) and sets the variable (var) to the value, if not available sets to default (dft)
#define IFSETARG(var,ind,dft) \
var = if ((count _this) > ind) then {_this select ind} else {dft}

// IFDIAG - Checks for an open dialog and ctrl index (ind), then proceeds
#define IFDIAG(ind) \
if (dialog AND (ind >= 0))

// REPORT - If enabled (enabled), it reports via control (ind) or else reverts to hinting, uses text (txt) and variable loading screen (loadScn)
#define REPORT(enabled,loadScn,ind,txt) \
if (enabled) then { \
	if (loadScn) then { \
		startLoadingScreen [txt, "aproxPI_loadingScreen"]; \
	} else { \
		IFDIAG(ind) then { \
			ctrlSetText [ind, txt]; \
		} else { \
			hint txt; \
		}; \
	}; \
}

// DBLRAND - A double-encompassing random number gen, pos + neg
#define DBLRAND(radius) \
radius - (2 * random(radius))