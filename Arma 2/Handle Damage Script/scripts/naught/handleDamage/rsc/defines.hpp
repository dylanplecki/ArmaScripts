//
//	CRACK_defines - (FUBAR) Standard Defines for Dialogs and Controls
//		By Naught (dylanplecki@gmail.com)
//
//		Taken from:
//			http://community.bistudio.com/wiki/Dialog_Control
//
//----------------------------------------------------------------------------
//
//			CT    -> Constant Types
//			ST    -> Static Styles
//			SL    -> Slider Styles
//			LB    -> ListBox Styles
//			RGB   -> Red-Green-Blue Colors
//			CRACK -> Columns User Interface
//
//*********************************************************************************************************************

// Constant Types
#define CT_STATIC 0
#define CT_BUTTON 1
#define CT_EDIT 2
#define CT_SLIDER 3
#define CT_COMBO 4
#define CT_LISTBOX 5
#define CT_TOOLBOX 6
#define CT_CHECKBOXES 7
#define CT_PROGRESS 8
#define CT_HTML 9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT 11
#define CT_TREE 12
#define CT_STRUCTURED_TEXT 13
#define CT_CONTEXT_MENU 14
#define CT_CONTROLS_GROUP 15
#define CT_SHORTCUTBUTTON 16
#define CT_XKEYDESC 40
#define CT_XBUTTON          41
#define CT_XLISTBOX 42
#define CT_XSLIDER 43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT 80
#define CT_OBJECT_ZOOM 81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK 98
#define CT_ANIMATED_USER 99
#define CT_MAP              100
#define CT_MAP_MAIN 101
#define CT_LISTNBOX 102

// Static Styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0c
#define ST_TYPE           0xF0
#define ST_SINGLE         0
#define ST_MULTI          16
#define ST_TITLE_BAR      32
#define ST_PICTURE        48
#define ST_FRAME          64
#define ST_BACKGROUND     80
#define ST_GROUP_BOX      96
#define ST_GROUP_BOX2     112
#define ST_HUD_BACKGROUND 128
#define ST_TILE_PICTURE   144
#define ST_WITH_RECT      160
#define ST_LINE           176
#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800
#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400
#define SL_TEXTURES       0x10

// ListBoxes
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Colors
#define RGB_GREEN 0, 0.5, 0, 1
#define RGB_BLUE 0, 0, 1, 1
#define RGB_ORANGE 0.5, 0.5, 0, 1
#define RGB_RED 1, 0, 0, 1
#define RGB_YELLOW 1, 1, 0, 1
#define RGB_WHITE 1, 1, 1, 1
#define RGB_GRAY 0.5, 0.5, 0.5, 1
#define RGB_BLACK 0, 0, 0, 1
#define RGB_MAROON 0.5, 0, 0, 1
#define RGB_OLIVE 0.5, 0.5, 0, 1
#define RGB_NAVY 0, 0, 0.5, 1
#define RGB_PURPLE 0.5, 0, 0.5, 1
#define RGB_FUCHSIA 1, 0, 1, 1
#define RGB_AQUA 0, 1, 1, 1
#define RGB_TEAL 0, 0.5, 0.5, 1
#define RGB_LIME 0, 1, 0, 1
#define RGB_SILVER 0.75, 0.75, 0.75, 1

// Multi-Player Menu
#define Paused_Title_IDC 523
#define CA_B_SAVE_IDC 103
#define CA_B_Skip_IDC 1002
#define CA_B_REVERT_IDC 119
#define CA_B_Respawn_IDC 1010
#define CA_B_Options_IDC 101
#define CA_B_Abort_IDC 104

// Single-Player Menu
#define CA_PGTitle_IDC 523
#define PG_Save_IDC 103
#define PG_Skip_IDC 1002
#define PG_Revert_IDC 119
#define PG_Again_IDC 1003
#define PG_Options_IDC 101
#define PG_Abort_IDC 104

// Columns UI Colors
#define CRACK_Colours_Black				179/256, 158/256, 113/256
#define CRACK_Colours_White				25/256, 25/256, 25/256
#define CRACK_Colours_Whitelight		50/256, 50/256, 50/256
#define CRACK_Colours_Brown				139/256, 115/256, 85/256
#define CRACK_Colours_Darker				73/256, 73/256, 73/256
#define CRACK_Colours_Dark				39/256, 46/256, 38/256
#define CRACK_Colours_Normal				59/256, 79/256, 51/256
#define CRACK_Colours_Light				93/256, 117/256, 93/256
#define CRACK_Colours_Lighter				204/256, 255/256, 151/256
#define CRACK_Colours_DialogBackground	CRACK_Colours_Whitelight
#define CRACK_Colours_DialogText			CRACK_Colours_Black
#define CRACK_Colours_WindowBackground	CRACK_Colours_Whitelight
#define CRACK_Colours_WindowText			CRACK_Colours_Black
#define CRACK_Colours_CaptionBackground	CRACK_Colours_Whitelight
#define CRACK_Colours_CaptionText			CRACK_Colours_Black
#define CRACK_Colours_ButtonBackground	CRACK_Colours_Whitelight
#define CRACK_Colours_ButtonText			CRACK_Colours_Black

