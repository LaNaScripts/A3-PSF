private["_worldspace","_player", "_positions", "_pos", "_posX", "_posY", "_posXRandom", "_posYRandom", "_rposX", "_rposY"];

_player = _this;

_worldspace = [];
for [{_j=0},{_j<=100},{_j=_j+1}] do {
	_mkr = getMarkerPos ("respawn_" + str(floor(random 16)));
	diag_log ("GetMarker: "+str(_mkr));
	
	_position = ([_mkr,0,1400,10,0,2,0] call BIS_fnc_findSafePos);
	diag_log ("FindsaveSpot: "+str(_position));
	_position set [2, 0];
	diag_log ("FindsaveSpot + 2: "+str(_position));
	if ((count _position >= 2) AND {(_position distance _mkr < 1400)}) exitwith {
		_worldspace = [0,_position];
	};
};

diag_log ("Worldspace: "+str(_worldspace));
_player setPosATL (_worldspace select 1);
_worldspace