private ["_player","_killed","_charID","_key"];
_player = _this select 0;
//_killed = _this select 1;

//diag_log format ["%1 was killed by %2 at distance of %3 meters",name (_this select 0),name (_this select 1),(_this select 0) distance (_this select 1)]; 

_charID = _player getVariable["characterID",0];

_key = format["CHILD:202:%1:%2:",_charID,0];
//diag_log ("HIVE: WRITE: "+ str(_key));
_key call sA3PSF_fnc_hiveWrite;

_player setDamage 1;

//PVC2017_EndMission = [_player];
//(owner _player) publicVariableClient "PVC2017_EndMission";
