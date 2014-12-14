#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

// base classes
class mustyTools_picture
{
	type = 0;
	style = 48;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};

class mustyToolsBGbase
{
	type = 0;
	idc = 124;
	style = 128;
	text = "";
	colorText[] = {0,0,0,1};
	font = "PuristaMedium";
	sizeEx = 0;
	shadow = 0;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	colorbackground[] = {0.1,0.1,0.1,0.8};
};

class mustyTools_text
{
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class mustyTools_listBox
{
	access = 0;
	// type = 5;
	type = 102;
	w = 0.4;
	h = 0.4;
	rowHeight = 0.01;
	idcLeft = -1;
	idcRight = -1;
	drawSideArrows = 0;
	onLBDblClick = "_null = [_this] spawn mustyToolsAction;";
	color[] = {1,0,1,1};
	colorText[] = {1,1,1,1};	// colour of text
	colorDisabled[] = {1,1,1,0.25};
	colorScrollbar[] = {0,0,0,0.5};
	colorSelect[] = {0,0,0,0.5};	// flashing colour of text
	colorSelect2[] = {0,0,0,0.5};	// flashing colour of text
	colorSelectBackground[] = {0.95,0.95,0.95,1};	// flashing colour of row
	colorSelectBackground2[] = {1,1,1,0.5};	// flashing colour of row
	colorBackground[] = {1,0,0,0.5};	// doesnt work
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	class ListScrollBar
	{
		color[] = {1,1,1,0.5};
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		// border = "#(argb,8,8,3)color(0.15,0.3,0.15,1)";
		autoScrollEnabled = 1;
	};
	style = 16;
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
	shadow = 0;
	colorShadow[] = {1,0,0,0.5};
	period = 0.5;
	maxHistoryDelay = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class mustyTools_stext
{
	access = 0;
	type = 13;
	idc = -1;
	style = 0;
	colorText[] = {1,1,1,1};
	class Attributes
	{
		font = "PuristaMedium";
		color = "#ffffff";
		align = "left";
		shadow = 1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 1;
};

class mustyTools
{
	idd = 11391;
	movingEnable = true;
	
	controls[]=
	{
		mustyTools_list1,
		mustyTools_list2,
		mustyTools_list3,
		mustyTools_title,
		mustyTools_txt01,
		mustyTools_txt02,
		mustyTools_txt03,
		mustyTools_infoBox,
		mustyTools_logo,
		mustyTools_footer
	};
	
	controlsBackground[]=
	{
		mustyToolsBG,
		mustyToolsBG1,
		mustyToolsBG2,
		mustyToolsBG3
	};
	
	class mustyTools_list1: mustyTools_listBox
	{
		idc = 1500;
		x = -2.5 * GUI_GRID_W + GUI_GRID_X;
		y = 2 * GUI_GRID_H + GUI_GRID_Y;
		w = 15.5 * GUI_GRID_W;
		h = 20 * GUI_GRID_H;
		//sizeEx = 0.8 * GUI_GRID_H;
	};
	class mustyTools_list2: mustyTools_listBox
	{
		idc = 1501;
		x = 14 * GUI_GRID_W + GUI_GRID_X;
		y = 2 * GUI_GRID_H + GUI_GRID_Y;
		w = 13 * GUI_GRID_W;
		h = 20 * GUI_GRID_H;
		//sizeEx = 0.8 * GUI_GRID_H;
	};
	class mustyTools_list3: mustyTools_listBox
	{
		idc = 1502;
		x = 28 * GUI_GRID_W + GUI_GRID_X;
		y = 2 * GUI_GRID_H + GUI_GRID_Y;
		w = 14.5 * GUI_GRID_W;
		h = 20 * GUI_GRID_H;
		//sizeEx = 0.8 * GUI_GRID_H;
	};
	class mustyToolsBG1: mustyToolsBGbase
	{
		idc = 9990;
		x = -2.5 * GUI_GRID_W + GUI_GRID_X;
		y = 2 * GUI_GRID_H + GUI_GRID_Y;
		w = 15.5 * GUI_GRID_W;
		h = 20 * GUI_GRID_H;
		colorbackground[] = {0.1,0.1,0.1,0.9};
	};	
	class mustyToolsBG2: mustyToolsBGbase
	{
		idc = 9991;
		x = 14 * GUI_GRID_W + GUI_GRID_X;
		y = 2 * GUI_GRID_H + GUI_GRID_Y;
		w = 13 * GUI_GRID_W;
		h = 20 * GUI_GRID_H;
		colorbackground[] = {0.1,0.1,0.1,0.9};
	};
	class mustyToolsBG3: mustyToolsBGbase
	{
		idc = 9991;
		x = 28 * GUI_GRID_W + GUI_GRID_X;
		y = 2 * GUI_GRID_H + GUI_GRID_Y;
		w = 14.5 * GUI_GRID_W;
		h = 20 * GUI_GRID_H;
		colorbackground[] = {0.1,0.1,0.1,0.9};
	};
	
	class mustyTools_title: mustyTools_text
	{
		idc = 1000;
		text = "Musty Tools Menu"; //--- ToDo: Localize;
		moving = 1;
		x = -2.5 * GUI_GRID_W + GUI_GRID_X;
		y = -1 * GUI_GRID_H + GUI_GRID_Y;
		w = 31.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 1.3 * GUI_GRID_H;
	};
	class mustyTools_txt01: mustyTools_text
	{
		idc = 1001;
		text = "Player List"; //--- ToDo: Localize;
		x = -2.5 * GUI_GRID_W + GUI_GRID_X;
		y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 11.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 1 * GUI_GRID_H;
	};
	class mustyTools_txt02: mustyTools_text
	{
		idc = 1002;
		text = "Actions"; //--- ToDo: Localize;
		x = 14 * GUI_GRID_W + GUI_GRID_X;
		y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 11.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 1 * GUI_GRID_H;
	};
	class mustyTools_txt03: mustyTools_text
	{
		idc = 1003;
		text = "Spawn"; //--- ToDo: Localize;
		x = 28.5 * GUI_GRID_W + GUI_GRID_X;
		y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 11.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		sizeEx = 1 * GUI_GRID_H;
	};
	class mustyTools_infoBox: mustyTools_stext
	{
		idc = 1100;
		text = "instructionsGoHere"; //--- ToDo: Localize;
		x = -2.5 * GUI_GRID_W + GUI_GRID_X;
		y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 35.5 * GUI_GRID_W;
		h = 4 * GUI_GRID_H;
	};
	class mustyTools_logo: mustyTools_picture
	{
		idc = 1200;
		// text = "#(argb,8,8,3)color(1,1,1,1)";
		text = "adminTools\mustyflag.paa";
		x = 34 * GUI_GRID_W + GUI_GRID_X;
		y = 22.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 8.5 * GUI_GRID_W;
		h = 4 * GUI_GRID_H;
	};
	class mustyTools_footer: mustyTools_text
	{
		idc = 1004;
		text = "by deadactionman"; //--- ToDo: Localize;
		x = 34 * GUI_GRID_W + GUI_GRID_X;
		y = 27 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 0.5 * GUI_GRID_H;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class mustyToolsBG: mustyToolsBGbase
	{
		idc = 2200;
		x = -3 * GUI_GRID_W + GUI_GRID_X;
		y = -1.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 46 * GUI_GRID_W;
		h = 29.5 * GUI_GRID_H;
	};
};

