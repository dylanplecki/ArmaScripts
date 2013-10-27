Private ["_nearPlayers", "_unitCenter", "_radius", "_nearMen"];

_nearPlayers = [];
_unitCenter = _this select 0;
_radius = _this select 1;
_nearMen = (getpos _unitCenter) nearobjects ["Man", _radius];

{ // foreach
	if ((isplayer _x) && (_x != player) && ((side _x != side player) AND (side _x != civilian))) then {_nearPlayers = _nearPlayers + [_x];};
} foreach _nearMen;
_nearPlayers