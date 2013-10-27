_teamRosterOn = _this select 0;
_cycle_time = _this select 1;
_diary_subject = _this select 2;
_arma_group = _this select 3;
_end_condition = _this select 4;

// Begin Script
// Split String Function
CRACK_fnc_splitstring = {
	_string = format["%1",(_this select 0)];
	_string_seperator = 95;
	_new_string = "";
	_character_to_string = [];
	_character_array = toArray(_string);
	_index = _character_array find _string_seperator;
	if (_index > 0) then
	{
		_counter = 0;
		while {_counter < _index} do
		{
			_space = false;
			_character = _character_array select _counter;
			if (_character == 54 AND (_character_array select (_counter + 1)) == 57) then {_character = 32;};
			if (_counter != 0) then {if (_character == 57 AND (_character_array select (_counter - 1)) == 54) then {_space = true};};
			if (!_space) then
			{
				_character_to_string = _character_to_string + [_character];
			};
			_counter = _counter + 1;
		};
		_new_string = tostring _character_to_string;
	};
	// Return Value
	_new_string
};
// Rank Function
CRACK_fnc_abbrank = {
	_man = _this select 0;
	_rankId = rankId _man;
	_rank = "";
	switch (_rankId) do
	{
		case 0: {_rank = "Pvt. "};
		case 1: {_rank = "Cpl. "};
		case 2: {_rank = "Sgt. "};
		case 3: {_rank = "Lt. "};
		case 4: {_rank = "Cpt. "};
		case 5: {_rank = "Maj. "};
		case 6: {_rank = "Col. "};
	};
	// Return Value
	_rank
};
// Lines-up cycle so everyone updates at the same time
if (time >= _cycle_time) then {sleep (time % _cycle_time)} else {if (time != 0) then {sleep (_cycle_time - time);};};
// Create Diary Subject
if (!(player diarySubjectExists "roster")) then
{
	nul = player createDiarySubject ["roster",_diary_subject];
};
// Setting Loop Counter
_loop_counter = round((time / _cycle_time) + 1);
// Player Side
_player_side = side player;
while {_end_condition} do
{
	private ["_all_groups","_used_groups","_usedgroups_blufor","_usedgroups_opfor","_usedgroups_resistance","_usedgroups_civilian","_usedgroups_sideEnemy","_diary_output_string","_new_line","_title","_description","_stop_counter"];
	_players_all = call CBA_fnc_players;
	_all_groups = allGroups;
	_usedgroups_blufor = [];
	_usedgroups_opfor = [];
	_usedgroups_resistance = [];
	_usedgroups_civilian = [];
	_usedgroups_sideEnemy = [];
	groups_blufor = [];
	groups_opfor = [];
	groups_resistance = [];
	groups_civilian = [];
	groups_sideEnemy = [];
	_diary_output_string = "";
	_new_line = "";
	_title = "";
	_description = "";
	_stop_counter = 0;
	// Seperating out the players by side, then group, then group index
	switch (_player_side) do
	{
		case west:
		{
			{
				if ((side _x) == _player_side AND (side _x) != SIDEENEMY) then
				{
					_group = group _x;
					_group_number = _all_groups find _group;
					// Checks to see if the group is already set, if not adds the group to array
					if ((_usedgroups_blufor find _group_number) == -1) then
					{	
						groups_blufor = groups_blufor + [[_group_number,"",[]]];
						_usedgroups_blufor = _usedgroups_blufor + [_group_number];
					};
					_main_group_index = _usedgroups_blufor find _group_number;
					// Checking to see if the player is leader, if not get index within group
					if ((leader _group) == _x) then
					{
						(groups_blufor select _main_group_index) set [1,_x];
					}
					else
					{
						_group_index = (_x call CBA_fnc_getGroupIndex) - 2;
						((groups_blufor select _main_group_index) select 2) set [_group_index,_x];
					};
					if ((side _x) == SIDEENEMY) then
					{
						groups_sideEnemy = groups_sideEnemy + [_x];
					};
				};
			} foreach _players_all;
			// Sorting Arrays by group ID
			groups_blufor = [groups_blufor,0] call CBA_fnc_sortNestedArray;
			// Preparing String for Diary Output
			_diary_output_string = format["<br/>%1 - by crackman<br/>--------------------------------------------------<br/>",_diary_subject];
			// Printing to Diary Output string
			{
				_group_number = _x select 0;
				_group_leader = _x select 1;
				_group_members = _x select 2;
				_group = _all_groups select _group_number;
				// Now compile new group-paragraph-section for group/leader
				_description = [_group_leader] call CRACK_fnc_splitstring;
				_rank = [_group_leader] call CRACK_fnc_abbrank;
				if (_arma_group) then
				{
					_new_line = format["<br/>%1 %2 - %3%4<br/>",_group,_description,_rank,(name _group_leader)];
				}
				else
				{
					_new_line = format["%1 - %2%3<br/>",_description,_rank,(name _group_leader)];
				};
				// Then compile the rest of the members into the new group-paragraph-section
				{
					_description = [_x] call CRACK_fnc_splitstring;
					_rank = [_x] call CRACK_fnc_abbrank;
					if (_arma_group) then
					{
						_new_line = format["%1    %2 %3 - %4 - %5%6<br/>",_new_line,_group,((_group_members find _x) + 2),_description,_rank,(name _x)];
					}
					else
					{
						_new_line = format["%1    %2 - %3 - %4%5<br/>",_new_line,((_group_members find _x) + 2),_description,_rank,(name _x)];
					};
				} foreach _group_members;
				// Then add it all to the full Diary Output String
				_diary_output_string = format["%1%2",_diary_output_string,_new_line];
			} foreach groups_blufor;
		};
		case east:
		{
			{
				if ((side _x) == _player_side AND (side _x) != SIDEENEMY) then
				{
					_group = group _x;
					_group_number = _all_groups find _group;
					// Checks to see if the group is already set, if not adds the group to array
					if ((_usedgroups_opfor find _group_number) == -1) then
					{	
						groups_opfor = groups_opfor + [[_group_number,"",[]]];
						_usedgroups_opfor = _usedgroups_opfor + [_group_number];
					};
					_main_group_index = _usedgroups_opfor find _group_number;
					// Checking to see if the player is leader, if not get index within group
					if ((leader _group) == _x) then
					{
						(groups_opfor select _main_group_index) set [1,_x];
					}
					else
					{
						_group_index = (_x call CBA_fnc_getGroupIndex) - 2;
						((groups_opfor select _main_group_index) select 2) set [_group_index,_x];
					};
					if ((side _x) == SIDEENEMY) then
					{
						groups_sideEnemy = groups_sideEnemy + [_x];
					};
				};
			} foreach _players_all;
			// Sorting Arrays by group ID
			groups_opfor = [groups_opfor,0] call CBA_fnc_sortNestedArray;
			// Preparing String for Diary Output
			_diary_output_string = format["<br/>%1 - by crackman<br/>--------------------------------------------------<br/><br/>",_diary_subject];
			// Printing to Diary Output string
			{
				_group_number = _x select 0;
				_group_leader = _x select 1;
				_group_members = _x select 2;
				_group = _all_groups select _group_number;
				// Now compile new group-paragraph-section for group/leader
				_description = [_group_leader] call CRACK_fnc_splitstring;
				_rank = [_group_leader] call CRACK_fnc_abbrank;
				if (_arma_group) then
				{
					_new_line = format["%1 %2 - %3%4<br/>",_group,_description,_rank,(name _group_leader)];
				}
				else
				{
					_new_line = format["%1 - %2%3<br/>",_description,_rank,(name _group_leader)];
				};
				// Then compile the rest of the members into the new group-paragraph-section
				{
					_description = [_x] call CRACK_fnc_splitstring;
					_rank = [_x] call CRACK_fnc_abbrank;
					if (_arma_group) then
					{
						_new_line = format["%1    %2 %3 - %4 - %5%6<br/>",_new_line,_group,((_group_members find _x) + 2),_description,_rank,(name _x)];
					}
					else
					{
						_new_line = format["%1    %2 - %3 - %4%5<br/>",_new_line,((_group_members find _x) + 2),_description,_rank,(name _x)];
					};
				} foreach _group_members;
				// Then add it all to the full Diary Output String
				_diary_output_string = format["%1%2",_diary_output_string,_new_line];
			} foreach groups_opfor;
		};
		case resistance:
		{
			{
				if ((side _x) == _player_side AND (side _x) != SIDEENEMY) then
				{
					_group = group _x;
					_group_number = _all_groups find _group;
					// Checks to see if the group is already set, if not adds the group to array
					if ((_usedgroups_resistance find _group_number) == -1) then
					{	
						groups_resistance = groups_resistance + [[_group_number,"",[]]];
						_usedgroups_resistance = _usedgroups_resistance + [_group_number];
					};
					_main_group_index = _usedgroups_resistance find _group_number;
					// Checking to see if the player is leader, if not get index within group
					if ((leader _group) == _x) then
					{
						(groups_resistance select _main_group_index) set [1,_x];
					}
					else
					{
						_group_index = (_x call CBA_fnc_getGroupIndex) - 2;
						((groups_resistance select _main_group_index) select 2) set [_group_index,_x];
					};
					if ((side _x) == SIDEENEMY) then
					{
						groups_sideEnemy = groups_sideEnemy + [_x];
					};
				};
			} foreach _players_all;
			// Sorting Arrays by group ID
			groups_resistance = [groups_resistance,0] call CBA_fnc_sortNestedArray;
			// Preparing String for Diary Output
			_diary_output_string = format["<br/>%1 - by crackman<br/>--------------------------------------------------<br/><br/>",_diary_subject];
			// Printing to Diary Output string
			{
				_group_number = _x select 0;
				_group_leader = _x select 1;
				_group_members = _x select 2;
				_group = _all_groups select _group_number;
				// Now compile new group-paragraph-section for group/leader
				_description = [_group_leader] call CRACK_fnc_splitstring;
				_rank = [_group_leader] call CRACK_fnc_abbrank;
				if (_arma_group) then
				{
					_new_line = format["%1 %2 - %3%4<br/>",_group,_description,_rank,(name _group_leader)];
				}
				else
				{
					_new_line = format["%1 - %2%3<br/>",_description,_rank,(name _group_leader)];
				};
				// Then compile the rest of the members into the new group-paragraph-section
				{
					_description = [_x] call CRACK_fnc_splitstring;
					_rank = [_x] call CRACK_fnc_abbrank;
					if (_arma_group) then
					{
						_new_line = format["%1    %2 %3 - %4 - %5%6<br/>",_new_line,_group,((_group_members find _x) + 2),_description,_rank,(name _x)];
					}
					else
					{
						_new_line = format["%1    %2 - %3 - %4%5<br/>",_new_line,((_group_members find _x) + 2),_description,_rank,(name _x)];
					};
				} foreach _group_members;
				// Then add it all to the full Diary Output String
				_diary_output_string = format["%1%2",_diary_output_string,_new_line];
			} foreach groups_resistance;
		};
		case civilian:
		{
			{
				if ((side _x) == _player_side AND (side _x) != SIDEENEMY) then
				{
					_group = group _x;
					_group_number = _all_groups find _group;
					// Checks to see if the group is already set, if not adds the group to array
					if ((_usedgroups_civilian find _group_number) == -1) then
					{	
						groups_civilian = groups_civilian + [[_group_number,"",[]]];
						_usedgroups_civilian = _usedgroups_civilian + [_group_number];
					};
					_main_group_index = _usedgroups_civilian find _group_number;
					// Checking to see if the player is leader, if not get index within group
					if ((leader _group) == _x) then
					{
						(groups_civilian select _main_group_index) set [1,_x];
					}
					else
					{
						_group_index = (_x call CBA_fnc_getGroupIndex) - 2;
						((groups_civilian select _main_group_index) select 2) set [_group_index,_x];
					};
					if ((side _x) == SIDEENEMY) then
					{
						groups_sideEnemy = groups_sideEnemy + [_x];
					};
				};
			} foreach _players_all;
			// Sorting Arrays by group ID
			groups_civilian = [groups_civilian,0] call CBA_fnc_sortNestedArray;
			// Preparing String for Diary Output
			_diary_output_string = format["<br/>%1 - by crackman<br/>--------------------------------------------------<br/><br/>",_diary_subject];
			// Printing to Diary Output string
			{
				_group_number = _x select 0;
				_group_leader = _x select 1;
				_group_members = _x select 2;
				_group = _all_groups select _group_number;
				// Now compile new group-paragraph-section for group/leader
				_description = [_group_leader] call CRACK_fnc_splitstring;
				_rank = [_group_leader] call CRACK_fnc_abbrank;
				if (_arma_group) then
				{
					_new_line = format["%1 %2 - %3%4<br/>",_group,_description,_rank,(name _group_leader)];
				}
				else
				{
					_new_line = format["%1 - %2%3<br/>",_description,_rank,(name _group_leader)];
				};
				// Then compile the rest of the members into the new group-paragraph-section
				{
					_description = [_x] call CRACK_fnc_splitstring;
					_rank = [_x] call CRACK_fnc_abbrank;
					if (_arma_group) then
					{
						_new_line = format["%1    %2 %3 - %4 - %5%6<br/>",_new_line,_group,((_group_members find _x) + 2),_description,_rank,(name _x)];
					}
					else
					{
						_new_line = format["%1    %2 - %3 - %4%5<br/>",_new_line,((_group_members find _x) + 2),_description,_rank,(name _x)];
					};
				} foreach _group_members;
				// Then add it all to the full Diary Output String
				_diary_output_string = format["%1%2",_diary_output_string,_new_line];
			} foreach groups_civilian;
		};
		case sideEnemy:
		{
			_diary_output_string = compile format["%1 - by Crackman<br/>-------------------------<br/><br/>You are a teamkiller! No information for you :)",_diary_subject];
		};
	};
	// Check to see if there were any teamkillers
	if ((count groups_sideEnemy) > 0) then
	{
		_new_line = "";
		{
			_new_line = format["%1%2<br/>",_new_line,(name _x)];
		} foreach groups_sideEnemy;
		_diary_output_string = format["%1<br/>Teamkillers:<br/>%2",_diary_output_string,_new_line];
	};
	// Printing to Diary
	_title = format["%1 Roster - %2",_player_side,_loop_counter];
	player createDiaryRecord ["roster", [_title,_diary_output_string]];
	// Counting-up loop counter
	_loop_counter = _loop_counter + 1;
	// Counting Stop Counter, and if loop gets too high re-execute script
	_stop_counter = _stop_counter + 1;
	if (_stop_counter == 9990) exitwith {nul = [] execVM "scripts\team_roster.sqf";};
	// Delaying cycle for performance
	sleep _cycle_time;
};