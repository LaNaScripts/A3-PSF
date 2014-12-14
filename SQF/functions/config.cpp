class CfgPatches {
	class functions {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Functions_F"};
	};
};

class CfgFunctions
{
	init = "A3PSF\functions\initFunctions.sqf"; // override default initFunctions until BIS implements http://feedback.arma3.com/view.php?id=19895
	class cA3PSF
	{
		recompile = 1;
		class eh
		{
			file = "A3PSF\functions\client\eh";
			class respawnPlayer 
			{
				Description = "Respawns player.";
			};
		};
	};
	class gA3PSF
	{
		recompile = 1;
		class perFrameHandler
		{
			file = "A3PSF\functions\global\perFrameHandler";
			class addPerFrameHandler;
			class onPerFrameHandler;
			class removePerFrameHandler;
		};
	};
};
