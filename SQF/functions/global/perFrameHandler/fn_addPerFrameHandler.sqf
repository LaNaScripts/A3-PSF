private ["_function", "_delay", "_arguments", "_handle", "_data", "_test"];
_function =  [_this, 0, {}, [{}]] call BIS_fnc_param;
_delay =     [_this, 1,  0,  [0]] call BIS_fnc_param;
_arguments = [_this, 2, [], [[]]] call BIS_fnc_param;

_handle = count GVA3PSF_perFrameHandlerArray;
_data = [_function, _delay, 0, _handle, _arguments];
GVA3PSF_perFrameHandlerArray set [_handle, _data];
_handle
