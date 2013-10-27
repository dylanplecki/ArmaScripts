
private ["_status", "_hintOnHit", "_status", "_return", "_statusDFT"];

_unit		= cm_siTarget;

_return		= [];
_statusDFT	= [];

if (_unit getVariable ["cm_handleDamage", false]) then {
	
	_hintOnHit	= [_unit] call cm_handleDamage_hds_hintOnHit_checkEnabled;

	_status		= player getVariable ["cm_hd_hintOnHit_params", ((cm_handleDamage_defaults select 1) select 1)];

	if (_unit == player) then { // ACE Self Interact
		
		#include "selfInteract.sqf"
		
	} else { // ACE Interact
		
		#include "interact.sqf"
		
	};
};

_return