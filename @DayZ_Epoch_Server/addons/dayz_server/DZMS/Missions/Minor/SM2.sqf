private ["_missName","_coords","_base","_base1","_base2","_base3","_vehicle","_vehicle1","_crate","_crate2"];
_missName = "Мед. оутпост";
_coords = call DZMSFindPos;
[nil,nil,rTitleText,"Группа преступников получила контроль над медицинским оутпостом! Проверь свою карту!", "PLAIN",10] call RE;
[_coords,_missName] ExecVM DZMSAddMinMarker;
_base = createVehicle ["US_WarfareBFieldhHospital_Base_EP1",[(_coords select 0) +2, (_coords select 1)+5,-0.3],[], 0, "CAN_COLLIDE"];
_base1 = createVehicle ["MASH_EP1",[(_coords select 0) - 24, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
_base2 = createVehicle ["MASH_EP1",[(_coords select 0) - 17, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
_base3 = createVehicle ["MASH_EP1",[(_coords select 0) - 10, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
[_base] call DZMSProtectObj;
[_base1] call DZMSProtectObj;
[_base2] call DZMSProtectObj;
[_base3] call DZMSProtectObj;
_vehicle = createVehicle ["UAZ_Unarmed_UN_EP1",[(_coords select 0) + 10, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
_vehicle1 = createVehicle ["HMMWV_DZ",[(_coords select 0) + 15, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
[_vehicle] call DZMSSetupVehicle;
[_vehicle1] call DZMSSetupVehicle;
_crate = createVehicle ["USVehicleBox",[(_coords select 0) - 3, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate,"medical"] ExecVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;
_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) - 8, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2,"weapons"] ExecVM DZMSBoxSetup;
[_crate2] call DZMSProtectObj;
[[(_coords select 0) - 20, (_coords select 1) - 15,0],4,0] ExecVM DZMSAISpawn;
sleep 3;
[[(_coords select 0) + 10, (_coords select 1) + 15,0],4,0] ExecVM DZMSAISpawn;
sleep 3;
[[(_coords select 0) - 10, (_coords select 1) - 15,0],4,0] ExecVM DZMSAISpawn;
sleep 3;
[[(_coords select 0) + 20, (_coords select 1) + 15,0],4,0] ExecVM DZMSAISpawn;
sleep 3;
waitUntil{{isPlayer _x && _x distance _coords <= 30  } count playableunits > 0}; 
[_vehicle] ExecVM DZMSSaveVeh;
[_vehicle1] ExecVM DZMSSaveVeh;
[nil,nil,rTitleText,"Мед. оутпост перешел под контроль выживших!", "PLAIN",6] call RE;
diag_log format["[DZMS]: Минор миссия SM2 завершена."];
deleteMarker "DZMSMinMarker";
deleteMarker "DZMSMinDot";
DZMSMinDone = true;