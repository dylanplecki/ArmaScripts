private ["_playerArray", "_player", "_text"];

_playerArray = _this select 0;
_player = _this select 1;
_text = _this select 2;

if (player in _playerArray) then {
	hint format[_text, (name _player)];
};