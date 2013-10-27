class aproxPI_loadingScreen {
	idd = 987;
	duration = 10e10;
	fadein = 0;
	fadeout = 0;
	name = "LoadingScreen";
	onLoad = "with uiNamespace do {AproxPI_loadingScreenIDD = (_this select 0);};";
			
	class controls {
		
		class CA_Black_Back3 : CA_Black_Back {
			idc = -1;
		};
		
		class Name : RscText {
			idc = 101;
			text = "";
			style = 0;
			colorText[] = {0.8784, 0.8471, 0.651, 1.0};
		};
		
		class CA_ProgressBackground : RscText {
			idc = -1;
			style = 48;
			text = "\ca\ui\data\loadscreen_progressbar_ca.paa";
			colorText[] = {1, 1, 1, 0.1};
			x = "(SafezoneX+(SafezoneW -SafezoneH*3/4)/2)+ (0.5/2/4)*3*SafezoneH";
			y = "SafezoneY+SafezoneH*0.95";
			w = "0.5* (((SafezoneW*3)/4)/SafezoneW)/(1/SafezoneH)";
			h = 0.0261438;
		};
		
		class HintBackground : RscText {
			idc = 8405;
			x = "SafezoneX + (safezoneW - 	1.3) / 2";
			y = "SafezoneY + (safezoneH - 		((SafezoneW / 2) * (4/3))) / 2 + 		((SafezoneW / 2) * (4/3)) - 	(	1.3 / 8) * 4/3 * 1.1";
			w = 1.3;
			h = (	1.3 / 8) * 4/3;
			text = "\ca\ui\data\ui_loading_text_ca.paa";
			style = 48;
			shadow = false;
		};
		
		class Hint : RscText {
			idc = 8404;
			x = "SafezoneX + (safezoneW - 			1.3 * 0.7 * (0.98)) / 2";
			y = "SafezoneY + (safezoneH - 		((SafezoneW / 2) * (4/3))) / 2 + 		((SafezoneW / 2) * (4/3)) - 	(	1.3 / 8) * 4/3 * 1.1 + (	(	1.3 / 8) * 4/3 - 						 0.03921 * 3)/2";
			w = 1.3 * 0.7 * (0.98);
			h = 0.03921 * 3;
			text = "Estimating the value of PI...";
			style = 0x02 + 0x10 + 0x200;
			lineSpacing = 1;
		};
		
		class CA_Progress : RscProgress {
			idc = 104;
			x = "(SafezoneX+(SafezoneW -SafezoneH*3/4)/2)+ (0.5/2/4)*3*SafezoneH";
			y = "SafezoneY+SafezoneH*0.95";
			w = "0.5* (((SafezoneW*3)/4)/SafezoneW)/(1/SafezoneH)";
			texture = "\ca\ui\data\loadscreen_progressbar_ca.paa";
			style = 0;
		};
	};
};