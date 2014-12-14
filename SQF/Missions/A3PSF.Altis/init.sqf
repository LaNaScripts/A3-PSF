player allowDamage false;
player hideObjectGlobal true;
startLoadingScreen ["Initialising..."];
0 cutText ["","BLACK"];

SV_instance = 1337; // The instance, move to server Vars


if(isServer) then {
	//is a dedicated server
	call compileFinal preprocessFileLineNumbers "\A3PSF\server\init\compile.sqf";
	call compileFinal preprocessFileLineNumbers "\A3PSF\server\init\variables.sqf";
	call compileFinal preprocessFileLineNumbers "\A3PSF\server\init\serverEH.sqf";
};

if (!isServer) then {
	waitUntil {!isNull player && isPlayer player};
	
	call compileFinal preprocessFileLineNumbers "\A3PSF\code\init\compile.sqf";
	call compileFinal preprocessFileLineNumbers "\A3PSF\code\init\variables.sqf";
	call compileFinal preprocessFileLineNumbers "\A3PSF\code\init\clientEH.sqf";
};