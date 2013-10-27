//     ____   ____       _       ____   _  __        _   _    ___    _____   _____   ____       _      ____  
//    / ___| |  _ \     / \     / ___| | |/ /       | \ | |  / _ \  |_   _| | ____| |  _ \     / \    |  _ \ 
//   | |     | |_) |   / _ \   | |     | ' /        |  \| | | | | |   | |   |  _|   | |_) |   / _ \   | | | |
//   | |___  |  _ <   / ___ \  | |___  | . \        | |\  | | |_| |   | |   | |___  |  __/   / ___ \  | |_| |
//    \____| |_| \_\ /_/   \_\  \____| |_|\_\       |_| \_|  \___/    |_|   |_____| |_|     /_/   \_\ |____/ 
//                                                                                                          
//*********************************************************************************************************************
//
// DIALOG INIT
//
//*********************************************************************************************************************
#include "\x\crack\addons\main\rsc\defines.hpp"

//*********************************************************************************************************************

#define CRACK_xPos 1
#define CRACK_inputText "Input Text"
#define CRACK_outputText "Output Text"
#define CRACK_textSize 0.036
#define CRACK_soundPush {"", 0.1, 1}
#define CRACK_borderHeight 0.1
#define CRACK_borderWidth2 (CRACK_Box_W / 256)
#define CRACK_captionTextSize 0.032

class DefaultCalcButton : CRACK_Button {
	// Text
	sizeEx = CRACK_textSize;
	font = "Zeppelin32";
	// Position and Size
	h = CRACK_Row_DY(15.5,17.5) - (CRACK_borderHeight * CRACK_Row_H);
	w = ((CRACK_Box_W) / 4) - (CRACK_borderWidth2);
	// Colors
	colorText[] = {CRACK_Colours_Black, 1};
	colorBackground[] = {CRACK_Colours_White, 1};
	colorBackgroundActive[] = {CRACK_Colours_White, 0.8};
	colorFocused[] = {CRACK_Colours_White, 0.8};
	colorDisabled[] = {CRACK_Colours_White, 0};
	// Sounds
	soundPush[] = CRACK_soundPush;
	// Default
	default = false;
};

class DefaultNumCalcButton : DefaultCalcButton {
	// Colors
	colorText[] = {CRACK_Colours_White, 1};
	colorBackground[] = {CRACK_Colours_Black, 1};
	colorBackgroundActive[] = {CRACK_Colours_Black, 0.9};
	colorFocused[] = {CRACK_Colours_Black, 0.9};
	colorDisabled[] = {CRACK_Colours_Black, 0};
};

class CRACK_calculator_diag {
	idd = 80510;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "crack_notepad_dialogInUse = true;";
	onUnload = "crack_notepad_dialogInUse = false;";

