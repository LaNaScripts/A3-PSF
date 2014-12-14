WaitUntil {!IsNull Player};
WaitUntil {Alive Player};
WaitUntil {player == player};

[] spawn {

	["perFrameHandler", "onEachFrame", gA3PSF_perFrameHandlerArray] call BIS_fnc_addStackedEventHandler;
};
