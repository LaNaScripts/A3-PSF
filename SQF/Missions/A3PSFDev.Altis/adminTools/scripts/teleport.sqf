if (isnil "GPS" ) then {GPS=0};

if (GPS==0) then
{
	player addweapon "ItemGPS";
	player addweapon "ItemMap";
	GPS=1;
};

closedialog 0;
sleep 0.5;
TitleText [format["Click on the map to Tele-Port"], "PLAIN DOWN"];

openMap [true, false];
onMapSingleClick "[_pos select 0, _pos select 1, _pos select 2] execVM ""adminTools\scripts\Teleport1.sqf""; True";
