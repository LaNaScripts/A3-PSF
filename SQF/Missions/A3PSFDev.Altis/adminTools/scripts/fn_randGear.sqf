private ["_cfgWeapons","_cfgVehicles","_cfgMagazines","_cfgAmmo","_underwear","_hatsArray","_uniformsArray","_vestsArray","_backpacksArray","_weaponsPrimaryArray","_weaponsSecondaryArray","_weaponsLaunchersArray","_i","_item","_type","_scope","_displayName","_uniform","_hat","_vest","_backpack","_primary","_primaryClip","_secondary","_secondaryclip"];

_cfgWeapons = configfile >> "CfgWeapons";
_cfgVehicles = configfile >> "CfgVehicles";
_cfgMagazines = configfile >> "CfgMagazines";
_cfgAmmo = configfile >> "CfgAmmo";

_underwear = ["Underwear","Underwear 1","Underwear 2","Underwear 3","Underwear 4","Underwear 5"];

removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;

_hatsArray = [];
_uniformsArray = [];
_vestsArray = [];
_backpacksArray = [];
_weaponsPrimaryArray = [];
_weaponsSecondaryArray = [];
_weaponsLaunchersArray = [];

for "_i" from 1 to ((count _cfgWeapons) - 1) do
{
	_item = _cfgWeapons select _i;
	_type = getNumber(_item >> "iteminfo" >> "type");
	_scope = getNumber (_item >> "scope");
	
	if (!(_scope == 0)) then
	{
		_name = configName _item;
		
		if (_type == 605) then
		{
			_hatsArray set [(count _hatsArray),_name];
		};
		
		if (_type == 801) then
		{
			_displayName = getText (_item >> "displayName");
			if (!(_displayName in _underwear)) then
			{
				_uniformsArray set [(count _uniformsArray),_name];
			};
		};
		
		if (_type == 701) then
		{
			_vestsArray set [(count _vestsArray),_name];
		};
	};
};

for "_i" from 1 to ((count _cfgVehicles) - 1) do
{
	_item = _cfgVehicles select _i;
	_name = configName _item;
	
	if (_name iskindof "Bag_Base") then
	{
		_scope = getNumber (_item >> "scope");
		
		if (!(_scope == 0)) then
		{
			_backpacksArray set [(count _backpacksArray),_name];
		};	
	};	
};

for "_i" from 1 to ((count _cfgWeapons) - 1) do
{
	_item = _cfgWeapons select _i;
	_type = getNumber(_item  >> "type");
	_scope = getNumber (_item >> "scope");

	if (!(_scope == 0)) then
	{
		_name = configName _item;
		if (_type == 1) then
		{
			_weaponsPrimaryArray set [(count _weaponsPrimaryArray),_name];
		};

		if (_type == 2) then
		{
			_weaponsSecondaryArray set [(count _weaponsSecondaryArray),_name];
		};
/*
		if (_type == 4) then
		{
			_weaponsLaunchersArray set [(count _weaponsLaunchersArray),_name];
		};
*/
	};	
};

//gear selection;
_uniform = _uniformsArray select (round (random ((count _uniformsArray) - 1)));
//add hat
_hat = _hatsArray select (round (random ((count _hatsArray) - 1)));
//add vest
_vest = _vestsArray select (round (random ((count _vestsArray) - 1)));
//add backpack
_backpack = _backpacksArray select (round (random ((count _backpacksArray) - 1)));
//add primary
_primary = _weaponsPrimaryArray select (round (random ((count _weaponsPrimaryArray) - 1)));
_primaryClip = (getArray (_cfgWeapons >>_primary >> "magazines")) select 0;
//add secondary
_secondary = _weaponsSecondaryArray select (round (random ((count _weaponsSecondaryArray) - 1)));
_secondaryclip = (getArray (_cfgWeapons >>_secondary >> "magazines")) select 0;


player addUniform _uniform;
player addVest _vest;
player addHeadGear _hat;
player addBackpack _backpack;
player addMagazine [_primaryClip,(round(random 3))];
player addWeapon _primary;
player addMagazine [_secondaryclip,(round(random 3))];
player addWeapon _secondary;