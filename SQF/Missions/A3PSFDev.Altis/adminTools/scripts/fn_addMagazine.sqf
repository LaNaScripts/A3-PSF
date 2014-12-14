_weapon = currentWeapon player;  
_cfg = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines"); 
_count = count _cfg; 
_mag = _cfg select 0; 

systemChat format ["found %1", _mag];  
 player addMagazine _mag;