private ["_key","_result","_outcome","_date"];

_key = "CHILD:307:";
_result = _key call A3PSF_fnc_hiveReadWrite;
_outcome = _result select 0;

_date = [2017,6,6,6,0];

if(_outcome == "PASS") then {
	_date = _result select 1;
};

setDate _date;

_date