	class controls {
		class Background : CRACK_Frame {
			x = (CRACK_Box_W) * CRACK_xPos;
			y = CRACK_Row_Y(10.5);
			h = CRACK_Row_DY(10.5,31.5);
			w = CRACK_Box_W;
			colorBackground[] = {CRACK_Colours_Whitelight,1};
		};
		class CalcCaption : CRACK_Caption {
			text = "Calculator";
			sizeEx = CRACK_captionTextSize;
			moving = 1;
			x = (CRACK_Box_W) * CRACK_xPos;
			y = CRACK_Row_Y(10.5);
			h = CRACK_Row_DY(10.5,11.5);
			w = CRACK_Box_W;
			colorText[] = {CRACK_Colours_Black, 1};
			colorBackground[] = {CRACK_Colours_Whitelight,1};
		};
		class DegRadCurrentState : CRACK_Caption {
			idc = 34;
			text = "DEG";
			sizeEx = CRACK_captionTextSize;
			x = ((CRACK_Box_W) * CRACK_xPos) + ((CRACK_Box_W) * (13/16));
			y = CRACK_Row_Y(10.5);
			h = CRACK_Row_DY(10.5,11.5);
			w = ((CRACK_Box_W) / 8);
			colorBackground[] = {CRACK_Colours_Whitelight, 1};
		};
		class CloseButton : CRACK_Button {
			text = "x";
			action = "closedialog 80510;";
			sizeEx = CRACK_captionTextSize;
			x = ((CRACK_Box_W) * CRACK_xPos) + ((CRACK_Box_W) * (15/16));
			y = CRACK_Row_Y(10.5);
			h = CRACK_Row_DY(10.5,11.5);
			w = ((CRACK_Box_W) / 16);
			colorText[] = {CRACK_Colours_Black, 1};
			colorBackground[] = {CRACK_Colours_White, 1};
			colorBackgroundActive[] = {CRACK_Colours_White, 0.5};
			colorFocused[] = {CRACK_Colours_White, 0.5};
			colorDisabled[] = {CRACK_Colours_White, 0};
		};
		class InputData : CRACK_Text {
			idc = 1;
			x = (CRACK_Box_W) * CRACK_xPos;
			y = CRACK_Row_Y(11.5);
			h = CRACK_Row_DY(11.5,13.475) - ((CRACK_borderHeight / 4) * CRACK_Row_H);
			w = CRACK_Box_W;
			sizeEx = CRACK_textSize;
			colorBackground[] = {CRACK_Colours_Black, 1};
			colorText[] = {CRACK_Colours_White, 1};
			text = CRACK_inputText;
		};
		class OutputData : CRACK_Text {
			idc = 2;
			x = (CRACK_Box_W) * CRACK_xPos;
			y = CRACK_Row_Y(13.5);
			h = CRACK_Row_DY(13.525,15.5) - ((CRACK_borderHeight / 4) * CRACK_Row_H);
			w = CRACK_Box_W;
			sizeEx = CRACK_textSize;
			colorBackground[] = {CRACK_Colours_Black, 1};
			colorText[] = {CRACK_Colours_White, 1};
			text = CRACK_outputText;
		};
		
		// Buttons ------------------------------------------------------------------------------
		
