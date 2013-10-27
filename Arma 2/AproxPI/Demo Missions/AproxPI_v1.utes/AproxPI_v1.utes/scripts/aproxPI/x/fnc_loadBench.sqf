
#include "x_defines.sqf"

private ["_call"];

_call	= _this select 0;

switch (_call) do {
	
	case "preset": {
		
		private ["_args", "_method"];
		
		_args	= _this select 1;
		
		_method	= LBCURTXT(1);
		
		_args set [3, _method];
		
		_args spawn AproxPI_main;
	};
	
	case "custom": {
		
		private ["_args"];
		
		_args	= [ CTRLNUM(2), CTRLNUM(3), DFT_OUTPUTCTRL, LBCURTXT(4), true, true, CTRLNUM(5), CTRLNUM(6) ];
		
		_args spawn AproxPI_main;
	};
};