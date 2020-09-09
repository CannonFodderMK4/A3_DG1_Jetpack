#include "script_component.hpp"
private _refuelTime = (GVAR(Fuel_Max) - GVAR(Fuel))/10;
if (GVAR(Fuel_Action) isEqualType 1) then {
	[player,GVAR(Fuel_Action)] call BIS_fnc_holdActionRemove;
};
GVAR(Fuel_Action) = [
	player,
	"Refuel",
	"",
	"",
	"_this == _target && (toUpper (typeOf cursorObject)) in dg1_jetpack_Fuel_Stations && _this distance cursorObject < 3 && !(dg1_jetpack_Thrust) && !(dg1_jetpack_Brake)",
	"_caller distance cursorObject < 3",
	{
		hint "Refueling Jetpack";
		GVAR(Refuel) = true;
		[] spawn {
			call FUNC(refuelPack);
		};
	},
	{},
	{
		hint "Refueling Complete";
		GVAR(Refuel) = false;
		GVAR(Fuel) = GVAR(Fuel_Max);
		cutRsc ["DG1_Jetpack_RSC_Counter","PLAIN",-1,false];
	},
	{
		hint "Refueling interrupted";
		GVAR(Refuel) = false;
		[player,GVAR(Fuel_Action)] call BIS_fnc_holdActionRemove;
		call FUNC(fuelStation);
		cutRsc ["DG1_Jetpack_RSC_Counter","PLAIN",-1,false];
	},
	[],
	_refuelTime,
	10000,
	true,
	false,
	true
] call BIS_fnc_holdActionAdd;