private ["_aObjs","_bldObj"];
_bldObj	=	objNull;
_aObjs	=	[
					["MAP_uaz_wrecked", [4899.1094, 9713.3018, 3.0517578e-005], 8.8413763, false],
					["MAP_t_fagus2W", [4897.5112, 9707.7051, -0.79516613], 1234567890, false],
					["MAP_t_betula2f", [4713.5127, 10206.061], 1234567890, false],
					["MAP_t_betula2f", [4909.1489, 9703.0039, 9.1552734e-005], 1234567890, false],
					["MAP_t_picea1s", [4516.5547, 9964.6191, -6.1035156e-005], 1234567890, false],
					["MAP_t_picea2s", [4515.1069, 9968.3164, -0.00012207031], 1234567890, false],
					["MAP_t_picea2s", [4511.4512, 9971.0332, 9.1552734e-005], 1234567890, false],
					["MAP_t_picea1s", [4512.9326, 9975.6436, 6.1035156e-005], 1234567890, false],
					["MAP_t_picea2s", [4508.2334, 9976.2275], 1234567890, false],
					["MAP_t_picea3f", [4290.4248, 10352.474, -3.0517578e-005], 1234567890, false],
					["MAP_t_picea3f", [4293.4878, 10356.092, 3.0517578e-005], 1234567890, false],
					["MAP_t_picea3f", [4291.3921, 10359.858, -3.0517578e-005], 1234567890, false],
					["MAP_t_picea3f", [4293.7432, 10337.206, 3.0517578e-005], 1234567890, false],
					["MAP_t_picea2s", [4283.2612, 10375.067, 6.1035156e-005], 1234567890, false],
					["MAP_t_picea3f", [4271.1689, 10392.027], 1234567890, false],
					["MAP_t_picea3f", [4297.9121, 10342.161], 1234567890, false],
					["MAP_t_picea3f", [4301.6021, 10332.664, 3.0517578e-005], 1234567890, false],
					["MAP_t_picea2s", [4261.4653, 10390.544, 3.0517578e-005], 1234567890, false],
					["MAP_t_picea1s", [4300.6206, 10330.016, 3.0517578e-005], 1234567890, false],
					["MAP_t_picea3f", [4298.6274, 10326.13, -2.2621694], 1234567890, false],
					["MAP_t_picea1s", [4299.1294, 10321.624, -6.1035156e-005], 1234567890, false],
					["MAP_t_picea1s", [4305.2939, 10333.221, 0.00012207031], 1234567890, false],
					["MAP_t_picea1s", [4382.6421, 10492.962, 3.0517578e-005], 1234567890, false],
					["MAP_t_picea1s", [4382.3496, 10490.436, -3.0517578e-005], 1234567890, false],
					["MAP_t_picea1s", [4371.4819, 10498.944], 1234567890, false],
					["MAP_t_picea2s", [4411.3726, 10584.946], 127.78613, false],
					["MAP_t_picea1s", [4408.0869, 10586.209, 0.00012207031], 1234567890, false],
					["MAP_t_picea1s", [4505.0063, 9979.4746, 3.0517578e-005], 1234567890, false],
					["C130J_wreck_EP1", [4756.5796, 9806.0146, 0.048682272], -4.6038976, false],
					["Mi8Wreck", [4535.832, 10347.728, 9.1552734e-005], 1234567890, false],
					["HeliHCivil", [4840.1382, 10157.658, -6.1035156e-005], 1234567890, false],
					["MAP_t_picea2s", [5063.6436, 9577.3193], 1234567890, false],
					["MAP_t_picea1s", [5069.3262, 9558.2383, 9.1552734e-005], 1234567890, false],
					["MAP_t_picea2s", [5061.0996, 9563.1973, 3.0517578e-005], 1234567890, false],
					["MAP_t_picea1s", [5066.041, 9555.6787, 3.0517578e-005], 1234567890, false],
					["MAP_t_picea1s", [5088.3032, 9557.3232, 6.1035156e-005], 1234567890, false],
					["MAP_t_picea1s", [5089.0093, 9560.0225, 0.00015258789], 1234567890, false],
					["MAP_t_picea1s", [5085.9951, 9555.207, 9.1552734e-005], 1234567890, false],
					["MAP_t_picea1s", [5074.7754, 9537.0244, -3.0517578e-005], 1234567890, false],
					["MAP_t_picea1s", [5030.0942, 9474.0781, -9.1552734e-005], 1234567890, false],
					["MAP_t_picea1s", [5046.3862, 9497.917, 0], 1234567890, false],
					["MAP_t_picea1s", [5046.6484, 9494.9375, -3.0517578e-005], 1234567890, false],
					["MAP_t_picea1s", [5082.0117, 9598.4424, 3.0517578e-005], 1234567890, false],
					["MAP_t_betula2w", [5103.6699, 9579.5967, -0.77613705], 49.531376, false],
					["MAP_t_betula2s", [5101.2949, 9574.75, -3.0517578e-005], 1234567890, false],
					["MAP_t_betula2s", [5018.9014, 9456.8418, -3.0517578e-005], 1234567890, false],
					["MAP_t_betula2s", [5061.9849, 9514.8857], 1234567890, false],
					["MAP_t_betula2w", [5072.6904, 9531.6621, -3.0517578e-005], 1234567890, false],
					["MAP_t_betula2w", [5091.9854, 9565.6543, -0.24476153], 1234567890, false]
				];
{
	_bldObj = createVehicle [(_x select 0), (_x select 1), [], 0, "CAN_COLLIDE"];
	if ((_x select 2) != 1234567890) then
		{_bldObj setDir (_x select 2);};
	if (_x select 3) then
		{_bldObj setVehicleInit "this allowDammage false; this enableSimulation false;";};
	_bldObj setPos (_x select 1);
} forEach _aObjs;