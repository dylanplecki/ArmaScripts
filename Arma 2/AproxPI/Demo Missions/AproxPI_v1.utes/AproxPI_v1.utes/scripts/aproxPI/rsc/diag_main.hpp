class aproxpi_main {
	idd = 80709;
	movingEnable = 1;
	enableSimulation = 0;
	onLoad = "[] spawn AproxPI_fnc_popDialog;";
	onUnload = "nul = [] spawn {sleep 1; createDialog 'aproxpi_main';};";
	
	#define DCOLS		3
	#define DROWS		24
	
	#define DWIDTH		(CRACK_Box_W * DCOLS)
	#define DHEIGHT		(CRACK_Row_H * DROWS)
	#define DFTX		(safeCX - (DWIDTH / 2))
	#define DFTY		(safeCY - (DHEIGHT / 2))
	
	#define GETX(col)	(DFTX + (CRACK_Box_W * col))
	#define GETY(row)	(DFTY + (CRACK_Row_H * row))
	
	class controls {
		class Background : CRACK_Frame {
			x = DFTX;
			y = DFTY;
			h = DHEIGHT;
			w = DWIDTH;
		};
		class MainCaption : CRACK_Caption {
			text = "AproxPI Simulation";
			moving = 1;
			x = DFTX;
			y = DFTY;
			w = DWIDTH;
		};
		
		// Start Preset Area --------------------
		
		#define CTRLWIDTH .17
		#define CTRLPADDING 0.025
		#define CTRLX(col) DFTX + (DWIDTH * ((CTRLPADDING * (col)) + (CTRLWIDTH * (col - 1))))
		
		class BenchText : CRACK_Text {
			text = "Preset AproxPI Benchmarks:";
			x = CTRLX(1);
			y = GETY(3);
			w = DWIDTH * CTRLWIDTH;
		};
		class LightBench : CRACK_Button {
			text = "Light Benchmark";
			x = CTRLX(2);
			y = GETY(3);
			w = DWIDTH * CTRLWIDTH;
			action = "['preset', AproxPI_lightBench] spawn AproxPI_fnc_loadBench;";
			default = true;
		};
		class MedBench : CRACK_Button {
			text = "Normal Benchmark";
			x = CTRLX(3);
			y = GETY(3);
			w = DWIDTH * CTRLWIDTH;
			action = "['preset', AproxPI_medBench] spawn AproxPI_fnc_loadBench;";
		};
		class HeavyBench : CRACK_Button {
			text = "Extreme Benchmark";
			x = CTRLX(4);
			y = GETY(3);
			w = DWIDTH * CTRLWIDTH;
			action = "['preset', AproxPI_heavyBench] spawn AproxPI_fnc_loadBench;";
		};
		class BechMethod : CRACK_Combo {
			idc = 1;
			x = CTRLX(5);
			y = GETY(3);
			w = DWIDTH * CTRLWIDTH;
		};
		
		// Start Custom Area --------------------
		
		#define DIVIDERWIDTH (CRACK_Row_H / 4)
		
		#define CTRLWIDTH .2125
		#define CTRLPADDING 0.025
		#define CTRLX(col) DFTX + (DWIDTH * ((CTRLPADDING * (col)) + (CTRLWIDTH * (col - 1))))
		
		class CustomCaption : CRACK_Caption {
			text = "Custom Benchmark";
			x = DFTX;
			y = GETY(6);
			w = (DWIDTH / 2) - (DIVIDERWIDTH / 2);
		};
		
		class IterationsText : CRACK_Text {
			text = "Number of Iterations: ";
			x = CTRLX(1);
			y = GETY(8);
			w = (DWIDTH * CTRLWIDTH) - (DIVIDERWIDTH / 2);
		};
		class IterationsField : CRACK_Edit {
			idc = 2;
			x = CTRLX(2);
			y = GETY(8);
			w = (DWIDTH * CTRLWIDTH) - (DIVIDERWIDTH / 2);
		};
		
		class SubIterationsText : CRACK_Text {
			text = "Number of Runs per Iteration: ";
			x = CTRLX(1);
			y = GETY(10);
			w = (DWIDTH * CTRLWIDTH) - (DIVIDERWIDTH / 2);
		};
		class SubIterationsField : CRACK_Edit {
			idc = 3;
			x = CTRLX(2);
			y = GETY(10);
			w = (DWIDTH * CTRLWIDTH) - (DIVIDERWIDTH / 2);
		};
		
		class MethodText : CRACK_Text {
			text = "Method to Run: ";
			x = CTRLX(1);
			y = GETY(12);
			w = (DWIDTH * CTRLWIDTH) - (DIVIDERWIDTH / 2);
		};
		class MethodField : CRACK_Combo {
			idc = 4;
			x = CTRLX(2);
			y = GETY(12);
			w = (DWIDTH * CTRLWIDTH) - (DIVIDERWIDTH / 2);
		};
		
		class TimePrecText : CRACK_Text {
			text = "Output Time Decimal Precision: ";
			x = CTRLX(1);
			y = GETY(14);
			w = (DWIDTH * CTRLWIDTH) - (DIVIDERWIDTH / 2);
		};
		class TimePrecField : CRACK_Edit {
			idc = 5;
			x = CTRLX(2);
			y = GETY(14);
			w = (DWIDTH * CTRLWIDTH) - (DIVIDERWIDTH / 2);
		};
		
		class PIPrecText : CRACK_Text {
			text = "Output PI Decimal Precision: ";
			x = CTRLX(1);
			y = GETY(16);
			w = (DWIDTH * CTRLWIDTH) - (DIVIDERWIDTH / 2);
		};
		class PIPrecField : CRACK_Edit {
			idc = 6;
			x = CTRLX(2);
			y = GETY(16);
			w = (DWIDTH * CTRLWIDTH) - (DIVIDERWIDTH / 2);
		};
		
		// Start Divider Area -------------------
		
		#define DIVIDEROFFSET .03
		
		class Divider : CRACK_Frame {
			colorBackground[] = {CRACK_Colours_CaptionBackground, 4/5};
			x = DFTX + (DWIDTH / 2) - (DIVIDERWIDTH / 2) - (DIVIDERWIDTH * (DIVIDEROFFSET / 2));
			y = GETY(6);
			w = DIVIDERWIDTH * (1 + DIVIDEROFFSET);
			h = DHEIGHT - (CRACK_Row_H * 6);
		};
		
		// Start Output Area --------------------
		
		#define CTRLWIDTH .45
		#define CTRLPADDING 0.025
		#define CTRLX(col) DFTX + (DWIDTH / 2) + (DWIDTH * ((CTRLPADDING * (col)) + (CTRLWIDTH * (col - 1)))) + (DIVIDERWIDTH / 2)
		
		class OutputCaption : CRACK_Caption {
			text = "Benchmark Output";
			x = DFTX + (DWIDTH / 2) + (DIVIDERWIDTH / 2);
			y = GETY(6);
			w = (DWIDTH / 2) - (DIVIDERWIDTH / 2);
		};
		class OutputArea : CRACK_Text {
			idc = 99;
			text = "";
			colorText[] = {CRACK_Colours_ButtonText, 1};
			colorBackground[] = {CRACK_Colours_ButtonBackground, 2/5};
			style = 0x10 + 0x200;
			lineSpacing = 1;
			x = CTRLX(1);
			y = GETY(8);
			w = (DWIDTH / 2) - (DIVIDERWIDTH / 2) - (DWIDTH * 2 * CTRLPADDING);
			h = DHEIGHT - (CRACK_Row_H * 11);
		};
		class CopyToClip : CRACK_Button {
			text = "Copy to Clipboard";
			x = CTRLX(1);
			y = GETY(21);
			w = ((DWIDTH / 2) - (DIVIDERWIDTH / 2) - (DWIDTH * 2 * CTRLPADDING)) / 2;
			action = "copyToClipboard (ctrlText 99);";
		};
		class ExportToLog : CRACK_Button {
			text = "Write to RPT";
			x = CTRLX(1) + (((DWIDTH / 2) - (DIVIDERWIDTH / 2) - (DWIDTH * 2 * CTRLPADDING)) / 2);
			y = GETY(21);
			w = ((DWIDTH / 2) - (DIVIDERWIDTH / 2) - (DWIDTH * 2 * CTRLPADDING)) / 2;
			action = "diag_log text(ctrlText 99);";
		};
		
		// Footer for buttons below -------------
		
		class StartCustom : CRACK_Button {
			text = "Start Custom Benchmark";
			w = (DWIDTH / 2);
			x = DFTX;
			y = (DFTY + DHEIGHT);
			action = "['custom'] spawn AproxPI_fnc_loadBench;";
		};
		class ExitMission : CRACK_Button {
			text = "Exit Mission";
			w = (DWIDTH / 2);
			x = DFTX + (DWIDTH / 2);
			y = (DFTY + DHEIGHT);
			action = "endMission 'END1'; forceEnd;";
		};
	};
};