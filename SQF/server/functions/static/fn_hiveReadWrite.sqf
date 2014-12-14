private["_key","_resultArray","_data"];

_data = "HiveExt" callExtension _this;
_resultArray = call compile format ["%1",_data];

_resultArray
