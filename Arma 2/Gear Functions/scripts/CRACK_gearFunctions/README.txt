//   _____   _____                _____   _  __        ____    _____    ____               _______ 
//  / ____| |  __ \      /\      / ____| | |/ /       / __ \  |  __ \  |  _ \      /\     |__   __|
// | |      | |__) |    /  \    | |      | ' /       | |  | | | |__) | | |_) |    /  \       | |   
// | |      |  _  /    / /\ \   | |      |  <        | |  | | |  _  /  |  _ <    / /\ \      | |   
// | |____  | | \ \   / ____ \  | |____  | . \       | |__| | | | \ \  | |_) |  / ____ \     | |   
//  \_____| |_|  \_\ /_/    \_\  \_____| |_|\_\       \____/  |_|  \_\ |____/  /_/    \_\    |_|   
//
//*************************************************************************************************
//
// README
//
//*************************************************************************************************

Call this in the init.sqf (top-most preferably) for all machines:
	
	_handle = [] execVM "scripts\CRACK_gearFunctions\init.sqf";
	waituntil {scriptDone _handle};
	
//*************************************************************************************************

Here's the syntax for after the init above: (NOTE: for the strings, put "" to keep empty, for the arrays put [])

	[_man, "PrimaryWeapon", "SecondaryWeapon", "OnBack", "ACE_OnBack", _items, _optics, _pMags, _sMags, _rWeapons, _rItems, _rpMags, _rsMags, _IFAK, _earPlugs] call CRACK_fnc_setLoadout;

		_man = player; // Or 'this' if placed in a unit's init field
		
		_items = ["Item", "Item", "Item", "Item"]; // Up to 12
		
		_optics = ["Optic", "Optic"]; // Up to 2
		
		_pMags = ["PrimaryMagazine", "PrimaryMagazine", "PrimaryMagazine", "PrimaryMagazine"]; // Up to 12
		_pMags = [["PrimaryMagazine", Count], ["PrimaryMagazine", Count], ["PrimaryMagazine", Count]]; // Up to 12 Total
		
		_sMags = ["SecondaryMagazine", "SecondaryMagazine", "SecondaryMagazine", "SecondaryMagazine"]; // Up to 8
		_sMags = [["SecondaryMagazine", Count], ["SecondaryMagazine", Count], ["SecondaryMagazine", Count]]; // Up to 8 Total
		
		_rWeapons = ["Weapon", "Weapon"]; // Rucksack - Unlimited
		
		_rItems = ["Item", "Item", "Item", "Item"]; // Rucksack - Unlimited
		
		_rpMags = ["PrimaryMagazine", "PrimaryMagazine", "PrimaryMagazine", "PrimaryMagazine"]; // Rucksack - Unlimited
		_rpMags = [["PrimaryMagazine", Count], ["PrimaryMagazine", Count], ["PrimaryMagazine", Count]]; // Rucksack - Unlimited
		
		_rsMags = ["SecondaryMagazine", "SecondaryMagazine", "SecondaryMagazine", "SecondaryMagazine"]; // Rucksack - Unlimited
		_rsMags = [["SecondaryMagazine", Count], ["SecondaryMagazine", Count], ["SecondaryMagazine", Count]]; // Rucksack - Unlimited
		
		_IFAK = 1; // Set 1 for a full IFAK, 0 for nothing
		
		_earPlugs = 1; // Set 1 for Ear Protection, 0 for nothing