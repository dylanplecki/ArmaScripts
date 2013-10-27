
private ["_instructors", "_medics", "_isInstructor", "_medicalAbility"];

_instructors		= [Instructor1];
_medics				= [];

_isInstructor		= player in _instructors;
_hasMedicalAbility	= (player in _medics) OR _isInstructor;

cm_handleDamage_defaults = [
	
	[ // 0
		"cm_hd_script",
		"cm_handleDamage_hds_hintOnHit_hint" // Options: "cm_handleDamage_hds_hintOnHit_hint", "ACE_Wounds"
	],
	
	[ // 1
		"cm_hd_hintOnHit_params",
		[ // Array of Boolean values
			true,				// 0 - Allow player to check their own damage
			_hasMedicalAbility,	// 1 - Allow player to change their own damage
			_isInstructor,		// 2 - Allow player to turn off/on his Hint-on-Hit
			_hasMedicalAbility,	// 3 - Allow player to check other units' damages
			_hasMedicalAbility,	// 4 - Allow player to change other units' damages
			_isInstructor		// 5 - Allow player to turn off/on other units Hint-on-Hit
		]
	]
	
];