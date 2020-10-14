#include "script_component.hpp"
if (GVAR(Brake)) then {
	if (!(GVAR(Fuel_Recharge)) && GVAR(Fuel_Action) isEqualType 1) then {
		[player,GVAR(Fuel_Action)] call BIS_fnc_holdActionRemove;
	};
	GVAR(Brake_Text) = "\nEmergency Airbrakes Active";
	player spawn {
		private _deceleration = (vectorMagnitude (velocityModelSpace _this)) * 0.25;
		private _vel = (vectorNormalized (velocityModelSpace _this)) vectorMultiply _deceleration;
		private _fuelUse = ((_deceleration / 1.8) * 0.1) * (((getPosVisual _this) select 2)/10);
		while {alive _this && {GVAR(Brake) && {typeOf unitBackpack player in GVAR(Backpacks)}}} do {
			if (GVAR(Fuel) > 0 || {!GVAR(Fuel_Enable)}) then {
				if (((getPosVisual _this) select 2) > 0.1 && !GVAR(Sound_Play)) then {
					call FUNC(sound);
				};
				_deceleration = (vectorMagnitude (velocityModelSpace _this)) * 0.25;
				_vel = (vectorNormalized (velocityModelSpace _this)) vectorMultiply _deceleration;
				_this setVelocityModelSpace ((velocityModelSpace _this) vectorDiff _vel);
				if (GVAR(Fuel_Enable)) then {
					_fuelUse = ((_deceleration / 1.8) * 0.1) * (((getPosVisual _this) select 2)/10);
					if (GVAR(Fuel) > _fuelUse) then {
						GVAR(Fuel) = GVAR(Fuel) - _fuelUse;
					} else {
						GVAR(Fuel) = 0;
					};
				};
				cutRsc ["DG1_Jetpack_RSC_Counter","PLAIN",-1,false];
			};
			uiSleep  0.1;
		};
		if (GVAR(Fuel_Recharge)) then {
			[] spawn {call FUNC(refuelPack);};
		} else {
			call FUNC(fuelStation);
		};
	};
} else {
	GVAR(Brake_Text) = "";
	cutRsc ["DG1_Jetpack_RSC_Counter","PLAIN",-1,false];
;}