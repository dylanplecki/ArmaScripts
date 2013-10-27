//#include "defines.hpp"

private ["_man", "_rankId", "_rank"];

_man = _this select 0;

_rankId = rankId _man;

switch (_rankId) do
{
	case 0: {_rank = "Pvt. ";};
	case 1: {_rank = "Cpl. ";};
	case 2: {_rank = "Sgt. ";};
	case 3: {_rank = "Lt.  ";};
	case 4: {_rank = "Cpt. ";};
	case 5: {_rank = "Maj. ";};
	case 6: {_rank = "Col. ";};
	default {_rank = "";};
};

// Return Value
_rank