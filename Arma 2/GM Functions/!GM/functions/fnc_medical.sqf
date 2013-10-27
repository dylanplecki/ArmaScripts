
GM_fnc_giveBandage = {
	private ["_unitName"];
	_unitName = _this select 0;
	[
		_unitName,
		{[player, _this] call ace_sys_wounds_fnc_RemoveBleed;},
		'ACE_Bandage'
	] call GM_fnc_execOnPlayer;
};

GM_fnc_giveLargeBandage = {
	private ["_unitName"];
	_unitName = _this select 0;
	[
		_unitName,
		{[player, _this] call ace_sys_wounds_fnc_RemoveBleed;},
		'ACE_LargeBandage'
	] call GM_fnc_execOnPlayer;
};

GM_fnc_giveTourniquet = {
	private ["_unitName"];
	_unitName = _this select 0;
	[
		_unitName,
		{[player, _this] call ace_sys_wounds_fnc_RemoveBleed;},
		'ACE_Tourniquet'
	] call GM_fnc_execOnPlayer;
};

GM_fnc_removeTourniquet = {
	private ["_unitName"];
	_unitName = _this select 0;
	[
		_unitName,
		{player spawn compile preProcessFileLineNumbers "\x\ace\addons\sys_wounds\self_CATremove.sqf";},
		[]
	] call GM_fnc_execOnPlayer;
};

GM_fnc_giveMorphine = {
	private ["_unitName"];
	_unitName = _this select 0;
	[
		_unitName,
		{player call ace_sys_wounds_fnc_RemovePain;},
		[]
	] call GM_fnc_execOnPlayer;
};

GM_fnc_giveEpi = {
	private ["_unitName"];
	_unitName = _this select 0;
	[
		_unitName,
		{player call ace_sys_wounds_fnc_RemoveUncon;},
		[]
	] call GM_fnc_execOnPlayer;
};

GM_fnc_giveMedkit = {
	private ["_unitName"];
	_unitName = _this select 0;
	[
		_unitName,
		{['ace_sys_wounds_heal', [(_this select 0), 0]] call ACE_fnc_receiverOnlyEvent;},
		[]
	] call GM_fnc_execOnPlayerLocal;
};