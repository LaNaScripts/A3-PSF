private ["_player","_building"];
{
	_player = _x;
	if (isPlayer _player && {alive _player}) then {
		{
			_building = _x;
			if(vehicle _player == _player) then {
			//if building gets damaged may return [] due to models not contatining all locations.
				_array1 = [_building] call BIS_fnc_buildingPositions;
				
				diag_log format["1:%1, 2:%2",_array1,(count _array1)];
				
				_building setVariable ["spawnedLoot",1];
			};
		} forEach nearestObjects [_player, ["house"], 50];
	};
} forEach playableUnits;
