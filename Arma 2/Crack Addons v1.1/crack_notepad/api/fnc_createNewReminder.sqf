#include "\x\crack\addons\notepad\script_component.hpp"
// _reminderTitle = [_title, _timer, _text] call FUNC(createNewReminder);

private ["_title"];

_title = _this select 0;

_handle = _this spawn {
	
	private ["_title", "_timer", "_text"];
	
	_title = _this select 0;
	_timer = _this select 1;
	_text = _this select 2;
	
	_hintText = "<t color='#00E5EE' size='1.2' shadow='1' shadowColor='#000000' align='center'>REMINDER:</t><br/><br/>" + _text;
	
	_timerReal = _timer + time;
	
	waituntil {sleep GVAR(reminderCheckFrequency); time >= _timerReal;};
	
	if (GVAR(remindersShown) AND GVAR(remindersEnabled)) then {
		hint parsetext _hintText;
	};
	
	_result = [_title, false] call FUNC(deleteReminder);
	
};

GVAR(reminderCache) set [(count GVAR(reminderCache)), [_title, _handle]];

_title