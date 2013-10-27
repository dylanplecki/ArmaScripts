#include "defines.hpp"

private ["_result", "_nearPlayers"];

// Hint the surrounding players that the target is surrendering.
_nearPlayers = [player, GVAR(runAwayHintRadius)] call FUNC(getNearEnemies);

// START - Hinted this out for now, for Headshot's benefit
	/*
	if ((count _nearPlayers) > 0) exitwith {
		hint "You can't run now, there are still enemies near you!";
	};
	*/
// END HINTED OUT CODE

[player] call FUNC(removeAllActions);

// Executing things to reverse surrender action
_result = player getvariable QUOTE(GVAR(surrenderedStatus));
_result set [0, false];
player setvariable [QUOTE(GVAR(surrenderedStatus)), _result, true];
player setCaptive false;
terminate GVAR(scriptHandle_noWeaponScript);
GVAR(scriptHandle_noWeaponScript) = nil;

["CRACK_ceh_hintSurrender", [_nearPlayers, player, "%1 is running away!!!"]] call CBA_fnc_globalEvent;

[player] call FUNC(addSurrenderAction);