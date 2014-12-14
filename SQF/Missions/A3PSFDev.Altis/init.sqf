player allowDamage false;
player hideObjectGlobal true;
startLoadingScreen ["Initialising..."];
0 cutText ["","BLACK"];

SV_instance = 1337; // The instance, move to server Vars


//Both
call compileFinal preprocessFileLineNumbers "both\init\compile.sqf";
call compileFinal preprocessFileLineNumbers "both\init\variables.sqf";
call compileFinal preprocessFileLineNumbers "both\init\globalEH.sqf";

if(isServer) then {
	//is a dedicated server
	call compileFinal preprocessFileLineNumbers "server\init\compile.sqf";
	call compileFinal preprocessFileLineNumbers "server\init\variables.sqf";
	call compileFinal preprocessFileLineNumbers "server\init\serverEH.sqf";
};

if (!isServer) then {
	call compileFinal preprocessFileLineNumbers "client\init\compile.sqf";
	call compileFinal preprocessFileLineNumbers "client\init\variables.sqf";
	call compileFinal preprocessFileLineNumbers "client\init\clientEH.sqf";
};


if (!isDedicated) then {
	waitUntil {!isNull player && isPlayer player};
	call compileFinal preprocessFileLineNumbers "adminTools\init.sqf";
};