class CfgPatches {
	class server {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {};
	};
};

class CfgFunctions 
{
	class sA3PSF
	{
		class player{
			file = "\A3PSF\server\functions\player";
			
			class addPlayer {};
			class disconnect {};
			class getPlayer {};
			class setupPlayer {};
			class playerTerminate {};
			class randomSpawn {};
			class updatePlayer {};
		};
		class static
		{
			file = "\A3PSF\server\functions\static";
			class hiveReadWrite { Description = ""; };
			class hiveWrite { Description = ""; };
			class selectRandomLocation { Description = ""; };
			class setdate { Description = ""; };
			class fps { Description = ""; };
		};
	};
};