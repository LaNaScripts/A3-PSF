_HUD = 
{
	disableSerialization; 
	cutRsc ["UI_Monitor", "PLAIN"]; 
	_display = uiNamespace getVariable "UI_Monitor_display"; 
	_ctrlHealth = _display displayCtrl 5001;
	_ctrlDir = _display displayCtrl 5003; 
	_ctrlFps = _display displayCtrl 5004;
	_ctrlCash = _display displayCtrl 5005;
      
    while {!isNull _display} do {
		_ctrlFps ctrlSetText format["%1",round diag_fps];
		_ctrlHealth ctrlSetText format["%1%2", round((1 - (damage player)) * 100), "%"];
		_ctrlCash ctrlSetText format["%1",rating player];
		if (Damage Player < 0.25) Then {_ctrlHealth ctrlSetTextColor [0,0.5,0,1];}; 
		if (Damage Player >= 0.25) Then {_ctrlHealth ctrlSetTextColor [1,1,0,1];};         
		if (Damage Player >= 0.5) Then {_ctrlHealth ctrlSetTextColor [1.000000,0.644531,0.000000,1];};
		if (Damage Player >= 0.75) Then {_ctrlHealth ctrlSetTextColor [1,0,0,1];};

		if (vehicle player != player) Then {
			Private ["_dir","_d"];
			_d = GetDir Vehicle player;

			if (_d >= 337.5 || _d < 22.5) Then {_dir = "N";};
			if (_d >= 292.5 && _d < 337.5) Then {_dir = "NW";};
			if (_d >= 247.5 && _d < 292.5) Then {_dir = "W";};
			if (_d >= 202.5 && _d < 247.5) Then {_dir ="SW";};
			if (_d >= 157.5 && _d < 202.5) Then {_dir ="S";};
			if (_d >= 112.5 && _d < 157.5) Then {_dir ="SE";};
			if (_d >= 67.5 && _d < 112.5) Then {_dir ="E";};
			if (_d >= 22.5 && _d < 67.5) Then {_dir ="NE";};
			_ctrlDir ctrlSetText format["%1", _dir];
		} else {
			Private ["_dir","_d"];
			_d = GetDir player;

			if (_d >= 337.5 || _d < 22.5) Then {_dir = "N";};
			if (_d >= 292.5 && _d < 337.5) Then {_dir = "NW";};
			if (_d >= 247.5 && _d < 292.5) Then {_dir = "W";};
			if (_d >= 202.5 && _d < 247.5) Then {_dir ="SW";};
			if (_d >= 157.5 && _d < 202.5) Then {_dir ="S";};
			if (_d >= 112.5 && _d < 157.5) Then {_dir ="SE";};
			if (_d >= 67.5 && _d < 112.5) Then {_dir ="E";};
			if (_d >= 22.5 && _d < 67.5) Then {_dir ="NE";};
			_ctrlDir ctrlSetText format["%1", _dir];
		};
			sleep 0.1;
    }; 
};

[]Spawn _HUD; 