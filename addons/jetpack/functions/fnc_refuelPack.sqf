#include "script_component.hpp"
private _recharge = true;
if (GVAR(Fuel_Recharge) && !(GVAR(Thrust)) && !(GVAR(Brake)) && (GVAR(Fuel) < GVAR(Fuel_Max))) then {
	for [{_i=0},{_i < GVAR(Fuel_Cooldown)}, {_i = _i + 0.1}] do {
		if (GVAR(Thrust) || GVAR(Brake)) exitWith {_recharge = false};
		uiSleep  0.1;
	};
};
if (_recharge) then {
	while {!(GVAR(Thrust)) && !(GVAR(Brake)) && (GVAR(Fuel) < GVAR(Fuel_Max)) && (GVAR(Refuel) || GVAR(Fuel_Recharge))} do {
		GVAR(Fuel) = GVAR(Fuel) + 1;
		if (GVAR(Fuel) > GVAR(Fuel_Max)) then {
			GVAR(Fuel) = GVAR(Fuel_Max);
		};
		cutRsc ["DG1_Jetpack_RSC_Counter","PLAIN",-1,false];
		uiSleep  0.1;
	};
};