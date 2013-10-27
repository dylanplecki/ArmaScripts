
GM_fnc_execScratchPad = {
	
	private ["_params", "_handle"];
	
	_params = _this;
	
	_handle = _params spawn compile preProcessFileLineNumbers "\!GM\scratchpad.sqf";
	
	_handle
	
};