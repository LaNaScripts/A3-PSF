private ["_playerObj","_charID","_config","_mags","_wpns","_bcpk","_key"];

_playerObj = _this select 0;
_charID = _this select 1;

//Record initial inventory
_config = (configFile >> "CfgSurvival" >> "Inventory" >> "Default");
//bakcpack
_bcpk = getArray (_config >> "backpack");
//Vest
_vest = getArray (_config >> "vest");
//Uniform
_uniform = getArray (_config >> "uniform");

//"UPDATE `Character_DATA` SET `Inventory` = ? , `Backpack` = ? , `Vest` = ? , `Uniform` = ? WHERE `CharacterID` = ?"
//Wait for HIVE to be free
_key = format["CHILD:203:%1:%2:%3:",_charID,[],_bcpk,_vest,_uniform];
_key call sA3PSF_fnc_hiveWrite;