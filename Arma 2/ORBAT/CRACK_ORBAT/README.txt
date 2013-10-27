   _____   _____                _____   _  __        ____    _____    ____               _______ 
  / ____| |  __ \      /\      / ____| | |/ /       / __ \  |  __ \  |  _ \      /\     |__   __|
 | |      | |__) |    /  \    | |      | ' /       | |  | | | |__) | | |_) |    /  \       | |   
 | |      |  _  /    / /\ \   | |      |  <        | |  | | |  _  /  |  _ <    / /\ \      | |   
 | |____  | | \ \   / ____ \  | |____  | . \       | |__| | | | \ \  | |_) |  / ____ \     | |   
  \_____| |_|  \_\ /_/    \_\  \_____| |_|\_\       \____/  |_|  \_\ |____/  /_/    \_\    |_|   

*************************************************************************************************

	 -> README File
	 
		-> Script by Crackman
	 
			-> Verision 1.0.0

*************************************************************************************************

		You can contact me at dylanplecki@gmail.com
		Or on the United Operations forums @ forums.unitedoperations.net as Crackman

*************************************************************************************************

This script is designed to provide an easy-to-use interface for providing gear loadouts to units.

*************************************************************************************************

Installation:
	
	1. Copy the CRACK_ORBAT folder to your root mission directory
	2. Put this line into your init.sqf:
		nul = [] execVM "CRACK_ORBAT\init.sqf";
	3. Go to the Usage Instructions below
	
*************************************************************************************************

Usage:
	
	1. After installation, determine the ORBATS you wish to use (You may use more than one, but they must be different factions)
	
	2. Once faction is determined, extract the .rar file in the faction folder for the camo you wish to use INTO that faction folder.
		ie. If you want the US Army ACU ORBAT, extract the ORBAT_US_Army_ACU.rar file into the us_army folder, so you have these two directories:
			"\CRACK_ORBAT\ORBATS\us_army\orbat.sqf" (ORBAT + Loadout file)
			"\CRACK_ORBAT\ORBATS\us_army\ORBAT_US_Army_ACU.utes\mission.sqm" (Template Mission)
	
	3. Then copy the mission folder ("ORBAT_US_Army_ACU.utes" in our example) to your missions directory, as it is a template of the units for your mission
	
	4. Copy or Merge the units from the template mission into your mission, and then make those units "playable"
	
	5. Once that is done, go to the ORBAT.sqf file you extracted, and look at the SYNTAX and DEFAULT syntax for the next step.
	
	6. Now once you have determined the SYNTAX you wish to use, copy that to the settings.sqf file in "\CRACK_ORBAT\" (Or alternatively you can just edit the default ones given to you)
	
	7. Once all that is done, you can change the units, the loadout, etc.
		You can also delete units by deleting the squad / units in the editor, and then deleting those same units (remember the units' names) in the ORBAT file.
		
*************************************************************************************************

You can find information on the team_roster script and its settings in the "CRACK_ORBAT\scripts\team_roster\" folder

*************************************************************************************************