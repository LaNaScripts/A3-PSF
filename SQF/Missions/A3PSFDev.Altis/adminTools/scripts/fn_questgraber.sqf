/*
	DAM_questGrab.sqf - by deadactionman 2014
	
	Grabs all units and vehicles and duplicates them to the clipboard
	Usage: _null = [range, abs] execVM "DAM_questGrab.sqf";
		abs = true, just grab the absoloute location of each object
		abs = false, the object positions are relative to the player's position. Can then use the quest in multiple locations
		Origin/player pos is saved in the output

	After the beep, copy the contents of the clipboard into a custom Quest
*/
hint "Scanning for units and vehicles...";
_range = _this select 0;
_abs = _this select 1;
_eol = toString[13];
_clipboard = "";
_validObjects = [];
_nearObjects = nearestObjects [player, ["Man","LandVehicle","Air","Ship","Static","Thing"], _range];
{
	if ((_x != player) && (!(_x isKindOf "Animal")) && (_x in allMissionObjects "All")) then {
		_validObjects set [count _validObjects, _x];
	};
} forEach _nearObjects;

if (count _nearObjects > 0) then {
	_nearestCity = text (nearestLocations [getpos player,["NameCity","Name","NameLocal","NameVillage","Airport","Strategic","CityCenter"],3000] select 0);
	_clipboard = _clipboard + "quest_XXX = {" + toString[13];
	_clipboard = _clipboard + format["// Custom Quest near %1, created with DAM_questGrab.sqf", _nearestCity] + toString[13];	
	_clipboard = _clipboard + format["// Origin %1, ABS=%2", getpos player, _abs] + toString[13] + toString[13];
	_clipboard = _clipboard + "	_tier = _this select 0;" + toString[13];
	_clipboard = _clipboard + "	_displayName = _this select 1;" + toString[13];
	_clipboard = _clipboard + "	_icon = _this select 2;" + toString[13];
	_clipboard = _clipboard + "	_type = _this select 3;" + toString[13];
	_clipboard = _clipboard + "	_pos = _this select 4;" + toString[13];
	_clipboard = _clipboard + "	_script = _this select 5;" + toString[13];
	_clipboard = _clipboard + "	_radius = _this select 6;" + toString[13];
	_clipboard = _clipboard + "	_questObjects = [];" + toString[13] + toString[13];
	{
		_group = grpNull;
		_object = objNull;
		_objectPos = [];
		_xDiff = 0;
		_yDiff = 0;
		_objectDir = getDir _x;
		if (!_abs) then {
			_xDiff = (getPos player) select 0;
			_yDiff = (getPos player) select 1;
		};
		_objectPos = [((getPos _x) select 0) - _xDiff, ((getPos _x) select 1) - _yDiff, (getPos _x) select 2];

		_groupType = "";

		// Build the clipboard object at a time
		if (_abs) then {	
			if (_x isKindOf "Man") then {
				_clipboard = _clipboard + format["	_group = createGroup CIVILIAN;"] + toString[13];
				_clipboard = _clipboard + format["	_obj = _group createUnit [%1, %2, [], 0, ""CAN_COLLIDE""];	// ITEM %3", str(typeOf _x),_objectPos,_forEachIndex + 1] + toString[13];
				_clipboard = _clipboard + format["	_obj setDir %1;", _objectDir] + toString[13];
				_clipboard = _clipboard + format["	_obj setPos %1;", _objectPos] + toString[13];	
			}
			else
			{
				// has waypoints and is a vehicle
				_clipboard = _clipboard + format["	_obj = createVehicle [%1, %2, [], 0, ""CAN_COLLIDE"";	// ITEM %3", str(typeOf _x), _objectPos ,_forEachIndex + 1] + toString[13];
				_clipboard = _clipboard + format["	_obj setDir %1;", _objectDir] + toString[13];
				_clipboard = _clipboard + format["	_obj setPos %1;", _objectPos] + toString[13];	
			};
		} else
		{
			if (_x isKindOf "Man") then {
				_clipboard = _clipboard + format["	_group = createGroup CIVILIAN;"] + toString[13];
				_clipboard = _clipboard + format["	_obj = _group createUnit [%1, [(_pos select 0) + %2, (_pos select 1) + %3, (_pos select 2) + %4], [], 0, ""CAN_COLLIDE""];	// ITEM %5", str(typeOf _x),_objectPos select 0, _objectPos select 1, _objectPos select 2,_forEachIndex + 1] + toString[13];
				_clipboard = _clipboard + format["	_obj setDir %1;", _objectDir] + toString[13];			
				_clipboard = _clipboard + format["	_obj setPos [(_pos select 0) + %1, (_pos select 1) + %2, (_pos select 2) + %3];",_objectPos select 0, _objectPos select 1, _objectPos select 2] + toString[13];	
			
			}	//	_unit = group player createUnit ["SoldierWB", Position player, [], 0, "FORM"];	 _veh = createVehicle ["ah1w", position player, [], 0, "FLY"] 
			else
			{
				// has waypoints and is a vehicle
				_clipboard = _clipboard + format["	_obj = createVehicle [%1, [(_pos select 0) + %2, (_pos select 1) + %3, (_pos select 2) + %4], [], 0, ""CAN_COLLIDE""];	// ITEM %5", str(typeOf _x),_objectPos select 0, _objectPos select 1, _objectPos select 2,_forEachIndex + 1] + toString[13];
				_clipboard = _clipboard + format["	_obj setDir %1;", _objectDir] + toString[13];
				_clipboard = _clipboard + format["	_obj setPos [(_pos select 0) + %1, (_pos select 1) + %2, (_pos select 2) + %3];",_objectPos select 0, _objectPos select 1, _objectPos select 2] + toString[13];					
			};		
		};
		_clipboard = _clipboard + "	_questObjects set[count _questObjects, _obj];" + toString[13];
		
	} forEach _validObjects;
	_clipboard = _clipboard + toString[13];
	_clipboard = _clipboard + "// wait until !SOME_CONDITION OR [_tier] call quest_getStatus == 2 (timeout)" + toString[13];
	_clipboard = _clipboard + "	while {SOME_CONDITION && [_tier] call quest_getStatus != 2} do {" + toString[13];
	_clipboard = _clipboard + "		sleep 1;	// not much to do but wait!" + toString[13];
	_clipboard = _clipboard + "	};" + toString[13];
	_clipboard = _clipboard + "	if ([_tier] call quest_getStatus != 2) then {[_tier,""complete""] call quest_update;};	// if it didn't timeout, declare COMPLETE" + toString[13];
	_clipboard = _clipboard + "	[_tier, _pos, _questObjects] spawn quest_AOmonitor;	// monitor the AO and delete all _questObjects when all players leave" + toString[13];
	_clipboard = _clipboard + "};" + toString[13];
	
	copyToClipboard (_clipboard);
	hint "All objects/units/vehicles copied to the clipboard";
} else
{
	hint "Nothing nearby?";
};
playSound "alarm";
	