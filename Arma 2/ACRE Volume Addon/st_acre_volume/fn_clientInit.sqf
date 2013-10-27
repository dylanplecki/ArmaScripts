/************************************************
*
*	ShackTac ACRE Volume v1.1
*		Original by dslyecxi  (7/24/2012) (v1.0)
*		Major edits by Naught (7/23/2013) (v1.1)
*
*************************************************
*
*	Changelog:
*	v1.1
*		- Added the mission global variable
*		  'stacre_VolumeLevels' to allow for the
*		  changing of volume levels in-game.
*		- Fixed low ACRE 3D volume, now defaults
*		  to 100% instead of 70%.
*		- Fixed off-center 'Normal' slider text.
*		- Removed informational output and
*		  unnecessary diag init at mission start.
*		- Replaced redundant code and variables
*		  and functionalized.
*	v1.0
*		- Orginal script released by dslyecxi.
*
************************************************/

private ["_haveACRE","_haveJaylib"];

_haveACRE =  isClass (configFile >> "CfgPatches" >> "ACRE_MAIN");
_haveJaylib =  isClass (configFile >> "CfgPatches" >> "jayarma2lib_main");

if ((!_haveAcre) || (!_haveJaylib)) exitWith {}; // Won't run this if someone isn't running ACRE/Jaylib 

/* Settings */

stacre_VolumeLevels			= [0.1, 0.4, 0.7, 1, 1.3, 1.45, 1.6]; // Should be an odd count for aesthetics
stacre_DftVolumeLevelIndex	= 3; // Default volume level index, should be middle of VolumeLevels
stacre_debug_volume			= false; // Debug

/************/

stacre_Keyblock = false;

fn_stacre_GetVolumeLimits =
{
	private ["_max", "_return"];
	_max = (count stacre_VolumeLevels) - 1;
	_return = [0, _max];
	_return;
};

fn_stacre_VolAdjustDiag =
{
	disableSerialization;
	private ["_slider"]; 
	57701 cutRsc ["st_acre_VolumeAdjustDialog", "PLAIN"];
	
	_slider = (st_acre_VolumeAdjustDialog_Var select 0) displayCtrl 1900;
	_slider sliderSetRange (call fn_stacre_GetVolumeLimits);

	_slider ctrlSetEventHandler ["SliderPosChanged","_this call fn_stacre_SliderChanged"];
	_slider sliderSetPosition stacre_VolumeLevelIndex;
};

fn_stacre_VolumeDialogKeyHandler = 
{
	if (((_this select 1) in (actionKeys "PushToTalkDirect")) && (!stacre_Keyblock) && (alive player) && (time > 1)) then 
	{
		stacre_Keyblock = true; 
		[] call fn_stacre_VolAdjustDiag;	
	};
};

fn_stacre_VolumeDialogKeyHandler_Up = 
{	
	if ((_this select 1) in (actionKeys "PushToTalkDirect") && (alive player)) then 
	{
		disableSerialization; 
		stacre_Keyblock = false; 
		57701 cutRsc ["Default", "PLAIN"];
		call fn_stacre_CloseVolume;
	};
};

fn_stacre_AdjustVolume =
{
	private ["_amount", "_limits", "_volumeLevelIndex"]; 
	_amount = _this select 1;
	_limits = call fn_stacre_GetVolumeLimits;
	_volumeLevelIndex = stacre_VolumeLevelIndex;
	
	if ((!alive player) || (time < 2)) exitWith {}; 
	
	if (isNull (st_acre_VolumeAdjustDialog_Var select 0)) exitWith {};
	
	if (_amount > 0) then 
	{
		_volumeLevelIndex = _volumeLevelIndex + 1; 
		if (_volumeLevelIndex > (_limits select 1)) then {_volumeLevelIndex = (_limits select 1);};
	} 
	else
	{
		_volumeLevelIndex = _volumeLevelIndex - 1; 
		if (_volumeLevelIndex < (_limits select 0)) then {_volumeLevelIndex = (_limits select 0);};
	};
	
	stacre_VolumeLevelIndex = _volumeLevelIndex;
	
	_slider = (st_acre_VolumeAdjustDialog_Var select 0) displayCtrl 1900;
	
	_slider sliderSetPosition stacre_VolumeLevelIndex;
};

fn_stacre_CloseVolume =
{
	if (!alive player) exitWith {};
	
	private ["_factor", "_currentVolume"];
	
	if (stacre_VolumeLevelIndex < (count stacre_VolumeLevels)) then {
		_factor = stacre_VolumeLevels select stacre_VolumeLevelIndex;
	} else {
		_factor = stacre_VolumeLevels select stacre_DftVolumeLevelIndex;
	};
	_currentVolume = call acre_api_fnc_getSelectableVoiceCurve;
	if (!isNil "_currentVolume") then 
	{
		if (stacre_debug_volume) then {player sideChat format["Curv: %1  Fact: %2", _currentVolume, _factor];};
		
		if (_currentVolume != _factor) then 
		{
			[_factor] call acre_api_fnc_setSelectableVoiceCurve;
			if (stacre_debug_volume) then {player sideChat format["Set volume factor: %1", _factor];};
		};
	} 
	else 
	{
		if (stacre_debug_volume) then {player sideChat "Custom curves not set currently, oh noes."};
	};
};

fn_stacre_SliderChanged =
{
	stacre_VolumeLevelIndex = round (_this select 1);
};

fn_stacre_AddKeyEH =
{
	disableSerialization;
	
	waitUntil {private "_disp"; _disp = findDisplay 46; !isNull _disp};
	
	(findDisplay 46) displayRemoveAllEventHandlers "MouseZChanged"; // This is probably dangerous, need to find the better method. TODO. 
	
	stacre_KeyHandlerEH = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call fn_stacre_VolumeDialogKeyHandler"];
	stacre_KeyHandlerEH_Up = (findDisplay 46) displayAddEventHandler ["KeyUp", "_this call fn_stacre_VolumeDialogKeyHandler_Up"];
	stacre_KeyHandlerEH_MWheel = (findDisplay 46) displayAddEventHandler ["MouseZChanged", "_this call fn_stacre_AdjustVolume"];
};

// ACRE compat for 1.3.17+
fn_stacre_GameLoop =
{
	waitUntil {!isNil "acre_api_fnc_setSpectator" && !isNil "stacre_KeyHandlerEH_MWheel" && !isNil "acre_sys_core_ts3id" && !isNull player};
	waitUntil
	{
		stacre_VolumeLevelIndex = stacre_DftVolumeLevelIndex;
		waitUntil {(alive player) && (acre_sys_core_ts3id != -1)};
		sleep 1; 
		call fn_stacre_CloseVolume;
		sleep .5;
		waitUntil {!alive player};
		sleep 0.01;
		false;
	};
};

[] spawn fn_stacre_AddKeyEH;
[] spawn fn_stacre_GameLoop;