		// ROW 1 ******************************************
			class ParenthesisButtonLeft : DefaultCalcButton {
				// ID and Action
				idc = 3;
				action = "['('] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "(";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 0 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(15.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class ParenthesisButtonRight : DefaultCalcButton {
				// ID and Action
				idc = 4;
				action = "[')'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = ")";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 1 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(15.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class DelButton : DefaultCalcButton {
				// ID and Action
				idc = 5;
				action = "['del'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "DEL";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 2 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(15.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class ClearButton : DefaultCalcButton {
				// ID and Action
				idc = 6;
				action = "['clear'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "CLEAR";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 3 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(15.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
		// END ROW 1 **************************************
		//-------------------------------------------------
		// ROW 2 ******************************************
			class RadButton : DefaultCalcButton {
				// ID and Action
				idc = 7;
				action = "['rad('] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "rad(";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 0 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(17.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class PowHatButton : DefaultCalcButton {
				// ID and Action
				idc = 8;
				action = "['^('] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "x^y";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 1 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(17.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class SQRTButton : DefaultCalcButton {
				// ID and Action
				idc = 9;
				action = "['sqrt('] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "sqrt()";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 2 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(17.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class PiButton : DefaultCalcButton {
				// ID and Action
				idc = 10;
				action = "['pi'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "pi";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 3 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(17.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
		// END ROW 2 **************************************
		//-------------------------------------------------
		// ROW 3 ******************************************
			class SinButton : DefaultCalcButton {
				// ID and Action
				idc = 11;
				action = "['sin('] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "sin";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 0 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(19.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class CosButton : DefaultCalcButton {
				// ID and Action
				idc = 12;
				action = "['cos('] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "cos";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 1 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(19.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class TanButton : DefaultCalcButton {
				// ID and Action
				idc = 13;
				action = "['tan('] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "tan";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 2 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(19.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class DivButton : DefaultCalcButton {
				// ID and Action
				idc = 14;
				action = "['/'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "/";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 3 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(19.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
		// END ROW 3 **************************************
		//-------------------------------------------------
		// ROW 4 ******************************************
			class ArcSinButton : DefaultCalcButton {
				// ID and Action
				idc = 15;
				action = "['asin('] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "arcsin";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 0 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(21.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class ArcCosButton : DefaultCalcButton {
				// ID and Action
				idc = 16;
				action = "['acos('] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "arccos";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 1 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(21.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class ArcTanButton : DefaultCalcButton {
				// ID and Action
				idc = 17;
				action = "['atan('] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "arctan";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 2 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(21.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class MultButton : DefaultCalcButton {
				// ID and Action
				idc = 18;
				action = "['*'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "*";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 3 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(21.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
		// END ROW 4 **************************************
		//-------------------------------------------------
		// ROW 5 ******************************************
			class SevenButton : DefaultNumCalcButton {
				// ID and Action
				idc = 19;
				action = "['7'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "7";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 0 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(23.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class EightButton : DefaultNumCalcButton {
				// ID and Action
				idc = 20;
				action = "['8'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "8";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 1 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(23.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class NineButton : DefaultNumCalcButton {
				// ID and Action
				idc = 21;
				action = "['9'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "9";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 2 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(23.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class MinButton : DefaultCalcButton {
				// ID and Action
				idc = 22;
				action = "['-'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "-";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 3 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(23.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
		// END ROW 5 **************************************
		//-------------------------------------------------
		// ROW 6 ******************************************
			class FourButton : DefaultNumCalcButton {
				// ID and Action
				idc = 23;
				action = "['4'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "4";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 0 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(25.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class FiveButton : DefaultNumCalcButton {
				// ID and Action
				idc = 24;
				action = "['5'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "5";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 1 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(25.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class SixButton : DefaultNumCalcButton {
				// ID and Action
				idc = 25;
				action = "['6'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "6";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 2 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(25.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class PlusButton : DefaultCalcButton {
				// ID and Action
				idc = 26;
				action = "['+'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "+";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 3 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(25.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
		// END ROW 6 **************************************
		//-------------------------------------------------
		// ROW 7 ******************************************
			class OneButton : DefaultNumCalcButton {
				// ID and Action
				idc = 27;
				action = "['1'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "1";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 0 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(27.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class TwoButton : DefaultNumCalcButton {
				// ID and Action
				idc = 28;
				action = "['2'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "2";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 1 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(27.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class ThreeButton : DefaultNumCalcButton {
				// ID and Action
				idc = 29;
				action = "['3'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "3";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 2 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(27.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			class EqualButton : DefaultCalcButton {
				// ID and Action
				idc = 30;
				action = "['='] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "=";
				// Position and Size
				h = CRACK_Row_DY(27.5,31.5) - (CRACK_borderHeight * CRACK_Row_H);
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 3 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(27.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
				default = true;
			};
		// END ROW 7 **************************************
		//-------------------------------------------------
		// ROW 7 ******************************************
			class AnsButton : DefaultCalcButton {
				// ID and Action
				idc = 31;
				action = "['ANS'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "ANS";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 0 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(29.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class ZeroButton : DefaultNumCalcButton {
				// ID and Action
				idc = 32;
				action = "['0'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = "0";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 1 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(29.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
			
			class DotButton : DefaultCalcButton {
				// ID and Action
				idc = 33;
				action = "['.'] call crack_notepad_fnc_calculatorGUI;";
				// Text
				text = ".";
				// Position and Size
				x = ((CRACK_Box_W) * CRACK_xPos) + ( 2 * ((CRACK_Box_W) / 4)) + ((CRACK_borderWidth2) / 2);
				y = CRACK_Row_Y(29.5) + ((CRACK_borderHeight / 2) * CRACK_Row_H);
			};
		// END ROW 7 **************************************
		
		// End Buttons --------------------------------------------------------------------------
		
	};
};
//*********************************************************************************************************************

class CRACK_notepad_diag_main {
	idd = 80509;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "crack_notepad_dialogInUse = true;";
	onUnload = "crack_notepad_dialogInUse = false;";

	class controls {
		class Background : CRACK_Frame {
			y = CRACK_Row_Y(0);
			h = CRACK_Row_DY(0,30);
			w = CRACK_Box_W * 1.5;
		};
		class NotePadCaption : CRACK_Caption {
			text = "NotePad";
			moving = 1;
			y = CRACK_Row_Y(0);
			w = CRACK_Box_W * 1.5;
		};
		class NotePage : CRACK_Combo {
			idc = 1;
			x = (CRACK_Box_X(0) + (CRACK_Box_W * 0.1));
			y = CRACK_Row_Y(2);
			w = CRACK_Box_W * (.6);
			onLBSelChanged = "[2, [lbCurSel 1]] spawn crack_notepad_fnc_notepadGUI;";
		};
		class NoteLoad : CRACK_Button {
			text = "Clear Page";
			x = (CRACK_Box_X(0) + (CRACK_Box_W * 0.8)));
			y = CRACK_Row_Y(2);
			w = CRACK_Box_W * (.6);
			action = "[4] spawn crack_notepad_fnc_notepadGUI;";
		};
		class NoteTitle : CRACK_Edit {
			idc = 3;
			y = CRACK_Row_Y(4);
			w = CRACK_Box_W * 1.3;
		};
		class CodeCaption : CRACK_Caption {
			text = "Notes:";
			y = CRACK_Row_Y(6);
			w = CRACK_Box_W * 1.5;
		};
		class Notes5 : CRACK_Edit {
			idc = 6;
			y = CRACK_Row_dif_Y(8);
		};
		class Notes6 : CRACK_Edit {
			idc = 7;
			y = CRACK_Row_dif_Y(9);
		};
		class Notes7 : CRACK_Edit {
			idc = 8;
			y = CRACK_Row_dif_Y(10);
		};
		class Notes8 : CRACK_Edit {
			idc = 9;
			y = CRACK_Row_dif_Y(11);
		};
		class Notes9 : CRACK_Edit {
			idc = 10;
			y = CRACK_Row_dif_Y(12);
		};
		class Notes10 : CRACK_Edit {
			idc = 11;
			y = CRACK_Row_dif_Y(13);
		};
		class Notes11 : CRACK_Edit {
			idc = 12;
			y = CRACK_Row_dif_Y(14);
		};
		class Notes12 : CRACK_Edit {
			idc = 13;
			y = CRACK_Row_dif_Y(15);
		};
		class Notes13 : CRACK_Edit {
			idc = 14;
			y = CRACK_Row_dif_Y(16);
		};
		class Notes14 : CRACK_Edit {
			idc = 15;
			y = CRACK_Row_dif_Y(17);
		};
		class Notes15 : CRACK_Edit {
			idc = 16;
			y = CRACK_Row_dif_Y(18);
			h = CRACK_Row_DY(18,19);
		};
		class Notes16 : CRACK_Edit {
			idc = 17;
			y = CRACK_Row_dif_Y(19);
		};
		class Notes17 : CRACK_Edit {
			idc = 18;
			y = CRACK_Row_dif_Y(20);
		};
		class Notes18 : CRACK_Edit {
			idc = 19;
			y = CRACK_Row_dif_Y(21);
		};
		class Notes19 : CRACK_Edit {
			idc = 20;
			y = CRACK_Row_dif_Y(22);
		};
		class Notes20 : CRACK_Edit {
			idc = 21;
			y = CRACK_Row_dif_Y(23);
		};
		class Notes21 : CRACK_Edit {
			idc = 22;
			y = CRACK_Row_dif_Y(24);
		};
		class Notes22 : CRACK_Edit {
			idc = 23;
			y = CRACK_Row_dif_Y(25);
		};
		class Notes23 : CRACK_Edit {
			idc = 24;
			y = CRACK_Row_dif_Y(26);
		};
		class Notes24 : CRACK_Edit {
			idc = 25;
			y = CRACK_Row_dif_Y(27);
		};
		class Notes25 : CRACK_Edit {
			idc = 26;
			y = CRACK_Row_dif_Y(28);
		};
		class Clear : CRACK_Button {
			text = "Copy";
			w = CRACK_Box_W * (1.5 * (0.25));
			y = CRACK_Row_Y(30);
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "[5] spawn crack_notepad_fnc_notepadGUI;";
		};
		class Save : CRACK_Button {
			text = "Save";
			w = CRACK_Box_W * (1.5 * (0.5));
			x = CRACK_Box_X(0) + (CRACK_Box_W * (1.5 * (0.25)));
			y = CRACK_Row_Y(30);
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "[3] spawn crack_notepad_fnc_notepadGUI;";
			default = true;
		};
		class Close : CRACK_Button {
			text = "Close";
			w = CRACK_Box_W * (1.5 * (0.25));
			x = CRACK_Box_X(0) + (CRACK_Box_W * (1.5 * (0.75)));
			y = CRACK_Row_Y(30);
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "closeDialog 80509;";
		};
	};
};


class CRACK_reminders_diag_main {
	idd = 80529;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "crack_notepad_dialogInUse = true;";
	onUnload = "crack_notepad_dialogInUse = false;";

	class controls {
		class Background : CRACK_Frame {
			y = CRACK_Row_Y(0) + CRACK_Row_Y(18);
			x = CRACK_Box_X(2);
			h = CRACK_Row_DY(0,6);
			w = CRACK_Box_W * .5;
		};
		class NotePadCaption : CRACK_Caption {
			text = "Reminders";
			moving = 1;
			y = CRACK_Row_Y(0) + CRACK_Row_Y(18);
			x = CRACK_Box_X(2);
			w = CRACK_Box_W * .5;
		};
		class NewReminder : CRACK_Button {
			text = "Create";
			idc = 1;
			x = (CRACK_Box_X(2) + (CRACK_Box_W * 0.1));
			y = CRACK_Row_Y(2) + CRACK_Row_Y(18);
			w = CRACK_Box_W * .3;
			action = "[1] call crack_notepad_fnc_reminderGUI;";
			default = true;
		};
		class DeleteReminder : CRACK_Button {
			text = "Delete";
			idc = 2;
			x = (CRACK_Box_X(2) + (CRACK_Box_W * 0.1));
			y = CRACK_Row_Y(4) + CRACK_Row_Y(18);
			w = CRACK_Box_W * .3;
			action = "[2] call crack_notepad_fnc_reminderGUI;";
		};
		class Close : CRACK_Button {
			text = "Close";
			w = CRACK_Box_W * .5;
			x = CRACK_Box_X(2);
			y = CRACK_Row_Y(6) + CRACK_Row_Y(18);
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "closeDialog 80529;";
		};
	};
};

class CRACK_reminders_diag_new_reminder {
	idd = 80519;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "crack_notepad_dialogInUse = true;";
	onUnload = "crack_notepad_dialogInUse = false;";

	class controls {
		class Background : CRACK_Frame {
			y = CRACK_Row_Y(0);
			h = CRACK_Row_DY(0,20);
			w = CRACK_Box_W;
		};
		class NotePadCaption : CRACK_Caption {
			text = "New Reminder";
			moving = 1;
			y = CRACK_Row_Y(0);
			w = CRACK_Box_W;
		};
		class TitleText : CRACK_Text {
			text = "Title:";
			colorText[] = {CRACK_Colours_Black, 1};
			x = (CRACK_Box_X(0) + (CRACK_Box_W * 0.08));
			y = CRACK_Row_Y(2);
			w = CRACK_Box_W * .3;
		};
		class NoteTitle : CRACK_Edit {
			idc = 3;
			y = CRACK_Row_Y(3);
			w = CRACK_Box_W * .8;
		};
		class CodeCaption : CRACK_Caption {
			text = "Options:";
			y = CRACK_Row_Y(5);
			w = CRACK_Box_W;
		};
		class TimerText : CRACK_Text {
			text = "Timer:";
			colorText[] = {CRACK_Colours_Black, 1};
			x = (CRACK_Box_X(0) + (CRACK_Box_W * 0.08));
			y = CRACK_Row_dif_Y(7);
			w = CRACK_Box_W * .3;
		};
		class MinuteText : CRACK_Edit {
			idc = 6;
			x = CRACK_Box_X(0) + (CRACK_Box_W * 0.28);
			y = CRACK_Row_dif_Y(7);
			w = CRACK_Box_W * .3;
		};
		class Notes5 : CRACK_Text {
			text = "Minutes";
			colorText[] = {CRACK_Colours_Black, 1};
			x = (CRACK_Box_X(0) + (CRACK_Box_W * 0.6));
			y = CRACK_Row_dif_Y(7);
			w = CRACK_Box_W * .3;
		};
		class HintText : CRACK_Text {
			text = "Hint Text:";
			colorText[] = {CRACK_Colours_Black, 1};
			x = (CRACK_Box_X(0) + (CRACK_Box_W * 0.08));
			y = CRACK_Row_dif_Y(9);
			w = CRACK_Box_W * .3;
		};
		class Hint : CRACK_Edit {
			idc = 7;
			style = 16;
			h = CRACK_Row_H * 8;
			y = CRACK_Row_dif_Y(10);
			w = CRACK_Box_W * .8;
		};
		class ExtraText : CRACK_Text {
			text = "Use <br/> to create a new line";
			sizeEx = 0.020;
			colorText[] = {CRACK_Colours_Black, 1};
			x = (CRACK_Box_X(0) + (CRACK_Box_W * 0.082));
			y = CRACK_Row_dif_Y(18);
			w = CRACK_Box_W * .8;
		};
		class Clear : CRACK_Button {
			text = "Clear";
			w = CRACK_Box_W * 0.25;
			y = CRACK_Row_Y(20);
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "[4] call crack_notepad_fnc_reminderGUI;";
		};
		class Save : CRACK_Button {
			text = "Create";
			w = CRACK_Box_W * 0.5;
			x = CRACK_Box_X(0) + (CRACK_Box_W * 0.25);
			y = CRACK_Row_Y(20);
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "[3] call crack_notepad_fnc_reminderGUI;";
			default = true;
		};
		class Close : CRACK_Button {
			text = "Close";
			w = CRACK_Box_W * 0.25;
			x = CRACK_Box_X(0) + (CRACK_Box_W * 0.75);
			y = CRACK_Row_Y(20);
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "closeDialog 80519;";
		};
	};
};

class CRACK_reminders_diag_delete_reminder {
	idd = 80539;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "crack_notepad_dialogInUse = true;";
	onUnload = "crack_notepad_dialogInUse = false;";

	class controls {
		class Background : CRACK_Frame {
			y = CRACK_Row_Y(0) + CRACK_Row_Y(18);
			x = CRACK_Box_X(2);
			h = CRACK_Row_DY(0,4);
			w = CRACK_Box_W;
		};
		class NotePadCaption : CRACK_Caption {
			text = "Delete Reminder";
			moving = 1;
			y = CRACK_Row_Y(0) + CRACK_Row_Y(18);
			x = CRACK_Box_X(2);
			w = CRACK_Box_W;
		};
		class NewReminder : CRACK_Combo {
			idc = 1;
			x = (CRACK_Box_X(2) + (CRACK_Box_W * 0.1));
			y = CRACK_Row_Y(2) + CRACK_Row_Y(18);
			w = CRACK_Box_W * .8;
		};
		class DeleteReminder : CRACK_Button {
			text = "Delete";
			w = CRACK_Box_W * .5;
			x = CRACK_Box_X(2);
			y = CRACK_Row_Y(4) + CRACK_Row_Y(18);
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "[5] call crack_notepad_fnc_reminderGUI;";
		};
		class Close : CRACK_Button {
			text = "Close";
			w = CRACK_Box_W * .5;
			x = CRACK_Box_X(2) + (CRACK_Box_W * .5);
			y = CRACK_Row_Y(4) + CRACK_Row_Y(18);
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "closeDialog 80539;";
		};
	};
};

class CRACK_notepad_diag_copy_page {
	idd = 80549;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "crack_notepad_dialogInUse = true;";
	onUnload = "crack_notepad_dialogInUse = false;";

	class controls {
		class Background : CRACK_Frame {
			y = CRACK_Row_Y(0) + CRACK_Row_Y(18);
			x = CRACK_Box_X(2);
			h = CRACK_Row_DY(0,10);
			w = CRACK_Box_W;
		};
		class NotePadCaption : CRACK_Caption {
			text = "Copy NotePad Page";
			moving = 1;
			y = CRACK_Row_Y(0) + CRACK_Row_Y(18);
			x = CRACK_Box_X(2);
			w = CRACK_Box_W;
		};
		class TheirPage : CRACK_Combo {
			idc = 1;
			x = (CRACK_Box_X(2) + (CRACK_Box_W * 0.1));
			y = CRACK_Row_Y(2) + CRACK_Row_Y(18);
			w = CRACK_Box_W * .8;
		};
		class ExtraText : CRACK_Text {
			text = "to your page of";
			colorText[] = {CRACK_Colours_Black, 1};
			x = (CRACK_Box_X(2) + (CRACK_Box_W * 0.3));
			y = CRACK_Row_Y(4) + CRACK_Row_Y(18);
			w = CRACK_Box_W * .8;
		};
		class YourPage : CRACK_Combo {
			idc = 2;
			x = (CRACK_Box_X(2) + (CRACK_Box_W * 0.1));
			y = CRACK_Row_Y(6) + CRACK_Row_Y(18);
			w = CRACK_Box_W * .8;
		};
		class CopyPage : CRACK_Button {
			text = "Copy";
			w = CRACK_Box_W * .5;
			x = CRACK_Box_X(2) + (CRACK_Box_W * 0.25));
			y = CRACK_Row_Y(8) + CRACK_Row_Y(18);
			action = "[6] spawn crack_notepad_fnc_notepadGUI;";
			default = true;
		};
		class Close : CRACK_Button {
			text = "Close";
			w = CRACK_Box_W ;
			x = CRACK_Box_X(2);
			y = CRACK_Row_Y(10) + CRACK_Row_Y(18);
			action = "closeDialog 80549;";
		};
	};
};

class CRACK_notepad_diag_copyPageToClipboard {
	idd = 80559;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "crack_notepad_copyPageToCBDiagOpen = true; crack_notepad_dialogInUse = true;";
	onUnload = "crack_notepad_copyPageToCBDiagOpen = false;";

	class controls {
		class Background : CRACK_Frame {
			y = CRACK_Row_Y(0) + CRACK_Row_Y(18);
			x = CRACK_Box_X(1.5);
			h = CRACK_Row_DY(0,11);
			w = CRACK_Box_W;
		};
		class NotePadCaption : CRACK_Caption {
			text = "Copy Page to Clipboard";
			moving = 1;
			y = CRACK_Row_Y(0) + CRACK_Row_Y(18);
			x = CRACK_Box_X(1.5);
			w = CRACK_Box_W;
		};
		class CopyTextBox : CRACK_Edit {
			text = "";
			idc = 1;
			x = (CRACK_Box_X(1.5) + (CRACK_Box_W * 0.1));
			y = CRACK_Row_Y(2) + CRACK_Row_Y(18);
			w = CRACK_Box_W * .8;
			h = CRACK_Row_DY(0,5);
			style = ST_MULTI;
			default = true;
		};
		class CopyText0 : CRACK_Text {
			text = "Select & Copy (CTRL + C) all of the text above";
			sizeEx = 0.020;
			colorText[] = {CRACK_Colours_Black, 1};
			x = (CRACK_Box_X(1.5) + (CRACK_Box_W * 0.1));
			y = CRACK_Row_Y(7) + CRACK_Row_Y(18);
			w = CRACK_Box_W * .8;
		};
		class CopyText1 : CRACK_Text {
			text = "Remember to find and replace every <br />";
			//sizeEx = 0.020;
			colorText[] = {CRACK_Colours_Black, 1};
			x = (CRACK_Box_X(1.5) + (CRACK_Box_W * 0.1));
			y = CRACK_Row_Y(8.5) + CRACK_Row_Y(18);
			w = CRACK_Box_W * .8;
		};
		class CopyText2 : CRACK_Text {
			text = "with an actual line break.";
			//sizeEx = 0.020;
			colorText[] = {CRACK_Colours_Black, 1};
			x = (CRACK_Box_X(1.5) + (CRACK_Box_W * 0.1));
			y = CRACK_Row_Y(9.1) + CRACK_Row_Y(18);
			w = CRACK_Box_W * .8;
		};
		class Close : CRACK_Button {
			text = "Close";
			w = CRACK_Box_W;
			x = CRACK_Box_X(1.5);
			y = CRACK_Row_Y(10.99) + CRACK_Row_Y(18);
			colorFocused[] = {CRACK_Colours_White, 3/5};
			colorBackgroundActive[] = {CRACK_Colours_White, 5/5};
			action = "closeDialog 80529;";
		};
	};
};