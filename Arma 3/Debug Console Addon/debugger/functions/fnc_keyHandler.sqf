#include "\x\uo\addons\debugger\script_component.hpp"

private["_handled", "_display", "_ctrl", "_keyCode", "_shift", "_alt", "_allowed"];

_display = _this select 0;
_keyCode = _this select 1;
_shift = _this select 2;
_ctrl = _this select 3;
_alt = _this select 4;
  
_handled = false;

// Are we allowed to use debug commands?
_allowed = call FUNC(checkAllowed);

if (_allowed) then {
	
	// CTRL + SHIFT + [KEYCODE]
	if (_ctrl && _shift && !_alt && _keyCode == GVAR(keyCode)) then {
		/*
		// Not Needed?
		if (isnull (finddisplay 26)) then {
			createDialog "RscDisplayDebugPublicTricker";
		};
		createDialog "RscDisplayDebugPublicMod";
		*/
		createDialog "RscDisplayDebugUO"; // BASIC
		_handled = true;
	};
	
	// CTRL + SHIFT + ALT + [KEYCODE]
	if (_ctrl && _shift && _alt && _keyCode == GVAR(keyCode)) then {
		createDialog "RscDisplayDebug"; // ADVANCED
		_handled = true;
	};
};

_handled;