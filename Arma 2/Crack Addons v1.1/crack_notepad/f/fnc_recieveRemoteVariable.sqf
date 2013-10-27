#include "\x\crack\addons\notepad\script_component.hpp"

private ["_dataType", "_unit", "_reciever", "_recievedData", "_data", "_args", "_id"];

_dataType = _this select 0; // Titles = 0 || Contents = 1
_unit = _this select 1;
_reciever = _this select 2;
_recievedData = _this select 3;
_args = _this select 4;

if (ismultiplayer) then {
	
	if (!isdedicated) then {
		
		if (_reciever == player) then {
			
			if (typename(_recievedData) == typename("Text")) exitwith {
				if (_recievedData == "ERROR") then {
					_name = if (alive _unit) then {name _unit} else {_unit};
					_text = format["The page entitled '%1' requested on %2's notepad is currently not available.", (_args select 0), _name];
				};
				if (_recievedData == "TRUNCATED") then {
					_name = if (alive _unit) then {name _unit} else {_unit};
					_text = format["The page entitled '%1' requested on %2's notepad is currently too large to send - May be neglectful abuse.", (_args select 0), _name];
				};
				ERROR(_text);
				hint _text;
			};
			
			switch (_dataType) do {
				
				//-------------------------------------------------
				
				case 0: { // Titles
					
					createdialog "CRACK_notepad_diag_copy_page";
					
					{
						_id = lbadd [1, _x];
					} foreach _recievedData;
					
					{
						_id = lbAdd [2,(_x select 0)];
					} foreach GVAR(notepadContents);
					
				};
				
				//-------------------------------------------------
				
				case 1: { // Contents
					
					_title = (_args select 0);
					_contents = _recievedData;
					_index = -1;
					
					for "_i" from 0 to (count GVAR(notepadContents) - 1) do {
						if (((GVAR(notepadContents) select _i) select 0) == (_args select 1)) exitwith {_index = _i};
					};
					
					if (_index < 0) exitwith {
						_text = format["The page entitled '%1' no longer exists on the local player's notepad.", (_args select 1), _name];
						ERROR(_text);
						hint ("ERROR:\n\n" + _text);
					};
					
					GVAR(notepadContents) set [_index, [_title, _contents]];
					
					hint format["Notpad page '%1' successfully copied to your page of '%2'", (_args select 0), (_args select 1)];
					
				};
				
				//-------------------------------------------------
			};
		};
	};
};