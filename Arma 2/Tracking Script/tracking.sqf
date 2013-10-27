if (isServer) then {
	CRACK_track_briefcase_object = briefcase; // INSERT NAME OF TRACKING OBJECT HERE
	publicVariable "CRACK_track_briefcase_object";
	
	CRACK_track_loopTime = 30; // Loop Time for Tracking
	publicVariable "CRACK_track_loopTime";
};

if (!isdedicated) then {
	
	_condition = true;
	
	waituntil {!isnil "CRACK_track_briefcase_object" AND !isNil "CRACK_track_loopTime"};
	
	if (time == 0) then {sleep .01;};
	
	_centerMarker = createMarkerLocal ["briefcase_location_tracking_marker_center", [0,0,0]];
	_centerMarker setMarkerShapeLocal "ICON";
	_centerMarker setMarkerTypeLocal "Dot";
	_centerMarker setMarkerAlphaLocal 1;
	_centerMarker setMarkerSizeLocal [.8, .8];
	_centerMarker setMarkerColorLocal "ColorBlue";
	
	_circleMarker = createMarkerLocal ["briefcase_location_tracking_marker_circle", [0,0,0]];
	_circleMarker setMarkerShapeLocal "ELLIPSE";
	_circleMarker setMarkerBrushLocal "Solid";
	_circleMarker setMarkerAlphaLocal 0.3;
	_circleMarker setMarkerSizeLocal [10, 10];
	_circleMarker setMarkerColorLocal "ColorBlue";
	
	_perimeterMarker = createMarkerLocal ["briefcase_location_tracking_marker_perimeter", [0,0,0]];
	_perimeterMarker setMarkerShapeLocal "ELLIPSE";
	_perimeterMarker setMarkerBrushLocal "Border";
	_perimeterMarker setMarkerAlphaLocal 0.7;
	_perimeterMarker setMarkerSizeLocal [10.05, 10.05];
	_perimeterMarker setMarkerColorLocal "ColorBlue";
	
	_markers = [_centerMarker, _circleMarker, _perimeterMarker];
	
	_oldPos = [0,0,0];
	
	while {_condition} do {
		
		_briefcasepos = getpos CRACK_track_briefcase_object;
		
		//player sideChat (format["%1 ...:::... %2",_oldPos,_briefcasepos]); // DEBUGGING CODE
		
		if (((_briefcasepos select 0) != (_oldPos select 0)) OR ((_briefcasepos select 1) != (_oldPos select 1)) OR ((_briefcasepos select 2) != (_oldPos select 2))) then {
			_oldPos = _briefcasepos;
			// Randomizing Function
			_briefcasepos = [(((_briefcasepos select 0) + 4) - random(8)),(((_briefcasepos select 1) + 4) - random(8)),(_briefcasepos select 2)];
		};
		
		//player sideChat (format["%1 ...:::... %2",_oldPos,_briefcasepos]); // DEBUGGING CODE
		
		{
			_x setMarkerPosLocal _briefcasepos;
		} foreach _markers;
		
		_time = time + (CRACK_track_loopTime - (time % CRACK_track_loopTime)); // REMEMBER THIS PERFECT ALGORITHM
		waitUntil {sleep 0.1; time > _time;};
	};
};