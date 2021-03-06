private ["_spawnSelection","_characterID","_playerObj","_playerID","_dummy","_worldspace","_state","_doLoop","_key","_primary","_medical","_stats","_humanity","_lastinstance","_friendlies","_randomSpot","_position","_debug","_distance","_hit","_fractures","_score","_findSpot","_pos","_isIsland","_w","_clientID","_spawnMC","_namespace"];
_characterID			=	_this select 0;
_playerObj			=	_this select 1;
_spawnSelection	=	_this select 3;
_playerID				=	getPlayerUID _playerObj;
if (isNull _playerObj) exitWith
	{diag_log ("[Сервер]: Установки: Ошибка инициализации: Выход, объект игрок обнулен: " + str(_playerObj));};
_playerObj addMPEventHandler ["MPHit", {_this spawn fnc_plyrHit;}];
if (_playerID == "") then
	{_playerID	=	getPlayerUID _playerObj;};
if (_playerID == "") exitWith
	{diag_log ("[Сервер]: Установки: Ошибка инициализации: Выход, игрок не имеет ID: " + str(_playerObj));};
private["_dummy"];
_dummy	=	getPlayerUID _playerObj;
if ( _playerID != _dummy ) then
	{ 
		diag_log format["[Сервер]: Отладка: _playerID не совпадает с UID! _playerID:%1",_playerID]; 
		_playerID	=	_dummy;
	};
_worldspace	=	[];
_state			=	[];
_doLoop		=	0;
while {_doLoop < 5} do
	{
		_key			=	format["CHILD:102:%1:",_characterID];
		_primary	=	_key call server_hiveReadWrite;
		if (count _primary > 0) then
			{
				if ((_primary select 0) != "ERROR") then
					{_doLoop = 9;};
			};
		_doLoop	=	_doLoop + 1;
	};
if (isNull _playerObj || !isPlayer _playerObj) exitWith
	{diag_log ("[Сервер]: Установки: Результат: Выход, объект-игрок, обнулен: " + str(_playerObj));};
_medical		=	_primary select 1;
_stats			=	_primary select 2;
_state			=	_primary select 3;
_worldspace	=	_primary select 4;
_humanity		=	_primary select 5;
_lastinstance	=	_primary select 6;
_randomSpot	=	false;
if (count _worldspace > 0) then
	{
		_position	=	_worldspace select 1;
		if (count _position < 3) then
			{_randomSpot	=	true;};
		_debug	=	getMarkerpos "respawn_west";
		_distance	=	_debug distance _position;
		if (_distance < 2000) then
			{_randomSpot	=	true;};
		_distance	=	[0,0,0] distance _position;
		if (_distance < 500) then
			{_randomSpot	=	true;};
		if (_lastinstance != dayZ_instance) then
			{_randomSpot	=	true;};
	}
else
	{_randomSpot	=	true;};
if (count _medical > 0) then
	{
		_playerObj setVariable["USEC_isDead",(_medical select 0),true];
		_playerObj setVariable["NORRN_unconscious", (_medical select 1), true];
		_playerObj setVariable["USEC_infected",(_medical select 2),true];
		_playerObj setVariable["USEC_injured",(_medical select 3),true];
		_playerObj setVariable["USEC_inPain",(_medical select 4),true];
		_playerObj setVariable["USEC_isCardiac",(_medical select 5),true];
		_playerObj setVariable["USEC_lowBlood",(_medical select 6),true];
		_playerObj setVariable["USEC_BloodQty",(_medical select 7),true];
		_playerObj setVariable["unconsciousTime",(_medical select 10),true];
		{
			_playerObj setVariable[_x,true,true];
			usecBleed	=	[_playerObj,_x,_hit];
			publicVariable "usecBleed";
		} count (_medical select 8);
		_fractures	=	(_medical select 9);
		_playerObj setVariable ["hit_legs",(_fractures select 0),true];
		_playerObj setVariable ["hit_hands",(_fractures select 1),true];
		if (count _medical > 11) then
			{_playerObj setVariable ["messing",(_medical select 11),true];};
	}
else
	{
		_playerObj setVariable ["hit_legs",0,true];
		_playerObj setVariable ["hit_hands",0,true];
		_playerObj setVariable ["USEC_injured",false,true];
		_playerObj setVariable ["USEC_inPain",false,true];
		_playerObj setVariable ["messing",[0,0],true];
	};
if (count _stats > 0) then
	{
		_playerObj setVariable["zombieKills",(_stats select 0),true];
		_playerObj setVariable["headShots",(_stats select 1),true];
		_playerObj setVariable["humanKills",(_stats select 2),true];
		_playerObj setVariable["banditKills",(_stats select 3),true];
		_playerObj addScore (_stats select 1);
		_score = score _playerObj;
		_playerObj addScore ((_stats select 0) - _score);
		_playerObj setVariable["zombieKills_CHK",(_stats select 0)];
		_playerObj setVariable["headShots_CHK",(_stats select 1)];
		_playerObj setVariable["humanKills_CHK",(_stats select 2)];
		_playerObj setVariable["banditKills_CHK",(_stats select 3)];
		if (count _stats > 4) then
			{
				if (!(_stats select 3)) then
					{_playerObj setVariable["selectSex",true,true];};
			}
		else
			{_playerObj setVariable["selectSex",true,true];};
	}
