player call DG1_fnc_Jetpack_Fuel;
player call DG1_fnc_Jetpack_Thrust;

player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	thrust = false;
	player call DG1_fnc_Jetpack_Fuel;
	player call DG1_fnc_Jetpack_Thrust;
}];