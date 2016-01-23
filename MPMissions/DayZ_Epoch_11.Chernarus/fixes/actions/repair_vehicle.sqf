private ["_part","_cancel","_color","_allFixed","_percent","_string","_handle","_damage","_cmpt","_vehicle","_hitpoints"];
_vehicle	=	(_this select 3);
{dayz_myCursorTarget removeAction _x} count s_player_repairActions;s_player_repairActions = [];
_allFixed	=	true;
_hitpoints	=	_vehicle call vehicle_getHitpoints;
{			
	_damage	=	[_vehicle,_x] call object_getHit;
	_part	=	"PartGeneric";
	_cmpt	=	toArray (_x);
	_cmpt set [0,20];
	_cmpt set [1,toArray ("-") select 0];
	_cmpt set [2,20];
	_cmpt	=	toString _cmpt;
	if(["Engine",_x,false] call fnc_inString) then
		{_part	=	"PartEngine";};
	if(["HRotor",_x,false] call fnc_inString) then
		{_part	=	"PartVRotor";};
	if(["Fuel",_x,false] call fnc_inString) then
		{_part	=	"PartFueltank";};
	if(["Wheel",_x,false] call fnc_inString) then
		{_part	=	"PartWheel";};	
	if(["Glass",_x,false] call fnc_inString) then
		{_part	=	"PartGlass";};
	if (_damage > 0) then
		{
			_allFixed	=	false;
			_color	=	"color='#ffff00'";
			if (_damage >= 0.5) then
				{_color = "color='#ff8800'";};
			if (_damage >= 0.9) then
				{_color = "color='#ff0000'";};
			_percent	=	round(_damage * 100);
			_string		=	format["<t %1>%2%3 (%4 %5)</t>",_color, (localize "Ultima_Repair"), _cmpt, _percent, "%"];
			_handle		=	dayz_myCursorTarget addAction [_string, "\z\addons\dayz_code\actions\repair.sqf", [_vehicle,_part,_x], 0, false, true, "", ""];
			s_player_repairActions set [count s_player_repairActions,_handle];
		};
} count _hitpoints;
if (_allFixed) then
	{_vehicle setDamage 0;};
if(count _hitpoints > 0 ) then
	{
		_cancel	=	dayz_myCursorTarget addAction [localize "STR_EPOCH_PLAYER_CANCEL", "\z\addons\dayz_code\actions\repair_cancel.sqf", "repair", 0, true, false, "", ""];
		s_player_repairActions set [count s_player_repairActions,_cancel];
		s_player_repair_crtl = 1;
	};