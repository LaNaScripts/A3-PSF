waitUntil {getPlayerUID player !=""};
waituntil {!(IsNull (findDisplay 46))};

mustyAdminUIDs = ["76561197965409790"];

call compile preprocessFileLineNumbers "adminTools\compile.sqf";

adminEH = (findDisplay 46) displaySetEventHandler ["KeyUp", "_this call AdminKeyHandler"];