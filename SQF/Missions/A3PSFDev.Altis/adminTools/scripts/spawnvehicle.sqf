_vehicleClass = _this select 0;;
_vehiclePos = player modeltoworld [0,20,0];;	// need to work out a safe place
_vehicleName = getText(configFile >> "cfgVehicles" >> _vehicleClass >> "displayName");

hint format["Spawning %1",_vehicleName];

_vehicleObj = _vehicleClass createVehicle _vehiclePos;	// spawn the vehicle on the server