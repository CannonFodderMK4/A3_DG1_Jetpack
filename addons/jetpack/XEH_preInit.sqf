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
GVAR(Sound_Play) = false;
GVAR(Spool_Down) = false;


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
	"DG1_Jetpack_Sound_Start",
	"EDITBOX",
	["Jetpack Start Sound Class Name","No quotes, only add one as defined in CfgSounds in your description.ext (or you could use one defined by another mod), no default sound atm. If undefined will not attempt to play"],
	["Degenerates Extras","Jetpacks"],
	"",
	true,
	{
		params ["_value"];
		GVAR(Sound_Start) = _value;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Sound_Start_Length",
	"SLIDER",
	["Jetpack Start Sound length (secs)","Set to length of audio file to allow continuous playback. Sounds longer than 30 secs will overlap."],
	["Degenerates Extras","Jetpacks"],
	[0,30,1,1],
	true,
	{
		params ["_value"];
		GVAR(Sound_Start_Length) = _value;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Sound_Continue",
	"EDITBOX",
	["Jetpack Running Sound Class Name","No quotes, only add one as defined in CfgSounds in your description.ext (or you could use one defined by another mod), no default sound atm. If undefined will not attempt to play, must be defined for Start and Stop to also play"],
	["Degenerates Extras","Jetpacks"],
	"",
	true,
	{
		params ["_value"];
		GVAR(Sound_Continue) = _value;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Sound_Continue_Length",
	"SLIDER",
	["Jetpack Running Sound length (secs)","Set to length of audio file to allow continuous playback. Sounds longer than 30 secs will overlap."],
	["Degenerates Extras","Jetpacks"],
	[0,30,1,1],
	true,
	{
		params ["_value"];
		GVAR(Sound_Continue_Length) = _value;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Sound_End",
	"EDITBOX",
	["Jetpack Stop Sound Class Name","No quotes, only add one as defined in CfgSounds in your description.ext (or you could use one defined by another mod), no default sound atm. If undefined will not attempt to play"],
	["Degenerates Extras","Jetpacks"],
	"",
	true,
	{
		params ["_value"];
		GVAR(Sound_End) = _value;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Sound_End_Length",
	"SLIDER",
	["Jetpack Stop Sound length (secs)","Set to length of audio file to allow continuous playback. Sounds longer than 30 secs will overlap."],
	["Degenerates Extras","Jetpacks"],
	[0,30,1,1],
	true,
	{
		params ["_value"];
		GVAR(Sound_End_Length) = _value;
	}
] call CBA_fnc_addSetting;

[
	"DG1_Jetpack_Spool",
	"SLIDER",
	["[EXPERIMENTAL: Use at own risk] Jetpack Spool up","If this is greater than 0 then the Jetpack will wait until the throttle has been active for this time before generating lift (This does not affect Airbrakes)"],
	["Degenerates Extras","Jetpacks"],
	[0,30,0,1],
	true,
	{
		params ["_value"];
		GVAR(Spool) = _value;
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