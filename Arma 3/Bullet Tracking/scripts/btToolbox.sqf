/*
	Script: Bullet Tracking Toolbox
	File: btToolbox.sqf
	Author: Naught
*/

/*
	Function:
	NGT_fnc_hsvToRGB
	
	Group:
	API Functions
	
	Description:
	Convert HSV color array to RGB color array.
	
	Example:
	_rgb = [0,1,1,0.5] call NGT_fnc_hsvToRGB; // Returns [1,0,0,0.5]

	Parameter(s):
	_this select 0: Hue [Integer; [0,360]]
	_this select 1: Saturation [Integer; [0,1]]
	_this select 2: Value [Integer; [0,1]]
	
	Returns:
	RGB Color [Array]
*/
NGT_fnc_hsvToRGB = {
	private ["_h", "_s", "_v", "_rgb"];
	_h		= _this select 0; // Degrees [0,360]
	_s		= _this select 1; // Integer [0,1]
	_v		= _this select 2; // Integer [0,1]
	_a		= [_this, 3, 1] call BIS_fnc_param; // Integer [0,1]
	if (_h >= 0) then { // Negative is undefined
		private ["_c", "_dH", "_x", "_m"];
		_c		= _v * _s;
		_dH		= _h / 60;
		_x		= _c * (1 - abs((_dH mod 2) - 1));
		_m		= _v - _c;
		_rgb	= switch (true) do {
			case ((0 <= _dH) && (_dh < 1)): {[_c,_x,0]};
			case ((1 <= _dH) && (_dh < 2)): {[_x,_c,0]};
			case ((2 <= _dH) && (_dh < 3)): {[0,_c,_x]};
			case ((3 <= _dH) && (_dh < 4)): {[0,_x,_c]};
			case ((4 <= _dH) && (_dh < 5)): {[_x,0,_c]};
			case ((5 <= _dH) && (_dh < 6)): {[_c,0,_x]};
		};
		for "_i" from 0 to 2 do {
			_rgb set [_i, ((_rgb select _i) + _m)];
		};
	} else {_rgb = [0,0,0]};
	[_rgb, _a] call BIS_fnc_arrayPush;
};

/*
	Function:
	NGT_fnc_getMagnitudeColor
	
	Group:
	Internal Functions
	
	Description:
	Calculates color of given magnitude.
*/
NGT_fnc_getMagnitudeColor = {
	private ["_projectile", "_maxMag", "_startGrad", "_colorShifts", "_magFactor", "_color"];
	_projectile		= _this select 0;
	_maxMag			= _this select 1;
	_startGrad		= _this select 2;
	_colorShifts	= _this select 3;
	_magFactor		= 1 - (((velocity _projectile) call BIS_fnc_magnitude) / _maxMag);
	[
		((_startGrad select 0) + ((_colorShifts select 0) * _magFactor)),
		((_startGrad select 1) + ((_colorShifts select 1) * _magFactor)),
		((_startGrad select 2) + ((_colorShifts select 2) * _magFactor)),
		((_startGrad select 3) + ((_colorShifts select 3) * _magFactor))
	];
};

/*
	Function:
	NGT_fnc_bulletTracking
	
	Group:
	Internal Functions
	
	Description:
	Per-frame bullet tracking loop.
*/
NGT_fnc_bulletTracking = {
	if ((count NGT_bt_arr_bullets) > 0) then {
		private ["_removalQueue"];
		_removalQueue = [];
		{ // forEach
			private ["_maxTOF"];
			_maxTOF			= _x select 4;
			if ((_maxTOF < 0) || (diag_tickTime <= ((_x select 3) + _maxTOF))) then {
				private ["_projectile", "_positions", "_lidx"];
				_projectile		= _x select 0;
				_positions		= _x select 1;
				_lidx			= (count _positions) - 1;
				// Add Current Bullet Position
				if (!(isNull _projectile) && (((diag_frameno - (_x select 5)) mod (_x select 6)) == 0)) then {
					_lidx = _lidx + 1;
					_positions set [_lidx, [(getPos _projectile), (([_projectile, (_x select 2), (_x select 7), (_x select 8)] call NGT_fnc_getMagnitudeColor) call NGT_fnc_hsvToRGB)]];
				};
				// Draw Line
				for "_j" from 0 to (_lidx - 1) do {
					drawLine3D [((_positions select _j) select 0), ((_positions select (_j + 1)) select 0), ((_positions select _j) select 1)];
				};
			} else { // Remove Bullet
				_removalQueue = _removalQueue + [_i];
			};
		} forEach NGT_bt_arr_bullets;
		if ((count _removalQueue) > 0) then {
			[NGT_bt_arr_bullets, _removalQueue] call BIS_fnc_removeIndex;
		};
	};
};

