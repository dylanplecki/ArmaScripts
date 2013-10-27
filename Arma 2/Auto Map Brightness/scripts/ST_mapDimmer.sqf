// Remember that old 1.1 version by dslyecxi? Yeah whatever, old news, zx64 saves the day.
// Modified to be togglable by Crackman
//*********************************************************************************************
//	Syntax:
//
//		nul = [] execVM "scripts\ST_mapDimmer.sqf";
//
//		Call it from the init.sqf, anything in the editor, or whatever you can think of: it just has to run on all clients
//
//*********************************************************************************************

	// Parameters
	_defaultDimmerOn = 0; // Change to 1 to default it on, 0 to default it off

//*********************************************************************************************
if (!isdedicated) then {
	if (isNil "st_map_auto_brightness_enabled") then {st_map_auto_brightness_enabled = true;};
	st_map_auto_brightness_EHID = -2;

	#define MAPCONTROL ((findDisplay 12) displayCtrl 51)
	#define MAPPOS(X,Y) (MAPCONTROL ctrlMapScreenToWorld [X,Y])

	st_map_auto_brightness_start =
	{
		if (!isdedicated) then {
			waitUntil {!isNull(MAPCONTROL)};
			
			if (st_map_auto_brightness_EHID >= 0) exitwith {hint "ShackTac Map Brightness Modification is already active!"};
			
			st_map_auto_brightness_EHID = MAPCONTROL ctrlAddEventHandler ["Draw", "call st_map_auto_brightness_OnDraw"];
		};
	};

	st_map_auto_brightness_stop =
	{
		if (!isdedicated) then {
			if (st_map_auto_brightness_EHID < 0) exitwith {hint "ShackTac Map Brightness Modification is not yet active!"};
			
			waitUntil {!isNull(MAPCONTROL)};
			MAPCONTROL ctrlRemoveEventHandler ["Draw", st_map_auto_brightness_EHID];
			st_map_auto_brightness_EHID = -2;
			
			openMap [false, false];
			openMap [true, false];
		};
	};

	st_map_auto_brightness_MaxDark = 0.7;

	st_map_auto_brightness_OnDraw =
	{
		if (st_map_auto_brightness_enabled) then
		{
			// Find the edges of the screen in world space
			private ["_topleft", "_bottomright"];
			_topleft = MAPPOS(safeZoneX, safeZoneY);
			_bottomright = MAPPOS(safeZoneX + safeZoneW, safeZoneY + safeZoneH);

			// Now figure out how to make the marker cover everything
			private ["_pos", "_width", "_height"];
			_pos = MAPPOS(0.5, 0.5);
			_width  = 1.5 * ((_bottomright select 0) - (_topleft select 0)); // 1.5 (0.5 * 3) for Multi-Monitors, it's sloppy I know. Default to 0.5
			_height = 0.5 * ((_topleft select 1)     - (_bottomright select 1));

			_alpha = st_map_auto_brightness_MaxDark min abs(sunOrMoon - 1);

			MAPCONTROL drawRectangle [
				_pos,
				_width,
				_height,
				0,
				[0, 0, 0, _alpha],
				"#(rgb,1,1,1)color(0,0,0,1)" // solid black
			];
		};
	};

	sleep .01; // So the script doesn't activate in the briefing

	_subjectIndex = player createDiarySubject ["st_brightness_toggle","Map Brightness"];

	player createDiaryRecord ["st_brightness_toggle", ["ShackTac Map Dimmer", "<br /><br /><br /><br /><font size=20>Would you like the Map Dimmer to be: <execute expression='[] spawn st_map_auto_brightness_start;'>On</execute> / <execute expression='[] spawn st_map_auto_brightness_stop;'>Off</execute></font><br /><br /><br />"]];
	
	if (_defaultDimmerOn == 1) then {[] spawn st_map_auto_brightness_start;};
};