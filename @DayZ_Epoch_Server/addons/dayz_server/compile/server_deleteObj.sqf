private["_id","_uid","_key"];
_id						=	_this select 0;
_uid 						=	_this select 1;
_activatingPlayer	=	_this select 2;
if (isServer) then
	{
		if (parseNumber _id > 0) then
			{
				_key = format["CHILD:304:%1:",_id];
				_key call server_hiveWrite;
				diag_log format["[Сервер]: Удаление: %1 удален с ID: %2",_activatingPlayer,_id];
			}
		else 
			{
				_key = format["CHILD:310:%1:",_uid];
				_key call server_hiveWrite;
				diag_log format["[Сервер]: Удаление: %1 Удален с UID: %2",_activatingPlayer,_uid];
			};
	};