// Side-Based Colors
#define CRACK_Colours_WEST				54/256, 96/256, 146/256
#define CRACK_Colours_EAST				150/256, 54/256, 52/256
#define CRACK_Colours_RESISTANCE		118/256, 147/256, 60/256
#define CRACK_Colours_CIVILIAN			166/256, 166/256, 166/256

// Columns UI Safe-Zones
#define safeX	(safeZoneX * 0.9)
#define safeY	(safeZoneY * 0.9)
#define safeH	(safeZoneH * 0.9)
#define safeW	(safeZoneW * 0.9)
#define safeCX	(safeX + safeW/2)
#define safeCY	(safeY + safeH/2)

// Columns UI Rows
#ifndef CRACK_Rows
	#define CRACK_Rows 42
#endif
#define CRACK_Row_H	((safeH / CRACK_Rows) / 0.8)
#define CRACK_Row_Y(integer)	(safeY + ((integer) * CRACK_Row_H))
#define CRACK_Row_dif_Y(integer)	(safeY + ((integer) * CRACK_Row_H))
#define CRACK_Row_DY(int1,int2)	(((int2) - (int1)) * CRACK_Row_H)

// Columns UI Boxes
#ifndef CRACK_Boxes
	#define CRACK_Boxes 4
#endif
#define CRACK_Box_H	(CRACK_Row_H * (CRACK_Rows / CRACK_Boxes))
#define CRACK_Box_W	(safeW / CRACK_Boxes)
#define CRACK_Box_X(integer)	(safeX + ((integer) * CRACK_Box_W))
#define CRACK_Box_Y(integer)	(safeY + ((integer) * CRACK_Box_H))
#define CRACK_Box_Row(int1,int2)	(CRACK_Box_Y(int1) + ((int2) * CRACK_Row_H))
#define CRACK_Box_Rows	(CRACK_Box_H / CRACK_Row_H)

// Taken Columns UI Dialogs
class CRACK_Frame	{
	idc = -1;
	x = CRACK_Box_X(0); y = CRACK_Box_Y(0);
	w = CRACK_Box_W; h = CRACK_Box_H;
	
	type = 0; style = 0x00;
	sizeEx = 0.032;	font = "Zeppelin32";
	
	colorBackground[] = {CRACK_Colours_White, 1};
	colorText[] = {0,0,0,0};
	text = "";
};

class CRACK_Caption : CRACK_Frame {
	h = CRACK_Row_H;

	colorBackground[] = {CRACK_Colours_CaptionBackground, 4/5};
	colorText[] = {CRACK_Colours_CaptionText, 1};
};

class CRACK_List {
	idc = -1;
	x = CRACK_Box_X(0); y = CRACK_Box_Row(0,1);
	w = CRACK_Box_W; h = CRACK_Row_DY(0,5);
	
	type = 5; style = 0 + 0x10;
	sizeEx = 0.032;	font = "Zeppelin32";
	
	rowHeight = CRACK_Row_H;
	wholeHeight = 5 * CRACK_Row_H;
	
	color[] = {0,0.5,0,1};
	colorText[] = {CRACK_Colours_WindowText, 1};
	colorBackground[] = {CRACK_Colours_WindowBackground, 3/4};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {CRACK_Colours_DialogText, 1/2};
	colorSelect2[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0,1,0,1};
	colorSelectBackground2[] = {0.6, 0.8392, 0.4706, 1.0};

	period = 0;
	
	soundSelect[] = {"", 0.0, 1};
	
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	maxHistoryDelay = 1.0;

	arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
	arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
	
	class ScrollBar	{
		color[] = {CRACK_Colours_WindowText, 3/4};
		colorActive[] = {CRACK_Colours_WindowText, 1};
		colorDisabled[] = {CRACK_Colours_WindowText, 1/2};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};

class CRACK_Button {
	idc = -1;
	x = CRACK_Box_X(0); y = CRACK_Box_Row(0,1);
	w = CRACK_Box_W; h = CRACK_Row_H;
	
	type = 1; style = 0x02;
	sizeEx = 0.032;	font = "Zeppelin32";
	
