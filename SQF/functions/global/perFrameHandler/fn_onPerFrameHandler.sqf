private ["_handlerData", "_function", "_delay", "_delta"];
// TODO: Do a proper check
if (alive player || isServer) then {
	{
		_handlerData = _x;
		if (!isNil "_handlerData" && {typeName _handlerData == "ARRAY"}) then {
			_function = _handlerData select 0;
			_delay = _handlerData select 1;
			_delta = _handlerData select 2;

			if (diag_tickTime >= _delta) then {
				[_handlerData select 3, _handlerData select 4] call _function;
				_delta = diag_tickTime + _delay;
				_handlerData set [2, _delta];
			};
		};
	} forEach GVA3PSF_perFrameHandlerArray;
};
true
