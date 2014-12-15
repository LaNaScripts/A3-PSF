private ["_playerObj","_charID","_config","_mags","_wpns","_bcpk","_key"];

_playerObj = _this select 0;
_charID = _this select 1;

//Record initial inventory
_config = (configFile >> "CfgSurvival" >> "Inventory" >> "Default");

//[weapon,attachments,Loadedmagaizine];

_bcpk = getArray (_config >> "backpack");
_vest = getArray (_config >> "vest");
_uniform = getArray (_config >> "uniform");

//"UPDATE `Character_DATA` SET `Inventory` = ? , `Backpack` = ? , `Vest` = ? , `Uniform` = ? WHERE `CharacterID` = ?"
//Wait for HIVE to be free
//20:54:45 HiveExt(0): [Error] Error executing |CHILD:203:3:[]:[["",[],[]],["",[],[]],["U_C_Poloshirt_stripped",[],[]]]:|
//_key = format["CHILD:203:%1:%2:%3:",_charID,[],[_bcpk,_vest,_uniform]];
_key = format["CHILD:203:%1:%2:%3:%4:%5:%6:%7:%8:",_charID,[],[],[],[],[],[],[]];
_key call sA3PSF_fnc_hiveWrite;