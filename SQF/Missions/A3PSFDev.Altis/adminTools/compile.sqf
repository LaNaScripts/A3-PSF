mustyMM =
{
	if !("ItemMap" in items player) then {player addweapon "ItemMap";};
	mustyPlayers = [];
	mustyCrew = [];

	if (isnil "mustyMapMarkersFlag") then {mustyMapMarkersFlag = 0;}; 
	if (mustyMapMarkersFlag == 0) then {mustyMapMarkersFlag = 1;player setVariable["mustyMM", true, true]; hint "Player Markers ON";} else {mustyMapMarkersFlag = 0; player setVariable["mustyMM", false, true];hint "Player Markers OFF";};

	while {mustyMapMarkersFlag == 1} do
	{
		{
			if ((vehicle _x isKindOf "LandVehicle") || (vehicle _x isKindOf "Air") || (vehicle _x isKindOf "Ship")) then 
			{
				if (count (crew vehicle _x) > 0) then 
				{
					{
						if (!(_x in mustyPlayers) and (alive _x) and (getPlayerUID _x != "")) then 
						{
							private ["_pos", "_mkr", "_vhc"];
							_vhc = vehicle _x;
							_pos = visiblePosition _x;
							_mkr = createMarkerLocal [format ["CRW%1%2", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]]; 
							_vehname = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle _x) >> 'displayName'));
							_mkr setMarkerTextLocal format[' %1 --- %2 --- %3m',name _x,_vehname,round(_x distance player)];
							_mkr setMarkerTypeLocal "mil_dot"; 
							if ((side _x == side player) and (side _x != resistance)) then {_mkr setMarkerColorLocal "ColorBlue";}else{_mkr setMarkerColorLocal "ColorRed";};
							_mkr setMarkerSizeLocal [1,1];

							mustyPlayers set [count mustyPlayers, _x];
							[_x, _mkr,_vhc] spawn 
							{
								private ["_u", "_m","_pc"]; 
								_u = _this select 0; 
								_m = _this select 1; 
								while {(mustyMapMarkersFlag == 1) and (alive _u) and (vehicle _u != _u) and (getPlayerUID _u != "")} do 
								{
									_pc = ((crew vehicle _u) find _u); 
									_m setMarkerPosLocal ([(visiblePosition _u select 0) + 20, (visiblePosition _u select 1) - (25 + _pc*20), 0]); 
									sleep 0.01; 
								}; 
								deleteMarkerLocal _m;	
								if (_u in mustyPlayers) then 
								{ 
									mustyPlayers set [(mustyPlayers find _u), -1]; 
									mustyPlayers = mustyPlayers - [-1]; 			
								}; 					
								true;
							};
						};
					} forEach crew vehicle _x;
				}; 
			}
			else	
			{
				if (!(_x in mustyCrew) and (vehicle _x == _x) and (getPlayerUID _x != "")) then 			 
				{
					private ["_pos", "_mkr"]; 
					_pos = visiblePosition _x;
				
					_mkr = createMarkerLocal [format ["PLR%1%2", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]]; 
					_mkr setMarkerTypeLocal "mil_dot";  
					_mkr setMarkerSizeLocal [1,1];
					if ((side _x == side player) and (side _x != resistance)) then {_mkr setMarkerColorLocal "ColorWhite";}else{_mkr setMarkerColorLocal "ColorRed";};
					_mkr setMarkerTextLocal format ["%1 --- %2", name _x,round(_x distance player)];
					if (_x == player) then 
					{	
						_mkr setMarkerColorLocal "ColorGreen";
					};
					mustyCrew set [count mustyCrew, _x];
					[_x, _mkr] spawn 
					{ 
						private ["_u", "_m"]; 
						_u = _this select 0; 
						_m = _this select 1; 
						while {(mustyMapMarkersFlag == 1) and (alive _u) and (vehicle _u == _u) and (getPlayerUID _u != "") } do 
						{
							_m setMarkerPosLocal ([visiblePosition _u select 0, visiblePosition _u select 1, 0]); 
							sleep 0.01; 
						}; 
						deleteMarkerLocal _m;	
						if (_u in mustyCrew) then 
						{ 
							mustyCrew set [(mustyCrew find _u), -1]; 
							mustyCrew = mustyCrew - [-1];
						}; 					
						true;
					}; 
				};
			};
		} forEach playableUnits;
	sleep 0.3;
	};
	{_mkr = str _x; deleteMarkerLocal _mkr;} forEach playableUnits;
};

