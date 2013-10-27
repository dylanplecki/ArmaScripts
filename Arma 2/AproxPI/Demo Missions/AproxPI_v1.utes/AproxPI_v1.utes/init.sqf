
// DON'T EXECUTE IN MULTIPLAYER
if (isMultiplayer) then {
	forceEnd;
	endMission "END1";
};

// Constants
AproxPI_outputCtrlIDC	= 99;
AproxPI_camPos			= (getMarkerPos "camPos");
AproxPI_camAlt			= 300;
AproxPI_defaultBench	= [100, 50000, AproxPI_outputCtrlIDC, "montecarlo", true, true, 4, 4];
AproxPI_lightBench		= [50, 25000, AproxPI_outputCtrlIDC, "montecarlo", true, true, 4, 4];
AproxPI_medBench		= [100, 50000, AproxPI_outputCtrlIDC, "montecarlo", true, true, 4, 4];
AproxPI_heavyBench		= [200, 100000, AproxPI_outputCtrlIDC, "montecarlo", true, true, 4, 4];

// Load AproxPI
call compile preProcessFileLineNumbers "scripts\aproxPI\init.sqf";

waitUntil {!isNull player};

// Black Screen with background blur
private ["_cam"];
AproxPI_camPos set [2, AproxPI_camAlt];
_cam = "CAMERA" CamCreate AproxPI_camPos;
_cam CameraEffect ["INTERNAL","BACK"];
_cam CamSetTarget player;
_cam CamSetPos AproxPI_camPos;
_cam CamCommit 0;

// Open Dialog
sleep 1;
createDialog "aproxpi_main";