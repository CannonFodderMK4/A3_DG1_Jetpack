#include "script_component.hpp"

//Activate Thrust
[
	["Degenerates Extras","Jetpacks"],
	"DG1_Jetpack_Thrust",
	"Use Jetpack",
	{
		//Switch to Call FNC Down
		if (typeOf unitBackpack player in GVAR(Backpacks) && !(player getVariable ["ACE_isUnconscious", false])) then {
			GVAR(Thrust) = true;
			call FUNC(thrust);
		} else {
			GVAR(Thrust) = false;
			cutText ["", "PLAIN"];
		};
	},
	{
		//Switch to Call FNC Up
		GVAR(Thrust) = false
	}
] call cba_fnc_addKeybind;

//Toggle Thrust
[
	["Degenerates Extras","Jetpacks"],
	"DG1_Jetpack_Thrust_Toggle",
	"Toggle Jetpack",
	{
		if (typeOf unitBackpack player in GVAR(Backpacks) && !(player getVariable ["ACE_isUnconscious", false])) then {
			GVAR(Thrust) = !GVAR(Thrust);
			call FUNC(thrust);
		} else {
			GVAR(Thrust) = false;
			cutText ["", "PLAIN"];
		};
	},
	{}
] call cba_fnc_addKeybind;

//Toggle Airbrakes
[
	["Degenerates Extras","Jetpacks"],
	"DG1_Jetpack_Brake",
	"Emergency Airbrakes",
	{
		if (typeOf unitBackpack player in GVAR(Backpacks) && !(player getVariable ["ACE_isUnconscious", false])) then {
			GVAR(Brake) = !GVAR(Brake);
			call FUNC(brake);
		} else {
			GVAR(Brake) = false;
			call FUNC(brake);
			cutText ["", "PLAIN"];
		};
	},
	{}
] call cba_fnc_addKeybind;