else
	{
		_playerObj setVariable["zombieKills",0,true];
		_playerObj setVariable["humanKills",0,true];
		_playerObj setVariable["banditKills",0,true];
		_playerObj setVariable["headShots",0,true];
		_playerObj setVariable["zombieKills_CHK",0];
		_playerObj setVariable["humanKills_CHK",0,true];
		_playerObj setVariable["banditKills_CHK",0,true];
		_playerObj setVariable["headShots_CHK",0];
	};
if (_randomSpot) then
	{
		private["_counter","_position","_isNear","_isZero","_mkr"];
		if (!isDedicated) then
			{endLoadingScreen;};
		if (isnil "spawnArea") then
			{spawnArea	=	1500;};
		if(isnil "spawnShoremode") then
			{spawnShoremode	=	1;};
		_spawnMC	=	actualSpawnMarkerCount;
		_findSpot		=	true;
		_mkr				=	"";
		if (isNil "_spawnSelection") then
			{_spawnSelection	=	9;};
		while {_findSpot} do
			{
				_counter = 0;
				while {_counter < 20 and _findSpot} do
					{
						if (Ultima_SpawnMonitor) then
							{
								if ((dayz_spawnselection == 1) and (_spawnSelection < 9)) then
									{
										if ((((_humanity > Ultima_Spawn_Humanity) || (_humanity < (Ultima_Spawn_Humanity * -1))) && !(Ultima_SpawnMonitor_Donator)) || ((_playerID in Ultima_Donators) || (_playerID in Ultima_Admins))) then
											{
												_mkr			=	"spawn" + str(_spawnSelection);
												_position	=	getMarkerPos _mkr;
												if (dayz_paraSpawn) then
													{_position = [(random 100) + (_position select 0), (random 100) + (_position select 1), 300];}
												else
													{_position = [(random 100) + (_position select 0), (random 100) + (_position select 1), 0];};
											}
										else
											{
												_mkr	=	"spawn" + str(floor(random _spawnMC));
												_position	=	([(getMarkerPos _mkr),0,spawnArea,10,0,2000,spawnShoremode] call BIS_fnc_findSafePos);
											};
									}
								else
									{
										_mkr	=	"spawn" + str(floor(random _spawnMC));
										_position	=	([(getMarkerPos _mkr),0,spawnArea,10,0,2000,spawnShoremode] call BIS_fnc_findSafePos);
									};
							}
						else
							{
								_mkr	=	"spawn" + str(floor(random _spawnMC));
								_position	=	([(getMarkerPos _mkr),0,spawnArea,10,0,2000,spawnShoremode] call BIS_fnc_findSafePos);								
							};
						_isNear		=	count (_position nearEntities ["Man",100]) == 0;
						_isZero		=	((_position select 0) == 0) && ((_position select 1) == 0);
						_pos			=	_position;
						_isIsland	=	false;
						for [{_w=0},{_w<=150},{_w=_w+2}] do
							{
								_pos	=	[(_pos select 0),((_pos select 1) + _w),(_pos select 2)];
								if(surfaceisWater _pos) exitWith 
									{_isIsland	=	true;};
							};
						if ((_isNear && !_isZero) || _isIsland) then
							{_findSpot	=	false};
						_counter	=	_counter + 1;
					};
			};
		_isZero		=	((_position select 0) == 0) && ((_position select 1) == 0);
		_position	=	[_position select 0,_position select 1,0];
		if (!_isZero) then
			{_worldspace	=	[0,_position];};
		//	ULTIMA СНЯТИЕ КАРМЫ ЗА СМЕРТЬ ИГРОКА!!!!
		private ["_gainHum","_savelog"];
		_gainHum	=	0;
		if ((_humanity < 200) and (_humanity > -200)) then
			{_gainHum	=	-1*_humanity;}
		else
			{
				if (_humanity > 0) then
					{_gainHum	=	-200;}
				else
					{_gainHum	=	200;};
			};
		if (_gainHum != 0) then
			{
				_owner	=	owner _playerObj;
				PVDZE_plr_HumanityChange = [_playerObj,_gainHum,0];
				_owner publicVariableClient "PVDZE_plr_HumanityChange";
			};
	};
dayz_players set [count dayz_players,_playerObj];
_playerObj setVariable["CharacterID",_characterID,true];
_playerObj setVariable["humanity",_humanity,true];
_playerObj setVariable["humanity_CHK",_humanity];
_playerObj setVariable["lastPos",getPosATL _playerObj];
dayzPlayerLogin2 = [_worldspace,_state];
_clientID = owner _playerObj;
if (!isNull _playerObj) then
	{
		_clientID publicVariableClient "dayzPlayerLogin2";
		if (isNil "PVDZE_plr_SetDate") then
			{call server_timeSync;};
		_clientID publicVariableClient "PVDZE_plr_SetDate";
	};
_playerObj setVariable ["lastTime",time];
[_playerObj] call Terminal_Rebalance;

PVDZE_plr_Login = nil;
PVDZE_plr_Login2 = nil;