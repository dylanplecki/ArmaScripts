
private ["_textArray", "_unicodeArray"];

_textArray = _this;
_unicodeArray = [];

{
	_unicodeArray = _unicodeArray + toArray(_x);
} foreach _textArray;

_unicodeArray