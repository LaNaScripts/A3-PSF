private ["_player","_uid","_name","_playerObj"];

_id = _this select 0; 
_name = _this select 1; 
_uid  = _this select 2;

diag_log format["Disconnect! ID: %1, UID: %2, NAME: %3",_id,_uid,_name];

_playerObj = nil;

{
	if ((getPlayerUID _x) == _uid) exitwith { _playerObj = _x; };
} forEach playableUnits;

if (isNil "_playerObj") exitWith {
	diag_log format["%1: nil player object, _this:%2", __FILE__, _this];
};

_playerObj call sA3PSF_fnc_updatePlayer;
//remove death EH
_playerObj removeAllMPEventHandlers "mpkilled"; 
//Remove body
deleteVehicle _playerObj;

