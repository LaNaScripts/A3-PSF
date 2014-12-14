private ["_player","_playerObj","_playerID","_playerName","_doLoop","_key","_primary"];

_playerObj = _this select 0;
_playerID = _this select 1;
_playerName = _this select 2;

if (_playerID == "") then {
	_playerID = getPlayerUID _playerObj;
};

//Do Connection Attempt (Table player_data)
_doLoop = 0;
while {_doLoop < 5} do {
	_key = format["CHILD:101:%1:%2:%3:",_playerID,SV_instance,_playerName];
	_primary = _key call sA3PSF_fnc_hiveReadWrite;
	if (count _primary > 0) then {
		if ((_primary select 0) != "ERROR") then {
			_doLoop = 9;
		};
	};
	_doLoop = _doLoop + 1;
};

_primary