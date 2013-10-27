#include "\x\crack\addons\notepad\script_component.hpp"

_allowed = false;

if (!isdedicated) then {

	// Because ARMA doesn't use LAZY evaluations
	if (GVAR(addonEnabled) AND !GVAR(notepadInUse) AND (GVAR(notepadEnabled) OR GVAR(remindersEnabled) OR GVAR(calculatorEnabled))) then {
		if ((side player) in GVAR(enabledSides)) then {
			
			if (!alive player) exitwith {};
			
			_allowed = true;
			
			if (!isnil QUOTE(GVAR(enabledUnits))) then {
				if !(player in GVAR(enabledUnits)) then {
					_allowed = false; // Player is not in units that can use Notepad
				};
			};
		};
	};
	
};

_allowed