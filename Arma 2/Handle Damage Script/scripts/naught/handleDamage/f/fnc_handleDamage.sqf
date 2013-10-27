/************************************************
	
	//	Handle Damage EH Function
	//		Made for UOTC Courses
	
	0: injured [Object]
	1: part hit [String]
	2: new overall part damage [Number]
	3: injurer [Object]
	4: class of ammo causing the damage [String]

	For each hit this EH triggers 5 times within a frame, always in this sequence of parts:
	1. "" - info on overall damage
	2. "head_hit"
	3. "body"
	4. "hands"
	5. "legs"

	Multiple hits within one frame are handled one by one, not causing mixups
	(1-2-3-4-5 - 1-2-3-4-5  - etc)

	All 5 will trigger if at least 1 of the parts receives non-zero damage.
	Damage values causing the triggering may be as low as 0.0001, so filtering might be advised.

	Triggered by falling or collisions returns the unit itself as the injurer, ammo class is an empty string.
	Example: [unit1,"head_hit",0.000253947,unit1,""]

	Damage in destroyed vehicles only triggers the 1st type (""), then unit ejects.

	using BIS configs:
	head_hit:
	armor = 0.6;  ==  no helmet
	armor = 0.7; == for example pilot helmet
	armor = 0.85; == normal helmet

	body:
	armor = 1;
	passThrough = 0.8; == bulletproof west

	armor = 0.8;
	passThrough = 1; == NO bulletproof west

	The following hit-parts accumulate their damage instead of each time only show the damage made by the current hit.
	* ""
	* "head_hit"
	* "body"

	Returning 1 or above to the following parts, will kill the unit
	* "head_hit"
	* "body"
	* ""

	setDamage will override the visual wounds on the units.
	setHit properly sets the visual wounds on the units.
	
************************************************/

private ["_injuredUnit", "_return"];

_injuredUnit	= _this select 0;
_return			= 0;

if (local _injuredUnit) then {
	
	private ["_injuredPart", "_partDamage", "_injurer", "_ammoClass"];
	
	_injuredPart	= _this select 1;
	_partDamage		= _this select 2;
	_injurer		= _this select 3;
	_ammoClass		= _this select 4;
	
	if (_injuredUnit getVariable ["cm_hd_allowDamage", true]) then {
		
		private ["_cmScript", "_script"];
		
		_cmScript = [];
		_script = player getVariable ["cm_hd_script", ""];
		
		switch (_script) do {
			
			case "cm_handleDamage_hds_hintOnHit_hint": { // Hint On Hit
				_cmScript = [_script, true, "[_this, (localize 'STR_HINTONHIT_HIT')]"];
			};
			
			default { // By default reverts back to the ACE Wounds System
				_return = _this call ace_sys_wounds_fnc_hd;
			};
		};
		
		if ((count _cmScript) > 0) then {
			_return = [_this, _cmScript] call cm_handleDamage_fnc_addHit;
		};
	};
};

_return