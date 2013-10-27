#define __check configFile >> "CfgIdentities" >> "Identity" >> "name"

if (!isDedicated) then {
  waitUntil {!isNull player};
  
  _earplugs = {
    if ( ((getText(__check) == "") || (getText(__check) != (name player))) && isMultiplayer ) then { // indentity incorrect
      // don't wait
    } else { // wait for init
      waitUntil { sleep 0.5; _earplugs = player getVariable "ace_sys_goggles_earplugs"; !isNil "_earplugs" };
    };
    player setVariable ["ace_sys_goggles_earplugs", true, false];
    player setVariable ["ace_ear_protection", true, false];
  };

  [] spawn _earplugs;
  ["sandi_framework_respawnedLocal", { [] spawn _earplugs; }] call CBA_fnc_addEventHandler;
};