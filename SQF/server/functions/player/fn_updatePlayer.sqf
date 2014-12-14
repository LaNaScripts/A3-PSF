private ["_player","_uWeps","_uItms","_vWeps","_vItms","_bWeps","_bItms","_pMag","_sMag","_hMag","_pItems","_sItems","_hItems","_1Mags","_2Mags","_4Mags","_vMags","_uMags","_bMags","_class","_count","_state","_type","_loc","_pid","_playerWorldSpace","_health","_sanity","_hunger","_thirst","_temp","_charID","_medical","_kills","_headShots","_distanceFoot","_timeSince","_currentModel","_currentState","_killsH","_killsB","_uniform","_vest","_backpack","_goggles","_helmet","_assItems","_primaryWeapon","_secondaryWeapon","_handgunWeapon","_playerUniform","_playerVest","_playerBackpack","_inventoryGear","_primaryWepLoad","_secondaryWepLoad","_handgunWepLoad","_playerBackp","_key"];
_player = _this;

diag_log format["player %1 running sync",_player]; //("Player "+str(_player));

// Arrays
_uWeps = [];
_uItms = [];

_vWeps = [];
_vItms = [];

_bWeps = [];
_bItms = [];

_pMag = "";
_sMag = "";
_hMag = "";
_pItems = [];
_sItems = [];
_hItems = [];

_1Mags = [];
_2Mags = []; 
_4Mags = []; 
_vMags = [];
_uMags = [];
_bMags = [];

_charPos = 	getPosATL _player;
_debug = getMarkerpos "respawn_Debug";
_distance = _debug distance _charPos;
if (_distance < 250) exitWith { 
	diag_log format["ERROR: server_playerSync: Cannot Sync Player %1. Position in respawn! %3",name _player,_charPos];
};


{
	_class = _x select 0;
	_count = _x select 1;
	_state = _x select 2;
	_type = _x select 3; 
	_loc = _x select 4;
	
	_config = configFile >> "CfgMagizines" >> _class;
	_maxAmmo = getNumber(_config >> "count");
	
	if (_count < _maxAmmo) then { diag_log format["_class: %1, _count: %2, _maxAmmo: %3",_class,_count,_maxAmmo]; };

	if (_state) then {
		switch (_type) do {
			case 1: { _1Mags = [_class,_count];}; //_1Mags set [count _1Mags, [_class,_count]]
			case 2: {_2Mags = [_class,_count];}; //_2Mags set [count _2Mags, [_class,_count]];
			case 4: {_4Mags = [_class,_count];}; //_4Mags set [count _4Mags, [_class,_count]];};
        };
	} else {
		if (_count < _maxAmmo) then { 
			switch (_loc) do {
				case "Vest": {_vMags set [count _vMags, [_class,_count]];};
				case "Uniform": {_uMags set [count _uMags, [_class,_count]];};
				case "Backpack": {_bMags set [count _bMags, [_class,_count]];};
			};
		} else {
			switch (_loc) do {
				case "Vest": {_vMags set [count _vMags, _class];};
				case "Uniform": {_uMags set [count _uMags, _class];};
				case "Backpack": {_bMags set [count _bMags, _class];};
			};
		};

	};
} foreach (magazinesAmmoFull _player);
  
// Find All Uniform Items and Type
{
	if ((_x in (weapons _player)) or (_x in (items _player))) then {
		   _uMags set [count _uMags, _x];
	};
} forEach (uniformItems _player);
 

// Find All Vest Items and Type
{
	if ((_x in (weapons _player)) or (_x in (items _player))) then {
		_vMags set [count _vMags, _x];
	};
} forEach (vestItems _player);
 
// Find All Backpack Items and Type
{
	if ((_x in (weapons _player)) or (_x in (items _player))) then {
		_bMags set [count _bMags, _x];
	};
} forEach (backpackItems _player);
 
// Primary Attachments
if(count (primaryWeaponItems _player) > 0) then
{
    {
        _pItems = _pItems + [_x];
    } forEach (primaryWeaponItems _player);
};
 
// Secondary Attachments
if(count (secondaryWeaponItems _player) > 0) then
{
    {
        _sItems = _sItems + [_x];
    } forEach (secondaryWeaponItems _player);
};
 
// Handgun Attachments
if(count (handGunItems _player) > 0) then
{
    {
        _hItems = _hItems + [_x];
    } forEach (handGunItems _player);
};
 
// Player Vars
_pid = getPlayerUID _player;
_playerWorldSpace = [(getDir _player),(getPosATL _player)];
_health = ceil(_player getVariable "health");
_hunger = ceil(_player getVariable "hunger");
_thirst = ceil(_player getVariable "thirst");
_temp   = ceil(_player getVariable "bodyTemp");
_player_bleeding =  _player getVariable "bleeding";
_charID = _player getVariable["characterID",0];
 
// Vars for Sending
//_medical = [_health,_hunger,_thirst,_sanity];
_kills = 0;
_headShots = 0;
_distanceFoot = 0;
_timeSince = diag_ticktime;
_currentModel = (typeOf _player);
_currentState = [(currentMuzzle _player),(animationState _player),_temp];
_killsH = 0; // Not Needed
_killsB = 0; //Not needed
 
// Player Gear
_uniform = uniform _player;
_vest = vest _player;
_backpack = backpack _player;

//Needs new array
_goggles = goggles _player;
_helmet = headgear _player;
_assItems = assignedItems _player;
 
_primaryWeapon = primaryWeapon _player;
_secondaryWeapon = secondaryWeapon _player;
_handgunWeapon = handgunWeapon _player;

_playerUniform = [_uniform,_uMags];
_playerVest = [_vest,_vMags];
_playerBackpack = [_backpack,_bMags];

_inventoryGear = [_goggles,_helmet,_assItems]; //Needs spilting

_primaryWepLoad = [_primaryWeapon, _pItems, _1Mags];
_secondaryWepLoad = [_secondaryWeapon, _sItems, _4Mags];
_handgunWepLoad = [_handgunWeapon, _hItems, _2Mags];

//_playerBackp = [_playerUniform,_playerVest,_playerBackpack]; //Needs spilting
_medical = [_health,_hunger,_thirst,(getFatigue _player),_player_bleeding];
_kills = 0;
_headShots = 0;
_distanceFoot = 0;
_timeSince = diag_ticktime;
//_currentModel = [[_goggles],[_secondaryWeapon],_assItems]; //need to ad these
_currentModel = [_uniform];
_killsH = 0; // Not Needed
_killsB = 0; //Not needed

if (alive _player) then {
	//SQL - CharactorID,Worldspace, Inventory, Backpack, Vest, Uniform, Medical, JustAte, JustDrank, KillsZ, HeadshotsZ, DistanceFoot, Duration, CurrentState, KillsH, KillsB, Model, Humanity
	_key = format["CHILD:201:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:%17:%18:%19:%20:%21:",_charID,_playerWorldSpace,_inventoryGear,_primaryWepLoad,_secondaryWepLoad,_handgunWepLoad,_playerBackpack,_playerVest,_playerUniform,_medical,false,false,_kills,_headShots,_distanceFoot,_timeSince,_currentState,_killsH,_killsB,_currentModel,0];
	//diag_log ("HIVE: WRITE: "+ str(_key) );
	_key call sA3PSF_fnc_hiveWrite;
};