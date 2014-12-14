// Control types
#define CT_STATIC           0
#define CT_MAP_MAIN         101

// Static styles
#define ST_CENTER         0x02
#define ST_PICTURE        0x30

class RscTitles 
{
      class RscText
      {
        access = 0;
        type = CT_STATIC;
        style = ST_CENTER;
        idc = -1;
        colorBackground[] = {0,0,0,0};
        colorText[] = {1,1,1,0.8};
        text = "";
        fixedWidth = 0;
        x = 0;
        y = 0;
        h = 0;
        w = 0;
        shadow = 2;
        font = "puristaMedium";
        sizeEx = "0.035";  
    
      };

    class UI_Monitor
    {
        idd = -1; 
        duration = 1e+1000; 
        fadeIn = 0; 
        fadeOut = 0; 
        name = "UI_Monitor_display"; 
        onLoad = "uiNamespace setVariable ['UI_Monitor_display', _this select 0];"; 
        controlsBackground[] = {};
      	objects[] = {};
        
       
        class Controls 
        {
			////////////////////////////////////////////////////////
			// GUI EDITOR OUTPUT START (by R4Z0R49, v1.063, #Vusawa)
			////////////////////////////////////////////////////////

			/*
			$[1.063,["Hud",[["safezoneX","safezoneY","safezoneW","safezoneH"],"safezoneW / 40","safezoneH / 25","GUI_GRID"],0,0,0],[-1000,"",[1,"FPS",["0.9275 * safezoneW + safezoneX","0.964 * safezoneH + safezoneY","0.07 * safezoneW","0.032 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],[-1001,"",[1,"Direction",["0.9275 * safezoneW + safezoneX","0.924 * safezoneH + safezoneY","0.07 * safezoneW","0.032 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],[-1002,"",[1,"Health",["0.9275 * safezoneW + safezoneX","0.884 * safezoneH + safezoneY","0.07 * safezoneW","0.032 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],[-1003,"",[1,"Cash",["0.9275 * safezoneW + safezoneX","0.844 * safezoneH + safezoneY","0.07 * safezoneW","0.032 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]]
			*/
			class RscText_1000: RscText
			{
				idc = 5004;
				text = "FPS"; //--- ToDo: Localize;
				x = 0.9275 * safezoneW + safezoneX;
				y = 0.964 * safezoneH + safezoneY;
				w = 0.07 * safezoneW;
				h = 0.032 * safezoneH;
			};
			class RscText_1001: RscText
			{
				idc = 5003;
				text = "Direction"; //--- ToDo: Localize;
				x = 0.9275 * safezoneW + safezoneX;
				y = 0.924 * safezoneH + safezoneY;
				w = 0.07 * safezoneW;
				h = 0.032 * safezoneH;
			};
			class RscText_1002: RscText
			{
				idc = 5001;
				text = "Health"; //--- ToDo: Localize;
				x = 0.9275 * safezoneW + safezoneX;
				y = 0.884 * safezoneH + safezoneY;
				w = 0.07 * safezoneW;
				h = 0.032 * safezoneH;
			};
			class RscText_1003: RscText
			{
				idc = 5005;
				text = "Cash"; //--- ToDo: Localize;
				x = 0.9275 * safezoneW + safezoneX;
				y = 0.844 * safezoneH + safezoneY;
				w = 0.07 * safezoneW;
				h = 0.032 * safezoneH;
			};
			////////////////////////////////////////////////////////
			// GUI EDITOR OUTPUT END
			////////////////////////////////////////////////////////
		}; 
	};
};