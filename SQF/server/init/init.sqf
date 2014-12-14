[] spawn {
	_fps = { diag_log format["DEBUG FPS: %1",str(diag_fps)]; };
	_timeNDate = { call sA3PSF_fnc_setdate; };

	[_weather, 1, []] call GVA3PSF_perFrameHandlerArray;
	[_fps, 300, []] call GVA3PSF_perFrameHandlerArray;
	[_timeNDate, 300, []] call GVA3PSF_perFrameHandlerArray;

	["perFrameHandler", "onEachFrame", GVA3PSF_perFrameHandlerArray] call BIS_fnc_addStackedEventHandler;
};

