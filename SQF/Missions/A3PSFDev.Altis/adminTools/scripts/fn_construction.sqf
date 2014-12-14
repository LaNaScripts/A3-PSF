_build = _this select 0;

_config = configFile >> "CfgConstruction" >> _build;
_required = getArray (_config >> "required");
_tool = getText (_config >> "tool");

diag_log format["%1, %2, %3, %4",_build,_config,_required,_tool];

{
	_item = _x select 0;
	_amount = _x select 2;
	
	player addMagazines [_item,_amount];
} forEach _required;

if (_tool != "") then {
	_hasTool = (_tool in magazines player);
	if (!_hasTool) then {	
		player addMagazine _tool;
	};
};

systemChat format["Sent item's to create %1 to you inventory",_build];