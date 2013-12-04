// GETPARAM(var1)

#include "f\defines.hpp"

//***********************************************************************************************************************************************

//======================================================//
//===================== Parameters =====================//
//======================================================//
GVAR(parameters) = [

	true,					// 0  - ArmaGroup - Toggles whether to show Arma Group ID (ex. B 1-1-A or anything else set by the MM) (DEFAULT: true)
	"    ",					// 1  - BeginningChar - Leading character to seperate Squad Members from their leaders, like an indent (DEFAULT: "    ")
	(5 * 60),				// 2  - CycleTime - Time between each update of the list in seconds (DEFAULT: 300)
	"Team Roster",			// 3  - SubjectText - Text to be shown as the subject in the Map Screen(DEFAULT: "Team Roster")
	"true",					// 4  - LoopCondition - Conditional statement for loop; it will end on this returning false (DEFAULT: true)
	"",						// 5  - StartingString - The initial string for all lines logged to the roster (DEFAULT: "")
	"99",					// 6  - SpaceChar - Character(s) in a unit's name which will create a space in the printed diary entry (DEFAULT: "99")
	" - ",					// 7  - DividerChar - Character(s) that will serve as a divider for all parts of a line (DEFAULT: " - ")
	"_",					// 8  - SplitChar - Character(s) that will end a unit's name (all text before the first instance of this character is used) (DEFAULT: "_")
	"call CBA_fnc_players",	// 9  - UnitArray - String of command for all units to be included in Roster (DEFAULT: "call CBA_fnc_players")
	[],						// 10 - SkippedUnits - Array of all units NOT to be included in Roster regardless of side (DEFAULT: [])
	"Team Roster (:SIDE:)",	// 11 - HeaderText - Text to be shown above the Team Roster, ":SIDE:" represent's player's side (DEFAULT: "Team Roster (:SIDE:)")
	"1",					// 12 - FireteamColor - Coloring of fireteams on the Team Roster, "0" = off, "1" = player's squad only, "2" = all units (DEFAULT: "1")
	"2",					// 13 - Confidentiality - Controls who a player can see on their roster, "0" = leadership, "1" = player's squad + leadership, "2" = all units (DEFAULT: "2")
	"Team Roster",			// 14 - DiaryTitle - Title in the Diary section of the Map Screen (left-most control) (DEFAULT: "Team Roster")
	true					// 15 - PlayerDesc - Toggle whether a description should be shown for each player, setting to false will disable parameter 6 also (DEFAULT: true)
];

//***********************************************************************************************************************************************