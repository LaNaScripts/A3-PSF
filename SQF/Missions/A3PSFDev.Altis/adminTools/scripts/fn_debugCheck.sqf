/* ----------------------------------------------------------------------------
Function: c2017_fnc_debugCheck

Description:
	Gets variables and displays debug screen.

Parameters:
	None

Example:
	call c2017_fnc_debugCheck
	
Returns:
	Nothing

Author:
	r4z
---------------------------------------------------------------------------- */

private["_health","_hunger","_thirst","_sanity","_nearby","_debugRefresh","_fatigue","_status"];

if (isNil {player getVariable "MonitorStatus"}) then { player setVariable ["MonitorStatus",true]; MV = true; } else { player setVariable ["MonitorStatus",nil]; MV = false; };

_health = r_player_health;
_hunger = r_player_hunger;
_thirst = r_player_thirst;
_sanity = r_player_sanity;
_nearby = (player getVariable "nearby");
_fatigue = (getFatigue player);
_fps = (diag_fps);

if (!alive player) exitwith {}; 

while {MV} do {
	hintSilent parseText format ["
	<t size='1.15'  align='left' color='#FF0033'>Health: </t><t size='1.15'  align='right' color='#FFBF00'>%1</t><br/>
	<t size='1.15'  align='left' color='#FF0033'>Hunger: 	 </t><t size='1.15'  align='right' color='#FFBF00'>%2</t><br/>
	<t size='1.15'  align='left' color='#FF0033'>Thirst:		 </t><t size='1.15'  align='right' color='#FFBF00'>%3</t><br/>
	<br/>
	<t size='1.15'  align='left' color='#FF0033'>Sight/Sound: 	 </t><t size='1.15'  align='right' color='#FFBF00'>%8/%7</t><br/>
	<br/>
	<t size='1.15'  align='left' color='#FF0033'>Nearby: 		 </t><t size='1.15'  align='right' color='#FFBF00'>%6</t><br/>
	<t size='1.15'  align='left' color='#FF0033'>Sanity: 		 </t><t size='1.15'  align='right' color='#FFBF00'>%4</t><br/>
	<t size='1.15'  align='left' color='#FF0033'>Fatigue: 		 </t><t size='1.15'  align='right' color='#FFBF00'>%5</t><br/><br/>
	<t size='1.15'  align='left' color='#FF0033'>bodyTemp: 		 </t><t size='1.15'  align='right' color='#FFBF00'>%13</t><br/><br/>
	<t size='1.15'  align='left' color='#FF0033'>environmentTemp: 		 </t><t size='1.15'  align='right' color='#FFBF00'>%14</t><br/><br/>

	<t size='1.15'  align='left' color='#FF0033'>AI Count: 		 </t><t size='1.15'  align='right' color='#FFBF00'>%9/%10</t><br/>
	<br/>
	<t size='1.15'  align='left' color='#FF0033'>Bleeding: 		 </t><t size='1.15'  align='right' color='#FFBF00'>%11</t><br/>
	<br/>
	<t size='1.15'  align='center' color='#FF0033'>FPS: 		 </t><t size='1.15'  align='Center' color='#FFBF00'>%12</t><br/>",
	r_player_health, 
	r_player_hunger, 
	r_player_thirst, 
	r_player_sanity, 
	(getFatigue player), 
	(player getVariable "nearby"),
	C2017_audial,
	C2017_visual,
	({alive _x} count entities "AI_2017_Unit"),
	(count entities "AI_2017_Unit"),
	r_player_bleeding,
	_fps,
	r_player_bodyTemp,
	r_player_environmentTemp
	];
	sleep 1;
};

hintSilent "Debug Disabled";
