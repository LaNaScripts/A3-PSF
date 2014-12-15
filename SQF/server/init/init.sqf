call compileFinal preprocessFileLineNumbers "\A3PSF\server\init\compile.sqf";
call compileFinal preprocessFileLineNumbers "\A3PSF\server\init\variables.sqf";
call compileFinal preprocessFileLineNumbers "\A3PSF\server\init\serverEH.sqf";

[] spawn {
	_fps = { diag_log format["DEBUG FPS: %1",str(diag_fps)]; }; //Compiled code no return.
	_timeNDate = { private ["_date"]; _date = call sA3PSF_fnc_setdate; CV_SetDate = _date; publicVariable "CV_SetDate"; }; //FNC return value _date
	_loot = { [] spawn serverVar_LootSpawner; }; //Compiled code no return
	
	[_loot, 5, []] call gA3PSF_fnc_addPerFrameHandler;
	[_fps, 300, []] call gA3PSF_fnc_addPerFrameHandler;
	[_timeNDate, 300, []] call gA3PSF_fnc_addPerFrameHandler;

	["perFrameHandler", "onEachFrame", gA3PSF_fnc_onPerFrameHandler] call BIS_fnc_addStackedEventHandler;
};
