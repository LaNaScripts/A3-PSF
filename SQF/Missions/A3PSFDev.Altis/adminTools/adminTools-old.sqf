mustyAdminUIDs = ["76561197965409790"];

mustyTP = {
	_pos = _this select 0;
	_shift = _this select 1;
	_alt = _this select 2;
	if (_shift && _alt) then {
		player setPosATL [_pos select 0, _pos select 1, (getPosATL player) select 2];
	};
};


mustyToolsServer = {
	_incoming = _this select 0;
	if (count _incoming != 6) exitWith {diag_log("MUSTY_TOOLS - Error: Invalid Command Parameters");};

	// PV_mustyToolsServer = [_command, _unit, _pos, _var, _scope, _player];
	// publicVariableServer "PV_mustyToolsServer";

	_command = _incoming select 0;	// what to do - STRING
	_unit = _incoming select 1;	// who to do it to/who executes the _outputScript - PLAYER OBJECT
	_pos = _incoming select 2;	// where to do it - POSITION
	_var = _incoming select 3;	// custom variable "type", number, [array] - ANY
	_global = _incoming select 4;	// execute for the player that called it or send to all - BOOLEAN
	_player = _incoming select 5;	// who changed the variable - PLAYER OBJECT
	_owner = -1;
	
	// exit here if the caller isn't an admin
	if (!((getPlayerUID _player) in mustyAdminUIDs)) exitWith {};
	_player setVariable["mustyAdmin", true,true];
	
	_outputScript = "";
	switch (_command) do
	{
		case "init":
		{
		// usage: PV_mustyToolsServer = ["init", null, [], 0, false, player];
		// F1=59, F2=60, F3=61, F4=62
			_outputScript = "								
				mustyMM =
				{
					if !(""ItemMap"" in items player) then {player addweapon ""ItemMap"";};
					mustyPlayers = [];
					mustyCrew = [];

					if (isnil ""mustyMapMarkersFlag"") then {mustyMapMarkersFlag = 0;}; 
					if (mustyMapMarkersFlag == 0) then {mustyMapMarkersFlag = 1;player setVariable[""mustyMM"", true, true]; hint ""Player Markers ON"";} else {mustyMapMarkersFlag = 0; player setVariable[""mustyMM"", false, true];hint ""Player Markers OFF"";};

					while {mustyMapMarkersFlag == 1} do
					{
						{
							if ((vehicle _x isKindOf ""LandVehicle"") || (vehicle _x isKindOf ""Air"") || (vehicle _x isKindOf ""Ship"")) then 
							{
								if (count (crew vehicle _x) > 0) then 
								{
									{
										if (!(_x in mustyPlayers) and (alive _x) and (getPlayerUID _x != """")) then 
										{
											private [""_pos"", ""_mkr"", ""_vhc""];
											_vhc = vehicle _x;
											_pos = visiblePosition _x;
											_mkr = createMarkerLocal [format [""CRW%1%2"", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]]; 
											_vehname = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle _x) >> 'displayName'));
											_mkr setMarkerTextLocal format[' %1 --- %2 --- %3m',name _x,_vehname,round(_x distance player)];
											_mkr setMarkerTypeLocal ""mil_dot""; 
											if ((side _x == side player) and (side _x != resistance)) then {_mkr setMarkerColorLocal ""ColorBlue"";}else{_mkr setMarkerColorLocal ""ColorRed"";};
											_mkr setMarkerSizeLocal [1,1];

											mustyPlayers set [count mustyPlayers, _x];
											[_x, _mkr,_vhc] spawn 
											{
												private [""_u"", ""_m"",""_pc""]; 
												_u = _this select 0; 
												_m = _this select 1; 
												while {(mustyMapMarkersFlag == 1) and (alive _u) and (vehicle _u != _u) and (getPlayerUID _u != """")} do 
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
								if (!(_x in mustyCrew) and (vehicle _x == _x) and (getPlayerUID _x != """")) then 			 
								{
									private [""_pos"", ""_mkr""]; 
									_pos = visiblePosition _x;
								
									_mkr = createMarkerLocal [format [""PLR%1%2"", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]]; 
									_mkr setMarkerTypeLocal ""mil_dot"";  
									_mkr setMarkerSizeLocal [1,1];
									if ((side _x == side player) and (side _x != resistance)) then {_mkr setMarkerColorLocal ""ColorWhite"";}else{_mkr setMarkerColorLocal ""ColorRed"";};
									_mkr setMarkerTextLocal format [""%1 --- %2"", name _x,round(_x distance player)];
									if (_x == player) then 
									{	
										_mkr setMarkerColorLocal ""ColorGreen"";
									};
									mustyCrew set [count mustyCrew, _x];
									[_x, _mkr] spawn 
									{ 
										private [""_u"", ""_m""]; 
										_u = _this select 0; 
										_m = _this select 1; 
										while {(mustyMapMarkersFlag == 1) and (alive _u) and (vehicle _u == _u) and (getPlayerUID _u != """") } do 
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
				
				mustyTP = {
					_pos = _this select 0;
					_shift = _this select 1;
					_alt = _this select 2;
					_target = player;
					if (_shift && _alt) then {
						if (vehicle player != player) then {_target = vehicle player;};
						_target setPosATL [_pos select 0, _pos select 1, (getPosATL _target) select 2];
					};
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
						if (_x getVariable[""mustyTP"",false]) then {_displayName = format[""%1[T]"",_displayName];};
						if (_x getVariable[""mustyMM"",false]) then {_displayName = format[""%1[MM]"",_displayName];};
						if (captive _x) then {_displayName = format[""%1[I]"",_displayName];};
					
						_index = lbAdd[_playerList, _displayName];
						if (_x getVariable[""mustyAdmin"",false]) then {lbSetColor [_playerList, _index, [1, 0, 0, 0.8]];};
						lbSetData[_playerList, _index, (netID _x)];
						_pic = ""none"";
						if (vehicle player != player) then {
							_pic = getText(configFile >> ""CfgVehicles"" >> typeOf (vehicle _x) >> ""picture"");
						}
						else
						{
							_pic = ""adminTools\stache.paa"";
						};
						if (_pic != ""none"") then {lbSetPicture [_playerList, _index, _pic];};
					} forEach mustyPlayerArray;
					lbSetCurSel [_playerList, 0];
				};
				
				mustyPlayerUpdate = {
					_playerList = 1500;
					_index = lnbCurSelRow _playerList;
					_unit = objectFromNetId (lnbData [_playerList,[_index,0]]);
					_displayName = name _unit;
					sleep 1;
					if (_unit getVariable[""mustyTP"",false]) then {_displayName = format[""%1[T]"",_displayName];};
					if (_unit getVariable[""mustyMM"",false]) then {_displayName = format[""%1[MM]"",_displayName];};
					if (captive _unit) then {_displayName = format[""%1[I]"",_displayName];};	
					lnbSetText [_playerList, [_index,0], _displayName];
				};
				
				mustyToolsDialog = {
					_displayIDD = 11391;
					if (!isNull (findDisplay _displayIDD)) exitWith {_null = [] spawn mustyPlayerRefresh;};
					createDialog ""mustyTools"";
					
					disableSerialization;
					waitUntil{!isNull (findDisplay _displayIDD)};	
					
					_actionList = 1501;
					_vehicleList = 1502;
					_infoBox = 1100;
					_versionBox = 1004;
					_playerList = 1500;
					_actionArray = [
					""Map Markers"",
					""Teleport"",
					""Teleport Player to me"",
					""Teleport me to Player"",
					""Add Primary Magazine""
					];
					
					_spawnArray = [];
					_cfgVehicles = configFile >> ""cfgVehicles"";
					for ""_i"" from 0 to (count _cfgVehicles)-1 do
					{
						_vehicle = _cfgVehicles select _i;
						if (isClass _vehicle) then
						{
							_vehType = configName _vehicle;
							if ((getNumber (_vehicle >> ""scope"") == 2) && (getText (_vehicle >> ""picture"") != """") && (((_vehType isKindOf ""LandVehicle"") or (_vehType isKindOf ""Air"") or (_vehType isKindOf ""Ship""))) && !((_vehType isKindOf ""ParachuteBase"") or (_vehType isKindOf ""BIS_Steerable_Parachute""))) then
							{
								_spawnArray set[count _spawnArray, _vehType];
							};
						};
					};
					
					{
						_side = """";
						_pic = getText(configFile >> ""CfgVehicles"" >> _x >> ""picture"");
						switch (getNumber (configFile >> ""CfgVehicles"" >> _x >> ""side"")) do 
						{
							case 0:
							{
								_side = ""(OPFOR)"";
							};
							case 1:
							{
								_side = ""(BLUFOR)"";
							};
							case 2:
							{
								_side = ""(IND)"";
							};
							default
							{
								_side = ""(CIV)"";
							};
						};
						_displayName = format[""%1 %2"",getText(configFile >> ""CfgVehicles"" >> _x >> ""displayName""),_side];							
						_index = lbAdd[_vehicleList, _displayName];
						lbSetData[_vehicleList, _index, _x];
						lnbSetPicture [_vehicleList, [_index, 0], _pic];
					} forEach _spawnArray;
					_textBox = (findDisplay _displayIDD) displayCtrl _infoBox;
					_textBox ctrlSetStructuredText parseText ""F1=Admin Menu/Refresh Player List, F2=Fix, f3=Refuel"";
					
					ctrlSetText [_versionBox,""v0.5a - deadactionman""];
					
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
						PV_mustyToolsServer = [""spawnVehicle"", player, position player, _class, false, player]; 
						publicVariableServer ""PV_mustyToolsServer"";
					};
					if (_idc == _actionList) then {
						_actionIndex = lnbCurSelRow _actionList;
						switch (_actionIndex) do
						{
							case 0:
							{
								PV_mustyToolsServer = [""mmToggle"", player, [], 0, false, player];
								publicVariableServer ""PV_mustyToolsServer"";
							};
							case 1:
							{
								PV_mustyToolsServer = [""tpToggle"", player, [], 0, false, player];
								publicVariableServer ""PV_mustyToolsServer"";
							};
							case 2:
							{
								PV_mustyToolsServer = [""tp2me"", _selectedPlayer, [], 0, false, player];
								publicVariableServer ""PV_mustyToolsServer"";
							};
							case 3:
							{
								PV_mustyToolsServer = [""tp2t"", _selectedPlayer, [], 0, false, player];
								publicVariableServer ""PV_mustyToolsServer"";
							};
							case 4:
							{
								PV_mustyToolsServer = [""addMagazine"", player, [], 0, false, player];
								publicVariableServer ""PV_mustyToolsServer"";
							};							
						};
					};
					playSound ""FD_CP_Not_Clear_F"";
					null = [] spawn mustyPlayerUpdate;
				};
			
				mustyKeyHandler = {
				_display = _this select 0;
				_keypressed = _this select 1;
				_shift = _this select 2;
				_ctrlKey = _this select 3;
				_alt = _this select 4;
				_return = false;
				
				switch (_keypressed) do
				{
					case 59:
					{
						playSound ""FD_CP_Not_Clear_F"";
						_null = [] spawn mustyToolsDialog;
						_return = true;
					};
					
					case 60:
					{
						playSound ""FD_CP_Not_Clear_F"";
						PV_mustyToolsServer = [""fix"", cursorTarget, [], 0, false, player];
						publicVariableServer ""PV_mustyToolsServer"";
						_return = true;
					};
					
					case 61:
					{
						playSound ""FD_CP_Not_Clear_F"";
						PV_mustyToolsServer = [""refuel"", cursorTarget, [], 0, false, player];
						publicVariableServer ""PV_mustyToolsServer"";
						_return = true;
					};				
				};
				_return
			};
			waituntil {!(IsNull (findDisplay 46))};
			adminEH = (findDisplay 46) displaySetEventHandler [""KeyUp"", ""_this call mustyKeyHandler""];";
			_global = false;
			_owner = owner _player;
		};
				
		case "fix":
		{
		// usage: PV_mustyToolsServer = ["fix", victimUnit, [], 0, false, player];
			if (!isNull _unit) then {
				_owner = owner _unit;
				if (local _unit) then {
					_unit setDamage 0;
				} else {
					PVC2017_damage = [_unit,0];
					_owner publicVariableClient "PVC2017_damage";
				};
				_name = getText(configFile >> "cfgVehicles" >> (typeOf _unit) >> "displayName");
				_outputScript = format["hint ""Repairing %1"";vehicle player setFuel 1;",_name];	
			};
			_owner = owner _player;
			_global = false;
		};
		case "refuel":
		{
		// usage: PV_mustyToolsServer = ["fix", victimUnit, [], 0, false, player];
			if (!isNull _unit) then {
				_owner = owner _unit;
				if (local _unit) then {
					_unit setFuel _newFuel;
				} else {
					PVC2017_refuel = [_unit,0];
					_owner publicVariableClient "PVC2017_refuel";
				};
				_name = getText(configFile >> "cfgVehicles" >> (typeOf _unit) >> "displayName");
				_outputScript = format["hint ""Healing/Repairing %1"";vehicle player setFuel 1;",_name];	
			};
			diag_log (str (_unit));
			_owner = owner _player;
			_global = false;
		};
		case "addMagazine":
		{
			
		};
		case "spawnVehicle":
		{
		// usage: PV_mustyToolsServer = ["spawnVehicle", objNul, [position], "classname", false, player];
			_owner = owner _player;
			_vehicleClass = _var;
			_vehiclePos = _pos;	// need to work out a safe place
			_vehicleName = getText(configFile >> "cfgVehicles" >> _vehicleClass >> "displayName");
			
			_vehicleObj = _vehicleClass createVehicle _vehiclePos;	// spawn the vehicle on the server
			_outputScript = format["hint ""Spawned a %1"";", _vehicleName];	// send the message to the client
			_global = false;	// only display the message on the player that called this
		};
						
		case "tpToggle":
		{
		// usage: PV_mustyToolsServer = ["tpToggle", null, [], 0, false, player];
			if (_player getVariable["mustyTP", false]) then {
				_player setVariable["mustyTP", false, true];	// turn god mode on
				// _outputScript = "onMapSingleClick """";hint ""Teleport Disabled"";";
				_outputScript = "onMapSingleClick ""[_pos, _shift, _alt] call DAM_GPS_mapClick;"";hint ""Teleport Disabled"";";
			}
			else
			{
				_player setVariable["mustyTP", true, true];	// turn god mode off
				// onMapSingleClick "[_pos, _shift, _alt] call DAM_GPS_mapClick;";
				_outputScript = "onMapSingleClick ""[_pos, _shift, _alt] call mustyTP;"";hint ""Teleport Enabled\n\nUse SHIFT+ALT+LMB on the map"";";
				
			};
			_global = false;
			_owner = owner _player;
		};
		
		case "tp2me":
		{
		// usage: PV_mustyToolsServer = ["tp2me", unit, [], 0, false, player];
			_dir = getDir _player;
			_pos = getPos _player;
			_range = (sizeOf (typeOf _unit)) / 2;
			_safeLoc = [(_pos select 0) + _range * sin(_dir), (_pos select 1) + _range * cos(_dir),0];	// should be 5m away from player
			_unit setPos _safeLoc;
			_unit setDir _dir + 180;
			_unit setVelocity [0,0,0];	// stay still you fucker
			if (isPlayer _unit) then {
				_outputScript = format["hint ""You were teleported to\n%1"";", name _player];	// send this to the teleported unit
				PV_mustyTools = _outputScript;
				(owner _unit) publicVariableClient "PV_mustyTools";
				_outputScript = format["hint ""You teleported %1 to your location"";", name _unit];	// send this to the teleporer
				PV_mustyTools = _outputScript;
				(owner _player) publicVariableClient "PV_mustyTools";
			}
			else
			{
				_outputScript = format["hint ""You teleported a %1 to your location"";", getText(configFile >> "cfgVehicles" >> (typeOf _unit) >> "displayName")];
				PV_mustyTools = _outputScript;
				(owner _player) publicVariableClient "PV_mustyTools";
			};
			_global = false;
			_owner = -1;	// skip the broacast cause we already did it
		};
		case "tp2t":
		{
		// usage: PV_mustyToolsServer = ["tp2t", unit, [], 0, false, player];
			_dir = getDir _unit;
			_pos = getPos _unit;
			_range = (sizeOf (typeOf _player)) / 2;
			_safeLoc = [(_pos select 0) + _range * sin(_dir), (_pos select 1) + _range * cos(_dir),0];	// should be 5m away from player
			_player setPos _safeLoc;
			_player setDir _dir + 180;
			_player setVelocity [0,0,0];	// stay still you fucker
			_outputScript = format["hint ""You were teleported to\n%1"";", name _unit];	// send this to the teleported unit
			_global = false;
			_owner = owner _player;
		};	
				
		case "test":
		{
			_outputScript = "hint ""This is a test"";";
			_global = true;
		};
		
		case "mmToggle":
		{
			_outputScript = "_null = [] spawn mustyMM;";
			_global = false;
			_owner = owner _player;
		};		
		
		default
		{
			// no command issued
			diag_log("MUSTY_TOOLS - Error: No Command Specified");
		};
	};
		
	// send to the client(s)
	PV_mustyTools = _outputScript;
	if (!_global && _owner > -1) then {_owner publicVariableClient "PV_mustyTools";};	// only send to the ID of the _unit
	if (_global) then {publicVariable "PV_mustyTools";};	// send to all players (check for JiP issues
	
};

"PV_mustyToolsServer" addPublicVariableEventHandler {[_this select 1] spawn mustyToolsServer};