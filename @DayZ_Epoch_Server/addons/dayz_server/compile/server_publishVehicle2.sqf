private ["_ATL","_activatingPlayer","_isOK","_object","_worldspace","_location","_dir","_class","_uid","_key","_keySelected","_characterID","_donotusekey"];
_object				=	_this select 0;
_worldspace			=	_this select 1;
_class				=	_this select 2;
_donotusekey		=	_this select 3;
_keySelected		=	_this select 4;
_activatingPlayer	=	_this select 5;
if ( (count _this) > 5) then
	{_ATL	=	true;}
else
	{_ATL	=	false;};
if(_donotusekey) then
	{_isOK	=	true;}
else
	{_isOK	=	isClass(configFile >> "CfgWeapons" >> _keySelected);};
if(!_isOK) exitWith 
	{diag_log ("[БД]: Отсутствует ключ к технике: "+ str(_keySelected));};
if(_donotusekey) then
	{_characterID	=	_keySelected;}
else
	{_characterID	=	str(getNumber(configFile >> "CfgWeapons" >> _keySelected >> "keyid"));};
diag_log ("[Сервер]: Публичное: Попытка доступа: " + str(_object));
_dir			=	_worldspace select 0;
_location	=	_worldspace select 1;
_uid			=	_worldspace call dayz_objectUID3;
_key			=	format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance, _class, 0 , _characterID, _worldspace, [], [], 1,_uid];
diag_log ("[БД]: Запись: "+ str(_key)); 
_key call server_hiveWrite;
[_object,_uid,_characterID,_class,_dir,_location,_donotusekey,_activatingPlayer,_ATL] spawn
	{
		private ["_object","_uid","_characterID","_done","_retry","_key","_result","_outcome","_oid","_class","_location","_object_para","_donotusekey","_activatingPlayer"];
		_object				=	_this select 0;
		_uid				=	_this select 1;
		_characterID		=	_this select 2;
		_class				=	_this select 3;
		_location			=	_this select 5;
		_donotusekey		=	_this select 6;
		_activatingPlayer	=	_this select 7;
		_ATL				=	_this select 8;
		_done				=	false;
		_retry				=	0;
		while {_retry < 10} do
			{
				sleep 1;
				_key	=	format["CHILD:388:%1:",_uid];
				diag_log ("[БД]: Запись: "+ str(_key));
				_result		=	_key call server_hiveReadWrite;
				_outcome	=	_result select 0;
				if (_outcome == "PASS") then
					{
						_oid	=	_result select 1;
						diag_log("[Сервер]: Пользовательское: Выборка: " + str(_oid));
						_done	=	true;
						_retry	=	100;
					}
				else
					{
						diag_log("[Сервер]: Пользовательское: Новая попытка получить id для: " + str(_uid));
						_done	=	false;
						_retry	=	_retry + 1;
					};
			};
		deleteVehicle _object;
		if(!_done) exitWith
			{ diag_log("[Сервер]: Пользовательское: Неудалось получить id для: " + str(_uid)); };
		if(DZE_TRADER_SPAWNMODE) then
			{
				_object_para	=	createVehicle ["ParachuteMediumWest", [0,0,0], [], 0, "CAN_COLLIDE"];
				_object_para setPos [_location select 0, _location select 1,(_location select 2) + 65];
				_object	=	createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
			}
		else
			{_object	=	createVehicle [_class, _location, [], 0, "CAN_COLLIDE"];};
		if(!_donotusekey) then
			{
				_object setvehiclelock "locked";
				_object setVariable ["R3F_LOG_disabled",true,true];
			};
		clearWeaponCargoGlobal  _object;
		clearMagazineCargoGlobal  _object;
		[_object] call server_removeWME;	//	Удаление ПНВ, тепловизора и т.п., вооружения, патронов, для определенной техники
		_object setVariable ["ObjectID", _oid, true];
		_object setVariable ["lastUpdate",time];
		_object setVariable ["CharacterID", _characterID, true];
		if(DZE_TRADER_SPAWNMODE) then
			{
				_object attachTo [_object_para, [0,0,-1.6]];
				sleep 1.0;
				WaitUntil{(([_object] call FNC_GetPos) select 2) < 0.1};
				detach _object;
				deleteVehicle _object_para;
			};
		if (_ATL) then
			{_object setPosATL _location};
		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_object];
		_object call fnc_veh_ResetEH;
		PVDZE_veh_Init	=	_object;
		publicVariable "PVDZE_veh_Init";
		if (_ATL) then
			{diag_log ("[Сервер]: Публичное: " + str(_activatingPlayer) + " установил " + (_class) + " с ID " + str(_uid));}
		else
			{diag_log ("[Сервер]: Публичное: " + str(_activatingPlayer) + " купил " + (_class) + " с ID " + str(_uid));};
	};