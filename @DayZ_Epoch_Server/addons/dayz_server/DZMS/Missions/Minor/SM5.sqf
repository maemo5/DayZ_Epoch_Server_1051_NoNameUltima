private ["_missName","_coords","_crash","_crate"];
_missName	=	"Хаммер преступников";
_coords		=	call DZMSFindPos;
[nil,nil,rTitleText,"Хаммер преступников попал в аварию! Проверь свою карту!", "PLAIN",10] call RE;
[_coords,_missName] ExecVM DZMSAddMinMarker;
_crash = createVehicle ["HMMWVwreck",_coords,[], 0, "CAN_COLLIDE"];
[_crash] call DZMSProtectObj;
_crate = createVehicle ["RULaunchersBox",[(_coords select 0) - 14, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate,"weapons"] ExecVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;
[_coords,3,1] ExecVM DZMSAISpawn;
sleep 1;
[_coords,3,1] ExecVM DZMSAISpawn;
sleep 1;
waitUntil{{isPlayer _x && _x distance _coords <= 30 } count playableunits > 0}; 
[nil,nil,rTitleText,"Хаммер перешел под контроль выживших!", "PLAIN",6] call RE;
diag_log format["[DZMS]: Минор миссия SM5 завершена."];
deleteMarker "DZMSMinMarker";
deleteMarker "DZMSMinDot";
DZMSMinDone	=	true;