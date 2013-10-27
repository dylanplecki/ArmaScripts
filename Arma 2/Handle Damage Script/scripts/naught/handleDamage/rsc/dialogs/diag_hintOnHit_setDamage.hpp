class cm_handleDamage_hintOnHit_setDamage {
	idd = 70529;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['load'] spawn cm_handleDamage_hds_hintOnHit_diag_setDamage;";
	onUnload = "";

	class controls {
		
		#define BOXWIDTH CRACK_Box_W * .8
		#define ROWNUMSTART 18
		#define ROWNUMSPACE 0.1
		#define CPADDING (CRACK_Box_W * 0.1)
		
		#define XCOORD CRACK_Box_X(2)
		#define XCOORDPAD XCOORD + CPADDING
		#define YCOORD CRACK_Row_Y(ROWNUM) + CRACK_Row_Y(ROWNUMSTART) + (CRACK_Row_Y(ROWNUM) * ROWNUMSPACE)
		
		#define BGEND CRACK_Row_DY(0,12) + (CRACK_Row_DY(0,12) * ROWNUMSPACE)
		
		#define ROWNUM 0
		
		class Background : CRACK_Frame {
			y = YCOORD;
			x = XCOORD;
			h = BGEND;
			w = BOXWIDTH;
		};
		class Caption : CRACK_Caption {
			text = $STR_HINTONHIT_SETDAM;
			style = 0x00;
			idc = 99;
			moving = 1;
			y = YCOORD;
			x = XCOORD;
			w = BOXWIDTH;
		};
		
		#define ROWNUM 1
		// Empty Line
		
		//---------------------------------------
		
		#define ROWNUM 2
		
		class PlayerName : CRACK_Text {
			text = $STR_PLAYER;
			style = 0x00 + ST_CENTER;
			sizeEx = 0.048;
			idc = 98;
			x = XCOORDPAD;
			y = YCOORD;
			w = BOXWIDTH - (2 * CPADDING);
			h = 1.5 * CRACK_Row_H;
		};
		
		#define ROWNUM 3
		// Empty Line
		
		//---------------------------------------
		
		#define ROWNUM 4
		
		class Overall : CRACK_Text {
			text = $STR_BODY_ALL;
			x = XCOORDPAD;
			y = YCOORD;
			w = CRACK_Box_W * .25;
		};
		class OverallEdit : CRACK_Edit {
			idc = 1;
			x = (XCOORDPAD + (CRACK_Box_W * (0.25 + 0.1)));
			y = YCOORD;
			w = CRACK_Box_W * .15;
		};
		class OverallPercent : CRACK_Text {
			text = "%";
			x = (XCOORDPAD + (CRACK_Box_W * (0.25 + 0.1 + .15)));
			y = YCOORD;
			w = CPADDING;
		};
		
		//---
		
		#define ROWNUM 5
				
		class Head : CRACK_Text {
			text = $STR_BODY_HEAD;
			x = XCOORDPAD;
			y = YCOORD;
			w = CRACK_Box_W * .25;
		};
		class HeadEdit : CRACK_Edit {
			idc = 2;
			x = (XCOORDPAD + (CRACK_Box_W * (0.25 + 0.1)));
			y = YCOORD;
			w = CRACK_Box_W * .15;
		};
		class HeadPercent : CRACK_Text {
			text = "%";
			x = (XCOORDPAD + (CRACK_Box_W * (0.25 + 0.1 + .15)));
			y = YCOORD;
			w = CPADDING;
		};
		
		//---
		
		#define ROWNUM 6
				
		class Body : CRACK_Text {
			text = $STR_BODY_BODY;
			x = XCOORDPAD;
			y = YCOORD;
			w = CRACK_Box_W * .25;
		};
		class BodyEdit : CRACK_Edit {
			idc = 3;
			x = (XCOORDPAD + (CRACK_Box_W * (0.25 + 0.1)));
			y = YCOORD;
			w = CRACK_Box_W * .15;
		};
		class BodyPercent : CRACK_Text {
			text = "%";
			x = (XCOORDPAD + (CRACK_Box_W * (0.25 + 0.1 + .15)));
			y = YCOORD;
			w = CPADDING;
		};
		
		//---
		
		#define ROWNUM 7
				
		class Hands : CRACK_Text {
			text = $STR_BODY_HANDS;
			x = XCOORDPAD;
			y = YCOORD;
			w = CRACK_Box_W * .25;
		};
		class HandsEdit : CRACK_Edit {
			idc = 4;
			x = (XCOORDPAD + (CRACK_Box_W * (0.25 + 0.1)));
			y = YCOORD;
			w = CRACK_Box_W * .15;
		};
		class HandsPercent : CRACK_Text {
			text = "%";
			x = (XCOORDPAD + (CRACK_Box_W * (0.25 + 0.1 + .15)));
			y = YCOORD;
			w = CPADDING;
		};
		
		//---
		
		#define ROWNUM 8
				
		class Legs : CRACK_Text {
			text = $STR_BODY_LEGS;
			x = XCOORDPAD;
			y = YCOORD;
			w = CRACK_Box_W * .25;
		};
		class LegsEdit : CRACK_Edit {
			idc = 5;
			x = (XCOORDPAD + (CRACK_Box_W * (0.25 + 0.1)));
			y = YCOORD;
			w = CRACK_Box_W * .15;
		};
		class LegsPercent : CRACK_Text {
			text = "%";
			x = (XCOORDPAD + (CRACK_Box_W * (0.25 + 0.1 + .15)));
			y = YCOORD;
			w = CPADDING;
		};
		
		//---------------------------------------
		
		#define ROWNUM 9
		// Empty Line
		
		#define ROWNUM 10
		class NoteText : CRACK_Text {
			text = $STR_HINTONHIT_NOTETEXT;
			sizeEx = 0.016;
			lineSpacing = 1;
			style = ST_MULTI;
			x = XCOORDPAD;
			y = YCOORD;
			w = BOXWIDTH - (2 * CPADDING);
			h = 1.5 * CRACK_Row_H;
		};
		
		#define ROWNUM 11
		// Empty Line
		
		#define ROWNUM 12
		
		class Save : CRACK_Button {
			text = $STR_SAVE;
			w = BOXWIDTH / 2;
			x = XCOORD;
			y = YCOORD;
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			default = true;
			action = "['save'] spawn cm_handleDamage_hds_hintOnHit_diag_setDamage;";
		};
		class Close : CRACK_Button {
			text = $STR_CLOSE;
			w = BOXWIDTH / 2;
			x = XCOORD + (CRACK_Box_W * .4);
			y = YCOORD;
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "closeDialog 70529;";
		};
	};
};