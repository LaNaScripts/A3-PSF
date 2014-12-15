WaitUntil {!isNull Player};
WaitUntil {alive Player};
WaitUntil {player == player};

player allowDamage false;
player hideObjectGlobal true;
startLoadingScreen ["Initialising..."];
0 cutText ["","BLACK"];

call compileFinal preprocessFileLineNumbers "\A3PSF\code\init\compile.sqf";
call compileFinal preprocessFileLineNumbers "\A3PSF\code\init\variables.sqf";
call compileFinal preprocessFileLineNumbers "\A3PSF\code\init\clientEH.sqf";

[] spawn {
	_hud = { call compileFinal preprocessFile "\A3PSF\code\ui\hud.sqf"; };
	
	//[_hud, 1, []] call gA3PSF_fnc_addPerFrameHandler; //Removed till later
	["perFrameHandler", "onEachFrame", gA3PSF_fnc_onPerFrameHandler] call BIS_fnc_addStackedEventHandler;
};
