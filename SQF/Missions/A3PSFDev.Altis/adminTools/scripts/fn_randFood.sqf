private ["_cfgMagazines","_consumeFoodArray","_consumeDrinkArra","_i","_item","_inherit","_configName","_scope","_consume"];
_cfgMagazines = configfile >> "CfgMagazines";

_consumeFoodArray = [];
_consumeDrinkArray = [];

for "_i" from 1 to ((count _cfgMagazines) - 1) do
{
	_item = _cfgMagazines select _i;
	_inherit = inheritsFrom _item;
	_configName = configName (_inherit);

	if (_configName == "2017_fooddrink") then {
		_name = configName _item;
		_scope = getNumber (_item >> "scope");
		_itemType = getText (_item >> "Nutrition" >> "consumeType");
		
		if (_scope == 2) then
		{
			switch (_itemType) do {
				case "drink": { _consumeDrinkArray pushback _name; };
				case "food": { _consumeFoodArray pushback _name; };
			};
		};	
	};	
};

a = 0;

while {a < (round(random 3))} do {

	_consumeDrink = _consumeDrinkArray call BIS_fnc_selectRandom;
	_consumeFood = _consumeFoodArray call BIS_fnc_selectRandom;

	player addMagazines [_consumeDrink,1];
	player addMagazines [_consumeFood,1];
	
	a = a + 1;
};
