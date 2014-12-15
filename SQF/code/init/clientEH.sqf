"CV_SetDate"				addPublicVariableEventHandler {
	_newdate = _this select 1;
	_date = +(date); 
	{
		if (_x != _newdate select _forEachIndex) exitWith {
			setDate _newdate;
		};
	} forEach _date;
};