mustyPlayerRefresh = {
	_displayIDD = 11391;
	if (isNull (findDisplay _displayIDD)) exitWith {};				
	_playerList = 1500;
	sleep 0.3;
	mustyPlayerArray = playableUnits;
	lbClear _playerList;
	{
		_displayName = name _x;
		if (_x getVariable["mustyTP",false]) then {_displayName = format["%1[T]",_displayName];};
		if (_x getVariable["mustyMM",false]) then {_displayName = format["%1[MM]",_displayName];};
		if (captive _x) then {_displayName = format["%1[I]",_displayName];};
	
		_index = lbAdd[_playerList, _displayName];
		if (_x getVariable["mustyAdmin",false]) then {lbSetColor [_playerList, _index, [1, 0, 0, 0.8]];};
		lbSetData[_playerList, _index, (netID _x)];
		_pic = "none";
		if (vehicle player != player) then {
			_pic = getText(configFile >> "CfgVehicles" >> typeOf (vehicle _x) >> "picture");
		}
		else
		{
			_pic = "adminTools\stache.paa";
		};
		if (_pic != "none") then {lbSetPicture [_playerList, _index, _pic];};
	} forEach mustyPlayerArray;
	lbSetCurSel [_playerList, 0];
};

mustyPlayerUpdate = {
	_playerList = 1500;
	_index = lnbCurSelRow _playerList;
	_unit = objectFromNetId (lnbData [_playerList,[_index,0]]);
	_displayName = name _unit;
	sleep 1;
	if (_unit getVariable["mustyTP",false]) then {_displayName = format["%1[T]",_displayName];};
	if (_unit getVariable["mustyMM",false]) then {_displayName = format["%1[MM]",_displayName];};
	if (captive _unit) then {_displayName = format["%1[I]",_displayName];};	
	lnbSetText [_playerList, [_index,0], _displayName];
};

