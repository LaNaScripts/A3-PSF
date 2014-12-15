WaitUntil {!isNull Player};
WaitUntil {Alive Player};
WaitUntil {player == player};

player allowDamage false;
player hideObjectGlobal true;
startLoadingScreen ["Initialising..."];
0 cutText ["","BLACK"];

call compileFinal preprocessFileLineNumbers "\A3PSF\code\init\compile.sqf";
call compileFinal preprocessFileLineNumbers "\A3PSF\code\init\variables.sqf";
call compileFinal preprocessFileLineNumbers "\A3PSF\code\init\clientEH.sqf";
call compileFinal preprocessFile "\A3PSF\code\ui\hud.sqf";

[] spawn {

	["perFrameHandler", "onEachFrame", gA3PSF_fnc_addPerFrameHandler] call BIS_fnc_addStackedEventHandler;
};
