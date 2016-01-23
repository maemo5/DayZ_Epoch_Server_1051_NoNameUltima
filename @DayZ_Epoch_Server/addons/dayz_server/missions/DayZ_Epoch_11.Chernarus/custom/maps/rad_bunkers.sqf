private	["_bldObj","_ugol","_coord","_MetalFloor_DZ","_CinderWall_DZ"];
_bldObj 			= objNull;
_MetalFloor_DZ	=
	[
		[359.831,[7580.16,6785.83,0.127]],
		[179.831,[7580.17,6780.58,0.351]],
		[179.832,[7585.41,6785.85,0.135]],
		[179.831,[7580.19,6775.33,0.605]],
		[359.832,[7590.66,6785.86,0.173]],
		[359.832,[7585.42,6780.6,0.364]],
		[359.832,[7590.67,6780.61,0.397]],
		[179.83,[7585.44,6775.35,0.632]],
		[179.832,[7590.69,6775.36,0.672]],
		[269.585,[7591.8,6774.93,0.445]],
		[269.746,[7592.38,6774.91,0.245]],
		[269.854,[7592.9,6774.9,0.016]],
		[270.193,[7593.42,6774.92,-0.175]],
		[180.02,[7590.68,6775.36,4.079]],
		[180.02,[7585.43,6775.36,4.038]],
		[0.02,[7580.18,6775.36,4.011]],
		[180.02,[7580.18,6780.61,3.757]],
		[0.021,[7590.68,6780.61,3.805]],
		[0.02,[7585.43,6780.61,3.771]],
		[0.021,[7590.68,6785.86,3.581]],
		[0.02,[7580.18,6785.86,3.533]],
		[180.021,[7585.43,6785.86,3.541]]
	];
_CinderWall_DZ	=
	[
		[270,[7577.33,6774.86,-0.363]],
		[270,[7577.33,6780.37,-0.627]],
		[270,[7577.34,6785.89,-0.851]],
		[270,[7577.34,6774.86,3.017]],
		[270,[7577.34,6780.37,2.753]],
		[0.098,[7591.13,6788.62,-0.925]],
		[0.098,[7585.62,6788.63,-0.965]],
		[180,[7580.1,6788.64,2.406]],
		[180.098,[7580.1,6788.64,-0.974]],
		[180.098,[7585.62,6788.63,2.415]],
		[180.098,[7591.13,6788.62,2.455]],
		[270,[7577.34,6785.89,2.529]],
		[90,[7593.47,6785.71,-0.804]],
		[90,[7593.47,6785.71,2.576]],
		[90,[7593.47,6780.19,-0.564]],
		[90,[7593.47,6780.19,2.816]]
	];	
if (true) then
	{
		{
			_ugol	=	_x select 0;
			_coord	=	_x select 1;
			_bldObj	= createVehicle ["MetalFloor_DZ", _coord, [], 0, "CAN_COLLIDE"];
			_bldObj setDir _ugol;
			_bldObj setPos _coord;
		}	forEach _MetalFloor_DZ;
		
		{
			_ugol	=	_x select 0;
			_coord	=	_x select 1;
			_bldObj	= createVehicle ["CinderWall_DZ", _coord, [], 0, "CAN_COLLIDE"];
			_bldObj setDir _ugol;
			_bldObj setPos _coord;
		}	forEach _CinderWall_DZ;		
  
  
		_bldObj	= createVehicle ["CinderWallHalf_DZ", [7593.51,6774.69,4.113], [], 0, "CAN_COLLIDE"];
		_bldObj setDir 89.105;
		_bldObj setPos [7593.51,6774.69,4.113];
			
		_bldObj	= createVehicle ["CinderWallDoorSmall_DZ", [7593.51,6774.69,0.733], [], 0, "CAN_COLLIDE"];
		_bldObj setDir 89.105;
		_bldObj setPos [7593.51,6774.69,0.733];
		
		_bldObj = createVehicle ["Land_aif_heavyf", [7587, 6761, 1], [], 0, "CAN_COLLIDE"];
		_bldObj setPos [7587, 6761, 1];
	};
