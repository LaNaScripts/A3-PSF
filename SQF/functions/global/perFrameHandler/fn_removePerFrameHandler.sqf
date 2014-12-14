private ["_handle", "_entry"];
_handle = [_this, 0, -1, [0]] call BIS_fnc_param;
if (_handle == -1) exitWith { false };
GVA3PSF_perFrameHandlerArray set [_handle, -1];
true
