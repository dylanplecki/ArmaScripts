
private ["_call"];

_call = _this select 0;

switch (_call) do {
	
	case "create": {
		
		private ["_params", "_type", "_unit"];
		
		_params = _this select 1;
		
		_type	= _params select 0;
		_unit	= _params select 1;
		
		createDialog "cm_handleDamage_hintOnHit_setDamage";
		
		ctrlSetText [98, (name _unit)];
		
		cm_handleDamage_diagHintOnHit_type = _type;
		
	};
	
	/////////////////////////////////////////////
	
	case "load": {
		
		private ["_damArray"];
		
		_damArray = cm_siTarget getVariable ["cm_handleDamage_localDamArray", cm_handleDamage_dft_localDamArray];
		
		waitUntil {dialog};
		
		for "_i" from 0 to 4 do {
			
			private ["_dam"];
			
			_dam = (round((_damArray select _i) * 10000)) / 100; // Rounds to hundreths place
			
			ctrlSetText [(_i + 1), str(_dam)];
		};
		
		[] spawn {
		
			private ["_tooFar"];
			
			waitUntil {
				_tooFar = (player distance cm_siTarget) > 15;
				_tooFar or !dialog;
			};
			
			if (_tooFar AND dialog) then {
				closeDialog 70529;
			};
		};
	};
	
	/////////////////////////////////////////////
	
	case "save": {
		
		private ["_damArray", "_exit"];
		
		_exit = false;
		
		_damArray = [
			ctrlText 1, // Overall
			ctrlText 2, // Head
			ctrlText 3, // Body
			ctrlText 4, // Hands
			ctrlText 5  // Legs
		];
		
		for "_i" from 0 to (count _damArray - 1) do {
			
			private ["_dam", "_num"];
			
			_dam = _damArray select _i;
			
			_num = parseNumber _dam;
			
			if ((_num == 0) && !(_dam in ["0", "0.0", "0.00", "0%", "0.0%", "0.00%"])) exitWith {
				hint "You have provided an invalid number!";
				_exit = true;
			};
			
			_damArray set [_i, (_num / 100)];
			
		};
		
		if (_exit) exitWith {};
		
		_damArray = _damArray + [diag_tickTime];
		
		[cm_handleDamage_diagHintOnHit_type, _damArray] call cm_handleDamage_hds_hintOnHit_setPlayerDamage;
		
		closeDialog 70529;
		
	};
	
	/////////////////////////////////////////////
	
};