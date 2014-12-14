private ["_cfgMagazines","_consumeArray","_i","_item","_inherit","_configName","_scope","_consume"];
_cfgMagazines = configfile >> "CfgMagazines";

_consumeArray = [];

for "_i" from 1 to ((count _cfgMagazines) - 1) do
{
	_item = _cfgMagazines select _i;
	_inherit = inheritsFrom _item;
	_configName = configName (_inherit);

	if (_configName == "2017_tools") then {
		_name = configName _item;
		_scope = getNumber (_item >> "scope");
		if (_scope == 2) then
		{
			_consumeArray set [(count _consumeArray),_name];
		};	
	};	
};

a = 0;

while {a < (round(random 3))} do {

	_consume = _consumeArray call BIS_fnc_selectRandom;

	_hasTool = (_consume in magazines player);
	if (!_hasTool) then {	
		player addMagazine _consume;
	};
	a = a + 1;
};

diag_log (_consumeArray);