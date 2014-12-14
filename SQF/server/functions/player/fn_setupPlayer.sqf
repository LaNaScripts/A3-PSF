private ["_player","_characterID","_playerID","_playerArray","_defaultConfig","_doLoop","_key","_primary","_newPlayer","_charID","_isNew","_result","_inventoryArray","_primaryArray","_secondaryArray","_handgunArray","_itemBackpackArray","_itemVestArray","_itemUniformArray","_pDirection","_medicalArray","_statsArray","_stateArray","_worldspace","_sanity","_i","_weaponArrays","_survival","_model","_hiveVer","_playerUniform","_playerVest","_playerBackpack","_worldPos"];
//[_player,_playerID,_charID,_playerArray,_dummyGroup,_playerSide] 
_player = _this select 0;
_playerID = _this select 1;
_characterID = _this select 2;
_playerArray = _this select 3;
_playerSide = side _player;
_orginalView = cameraView;
if (_orginalView == "GUNNER") then {_orginalView = "INTERNAL";};

_dummyGroup = createGroup _playerSide;

_defaultConfig = (configFile >> "CfgSurvival" >> "defaultSettings");

//Need to correct this with a real model
removeUniform _player;

if (isNull _player) exitWith {
	diag_log ("SETUP INIT FAILED: Exiting, player object null: " + str(_player));
};

//Do Connection Attempt
//"SELECT `%s`, `Medical`, `Generation`, `KillsZ`, `HeadshotsZ`, `KillsH`, `KillsB`, `CurrentState`, `Humanity` " "FROM `Character_DATA` WHERE `CharacterID`=%d
_doLoop = 0;
while {_doLoop < 5} do {
	_key = format["CHILD:102:%1:",_characterID];
	_primary = _key call sA3PSF_fnc_hiveReadWrite;
	if (count _primary > 0) then {
		if ((_primary select 0) != "ERROR") then {
			_doLoop = 9;
		};
	};
	_doLoop = _doLoop + 1;
};

if ((_primary select 0) == "ERROR") exitWith {
	["LOGIN RESULT: Exiting, failed to load _primary: %1 for player: %2 ",_primary,_playerID] call BIS_fnc_logFormat;
};

//Process request
_newPlayer = 	_playerArray select 1;
_charID = 		_playerArray select 2;
_isNew = 		count _playerArray < 6; //_result select 1;

_inventoryArray = ["","",""];

//[weapon,attachments,Loadedmagaizine];
_primaryArray = ""; //Primary Weapons
_secondaryArray = ""; //secondary Weapons
_handgunArray = ""; //handgun Weapons

_itemBackpackArray = ["",[]];
_itemVestArray = ["",[]];
_itemUniformArray = ["",[]];


_pDirection = 0;

_medicalArray = _primary select 1;
_statsArray = _primary select 2;
_stateArray = _primary select 3;
_worldspace = _primary select 4;
_sanity = _primary select 5;

_i = 0;
{
	diag_log format["%1:%2",_i,_x];
	_i = _i + 1;
} foreach _playerArray;

if (_isNew) then {
	_config = (configFile >> "CfgSurvival" >> "Inventory" >> "Default");

	_inventoryArray = [getText (_config >> "goggles"),getText (_config >> "helmet"),getArray (_config >> "assignedItems")];

	//[weapon,attachments,Loadedmagaizine];
	_primaryArray = getArray (_config >> "primaryArray"); //Primary Weapons
	_secondaryArray = getArray (_config >> "secondaryArray"); //secondary Weapons
	_handgunArray = getArray (_config >> "handgunArray"); //handgun Weapons

	_itemBackpackArray = getArray (_config >> "backpack");
	_itemVestArray = getArray (_config >> "vest");
	_itemUniformArray = getArray (_config >> "uniform");

} else {
	["Full Array: 101 : %1 / %2",_playerArray,count _playerArray] call BIS_fnc_logFormat;

//diag_log format["Full Array: 101 : %1 / %2",_playerArray,count _playerArray];

	//0 pass
	//1 new char
	//2 charid
	//3 worldspace
	//RETURNING CHARACTER
	//_weaponArrays = _playerArray select 4;
	_inventoryArray = _playerArray select 4;

	_primaryArray = _playerArray select 5;
	_secondaryArray = _playerArray select 6;
	_handgunArray = _playerArray select 7;
	
	_itemBackpackArray = 	_playerArray select 8;
	_itemVestArray = 	_playerArray select 9;
	_itemUniformArray = 	_playerArray select 10;

	//0 mins alive, 0 mins since last ate, 0 mins since last drank
	_survival =		_playerArray select 11;
	_model =		_playerArray select 12;
	_hiveVer =		_playerArray select 13;
};

if (isPlayer _player) then {

	// Set some vars
	_player setVariable ["characterID",_characterID];

	if (count _medicalArray > 0) then {
		_player setVariable ["health",_medicalArray select 0];
		_player setVariable ["hunger",_medicalArray select 1];
		_player setVariable ["thirst",_medicalArray select 2];
		_player setFatigue (_medicalArray select 3);
		_player setVariable ["bleeding",(_medicalArray select 4)];
		_medicalArray = [_medicalArray select 0,_medicalArray select 1,_medicalArray select 2,_medicalArray select 3,_medicalArray select 4];
	} else {
		_medicalArray = [(getNumber (_defaultConfig >> "HEALTH")),(getNumber (_defaultConfig >> "HUNGER")),(getNumber (_defaultConfig >> "THIRST")),0,[false,0,0]];
		_player setVariable ["health", (getNumber (_defaultConfig >> "HEALTH"))];
		_player setVariable ["hunger", (getNumber (_defaultConfig >> "HUNGER"))];
		_player setVariable ["thirst", (getNumber (_defaultConfig >> "THIRST"))];
		_player setVariable ["bleeding",[false,0,0]];
	};

	if (count _stateArray > 0) then {
		_player setVariable ["bodyTemp",(_stateArray select 2),true];
	} else {
		_player setVariable ["bodyTemp", (getNumber (_defaultConfig >> "BODYTEMP")), true];
		
		_stateArray = ["","",(getNumber (_defaultConfig >> "BODYTEMP"))];
	};

	//send everything to player
	serverRtn = [];
	if (typename _primary != "BOOL") then{
		serverRtn = [_pDirection,_inventoryArray,_primaryArray,_secondaryArray,_handgunArray,_itemBackpackArray,_itemVestArray,_itemUniformArray,_stateArray,_medicalArray];
	};

	["ServerRtn: %1",serverRtn] call BIS_fnc_logFormat;
	diag_log format["ServerRtn: %1",serverRtn];

	(owner _player) publicVariableClient "serverRtn";

	//Setup player pos
	if (count _worldspace > 0) then {
		_player setPosATL (_worldspace select 1);
		_pDirection = (_worldspace select 0);
		_worldPos = (_worldspace select 1);
	} else {
		_pos = _player call sA3PSF_fnc_randomSpawn;
		_pDirection = (_pos select 0);
		_worldPos = (_pos select 1);
	};
	
	[_player] joinSilent grpNull;
	
	_key = format["CHILD:103:%1:%2:%3:",_playerID,_charID,1];
	_key call sA3PSF_fnc_hiveWrite;


} else { if (true) exitwith { }; };