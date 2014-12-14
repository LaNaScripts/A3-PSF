"playerJoin" addPublicVariableEventHandler { (_this select 1) execFSM "\A3PSF\server\monitor\loginsystem.fsm"; };
onPlayerDisconnected { [_id, _name, _uid] call sA3PSF_fnc_disconnect; };