Private ["_player", "_base", "_client", "_uid", "_base_radius", "_base_pos", "_fUID", "_admin_money", "_balance", "_i", "_pos", "_compare", "_days", "_live", "_key"];
_player			=	(_this select 0);
_base			=	(_this select 2);
_client			=	(owner _player);
_uid			=	(getPlayerUID _player);
_base_radius	=	(_base select 0);
_base_pos		=	(_base select 1);
_fUID			=	(_base select 2);
_admin_money	=	[_uid] call Ultima_Get_Admin_Money;
_balance		=	(_admin_money - Ultima_Defense_Friend_Cost);
if ( _balance < 0 ) exitWith
	{
		Terminal_Client = ["error", "Не хватает средств для оплаты услуги!"];
		_client publicVariableClient "Terminal_Client";
	};
diag_log (format["[Ultima]: [Добавление друга базы]: Игрок: %1, База: %2, Радиус базы: %3, Позиция базы: %4, добавлен друг: %5 ", _player, _base, _base_radius, _base_pos, _fUID]);

for "_i" from 0 to (count Ultima_Base_Defense) -1 do
	{
		_pos		=	(((Ultima_Base_Defense select _i) select 2) select 1);
		_compare	=	[_pos, _base_pos] call Ultima_Compare_Position;
		if (_compare) exitWith
			{
				[_player, _uid, _balance] call Ultima_Admin_Money_Set_Balance;
				_days	=	((Ultima_Base_Defense select _i) select 1);
				_live	=	(((Ultima_Base_Defense select _i) select 2) select 2);
				_live set [count _live, _fUID];
				_base	=	[Ultima_Date, _days, [_base_radius, _base_pos, _live]];
				Ultima_Base_Defense set [_i, _base];
				_key	=	"ultima_ini" callExtension format["4|base|%1", _i];
				"ultima_ini" callExtension format["9|base|%1|%2", _key, _base];
				Terminal_Client = ["message", "Идентификатор друга, добавлен!"];
				_client publicVariableClient "Terminal_Client";
				diag_log (format["[Ultima]: [Добавление друга базы]: Изменена запись: %1", (Ultima_Base_Defense select _i)]);
				diag_log (format["[Ultima]: [Добавление друга базы]: _key: %1, _base: %2", _key, _base]);
			};
	};
