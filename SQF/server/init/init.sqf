call compileFinal preprocessFileLineNumbers "\A3PSF\server\init\compile.sqf";
call compileFinal preprocessFileLineNumbers "\A3PSF\server\init\variables.sqf";
call compileFinal preprocessFileLineNumbers "\A3PSF\server\init\serverEH.sqf";

[] spawn {
	_fps = { call sA3PSF_fnc_fps; };
	_timeNDate = { call sA3PSF_fnc_setdate; };

	[_fps, 300, []] call gA3PSF_fnc_addPerFrameHandler;
	[_timeNDate, 300, []] call gA3PSF_fnc_addPerFrameHandler;

	["perFrameHandler", "onEachFrame", gA3PSF_fnc_addPerFrameHandler] call BIS_fnc_addStackedEventHandler;
};
