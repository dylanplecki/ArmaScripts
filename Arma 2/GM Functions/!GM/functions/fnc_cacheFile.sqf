
private ["_GM_CACHE_KEYS"];

_GM_CACHE_KEYS = uiNamespace getVariable "GM_CACHE_KEYS";

if (isNil "_GM_CACHE_KEYS") then {
	_GM_CACHE_KEYS = [];
	uiNamespace setVariable ["GM_CACHE_KEYS", _GM_CACHE_KEYS];
};

GM_CACHE_KEYS = _GM_CACHE_KEYS;

#ifdef BENCHMARK
	if (isNil "GM_STR_BENCH") then { GM_STR_BENCH = "private '_GM_int_time'; _GM_int_time = diag_tickTime; call (uiNamespace getVariable '%1'); diag_log [diag_frameNo, diag_tickTime, time, '%1', _GM_int_time, diag_tickTime - _GM_int_time]; if !(isNil '_ret') then { nil } else { _ret };" };
#endif

_fnc_compile = uiNamespace getVariable "GM_fnc_cacheFile";

if (isNil "_fnc_compile") then {
	
	_fnc_compile = {
		
		private ["_GM_int_code", "_recompile", "_isCached"];
		
		_recompile = if (isNil "GM_COMPILE_RECOMPILE") then {
			false;
		} else {
			GM_COMPILE_RECOMPILE;
		};
		
		// TODO: Unique namespace?
		_GM_int_code = uiNamespace getVariable _this;
		_isCached = if (isNil "GM_CACHE_KEYS") then { false } else { !isMultiplayer || isDedicated || _this in GM_CACHE_KEYS };
		if (isNil '_GM_int_code' || _recompile || !_isCached) then {
			
			#ifdef BENCHMARK
				// TODO: Fix
				//_GM_int_code = compile ("private '_GM_int_time'; _GM_int_time = diag_tickTime; call (uiNamespace getVariable '%1'); diag_log [diag_frameNo, diag_tickTime, time, '%1', _GM_int_time, diag_tickTime - _GM_int_time]; if !(isNil '_ret') then { nil } else { _ret };", _this]);
				uiNamespace setVariable [_this, compile preProcessFileLineNumbers _this];
				_GM_int_code = compile format[SLX_XEH_STR_BENCH, _this];
			#else
				_GM_int_code = compile preProcessFileLineNumbers _this;
				uiNamespace setVariable [_this, _GM_int_code];
			#endif
			
			if (!_isCached && !isNil "GM_CACHE_KEYS") then {
				GM_CACHE_KEYS = GM_CACHE_KEYS + [_this];
				uiNamespace setVariable ["GM_CACHE_KEYS", GM_CACHE_KEYS];
			};
		};
		
		_GM_int_code;
		
	};
	
	uiNamespace setVariable ["GM_fnc_cacheFile", _fnc_compile];
	
};

GM_fnc_cacheFile = _fnc_compile;