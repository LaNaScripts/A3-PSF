WaitUntil {!IsNull Player};
WaitUntil {Alive Player};
WaitUntil {player == player};

[] call compile preprocessFile "\A3PSF\code\ui\hud.sqf";

[] spawn {

	["perFrameHandler", "onEachFrame", gA3PSF_perFrameHandlerArray] call BIS_fnc_addStackedEventHandler;
};
