class CfgMods
{
	class A3PSF
	{
		dir = "A3PSF";
		name = "A3PSF";
		action = "https://github.com/R4Z0R49/A3-PSF";
		hidePicture = 0;
		hideName = 0;
		version = "0.2";
		picture = "A3PSF\code\images\logo.paa";
	};
};

class CfgPatches {
	class code {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = 	{
			"functions"
		};
	};
};

class CfgAISkill {
	aimingAccuracy[] = {0,0,0.5,0.5}; //0-1, 0.1-0.6
	aimingShake[] = {0, 0, 1, 1};
	aimingspeed[] = {0, 0, 1, 0.5};
	commanding[] = {0, 1, 1, 1};
	courage[] = {0, 1, 1, 1};
	endurance[] = {0, 1, 1, 1};
	general[] = {0, 1, 1, 1};
	reloadspeed[] = {0, 0.3, 1, 0.7};
	spotDistance[] = {0, 0.2, 1, 0.4};
	spotTime[] = {0, 0, 1, 0.7};
};

class CfgSurvival {
	//Default settings (replace define)
	class defaultSettings {
		hunger = 20000;
		thirst = 20000;
		health = 20000;
		bodytemp = 37;
	};
	//default inventory
	class Inventory {
		class Default {
			goggles = "";
			helmet = "";
			assignedItems[] = {"ItemMap"};
			backpack[] = {"",{},{}}; //["B_FieldPack_cbr_Repair",["ToolKit"]]
			vest[] = {"",{},{}}; // ["V_TacVest_khk",[""]]
			uniform[] = {"U_C_Poloshirt_stripped",{},{}}; //["U_C_Poloshirt_stripped",[""]]
			
			primaryArray[] = {"LMG_Mk200_F",{},{}}; //Primary Weapons ["LMG_Mk200_F",["","",""],
			secondaryArray[] = {"",{},{}}; //secondary Weapons
			handgunArray[] = {"",{},{}}; //handgun Weapons ["hgun_ACPC2_snds_F",["muzzle_snds_acp","",""],["9Rnd_45ACP_Mag",1]]
		};
	};
};

class CfgRespawnTemplates
{
	class respawn
	{
		onPlayerRespawn = "\A3PSF\functions\client\eh\fn_respawnPlayer.sqf";
		respawnDelay = 5;
	};
};

#include "\A3PSF\code\ui\defines.hpp"

class RscStandardDisplay;
class RscControlsGroup;
class RscText;
class RscPicture;
class RscPictureKeepAspect;