	colorText[] = {CRACK_Colours_ButtonText, 1};
	colorFocused[] = {CRACK_Colours_ButtonBackground, 3/5};
	colorDisabled[] = {CRACK_Colours_ButtonBackground, 2/5};
	colorBackground[] = {CRACK_Colours_ButtonBackground, 4/5};
	colorBackgroundDisabled[] = {CRACK_Colours_ButtonBackground, 4/5};
	colorBackgroundActive[] = {CRACK_Colours_ButtonBackground, 5/5};
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorShadow[] = { 0, 0, 0, 0 };
	colorBorder[] = { 0, 0, 0, 0 };
	borderSize = 0;
	soundEnter[] = {"", 0, 1};
	soundPush[] = {"", 0.1, 1};
	soundClick[] = {"", 0, 1};
	soundEscape[] = {"", 0, 1};
};

class CRACK_Combo {
	idc = -1;
	x = CRACK_Box_X(0); y = CRACK_Box_Row(0,1);
	w = CRACK_Box_W; h = CRACK_Row_H;
	
	type = 4; style = 0x00;
	sizeEx = 0.032;	font = "Zeppelin32";
	
	rowHeight = CRACK_Row_H;
	wholeHeight = 5 * CRACK_Row_H;

	color[] = {1,1,1,3/4};
	colorText[] = {CRACK_Colours_WindowText, 3/5};
	colorBackground[] = {CRACK_Colours_DialogBackground, 2/4};
	colorSelect[] = {CRACK_Colours_WindowText, 1};
	colorSelectBackground[] = {CRACK_Colours_DialogBackground, 3/4};
	soundSelect[] = {"", 0.0, 1};
	soundExpand[] = {"", 0.0, 1};
	soundCollapse[] = {"", 0.0, 1};
	
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	maxHistoryDelay = 1.0;
	
	arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
	arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
	
	class ScrollBar	{
		color[] = {CRACK_Colours_WindowText, 3/4};
		colorActive[] = {CRACK_Colours_WindowText, 1};
		colorDisabled[] = {CRACK_Colours_WindowText, 1/2};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};

class CRACK_Edit {
	idc = -1;
	x = (CRACK_Box_X(0) + (CRACK_Box_W * 0.1)); y = CRACK_Box_Row(0,1);
	w = CRACK_Box_W * 1.3; h = CRACK_Row_H;
	
	htmlControl = true;
	type = 2; style = 0;
	sizeEx = 0.028;	font = "BitStream";
	border = "";

	colorBackground[] = {CRACK_Colours_White, 1};
	colorText[] = {CRACK_Colours_Black, 4/5};
	colorSelection[] = {0,0,0,1};

	autocomplete = false;
	text = "";
};

class CRACK_Slider {
	idc = -1;
	x = CRACK_Box_X(0); y = CRACK_Box_Row(0,1);
	w = CRACK_Box_W; h = CRACK_Row_H;
	
	type = 3; style = 0x400;
	
	color[] = {CRACK_Colours_WindowText, 4/5};
	coloractive[] = {CRACK_Colours_WindowText, 1};
	onSliderPosChanged = "";
};

class CRACK_Text {
	idc = -1;
	x = CRACK_Box_X(0); y = CRACK_Box_Row(0,1);
	w = CRACK_Box_W; h = CRACK_Row_H;
	
	type = 0; style = 0x00;
	sizeEx = 0.032;	font = "Zeppelin32";

	colorBackground[] = {0,0,0,0};
	colorText[] = {CRACK_Colours_WindowText, 1};
};

class CRACK_StructText {
	idc = -1;
	x = CRACK_Box_X(0); y = CRACK_Box_Row(0,1);
	w = CRACK_Box_W; h = CRACK_Row_H;
	
	type = 13; style = 0x00;
	size = 0.032;	font = "Zeppelin32";

	colorBackground[] = {0,0,0,0};
	colorText[] = {CRACK_Colours_WindowText, 1};
};

class CRACK_ControlGroup {
	idc = -1;
	x = CRACK_Box_X(0); y = CRACK_Box_Row(0,1);
	w = CRACK_Box_W; h = CRACK_Row_H;
	
	type = 15; style = 0x00;

	class VScrollbar {
		color[] = {1, 1, 1, 1};
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
	};
	class HScrollbar {
		color[] = {1, 1, 1, 1};
		height = 0.028;
	};
	class ScrollBar {
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		thumb = "#(argb,8,8,3)color(1,1,1,1)";
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
		border = "#(argb,8,8,3)color(1,1,1,1)";
	};
	class controls {};
};