AdminToolsDialog = {
	_displayIDD = 11391;
	if (!isNull (findDisplay _displayIDD)) exitWith {_null = [] spawn mustyPlayerRefresh;};
	createDialog "mustyTools";
	
	disableSerialization;
	waitUntil{!isNull (findDisplay _displayIDD)};	
	
	_actionList = 1501;
	_vehicleList = 1502;
	_infoBox = 1100;
	_versionBox = 1004;
	_playerList = 1500;
	_actionArray = [
		"Map Markers", //0
		"Teleport", //1
		"Add Primary Magazine", //2
		"Random Gear", //3
		"Random Medical", //4
		"Random Food", //5
		"Random Tools", //6
		"Give Shantyhut Items", //7
		"Give SmallfirePlace Items", //8
		"Give Surival Shelter Items", //9
		"Give WorkBench Items", //10
		"Debug Monitor", //11
		"Quest Grabber" //12
	];
	
	_spawnArray = [];
	_cfgVehicles = configFile >> "cfgVehicles";
	for "_i" from 0 to (count _cfgVehicles)-1 do
	{
		_vehicle = _cfgVehicles select _i;
		if (isClass _vehicle) then
		{
			_vehType = configName _vehicle;
			if ((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (((_vehType isKindOf "LandVehicle") or (_vehType isKindOf "Air") or (_vehType isKindOf "Ship"))) && !((_vehType isKindOf "ParachuteBase") or (_vehType isKindOf "BIS_Steerable_Parachute"))) then
			{
				_spawnArray set[count _spawnArray, _vehType];
			};
		};
	};

	
	{
		_side = "";
		_pic = getText(configFile >> "CfgVehicles" >> _x >> "picture");
		switch (getNumber (configFile >> "CfgVehicles" >> _x >> "side")) do 
		{
			case 0:
			{
				_side = "(OPFOR)";
			};
			case 1:
			{
				_side = "(BLUFOR)";
			};
			case 2:
			{
				_side = "(IND)";
			};
			default
			{
				_side = "(CIV)";
			};
		};
		_displayName = format["%1 %2",getText(configFile >> "CfgVehicles" >> _x >> "displayName"),_side];							
		_index = lbAdd[_vehicleList, _displayName];
		lbSetData[_vehicleList, _index, _x];
		lnbSetPicture [_vehicleList, [_index, 0], _pic];
	} forEach _spawnArray;
	_textBox = (findDisplay _displayIDD) displayCtrl _infoBox;
	_textBox ctrlSetStructuredText parseText "F1=Admin Menu/Refresh Player List, F2=Fix, f3=Refuel";
	
	ctrlSetText [_versionBox,"v0.5a - deadactionman"];
	
	_null = [] spawn mustyPlayerRefresh;
	
	{
		_index = lbAdd[_actionList, _x];
	} forEach _actionArray;
};

mustyToolsAction = {
	_args = _this select 0;
	_idc = ctrlIDC (_args select 0);
	_actionList = 1501;
	_spawnList = 1502;
	_playerList = 1500;
	_selectedPlayer = mustyPlayerArray select (lnbCurSelRow _playerList);
	if (_idc == _spawnList) then {
		_class = lbData [_spawnList, (lnbCurSelRow _spawnList)];
		[_class] execVM "adminTools\scripts\spawnvehicle.sqf";
	};
	if (_idc == _actionList) then {
		_actionIndex = lnbCurSelRow _actionList;
		switch (_actionIndex) do
		{
			case 0:
			{
				[] call mustyMM;
			};
			case 1:
			{
				[] execVM "adminTools\scripts\teleport.sqf";
			};
			case 2:
			{
				[] execVM "adminTools\scripts\fn_addMagazine.sqf";	
			};	
			//"Random Gear"
			case 3:
			{
				[] execVM "adminTools\scripts\fn_randGear.sqf";	
			};
			//"Random Medical"
			case 4:
			{
				[] execVM "adminTools\scripts\fn_randMedical.sqf";	
			};					
			//"Random Food"
			case 5:
			{
				[] execVM "adminTools\scripts\fn_randFood.sqf";	
			};	
			//"randtools"
			case 6:
			{
				[] execVM "adminTools\scripts\fn_randTools.sqf";	
			};		
			//"shantyhut"
			case 7:
			{
				["shantyhut"] execVM "adminTools\scripts\fn_construction.sqf";		
			};
			//"smallfirePlace"
			case 8:
			{
				["smallfirePlace"] execVM "adminTools\scripts\fn_construction.sqf";	
			};
			//"surivalshelter"
			case 9:
			{
				["surivalshelter"] execVM "adminTools\scripts\fn_construction.sqf";		
			};
			//"WorkBench"
			case 10:
			{
				["WorkBench"] execVM "adminTools\scripts\fn_construction.sqf";	
			};	
			//"Debug"
			case 11:
			{
				[] execVM "adminTools\scripts\fn_debugCheck.sqf";	
			};
			//"Quest Grabber"
			case 12:
			{
				[4000,true] execVM "adminTools\scripts\fn_questgraber.sqf";	
			};				
		};
	};
	playSound "FD_CP_Not_Clear_F";
	null = [] spawn mustyPlayerUpdate;
};

AdminKeyHandler = {
	_display = _this select 0;
	_keypressed = _this select 1;
	_shift = _this select 2;
	_ctrlKey = _this select 3;
	_alt = _this select 4;
	_return = false;

	switch (_keypressed) do
	{
		case 0x3B: //F1
		{
			playSound "FD_CP_Not_Clear_F";
			_null = [] call AdminToolsDialog;
			_return = true;
		};
		//f2
		case 0x3C:
		{
			if (isNull cursorTarget) exitwith { };
			playSound "FD_CP_Not_Clear_F";
			[] execVM "adminTools\scripts\fn_fillFuel.sqf";
			_return = true;
		};
		//f3
		case 0x3D:
		{
			if (isNull cursorTarget) exitwith { };
			playSound "FD_CP_Not_Clear_F";
			[] execVM "adminTools\scripts\fn_fixVehicle.sqf";
			_return = true;
		};				
	};
	_return
};
