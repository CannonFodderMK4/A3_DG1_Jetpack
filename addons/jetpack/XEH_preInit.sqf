#include "script_component.hpp"

#include "XEH_PREP.sqf"

//Define Variable Defaults
GVAR(Backpacks) = [];
GVAR(Brake_Text) = "";
GVAR(Brake) = false;
GVAR(Fuel_Action) = true;
GVAR(Fuel_Cooldown) = 5;
GVAR(Fuel_Enable) = true;
GVAR(Fuel_Max) = 100;
GVAR(Fuel_Recharge) = true;
GVAR(Fuel_Stations) = [];
GVAR(Fuel_Objects) = [];
GVAR(Fuel) = GVAR(Fuel_Max);
GVAR(Refuel) = false;
GVAR(Thrust) = false;

[
	"DG1_Jetpack_List",
	"EDITBOX",
	["Jetpack Class Names","No quotes, split by comma"],
	["Degenerates Extras","Jetpacks"],
	"",
	true,
	{
		params ["_value"];
		_array = _value splitString ", ";
		GVAR(Backpacks) = _array;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Fuel_Enable",
	"CHECKBOX",
	"Uses Fuel",
	["Degenerates Extras","Jetpacks"],
	true, 
	true,
	{
		params ["_value"];
		GVAR(Fuel_Enable) = _value;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Fuel_Max",
	"SLIDER",
	["Tank Size","Flight time in Seconds"],
	["Degenerates Extras","Jetpacks"],
	[10,1000,100,0],
	true,
	{
		params ["_value" ];
		GVAR(Fuel_Max) = _value;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Fuel_Recharge",
	"CHECKBOX",
	"Recharges when not in use",
	["Degenerates Extras","Jetpacks"],
	true,
	true,
	{
		params ["_value"];
		GVAR(Fuel_Recharge) = _value;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Fuel_Cooldown",
	"SLIDER",
	["Recharge Cooldown","Delay before recharge in Seconds"],
	["Degenerates Extras","Jetpacks"],
	[1,60,5,0],
	true,
	{
		params ["_value" ];
		GVAR(Fuel_Cooldown) = _value;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Fuel_Stations",
	"EDITBOX",
	["Fuel Station Class Names","No quotes, split by comma"],
	["Degenerates Extras","Jetpacks"],
	"",
	true,
	{
		params ["_value"];
		_array = (toUpper _value) splitString ", ";
		GVAR(Fuel_Stations) = _array;
	},
	true
] call CBA_fnc_addSetting;