/*
	Function:
	NGT_fnc_trackBullet
	
	Group:
	API Functions
	
	Description:
	Track a bullet object with a 3D line.
	
	Example:
	[_bulletObj, 30, 2, [0,1,1,1], [270,1,1,1]] call NGT_fnc_trackBullet;

	Parameter(s):
	_this select 0: Bullet [Object]
	_this select 1: Max Time of Flight (seconds) [Integer]
	_this select 2: Skipped Frames [Integer]
	_this select 3: Start Gradient (HSVA) [Array]
	_this select 4: End Gradient (HSVA) [Array]
	
	Returns:
	Nothing [Nil]
*/
NGT_fnc_trackBullet = {
	private ["_projectile", "_maxTOF", "_skippedFrames", "_startGrad", "_endGrad", "_initPos", "_initVel", "_initColor", "_colorShifts"];
	_projectile		= _this select 0; // Object
	_maxTOF			= _this select 1; // Seconds
	_skippedFrames	= _this select 2; // Integer
	_startGrad		= _this select 3; // Array [H,S,V,A]
	_endGrad		= _this select 4; // Array [H,S,V,A]
	_colorShifts	= [((_endGrad select 0) - (_startGrad select 0)),((_endGrad select 1) - (_startGrad select 1)),((_endGrad select 2) - (_startGrad select 2)),((_endGrad select 3) - (_startGrad select 3))];
	_initPos		= getPos _projectile;
	_initVel		= (velocity _projectile) call BIS_fnc_magnitude;
	_initColor		= _startGrad call NGT_fnc_hsvToRGB;
	NGT_bt_arr_bullets set [(count NGT_bt_arr_bullets), [ 
		_projectile,
		[[_initPos, _initColor]],
		_initVel,
		diag_tickTime,
		_maxTOF,
		diag_frameno,
		_skippedFrames,
		_startGrad,
		_colorShifts
	]];
};

/*
	Function:
	NGT_fnc_addBulletTrackingHandler
	
	Group:
	API Functions
	
	Description:
	Adds an event handler to a unit which adds bullet tracking to all rounds fired.
	
	Example:
	[player, 30, 2, [0,1,1,1], [270,1,1,1]] call NGT_fnc_addBulletTrackingHandler;

	Parameter(s):
	_this select 0: Unit [Object]
	_this select 1: Max Time of Flight (seconds) [Integer] (Optional)
	_this select 2: Skipped Frames [Integer] (Optional)
	_this select 3: Start Gradient (HSVA) [Array] (Optional)
	_this select 4: End Gradient (HSVA) [Array] (Optional)
	
	Returns:
	Fired Event Handle [Handle]
*/
NGT_fnc_addBulletTrackingHandler = {
	private ["_object", "_maxTOF", "_skippedFrames", "_startGrad", "_endGrad", "_handle"];
	_object			= [_this, 0] call BIS_fnc_param; // Object
	_maxTOF			= [_this, 1, -1, [0]] call BIS_fnc_param; // Seconds
	_skippedFrames	= [_this, 2, 2, [0]] call BIS_fnc_param; // Integer
	_startGrad		= [_this, 3, [0,1,1,1], [[]], 4] call BIS_fnc_param; // Array [H,S,V,A]
	_endGrad		= [_this, 4, [240,1,1,1], [[]], 4] call BIS_fnc_param; // Array [H,S,V,A]
	_handle			= -1;
	if ((_object getVariable ["NGT_bt_int_trackingHandle", -1]) < 0) then { // No bt handler yet
		_handle = _object addEventHandler ["fired", (compile format["[(_this select 6), %1, %2, %3, %4] call NGT_fnc_trackBullet;", _maxTOF, _skippedFrames, _startGrad, _endGrad])];
		_object setVariable ["NGT_bt_int_trackingHandle", _handle];
	};
	_handle
};

/*
	Function:
	NGT_fnc_removeBulletTrackingHandler
	
	Group:
	API Functions
	
	Description:
	Removes a bullet tracking handler.
	
	Example:
	[player] call NGT_fnc_removeBulletTrackingHandler;

	Parameter(s):
	_this select 0: Unit [Object]
	
	Returns:
	Nothing [Nil]
*/
NGT_fnc_removeBulletTrackingHandler = {
	private ["_object", "_handle"];
	_object	= [_this, 0] call BIS_fnc_param;
	_handle	= _object getVariable ["NGT_bt_int_trackingHandle", -1];
	if (_handle >= 0) then {
		_object removeEventHandler ["fired", _handle];
		_object setVariable ["NGT_bt_int_trackingHandle", -1];
	};
};

