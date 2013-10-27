class RscText {
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 2;
	font = "Zeppelin32";
	type = 0;
	SizeEx = 0.03921;
	colorText[] = {0.8784, 0.8471, 0.651, 1.0};
	colorBackground[] = {0, 0, 0, 0};
};

class RscHTML {
	colorText[] = {0.8784, 0.8471, 0.651, 1.0};
	colorLink[] = {0.8784, 0.8471, 0.651, 1.0};
	colorBold[] = {0.8784, 0.8471, 0.651, 1.0};
	colorLinkActive[] = {1, 0.537, 0, 1};
	sizeEx = 0.03921;
	type = 9;
	prevPage = "\ca\ui\data\arrow_left_ca.paa";
	nextPage = "\ca\ui\data\arrow_right_ca.paa";
	shadow = 2;
	
	class H1 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.03921;
		align = "left";
	};
	
	class H2 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.03921;
		align = "left";
	};
	
	class H3 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.03921;
		align = "left";
	};
	
	class H4 {
		font = "Zeppelin33Italic";
		fontBold = "Zeppelin33";
		sizeEx = 0.03921;
		align = "left";
	};
	
	class H5 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.03921;
		align = "left";
	};
	
	class H6 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.03921;
		align = "left";
	};
	
	class P {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.03921;
		align = "left";
	};
};

class RscPicture : RscText {
	shadow = false;
	colorText[] = {1, 1, 1, 1};
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	type = 0;
};

class RscProgress {
	x = 0.344;
	y = 0.619;
	w = 0.313726;
	h = 0.0261438;
	shadow = 2;
	texture = "\ca\ui\data\loadscreen_progressbar_ca.paa";
	colorFrame[] = {0, 0, 0, 0};
	colorBar[] = {1, 1, 1, 1};
	type = 8;
};

class RscPictureKeepAspect : RscPicture {
	style = 0x30 + 0x800;
};

class CA_Mainback : RscPicture {
	x = 0.35;
	y = 0.8;
	w = 0.3;
	h = 0.2;
	text = "\ca\ui\data\ui_gradient_start_gs.paa";
	colorText[] = {0.424, 0.651, 0.247, 1};
};

class CA_Black_Back : CA_Mainback {
	x = "SafeZoneX - SafeZoneW";
	y = "SafeZoneY - SafeZoneH";
	w = "SafeZoneW * 4";
	h = "SafeZoneH * 4";
	text = "#(argb,8,8,3)color(0,0,0,1)";
	colorText[] = {0.023529, 0, 0.0313725, 1};
	color[] = {0.023529, 0, 0.0313725, 1};
	colorBackground[] = {0.023529, 0, 0.0313725, 1};
};