/*
	Function:
	NGT_fnc_clearBulletTracking
	
	Group:
	API Functions
	
	Description:
	Clears all bullets from bullet tracking.
	
	Example:
	[] call NGT_fnc_clearBulletTracking;

	Parameter(s):
	None.
	
	Returns:
	Nothing [Nil]
*/
NGT_fnc_clearBulletTracking = {
	NGT_bt_arr_bullets = [];
};

/*
	Function:
	NGT_fnc_stopBulletTracking
	
	Group:
	API Functions
	
	Description:
	Stops bullet tracking on the local machine.
	This will not clear current bullet traces.
	
	Example:
	[] call NGT_fnc_stopBulletTracking;

	Parameter(s):
	None.
	
	Returns:
	Nothing [Nil]
*/
NGT_fnc_stopBulletTracking = {
	if (!isNil "NGT_bt_handle_draw3DID") then {
		removeMissionEventHandler ["draw3D", NGT_bt_handle_draw3DID];
		NGT_bt_handle_draw3DID = nil;
	};
};

/*
	Function:
	NGT_fnc_startBulletTracking
	
	Group:
	API Functions
	
	Description:
	Starts bullet tracking on the local machine.
	
	Example:
	[] call NGT_fnc_startBulletTracking;

	Parameter(s):
	None.
	
	Returns:
	Nothing [Nil]
*/
NGT_fnc_startBulletTracking = {
	if (isNil "NGT_bt_handle_draw3DID") then {
		[] call NGT_fnc_clearBulletTracking;
		NGT_bt_handle_draw3DID = addMissionEventHandler ["draw3D", NGT_fnc_bulletTracking];
	};
};

/*
	Function:
	NGT_fnc_addBulletTrackingActions
	
	Group:
	API Functions
	
	Description:
	Adds bullet tracking actions to an object.
	
	Example:
	[player, 452] call NGT_fnc_addBulletTrackingActions;

	Parameter(s):
	_this select 0: Object [Object] (Optional)
	_this select 1: Max Action Priority [Integer] (Optional)
	
	Returns:
	Nothing [Nil]
*/
NGT_fnc_addBulletTrackingActions = {
	if (!isDedicated) then {
		private ["_unit", "_maxPriority", "_actions"];
		_unit			= [_this, 0, player, [objNull]] call BIS_fnc_param;
		_maxPriority	= [_this, 0, 9523, [0]] call BIS_fnc_param;
		_actions		= [
			["Purge Bullet Traces", {[] call NGT_fnc_clearBulletTracking}, "!isNil 'NGT_bt_handle_draw3DID'"],
			["Add BT To Vehicle", {[cursorTarget] call NGT_fnc_addBulletTrackingHandler}, "(!isNil 'NGT_bt_handle_draw3DID') && (cursorTarget isKindOf 'AllVehicles') && ((cursorTarget getVariable ['NGT_bt_int_trackingHandle', -1]) < 0)"],
			["Remove BT From Vehicle", {[cursorTarget] call NGT_fnc_removeBulletTrackingHandler}, "(!isNil 'NGT_bt_handle_draw3DID') && (cursorTarget isKindOf 'AllVehicles') && ((cursorTarget getVariable ['NGT_bt_int_trackingHandle', -1]) >= 0)"],
			["Add BT To Self", {[_this select 1] call NGT_fnc_addBulletTrackingHandler}, "(!isNil 'NGT_bt_handle_draw3DID') && ((_this getVariable ['NGT_bt_int_trackingHandle', -1]) < 0)"],
			["Remove BT From Self", {[_this select 1] call NGT_fnc_removeBulletTrackingHandler}, "(!isNil 'NGT_bt_handle_draw3DID') && ((_this getVariable ['NGT_bt_int_trackingHandle', -1]) >= 0)"],
			["Start Bullet Tracking", {[] call NGT_fnc_startBulletTracking}, "isNil 'NGT_bt_handle_draw3DID'"],
			["Stop Bullet Tracking", {[] call NGT_fnc_stopBulletTracking}, "!isNil 'NGT_bt_handle_draw3DID'"]
		];
		for "_i" from 0 to ((count _actions) - 1) do {	
			private ["_action", "_title", "_code", "_condition", "_priority"];
			_action		= _actions select _i;
			_title		= "<t color='#FF0066'>" + (_action select 0) + "</t>";
			_code		= _action select 1;
			_condition	= _action select 2;
			_priority	= _maxPriority - _i;
			_unit addAction [_title, _code, [], _priority, false, true, "", _condition];
		};
	};
};